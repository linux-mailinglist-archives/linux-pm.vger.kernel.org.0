Return-Path: <linux-pm+bounces-17472-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE6D9C6B22
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 10:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1731281526
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 09:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504321BD9D1;
	Wed, 13 Nov 2024 09:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9LQZK4o"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E341AA792;
	Wed, 13 Nov 2024 09:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731488714; cv=none; b=t28muTYyAwfrHZWaw8vwZd8mSBVSGhNR7ChafF0SQKrws6G0ggUg1jgkYymfa+au0VzuCP3IxTNPHUVD0j6XO3TShFJd0ti5GEMoxzQYjWOPWHJ4cYeQI4X8CFFp62hsayzNoJ6oLe6XINRzcInJlKMr/TTH1+GV39slX2TqwQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731488714; c=relaxed/simple;
	bh=W00M0mj4cJIl+1Ton9OydQMdPhzyCEMv2h5lPx7LI00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JkIZkITMxWUPuKaThlKBvdY0t6eO9LvKzFX8w9vo1Kor8w1ZPUtZ4ot8YFnOpWx4Lt1dl+HKwgTUPPIZP48eqTM/gG+xG6GqYLaCMGCPy58Enrx/bEmuj2r9BRhBp4gub7f1x13uuUoO0Q0gndSlYIJnbLKV0ov9O+VZZsKb0Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9LQZK4o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F2F1C4CED8;
	Wed, 13 Nov 2024 09:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731488713;
	bh=W00M0mj4cJIl+1Ton9OydQMdPhzyCEMv2h5lPx7LI00=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=R9LQZK4ooTpWKWy4Us6NBb6veiQsS6Aq9mCWAFmAHrxlv0ktP+mofhnJCSZ/fA4FG
	 07FF7puRZ/WzI3h8T8gyDbG93hrsptuiIrSyIfvqRDg+W3eZDkan5UTffEligh4SW7
	 yeitrybX6sSJOWKxMH07EgQupF88mB3ZWwszySDZQo9lvpvsQNqlUCGQV+QhN6DkOO
	 trIEmsPT6T8cWD0xkBWPobEjZB/FZEhVmBCeUqCUWCerkociHygK36/PFJt0m8vrJ+
	 gMHDB93ANEyNydVKPxO68qqwJ0lKlB/pk2C/1ODqHovDrcjNdDPix3yr/dgUGF7NFt
	 o2+3GZZmR844Q==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5ee3e12b191so2715363eaf.0;
        Wed, 13 Nov 2024 01:05:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWWPZHKptkQQWx/D5G+yLgC99M9iMcjKK+f3P1Tji9qe2CTAGlBxxe9N47Iq/uhSCmuOy0u5NvO@vger.kernel.org, AJvYcCWhp4f9+WLCefqEwjkav9O1v1NPZoQy67HJlJGS1H+GdpbRm9jb0dnPFKU64UsDod+W+UK5fA9Obv8=@vger.kernel.org, AJvYcCWsEhdmQZOpDkk6wbT9MXOPSBVYR644fLO2paC/iJTnsjYs4XeA2Et6qSyOEwy+d0mXlJRVY+xUhgeC4fA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk6poIN8sVG2C94IikF6lOhpmpCmbX8qKwXSoXYZS2fxjQO3y0
	+x8ku+xas5L8DtL+j5KZJLNoNtvut8GOQTBntP2MdZDyzRWVTkxyJK23+sLBGnxCFRX/0cTCanV
	70rC418QVRmCBv+kD2jfUWE/b0A8=
X-Google-Smtp-Source: AGHT+IHlr7mJZgg0FFV+zNCbZW3MEXnJeIs0/hgP3cdKe8S9pjQ6lzqSiKGj5MiEPQ3PK2Ayi3T92S192wFQCOjV+Jo=
X-Received: by 2002:a05:6870:34e:b0:287:0:9ecc with SMTP id
 586e51a60fabf-2956036be18mr15912074fac.33.1731488712678; Wed, 13 Nov 2024
 01:05:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a4aa8842a3c3bfdb7fe9807710eef159cbf0e705.1731463305.git.len.brown@intel.com>
In-Reply-To: <a4aa8842a3c3bfdb7fe9807710eef159cbf0e705.1731463305.git.len.brown@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 13 Nov 2024 10:05:01 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h5TfKkdbvhnPoM9fmBOMr+gCOzy-_zNdCGX=McF+Awqg@mail.gmail.com>
Message-ID: <CAJZ5v0h5TfKkdbvhnPoM9fmBOMr+gCOzy-_zNdCGX=McF+Awqg@mail.gmail.com>
Subject: Re: [PATCH v3] x86/cpu: Add INTEL_LUNARLAKE_M to X86_BUG_MONITOR
To: Len Brown <lenb@kernel.org>
Cc: peterz@infradead.org, tglx@linutronix.de, x86@kernel.org, 
	rafael@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Len Brown <len.brown@intel.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 3:07=E2=80=AFAM Len Brown <lenb@kernel.org> wrote:
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

Still

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> v3 syntax tweak
> v2 leave smp_kick_mwait_play_dead() alone
>
>  arch/x86/kernel/cpu/intel.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index e7656cbef68d..4b5f3d052151 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -586,7 +586,9 @@ static void init_intel(struct cpuinfo_x86 *c)
>              c->x86_vfm =3D=3D INTEL_WESTMERE_EX))
>                 set_cpu_bug(c, X86_BUG_CLFLUSH_MONITOR);
>
> -       if (boot_cpu_has(X86_FEATURE_MWAIT) && c->x86_vfm =3D=3D INTEL_AT=
OM_GOLDMONT)
> +       if (boot_cpu_has(X86_FEATURE_MWAIT) &&
> +           (c->x86_vfm =3D=3D INTEL_ATOM_GOLDMONT ||
> +            c->x86_vfm =3D=3D INTEL_LUNARLAKE_M))
>                 set_cpu_bug(c, X86_BUG_MONITOR);
>
>  #ifdef CONFIG_X86_64
> --
> 2.43.0
>

