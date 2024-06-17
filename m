Return-Path: <linux-pm+bounces-9271-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E58F90A285
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 04:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E6C4282D3E
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 02:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C42D17836E;
	Mon, 17 Jun 2024 02:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UI1bCvAX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6419C176AC6;
	Mon, 17 Jun 2024 02:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718591796; cv=none; b=XpNBj8/BGiNmJQLTMG/7dVkXabJIQpu28YZFfUBrOBcCAb9SLYBfdMN86dHT/I36kGofcGJhRmW7eu0AORv2ctdgb+QhFYutHLp9UEaJ4a6mNjhiitKuRbXXw0Mn/xpLQBL/KzSmLm3Ch+cRII3iflXNvvmwyngZh+cvLTg6rrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718591796; c=relaxed/simple;
	bh=lczObmd9t5CNOLsW1w8BAFRVJ0CtUEDoyScV7EOYG6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kDvdOEQgCSp2S1RGhfRLVVNms+kfnku7e01XNzbvX6oi1SyTBMM2mAO45qh0BRGHPPApa23z6MbRq06n2gjE0XCqQ1v0O2bcvc9UBaFhpxARUbzTlnAfZgmnF46YCXOas1YWMilPAnZztJP2sWeQy/r+sBfwdXwCC2jrEeIf5Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UI1bCvAX; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-25075f3f472so544980fac.2;
        Sun, 16 Jun 2024 19:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718591794; x=1719196594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3S2YurUrl5MC+fkMuKFY0ClzSCLEfz1Oc40ER8vtAUk=;
        b=UI1bCvAXcT8oFawrgPKV7R7V1Y1l9hihWGu2H359gjJ86/mdhD10RbY13jKDplo6/f
         j4V84YzGTTu7GMT1ujD373FYRNeHQFOHZf6QPKhEoMUGslm5dhXoJ1RwPb2xnhlnWk/p
         z7z7jOtlxyWt8CfvBFI5/ee6EgGNfqXCkMghaEfY+P9clxdD+UnnSpP/jlgoz43VPB41
         tVD5AekHv/QDHkxhhuTnNPW2SDN7DQGi56Gvvj84EWqKSmshZ6pThCJEmoa8GAhQG5dj
         VIRiR66vbrNfsH5XyRNwcbjerF2JQDz4/TR9ZjWsLCKj425Tas+U9JkZmxEi+q8Z9N9V
         qcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718591794; x=1719196594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3S2YurUrl5MC+fkMuKFY0ClzSCLEfz1Oc40ER8vtAUk=;
        b=jvOUItlC6L/lAYZLl8KVUurp+pX1dgaDnDb4hQ9OEBaC0YMEQoC8HYQyuR3+APoRZ9
         q6fQTLpFjWwVBPjgO8279WXaBtW0cdIHmA/PrPxHD6ZrlkP9YHdZr1qAakVy1qob4WLo
         Ed1J7zZYBMlVTFtPGBkQHCYDet9cXi+rfKLld8iI1+iIgXPluYR80poYt6oBYod31NTu
         kCoZwWH4P9S7KN/p/oTbo9XEZc+9SIGSSr44+WRZpKwVbXX3xYIlrQTZu8ZiTS14Mqu/
         XD/5ci+pduOWSul41Ndt0iFZrRzh675LxcZDCB6sJdleojYsKRSig9rYpY9I29fjsFAD
         EIeg==
X-Forwarded-Encrypted: i=1; AJvYcCWhYVX2EiZOngemrWzn1b7b9JA3sbrM0CIxZHB6Pjcp3Kb2409O+2NqqdioOBYiS9oU2s1i/+8qo5+3VzeeD5r8Lm2PwJaQNfIlHDtMI13eMedKFn/grLLqTkxxDDWMQ3uKDkV2APKXQS4o5EEjyVQPomhsvucKYjHoWEWtCgn9HyE0BWkQzIcj7OJOmdgxzMZ3dm5J+RzpQcnvXWNvbmtFcwG0FQUxAS5R3Z6+xuAzc8OxRDqMWzt+kjo68y+OuMsUr/pLHDoj3mHcglckzvvezLvjCAZwaPTwFVp6xANeUPhFokzUyY9Vmj4PTfu+7Co8OjDeqnbGDEuz2QMJo9KaG2bOOg==
X-Gm-Message-State: AOJu0Yxu0BgZ9ADF/gBgQT1lzljIvTuI4UwcS7fRtrRlT1g2f3MQUVde
	WrKzWTuwJzMvhlIquQFDFOrZGa/Z0jFgnYm7zkjg5WT2uw2L0imnrBuUsfD2VgGF+rTUscD5s4v
	PM3FCkJ27GqkA/N+D4+6Ch6sTIF0=
X-Google-Smtp-Source: AGHT+IGltFa0bQ5GCz9R8Qfp8q4AWMyO+O31iG05ayKCR1g5p5BB0jiP/wIlvjmzI8GEc+sBuDPZkWfe/0K++X8dom4=
X-Received: by 2002:a05:6870:469f:b0:254:d417:351f with SMTP id
 586e51a60fabf-258429511admr9266807fac.1.1718591794255; Sun, 16 Jun 2024
 19:36:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614-dt-bindings-thermal-allof-v1-0-30b25a6ae24e@linaro.org> <20240614-dt-bindings-thermal-allof-v1-3-30b25a6ae24e@linaro.org>
In-Reply-To: <20240614-dt-bindings-thermal-allof-v1-3-30b25a6ae24e@linaro.org>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Sun, 16 Jun 2024 19:36:08 -0700
Message-ID: <CA+E=qVdpw5dMSdZiBkX5i6y18vHzfG2JnBSmd2Rq=y4kkgZLQw@mail.gmail.com>
Subject: Re: [PATCH 03/22] dt-bindings: thermal: allwinner,sun8i-a83t-ths:
 reference thermal-sensor schema
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Guillaume La Roque <glaroque@baylibre.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Anson Huang <Anson.Huang@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Amit Kucheria <amitk@kernel.org>, =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
	Heiko Stuebner <heiko@sntech.de>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Pascal Paillet <p.paillet@foss.st.com>, Keerthy <j-keerthy@ti.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	zhanghongchen <zhanghongchen@loongson.cn>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Bjorn Andersson <andersson@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-pm@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-amlogic@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	imx@lists.linux.dev, linux-tegra@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, 
	Florian Fainelli <f.fainelli@gmail.com>, linux-rpi-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 2:46=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Device is a thermal sensor and it requires '#thermal-sensor-cells', so
> reference the thermal-sensor.yaml to simplify it and bring the
> common definition of '#thermal-sensor-cells' property.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Vasily Khoruzhick <anarsoul@gmail.com>

> ---
>  .../devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml       | 6 =
+++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a8=
3t-ths.yaml b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83=
t-ths.yaml
> index 6b3aea6d73b0..dad8de900495 100644
> --- a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.=
yaml
> +++ b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.=
yaml
> @@ -10,6 +10,8 @@ maintainers:
>    - Vasily Khoruzhick <anarsoul@gmail.com>
>    - Yangtao Li <tiny.windzz@gmail.com>
>
> +$ref: thermal-sensor.yaml#
> +
>  properties:
>    compatible:
>      enum:
> @@ -55,7 +57,6 @@ properties:
>      maxItems: 1
>      description: phandle to device controlling temperate offset SYS_CFG =
register
>
> -  # See Documentation/devicetree/bindings/thermal/thermal-sensor.yaml fo=
r details
>    "#thermal-sensor-cells":
>      enum:
>        - 0
> @@ -135,9 +136,8 @@ required:
>    - compatible
>    - reg
>    - interrupts
> -  - '#thermal-sensor-cells'
>
> -additionalProperties: false
> +unevaluatedProperties: false
>
>  examples:
>    - |
>
> --
> 2.43.0
>

