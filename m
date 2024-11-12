Return-Path: <linux-pm+bounces-17399-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B759C571B
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 12:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 180FFB396D7
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 11:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B541B1BC099;
	Tue, 12 Nov 2024 11:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="en/EoVJG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8461B1AFB35;
	Tue, 12 Nov 2024 11:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731411884; cv=none; b=Q9qgDGxXmp1vyx9TMcT0QuEFTtZgVmUc7zIVXc+1mZBQx5i+iQOZIwuDEgZ0f51P6MdsaHfZn+FbPLP32j+uiFBuPD/+Tq5Xp7SDG+b2KmiNOvdHU04HzjM86cclwlPeoxLYqJlPjec+DwiIuwpWJzzjuEPYwlSTdFPRJ0uiS5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731411884; c=relaxed/simple;
	bh=HBGmd7LnHZIxSyRepcDAui8bwvx6IpwO6m4FZ6iG2uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A1gj1k+AV1HyZ9LXwCW2ofQxYE0ofxXspuE3K8AaUsIAYqfgViejm2N0nQoYQL5h8pe5gqMIr0XZteO90kNZdnmLtFQjIl0J+8RvJwm64bGNvKz2zEBzlrZSusTwJJC4ehMoVXMwbzKQ24BZiIcBESJK8doeFqBctmOolZ2bI+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=en/EoVJG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23E5C4CED6;
	Tue, 12 Nov 2024 11:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731411883;
	bh=HBGmd7LnHZIxSyRepcDAui8bwvx6IpwO6m4FZ6iG2uc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=en/EoVJGtxE/JmGWj/z+UEHRFXJf5ZmJnVRF6367gtmPvaTzHzKjobiz+VxME5tc3
	 Nn7mO3MeFiiG1K76L/TsBRHjWPuAq16Se62Ui9ekgR1eLpFwaaqgEKMW6jhWXtQipB
	 sBXKjD/BD8UU0W79Plxbw92ZuEQ0bkDb+9yDzY6qZDrkQqaI1xxog22gc0JvORA+K+
	 JYJ7PNIoxsThXJUyRyrMbNgHWyRyiH3gh6YsE8d9RljKqTPAWAWQQXDvI64vUV4QsJ
	 wgc3WbDgtlhkpM3wTOsgYmuRZTLHDFPyNkEabKDlGpbgCbQRAbVeWaggE1T9Vr7sNJ
	 KMjNL8vMjMVzw==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5ebc27fdc30so2740125eaf.2;
        Tue, 12 Nov 2024 03:44:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUGXCo4BjkaBJG6F1UapRJX69eUbVttYrHZSL5oKa3SifSk1CDra3d3y3YBr5CWPwUtAryIDrmi@vger.kernel.org, AJvYcCUzP9byHqI6lNVHyTxlxaweEpPOAimCHtSphfU3xMIxAaviat5Ymy/JgbO8oILoa5LmmEYRrJeX9kw=@vger.kernel.org, AJvYcCVCx/YkQq3Xm/bQkGXuu6afxp4ONhZR4oXeQSlSRkCiplB/FI10y8axZZxnmYqNJP8FaIjLj72RAcLCvlc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Zf2nv3V0G2n6oEaJYhLXvex6KUbuX9eX+CZ1FNAjNiwBa378
	vIOnlpEaGmJvTaaUA7dWVOz7jxq7GAWuBezuEvuXHMTtfHlvnqe3EX302tm+n9M0SKP9lUp3y9n
	YnwGGJdO1DDDUapxCFp3S2J6zqX4=
X-Google-Smtp-Source: AGHT+IHEnNMF4ElCmn3oKj+4IzNKQ36nGCs61M4QPp9bDjMbO5EIPJrMfsrdGOSy3nYtlqKj3LwzZO5tLssIhs9m2BI=
X-Received: by 2002:a05:6820:2910:b0:5ed:fc18:910f with SMTP id
 006d021491bc7-5ee57c4092fmr10724745eaf.3.1731411883196; Tue, 12 Nov 2024
 03:44:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111162316.GH22801@noisy.programming.kicks-ass.net>
 <20241112053722.356303-1-lenb@kernel.org> <351549432f8d766842dec74ccab443077ea0af91.1731389117.git.len.brown@intel.com>
In-Reply-To: <351549432f8d766842dec74ccab443077ea0af91.1731389117.git.len.brown@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 Nov 2024 12:44:30 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j1gvwoYS-YaOQWh0bQ3x5=54npiYj8erq68dM92+ad-g@mail.gmail.com>
Message-ID: <CAJZ5v0j1gvwoYS-YaOQWh0bQ3x5=54npiYj8erq68dM92+ad-g@mail.gmail.com>
Subject: Re: [PATCH 1/1] x86/cpu: Add INTEL_LUNARLAKE_M to X86_BUG_MONITOR
To: Len Brown <lenb@kernel.org>
Cc: peterz@infradead.org, tglx@linutronix.de, x86@kernel.org, 
	rafael@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Len Brown <len.brown@intel.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 6:37=E2=80=AFAM Len Brown <lenb@kernel.org> wrote:
>
> From: Len Brown <len.brown@intel.com>
>
> Under some conditions, MONITOR wakeups on Lunar Lake processors
> can be lost, resulting in significant user-visible delays.
>
> Add LunarLake to X86_BUG_MONITOR so that wake_up_idle_cpu()
> always sends an IPI, avoiding this potential delay.
>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219364
>
> Cc: stable@vger.kernel.org # 6.11
> Signed-off-by: Len Brown <len.brown@intel.com>

So again

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

and see one super-minor nit below.

> ---
>  arch/x86/kernel/cpu/intel.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index e7656cbef68d..284cd561499c 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -586,7 +586,9 @@ static void init_intel(struct cpuinfo_x86 *c)
>              c->x86_vfm =3D=3D INTEL_WESTMERE_EX))
>                 set_cpu_bug(c, X86_BUG_CLFLUSH_MONITOR);
>
> -       if (boot_cpu_has(X86_FEATURE_MWAIT) && c->x86_vfm =3D=3D INTEL_AT=
OM_GOLDMONT)
> +       if (boot_cpu_has(X86_FEATURE_MWAIT) &&
> +           (c->x86_vfm =3D=3D INTEL_ATOM_GOLDMONT
> +            || c->x86_vfm =3D=3D INTEL_LUNARLAKE_M))

I would put the || at the end of the previous line, that is

> +           (c->x86_vfm =3D=3D INTEL_ATOM_GOLDMONT ||
> +            c->x86_vfm =3D=3D INTEL_LUNARLAKE_M))

>                 set_cpu_bug(c, X86_BUG_MONITOR);
>
>  #ifdef CONFIG_X86_64
> --
> 2.43.0
>

