Return-Path: <linux-pm+bounces-33997-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3A7B45AA2
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 16:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFBE8B60D07
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 14:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4E836CDFC;
	Fri,  5 Sep 2025 14:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I34lo9IB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FFD369322
	for <linux-pm@vger.kernel.org>; Fri,  5 Sep 2025 14:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757082487; cv=none; b=H0YpJ5Zzg1lTXTxK70i8JxoAhqdH6kzKW+9H2+jaJ3kFAMPHVrqz79OuclRL0vkULzE1UEIzs2ShvGH3Jy3nwMMidY8H10CAVSncZW6Ix77/QQoMUB/TvCNr0S9pA4IzGTQ2gmM3+gcAOqrXXUf6U9+GodPEthqCHux1pxzq5Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757082487; c=relaxed/simple;
	bh=iMW3bYd4LW3JWRnFP3mkUjQVIbwOYp4N45RelcvLep0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ax5dVc/0enTIGoZ2RZ57bgaoOTQ0ZuPNQ85hM7BwzkZyjXAXSt/lHbLOI6NyM0el8hJZu6m/mB3IaR3dRcYFs7C8jyOONGkYyOZo8dT2Bnwa6JlZXWhEI+51QlFrgIRiBZg3rrLSvSAl3NUxaP1dhb3ZmEPmiLg2c1UiXR2NPUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I34lo9IB; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71d603a9cfaso21972487b3.1
        for <linux-pm@vger.kernel.org>; Fri, 05 Sep 2025 07:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757082484; x=1757687284; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iMW3bYd4LW3JWRnFP3mkUjQVIbwOYp4N45RelcvLep0=;
        b=I34lo9IBKAhIThYSuhxJwU40XSCILPTSkDYYFnmLQZImtfJmQBm9JZbonP2Xs6Q0py
         KwWclXdxeXyDleI0ixx44bPKZNK7VK5RnyxU0wXIeZSRYdeClXx9xm/DGXe2QJAaXFPy
         2nRqdM/NFCEd2w9ZLurc8uCYFaty3fXZaiIMrespHz2+DubYYxYzsuFJTUWyog6tTTsT
         KTyztXsBEl6jlSIhCwaWRwYpkvjPrl4s1PBaHWqkGQHEMRtMS3fI+E1mo9ISuBWXIxkM
         2Byks87Lm/2Xec+einG4F2e+ILzoRRm0s/P/BBE9sowwHCuJTJyXfwV4tnZeYZnYWBLa
         0YvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757082484; x=1757687284;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iMW3bYd4LW3JWRnFP3mkUjQVIbwOYp4N45RelcvLep0=;
        b=Gw3laHSEhn08ZLNmrYsJPBVaVXQCPpIDOpiCXgo/wWDBfm6ihbWiM0soQSH+t8PeYO
         62MlpC5fnoYOiPkIQgzXfLJdTkpEqsMdB5C32+A0NrbCi3QihU4a9RxPJ90gtqWny4XY
         YXlQSJktBE0Xkdrz3CdZKfVPQGddsDTQjb8mC8JTEc2Da7PkEcufXUGI+AyxYTAnmYbs
         tm+eHhvZttWXITwakd33ootRtgAcJlgJOe5FAIcThOgBmdTI80b0gH451OHidrXKQRLx
         ZRkEn0+cxgxUZ1xN5K75KE6tZ3bs0MdrDLxMptd2o/dwZtTPrPh9lvajeFeDtW6OIUem
         O6+Q==
X-Gm-Message-State: AOJu0YwRPcx0i3Arkoxcdrf8HqOY+mZkPCnHmVx2icntVHpHv6t6Z3Pu
	y6H30JFFgOQukJGjfRWAR9yP8FZ5/LbiCqlvC8uKwSUYCw/0LgO/axd8X8aj/tdmWWuc+Dt0F58
	X+3XvnFAw9rEC0wscRHwhbYZdLzxovh/RbQkPuhuhlPx+9kU1cwA5x9M=
X-Gm-Gg: ASbGncuoZL/SJywT8YOydeWqm29t3Tk3LVeMnalEPgvxOE9hpCCzfXxBNYF6VvigBRs
	TtWZGMc67zCBYZEX8Pr8GN27qW0hABI2mcHwTqwLbqeOzDxAMFpQDFB6BkXM5aFHpO74n/+LsIW
	QdXmq/XTzUdgJsvoQJZjOT6ztFiAE1JYz97mYf9mnDF+irRsSPCj/urZ1YajoOvOe7Lel3m9xuf
	siXCIiTn1Fyy/ke/ng=
X-Google-Smtp-Source: AGHT+IHckmRAJE89FXWWeCt002oCNhs7ilFvKi54aN2hkL9SOdLB58eIP1SZS8Ne2VJD5q2m/6tTefKqLCBLkhBMdCQ=
X-Received: by 2002:a05:690c:f86:b0:71f:b944:103e with SMTP id
 00721157ae682-72276543df1mr262928937b3.47.1757082484124; Fri, 05 Sep 2025
 07:28:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902-rk3576-lockup-regression-v1-1-c4a0c9daeb00@collabora.com>
 <CAPDyKFpAOLiBOoAhv+GQcobU_g_AWrB9iyOGmodROLtRmR30JA@mail.gmail.com>
 <3332408.jE0xQCEvom@workhorse> <3556261.BddDVKsqQX@workhorse>
In-Reply-To: <3556261.BddDVKsqQX@workhorse>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 5 Sep 2025 16:27:27 +0200
X-Gm-Features: Ac12FXzti6CwQKzMNnrf9BUUJQxR_BOv1AT1PonXIWLFU5Biyc2yW9uocDffvw8
Message-ID: <CAPDyKFpSY+FeKh7ocjQ_nGNZA5+3tWAL8e7ZNKXKNFP-yoiu_g@mail.gmail.com>
Subject: Re: [PATCH] pmdomian: core: don't unset stay_on during sync_state
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@collabora.com, linux-rockchip@lists.infradead.org, 
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"

[...]

>
> Okay so I believe I have found the root cause of the regression. UFS is
> innocent, disabling UFS just happens to avoid it due to how the timing of
> things works out.
>
> The real issue is that the NPU power domains on the RK3576, which are
> currently unused, have an undeclared dependency on vdd_npu_s0.
>
> Declaring this dependency with a `domain-supply` and adding the
> necessary flag in the rockchip PD controller to use it does not solve
> he problem. This is because the rockchip PD controller cannot acquire
> those supplies during probe, as they're not available yet and their
> availability depends on the PD controller finishing probe.
>
> That's why it acquires them in the PD enable callback, but the NPU
> PDs are never enabled because they're unused.
>
> This worked fine when unused PDs were still turned off quite early, as
> this meant they were turned off before regulators. Now the unused
> regulators are turned off before turning off the unused PDs happens.

I see, thanks for sharing these details. What a mess.

>
> I don't really see an easy way to fix this with a patch that's fit for
> an rc cycle. We can't request the regulator early or even just add a
> device link, as the regulator is not around yet.

Right, I will work on a patch or two that allows rockchip
power-domains to opt-out from genpds new behavior and to keep using
the old one.

I think we prefer to do it like this (should be quite a limited amount
of code and okay for an rc), rather than reverting for everyone.

>
> Marking vdd_npu_s0 as always-on would be abusing DT to work around a
> Linux kernel shortcoming, which is a no-no.
>
> What we need is either a way to register with pmdomain core that
> certain PDs need a late init for additional supplies, which is then
> called before any of the unused regulator power off functionality is
> invoked by the regulator core.
>
> Any ideas?

Yes :-)

I would suggest implementing an auxiliary driver, along with the
rockchip_pm_domain_driver. The main job for the auxiliary driver would
be to get the regulator in its ->probe() - and if it fails because the
regulator isn't available yet, it should keep trying by returning
-EPROBE_DEFER. See more about the auxiliary bus/device/driver in
include/linux/auxiliary_bus.h and module_auxiliary_driver().

Moreover, when the rockchip_pm_domain_driver probes, it becomes
responsible for pre-parsing the OF nodes for the domain-supply DT
property, for each of the specified power-domains. If it finds a
domain-supply, it should register an auxiliary device that corresponds
to that particular power-domain. This can be done by using
platform-data that is shared with the auxiliary device/driver. See
devm_auxiliary_device_create().

Furthermore we would need some kind of synchronization mechanism
between the rockchip_pm_domain_driver and the auxiliary driver, to
manage the regulator get/enable/disable. I think that should be rather
easy to work out.

Do you think this can work?

Kind regards
Uffe

