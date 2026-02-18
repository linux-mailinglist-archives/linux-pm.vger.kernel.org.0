Return-Path: <linux-pm+bounces-42840-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id tIxjM5QblmkuaQIAu9opvQ
	(envelope-from <linux-pm+bounces-42840-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 21:05:40 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C78159520
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 21:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 806FF301B737
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 20:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2C6346ACD;
	Wed, 18 Feb 2026 20:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dRPrj7he"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B4531ED64
	for <linux-pm@vger.kernel.org>; Wed, 18 Feb 2026 20:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771445137; cv=none; b=KhBvuS2Xd/KQVGZ9hKJ2vZqfYn7QjmBHHA+p9Z5auohrYlqaqNBbAjXBKwShY10PQdgllNDvv3IY0hKxVwYYok6yp3OsLI6dKDHpSUJIwaH6191v97UuITd+wBPXUFwpdIgKb+7aYCdUp9TZmLbst2Oh4AAE70Pl4/AubtIhbqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771445137; c=relaxed/simple;
	bh=Eb8WztYruLPtpbjUq44P2hChG8R4NOCFEJN+uEHJMMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=itInlR05F+dEkXW/Jqs47nOXh6RiSYLuhqYOodd8ehfbOm2c7qWZh4O991AKosTY4bOV1sYXCyAMDd5A1M3UarEuJiflqsyf/xmkdEbs1QQKK1NRN8CjHwQzTZ/0eVhlwaoA0rLdktXvJxJH24Symz6zhkJB8EW25Mtri8Q4gXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dRPrj7he; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2b86671f87eso356363eec.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Feb 2026 12:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771445136; x=1772049936; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ruwMDgtbpwkbLzJMSDs2l3vNnZLc2ZiEeFBqv+MGVhg=;
        b=dRPrj7heC/vfUsmGojrAEh7xjifEi2K+5ikryz/EC9J7P9XlzGI3qouVczByYM1bGd
         yTSj+o7bCuk6WcccyIG3fu+Qvr8BYPYzEY/rp2tc9+LtVIELy3ewyj5gLQqx/ttugou2
         0kkowdferefjOvocOP+WvlEyCgQ7ThxJ6i/Oo7fBIJ8Kk3CEGvEeNe+x3TBwi5rl8XnR
         Ulepf87PwFOUUQTO3AB/y0T87WU81BSx+ioby/YFLsiSmLZE3n6NlzPUauHKHAnbKZSG
         RaKVr/l+aLWp/KiH4qiVdYH4EEZoqfLlmIZITWaC5hzCNUgWKyQZTPwjPzUU5gOJc6NV
         4hVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771445136; x=1772049936;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ruwMDgtbpwkbLzJMSDs2l3vNnZLc2ZiEeFBqv+MGVhg=;
        b=oEEDZoaIXx9LeEJlfBHMnSk1dtx0yeNVWLWyCKlN4LIKtHar/S4BN9sr2UJ6zPExqK
         al2rsIE3u6KupGyicURbSK0gg0+6fGr/aMLFrVj7ze9zKfCsJ4CiCPnIR3nGhO53jo8f
         ML2I3MXjt2RygcLrNde0RfRmNvlHiSpLwCm+gvVUIq9w5V6cjtSpHmTQSN2hynZANScc
         4PhftkcQF2mnPwPp0vj+sTR+euDKJ5MtN4fWN4y/i9hKQuTTp8lXYRcWGne6FzJey1a1
         30ACtwUsXFCGFep6IIXgr1OgYyV4c4gfnAY3nvbVyWSW9hhj1+MNu5VG91V8dzhdsMYR
         bxvA==
X-Forwarded-Encrypted: i=1; AJvYcCXMnunQkwO5U/8wpJiecRbdQ3vzyYx0cibA+ClSQUn0RzRVMn0MYgimIM2OB0IBe515zfx0xCr9DQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTQ5xIovdveAzcwJjVQquqfbNnZeErRQtAZl7wR+ATuBQyGtvw
	dGhudZUMtO3oWv1s8jZ1AkH5OTMCajooPrKV8NkziUCd95dw/Iz5t46W/7LkNqAsTA==
X-Gm-Gg: AZuq6aLzTnSjDEZf4t/fFz1x+1NhqxHmkG/fkLlqwv0xYimg6qEtgQPd9HXSMnJ8zpC
	MVn2TeTQLLWEjiQigc/4zOZ5NSO0vFsCj5TfqIrVPNq0MaqKTQjOU4A7bn4kS12sKFtfhS5ewbP
	jM6ToY9xPeEEUxw5k6oe/UHT/TiLYeqZOFJXytXbUhWznb7Pub6VpHv7uXCrTT5XzUlM49n3CdF
	N9WnlwPzZhDcE84qg80PWD5GCQrfiSrP28ZWNaHKZTf0Y8WjpIKBOFUKb/ZssiKW6aM+W7SBmzn
	rfiOOLvFzul33PgtTLTXKa3cv6b+za3dExe7X+XQpBcrtjSYt1LNBisXhd6zrfilhUBb6pSzzIU
	uA/4BK3pbx7zL/IV6r3Keai4y/wDQD1KGGhO/k0EiT2Akd1ZG8ywHpqSS+ZvrDRCdRnjeCSGSfP
	xIFYBP89GnrAnn3lOHLNSkPkkX7yfFPax8qXZmWXDQVNHNErX5JZ+lBYphMWmrtE5zKxJ7fZAPJ
	x25mglWkcd/Pbykmu2Bjl3jDA==
X-Received: by 2002:a05:7301:100e:b0:2ba:a04a:8353 with SMTP id 5a478bee46e88-2babc44eb66mr9413193eec.27.1771445135121;
        Wed, 18 Feb 2026 12:05:35 -0800 (PST)
Received: from ?IPV6:2a00:79e0:2e7c:8:c8f1:53bf:725c:563b? ([2a00:79e0:2e7c:8:c8f1:53bf:725c:563b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb543e8dsm19410069eec.5.2026.02.18.12.05.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Feb 2026 12:05:34 -0800 (PST)
Message-ID: <e9a353aa-1194-4c87-b902-c533e52c264e@google.com>
Date: Wed, 18 Feb 2026 12:05:32 -0800
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
 <b1df24fd-bbb6-4991-be52-dc1ef694db25@google.com>
 <66dab64b-ca3e-4ae0-81d6-0500899757e5@gmail.com>
Content-Language: en-US
From: Amit Sunil Dhamne <amitsd@google.com>
In-Reply-To: <66dab64b-ca3e-4ae0-81d6-0500899757e5@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-42840-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,linaro.org,linuxfoundation.org,google.com,linux.intel.com,samsung.com,linux-foundation.org];
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
X-Rspamd-Queue-Id: 22C78159520
X-Rspamd-Action: no action


On 2/18/26 12:17 AM, Matti Vaittinen wrote:
> On 18/02/2026 03:45, Amit Sunil Dhamne wrote:
>>
>> On 2/16/26 5:58 AM, Matti Vaittinen wrote:
>>> On 14/02/2026 05:12, Amit Sunil Dhamne via B4 Relay wrote:
>>>> From: Amit Sunil Dhamne <amitsd@google.com>
>
> // snip
>
>>>> --- a/lib/linear_ranges.c
>>>> +++ b/lib/linear_ranges.c
>>>> @@ -241,6 +241,42 @@ int linear_range_get_selector_high(const 
>>>> struct linear_range *r,
>>>>   }
>>>>   EXPORT_SYMBOL_GPL(linear_range_get_selector_high);
>>>>   +/**
>>>> + * linear_range_get_selector_high_array - return linear range 
>>>> selector for value
>>>> + * @r:        pointer to array of linear ranges where selector is 
>>>> looked from
>>>> + * @ranges:    amount of ranges to scan from array
>>>> + * @val:    value for which the selector is searched
>>>> + * @selector:    address where found selector value is updated
>>>> + * @found:    flag to indicate that given value was in the range
>>>> + *
>>>> + * Scan array of ranges for selector for which range value matches 
>>>> given
>>>> + * input value. Value is matching if it is equal or higher than 
>>>> given value
>>>> + * If given value is found to be in a range scanning is stopped 
>>>> and @found is
>>>> + * set true. If a range with values greater than given value is found
>>>> + * but the range min is being greater than given value, then the 
>>>> range's
>>>> + * lowest selector is updated to @selector and scanning is stopped.
>>>
>>> Is there a reason why the scanning is stopped here? What ensures 
>>> that the rest of the ranges wouldn't contain a better match?
>>>
>>> The logic is now different from the 
>>> linear_range_get_selector_low_array(), and I would like to 
>>> understand why? It'd be nice if these APIs were 'symmetric' to avoid 
>>> confusion. Hence, I would like to know rationale behind making them 
>>> different.
>>
>>
>> The rationale for this being asymmetric is to find the tightest upper 
>> bound for `value` < minimum value across the linear range array.
>>
>> To better illustrate this with an example. I have 2 entries in the 
>> linear range array [ [4, 8], [11, 15] ]. Let's assume I pass a value 
>> of "2".
>>
>> Based on my current approach, the call to get_selector_high() would 
>> successfully return with `found`=false and a selector value 
>> corresponding to "4".
>>
>> However, if I continued to search, I would end up the selector 
>> corresponding to "11". A selector corresponding to "4" is much 
>> closer/ tighter than "2".
>>
>> For values higher than the highest value in any range, this would 
>> keep iterating and end up returning an -EINVAL.
>>
>> For in range values this would work as expected.
>>
>> This implementation assumes that the linear ranges are provided in 
>> sorted order, an assumption that I believe already underlies the 
>> existing *_low_array() logic.
>
> Ah. I think ... I didn't think. :)
>
> It definitely makes sense to stop scanning if the range_min already 
> was greater than the given target value. Thanks for the patience and 
> for adding this missing piece :)
>
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>


Thanks for the review! :)


Regards,

Amit

>
>
> ---
> Matti Vaittinen
> Linux kernel developer at ROHM Semiconductors
> Oulu Finland
>
> ~~ When things go utterly wrong vim users can always type :help! ~~

