Return-Path: <linux-pm+bounces-4296-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC2B860246
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 20:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA4E81F265E5
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 19:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A62714B825;
	Thu, 22 Feb 2024 19:07:11 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1838548F1
	for <linux-pm@vger.kernel.org>; Thu, 22 Feb 2024 19:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708628831; cv=none; b=tg/BhMsDmVojzgAYx0h+oHLq30UFZWoyzt7E/PRQX6f3HlkFQvA13PqA+aBvXFoyWHvyaEwlObGW6O6Lv3Trek6pA+JrUkj1YViIK/RsZ/GFcgrvJYmovoQN1zysx9AyYp0rPTIU5BogMtMgGoC+fqIHcaHwMOmDkbzqLfFz2Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708628831; c=relaxed/simple;
	bh=cB2qXfRawhQ0ImXEMhf82WzVWw9qVHBRCHumqTQkgo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MCYAY1kpCIkbJN9K+s5L+nDpDBvChWNyhHxBQOYJmEvpAPZwzOPV+xPDY51IqqvvecmcVRwAKewPSorFB7E0Mem39o53ZHCA5K1ecf+jrlI2kWWSXixvwEISYLErbOcoY3kvjhoCr25MZD2W/MHmZb4VaMk3RdEyhorRpLaTCpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5a0333a9779so35086eaf.0
        for <linux-pm@vger.kernel.org>; Thu, 22 Feb 2024 11:06:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708628809; x=1709233609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gklgZW4oqGYX/xbPlBQ/wXJoAVtaEV/8KzYR+to7xns=;
        b=EHhjfc3cV1ykrCmrEfdHnLG0YhEwsNF7GazRHfBxPxv38mAypeRU9jxnWaZWAjVBdR
         +zkdhFFIZ0WX8vQuaaYsnSRppeiluKOjjldbye/NHS8LIaFy3GdXYD7cMnbvVy1r2wvV
         abbkHjsHoRU4M/ezLk8lFR97F1DY4WhLn45bQVDiU8wmVsaeKbVVO0MNGnx3kEYPjoOv
         G1+o8EhxOC510g6I7cv6dbAoUYlSm9XKmGDcm1Mh4J9Q7LywL+sP7yxU6gqyg/XUY9mE
         Afk+/RbIy5uw4pto3GVPRdZJKxU0hDBinXXKibz9f9ajAXN6L882zzP5QPpw4xW05xIq
         mCRA==
X-Forwarded-Encrypted: i=1; AJvYcCVh6Nf0WPfa9WRxSNAatpNppcnQFDKJZ9ThmGxAR5+kACPD/bO8MWX7FHrikhA5YxzzeynonlIq40UcExblMmdjPxalzUu8KUQ=
X-Gm-Message-State: AOJu0YzVdmSDyxTlfNinpakQAKqvyORvfkNPe5Hjfb0Aio5t5xiFfZUb
	rKx+oKst+5mtEndQoPCaqg8sQFK7nLuu6SfbqLNaEINWlSt2wNITB8733pnkgotDAaHPEqB0CIR
	k7quqxBQJAX57bb5PEyA3jGnn3d8=
X-Google-Smtp-Source: AGHT+IEdkHxO0SJS5bAqcjl1m8uQR+tVMWI58sbnu3DmUX8eAk4P24m9eNimmjoy9dOFIYQk1lEJUzj/UDNW6OSeLuk=
X-Received: by 2002:a05:6820:134d:b0:59f:881f:9318 with SMTP id
 b13-20020a056820134d00b0059f881f9318mr27267002oow.0.1708628809096; Thu, 22
 Feb 2024 11:06:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214001956.3087944-1-samasth.norway.ananda@oracle.com>
In-Reply-To: <20240214001956.3087944-1-samasth.norway.ananda@oracle.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 Feb 2024 20:06:38 +0100
Message-ID: <CAJZ5v0g7iN3nfP+2mYk-Zsa00_LLzeQHo7rYCsgnnMNk4QkjZQ@mail.gmail.com>
Subject: Re: [PATCH ] tools/power x86_energy_perf_policy: Fix file leak in get_pkg_num()
To: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
Cc: lenb@kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 1:20=E2=80=AFAM Samasth Norway Ananda
<samasth.norway.ananda@oracle.com> wrote:
>
> In function get_pkg_num() if fopen_or_die() succeeds it returns a file
> pointer to be used. But fclose() is never called before returning from
> the function.
>
> Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
> ---
> Found this error through static analysis. This has only been compile
> tested.
> ---
>  tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_polic=
y.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
> index 5fd9e594079c..ebda9c366b2b 100644
> --- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
> +++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
> @@ -1241,6 +1241,7 @@ unsigned int get_pkg_num(int cpu)
>         retval =3D fscanf(fp, "%d\n", &pkg);
>         if (retval !=3D 1)
>                 errx(1, "%s: failed to parse", pathname);
> +       fclose(fp);
>         return pkg;
>  }
>
> --

Applied as 6.9 material, thanks!

