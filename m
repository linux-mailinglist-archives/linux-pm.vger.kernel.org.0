Return-Path: <linux-pm+bounces-31221-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1551DB0C867
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 18:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 848D87AEA8F
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 16:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D852DF3F8;
	Mon, 21 Jul 2025 16:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tb48J74H"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EC2218AD4;
	Mon, 21 Jul 2025 16:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753113878; cv=none; b=JN93t6tD1HyCVcLpxAew1GuGJUvyTF/czXb/vHyfhJFXlwOyB4BDyepV92AcD8JxvTVBV6DlU88PSVVlMFH9WU9yFzSSVcfICODRB790DQ0/Ipp7nUDKrsb3IaLKYDXLqEg+7uVuAXlBtHNZbF/RlKdP6RRUzPO/flhXG6fC4ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753113878; c=relaxed/simple;
	bh=3fXtOBirZFhzz6wQYUzffNMAfSLr+ou8gT9PHBFIduU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nWRPx6K850qu4k67yQHKQHzPufL+9vgmS/CnvB2f31b7n/1smGKS2+2IkBw2oHhp3usBZ6XwP3j+BSkrthd4FedWw2bZVRg6i7HfnWrc7wuAr9YlrGB5zJVOI2PxwJmZwzrHVtszOV5DVind2JIpGcR+sIuDNGHls4VhcLBlAHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tb48J74H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E3FC4CEED;
	Mon, 21 Jul 2025 16:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753113875;
	bh=3fXtOBirZFhzz6wQYUzffNMAfSLr+ou8gT9PHBFIduU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Tb48J74Hm888pLaIm8BZqtQc3KV35gwq8oH1dYWZOb85tMU9kxiNAeivcMraEPViV
	 LXtvaa/2tQFOXoRh+eQu5fRuTkW/sUOhZJqzHtfrK1nfUyzpr7em+d3yZAFbsrpfUf
	 RSXbLX6vOzSBbv2bwnT5V3ePDuzwXG0+gJB1lPabwCVTiaMPYtwvRBF59gu9smfdWH
	 ilKCpNVrp+pu3HbaPFrM6XFyOD7bY8G2nLSuCLOLvfPehpFDTB3wZ4AML2M3pSVg2Y
	 ykTkzCMEQELlXyyL8fF1e83fAVrbYmKCTjh4V08Zvs2ANiqywxA32U8kCHBVlsmLKF
	 zgRH74dQosF9A==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-615a256240bso2217442eaf.3;
        Mon, 21 Jul 2025 09:04:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVsGiLoazCPymHolWXKYQl40hNPhcl2+gAhNqtQZkwX5fCKoG9r83IHfWVXjbUixLSpuUIj0jUBi3M=@vger.kernel.org, AJvYcCXwXQMQAq2pxPNftR54uDj9Gncs8YERk19gTM6Og73UN+Cds3YWlq4INnrmzVyeNh7d6440UtSX7u6N9/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeSEBSCljQr9iIKE3Re562op4FRabr/JuHUs221y4i/+ANqgck
	bmLazCJNNvNhxtYKMVCfEmvX6ty9l4AB/6CCMRaGFIOciD4XpH3aKjoZCD7XKuOe2dyNDGc8DRK
	Y1gHKYQrgTWPSh51vns9xHJjkwwP7940=
X-Google-Smtp-Source: AGHT+IHOnexltxUDSrZb8nSmvec7gRKeOPZadJJGGkhtS6XE+1FpFHLOqlwsu3p5m/ISuUEDcsq0Ssn5YbwgOgwBT58=
X-Received: by 2002:a05:6808:1509:b0:40a:fb27:9e8d with SMTP id
 5614622812f47-41e451fc131mr10549189b6e.15.1753113874817; Mon, 21 Jul 2025
 09:04:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716123323.65441-1-ulf.hansson@linaro.org> <20250716123323.65441-4-ulf.hansson@linaro.org>
In-Reply-To: <20250716123323.65441-4-ulf.hansson@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 21 Jul 2025 18:04:22 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i0h1RZxr47AVdLsNp6xq1dbKE4xTw6AmEGOr+NPAqD0w@mail.gmail.com>
X-Gm-Features: Ac12FXzYHD7Ack55p_cSLMSgv53_-oN31zExvtLgIArXK4ZetKAR3FLJccwSH_k
Message-ID: <CAJZ5v0i0h1RZxr47AVdLsNp6xq1dbKE4xTw6AmEGOr+NPAqD0w@mail.gmail.com>
Subject: Re: [RFC/PATCH 3/3] cpuidle: Respect the system-wakeup QoS limit for s2idle
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Kevin Hilman <khilman@baylibre.com>, Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Saravana Kannan <saravanak@google.com>, 
	Maulik Shah <quic_mkshah@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 2:33=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> A system-wakeup QoS limit may have been requested by user-space. To avoid
> entering a too deep state during s2idle, let's start to take into account
> the QoS limit when selecting a suitable low-power-state.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/cpuidle/cpuidle.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 0835da449db8..5f6dacb5b134 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -190,14 +190,15 @@ static noinstr void enter_s2idle_proper(struct cpui=
dle_driver *drv,
>   */
>  int cpuidle_enter_s2idle(struct cpuidle_driver *drv, struct cpuidle_devi=
ce *dev)
>  {
> +       u64 constraint_ns =3D system_wakeup_latency_qos_limit() * NSEC_PE=
R_USEC;
>         int index;
>
>         /*
> -        * Find the deepest state with ->enter_s2idle present, which guar=
antees
> -        * that interrupts won't be enabled when it exits and allows the =
tick to
> -        * be frozen safely.
> +        * Find the deepest state with ->enter_s2idle present that meets =
the
> +        * system-wakeup QoS limit, which guarantees that interrupts won'=
t be
> +        * enabled when it exits and allows the tick to be frozen safely.
>          */
> -       index =3D find_deepest_state(drv, dev, U64_MAX, 0, true);
> +       index =3D find_deepest_state(drv, dev, constraint_ns, 0, true);
>         if (index > 0) {
>                 enter_s2idle_proper(drv, dev, index);
>                 local_irq_enable();

This is not the only place that needs to be patched this way.
cpuidle_idle_call() is another one AFAICS.

