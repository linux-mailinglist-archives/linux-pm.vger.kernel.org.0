Return-Path: <linux-pm+bounces-42893-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHzgGOt0l2lpywIAu9opvQ
	(envelope-from <linux-pm+bounces-42893-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 21:39:07 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 944581625D8
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 21:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1875C30071F4
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 20:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A66324B2D;
	Thu, 19 Feb 2026 20:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V5smHirx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBF8318BB7
	for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2026 20:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771533544; cv=none; b=hLzvVG/wpq+kC9Po/WD8cknfzGw6PTAE1gwgdjF8cCJUFJLEkh0L5/N60FMMUxiisfPVZsRuhqsJeUuEerOBqyy9n/YGW1fQ+FFqa5zUmMXejMKReHvYWOclL5gNe9JJ+6bHgYAFX46NpM+VVFQb3VNqK1xZesslkym0jhOWsGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771533544; c=relaxed/simple;
	bh=+8WdIeayvQwTa1EO0ctLm8O+l21nYzdUf7o4bczyCAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DH4MBt2gLmb7muO4b0Jg/ef9/T2oP6kQ8I5r3yyx5WX7MPl27s25Ff/Ax6R02T43x8C7tVk+bQIJafmS9NR4W0JYTqHPzO9dU5gxZJNM2h8wW+FLdKaMY/3Oy+nS19iSIAq7hrVD03lAJggHmrRzN+n/L6aMS3Cdqh0myMPx1Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V5smHirx; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2b6b0500e06so1665207eec.1
        for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2026 12:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771533542; x=1772138342; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SI/A7iNXCicM0eX7PESju9pA0T4gNBVRW7g2h/AnymA=;
        b=V5smHirx/j0NvvcbaYqORRLcRESItsM/vtuSDTRrrSoczn0CRNE6ZTCY6evAwGfnAE
         iiJRCptNclwdWCN6pHCo6VWu8LhC9sDERKGhghvt+LeDGclNmjmgeAgS036Pq1cUJUMK
         dIzbGmWx+LDUrvkxgTjsPR7gbcVabsaJl8OpWKTsYUYNtAq03hwew6bjyjlGlI2UkxyX
         tTlitqIHHv3oHyZYcSQKSRSDT7aSt7jIuLkcJCU/WnwJngzL4hN3DP1WDXeRwMY4c90s
         rBqyQR/SzjQZC4/7ND+6AseYNIynUaV3kTtzGu5eJJyLSp2XKowA8I3n1u/AFk/vcAeb
         zw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771533542; x=1772138342;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SI/A7iNXCicM0eX7PESju9pA0T4gNBVRW7g2h/AnymA=;
        b=uVZk4lx1z5zVu5EZTKzZyeSwCEUvC5I68SdkbDy3BiwZ+BsuQne63cuCA0qAcJrECh
         1uuGep2YDqgjdbF6iwTDf6fVRFlzCVGh2jFbWNCXtGhSxWGdnoFcOeMjae2ERZ1j9lIp
         /6sBmEl30dk9rQ6/xChARixCtO3reob+iAGYG1IbAy1NU2MNTNtKATf3xRrrijnbSjbe
         +S0dwb/KOuuYArboaL3FimcxvztvUkHIsh7dxHGjQRjqTr/wE1TDBFwAEqXTKeDmq91O
         HY5/2u0HXrM3x5IJP7Q4pHPRrnzVVh9jTKNPlg0ug9CzyuSJdjdMUdvKUOWcfBcKhWFJ
         SP+w==
X-Forwarded-Encrypted: i=1; AJvYcCXQ1/u+ChDyrXtO5QHIK5fw/z1iaTlybXYCieVqP1WT7b9Mm0CK3pZS43CDETcaObIQRGe0RZz3tQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIZQbVX9YjZ/5mHykvC5j99ifhJT3hTVOst0ZkcQHsmL4tIeb6
	oLIEBfI5oy5phW2CIcAXNU+q16eBIX7mGBKaZZoSzExfZMF7X/m90vgRYSRpRcFyGw==
X-Gm-Gg: AZuq6aITFOf8ITXN/Q0Eq3n4gPzlptMqDCRuStoApBQHKbhRcVG/eKRO3/4vN9ZR493
	INyY9QaDOhLrjDpL93hv5l2FVzZgWcYtNTx6YX33zGNlDIiWJjWk+8Yu9K8tEav4T9nBI2wa3qv
	vQLdrl99ndVCZwWGu6ZpYlAePBPRYJd+WiD1LFy8cHFWiwcjWVKcOCXIMh/ynNJfrGbv+nvLFlr
	Jpid+KPGBuL4tkKkFFSNzCVzR2nw1QcAmTaBQ1Lzt5L0m6A3vikp7OuGH1BzT5CugXLe69RrygA
	FLh8cuFrxfyhnSaa2WCUX6tjS6cELnVO8m9yY/8INkn2xOE6yvqj3LBqsR4RtrMXmauxqRZUPji
	PDKFb8uBe1pEkjtVknPa+eW35dRRaPpelWV0WdwlpIQLDYs/1Lerja2QdHUn6darJc/7YKXXUbZ
	jRZyPI4uWKx7GS83HzO+pUYUjqXw+Zo/Dml6noZD9144gG+aWsItFXtyZMMf4l/+PRtvxq6SN8L
	cWyDTrrHzcouKX38gh1pkT9hg==
X-Received: by 2002:a05:7300:cb15:b0:2b0:48f7:837d with SMTP id 5a478bee46e88-2baba03cffcmr6411860eec.11.1771533541615;
        Thu, 19 Feb 2026 12:39:01 -0800 (PST)
Received: from ?IPV6:2a00:79e0:2e7c:8:748f:1ebc:e491:46c0? ([2a00:79e0:2e7c:8:748f:1ebc:e491:46c0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb658544sm24546429eec.17.2026.02.19.12.39.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 12:39:01 -0800 (PST)
Message-ID: <5bcc02b3-2785-4fc4-ab58-2dd94ea7b00a@google.com>
Date: Thu, 19 Feb 2026 12:38:59 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/6] power: supply: max77759: add charger driver
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
References: <20260218-max77759-charger-v7-0-e8d907ce69c5@google.com>
 <20260218-max77759-charger-v7-5-e8d907ce69c5@google.com>
 <f46fa180198ec103aeb1e1c06286c6a2a0fb8b7f.camel@linaro.org>
Content-Language: en-US
From: Amit Sunil Dhamne <amitsd@google.com>
In-Reply-To: <f46fa180198ec103aeb1e1c06286c6a2a0fb8b7f.camel@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42893-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linaro.org,kernel.org,linuxfoundation.org,google.com,linux.intel.com,samsung.com,gmail.com,linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amitsd@google.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 944581625D8
X-Rspamd-Action: no action

Hi Andre',

On 2/19/26 7:52 AM, André Draszik wrote:
> Hi Amit,
>
> I was trying out your series and noticed a few things that I didn't before:
>
> On Wed, 2026-02-18 at 21:59 +0000, Amit Sunil Dhamne via B4 Relay wrote:
>
> [...]
>
>> diff --git a/drivers/power/supply/max77759_charger.c b/drivers/power/supply/max77759_charger.c
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..035f16822d85de94c7707ce11c49345c714cd559
>> --- /dev/null
>> +++ b/drivers/power/supply/max77759_charger.c
> [...]
>
>> +		dev_err(chg->dev, "Invalid mode transition from %d to %d",
>> +			chg->mode, mode);
> All your format strings are missing the final \n throughout this patch.

Sorry will fix. I think this is because of my muscle memory from writing 
`tcpm_log` (which doesn't require an escape character).


>
> [...]
>
>> +static int max77759_charger_probe(struct platform_device *pdev)
>> +{
>> +	struct regulator_config chgin_otg_reg_cfg;
>> +	struct power_supply_config psy_cfg;
>> +	struct device *dev = &pdev->dev;
>> +	struct max77759_charger *chg;
>> +	int ret;
>> +
>> +	device_set_of_node_from_dev(dev, dev->parent);
>> +	chg = devm_kzalloc(dev, sizeof(*chg), GFP_KERNEL);
>> +	if (!chg)
>> +		return -ENOMEM;
>> +
>> +	platform_set_drvdata(pdev, chg);
>> +	chg->dev = dev;
>> +	chg->regmap = dev_get_regmap(dev->parent, "charger");
>> +	if (!chg->regmap)
>> +		return dev_err_probe(dev, -ENODEV, "Missing regmap");
>> +
>> +	ret = devm_mutex_init(dev, &chg->lock);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Failed to initialize lock");
>> +
>> +	ret = devm_mutex_init(dev, &chg->retry_lock);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret,
>> +				     "Failed to initialize retry_lock");
>> +
>> +	psy_cfg.fwnode = dev_fwnode(dev);
>> +	psy_cfg.drv_data = chg;
>> +	chg->psy = devm_power_supply_register(dev, &max77759_charger_desc,
>> +					      &psy_cfg);
>> +	if (IS_ERR(chg->psy))
>> +		return dev_err_probe(dev, -EPROBE_DEFER,
>> +				     "Failed to register psy, ret=%ld",
>> +				     PTR_ERR(chg->psy));
> Why are you returning -EPROBE_DEFER here instead of the original error? This
> is quite unusual.

Will fix. The original thought was that the 
power_supply_check_supplies() (run as part of power_supply_register()) 
wasn't deferring probe if it didn't find its provider device but I was 
mistaken.


Regards,

Amit

>
> Cheers,
> Andre'

