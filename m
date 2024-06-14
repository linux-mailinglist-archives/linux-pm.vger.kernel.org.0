Return-Path: <linux-pm+bounces-9181-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 244D9908A0F
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 12:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97E3A28B8B5
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 10:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A772A19414A;
	Fri, 14 Jun 2024 10:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="teEWlvVU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51F1137C2E
	for <linux-pm@vger.kernel.org>; Fri, 14 Jun 2024 10:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718361327; cv=none; b=OjzNFi4/t3cwGbFRrFz2bCoqrOo/x6lBwxX2KO9uw/dJWb/jdb7JO1zm+L5OzAJvWZnnIW4aJIThX4/HotAoaYMqHef4sn6uu+Qe6D4Waof9cLtHqE3VpumfHJI1NLRJvnXDGq7iKAoPZluMTk4DCpgjKIeh1Da69+kOzlDd/b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718361327; c=relaxed/simple;
	bh=zQTF8f1f4E4offgF6AppLKOcBdlWwKz4eWbWjGZGOSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7jyaAMK3MhQrrEXieVINhhqh2/msLKVeYGdIWHE+pw7D1cvQAaMIs2OIg3HYJll6V2Q+mkii84O+889HPt6gkulTM0/XaxT+jc9Fe5GQ/4Zsi+8OL6/FC8+VGKQN3bVKNGrqK5rGYOjhurQh66MOvGIjFo584JByimLgoQ/56s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=teEWlvVU; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52b7e693b8aso2805137e87.1
        for <linux-pm@vger.kernel.org>; Fri, 14 Jun 2024 03:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718361324; x=1718966124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gi0zKyxT3hCd9nb/MhrUUh7myaChKF1I5PdBUyc2GXs=;
        b=teEWlvVUTdSj7i/zCVjz2AkzvoRghq+p6jDie657GiaKHfA5G2ESEp0cwqYDYvgxjq
         6Am5IXyt85BaN35MFgVOxdOTJoJ2VmZfWBFFeIPeL7YBZRm4aRuIKrpKS+aoYYCUUHdP
         Y2vHvW5sETuPwhJIzrQusKaEceMr1WfGFkqhrfqv3miZJEumFmj0oKScjz1jsTa8+pEM
         FFYlZgS3DQH5XzcsGK4vpnI50gbD+K6BQ42ml2+4B9oiZRfHLWmKD1IIKPJr/tjwHyyf
         6ubFH+QzWNqNbU7jhqwc/AYEInvFylWg6Fjf/H+4nZGtc7GX+0ZgUoAuURMZuiIkcUwj
         HtrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718361324; x=1718966124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gi0zKyxT3hCd9nb/MhrUUh7myaChKF1I5PdBUyc2GXs=;
        b=jUUjHkc7TID45VWPdag+3HZFRLvNOZ5/iP/BUbxKYjYmz1xCl/Ue/hrWX86V5IrT0D
         cSvbCyG2GD7pFFy/mOrhj+KEsMkNAKU+fl/xy5RQ3jFNPmV9Vb55Sj7mCaRXJozgnoi6
         Y+vo+weIuHYSbj8yF+bn6cf9k+5eJgBhDNnJZ9sku0MOX5+moMzNQlDCwqiv+5qRyfV9
         NiCibT36ESYwdi/hcosAC14Uo3ZdTA9eXjtZP8j0QQ+HOEB1J6LlcD4S4lvCUM5ahMB8
         U+HSP47+a0/jUs25B8OqSF07m/5Rl9Sz+/Yj5GulN8IsToAkmedpKfLOdVaK1N9yciMh
         Wm4g==
X-Forwarded-Encrypted: i=1; AJvYcCVVC/Nufaf+3+/uBpnrbt9vCGG2vxj4rjwlznnV81eFhHxfyD/iLuC1hbc32hTu1L4cQnZ5gP9zE8SNxzWFoiiEY3e+jR4qbbQ=
X-Gm-Message-State: AOJu0YwGlImkyumG/6JnLObVY++6nA9StpCsP7Q2b+U7QJdy5rYkFqzf
	uxazys9zop4ihHw7VdHrWk7cTEQpPJMXo8joBCPpPYMiFZq7HdolMQVlVXneOHQ=
X-Google-Smtp-Source: AGHT+IF21atwqR62ijL3XLbekBscy+usmTEKarUelgvxFuWKneWXxFSinPdGquI11kE+MEGG3syk0w==
X-Received: by 2002:ac2:4649:0:b0:52c:94ad:9b26 with SMTP id 2adb3069b0e04-52ca0464493mr1605471e87.30.1718361324088;
        Fri, 14 Jun 2024 03:35:24 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca2872578sm468370e87.130.2024.06.14.03.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 03:35:23 -0700 (PDT)
Date: Fri, 14 Jun 2024 13:35:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Guillaume La Roque <glaroque@baylibre.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Vasily Khoruzhick <anarsoul@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Anson Huang <Anson.Huang@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Amit Kucheria <amitk@kernel.org>, 
	Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, Heiko Stuebner <heiko@sntech.de>, 
	Biju Das <biju.das.jz@bp.renesas.com>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Pascal Paillet <p.paillet@foss.st.com>, 
	Keerthy <j-keerthy@ti.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, zhanghongchen <zhanghongchen@loongson.cn>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Bjorn Andersson <andersson@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	imx@lists.linux.dev, linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, Florian Fainelli <f.fainelli@gmail.com>, 
	linux-rpi-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 09/22] dt-bindings: thermal: qcom-spmi-adc-tm-hc:
 reference thermal-sensor schema
Message-ID: <mobms3s3tibh6wljulwr3okof2msvewed55ukecj3bkdfbgech@blk6udpuy5ov>
References: <20240614-dt-bindings-thermal-allof-v1-0-30b25a6ae24e@linaro.org>
 <20240614-dt-bindings-thermal-allof-v1-9-30b25a6ae24e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614-dt-bindings-thermal-allof-v1-9-30b25a6ae24e@linaro.org>

On Fri, Jun 14, 2024 at 11:46:08AM GMT, Krzysztof Kozlowski wrote:
> Device is a thermal sensor and it requires '#thermal-sensor-cells', so
> reference the thermal-sensor.yaml to simplify it and bring the
> common definition of '#thermal-sensor-cells' property.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml          | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

