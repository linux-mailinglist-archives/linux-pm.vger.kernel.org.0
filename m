Return-Path: <linux-pm+bounces-8570-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A77958FB1B5
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 14:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F7361F24EED
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 12:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E346113CF98;
	Tue,  4 Jun 2024 12:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="q2iURE3A"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D036A6FC3;
	Tue,  4 Jun 2024 12:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717502532; cv=none; b=UddNzaduNM6SbEbOuE3Vq+UUMxGwQc+HuCNFFP11/6E6rjuGDAl4F3CYi4vcsph0pFx1DeFAfhGoJLMWVX/LYAH+YsqjqeVC5S+tOdiXwCzrRdS1SP19/CQV+vJS9SxfPd4jndsISwumGiPVFOFVFxxAZ2zeUYUhu2CFMWLhejA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717502532; c=relaxed/simple;
	bh=RPokp8KoGwM0k25xUQr9w8oEeLy2cIEiE4e2CbX+uf8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=J8vRWzfXvTW3HDZ2skIlzelG9Muo1RuTj+e4/Gv0hQlDVN68whgB5OUgfidhaqJJpJL2q1XXPUg4spTog0TeBqLl79c2z3S2ZTGBVuvP4fblE11k4Ez2tPA7eztp8Htodeuh5ICMH87Htu1tcoIH/caOCVxcqoDW1QgFmllKk4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=q2iURE3A; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1717502524; x=1718107324; i=w_armin@gmx.de;
	bh=DYfX5asiSQ5TGa/Edpy4+l0LBbjxyMvWoqp83X0yK/o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=q2iURE3AXuGiBlDreeV4hiQrh4qjTnIujmX/eoZsfHQyipSjAiFPyFLA8+25sTmj
	 Q6SI6Tt6HwLLoe61AhrAU+IhaKzBpg4YpskHIdBMjwmJtR//diLUTgFmsMcLcpxsR
	 jNDKUkcEvo7ER9Wmg9dI2QVSmtTRpLN9lh+8c3ZVYfPW20KA4xFOufh0yxnmb50yC
	 vRjw/IgLUXUjGr6GgFG+GmoqhYS5lVmdlChInQojBFoYiFaECLkTUnyQAOpGBhH5L
	 pclWV8Z65+NIPt795V99vGPrpLIvQIwaaHlFyZQhtQtn0qthAm+MdfBkcjrhEZUYx
	 oD2k+IkoQkvZcbCmEg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.104.27] ([141.76.182.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8ofO-1sZ4dW1Emc-015tvq; Tue, 04
 Jun 2024 14:02:04 +0200
Message-ID: <dbb9dfe5-8812-482a-b384-8e86e0a8eb8f@gmx.de>
Date: Tue, 4 Jun 2024 14:02:02 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: supply: hwmon: Add support for power sensors
From: Armin Wolf <W_Armin@gmx.de>
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240528222115.791511-1-W_Armin@gmx.de>
Content-Language: en-US
In-Reply-To: <20240528222115.791511-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:MogaJJ0Q6ymVcMiBnjZyHWDa/2IRqoo4Z4nqDkkQiwwZqmUvn1g
 ieC0a2IavPQiaBTaCgM+ZqauO8ABVQ/1Rw34wzWNou4MsV9F5eHmvCfFdCqoviB6TcsaLYe
 XqcqTW5GLrFlbwkasO2tHSRVVgHt+bHpOIsG4j1aqjFZCyL5imrhR84Mk8AVfqOJqVsCFoA
 pZiEc6NBpqeaEV5Se8JiQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iT6Rdzp9fZk=;MgFU7dgpZqTBoBPmsFhNCV8J163
 D3BtPVx6vp9dGvWv1/098HAfNW42tuvLwVRlhDkJnwNSGF89nnSQUs/CtZJTmjl9NKWWkBdOa
 nse9igQ9no5HpeBP8NHh3Jg2v1SyVD+OSbJ3gwC1yVG44PGBxIwDvUdBArY/CYXTyfgu1uZII
 nuSwoQhYgyczUza+9UJjBxNu305THAuZ0mzcDYzcn3wVvW1kH1w7wjfh1aXCQh/5vLW1u1AzX
 iIZCu6IeXLOmu+7voRsEs1pwwXnAYD69R7eK9wBEQJH6vVvFsYI4kyM8oa+/1zf+/tGPQzg7p
 9oyTMHM7eCIZhaVBHSPfu/vFNMU64c96olFJttbLPWfYDwajXNSSlaSxz3xS949uiYB6uNayf
 Qmmi2p8sIYP47x+pbyMxuDXnSbXKiakq0N8T7ZdWRB/W/j7PgGAXXIMW2lVZfZML60AOnooZP
 KOT8CIVNxpWKRloodY/95k8m8ZoxtzXp0Gcqg9lw1Iw/Q5x4mvEgm4nVkC92IHPnNi8A32oG6
 VkDtgrLlwIbJLnqdIhxL7fzBoTU9ki7IzZItWSzxraZO2txCxtTZOgS5ValGKO330cTCzzWT+
 ov7sY/GOBwz/Tu7zMINHxl7Pa99vztH+O38ACtEnSjDLYjG2528XC5RFKfT1/H9/XGNwYABpE
 /NNc2BK7YTt9rtiSlzXPY/R08SaWVYF/CoF/lI3TEkoHEFtJY7cz5YdcaMoj77tZUe88WNCGg
 PsHKUCblrRAW4vGfELbmvpHJFEJDPOJUvERyJy+/iqwy2rxMDYoO6UR/6Ke5rJLgyEyZeqPqE
 YHF2JiXC+T+v7EzbC53OYY+WTnV74Z1RDFEVCmeXZkAio=

Am 29.05.24 um 00:21 schrieb Armin Wolf:

> Currently, more than seven power supply drivers are supporting
> POWER_SUPPLY_PROP_POWER_NOW, but their power readings are not being
> reported through the hwmon subsystem.
>
> Fix this by adding support for power sensors to the power supply
> hwmon integration.

Hi, what is the status of this patch? Are there any obvious errors which
need to be fixed?

Thanks,
Armin Wolf

> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>   drivers/power/supply/power_supply_hwmon.c | 25 +++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
>
> diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/supply/power_supply_hwmon.c
> index c97893d4c25e..baacefbdf768 100644
> --- a/drivers/power/supply/power_supply_hwmon.c
> +++ b/drivers/power/supply/power_supply_hwmon.c
> @@ -48,6 +48,18 @@ static int power_supply_hwmon_curr_to_property(u32 attr)
>   	}
>   }
>
> +static int power_supply_hwmon_power_to_property(u32 attr)
> +{
> +	switch (attr) {
> +	case hwmon_power_input:
> +		return POWER_SUPPLY_PROP_POWER_NOW;
> +	case hwmon_power_average:
> +		return POWER_SUPPLY_PROP_POWER_AVG;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>   static int power_supply_hwmon_temp_to_property(u32 attr, int channel)
>   {
>   	if (channel) {
> @@ -90,6 +102,8 @@ power_supply_hwmon_to_property(enum hwmon_sensor_types type,
>   		return power_supply_hwmon_in_to_property(attr);
>   	case hwmon_curr:
>   		return power_supply_hwmon_curr_to_property(attr);
> +	case hwmon_power:
> +		return power_supply_hwmon_power_to_property(attr);
>   	case hwmon_temp:
>   		return power_supply_hwmon_temp_to_property(attr, channel);
>   	default:
> @@ -229,6 +243,11 @@ power_supply_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>   	case hwmon_in:
>   		pspval.intval = DIV_ROUND_CLOSEST(pspval.intval, 1000);
>   		break;
> +	case hwmon_power:
> +		/*
> +		 * Power properties are already in microwatts.
> +		 */
> +		break;
>   	/*
>   	 * Temp needs to be converted from 1/10 C to milli-C
>   	 */
> @@ -311,6 +330,10 @@ static const struct hwmon_channel_info * const power_supply_hwmon_info[] = {
>   			   HWMON_C_MAX     |
>   			   HWMON_C_INPUT),
>
> +	HWMON_CHANNEL_INFO(power,
> +			   HWMON_P_INPUT |
> +			   HWMON_P_AVERAGE),
> +
>   	HWMON_CHANNEL_INFO(in,
>   			   HWMON_I_AVERAGE |
>   			   HWMON_I_MIN     |
> @@ -359,6 +382,8 @@ int power_supply_add_hwmon_sysfs(struct power_supply *psy)
>   		case POWER_SUPPLY_PROP_CURRENT_AVG:
>   		case POWER_SUPPLY_PROP_CURRENT_MAX:
>   		case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		case POWER_SUPPLY_PROP_POWER_AVG:
> +		case POWER_SUPPLY_PROP_POWER_NOW:
>   		case POWER_SUPPLY_PROP_TEMP:
>   		case POWER_SUPPLY_PROP_TEMP_MAX:
>   		case POWER_SUPPLY_PROP_TEMP_MIN:
> --
> 2.39.2
>
>

