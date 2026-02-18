Return-Path: <linux-pm+bounces-42807-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yETdLox1lWlCRwIAu9opvQ
	(envelope-from <linux-pm+bounces-42807-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 09:17:16 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3220C153EE6
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 09:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BFCB7301C6D9
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 08:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234593126A1;
	Wed, 18 Feb 2026 08:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTx7qOme"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A487F308F05
	for <linux-pm@vger.kernel.org>; Wed, 18 Feb 2026 08:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771402632; cv=none; b=pmPfzSbg6l0JQ175795rxCEZMa7Wy3O7ruRrI6dgx4+TkQQOxYAEUHHX9h9whIzyhfY1LbLIFBynRuKmKalT8IbkdHq0G6HTEOPDCk8DKfW1exHwkhrUoCABALKaWAiFFLdjB/I2xDitrjoTmyaeRNp0cwoAFAo33o3cRZj5Ibs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771402632; c=relaxed/simple;
	bh=9moeBSWAnG3dtSIbdW4ZnD0x20PyiAy3DOWv8ETJgx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qrJaSA02COdny5mHB+EdbCwvfriFMK86MKH81DAazNZ0FVjRW7cHNaqnCC/vGuasBbq08w+jvq+gDkhyC7/mWv+hjg8MEnf+F36jDIcVvh4+A5zAuXazmremCL8q9x1SGpCTZD7pIbD1r8eolsQ52w+u/LvDNMfUFH0V7puc3tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTx7qOme; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59b672f8ec4so4803748e87.1
        for <linux-pm@vger.kernel.org>; Wed, 18 Feb 2026 00:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771402629; x=1772007429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5r0xdr1WGpCeGTUqLANRfTri1dCqx5zok5lpbzySRko=;
        b=nTx7qOmeum236BXFrq/lI95npYcbZdRkmrsYpw6z44rQeeD2T//+MtGlF4miv5w2A3
         973XqBQSOtxZaws0YxAmu+XEEJNfeGXkBlZFU5Z+lKYprZhMNfCc/i0gIofqZCTjnUn/
         vVKH4KurYSpHbro3gpWg8JEiIu6tPOrKkEyhgu0fVuyXnNMQTtY8kYWz6F7X002VpCx0
         VI0Gq1zYb0an31wBKti3j8ihdTIBaDKT6QjtbmQjIBr8z4GPRYyxbPS6qdw/kdbxdOWb
         Xmwf48ZWRjNGLbJS23hhX4iX20jPRH8xdAg3+1VlzLeqSvVxnb/78oDeP5vADrvsirma
         BKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771402629; x=1772007429;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5r0xdr1WGpCeGTUqLANRfTri1dCqx5zok5lpbzySRko=;
        b=k5VnD41ejbeUK6mYMVLg4XfLCYBXOHCrbv6ZB389fZ50ToITU/Zs5pd+RZ7bML9rtB
         SqHIIrZoz7rvLs86KXGMqZD6PtS2S68UGIzut40W0ick6nrojaFhKoznD7MDYPbXAl9H
         +XeRDYsnCO87eqeBVs3JwHuv/0puWIj/Wgbt/AaIYq9aCnWw9PcF1FgoEUTZbHKgH0Yj
         bptngHLOchuuhHw1bJmtRH5Ql3L73gYg9t3jskiy8qZ/egMaa43m+wXFW/+HFajNhun5
         LId+VyPsTje2d0tm7FK0JAq2haIuJj/VtAD2PnG+LEeRU/GSu/UYCf+j3ZFe+UTZZNgb
         wtcw==
X-Forwarded-Encrypted: i=1; AJvYcCXDkBbgDip3weGWTu6OonqjHnvY3UE/J4V+41LNDcsWbEidNNF4r0e7CKFTgZtFhkVdHt8pH9WmdA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHjDD2OSTIiFB9RmuLTlySxoPRpg4fd6tHYOA4QaKCvnETvCHQ
	X0xvY0CvVOAIsqjSUQBr0X77jEk5h+baYx92OST70sWdEN9uYpHG2H8l
X-Gm-Gg: AZuq6aJBup0jVMwDn1VcOw9FDRpZVK3QkftpbSpkSCPWe6/WebgZOtXwCwZzQWF+FOo
	RUcYViaEx21uBC3hMbYTawe4fgznUZTgwYBeDc73qtkDvWo31dnHR0NLrmbZPeisgyA+pgbXLlb
	GMsECA8akrMjRmx4OL/uxnN78uuAKrdduBuQnK/V4+TDizI2wgUUKYnvbPl4fPXhVJDJYQcp2GJ
	UapeooQR/aK+Lm1hl8udS0nq8sHasoHdKdQWypsBSOnSxfLbshV5VlzTP2DluWBBqDkmfCP1itJ
	7i6Z8or9ovCEnqVXI46aNPmjV57rMY8RZwjgoIcInPMrI+g21WlcGi6PnCNS/ilL0gKobmTRxKz
	a45HHM4UvQyizfZUSxxN7OWmjTalNhENU9kf/VdIKRUMsG4z/zCJKXN7rWq3zNFwF1MEpa9d1aW
	THfBZv/v7/bb+sCo8bQe5btefCui2hAqsSf31h9iDcOXsPIRJ3qHIoNF03OeMbg9STvNxs9gkRV
	4eJ8+YCogSCVT+HHz4=
X-Received: by 2002:a05:6512:1150:b0:59e:6c24:3f91 with SMTP id 2adb3069b0e04-59f83bbcd19mr369556e87.34.1771402628519;
        Wed, 18 Feb 2026 00:17:08 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e5f56867fsm4391846e87.24.2026.02.18.00.17.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Feb 2026 00:17:07 -0800 (PST)
Message-ID: <66dab64b-ca3e-4ae0-81d6-0500899757e5@gmail.com>
Date: Wed, 18 Feb 2026 10:17:06 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/6] lib/linear_ranges: Add
 linear_range_get_selector_high_array
To: Amit Sunil Dhamne <amitsd@google.com>, Sebastian Reichel
 <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>, Lee Jones <lee@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Badhri Jagan Sridharan <badhri@google.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Mark Brown <broonie@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>
References: <20260214-max77759-charger-v6-0-28c09bda74b4@google.com>
 <20260214-max77759-charger-v6-4-28c09bda74b4@google.com>
 <5d889f66-7697-4a39-beed-33ace693a1ef@gmail.com>
 <b1df24fd-bbb6-4991-be52-dc1ef694db25@google.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <b1df24fd-bbb6-4991-be52-dc1ef694db25@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42807-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mazziesaccount@gmail.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3220C153EE6
X-Rspamd-Action: no action

On 18/02/2026 03:45, Amit Sunil Dhamne wrote:
> 
> On 2/16/26 5:58 AM, Matti Vaittinen wrote:
>> On 14/02/2026 05:12, Amit Sunil Dhamne via B4 Relay wrote:
>>> From: Amit Sunil Dhamne <amitsd@google.com>

// snip

>>> --- a/lib/linear_ranges.c
>>> +++ b/lib/linear_ranges.c
>>> @@ -241,6 +241,42 @@ int linear_range_get_selector_high(const struct 
>>> linear_range *r,
>>>   }
>>>   EXPORT_SYMBOL_GPL(linear_range_get_selector_high);
>>>   +/**
>>> + * linear_range_get_selector_high_array - return linear range 
>>> selector for value
>>> + * @r:        pointer to array of linear ranges where selector is 
>>> looked from
>>> + * @ranges:    amount of ranges to scan from array
>>> + * @val:    value for which the selector is searched
>>> + * @selector:    address where found selector value is updated
>>> + * @found:    flag to indicate that given value was in the range
>>> + *
>>> + * Scan array of ranges for selector for which range value matches 
>>> given
>>> + * input value. Value is matching if it is equal or higher than 
>>> given value
>>> + * If given value is found to be in a range scanning is stopped and 
>>> @found is
>>> + * set true. If a range with values greater than given value is found
>>> + * but the range min is being greater than given value, then the 
>>> range's
>>> + * lowest selector is updated to @selector and scanning is stopped.
>>
>> Is there a reason why the scanning is stopped here? What ensures that 
>> the rest of the ranges wouldn't contain a better match?
>>
>> The logic is now different from the 
>> linear_range_get_selector_low_array(), and I would like to understand 
>> why? It'd be nice if these APIs were 'symmetric' to avoid confusion. 
>> Hence, I would like to know rationale behind making them different.
> 
> 
> The rationale for this being asymmetric is to find the tightest upper 
> bound for `value` < minimum value across the linear range array.
> 
> To better illustrate this with an example. I have 2 entries in the 
> linear range array [ [4, 8], [11, 15] ]. Let's assume I pass a value of 
> "2".
> 
> Based on my current approach, the call to get_selector_high() would 
> successfully return with `found`=false and a selector value 
> corresponding to "4".
> 
> However, if I continued to search, I would end up the selector 
> corresponding to "11". A selector corresponding to "4" is much closer/ 
> tighter than "2".
> 
> For values higher than the highest value in any range, this would keep 
> iterating and end up returning an -EINVAL.
> 
> For in range values this would work as expected.
> 
> This implementation assumes that the linear ranges are provided in 
> sorted order, an assumption that I believe already underlies the 
> existing *_low_array() logic.

Ah. I think ... I didn't think. :)

It definitely makes sense to stop scanning if the range_min already was 
greater than the given target value. Thanks for the patience and for 
adding this missing piece :)

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>


---
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

