Return-Path: <linux-pm+bounces-27846-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C323AC8A27
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 10:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7703CA22C90
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 08:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEE021B90B;
	Fri, 30 May 2025 08:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lZoPuwpa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C9821ABC1
	for <linux-pm@vger.kernel.org>; Fri, 30 May 2025 08:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748594909; cv=none; b=kA6c0KIi7FxyOxnWCjBc9FignELTwwuyfmXyaSXt06LgxNDW2O8gC3zt/hvmQsOWdGEs4TSMf10zI1w99pysmDxKBVj11w55opTOfP4nFnf5yOedaUT505KaVzLn9N22bTfnR67bX5EU94JXlFdW74vwl9CGIBKRU/yhHDnktVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748594909; c=relaxed/simple;
	bh=D46erJa1hDlfl78bbCvumBIwf11Orw9oayL8XK4PtbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nA1cWIUy1eonM2GhH6MNji36Yv8YAdSipxzQnwL8+s7s2rpEQmRUABwjH1Juzp6o2M+17ymOMq37w9ARDghy+bOzTIDN2/N6TPJcn7yy3OKIkYchzWkDEZpeBPd34BJ+YTdZcTXWrxLR1R+HLQ1buBSsI8Lc6SMLZOWpfWjilRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lZoPuwpa; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a4dc0f164fso1701781f8f.3
        for <linux-pm@vger.kernel.org>; Fri, 30 May 2025 01:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748594905; x=1749199705; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2FF94acC02KXHXPQmhhdghAhcPWaDPTPL3VB4RqaEg0=;
        b=lZoPuwpa4FPdECB3pj8VahVJpHd51iI/J6kX5AnqeSXSp0TwEk8ZtFc/F2BG0V5+IT
         VAJ8kg12sRJznDE8W9vPsnv6k68PTekChWyTmm3iI0GIc76ob6nilJ5VUPcB1YyJZ5+R
         7DK9i2pBWylUm7zIfWcJwaT8d8f/oUkasNb7CU6GYn5MMqtLPOnDnnWd/h2ZFqdjrkgN
         HdY9fPYIujQXMuprPTLbrzlLBly3oWVVWI2VszG0zi/dTaCWZeSnzQP0BidvCgltRriy
         ZRR0hMrkBO3oSMt6qT7LuHIJh3PNyBd20oehfKjakhaRSv6v+cGj2GFbH6YWVdO0MO9W
         d8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748594905; x=1749199705;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2FF94acC02KXHXPQmhhdghAhcPWaDPTPL3VB4RqaEg0=;
        b=RzuCC2UK/A0zN/coF/FGmj83xIZvUt2VFvfORGgFIY/ZwpR3aAUHXMBFHaPZ6f1kdW
         xIh0LfuqAQgBkdCGo1oHGF/2IT5zeE4FasiMEcajJ3G7Mm23K/Sq9V1GPziyUFQv0+9O
         VoV3JYmaHChRGZ83EyiQ0arAacnfmfTJf8qEu6pO/UzRLWTRSz808NyxVE+vrVOsvRga
         TRDVC+5XjSYhaL8ebznKYyMznhca7+jkWTjvdwT4KZMhIBd45fzZO07FjnPD8zNxKmTj
         CJuKke1ljKqrO1smcQZKQnR9BJH73Hq2aNUwVRW/P5MPSTJIWLOYYUd3NC/tmqSfD9Mn
         CDPA==
X-Forwarded-Encrypted: i=1; AJvYcCUcW/d0vkEcLbiHjFOKZpblZXaE0aL6imUk8F6GgVl/d6wr7RQDu22V8x1FsT0L8I8HixkeB74EIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlJ7/QfZAKa/irsqgdkNBoIlF9Bjfig9zC+Dw2JKxWC7mh5Izk
	u6MjCa/mPiWF33PKf4CFO8CO4ElGgkpzp9tncrnbGeXCBV+Fmiv5klcg0QcEi3sxLw0=
X-Gm-Gg: ASbGncs9RBYBOjgrDcs31akEVYQ8h9SnLAI1XEZoPwNClGRNKeXIy76LS5E43L9uLJ1
	QQQIs1KFo6s/OtfbqoUt1MgxJ8geUWy6if4VUi2azCMNflUey1K5ztnuKX0mjuk4Mh1TdxJWMgs
	RpAMhBFu/wgI3IoCn6JPguz0Fz0dd765XkrNWNYa7V0IA9VcqmL93tU+sOOgZ6IVpndxm4BbeRQ
	GDtOur/cS0W3l4RwWB3dJQaESyzbU8MRwedeoO7yp7iebAVi7+ge/zeQ46zc9ml1LuBkVNTSCKI
	scDsAy2+KMhRsbuy3QKWw2lUutXcYiVFVltM/HWsqvvCznRYG52GKfK6sLkdZhom8NmtjEuDDSf
	VWUcOUWW0F0YneSk3G5YWg5lA5VQ=
X-Google-Smtp-Source: AGHT+IFvcFNB62OxE7MIDiidAN2Mv/BdtuQ0G91swbi4nnUSB4ekkNNovaQmQRzoZEkSDncgY+MwZw==
X-Received: by 2002:a05:6000:4009:b0:3a4:dfa5:325e with SMTP id ffacd0b85a97d-3a4f7a438e5mr1975523f8f.10.1748594904489;
        Fri, 30 May 2025 01:48:24 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe7440asm4317227f8f.58.2025.05.30.01.48.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 01:48:23 -0700 (PDT)
Message-ID: <8b396edf-e344-47e9-b497-3f7fb35783ed@linaro.org>
Date: Fri, 30 May 2025 09:48:22 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] power: supply: qcom_battmgr: Add charge control
 support
To: fenglin.wu@oss.qualcomm.com, Sebastian Reichel <sre@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
 David Collins <david.collins@oss.qualcomm.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 kernel@oss.qualcomm.com, devicetree@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <20250530-qcom_battmgr_update-v2-0-9e377193a656@oss.qualcomm.com>
 <497BF3hThnrmYe-YHKmdOyZwdjP3ivm1hFYDDy3-HkSOvkCOMVSkokyhb859mcTarGb55Go5nJLfgsc553u7ZA==@protonmail.internalid>
 <20250530-qcom_battmgr_update-v2-5-9e377193a656@oss.qualcomm.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20250530-qcom_battmgr_update-v2-5-9e377193a656@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/05/2025 08:35, Fenglin Wu via B4 Relay wrote:
> From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> 
> Add charge control support for SM8550 and X1E80100. It's supported
> with below two power supply properties:
> 
> charge_control_end_threshold: SOC threshold at which the charging
> should be terminated.
> 
> charge_control_start_threshold: SOC threshold at which the charging
> should be resumed.

Maybe this is very obvious to battery charger experts but what does SOC 
mean here ?

Reading your patch you pass a "int soc" and compare it to a threshold 
value, without 'soc' having an obvious meaning.

Its a threshold right ? Why not just call it threshold ?

> 
> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> ---
>   drivers/power/supply/qcom_battmgr.c | 256 ++++++++++++++++++++++++++++++++++--
>   1 file changed, 248 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
> index d5d0200b92bdc3d9a22f44159ad45b152efe8be0..39009415f4bfcd76b010305179d3c8fb847254a6 100644
> --- a/drivers/power/supply/qcom_battmgr.c
> +++ b/drivers/power/supply/qcom_battmgr.c
> @@ -21,6 +21,8 @@
>   enum qcom_battmgr_variant {
>   	QCOM_BATTMGR_SM8350,
>   	QCOM_BATTMGR_SC8280XP,
> +	QCOM_BATTMGR_X1E80100,
> +	QCOM_BATTMGR_SM8550,
You're breaking ordering here.

Well the ordering is already broken but, please sort this list 
alphanumerically.

>   };
> 
>   #define BATTMGR_BAT_STATUS		0x1
> @@ -66,6 +68,9 @@ enum qcom_battmgr_variant {
>   #define BATT_RESISTANCE			21
>   #define BATT_POWER_NOW			22
>   #define BATT_POWER_AVG			23
> +#define BATT_CHG_CTRL_EN		24
> +#define BATT_CHG_CTRL_START_THR		25
> +#define BATT_CHG_CTRL_END_THR		26
> 
>   #define BATTMGR_USB_PROPERTY_GET	0x32
>   #define BATTMGR_USB_PROPERTY_SET	0x33
> @@ -90,6 +95,13 @@ enum qcom_battmgr_variant {
>   #define WLS_TYPE			5
>   #define WLS_BOOST_EN			6
> 
> +#define BATTMGR_CHG_CTRL_LIMIT_EN	0x48
> +#define CHARGE_CTRL_START_THR_MIN	50
> +#define CHARGE_CTRL_START_THR_MAX	95
> +#define CHARGE_CTRL_END_THR_MIN		55
> +#define CHARGE_CTRL_END_THR_MAX		100
> +#define CHARGE_CTRL_DELTA_SOC		5
> +
>   struct qcom_battmgr_enable_request {
>   	struct pmic_glink_hdr hdr;
>   	__le32 battery_id;
> @@ -124,6 +136,13 @@ struct qcom_battmgr_discharge_time_request {
>   	__le32 reserved;
>   };
> 
> +struct qcom_battmgr_charge_ctrl_request {
> +	struct pmic_glink_hdr hdr;
> +	__le32 enable;
> +	__le32 target_soc;
> +	__le32 delta_soc;
> +};
> +
>   struct qcom_battmgr_message {
>   	struct pmic_glink_hdr hdr;
>   	union {
> @@ -236,6 +255,8 @@ struct qcom_battmgr_info {
>   	unsigned int capacity_warning;
>   	unsigned int cycle_count;
>   	unsigned int charge_count;
> +	unsigned int charge_ctrl_start;
> +	unsigned int charge_ctrl_end;
>   	char model_number[BATTMGR_STRING_LEN];
>   	char serial_number[BATTMGR_STRING_LEN];
>   	char oem_info[BATTMGR_STRING_LEN];
> @@ -424,6 +445,8 @@ static const u8 sm8350_bat_prop_map[] = {
>   	[POWER_SUPPLY_PROP_RESISTANCE] = BATT_RESISTANCE,
>   	[POWER_SUPPLY_PROP_STATE_OF_HEALTH] = BATT_SOH,
>   	[POWER_SUPPLY_PROP_POWER_NOW] = BATT_POWER_NOW,
> +	[POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD] = BATT_CHG_CTRL_START_THR,
> +	[POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD] = BATT_CHG_CTRL_END_THR,
>   };
> 
>   static int qcom_battmgr_bat_sm8350_update(struct qcom_battmgr *battmgr,
> @@ -494,7 +517,8 @@ static int qcom_battmgr_bat_get_property(struct power_supply *psy,
>   	if (!battmgr->service_up)
>   		return -EAGAIN;
> 
> -	if (battmgr->variant == QCOM_BATTMGR_SC8280XP)
> +	if (battmgr->variant == QCOM_BATTMGR_SC8280XP ||
> +			battmgr->variant == QCOM_BATTMGR_X1E80100)

Please run your series through checkpatch

0004-power-supply-qcom_battmgr-Add-state_of_health-proper.patch has no 
obvious style problems and is ready for submission.
CHECK: Alignment should match open parenthesis
#95: FILE: drivers/power/supply/qcom_battmgr.c:521:
+	if (battmgr->variant == QCOM_BATTMGR_SC8280XP ||
+			battmgr->variant == QCOM_BATTMGR_X1E80100)

CHECK: Alignment should match open parenthesis
#137: FILE: drivers/power/supply/qcom_battmgr.c:678:
+	if (soc < CHARGE_CTRL_START_THR_MIN ||
+			soc > CHARGE_CTRL_START_THR_MAX) {

CHECK: Alignment should match open parenthesis
#139: FILE: drivers/power/supply/qcom_battmgr.c:680:
+		dev_err(battmgr->dev, "charge control start threshold exceed range: 
[%u - %u]\n",
+				CHARGE_CTRL_START_THR_MIN, CHARGE_CTRL_START_THR_MAX);

CHECK: Alignment should match open parenthesis
#175: FILE: drivers/power/supply/qcom_battmgr.c:716:
+	if (soc < CHARGE_CTRL_END_THR_MIN ||
+			soc > CHARGE_CTRL_END_THR_MAX) {

CHECK: Alignment should match open parenthesis
#177: FILE: drivers/power/supply/qcom_battmgr.c:718:
+		dev_err(battmgr->dev, "charge control end threshold exceed range: [%u 
- %u]\n",
+				CHARGE_CTRL_END_THR_MIN, CHARGE_CTRL_END_THR_MAX);

CHECK: Alignment should match open parenthesis
#196: FILE: drivers/power/supply/qcom_battmgr.c:737:
+static int qcom_battmgr_bat_is_writeable(struct power_supply *psy,
+				enum power_supply_property psp)

CHECK: Alignment should match open parenthesis
#210: FILE: drivers/power/supply/qcom_battmgr.c:751:
+static int qcom_battmgr_bat_set_property(struct power_supply *psy,
+			enum power_supply_property psp,

CHECK: Alignment should match open parenthesis
#326: FILE: drivers/power/supply/qcom_battmgr.c:985:
+	if (battmgr->variant == QCOM_BATTMGR_SC8280XP ||
+			battmgr->variant == QCOM_BATTMGR_X1E80100)

CHECK: Alignment should match open parenthesis
#336: FILE: drivers/power/supply/qcom_battmgr.c:1108:
+	if (battmgr->variant == QCOM_BATTMGR_SC8280XP ||
+			battmgr->variant == QCOM_BATTMGR_X1E80100)

CHECK: Alignment should match open parenthesis
#367: FILE: drivers/power/supply/qcom_battmgr.c:1527:
+	else if (battmgr->variant == QCOM_BATTMGR_SC8280XP ||
+			battmgr->variant == QCOM_BATTMGR_X1E80100)

CHECK: Alignment should match open parenthesis
#396: FILE: drivers/power/supply/qcom_battmgr.c:1606:
+	if (battmgr->variant == QCOM_BATTMGR_SC8280XP ||
+			battmgr->variant == QCOM_BATTMGR_X1E80100) {


>   		ret = qcom_battmgr_bat_sc8280xp_update(battmgr, psp);
>   	else
>   		ret = qcom_battmgr_bat_sm8350_update(battmgr, psp);
> @@ -599,6 +623,12 @@ static int qcom_battmgr_bat_get_property(struct power_supply *psy,
>   	case POWER_SUPPLY_PROP_TIME_TO_FULL_AVG:
>   		val->intval = battmgr->status.charge_time;
>   		break;
> +	case POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD:
> +		val->intval = battmgr->info.charge_ctrl_start;
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
> +		val->intval = battmgr->info.charge_ctrl_end;
> +		break;
>   	case POWER_SUPPLY_PROP_MANUFACTURE_YEAR:
>   		val->intval = battmgr->info.year;
>   		break;
> @@ -624,6 +654,120 @@ static int qcom_battmgr_bat_get_property(struct power_supply *psy,
>   	return 0;
>   }
> 
> +static int qcom_battmgr_set_charge_control(struct qcom_battmgr *battmgr,
> +					   u32 target_soc, u32 delta_soc)
> +{
> +	struct qcom_battmgr_charge_ctrl_request request = {
> +		.hdr.owner = cpu_to_le32(PMIC_GLINK_OWNER_BATTMGR),
> +		.hdr.type = cpu_to_le32(PMIC_GLINK_REQ_RESP),
> +		.hdr.opcode = cpu_to_le32(BATTMGR_CHG_CTRL_LIMIT_EN),
> +		.enable = cpu_to_le32(1),
> +		.target_soc = cpu_to_le32(target_soc),
> +		.delta_soc = cpu_to_le32(delta_soc),
> +	};
> +
> +	return qcom_battmgr_request(battmgr, &request, sizeof(request));
> +}
> +
> +static int qcom_battmgr_set_charge_start_threshold(struct qcom_battmgr *battmgr, int soc)
> +{
> +	u32 target_soc, delta_soc;
> +	int ret;
> +
> +	if (soc < CHARGE_CTRL_START_THR_MIN ||
> +			soc > CHARGE_CTRL_START_THR_MAX) {
> +		dev_err(battmgr->dev, "charge control start threshold exceed range: [%u - %u]\n",
> +				CHARGE_CTRL_START_THR_MIN, CHARGE_CTRL_START_THR_MAX);
> +		return -EINVAL;
> +	}

'soc' is what - a threshold as far as I can tell.

> +
> +	/*
> +	 * If the new start threshold is larger than the old end threshold,
> +	 * move the end threshold one step (DELTA_SOC) after the new start
> +	 * threshold.
> +	 */
> +	if (soc > battmgr->info.charge_ctrl_end) {
> +		target_soc = soc + CHARGE_CTRL_DELTA_SOC;
> +		target_soc = min_t(u32, target_soc, CHARGE_CTRL_END_THR_MAX);
> +		delta_soc = target_soc - soc;
> +		delta_soc = min_t(u32, delta_soc, CHARGE_CTRL_DELTA_SOC);
> +	} else {
> +		target_soc =  battmgr->info.charge_ctrl_end;
> +		delta_soc = battmgr->info.charge_ctrl_end - soc;
> +	}
> +
> +	mutex_lock(&battmgr->lock);
> +	ret = qcom_battmgr_set_charge_control(battmgr, target_soc, delta_soc);
> +	mutex_unlock(&battmgr->lock);
> +	if (!ret) {
> +		battmgr->info.charge_ctrl_start = soc;
> +		battmgr->info.charge_ctrl_end = target_soc;
> +	}
> +
> +	return 0;
> +}
> +
> +static int qcom_battmgr_set_charge_end_threshold(struct qcom_battmgr *battmgr, int soc)
> +{
> +	u32 delta_soc = CHARGE_CTRL_DELTA_SOC;
> +	int ret;
> +
> +	if (soc < CHARGE_CTRL_END_THR_MIN ||
> +			soc > CHARGE_CTRL_END_THR_MAX) {
> +		dev_err(battmgr->dev, "charge control end threshold exceed range: [%u - %u]\n",
> +				CHARGE_CTRL_END_THR_MIN, CHARGE_CTRL_END_THR_MAX);
> +		return -EINVAL;
> +	}
> +
> +	if (battmgr->info.charge_ctrl_start && soc > battmgr->info.charge_ctrl_start)
> +		delta_soc = soc - battmgr->info.charge_ctrl_start;
> +
> +	mutex_lock(&battmgr->lock);
> +	ret = qcom_battmgr_set_charge_control(battmgr, soc, delta_soc);
> +	mutex_unlock(&battmgr->lock);
> +	if (!ret) {
> +		battmgr->info.charge_ctrl_start = soc - delta_soc;
> +		battmgr->info.charge_ctrl_end = soc;
> +	}
> +
> +	return 0;
> +}
> +
> +static int qcom_battmgr_bat_is_writeable(struct power_supply *psy,
> +				enum power_supply_property psp)
> +{
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD:
> +	case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
> +		return 1;
> +	default:
> +		return 0;
> +	}
> +
> +	return 0;
> +}
> +
> +static int qcom_battmgr_bat_set_property(struct power_supply *psy,
> +			enum power_supply_property psp,
> +			const union power_supply_propval *pval)
> +{
> +	struct qcom_battmgr *battmgr = power_supply_get_drvdata(psy);
> +
> +	if (!battmgr->service_up)
> +		return -EAGAIN;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD:
> +		return qcom_battmgr_set_charge_start_threshold(battmgr, pval->intval);
> +	case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
> +		return qcom_battmgr_set_charge_end_threshold(battmgr, pval->intval);
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>   static const enum power_supply_property sc8280xp_bat_props[] = {
>   	POWER_SUPPLY_PROP_STATUS,
>   	POWER_SUPPLY_PROP_PRESENT,
> @@ -657,6 +801,43 @@ static const struct power_supply_desc sc8280xp_bat_psy_desc = {
>   	.get_property = qcom_battmgr_bat_get_property,
>   };
> 
> +static const enum power_supply_property x1e80100_bat_props[] = {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_TECHNOLOGY,
> +	POWER_SUPPLY_PROP_CYCLE_COUNT,
> +	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_POWER_NOW,
> +	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> +	POWER_SUPPLY_PROP_CHARGE_FULL,
> +	POWER_SUPPLY_PROP_CHARGE_EMPTY,
> +	POWER_SUPPLY_PROP_CHARGE_NOW,
> +	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
> +	POWER_SUPPLY_PROP_ENERGY_FULL,
> +	POWER_SUPPLY_PROP_ENERGY_EMPTY,
> +	POWER_SUPPLY_PROP_ENERGY_NOW,
> +	POWER_SUPPLY_PROP_TEMP,
> +	POWER_SUPPLY_PROP_MANUFACTURE_YEAR,
> +	POWER_SUPPLY_PROP_MANUFACTURE_MONTH,
> +	POWER_SUPPLY_PROP_MANUFACTURE_DAY,
> +	POWER_SUPPLY_PROP_MODEL_NAME,
> +	POWER_SUPPLY_PROP_MANUFACTURER,
> +	POWER_SUPPLY_PROP_SERIAL_NUMBER,
> +	POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD,
> +	POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD,
> +};
> +
> +static const struct power_supply_desc x1e80100_bat_psy_desc = {
> +	.name = "qcom-battmgr-bat",
> +	.type = POWER_SUPPLY_TYPE_BATTERY,
> +	.properties = x1e80100_bat_props,
> +	.num_properties = ARRAY_SIZE(x1e80100_bat_props),
> +	.get_property = qcom_battmgr_bat_get_property,
> +	.set_property = qcom_battmgr_bat_set_property,
> +	.property_is_writeable = qcom_battmgr_bat_is_writeable,
> +};
> +
>   static const enum power_supply_property sm8350_bat_props[] = {
>   	POWER_SUPPLY_PROP_STATUS,
>   	POWER_SUPPLY_PROP_HEALTH,
> @@ -689,6 +870,42 @@ static const struct power_supply_desc sm8350_bat_psy_desc = {
>   	.get_property = qcom_battmgr_bat_get_property,
>   };
> 
> +static const enum power_supply_property sm8550_bat_props[] = {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_CHARGE_TYPE,
> +	POWER_SUPPLY_PROP_CAPACITY,
> +	POWER_SUPPLY_PROP_VOLTAGE_OCV,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_VOLTAGE_MAX,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_TEMP,
> +	POWER_SUPPLY_PROP_TECHNOLOGY,
> +	POWER_SUPPLY_PROP_CHARGE_COUNTER,
> +	POWER_SUPPLY_PROP_CYCLE_COUNT,
> +	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> +	POWER_SUPPLY_PROP_CHARGE_FULL,
> +	POWER_SUPPLY_PROP_MODEL_NAME,
> +	POWER_SUPPLY_PROP_TIME_TO_FULL_AVG,
> +	POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG,
> +	POWER_SUPPLY_PROP_RESISTANCE,
> +	POWER_SUPPLY_PROP_STATE_OF_HEALTH,
> +	POWER_SUPPLY_PROP_POWER_NOW,
> +	POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD,
> +	POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD,
> +};
> +
> +static const struct power_supply_desc sm8550_bat_psy_desc = {
> +	.name = "qcom-battmgr-bat",
> +	.type = POWER_SUPPLY_TYPE_BATTERY,
> +	.properties = sm8550_bat_props,
> +	.num_properties = ARRAY_SIZE(sm8550_bat_props),
> +	.get_property = qcom_battmgr_bat_get_property,
> +	.set_property = qcom_battmgr_bat_set_property,
> +	.property_is_writeable = qcom_battmgr_bat_is_writeable,
> +};
> +
>   static int qcom_battmgr_ac_get_property(struct power_supply *psy,
>   					enum power_supply_property psp,
>   					union power_supply_propval *val)
> @@ -764,7 +981,8 @@ static int qcom_battmgr_usb_get_property(struct power_supply *psy,
>   	if (!battmgr->service_up)
>   		return -EAGAIN;
> 
> -	if (battmgr->variant == QCOM_BATTMGR_SC8280XP)
> +	if (battmgr->variant == QCOM_BATTMGR_SC8280XP ||
> +			battmgr->variant == QCOM_BATTMGR_X1E80100)
>   		ret = qcom_battmgr_bat_sc8280xp_update(battmgr, psp);
>   	else
>   		ret = qcom_battmgr_usb_sm8350_update(battmgr, psp);
> @@ -886,7 +1104,8 @@ static int qcom_battmgr_wls_get_property(struct power_supply *psy,
>   	if (!battmgr->service_up)
>   		return -EAGAIN;
> 
> -	if (battmgr->variant == QCOM_BATTMGR_SC8280XP)
> +	if (battmgr->variant == QCOM_BATTMGR_SC8280XP ||
> +			battmgr->variant == QCOM_BATTMGR_X1E80100)
>   		ret = qcom_battmgr_bat_sc8280xp_update(battmgr, psp);
>   	else
>   		ret = qcom_battmgr_wls_sm8350_update(battmgr, psp);
> @@ -1196,6 +1415,12 @@ static void qcom_battmgr_sm8350_callback(struct qcom_battmgr *battmgr,
>   		case BATT_POWER_NOW:
>   			battmgr->status.power_now = le32_to_cpu(resp->intval.value);
>   			break;
> +		case BATT_CHG_CTRL_START_THR:
> +			battmgr->info.charge_ctrl_start = le32_to_cpu(resp->intval.value);
> +			break;
> +		case BATT_CHG_CTRL_END_THR:
> +			battmgr->info.charge_ctrl_end = le32_to_cpu(resp->intval.value);
> +			break;
>   		default:
>   			dev_warn(battmgr->dev, "unknown property %#x\n", property);
>   			break;
> @@ -1278,6 +1503,7 @@ static void qcom_battmgr_sm8350_callback(struct qcom_battmgr *battmgr,
>   		}
>   		break;
>   	case BATTMGR_REQUEST_NOTIFICATION:
> +	case BATTMGR_CHG_CTRL_LIMIT_EN:
>   		battmgr->error = 0;
>   		break;
>   	default:
> @@ -1297,7 +1523,8 @@ static void qcom_battmgr_callback(const void *data, size_t len, void *priv)
> 
>   	if (opcode == BATTMGR_NOTIFICATION)
>   		qcom_battmgr_notification(battmgr, data, len);
> -	else if (battmgr->variant == QCOM_BATTMGR_SC8280XP)
> +	else if (battmgr->variant == QCOM_BATTMGR_SC8280XP ||
> +			battmgr->variant == QCOM_BATTMGR_X1E80100)
>   		qcom_battmgr_sc8280xp_callback(battmgr, data, len);
>   	else
>   		qcom_battmgr_sm8350_callback(battmgr, data, len);
> @@ -1333,7 +1560,8 @@ static void qcom_battmgr_pdr_notify(void *priv, int state)
>   static const struct of_device_id qcom_battmgr_of_variants[] = {
>   	{ .compatible = "qcom,sc8180x-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
>   	{ .compatible = "qcom,sc8280xp-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
> -	{ .compatible = "qcom,x1e80100-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
> +	{ .compatible = "qcom,x1e80100-pmic-glink", .data = (void *)QCOM_BATTMGR_X1E80100 },
> +	{ .compatible = "qcom,sm8550-pmic-glink", .data = (void *)QCOM_BATTMGR_SM8550 },

Please separate compat string addition from functional changes.

>   	/* Unmatched devices falls back to QCOM_BATTMGR_SM8350 */
>   	{}
>   };
> @@ -1343,6 +1571,7 @@ static char *qcom_battmgr_battery[] = { "battery" };
>   static int qcom_battmgr_probe(struct auxiliary_device *adev,
>   			      const struct auxiliary_device_id *id)
>   {
> +	const struct power_supply_desc *psy_desc;
>   	struct power_supply_config psy_cfg_supply = {};
>   	struct power_supply_config psy_cfg = {};
>   	const struct of_device_id *match;
> @@ -1373,8 +1602,14 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
>   	else
>   		battmgr->variant = QCOM_BATTMGR_SM8350;
> 
> -	if (battmgr->variant == QCOM_BATTMGR_SC8280XP) {
> -		battmgr->bat_psy = devm_power_supply_register(dev, &sc8280xp_bat_psy_desc, &psy_cfg);
> +	if (battmgr->variant == QCOM_BATTMGR_SC8280XP ||
> +			battmgr->variant == QCOM_BATTMGR_X1E80100) {
> +		if (battmgr->variant == QCOM_BATTMGR_X1E80100)
> +			psy_desc = &x1e80100_bat_psy_desc;
> +		else
> +			psy_desc = &sc8280xp_bat_psy_desc;
> +
> +		battmgr->bat_psy = devm_power_supply_register(dev, psy_desc, &psy_cfg);
>   		if (IS_ERR(battmgr->bat_psy))
>   			return dev_err_probe(dev, PTR_ERR(battmgr->bat_psy),
>   					     "failed to register battery power supply\n");
> @@ -1394,7 +1629,12 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
>   			return dev_err_probe(dev, PTR_ERR(battmgr->wls_psy),
>   					     "failed to register wireless charing power supply\n");
>   	} else {
> -		battmgr->bat_psy = devm_power_supply_register(dev, &sm8350_bat_psy_desc, &psy_cfg);
> +		if (battmgr->variant == QCOM_BATTMGR_SM8550)
> +			psy_desc = &sm8550_bat_psy_desc;
> +		else
> +			psy_desc = &sm8350_bat_psy_desc;
> +
> +		battmgr->bat_psy = devm_power_supply_register(dev, psy_desc, &psy_cfg);
>   		if (IS_ERR(battmgr->bat_psy))
>   			return dev_err_probe(dev, PTR_ERR(battmgr->bat_psy),
>   					     "failed to register battery power supply\n");
> 
> --
> 2.34.1
> 
> 
> 


