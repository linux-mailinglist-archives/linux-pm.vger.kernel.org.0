Return-Path: <linux-pm+bounces-27586-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DABFAC260D
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 17:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 076A47BD446
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 15:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D673B29615B;
	Fri, 23 May 2025 15:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3dWmpa+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD02296157;
	Fri, 23 May 2025 15:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748013039; cv=none; b=tbeUqBQHEGYVYjv1uNaJ5E97ULxqBD9e2hs6sd2u6vfE6NTmV+fU6OOUnOA+e6c6O777DNxkcIAojjWVTSSyOiYtyj6IYBHw/6gedPu4DPwa+OBPfJpHDtEr1rtgq1mD7Uz3njc4vOEb+HCdqnRDHQaKvQCWm7IuBpOVL76z/e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748013039; c=relaxed/simple;
	bh=1ZER5+aBDnuBoSCbc6x2pQIeNK9vhs5kJnMpDiT/9fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DQRQAzeiNFjScrGKw7sgBi4SvwimTEt07UH/P4Hj5iC3TztWhjepYyx9b5KVtKKRvI4ltr7T3eli1dEoJVkdIQAv3YFdyrNv64B1ehivHfIl0dz+uTHRUqZQ6hk1iWKVpXQvydhaFtmkaCK4qPobsH68Nzf2/w3oIpehq10BWs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3dWmpa+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252A0C4AF09;
	Fri, 23 May 2025 15:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748013039;
	bh=1ZER5+aBDnuBoSCbc6x2pQIeNK9vhs5kJnMpDiT/9fs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=R3dWmpa+N6hoP1CvxOlu7roVfC0AUxUOaWgjSz6F494dkA8FOYefcqv5UB1NzwZqI
	 NbukgXJpjvESBL9dVUh6NlIes4velVCUs5su850T1sl52Dmeifsa2c8EBEloJRbdgt
	 zs87hovmw6rFkT2ijz8y+ZnIwVUpbhKQXjPIdSCeu3LhX83OwlUhc1su8/qpqUCXgN
	 K3jVsNwrXv5GK+PzERDd4xLEg1OyrJqkWg8VWBiPKJrbMInRBqTVuwYUONpwhENcoJ
	 2un1sIrEbTflbMxGT55N4D5xeBoVh8FznJ5XCcy0olhkVsGMe4o5/nCuduLOsiARth
	 fenNjjSFxf9Vg==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3fbaa18b810so22716b6e.2;
        Fri, 23 May 2025 08:10:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV2Wqj9E2oQTx5upBLO7tOFraiYeixFKlIBWvmx2z532Wd9TrlJwEcPOgpbvmEgZKNdZmX+xgylB3HrRzA=@vger.kernel.org, AJvYcCWXock+oX5vtrMpGH3H4ffVmpClh53KpIhYnTIVTLswEUAaM8ISAfdnb/xqZPFgm5lwTZ0Ny7ibYEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YynjSOEzWk1Ef9aI+ZrTWXaqIVFVdZOvZctGsnqW3WybygbJUWM
	HZvu84qBmUrcvaaeGJpzpofI8YNQulNjZ5TZmpBcYTxR84HXmt78Rd2iXxpR06pHX+h+6i9r1+1
	Z3QyeYPzYK5ISnx/4MJPXEl5/ViJHPl8=
X-Google-Smtp-Source: AGHT+IGxAsxnD6gRCOZG/OvzSCsWfF12hBV27JMmE4jSskt0tjlXticiu9aTvNs0YstL5t0Yzc58hit/7oCtAlCQmNE=
X-Received: by 2002:a05:6808:2f0d:b0:403:31a4:f406 with SMTP id
 5614622812f47-404da735919mr19019904b6e.10.1748013038448; Fri, 23 May 2025
 08:10:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250516084011.29309-1-tuhaowen@uniontech.com> <20250523085645.17695-1-tuhaowen@uniontech.com>
In-Reply-To: <20250523085645.17695-1-tuhaowen@uniontech.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 23 May 2025 17:10:27 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jazfh7A8-6werFtsQ=XOYzDioYh19p4S4v=0to2Na4Hw@mail.gmail.com>
X-Gm-Features: AX0GCFvuvqReknQ5QffB20GDXZFmKM5klmigewjIpnkzgVP6BJSMJXA1EGYV_H8
Message-ID: <CAJZ5v0jazfh7A8-6werFtsQ=XOYzDioYh19p4S4v=0to2Na4Hw@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] PM/console: Fix the black screen issue
To: tuhaowen <tuhaowen@uniontech.com>
Cc: pavel@kernel.org, len.brown@intel.com, rafael@kernel.org, 
	huangbibo@uniontech.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, wangyuli@uniontech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 10:57=E2=80=AFAM tuhaowen <tuhaowen@uniontech.com> =
wrote:
>
> When the computer enters sleep status without a monitor
> connected, the system switches the console to the virtual
> terminal tty63(SUSPEND_CONSOLE).
>
> If a monitor is subsequently connected before waking up,
> the system skips the required VT restoration process
> during wake-up, leaving the console on tty63 instead of
> switching back to tty1.
>
> To fix this issue, a global flag vt_switch_done is introduced
> to record whether the system has successfully switched to
> the suspend console via vt_move_to_console() during suspend.
>
> If the switch was completed, vt_switch_done is set to 1.
> Later during resume, this flag is checked to ensure that
> the original console is restored properly by calling
> vt_move_to_console(orig_fgconsole, 0).
>
> This prevents scenarios where the resume logic skips console
> restoration due to incorrect detection of the console state,
> especially when a monitor is reconnected before waking up.
>
> Signed-off-by: tuhaowen <tuhaowen@uniontech.com>
> ---
> Changes in v2:
> - Added explanation in the commit message on how the issue is fixed.
> - Link to v1: https://lore.kernel.org/all/20250516034643.22355-1-tuhaowen=
@uniontech.com
> ---
>  kernel/power/console.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/power/console.c b/kernel/power/console.c
> index fcdf0e14a47d..832e04bf5439 100644
> --- a/kernel/power/console.c
> +++ b/kernel/power/console.c
> @@ -16,6 +16,7 @@
>  #define SUSPEND_CONSOLE        (MAX_NR_CONSOLES-1)
>
>  static int orig_fgconsole, orig_kmsg;
> +static int vt_switch_done;

Better use bool for this.

Thanks!

>
>  static DEFINE_MUTEX(vt_switch_mutex);
>
> @@ -136,15 +137,19 @@ void pm_prepare_console(void)
>         if (orig_fgconsole < 0)
>                 return;
>
> +       vt_switch_done =3D 1;
> +
>         orig_kmsg =3D vt_kmsg_redirect(SUSPEND_CONSOLE);
>         return;
>  }
>
>  void pm_restore_console(void)
>  {
> -       if (!pm_vt_switch())
> +       if (!pm_vt_switch() && !vt_switch_done)
>                 return;
>
> +       vt_switch_done =3D 0;
> +
>         if (orig_fgconsole >=3D 0) {
>                 vt_move_to_console(orig_fgconsole, 0);
>                 vt_kmsg_redirect(orig_kmsg);
> --
> 2.20.1
>

