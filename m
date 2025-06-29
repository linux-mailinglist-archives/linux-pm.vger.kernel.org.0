Return-Path: <linux-pm+bounces-29807-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B8AAED1B5
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 01:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7B9D3A67F7
	for <lists+linux-pm@lfdr.de>; Sun, 29 Jun 2025 23:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716CD23D2BC;
	Sun, 29 Jun 2025 23:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BQJtl6UL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CF822FE10
	for <linux-pm@vger.kernel.org>; Sun, 29 Jun 2025 23:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751238391; cv=none; b=iMz9WrNvj6/qJDzp9nbEHmTXthiTUECj1R5+GcwR2PeF5EuZS4I7OV91VAPKeJWr5b3i2cqp2PaYQsSijGh6c6tJMDUVU03aSG8RLfEKQb7DEq/AwdOjyLEtWZrSYPBXFRcmSuiuTpRQFzAmfOW/BC1pz7S3OX/hnl1BLzHiknc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751238391; c=relaxed/simple;
	bh=fQiO+fvPB2oBbOIOAeTHIauXaUQsCdkQV+KBRdLkydI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sg2b5VE8cKRsdKR/y1TGb81ZrqzaElA8mbtJ7Laq8gZB6RBmUnhARcmCA5X6NtfrSQAGad+PjJGenurE21Jzbi1Rrq4kC66oHx5I9e7XySfxj12bZk4sDGsy2d+lUCnKS+XUhy84I+V4+wcUwVI7SzXtFmM+v/OvQyl5zVutYXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BQJtl6UL; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so25953745e9.1
        for <linux-pm@vger.kernel.org>; Sun, 29 Jun 2025 16:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751238387; x=1751843187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uxuDp6QIueaey7GUSgwQktLT/w2is4ZmWxAVjFySs+k=;
        b=BQJtl6ULw5OVLdD/wAhWHluOBaGZkCQ1s5ysYV4Rg4nptZp1yWZHGfvjuh+Sx3Np9M
         sttxWqO1nwnQNC+9+j2Swmelg3Lux8ECipWBMQdzHzvMrXuhBaRt/DfonFhQ7zxqhbJH
         Na5Hwh66E0ntgETnNrm90xzWWEYUI5S6gJs2dL0Oo/S6FtcyCnJknd4GW/P1ktGiGK7B
         oe7yt4VsiDM993rS1L1fGbhozOgGg1LFmZQgV8k1EwAlR4NN+EVOGqKrKeTOXfBUJK0m
         /ZrKC64u2sj3+eyeLQN6KcIKJb7WX6ginq1pR27VGLBUMd7SKB/pUtSepMV9AeVGK65x
         PULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751238387; x=1751843187;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uxuDp6QIueaey7GUSgwQktLT/w2is4ZmWxAVjFySs+k=;
        b=Zr53KDd1Lje67AfOtc4/i3RzjvQi2vUZ/qgQ/eB75jKqfX8wkXtKnP/Ea7ip7816cR
         tGyMitcXCSJWW4VcqFw73r/6Tow45pmvubDXahH7W+obhPY+9x+oC5MqFyoK5oTb1Iw7
         bPhI+CqyaNamIg+UgwP9/LpNNdtMYNsPm+QZPL92oeN7kLf4XxHmKWIUrETXdtDfwm7R
         RIyREW8Rf/X8A4rF0YRp4FifXvY7aI1r8kJmSTAMQJ1P6cqIeOtPACd6Q9TBv359i49z
         0B4kqi8OqSc8Jt9iiGdBBo9Uqr4G1AxuwJw4+o+opHxtHAV772dDWaksM7Qk8P6r9gGR
         Je1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUj3T8XVfTv4SJquXSCTSutonf1OX5s2uxKMQAh2/dhce7rYrZ0q4AU5JCwld/z9+y29axvwRQwUg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQvvOVafR+5Q85Rv4VUgxFmWebdZlMX5bq/6d2yr9IVIePXBQH
	gjsCBUzwtFN2adOpPEpDxjihVGXzZACAjIQRniQOVVd+agOCFimHtMYKHFaLaj6PI8/ijAXleL0
	mr5XQ
X-Gm-Gg: ASbGncv4IFzto0MlLjvmqju4DetB7fi4tpHTvPGrG0Dg2YVUrW41ZiMIxtH2N4rbPpL
	MfZ2nKQsKWqlvcmOlttPZH91gj+XX4eCOigRZ8xTd7ODeOlsd5tc4bPOxnA79OkEenq59b463sh
	1l+tAjNmNjg5WtD09z8inAOh8ZcesFfWijPzac5jjehYA+Ktiqf9Un39dqzFVwq+CoenXykaAzt
	yb6Sld/Ser1hcvEnCqd9XCeLMwIxoKqYtxTuOAzql+4zPQjWrrsDWInj5vC7d05BbCRm3g1bsYJ
	f3637EoSjjjQ9Ru5B6ziSxNwQammonqfZVWFoxjxtpsc9vA3uRxapkiPec0CunzQJOF6mGykOim
	VjfKyh3I3MC6rr1rJrbtU5wOvxQU=
X-Google-Smtp-Source: AGHT+IF2HE4rnHq996sjWYjKV57QTV3ArWggC/mfk3mKSJWGQ8Ye38IJACkidbow25r2+iRqd3bCtw==
X-Received: by 2002:a05:6000:38a:b0:3a3:7ba5:9a68 with SMTP id ffacd0b85a97d-3a98b53f3ebmr9280430f8f.18.1751238387168;
        Sun, 29 Jun 2025 16:06:27 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3d10e.dip0.t-ipconnect.de. [79.195.209.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e52a35sm8912812f8f.57.2025.06.29.16.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Jun 2025 16:06:26 -0700 (PDT)
Message-ID: <87d8b81a-2ab9-49f2-9319-99d74f84081e@linaro.org>
Date: Mon, 30 Jun 2025 01:06:24 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] power: supply: qcom_smbx: add smb5 support
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 linux-hardening@vger.kernel.org
References: <20250619-smb2-smb5-support-v1-0-ac5dec51b6e1@linaro.org>
 <20250619-smb2-smb5-support-v1-9-ac5dec51b6e1@linaro.org>
 <anawfylnc5afpljxeooruyy3lgxn3wizy57jruvnmro6akfsx7@zdzsnludbl6f>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <anawfylnc5afpljxeooruyy3lgxn3wizy57jruvnmro6akfsx7@zdzsnludbl6f>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 24/06/2025 03:06, Dmitry Baryshkov wrote:
> On Thu, Jun 19, 2025 at 04:55:17PM +0200, Casey Connolly wrote:
>> Introduce support for the SMB5 charger found on pm8150b and other more
>> modern Qualcomm SoCs.
>>
>> SMB5 is largely similar to SMB2, with a few register differences. The
>> main difference is the new Type-C hardware block which some registers
>> are moved to.
>>
>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>> ---
>>  drivers/power/supply/qcom_smbx.c | 367 +++++++++++++++++++++++++++++++++------
>>  1 file changed, 314 insertions(+), 53 deletions(-)
>>
>> diff --git a/drivers/power/supply/qcom_smbx.c b/drivers/power/supply/qcom_smbx.c
>> index 10ddd33a09599decb23c0f1ccd02fa9b56602543..d902f3f43548191d3d0310ce90e699918ed0f16f 100644
>> --- a/drivers/power/supply/qcom_smbx.c
>> +++ b/drivers/power/supply/qcom_smbx.c
>> @@ -22,18 +22,32 @@
>>  #include <linux/regmap.h>
>>  #include <linux/types.h>
>>  #include <linux/workqueue.h>
>>  
>> +enum smb_generation {
>> +	SMB2,
>> +	SMB5,
>> +};
>> +
>> +#define SMB_REG_OFFSET(smb) (smb->gen == SMB2 ? 0x600 : 0x100)
>> +
>>  /* clang-format off */
>>  #define BATTERY_CHARGER_STATUS_1			0x06
>>  #define BATTERY_CHARGER_STATUS_MASK			GENMASK(2, 0)
>>  
>>  #define BATTERY_CHARGER_STATUS_2			0x07
>> -#define CHARGER_ERROR_STATUS_BAT_OV_BIT			BIT(5)
>> -#define BAT_TEMP_STATUS_HOT_SOFT_LIMIT_BIT		BIT(3)
>> -#define BAT_TEMP_STATUS_COLD_SOFT_LIMIT_BIT		BIT(2)
>> -#define BAT_TEMP_STATUS_TOO_HOT_BIT			BIT(1)
>> -#define BAT_TEMP_STATUS_TOO_COLD_BIT			BIT(0)
>> +#define SMB2_CHARGER_ERROR_STATUS_BAT_OV_BIT		BIT(5)
>> +#define SMB2_BAT_TEMP_STATUS_HOT_SOFT_LIMIT_BIT	BIT(3)
>> +#define SMB2_BAT_TEMP_STATUS_COLD_SOFT_LIMIT_BIT	BIT(2)
>> +#define SMB2_BAT_TEMP_STATUS_TOO_HOT_BIT		BIT(1)
>> +#define SMB5_CHARGER_ERROR_STATUS_BAT_OV_BIT		BIT(1)
>> +#define SMB2_BAT_TEMP_STATUS_TOO_COLD_BIT		BIT(0)
>> +
>> +#define BATTERY_CHARGER_STATUS_7			0x0D
>> +#define SMB5_BAT_TEMP_STATUS_HOT_SOFT_BIT		BIT(5)
>> +#define SMB5_BAT_TEMP_STATUS_COLD_SOFT_BIT		BIT(4)
>> +#define SMB5_BAT_TEMP_STATUS_TOO_HOT_BIT		BIT(3)
>> +#define SMB5_BAT_TEMP_STATUS_TOO_COLD_BIT		BIT(2)
>>  
>>  #define CHARGING_ENABLE_CMD				0x42
>>  #define CHARGING_ENABLE_CMD_BIT				BIT(0)
>>  
>> @@ -55,11 +69,14 @@
>>  
>>  #define FLOAT_VOLTAGE_CFG				0x70
>>  #define FLOAT_VOLTAGE_SETTING_MASK			GENMASK(7, 0)
>>  
>> -#define FG_UPDATE_CFG_2_SEL				0x7D
>> -#define SOC_LT_CHG_RECHARGE_THRESH_SEL_BIT		BIT(2)
>> -#define VBT_LT_CHG_RECHARGE_THRESH_SEL_BIT		BIT(1)
>> +#define SMB2_FG_UPDATE_CFG_2_SEL			0x7D
>> +#define SMB2_SOC_LT_CHG_RECHARGE_THRESH_SEL_BIT		BIT(2)
>> +#define SMB2_VBT_LT_CHG_RECHARGE_THRESH_SEL_BIT		BIT(1)
>> +
>> +#define SMB5_CHARGE_RCHG_SOC_THRESHOLD_CFG_REG		0x7D
>> +#define SMB5_CHARGE_RCHG_SOC_THRESHOLD_CFG_MASK		GENMASK(7, 0)
>>  
>>  #define OTG_CFG						0x153
>>  #define OTG_EN_SRC_CFG_BIT				BIT(1)
>>  
>> @@ -73,36 +90,46 @@
>>  #define CDP_CHARGER_BIT					BIT(2)
>>  #define OCP_CHARGER_BIT					BIT(1)
>>  #define SDP_CHARGER_BIT					BIT(0)
>>  
>> +#define USBIN_CMD_IL					0x340
>> +#define USBIN_SUSPEND_BIT				BIT(0)
>> +
>>  #define CMD_APSD					0x341
>>  #define APSD_RERUN_BIT					BIT(0)
>>  
>> +#define CMD_ICL_OVERRIDE				0x342
>> +#define ICL_OVERRIDE_BIT				BIT(0)
>> +
>>  #define TYPE_C_CFG					0x358
>> +#define APSD_START_ON_CC_BIT				BIT(7)
>>  #define FACTORY_MODE_DETECTION_EN_BIT			BIT(5)
>>  #define VCONN_OC_CFG_BIT				BIT(1)
>>  
>>  #define USBIN_OPTIONS_1_CFG				0x362
>> +#define AUTO_SRC_DETECT_BIT				BIT(3)
>>  #define HVDCP_EN_BIT					BIT(2)
>>  
>> +#define USBIN_LOAD_CFG					0x65
>> +#define ICL_OVERRIDE_AFTER_APSD_BIT			BIT(4)
>> +
>>  #define USBIN_ICL_OPTIONS				0x366
>>  #define USB51_MODE_BIT					BIT(1)
>>  #define USBIN_MODE_CHG_BIT				BIT(0)
>>  
>>  /* PMI8998 only */
>>  #define TYPE_C_INTRPT_ENB_SOFTWARE_CTRL			0x368
>> -#define VCONN_EN_SRC_BIT				BIT(4)
>> +#define SMB2_VCONN_EN_SRC_BIT				BIT(4)
>>  #define VCONN_EN_VALUE_BIT				BIT(3)
>>  #define TYPEC_POWER_ROLE_CMD_MASK			GENMASK(2, 0)
>> -#define UFP_EN_CMD_BIT					BIT(2)
>> -#define DFP_EN_CMD_BIT					BIT(1)
>> -#define TYPEC_DISABLE_CMD_BIT				BIT(0)
>> +#define SMB5_EN_SNK_ONLY_BIT				BIT(1)
>>  
>>  #define USBIN_CURRENT_LIMIT_CFG				0x370
>>  
>>  #define USBIN_AICL_OPTIONS_CFG				0x380
>>  #define SUSPEND_ON_COLLAPSE_USBIN_BIT			BIT(7)
>>  #define USBIN_AICL_START_AT_MAX_BIT			BIT(5)
>> +#define USBIN_AICL_PERIODIC_RERUN_EN_BIT		BIT(4)
>>  #define USBIN_AICL_ADC_EN_BIT				BIT(3)
>>  #define USBIN_AICL_EN_BIT				BIT(2)
>>  #define USBIN_HV_COLLAPSE_RESPONSE_BIT			BIT(1)
>>  #define USBIN_LV_COLLAPSE_RESPONSE_BIT			BIT(0)
>> @@ -113,15 +140,41 @@
>>  
>>  #define USBIN_CONT_AICL_THRESHOLD_CFG			0x384
>>  #define USBIN_CONT_AICL_THRESHOLD_CFG_MASK		GENMASK(5, 0)
>>  
>> -#define ICL_STATUS					0x607
>> +#define ICL_STATUS(smb)					(SMB_REG_OFFSET(smb) + 0x07)
>>  #define INPUT_CURRENT_LIMIT_MASK			GENMASK(7, 0)
>>  
>> -#define POWER_PATH_STATUS				0x60B
>> +#define POWER_PATH_STATUS(smb)				(SMB_REG_OFFSET(smb) + 0x0B)
>>  #define P_PATH_USE_USBIN_BIT				BIT(4)
>>  #define P_PATH_VALID_INPUT_POWER_SOURCE_STS_BIT		BIT(0)
>>  
>> +/* 0x5xx region is PM8150b only Type-C registers */
>> +
>> +/* Bits 2:0 match PMI8998 TYPE_C_INTRPT_ENB_SOFTWARE_CTRL */
>> +#define SMB5_TYPE_C_MODE_CFG				0x544
>> +#define SMB5_EN_TRY_SNK_BIT				BIT(4)
>> +#define SMB5_EN_SNK_ONLY_BIT				BIT(1)
>> +
>> +#define SMB5_TYPEC_TYPE_C_VCONN_CONTROL			0x546
>> +#define SMB5_VCONN_EN_ORIENTATION_BIT			BIT(2)
>> +#define SMB5_VCONN_EN_VALUE_BIT				BIT(1)
>> +#define SMB5_VCONN_EN_SRC_BIT				BIT(0)
>> +
>> +
>> +#define SMB5_TYPE_C_DEBUG_ACCESS_SINK			0x54a
>> +#define SMB5_TYPEC_DEBUG_ACCESS_SINK_MASK		GENMASK(4, 0)
>> +
>> +#define SMB5_DEBUG_ACCESS_SRC_CFG			0x54C
>> +#define SMB5_EN_UNORIENTED_DEBUG_ACCESS_SRC_BIT	BIT(0)
>> +
>> +#define SMB5_TYPE_C_EXIT_STATE_CFG			0x550
>> +#define SMB5_BYPASS_VSAFE0V_DURING_ROLE_SWAP_BIT	BIT(3)
>> +#define SMB5_SEL_SRC_UPPER_REF_BIT			BIT(2)
>> +#define SMB5_EXIT_SNK_BASED_ON_CC_BIT			BIT(0)
>> +
>> +/* Common */
>> +
>>  #define BARK_BITE_WDOG_PET				0x643
>>  #define BARK_BITE_WDOG_PET_BIT				BIT(0)
>>  
>>  #define WD_CFG						0x651
>> @@ -184,8 +237,9 @@ struct smb_chip {
>>  	const char *name;
>>  	unsigned int base;
>>  	struct regmap *regmap;
>>  	struct power_supply_battery_info *batt_info;
>> +	enum smb_generation gen;
>>  
>>  	struct delayed_work status_change_work;
>>  	int cable_irq;
>>  	bool wakeup_enabled;
>> @@ -195,8 +249,15 @@ struct smb_chip {
>>  
>>  	struct power_supply *chg_psy;
>>  };
>>  
>> +struct smb_match_data {
>> +	const char *name;
>> +	enum smb_generation gen;
>> +	size_t init_seq_len;
>> +	const struct smb_init_register __counted_by(init_seq_len) *init_seq;
>> +};
>> +
>>  static enum power_supply_property smb_properties[] = {
>>  	POWER_SUPPLY_PROP_MANUFACTURER,
>>  	POWER_SUPPLY_PROP_MODEL_NAME,
>>  	POWER_SUPPLY_PROP_CURRENT_MAX,
>> @@ -212,9 +273,9 @@ static int smb_get_prop_usb_online(struct smb_chip *chip, int *val)
>>  {
>>  	unsigned int stat;
>>  	int rc;
>>  
>> -	rc = regmap_read(chip->regmap, chip->base + POWER_PATH_STATUS, &stat);
>> +	rc = regmap_read(chip->regmap, chip->base + POWER_PATH_STATUS(chip), &stat);
>>  	if (rc < 0) {
>>  		dev_err(chip->dev, "Couldn't read power path status: %d\n", rc);
>>  		return rc;
>>  	}
>> @@ -267,11 +328,37 @@ static int smb_apsd_get_charger_type(struct smb_chip *chip, int *val)
>>  
>>  	return 0;
>>  }
>>  
>> +/* Return 1 when in overvoltage state, else 0 or -errno */
>> +static int smbx_ov_status(struct smb_chip *chip)
>> +{
>> +	u16 reg;
>> +	u8 mask;
>> +	int rc;
>> +	u32 val;
>> +
>> +	switch (chip->gen) {
>> +	case SMB2:
>> +		reg = BATTERY_CHARGER_STATUS_2;
>> +		mask = SMB2_CHARGER_ERROR_STATUS_BAT_OV_BIT;
>> +		break;
>> +	case SMB5:
>> +		reg = BATTERY_CHARGER_STATUS_7;
>> +		mask = SMB5_CHARGER_ERROR_STATUS_BAT_OV_BIT;
>> +		break;
>> +	}
>> +
>> +	rc = regmap_read(chip->regmap, chip->base + reg, &val);
>> +	if (rc)
>> +		return rc;
>> +
>> +	return !!(reg & mask);
>> +}
>> +
>>  static int smb_get_prop_status(struct smb_chip *chip, int *val)
>>  {
>> -	unsigned char stat[2];
>> +	u32 stat;
>>  	int usb_online = 0;
>>  	int rc;
>>  
>>  	rc = smb_get_prop_usb_online(chip, &usb_online);
>> @@ -279,24 +366,29 @@ static int smb_get_prop_status(struct smb_chip *chip, int *val)
>>  		*val = POWER_SUPPLY_STATUS_DISCHARGING;
>>  		return rc;
>>  	}
>>  
>> -	rc = regmap_bulk_read(chip->regmap,
>> -			      chip->base + BATTERY_CHARGER_STATUS_1, &stat, 2);
>> +	rc = regmap_read(chip->regmap,
>> +			      chip->base + BATTERY_CHARGER_STATUS_1, &stat);
>>  	if (rc < 0) {
>>  		dev_err(chip->dev, "Failed to read charging status ret=%d\n",
>>  			rc);
>>  		return rc;
>>  	}
>>  
>> -	if (stat[1] & CHARGER_ERROR_STATUS_BAT_OV_BIT) {
>> +	rc = smbx_ov_status(chip);
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	/* In overvoltage state */
>> +	if (rc == 1) {
>>  		*val = POWER_SUPPLY_STATUS_NOT_CHARGING;
>>  		return 0;
>>  	}
>>  
>> -	stat[0] = stat[0] & BATTERY_CHARGER_STATUS_MASK;
>> +	stat = stat & BATTERY_CHARGER_STATUS_MASK;
>>  
>> -	switch (stat[0]) {
>> +	switch (stat) {
>>  	case TRICKLE_CHARGE:
>>  	case PRE_CHARGE:
>>  	case FAST_CHARGE:
>>  	case FULLON_CHARGE:
>> @@ -318,9 +410,9 @@ static int smb_get_prop_status(struct smb_chip *chip, int *val)
>>  
>>  static inline int smb_get_current_limit(struct smb_chip *chip,
>>  					 unsigned int *val)
>>  {
>> -	int rc = regmap_read(chip->regmap, chip->base + ICL_STATUS, val);
>> +	int rc = regmap_read(chip->regmap, chip->base + ICL_STATUS(chip), val);
>>  
>>  	if (rc >= 0)
>>  		*val *= CURRENT_SCALE_FACTOR;
>>  	return rc;
>> @@ -413,9 +505,46 @@ static int smb_get_iio_chan(struct smb_chip *chip, struct iio_channel *chan,
>>  
>>  	return iio_read_channel_processed(chan, val);
>>  }
>>  
>> -static int smb_get_prop_health(struct smb_chip *chip, int *val)
>> +static int smb5_get_prop_health(struct smb_chip *chip, int *val)
>> +{
>> +	int rc;
>> +	unsigned int stat;
>> +
>> +	rc = smbx_ov_status(chip);
>> +
>> +	/* Treat any error as if we are in the overvoltage state */
>> +	if (rc < 0)
>> +		dev_err(chip->dev, "Couldn't determine overvoltage status!");
>> +	if (rc) {
>> +		dev_err(chip->dev, "battery over-voltage");
>> +		*val = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
>> +		return 0;
>> +	}
>> +
>> +	rc = regmap_read(chip->regmap, chip->base + BATTERY_CHARGER_STATUS_7,
>> +			 &stat);
>> +	if (rc < 0) {
>> +		dev_err(chip->dev, "Couldn't read charger status 7 rc=%d\n", rc);
>> +		return rc;
>> +	}
>> +
>> +	if (stat & SMB5_BAT_TEMP_STATUS_TOO_COLD_BIT)
>> +		*val = POWER_SUPPLY_HEALTH_COLD;
>> +	else if (stat & SMB5_BAT_TEMP_STATUS_TOO_HOT_BIT)
>> +		*val = POWER_SUPPLY_HEALTH_OVERHEAT;
>> +	else if (stat & SMB5_BAT_TEMP_STATUS_COLD_SOFT_BIT)
>> +		*val = POWER_SUPPLY_HEALTH_COOL;
>> +	else if (stat & SMB5_BAT_TEMP_STATUS_HOT_SOFT_BIT)
>> +		*val = POWER_SUPPLY_HEALTH_WARM;
>> +	else
>> +		*val = POWER_SUPPLY_HEALTH_GOOD;
>> +
>> +	return 0;
>> +}
>> +
>> +static int smb2_get_prop_health(struct smb_chip *chip, int *val)
>>  {
>>  	int rc;
>>  	unsigned int stat;
>>  
>> @@ -426,34 +555,45 @@ static int smb_get_prop_health(struct smb_chip *chip, int *val)
>>  		return rc;
>>  	}
>>  
>>  	switch (stat) {
>> -	case CHARGER_ERROR_STATUS_BAT_OV_BIT:
>> +	case SMB2_CHARGER_ERROR_STATUS_BAT_OV_BIT:
>>  		*val = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
>>  		return 0;
>> -	case BAT_TEMP_STATUS_TOO_COLD_BIT:
>> +	case SMB2_BAT_TEMP_STATUS_TOO_COLD_BIT:
>>  		*val = POWER_SUPPLY_HEALTH_COLD;
>>  		return 0;
>> -	case BAT_TEMP_STATUS_TOO_HOT_BIT:
>> +	case SMB2_BAT_TEMP_STATUS_TOO_HOT_BIT:
>>  		*val = POWER_SUPPLY_HEALTH_OVERHEAT;
>>  		return 0;
>> -	case BAT_TEMP_STATUS_COLD_SOFT_LIMIT_BIT:
>> +	case SMB2_BAT_TEMP_STATUS_COLD_SOFT_LIMIT_BIT:
>>  		*val = POWER_SUPPLY_HEALTH_COOL;
>>  		return 0;
>> -	case BAT_TEMP_STATUS_HOT_SOFT_LIMIT_BIT:
>> +	case SMB2_BAT_TEMP_STATUS_HOT_SOFT_LIMIT_BIT:
>>  		*val = POWER_SUPPLY_HEALTH_WARM;
>>  		return 0;
>>  	default:
>>  		*val = POWER_SUPPLY_HEALTH_GOOD;
>>  		return 0;
>>  	}
>>  }
>>  
>> +static int smb_get_prop_health(struct smb_chip *chip, int *val)
>> +{
>> +	switch (chip->gen) {
>> +	case SMB2:
>> +		return smb2_get_prop_health(chip, val);
>> +	case SMB5:
>> +		return smb5_get_prop_health(chip, val);
>> +	}
>> +}
>> +
>>  static int smb_get_property(struct power_supply *psy,
>>  			     enum power_supply_property psp,
>>  			     union power_supply_propval *val)
>>  {
>>  	struct smb_chip *chip = power_supply_get_drvdata(psy);
>> +	int ret;
>>  
>>  	switch (psp) {
>>  	case POWER_SUPPLY_PROP_MANUFACTURER:
>>  		val->strval = "Qualcomm";
>> @@ -466,10 +606,15 @@ static int smb_get_property(struct power_supply *psy,
>>  	case POWER_SUPPLY_PROP_CURRENT_NOW:
>>  		return smb_get_iio_chan(chip, chip->usb_in_i_chan,
>>  					 &val->intval);
>>  	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
>> -		return smb_get_iio_chan(chip, chip->usb_in_v_chan,
>> +		ret = smb_get_iio_chan(chip, chip->usb_in_v_chan,
>>  					 &val->intval);
>> +		if (!ret) {
>> +			if (chip->gen == SMB5)
>> +				val->intval *= 16;
>> +		}
>> +		return ret;
>>  	case POWER_SUPPLY_PROP_ONLINE:
>>  		return smb_get_prop_usb_online(chip, &val->intval);
>>  	case POWER_SUPPLY_PROP_STATUS:
>>  		return smb_get_prop_status(chip, &val->intval);
>> @@ -515,14 +660,10 @@ static int smb_property_is_writable(struct power_supply *psy,
>>  
>>  static irqreturn_t smb_handle_batt_overvoltage(int irq, void *data)
>>  {
>>  	struct smb_chip *chip = data;
>> -	unsigned int status;
>>  
>> -	regmap_read(chip->regmap, chip->base + BATTERY_CHARGER_STATUS_2,
>> -		    &status);
>> -
>> -	if (status & CHARGER_ERROR_STATUS_BAT_OV_BIT) {
>> +	if (smbx_ov_status(chip) == 1) {
>>  		/* The hardware stops charging automatically */
>>  		dev_err(chip->dev, "battery overvoltage detected\n");
>>  		power_supply_changed(chip->chg_psy);
>>  	}
>> @@ -566,9 +707,9 @@ static irqreturn_t smb_handle_wdog_bark(int irq, void *data)
>>  	return IRQ_HANDLED;
>>  }
>>  
>>  static const struct power_supply_desc smb_psy_desc = {
>> -	.name = "pmi8998_charger",
>> +	.name = "SMB2_charger",
>>  	.type = POWER_SUPPLY_TYPE_USB,
>>  	.usb_types = BIT(POWER_SUPPLY_USB_TYPE_SDP) |
>>  		     BIT(POWER_SUPPLY_USB_TYPE_CDP) |
>>  		     BIT(POWER_SUPPLY_USB_TYPE_DCP) |
>> @@ -580,18 +721,100 @@ static const struct power_supply_desc smb_psy_desc = {
>>  	.property_is_writeable = smb_property_is_writable,
>>  };
>>  
>>  /* Init sequence derived from vendor downstream driver */
>> -static const struct smb_init_register smb_init_seq[] = {
>> -	{ .addr = AICL_RERUN_TIME_CFG, .mask = AICL_RERUN_TIME_MASK, .val = 0 },
>> +static const struct smb_init_register smb5_init_seq[] = {
>> +	{ .addr = USBIN_CMD_IL, .mask = USBIN_SUSPEND_BIT, .val = 0 },
>> +	/*
>> +	 * By default configure us as an upstream facing port
>> +	 * FIXME: This will be handled by the type-c driver
>> +	 */
> 
> All of this needs to be reworked to cooperate with the type-c driver.
> Otherwise it might try to reconfigure the Type-C mode _after_ the TCPM
> has negotiated some configuration. So, it can't go in in this way.

Hi Dmitry,

this is the smb2/pmi8998 init sequence, we don't have any type-c support
for this yet hence this. When we add role switching/type-c support it
will make sense to rework this but until then we need this.

Kind regards,

> 
>> +	{ .addr = SMB5_TYPE_C_MODE_CFG,
>> +	  .mask = SMB5_EN_TRY_SNK_BIT | SMB5_EN_SNK_ONLY_BIT,
>> +	  .val = SMB5_EN_TRY_SNK_BIT },
>>
> 

-- 
// Casey (she/her)


