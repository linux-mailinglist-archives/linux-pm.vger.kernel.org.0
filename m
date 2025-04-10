Return-Path: <linux-pm+bounces-25109-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1996DA8435A
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 14:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D2B24C21FB
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 12:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846662857C5;
	Thu, 10 Apr 2025 12:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ygoG7ksq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779F92857C3
	for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 12:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744288577; cv=none; b=HHt3iTXK3TvSy8LDV5tqzOCbTHxWbMbxlbk5FltGcq/mPFef1jgd+Q1uGxS6yXnKcSvxmoJbMSw/x6Zd7FvL0cbO479UbYPQti3triiqRdKorufxdcGOTd0GVgbOU81F4mtOsQ0tKbqjhurU6zC9K2GEKslWUdkesx5J9pCmiag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744288577; c=relaxed/simple;
	bh=H2rAYnbGeFgX5saZ/b7X46QHeJfq5kinlY6BpgEnd3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QsCmEVqz78QG7+mMJkSjXGwJwW4+roJ5IXDfpD7GJivmkjnRqA+yDMim6iK2TFVS4lmvYIPVB7T4hnUHTQnddpUjzZfbEdwWbP0/XR/utSRVzmYtHC02QTguzJYkFwjbw/m+5oJeSJqr61IqfX3Ga9XdNwUAbSrSNjkY2OhJ21c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ygoG7ksq; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cf848528aso5911765e9.2
        for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 05:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744288574; x=1744893374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iQ0j7wMSGTmXUuOHtflR052mxHlsC9aOf5SK3WIqsvY=;
        b=ygoG7ksqWNg5LSepdZfB/g+GufHjgHmLbB8kRtXYFazeG1EQ3GAs58DYd41HbC4Msf
         v1iNSbVmc5xO6lBOIWnTCRlJWkcgRpmt5QeV9BiPNPNsMtcYBgTYGsphaDyJfbmTlKYx
         OMpfQRnGgVRDKAHzsMoyN25N7RLLB1ecXlr8g8Jg/ZhRGFzxpfsZCT/6bimq+2srOxzH
         z0TYCHmGdssVtMlbzsZa96s1IzN5jZ9C8wrgW6wOmUqjg7bcAkgEqR1sakAYSyUOIdwD
         nTeNLTql2k00gDCHDEwNOhrI4IDG2r/8HIMXola1w5WpOriOqWJ+Ym//XOVvxNzE/v0n
         C6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744288574; x=1744893374;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iQ0j7wMSGTmXUuOHtflR052mxHlsC9aOf5SK3WIqsvY=;
        b=DIsryfz/S3LJ9Tb4ETIXggfXnicaUxSBZMLT8klsWv2v2gd3bwcPPo2/t3akvkBN6q
         Lmm5WbZt9qsf7QyF4kE51mtu2DhAlsVSEZUyQjWvOMBfKfSAcdKhJtDTuZlQPg84tgny
         Bn0vMzlJFzkPk94oZ9eaKLXJPCiY6cWcxDUIR243AJ4oaa0FFYpdiZaZXpnuYTrmCvl9
         MCR/cTvNf9AVuUt7q5E4+RomUl4rf7q1Lxf4gi1S+3K8x2r32m9r9oV6CR4yOcmEJJp+
         M5eppAAkxeCBg+Xv2u73voW8tL1RK8SjIG3JdFocg7tkf7TV1uYcNIgQUrTZE7KSS61F
         43LQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6pL2UMWUzpAqnbdP0U4jV+OH+7DmssWMIjQnQbLi8Pfq8UdCGHLrth1O8i2xk1wqFfAvEjtV/7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAMzjXw2hAyOZ8Czyjll4YHBEarRqv2xqVsT/wlB/VdfoIIz3T
	+6ExiqbbG0BdRv/ajnLtz4+nV5FbULU9o5I4IwsoVF/EJXkz+I2iUQ0klGun8i4=
X-Gm-Gg: ASbGncu6SHjHCEvE798/Vd+ylJubfX4GVD+vmofyLBm7/L6H0/f+7SFrs6hn39VPATq
	okOPjYJTEfE45iisgsYu45WrxNFU+VfG/M1YB1K49wMoDkP/7hhlPyOPtTL/Hlu7VENI1F7gUnT
	efEMFEXp2odfH+FdEJp3ISJEYtFCOGBMwB2WmjxiWcH8/svPhVIHdCb4F6nf/nJfBvbm9yjxzco
	hhUNVVM/bs54jnAISPP7TYDhSOsXVnU95fiYXruW9SKYtTEI80Bc7UvFBcjJJ8iiD3k84cOmIRl
	+T0WwU1a+dBKjq3ogtCkMOB/UQ0VjgCF6SSHPkzy+yOFViGfvavyZbo1+KsRTkkyw3sb2PCBFsI
	XcqcpbfSiKRj/Xw==
X-Google-Smtp-Source: AGHT+IFetWy1yp/dwylC0fW3Xc3rkEsOkh6f7DWozfmMsr0xNplY7KcWpRd6urR6Mieq6r6/8yNM9w==
X-Received: by 2002:a05:6000:4285:b0:39a:c80b:8283 with SMTP id ffacd0b85a97d-39d8f498980mr2285415f8f.31.1744288573720;
        Thu, 10 Apr 2025 05:36:13 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d893fdf8fsm4624182f8f.91.2025.04.10.05.36.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 05:36:13 -0700 (PDT)
Message-ID: <17b9ff87-899e-44ca-b902-ab965cff0879@linaro.org>
Date: Thu, 10 Apr 2025 14:36:10 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/19] arm64: dts: broadcom: bcm2712: Use "l2-cache" for
 L2 cache node names
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
 Stephen Boyd <sboyd@kernel.org>, zhouyanjie@wanyeetech.com,
 Conor Dooley <conor@kernel.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Steen Hegelund <Steen.Hegelund@microchip.com>,
 Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-mips@vger.kernel.org,
 imx@lists.linux.dev, linux-rockchip@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-renesas-soc@vger.kernel.org
References: <20250403-dt-cpu-schema-v1-0-076be7171a85@kernel.org>
 <20250403-dt-cpu-schema-v1-2-076be7171a85@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250403-dt-cpu-schema-v1-2-076be7171a85@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/4/25 04:59, Rob Herring (Arm) wrote:
> There's no need include the CPU number in the L2 cache node names as
> the names are local to the CPU nodes. The documented node name is
> also just "l2-cache".
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>   arch/arm64/boot/dts/broadcom/bcm2712.dtsi | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


