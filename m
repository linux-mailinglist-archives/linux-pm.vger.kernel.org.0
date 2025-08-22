Return-Path: <linux-pm+bounces-32856-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF133B30C76
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 05:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A89D51C2684B
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 03:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A7D289E16;
	Fri, 22 Aug 2025 03:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="m/iT3Gel"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2321922172C;
	Fri, 22 Aug 2025 03:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755832877; cv=none; b=L+aHX7n5708OOoNTphF+CEmVekH2dg/Tb3vuJqbG2sct9iB2eT5O3wJ/2jH08OzFpqwP3JmD0QS+pSASqUALPTKvxfOt7gzgGpEtpgGHdRmis+Cu5LeH0FZEFqID2DhcsdHVdOl4Qkzb+K3T1iOAtpSS4fcLZoJ//vvObpYHuBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755832877; c=relaxed/simple;
	bh=hBBwFfmvRDgCwPWHrlxdOefK8GCSbJwUcdCgQ0eKL8s=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=IvobziPK2Mv/2plTL/byAf5x+k7hOoX5A1ZjIA58eq0dcVz15lyj2G6Lilw4aiamg4iif+m3NZAOGECGiV4DrrEt8GRfB0cXCP8Gr7VDzD3jqb4FVDwuPzV0gIHQPxdbSaE8jhtt1/wi3Yd3TF8AHbsQKEL25TwWWP/fA8jdKrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=m/iT3Gel; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1755832276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h3v0SnafxKU18FwdsFkXkfhEoVhOWX6Xg3ytYgsgU7E=;
	b=m/iT3GelGjtSI/56+p2/pI2ZDBaFTJ7bOFtj2h4mIKJrOkKIsUixAMmImGhx58H6Kpom9P
	0kjf7V9Cz4BvIQhdrME3LeVF1ug+pkOLdLLaK4h1xXJ1mnbgLZphRvhFolYEQZVdgXIDOZ
	5YbIYKb2OETmV2JXYGzl4fWBWbbeLv9/WwhwfrXzd1xRAxj/xMwjp5EhTFUuTXm4vrJxi4
	zkqKUSMvdUclVn77aLLOvXUCdkJae0rh0T/BCkJg3SkK+76Muj1wWdtRfASRRldKQAExq6
	lUaTRuIYgIXsTAVu5rpJcQ4ugqB6Q0D9CDmguShjx1mXZm3bWHL8me4+HOScwg==
Date: Fri, 22 Aug 2025 05:11:15 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
 <lukasz.luba@arm.com>, Heiko Stuebner <heiko@sntech.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Diederik de Haas
 <didi.debian@cknow.org>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 kernel@collabora.com
Subject: Re: [PATCH v2 1/3] thermal: rockchip: unify struct
 rockchip_tsadc_chip format
In-Reply-To: <20250820-thermal-rockchip-grf-warning-v2-1-c7e2d35017b8@kernel.org>
References: <20250820-thermal-rockchip-grf-warning-v2-0-c7e2d35017b8@kernel.org>
 <20250820-thermal-rockchip-grf-warning-v2-1-c7e2d35017b8@kernel.org>
Message-ID: <2bc3023e4b6e15b388f8765551018eed@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Sebastian,

On 2025-08-20 19:40, Sebastian Reichel wrote:
> Unify all chip descriptions to the version without any empty
> lines.
> 
> Suggested-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/thermal/rockchip_thermal.c | 27 ---------------------------
>  1 file changed, 27 deletions(-)

Thanks for the patch, it's perfectly reasonable and obviously correct.
Please feel free to include

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> diff --git a/drivers/thermal/rockchip_thermal.c
> b/drivers/thermal/rockchip_thermal.c
> index
> 3beff9b6fac3abe8948b56132b618ff1bed57217..7b18a705dfade6fa7318b28c2b57544a4446c1cc
> 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -1098,10 +1098,8 @@ static const struct rockchip_tsadc_chip
> px30_tsadc_data = {
>  	/* cpu, gpu */
>  	.chn_offset = 0,
>  	.chn_num = 2, /* 2 channels for tsadc */
> -
>  	.tshut_mode = TSHUT_MODE_CRU, /* default TSHUT via CRU */
>  	.tshut_temp = 95000,
> -
>  	.initialize = rk_tsadcv4_initialize,
>  	.irq_ack = rk_tsadcv3_irq_ack,
>  	.control = rk_tsadcv3_control,
> @@ -1109,7 +1107,6 @@ static const struct rockchip_tsadc_chip
> px30_tsadc_data = {
>  	.set_alarm_temp = rk_tsadcv2_alarm_temp,
>  	.set_tshut_temp = rk_tsadcv2_tshut_temp,
>  	.set_tshut_mode = rk_tsadcv2_tshut_mode,
> -
>  	.table = {
>  		.id = rk3328_code_table,
>  		.length = ARRAY_SIZE(rk3328_code_table),
> @@ -1122,11 +1119,9 @@ static const struct rockchip_tsadc_chip
> rv1108_tsadc_data = {
>  	/* cpu */
>  	.chn_offset = 0,
>  	.chn_num = 1, /* one channel for tsadc */
> -
>  	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
>  	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
>  	.tshut_temp = 95000,
> -
>  	.initialize = rk_tsadcv2_initialize,
>  	.irq_ack = rk_tsadcv3_irq_ack,
>  	.control = rk_tsadcv3_control,
> @@ -1134,7 +1129,6 @@ static const struct rockchip_tsadc_chip
> rv1108_tsadc_data = {
>  	.set_alarm_temp = rk_tsadcv2_alarm_temp,
>  	.set_tshut_temp = rk_tsadcv2_tshut_temp,
>  	.set_tshut_mode = rk_tsadcv2_tshut_mode,
> -
>  	.table = {
>  		.id = rv1108_table,
>  		.length = ARRAY_SIZE(rv1108_table),
> @@ -1147,11 +1141,9 @@ static const struct rockchip_tsadc_chip
> rk3228_tsadc_data = {
>  	/* cpu */
>  	.chn_offset = 0,
>  	.chn_num = 1, /* one channel for tsadc */
> -
>  	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
>  	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
>  	.tshut_temp = 95000,
> -
>  	.initialize = rk_tsadcv2_initialize,
>  	.irq_ack = rk_tsadcv3_irq_ack,
>  	.control = rk_tsadcv3_control,
> @@ -1159,7 +1151,6 @@ static const struct rockchip_tsadc_chip
> rk3228_tsadc_data = {
>  	.set_alarm_temp = rk_tsadcv2_alarm_temp,
>  	.set_tshut_temp = rk_tsadcv2_tshut_temp,
>  	.set_tshut_mode = rk_tsadcv2_tshut_mode,
> -
>  	.table = {
>  		.id = rk3228_code_table,
>  		.length = ARRAY_SIZE(rk3228_code_table),
> @@ -1172,11 +1163,9 @@ static const struct rockchip_tsadc_chip
> rk3288_tsadc_data = {
>  	/* cpu, gpu */
>  	.chn_offset = 1,
>  	.chn_num = 2, /* two channels for tsadc */
> -
>  	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
>  	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
>  	.tshut_temp = 95000,
> -
>  	.initialize = rk_tsadcv2_initialize,
>  	.irq_ack = rk_tsadcv2_irq_ack,
>  	.control = rk_tsadcv2_control,
> @@ -1184,7 +1173,6 @@ static const struct rockchip_tsadc_chip
> rk3288_tsadc_data = {
>  	.set_alarm_temp = rk_tsadcv2_alarm_temp,
>  	.set_tshut_temp = rk_tsadcv2_tshut_temp,
>  	.set_tshut_mode = rk_tsadcv2_tshut_mode,
> -
>  	.table = {
>  		.id = rk3288_code_table,
>  		.length = ARRAY_SIZE(rk3288_code_table),
> @@ -1197,10 +1185,8 @@ static const struct rockchip_tsadc_chip
> rk3328_tsadc_data = {
>  	/* cpu */
>  	.chn_offset = 0,
>  	.chn_num = 1, /* one channels for tsadc */
> -
>  	.tshut_mode = TSHUT_MODE_CRU, /* default TSHUT via CRU */
>  	.tshut_temp = 95000,
> -
>  	.initialize = rk_tsadcv2_initialize,
>  	.irq_ack = rk_tsadcv3_irq_ack,
>  	.control = rk_tsadcv3_control,
> @@ -1208,7 +1194,6 @@ static const struct rockchip_tsadc_chip
> rk3328_tsadc_data = {
>  	.set_alarm_temp = rk_tsadcv2_alarm_temp,
>  	.set_tshut_temp = rk_tsadcv2_tshut_temp,
>  	.set_tshut_mode = rk_tsadcv2_tshut_mode,
> -
>  	.table = {
>  		.id = rk3328_code_table,
>  		.length = ARRAY_SIZE(rk3328_code_table),
> @@ -1221,11 +1206,9 @@ static const struct rockchip_tsadc_chip
> rk3366_tsadc_data = {
>  	/* cpu, gpu */
>  	.chn_offset = 0,
>  	.chn_num = 2, /* two channels for tsadc */
> -
>  	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
>  	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
>  	.tshut_temp = 95000,
> -
>  	.initialize = rk_tsadcv3_initialize,
>  	.irq_ack = rk_tsadcv3_irq_ack,
>  	.control = rk_tsadcv3_control,
> @@ -1233,7 +1216,6 @@ static const struct rockchip_tsadc_chip
> rk3366_tsadc_data = {
>  	.set_alarm_temp = rk_tsadcv2_alarm_temp,
>  	.set_tshut_temp = rk_tsadcv2_tshut_temp,
>  	.set_tshut_mode = rk_tsadcv2_tshut_mode,
> -
>  	.table = {
>  		.id = rk3228_code_table,
>  		.length = ARRAY_SIZE(rk3228_code_table),
> @@ -1246,11 +1228,9 @@ static const struct rockchip_tsadc_chip
> rk3368_tsadc_data = {
>  	/* cpu, gpu */
>  	.chn_offset = 0,
>  	.chn_num = 2, /* two channels for tsadc */
> -
>  	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
>  	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
>  	.tshut_temp = 95000,
> -
>  	.initialize = rk_tsadcv2_initialize,
>  	.irq_ack = rk_tsadcv2_irq_ack,
>  	.control = rk_tsadcv2_control,
> @@ -1258,7 +1238,6 @@ static const struct rockchip_tsadc_chip
> rk3368_tsadc_data = {
>  	.set_alarm_temp = rk_tsadcv2_alarm_temp,
>  	.set_tshut_temp = rk_tsadcv2_tshut_temp,
>  	.set_tshut_mode = rk_tsadcv2_tshut_mode,
> -
>  	.table = {
>  		.id = rk3368_code_table,
>  		.length = ARRAY_SIZE(rk3368_code_table),
> @@ -1271,11 +1250,9 @@ static const struct rockchip_tsadc_chip
> rk3399_tsadc_data = {
>  	/* cpu, gpu */
>  	.chn_offset = 0,
>  	.chn_num = 2, /* two channels for tsadc */
> -
>  	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
>  	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
>  	.tshut_temp = 95000,
> -
>  	.initialize = rk_tsadcv3_initialize,
>  	.irq_ack = rk_tsadcv3_irq_ack,
>  	.control = rk_tsadcv3_control,
> @@ -1283,7 +1260,6 @@ static const struct rockchip_tsadc_chip
> rk3399_tsadc_data = {
>  	.set_alarm_temp = rk_tsadcv2_alarm_temp,
>  	.set_tshut_temp = rk_tsadcv2_tshut_temp,
>  	.set_tshut_mode = rk_tsadcv2_tshut_mode,
> -
>  	.table = {
>  		.id = rk3399_code_table,
>  		.length = ARRAY_SIZE(rk3399_code_table),
> @@ -1296,11 +1272,9 @@ static const struct rockchip_tsadc_chip
> rk3568_tsadc_data = {
>  	/* cpu, gpu */
>  	.chn_offset = 0,
>  	.chn_num = 2, /* two channels for tsadc */
> -
>  	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
>  	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
>  	.tshut_temp = 95000,
> -
>  	.initialize = rk_tsadcv7_initialize,
>  	.irq_ack = rk_tsadcv3_irq_ack,
>  	.control = rk_tsadcv3_control,
> @@ -1308,7 +1282,6 @@ static const struct rockchip_tsadc_chip
> rk3568_tsadc_data = {
>  	.set_alarm_temp = rk_tsadcv2_alarm_temp,
>  	.set_tshut_temp = rk_tsadcv2_tshut_temp,
>  	.set_tshut_mode = rk_tsadcv2_tshut_mode,
> -
>  	.table = {
>  		.id = rk3568_code_table,
>  		.length = ARRAY_SIZE(rk3568_code_table),

