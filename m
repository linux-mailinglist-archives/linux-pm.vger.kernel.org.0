Return-Path: <linux-pm+bounces-38650-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BDCC86BE1
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 20:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 069704E1B96
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 19:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCCF329C5B;
	Tue, 25 Nov 2025 19:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZyjQYXF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371DF224AF2
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 19:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764097971; cv=none; b=WSuuIqFkZu8CRWfFlklTZkG8LIQh5kuyYxDutzl73Papt+ALEA6isCDWigrUkviKSdtXV6FeZB1SIqOZQBaKhN+eEylN2vrtw9TvdmBiad9AhKBQOHUFCfKvcUb51uE55yMyXWv1XKNtMYqIOtQDghjFu1B0JJ1ae8dzG4GAwlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764097971; c=relaxed/simple;
	bh=wuqfj+QpTBNKpn1tFJ9yxbXd3bm1JMeJXIeg9uTE62A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eNVKtGHRoswTrSvcyi8fqU0BFJBKOnI9ehZDbu7kgE/xQubI7qIMo3J/pRmRPd/AckKFJT6/4GD9tzCMW8m98hIOLBtI4TLvIoZZpKRUl24GGO5xFoVu5rsQW67siHxENWgk8dWWDPcZWL3Ltc/kxxtzISNag8EDYcs0nkS4Rro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZyjQYXF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC6DC16AAE
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 19:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764097970;
	bh=wuqfj+QpTBNKpn1tFJ9yxbXd3bm1JMeJXIeg9uTE62A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JZyjQYXFbqFdIIUcYreKMYuvJjDP/hQF+3qjWx5xYFtFIlYa1m1PSMQGWTXtvNmW8
	 RSp9+nQKramceBxyteZ6hQPG0uwWm8p9KU3tgGxgVHvDMOc8a6mgEvivUdI/jtvaFa
	 6T/ypxFu8lAI2h4GOrg8e+yh/5GrqXKJiOgdmKYULSmDkDEBiQRg8i4AacjCJrqKE/
	 78J720lo1Xi/UzxGeInJWeAC+2VVLdjNV8loKk+jQbiSwONnYEICv7uCZdIBsxaJ4o
	 bc35Cujnt8w5TA6sf0+jiW26sOKzeXau1ofVEQzF37AaU0HJfGhwX8pBCT1X9n/xJX
	 Seww4X49HMlKA==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-3ebd1b07919so1342813fac.0
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 11:12:50 -0800 (PST)
X-Gm-Message-State: AOJu0YxlOLb1EZstdolFhGM38ptvlzStXCrui+04yEXBiSF2Qn7CiqCy
	khYkRcBcfojgz1RWK0S698hRXkx0reNdZzxMQ9VIm2a98zWvm9tL/ibocXYA/2aue9l6to3AjZm
	8dL5tNOO77jGVUUnIdFt8A7DqZKQrE+w=
X-Google-Smtp-Source: AGHT+IEP8anlcDWFcVHFQu1/c8ePe6czH2ltUbjI4mBrjABSI76YjsdKPN9cCZUb/LW73kBpNmECuZQ7kpNgJ9F6ylY=
X-Received: by 2002:a05:6808:3208:b0:44f:e954:ba44 with SMTP id
 5614622812f47-451159828c9mr5674240b6e.28.1764097970278; Tue, 25 Nov 2025
 11:12:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118155813.533424-1-darcari@redhat.com> <20251118155813.533424-3-darcari@redhat.com>
In-Reply-To: <20251118155813.533424-3-darcari@redhat.com>
From: Len Brown <lenb@kernel.org>
Date: Tue, 25 Nov 2025 14:12:38 -0500
X-Gmail-Original-Message-ID: <CAJvTdK=tw76+79sCAa3TbVQwDdv9EGCWVrFvFbHihtH3jNcDWw@mail.gmail.com>
X-Gm-Features: AWmQ_bmYICOj8TkvMD-WkxNXPj96HHQYUXRYdiw9Z5D6l9xbl0m91rmRQCsOUno
Message-ID: <CAJvTdK=tw76+79sCAa3TbVQwDdv9EGCWVrFvFbHihtH3jNcDWw@mail.gmail.com>
Subject: Re: [PATCH 2/3] tools/power turbostat: avoid an infinite loop of restarts
To: David Arcari <darcari@redhat.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

this patch introduces a limit of 10-restarts per turbostat lifetime,
down from infinity.

some turbostat invocations span multiple uses of cpu online/offline --
so this limit will not fly.

On Tue, Nov 18, 2025 at 10:58=E2=80=AFAM David Arcari <darcari@redhat.com> =
wrote:
>
> There are some error cases where turbostat will attempt to reinitialize
> by calling the re_initialize() function.  The code attempts to avoid
> an infinite loop by checking the value of 'restarted' in one case, but
> not others. It should be checked in all cases of restart.  Additonally,
> the 'restarted' is reset to zero at the start of the loop which also
> needs to be removed.
>
> Signed-off-by: David Arcari <darcari@redhat.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> ---
>  tools/power/x86/turbostat/turbostat.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turb=
ostat/turbostat.c
> index 584b0f7f9067..5567b9ecd516 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -6722,7 +6722,11 @@ void turbostat_loop()
>         set_my_sched_priority(-20);
>
>  restart:
> -       restarted++;
> +       if (restarted++ > 10) {
> +               if (!retval)
> +                       retval =3D -1;
> +               exit(retval);
> +       }
>
>         snapshot_proc_sysfs_files();
>         retval =3D for_all_cpus(get_counters, EVEN_COUNTERS);
> @@ -6730,13 +6734,9 @@ void turbostat_loop()
>         if (retval < -1) {
>                 exit(retval);
>         } else if (retval =3D=3D -1) {
> -               if (restarted > 10) {
> -                       exit(retval);
> -               }
>                 re_initialize();
>                 goto restart;
>         }
> -       restarted =3D 0;
>         done_iters =3D 0;
>         gettimeofday(&tv_even, (struct timezone *)NULL);
>
> --
> 2.51.0
>
>


--=20
Len Brown, Intel Open Source Technology Center

