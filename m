Return-Path: <linux-pm+bounces-42799-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LLHOo9PlWkVOQIAu9opvQ
	(envelope-from <linux-pm+bounces-42799-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 06:35:11 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6038D153213
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 06:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CD123011A65
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 05:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85132FFF8C;
	Wed, 18 Feb 2026 05:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wpPDybR2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA8C2EA749
	for <linux-pm@vger.kernel.org>; Wed, 18 Feb 2026 05:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771392906; cv=none; b=ObQnbJ2z4WIh6lUTVyEHoZ/5t0fozd3tJ1QOQ2rjhxifPgy0cTLwPg7K1stGctWoa/onJwPpy98Ui0PPTwdJctEeE7cnl8qofr/F1DPv8sfQwkyoVsclmtXYLje3ONIPC5Vb7St7pj4sJT6sZjTCnhwUZXYJVUpm3f5oKF8Bp0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771392906; c=relaxed/simple;
	bh=ykMbeLkM3JFjjAT+X4RiA986+vadbys1IX+AMjB2BRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Idu9QZIgUD+4v4fcE0c/GDq//ivk9mqJmnKlixU6l4kjb2sw7LeE0zca+gIAeXaGkLnstyLMoam87v7QPWvfbB+ZrFLnzALnOzVrj6010OsTCgKUTByShdN2WV1+qPVm/7qHtCH4ZXNS+1PIhqQ2cV5Hi5zG0DM9WC7crif1Zac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wpPDybR2; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-64acd19e1dfso4597371d50.0
        for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 21:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771392904; x=1771997704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j2gS7QPW0Vau0TRfECG0tWh0O+TEzQcOd404Ys3R6dI=;
        b=wpPDybR2cORDQVafAWe7BXkFmwQuCta0yMTOIiGfpyTI1Kso5yESnbSJrYU7kkvfOK
         ZSnbQ4omaYiXQ5KNpbsusz2zSH9wgLZ40oleczu6olQ/x57OWB6sHlJNc9fE+HK4m3EQ
         7j4jzv9zG/IzhGiujueJSKuhT2X55c1UAhsDHFc4Uo87YK1iyKDMBuPSWsf4EfX4rtjS
         oFqS5O1A2jUrNT6p0WWik/05BqRt4HyKwDnVh6NZwKwS6uHySim/rSwTk+TBhjr5JHWo
         +8lsX0bMPPvlou+a4HorwLemRqctNq5i5LeVHUdA1vG0c/zHHCFVzFCfcQB0LCcN+JU/
         X/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771392904; x=1771997704;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j2gS7QPW0Vau0TRfECG0tWh0O+TEzQcOd404Ys3R6dI=;
        b=DHs1MuWcdMrhaEgpUQwbRIcYroaZbC03eC+Me4GZmRWrMFOXFFUZsRExeZtfGEINJW
         q5dqh24mbExt5y4UIF43+kDge9pQzHLpvoKuQPGsPHxys3H2123XEi6v+UstgNwNVMRk
         TGSvF3LsaU0CCRuoKnWvQ8SKPsinCSdfquOXrb0FtRzkEYkll/IgLbSKlYu8Bi73eQvD
         vq7wKSt2VPu0AdkUQ3PvEKYiQYFR053MjxnvVRx3uwsCqtbFhXAXm2Zb+/nPdBpXwgQT
         69xgEIAOrDBe1JJefRinNTgLyT6WV0iubU0xKFmhebVh/kTiuIQfJUcf86Qm0soIaFt+
         qVCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtaseppQu4q9q6dDIcczEVFHm7kXnGJ4RpRO6U7xKiSQyCEzcIYMY29jE1ntJUjSEOIm98Y+y+QA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpotDsXEkv0Igo0IuZTiTZc4ssS0yCYkWmmV14MJyF78Ttw/eT
	jmNg/87LorlCWOBYkGLYsixg6UYkr3tNLDeEu1M1d7zU0xgBovptfsrQA7kXsAXdmg==
X-Gm-Gg: AZuq6aKuNS/I8XmFGz7CcYa6DDGINJsT4PFUVHAl0O9d6ievrXYefG8HFPe5pZtjPK1
	OWeF6KZEv60g9hnbO6mNlPZRcCflNWKoNyMrFSl8vkWqHqNPuhy3Wrpqiw119Xv2OV7eIVNeyH+
	ghgI0OxsmGSUWjund3rZGHo4+/FJlL3WFxEaiSfp+ildCgZtOgii2G7QH5V5Zws0F66G4Ic4BYG
	Ujfswk4UMAoPWCQOuk8kLhMiVjryQ37sbxwcFGhYVT5NA/k3DK8JcUhZz99QWw6/aoCgAxEo2EV
	x9m/yUQt1tTX6zf6msy26Mcc01f8ruZUmUZ3etv5gTPTOtzoaDj+ecbuTi5HV8x+UWee9ULemSJ
	Ai9Af6vOQaOxVoXh+nhYpIhaqOvZyL8wu3smvLwwKTHcr+hNGOUtnyK7d4EK0hqLGomzn5nWqEg
	46XXrDgam9ZarsSgIpWg2JRIiEWr3MQ7CpBew7IvYDt6N5y3eYb/VNcRpc943ZFjRtCsZbp8Xok
	ZZG
X-Received: by 2002:a05:690e:4005:b0:649:3b9:924e with SMTP id 956f58d0204a3-64c555942aamr701484d50.22.1771392903977;
        Tue, 17 Feb 2026 21:35:03 -0800 (PST)
Received: from ?IPV6:2600:1700:4570:89a0:b4:5cb3:5345:8019? ([2600:1700:4570:89a0:b4:5cb3:5345:8019])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64c22f8fa1fsm5666809d50.15.2026.02.17.21.35.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 21:35:03 -0800 (PST)
Message-ID: <7103a273-f066-4c1b-ad14-7e8fd7ba002a@google.com>
Date: Tue, 17 Feb 2026 21:35:01 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/6] power: supply: max77759: add charger driver
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Badhri Jagan Sridharan <badhri@google.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Mark Brown <broonie@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>
References: <20260214-max77759-charger-v6-0-28c09bda74b4@google.com>
 <20260214-max77759-charger-v6-5-28c09bda74b4@google.com>
 <0b6e7cb7223e553d9b53df464959e97fd3d1ce43.camel@linaro.org>
From: Amit Sunil Dhamne <amitsd@google.com>
Content-Language: en-US
In-Reply-To: <0b6e7cb7223e553d9b53df464959e97fd3d1ce43.camel@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42799-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[linaro.org,kernel.org,linuxfoundation.org,google.com,linux.intel.com,samsung.com,gmail.com,linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amitsd@google.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6038D153213
X-Rspamd-Action: no action

Hi André,


On 2/17/26 5:14 AM, André Draszik wrote:
> Hi Amit,
>
> All below comments are only minor, feel free to ignore them.
>
> On Sat, 2026-02-14 at 03:12 +0000, Amit Sunil Dhamne via B4 Relay wrote:
>> From: Amit Sunil Dhamne <amitsd@google.com>
>>
>> Add support for MAX77759 battery charger driver. This is a 4A 1-Cell
>> Li+/LiPoly dual input switch mode charger. While the device can support
>> USB & wireless charger inputs, this implementation only supports USB
>> input. This implementation supports both buck and boost modes.
>>
>> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
>> ---
>>  MAINTAINERS                             |   6 +
>>  drivers/power/supply/Kconfig            |  11 +
>>  drivers/power/supply/Makefile           |   1 +
>>  drivers/power/supply/max77759_charger.c | 768 ++++++++++++++++++++++++++++++++
>>  4 files changed, 786 insertions(+)
> [...]
>
>> diff --git a/drivers/power/supply/max77759_charger.c b/drivers/power/supply/max77759_charger.c
>> new file mode 100644
>> index 000000000000..d4e02764ba04
>> --- /dev/null
>> +++ b/drivers/power/supply/max77759_charger.c
>> @@ -0,0 +1,768 @@
> [...]
>
>> +
>> +/* USB input current limits (in uA) */
>> +static const struct linear_range chgin_ilim_ranges[] = {
>> +	LINEAR_RANGE(100000, 0x3, 0x7F, 25000),
>> +};
> Shouldn't this one also have a entry for 0x00...0x02:
> 	LINEAR_RANGE(100000, 0x0, 0x2, 0),
>
> Then you can also drop the umax() call in get_input_current_limit().
>
> Ah, I see now there is no linear_range_get_selector_within_array(),
> meaning the code is fine as-is, unless you want to add that as
> well :-)
>
>
> [...]

I would go with the code being as is for now.  :-)


>
>> +static int max77759_charger_init(struct max77759_charger *chg)
>> +{
>> +	struct power_supply_battery_info *info;
>> +	u32 regval, fast_chg_curr, fv;
>> +	int ret;
>> +
>> +	ret = regmap_read(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_00, &regval);
>> +	if (ret)
>> +		return ret;
>> +
>> +	chg->mode = FIELD_GET(MAX77759_CHGR_REG_CHG_CNFG_00_MODE, regval);
>> +	ret = charger_set_mode(chg, MAX77759_CHGR_MODE_OFF);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (power_supply_get_battery_info(chg->psy, &info)) {
>> +		fv = CHG_FV_DEFAULT_MV;
>> +		fast_chg_curr = CHG_CC_DEFAULT_UA;
>> +	} else {
>> +		fv = info->constant_charge_voltage_max_uv / 1000;
>> +		fast_chg_curr = info->constant_charge_current_max_ua;
>> +	}
>> +
>> +	ret = set_fast_charge_current_limit(chg, fast_chg_curr);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = set_float_voltage_limit(chg, fv);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = unlock_prot_regs(chg, true);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Disable wireless charging input */
>> +	ret = regmap_update_bits(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_12,
>> +				 MAX77759_CHGR_REG_CHG_CNFG_12_WCINSEL, 0);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = regmap_update_bits(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_18,
>> +				 MAX77759_CHGR_REG_CHG_CNFG_18_WDTEN, 0);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return unlock_prot_regs(chg, false);
> Should early error returns here try to lock the protection again? Something
> like:
>
> +	ret = unlock_prot_regs(chg, true);
> +	if (ret)
> +		return ret;
> +
> +	/* Disable wireless charging input */
> +	ret = regmap_update_bits(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_12,
> +				 MAX77759_CHGR_REG_CHG_CNFG_12_WCINSEL, 0);
> +	if (ret)
> +		goto relock;
> +
> +	ret = regmap_update_bits(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_18,
> +				 MAX77759_CHGR_REG_CHG_CNFG_18_WDTEN, 0);
> +	if (ret)
> +		goto relock;
> +
> +	return unlock_prot_regs(chg, false);
> +
> +relock:
> +	(void) unlock_prot_regs(chg, false);
> +	return ret;
>
> I guess if one of the regmap_update_bits() failed, then locking the
> registers might not work either, so I have no strong opinion on
> adding that.

Nice catch!

I need to send a next revision to keep the Linux Test Robot happy. I
will address this issue in that.


>
> With or without updates:
>
> Reviewed-by: André Draszik <andre.draszik@linaro.org>
>
LGTM! Thanks!


Regards,

Amit

> Cheers,
> Andre'

