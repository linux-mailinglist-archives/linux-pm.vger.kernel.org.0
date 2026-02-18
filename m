Return-Path: <linux-pm+bounces-42795-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mH/kIekZlWnnLAIAu9opvQ
	(envelope-from <linux-pm+bounces-42795-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 02:46:17 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1B9152932
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 02:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E30713050436
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 01:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4FC2DD60F;
	Wed, 18 Feb 2026 01:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="deKmsegR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A2E23EAB4
	for <linux-pm@vger.kernel.org>; Wed, 18 Feb 2026 01:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771379147; cv=none; b=twrpF4yYNWMhDG/yoW+gpM4LOkraYkLyX7iVsFu12aotjCDhHoqiNe5IuoesSqxeSO+QBva4nXGNCoj+pRsAzIB4emFSB08JIWoU9yKk0qDFr7H6+Gpf7LZlb2eVlX2E0jDv30m6+BvVUZ/VynodhlX/ZthLyx1/RuaABQ4hYYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771379147; c=relaxed/simple;
	bh=yQeoW4MqfwzTgrBMlSHdUdLyFckPUP27F2W5vrcbNCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S/1W7QJMwc7Agi8LBgDyix+iFoogfcym41wGDK59i+f1S5N1q1NwW+saFEcLQT/8ETHfB/c02RrrpUUiEIGAIZ/h9JQMWZIar6dNzhMnXc/Q8W1mdlY2PXrdGYp7IU2YQROc69+fie4oDp6IGV+NS0AZmtphaBXaYnEXxwaB9MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=deKmsegR; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2baab3137bcso4495441eec.0
        for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 17:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771379144; x=1771983944; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SzRez6id0tGCW3l1fRGMuvRJWCHYhvgSDSCiIHHHPic=;
        b=deKmsegRLQHlKTeYYjEyqOZDbPT9lm7vvpbOJK0dKQ3JSLSddLlEw9hR7WNK3PnB+S
         nPQZeipF+m1Tozp8onOYCJC6VqhdPdeNMmwiLNkzK8LiU2sI3D8ZlNySIsJ1Qs3TtxEq
         PTKwqw/RLTdnZHjvUXUJ4YRmH2yyo6gsVnvsniD5M0BFBb4M9KGx6CfSyCIC8Gr6o4Az
         NHipjdp+8+odThpoYB/EEyucN+Pj3E/Tfg/cipnbQoavXiD+0EIgDooLWweQNFImS6R1
         VrhIxRWUtVWGAOYjXala7kefYl82R9MHK2ArB/PowIPHcSI/RubWYLiYj6vj0P8FPrml
         m7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771379144; x=1771983944;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SzRez6id0tGCW3l1fRGMuvRJWCHYhvgSDSCiIHHHPic=;
        b=Avb812BLcv74ZQRzVPQgZezaag7UmrEjb/4PMRY9bDlIpoYSVfGlTqrSXJqX7MOF1E
         A+Hl8ETXEjTqkCgOA/+11ozyNCUYQ6/VXbJFzQb6DkM/Fye3DoOmE0BvQUYV/BdkwDyP
         uLNw8KgT3pl1VP7TzWiWNe8LJ5NaAIgvqd/YX3bbmvx7kqYrz5/myS2PLFvpyJ0j9zWf
         TTekWYviAd7YctYiiJJ0cKzdbiCTVHa7K6BPL3E5ATFnIh8A+eDZH8VuyVdhrhtG7dK3
         iXBsPTmx2fIYdH9+Iq/xGQkZc8ZL6L+7ijoCHBwHtywAecFB6UCSMKhnPAwjzkpmY5M5
         a2dA==
X-Forwarded-Encrypted: i=1; AJvYcCWuaSUOT2uc9TGqURdtFHCYjINhNGG194sn6Mi48DEC4+CC7P1PHvpl/TuF0HiARmjXC+vwCfTDTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8jZzJRjixX4436oyBNW8x26o1j77Z/hQrV6c7xPyQhf3K+Vk7
	Ws8QRuLC0TmeCa1P3YIgIf+L2OrYT+hYEwkzttdyCyuwXZog27kn6+c3TuBBMQQRdg==
X-Gm-Gg: AZuq6aKxLh21h2cZJIDcWTBPJzVEyGmncDtnhdf4rLgOnzVJEd4vUmgQPsof8LEeC0N
	f2ZRV60HjoXTNrteksuYwfHrHzGTwO/gVNmA/WMnmPhsWMXQQ1qyxgKwnWYjixJrwomuz66+woi
	BbB+Ww3nVs+qsjCmjZB0vxp4c8VumUcBij6FdKCOSpJ1g4H8TmDLT3Dhox0RKH/kBZFWXhr0MHL
	CocLGP7VmsYgTCofkGwAMhQ6EUOIY+RmgzAt9Nggn+ufa/6OBR/+/m0Ps2OAcXaNkWpAlYEGXcH
	wch4UIwJ1tVcquVYnfEZgH+58uVj0iM99HZVFg6rhsXdQ1WkP0sEUCf1HagRbzXfp4NiITH0uID
	jf8EiPr+GiRh2jZBVkiVqMQlRP3gA75XehQPOcXA3cDFSK6lsaA7bzQdcBJ92yAHh5+t1JG2a9+
	7E55qPQVObYxzgE6ymfEtlHOOxb8pAnhxjtqYTEUpk7Jcu6NjkVP15xxmX+aR3YO0yEpg0Ad5wN
	hM9KxYEB6yMEML3vtx/h8fpZA==
X-Received: by 2002:a05:7301:2b06:b0:2ba:964f:fa67 with SMTP id 5a478bee46e88-2bac97ad329mr5688952eec.24.1771379143326;
        Tue, 17 Feb 2026 17:45:43 -0800 (PST)
Received: from ?IPV6:2a00:79e0:2e7c:8:c8f1:53bf:725c:563b? ([2a00:79e0:2e7c:8:c8f1:53bf:725c:563b])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742cba192sm15951817c88.13.2026.02.17.17.45.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 17:45:42 -0800 (PST)
Message-ID: <b1df24fd-bbb6-4991-be52-dc1ef694db25@google.com>
Date: Tue, 17 Feb 2026 17:45:40 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/6] lib/linear_ranges: Add
 linear_range_get_selector_high_array
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
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
Content-Language: en-US
From: Amit Sunil Dhamne <amitsd@google.com>
In-Reply-To: <5d889f66-7697-4a39-beed-33ace693a1ef@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
	TAGGED_FROM(0.00)[bounces-42795-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,linaro.org,linuxfoundation.org,google.com,linux.intel.com,samsung.com,linux-foundation.org];
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
X-Rspamd-Queue-Id: 3C1B9152932
X-Rspamd-Action: no action


On 2/16/26 5:58 AM, Matti Vaittinen wrote:
> On 14/02/2026 05:12, Amit Sunil Dhamne via B4 Relay wrote:
>> From: Amit Sunil Dhamne <amitsd@google.com>
>>
>> Add a helper function to find the selector for a given value in a linear
>> range array. The selector should be such that the value it represents
>> should be higher or equal to the given value.
>>
>> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
>> ---
>>   include/linux/linear_range.h |  3 +++
>>   lib/linear_ranges.c          | 36 ++++++++++++++++++++++++++++++++++++
>>   2 files changed, 39 insertions(+)
>>
>> diff --git a/include/linux/linear_range.h b/include/linux/linear_range.h
>> index 2e4f4c3539c0..0f3037f1a94f 100644
>> --- a/include/linux/linear_range.h
>> +++ b/include/linux/linear_range.h
>> @@ -57,5 +57,8 @@ void linear_range_get_selector_within(const struct 
>> linear_range *r,
>>   int linear_range_get_selector_low_array(const struct linear_range *r,
>>                       int ranges, unsigned int val,
>>                       unsigned int *selector, bool *found);
>> +int linear_range_get_selector_high_array(const struct linear_range *r,
>> +                     int ranges, unsigned int val,
>> +                     unsigned int *selector, bool *found);
>>     #endif
>> diff --git a/lib/linear_ranges.c b/lib/linear_ranges.c
>> index a1a7dfa881de..c85583678f6b 100644
>> --- a/lib/linear_ranges.c
>> +++ b/lib/linear_ranges.c
>> @@ -241,6 +241,42 @@ int linear_range_get_selector_high(const struct 
>> linear_range *r,
>>   }
>>   EXPORT_SYMBOL_GPL(linear_range_get_selector_high);
>>   +/**
>> + * linear_range_get_selector_high_array - return linear range 
>> selector for value
>> + * @r:        pointer to array of linear ranges where selector is 
>> looked from
>> + * @ranges:    amount of ranges to scan from array
>> + * @val:    value for which the selector is searched
>> + * @selector:    address where found selector value is updated
>> + * @found:    flag to indicate that given value was in the range
>> + *
>> + * Scan array of ranges for selector for which range value matches 
>> given
>> + * input value. Value is matching if it is equal or higher than 
>> given value
>> + * If given value is found to be in a range scanning is stopped and 
>> @found is
>> + * set true. If a range with values greater than given value is found
>> + * but the range min is being greater than given value, then the 
>> range's
>> + * lowest selector is updated to @selector and scanning is stopped.
>
> Is there a reason why the scanning is stopped here? What ensures that 
> the rest of the ranges wouldn't contain a better match?
>
> The logic is now different from the 
> linear_range_get_selector_low_array(), and I would like to understand 
> why? It'd be nice if these APIs were 'symmetric' to avoid confusion. 
> Hence, I would like to know rationale behind making them different.


The rationale for this being asymmetric is to find the tightest upper 
bound for `value` < minimum value across the linear range array.

To better illustrate this with an example. I have 2 entries in the 
linear range array [ [4, 8], [11, 15] ]. Let's assume I pass a value of "2".

Based on my current approach, the call to get_selector_high() would 
successfully return with `found`=false and a selector value 
corresponding to "4".

However, if I continued to search, I would end up the selector 
corresponding to "11". A selector corresponding to "4" is much 
closer/tighter than "2".

For values higher than the highest value in any range, this would keep 
iterating and end up returning an -EINVAL.

For in range values this would work as expected.

This implementation assumes that the linear ranges are provided in 
sorted order, an assumption that I believe already underlies the 
existing *_low_array() logic.


Regards,

Amit

>
>> + *
>> + * Return: 0 on success, -EINVAL if range array is invalid or does 
>> not contain
>> + * range with a value greater or equal to given value
>> + */
>> +int linear_range_get_selector_high_array(const struct linear_range *r,
>> +                     int ranges, unsigned int val,
>> +                     unsigned int *selector, bool *found)
>> +{
>> +    int i;
>> +    int ret;
>> +
>> +    for (i = 0; i < ranges; i++) {
>> +        ret = linear_range_get_selector_high(&r[i], val, selector,
>> +                             found);
>> +        if (!ret)
>> +            return 0;
>> +    }
>> +
>> +    return -EINVAL;
>> +}
>> +EXPORT_SYMBOL_GPL(linear_range_get_selector_high_array);
>> +
>>   /**
>>    * linear_range_get_selector_within - return linear range selector 
>> for value
>>    * @r:        pointer to linear range where selector is looked from
>>
>
>

