Return-Path: <linux-pm+bounces-38649-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 865CDC86BDB
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 20:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 457B63B03C0
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 19:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01967329C5B;
	Tue, 25 Nov 2025 19:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5md2b/f"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00BA28D8D9
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 19:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764097891; cv=none; b=XmXGZf6+LkaH+Se9YnP98S++mHOA/0Zgu08Ozvvo8tBrNEF0ZsReyWH/+djs/cjfvNU/g87lqCzGBmP7PnOWF49rnrjCHjhYKcyf3r24aIAmyxySfNtjYpgY6oWTCGLSCIqFeosCcPYekrTNT2Bck+d642c7I8WrNq9IKCqs7GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764097891; c=relaxed/simple;
	bh=yh6DsMIU4V7h8gcLt40p18skHHG4ywP10iWGVf8lDSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FUHNpXB+xfZWXHc49eQk26p3FmI5w8fkzSoxJl6A3/efITUKcKQfdbdlYkgF/RuseanRBWQgSGsjchVuTQmDxTSbmTIyXepeJll1MJBENsODGrbdkooTHv7Oa0hi4ST8zLVq1fJ6/JrA6gvKj4eHOd+updOBDNKxiuMWRXgtaT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5md2b/f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64059C116B1
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 19:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764097891;
	bh=yh6DsMIU4V7h8gcLt40p18skHHG4ywP10iWGVf8lDSM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=g5md2b/fYtkUi8QljYTUqaOPGwwIdU7q/urkikI9/e617Ff9i/0z+/ZjD6ZlKALOW
	 J1S6FpEFTN/F8uxqS6FKPAbKNpWM0hopD1uCen2XtyWRF1sl2BRNjoKzkZLd32YZx7
	 ji0kpDI3ePeR9zL03G8qzUaV3/69TgH9W0nk/2P1CxeApwsCaEHjT519DrM+/Kelbt
	 rv6BxfW8QFOSJYkMomTBW2G6BxAAXgBDpUCK4tlaw4sxMon6OMZk51IZG5l7DGOy8H
	 YxpKR8N5B1VBWpGNk2QTNFk62piEzf8NMpaAGBRzWpMPu5xU0UpgtIpUyBoLR0MRuB
	 4K0IaCvVgrItA==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-30cce892b7dso2329776fac.1
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 11:11:31 -0800 (PST)
X-Gm-Message-State: AOJu0YyzGREmwZoxSXEpJJSpJz0F6P2ysbbZ5g5RRWhReEVGU+U1/BHi
	TMHRJLd0Wxqm3hujuc1MEUG9PkEEjF6TkXbIe9fw1kL2U27r6uOb6C3u/Gdt6/KfHN0nkI80sbM
	WPEtBf64w6PfXCuJCVzVF1aj+g2YY8QE=
X-Google-Smtp-Source: AGHT+IGoa18Y9gBynTrWR9G/nxBCBbdpnbGX94cGhDii5CH6/X/qmwiB6B7SH5pHewr5FP989rMoXX3WvJ2aew2StyE=
X-Received: by 2002:a05:6808:1a18:b0:450:d056:e0f0 with SMTP id
 5614622812f47-451158657cfmr6914328b6e.2.1764097890773; Tue, 25 Nov 2025
 11:11:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118155813.533424-1-darcari@redhat.com> <20251118155813.533424-2-darcari@redhat.com>
In-Reply-To: <20251118155813.533424-2-darcari@redhat.com>
From: Len Brown <lenb@kernel.org>
Date: Tue, 25 Nov 2025 14:11:19 -0500
X-Gmail-Original-Message-ID: <CAJvTdK=wpC85at_oshwAhdKtU32QLnHx8MyB7QVtRVRZ=303CQ@mail.gmail.com>
X-Gm-Features: AWmQ_bkGWJjZuF4RRRwNqyTafTTXQiZg7JwZNJOrc_eBxr6TOiYod647ceT4xII
Message-ID: <CAJvTdK=wpC85at_oshwAhdKtU32QLnHx8MyB7QVtRVRZ=303CQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] tools/power turbostat: avoid segfault referencing fd_instr_count_percpu
To: David Arcari <darcari@redhat.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

not your fault, but looking at this code, it seems that
get_instr_count_fd(base_cpu)
assumes that 0 is an invalid FD.  Fine, but based on that you'd think
we'd use zero for invalid
and non-zero for valid as return for the function call...

On Tue, Nov 18, 2025 at 10:58=E2=80=AFAM David Arcari <darcari@redhat.com> =
wrote:
>
> The problem is that fd_instr_count_percpu is allocated based on
> the value of has_aperf. If has_aperf=3D0 then fd_instr_count_percpu
> remains NULL. However, get_instr_count_fd() is called from
> turbostat_init() based on the value of has_aperf_access.
>
> On some VM systems has_aperf can be 0, while has_aperf_access can be
> 1.  In order to resolve the issue simply check for to see if
> fd_instr_count_percpu is NULL and return -1 if it is.  Accordingly,
> the has_aperf_access check can be removed from turbostat_init.
>
> Signed-off-by: David Arcari <darcari@redhat.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> ---
>  tools/power/x86/turbostat/turbostat.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turb=
ostat/turbostat.c
> index f2512d78bcbd..584b0f7f9067 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -2463,6 +2463,9 @@ static long open_perf_counter(int cpu, unsigned int=
 type, unsigned int config, i
>
>  int get_instr_count_fd(int cpu)
>  {
> +       if (!fd_instr_count_percpu)
> +               return -1;
> +
>         if (fd_instr_count_percpu[cpu])
>                 return fd_instr_count_percpu[cpu];
>
> @@ -10027,7 +10030,7 @@ void turbostat_init()
>         for_all_cpus(get_cpu_type, ODD_COUNTERS);
>         for_all_cpus(get_cpu_type, EVEN_COUNTERS);
>
> -       if (BIC_IS_ENABLED(BIC_IPC) && has_aperf_access && get_instr_coun=
t_fd(base_cpu) !=3D -1)
> +       if (BIC_IS_ENABLED(BIC_IPC) && get_instr_count_fd(base_cpu) !=3D =
-1)
>                 BIC_PRESENT(BIC_IPC);
>
>         /*
> --
> 2.51.0
>
>


--=20
Len Brown, Intel Open Source Technology Center

