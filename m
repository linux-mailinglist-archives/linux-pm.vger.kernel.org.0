Return-Path: <linux-pm+bounces-24798-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3246BA7BAE3
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 12:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45F677A578E
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 10:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162CA1DEFDB;
	Fri,  4 Apr 2025 10:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m/4st2RZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F4E1CB9E2
	for <linux-pm@vger.kernel.org>; Fri,  4 Apr 2025 10:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743762711; cv=none; b=I5pA9jgHlJHb3rZkxPQTZePzNcNK8j3xPNihxpFuTEo6DU5ZB6kNndjvuRlPAeZ8iJsSPUDBlCdkIgFTt6j8mQ4jUaZs1pPFPRppHfb405dcHKOxsBYax+9x5jHVzmJVT5oK6A56QCHmC0oVORrRsY1jZlyRqsd1mZ/YgJoGaFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743762711; c=relaxed/simple;
	bh=puo0zeWGfg/XrDDKhEtVrd4WcWPM6KhzepuNu4U2cy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fNNTpXPGz6m5g9o8YgD0PZr99VGjjEIm9nhI18U2cPgCo5oW5U5oAYOKD6P4gUIRCaWIkNwqJBZZoOBf9wW766s2/3l4GLXu5qbtW4xcrymOz9J4RVadD6nRVPkWArmPVuWKieLQ2X1B1Fr5A4UuK2/zFvyTyn9N59Y22CKfKBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m/4st2RZ; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6feab7c5f96so18585067b3.3
        for <linux-pm@vger.kernel.org>; Fri, 04 Apr 2025 03:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743762707; x=1744367507; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p2d7X4LZ95qskY0j6wRpuQmYie6Gy7m1icDTnjrkreI=;
        b=m/4st2RZ1mYZE75yFAAubk3/IIDJ6JIabR/ozRM8VS8xImfsqQIuAVxlGtQU97pD/N
         at9MecDkuLyDTFBTc/GnSfKatPHJXGGwPdSlb62nm79r/vCFoKJhws0GY0YYQdx6I9do
         yc7ttS8xCmP/SM5eAR8IoV5v4lD5mxYS74ErF7dLTE1RcqS4ijiM5nZ1nrMGuJO+cmiB
         7mnsRQRQDIFoc6BZxTFQAwLXf+0JHDocNLZKYAci5Rki3RGyrtWdNLmNjsNCdXAniL6Y
         iHoJNl2txeZVsiBZJY783GrBNnFFFqE3lVM/e4l3QrhuC5MYIOWYY2fi4NrLLRA+Jcwo
         aLeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743762707; x=1744367507;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p2d7X4LZ95qskY0j6wRpuQmYie6Gy7m1icDTnjrkreI=;
        b=Kqb9RH6XEibyPxiSA8Os+ze4ohb0WWAP7m6VhdzPBlpxPwZ+VGoBfgXbw0J1uNoL8C
         6uxp9Iaba4HRSVb9BgllIF51qzzBlZG95NxnlEHzkvCkVCd3Bx7l2UVGoRiFV1yBAos/
         +NagOOT45GH/DLQmwdMA3xwl0B/9O7KuBotDejPPTuxheEqOKeHIWGfASlcLc9BnXqBm
         dMvBTFp00vLiA0TA2yvFrVp/EiCfk1AXLd6tQjmdHwnrQTxMfMsLKNdOE9cRe4i3800F
         gjGMPiZWuW4+0+Z5w4amIzrcUNjdNNVMVifEnY1OnzKnJvb8HEmHQnM0IoC8YN5EWoO3
         EbiQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+8EHOr0SY6yyFAIhqoTcNmx30+a8Lr8C2QoyHOMRyEvC/yFcQhEord8LfjWSCJPRM9BqX9xIISQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYIljHmBY9JOc8mQQzw67AbhfYQ+Foq8cO5tPs2vX5NRozjKln
	Ryu7r2TrFj4E5H5TVX1ciUHtntPFylNhNzszMmzN75DxlJddXhPGiCCdHYUnoOOa4BBN1pT0YHR
	z761q06V2dk/tkW88eGqSaBg2EKaFAhArhYPHXQ==
X-Gm-Gg: ASbGncs9Bx0biG9MTgxQqI3WarblpvoKazAHWUGPrQJaA/al7SQveoS9wBbmRWIhL3w
	0gSCA8HWFpVFoQDpq5DlQEl7TME1CFtVR9DU9/6dxnbDuX8mLsSz+MJPlVwUo5B6Lj6MAXlCxTa
	DdBlQ1MZSUkcKmFlfjK9dytgE/roOYq33YfUU4dA==
X-Google-Smtp-Source: AGHT+IHL6tNiMt83fP/8QoVhxPRtZTRBqTJ/Cw9tCME3kjDGJ0WhVAtLf3L7QrkxkDkyR8ahdAf3HNvn/ambJdKtSJE=
X-Received: by 2002:a05:690c:9a0d:b0:702:d85:5347 with SMTP id
 00721157ae682-703e16473e9mr44558927b3.36.1743762706998; Fri, 04 Apr 2025
 03:31:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403-dt-cpu-schema-v1-0-076be7171a85@kernel.org> <20250403-dt-cpu-schema-v1-9-076be7171a85@kernel.org>
In-Reply-To: <20250403-dt-cpu-schema-v1-9-076be7171a85@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 4 Apr 2025 12:30:59 +0200
X-Gm-Features: AQ5f1JoO4h1zt0Jv8N6Q3VB80QU6oNypKSnO1edlCmwT1znvOfAf3BOWzm_IC6U
Message-ID: <CAPDyKFoEEp8AZ7aJ8-wwp8=n+T4gbij15oYaCNhF1Bd-E1nMbg@mail.gmail.com>
Subject: Re: [PATCH 09/19] arm: dts: qcom: sdx55/sdx65: Fix CPU power-domain-names
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Viresh Kumar <vireshk@kernel.org>, 
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, zhouyanjie@wanyeetech.com, 
	Conor Dooley <conor@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Steen Hegelund <Steen.Hegelund@microchip.com>, 
	Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Heiko Stuebner <heiko@sntech.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-mips@vger.kernel.org, 
	imx@lists.linux.dev, linux-rockchip@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 4 Apr 2025 at 05:02, Rob Herring (Arm) <robh@kernel.org> wrote:
>
> "rpmhpd" is not documented nor used anywhere. As the enable-method is
> "psci" use "psci" for the power-domain name.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  arch/arm/boot/dts/qcom/qcom-sdx55.dtsi | 2 +-
>  arch/arm/boot/dts/qcom/qcom-sdx65.dtsi | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
> index 39530eb580ea..64d9858b4248 100644
> --- a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
> +++ b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
> @@ -57,7 +57,7 @@ cpu0: cpu@0 {
>                         enable-method = "psci";
>                         clocks = <&apcs>;
>                         power-domains = <&rpmhpd SDX55_CX>;
> -                       power-domain-names = "rpmhpd";
> +                       power-domain-names = "psci";

As I understand it, this isn't for cpu-power-mgmt but for
cpu-performance-scaling.

I have been thinking of adding a common power-domain-name for this,
but never reached to do it. I think the last one we added was the
Airoha SoC [1] which uses "perf", which seems to be the most common
one. Still I don't see that being documented.

>                         operating-points-v2 = <&cpu_opp_table>;
>                 };
>         };
> diff --git a/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
> index 6b23ee676c9e..bfd04e53c5a8 100644
> --- a/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
> +++ b/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
> @@ -58,7 +58,7 @@ cpu0: cpu@0 {
>                         enable-method = "psci";
>                         clocks = <&apcs>;
>                         power-domains = <&rpmhpd SDX65_CX_AO>;
> -                       power-domain-names = "rpmhpd";
> +                       power-domain-names = "psci";

Ditto.

>                         operating-points-v2 = <&cpu_opp_table>;
>                 };
>         };
>
> --
> 2.47.2
>
>

Kind regards
Uffe

[1]
drivers/cpufreq/airoha-cpufreq.c
Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml
drivers/pmdomain/mediatek/airoha-cpu-pmdomain.c

