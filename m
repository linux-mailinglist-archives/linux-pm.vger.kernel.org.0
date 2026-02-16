Return-Path: <linux-pm+bounces-42698-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPm2B4Ejk2kX1wEAu9opvQ
	(envelope-from <linux-pm+bounces-42698-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 15:02:41 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D621144629
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 15:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6D1B301F497
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 13:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C4630EF82;
	Mon, 16 Feb 2026 13:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Orl3VpCZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39076301037
	for <linux-pm@vger.kernel.org>; Mon, 16 Feb 2026 13:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771250314; cv=none; b=ulBKdoWqhswCmFGb4wNFUzdO91HyMm6CASug6yX25oyqAIulEoTBZc1cXfqn/ACQt+xKSxvr9epqUzGjKMky5bo56Vo/ET8LPlyLfcgtdL7mezlcSGGXXUv+9fmP9b1mLzYgHZfABoRe090D1o35E8GH+1+BzSAHhtwPpx2Tew0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771250314; c=relaxed/simple;
	bh=JudCYDKTAao9yvz1obQeEFLjpJHRjDhkH80IAq3x6uY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HHbgfJIkAk4Uo3FIllUgKhzSMvyAOjlhWzR4I5tycBG3Tep3PL7UE1ZRHdlNVz/wofkBUuxG6wQ3rHAcAVwmoUkBy5vFS6SwFFyAVoD7isTieyx8EkuZjKXq3+vd4s4np9yQwpFCf5uuVemOD0BJr+ztm67gdYCuZeNZhfglxhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Orl3VpCZ; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59e60b3ccdfso4485781e87.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Feb 2026 05:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771250311; x=1771855111; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rUcAGLQZkv/PTBs//eYKKwXahaszOterbl1vVyU8vuo=;
        b=Orl3VpCZVgtxL7MpZh1NnWlx2fyQTWtrIKVH6nsudChRBkNWr52BLzHjewFb5rb7pN
         HubWuhvIET2AZmou4zCDw210uFqVfcuH209nQuWT3wKo318bb2jWFzmRN/mplBEPQE8O
         J+AIN3NaN0Tyy9367E9yuKF9bus9tUPDTIZVEsmksjb4WnpF/G1Q6B4JMeRi9E5WLate
         q1jCL8jtPY1PynwXqrTlDx2HbtzBgR4zc9qSYs8WuWL7bF8b7h/EEXOsuyGuaeRpsLOu
         5XTN/OIYNYSllIFsYDHuOGlAVo/ZU5fCcjorQnbtIoLnkcJcu064QyRdIVbpiPGBhK5B
         IknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771250311; x=1771855111;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rUcAGLQZkv/PTBs//eYKKwXahaszOterbl1vVyU8vuo=;
        b=EKrMBkV6BcVzNPqIJLEAP3a5iuucXIYr9nexqrUbuoA/5968NlvpeunJkXsZ5HWNN1
         BNx3KNH5bBPlfce47+uagi11IpZjVtkv6WabpRSr0KR1djd9rhYdPuGI+s/V/ibZN2Sj
         xfUh5jimSinPtFGQ6D4NBGkfKeR9H/M+dtqu/KK/7quJZaI5PkEwqLZxKf+ePw+KLvKy
         CRgy2LAkCvw7HKaH30Rh5f0Qg/0qeHMfIPLYNzMR7IhgSiSOR9XPfDvhRkboV2eAdBAe
         nvPU8END9zyibwRSSrI3hI2U6Kiy/EjtS+fnqIxb2FZhu3JCV3+FlMUWY6/wA6p2vbw1
         nFMg==
X-Forwarded-Encrypted: i=1; AJvYcCWTH/1ph3Y/VA+tn0H3sb5H048Jk87VpvRbX613No5SYLqNKLD7IxNj+8BI8B9cySpVd0zwrnxZ9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEriQLFEXBYYXUzq17fF+B0fm4Uj/gSgpeWiXtjGPy8IjrZYFF
	YXqYV1UqH1/vrsxfsJ/zprnjLMlZmKDdyWe94mFlQVd0t5g5jv0J+mas
X-Gm-Gg: AZuq6aJY6eIaFdFndqiiTvlzZtr7KK+i5+Omuu8XMBScwHE2VtWsPfMoCR8djAuLbuO
	V/9pwOAtWvqlquaU1X4QdDcq/Sug4wa4aOUYpCxyTm/jkDhAVINMSFDK9JI5hxBEdBSMcixdWmf
	GCd7aJp1qk0DzmzxnujR/+Ahlkxugpi4kYjmPaaSUO8BHoUWGQnw9+elVRLFlPfACN8mYvhM/kG
	tcYAQmywWicn/HcikM5MMFj1sEelVteR/W0BvHvRwiJ/rXN2tE/HbaNoEqhUZSlvWqggR1EJ3HC
	YPOAhHcmooKc+LSuOoFv/TSmWbwY4vly8JjM7VaoGdEH3NTyiFNB5WSOVyoPPKI/zYJuwNdJBbM
	JW6eTnpHspXQGQctDESvOkhkim/ZvWQZdYxaV5eG3lKa3CngHa20y3WchLP3PWU9WRwBmQf0vZ3
	hh0fv1AK/YgNp5De+9LwS3IWTFl2Mcld0ZW7HB2EqBPwk=
X-Received: by 2002:a05:6512:145a:10b0:59f:6db3:1526 with SMTP id 2adb3069b0e04-59f6db316f1mr1715840e87.10.1771250311130;
        Mon, 16 Feb 2026 05:58:31 -0800 (PST)
Received: from [10.38.18.54] ([213.255.186.37])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e5f5b2223sm3224103e87.79.2026.02.16.05.58.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 05:58:30 -0800 (PST)
Message-ID: <5d889f66-7697-4a39-beed-33ace693a1ef@gmail.com>
Date: Mon, 16 Feb 2026 15:58:28 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/6] lib/linear_ranges: Add
 linear_range_get_selector_high_array
To: amitsd@google.com, Sebastian Reichel <sre@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?=
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
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20260214-max77759-charger-v6-4-28c09bda74b4@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42698-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mazziesaccount@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D621144629
X-Rspamd-Action: no action

On 14/02/2026 05:12, Amit Sunil Dhamne via B4 Relay wrote:
> From: Amit Sunil Dhamne <amitsd@google.com>
> 
> Add a helper function to find the selector for a given value in a linear
> range array. The selector should be such that the value it represents
> should be higher or equal to the given value.
> 
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> ---
>   include/linux/linear_range.h |  3 +++
>   lib/linear_ranges.c          | 36 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 39 insertions(+)
> 
> diff --git a/include/linux/linear_range.h b/include/linux/linear_range.h
> index 2e4f4c3539c0..0f3037f1a94f 100644
> --- a/include/linux/linear_range.h
> +++ b/include/linux/linear_range.h
> @@ -57,5 +57,8 @@ void linear_range_get_selector_within(const struct linear_range *r,
>   int linear_range_get_selector_low_array(const struct linear_range *r,
>   					int ranges, unsigned int val,
>   					unsigned int *selector, bool *found);
> +int linear_range_get_selector_high_array(const struct linear_range *r,
> +					 int ranges, unsigned int val,
> +					 unsigned int *selector, bool *found);
>   
>   #endif
> diff --git a/lib/linear_ranges.c b/lib/linear_ranges.c
> index a1a7dfa881de..c85583678f6b 100644
> --- a/lib/linear_ranges.c
> +++ b/lib/linear_ranges.c
> @@ -241,6 +241,42 @@ int linear_range_get_selector_high(const struct linear_range *r,
>   }
>   EXPORT_SYMBOL_GPL(linear_range_get_selector_high);
>   
> +/**
> + * linear_range_get_selector_high_array - return linear range selector for value
> + * @r:		pointer to array of linear ranges where selector is looked from
> + * @ranges:	amount of ranges to scan from array
> + * @val:	value for which the selector is searched
> + * @selector:	address where found selector value is updated
> + * @found:	flag to indicate that given value was in the range
> + *
> + * Scan array of ranges for selector for which range value matches given
> + * input value. Value is matching if it is equal or higher than given value
> + * If given value is found to be in a range scanning is stopped and @found is
> + * set true. If a range with values greater than given value is found
> + * but the range min is being greater than given value, then the range's
> + * lowest selector is updated to @selector and scanning is stopped.

Is there a reason why the scanning is stopped here? What ensures that 
the rest of the ranges wouldn't contain a better match?

The logic is now different from the 
linear_range_get_selector_low_array(), and I would like to understand 
why? It'd be nice if these APIs were 'symmetric' to avoid confusion. 
Hence, I would like to know rationale behind making them different.

> + *
> + * Return: 0 on success, -EINVAL if range array is invalid or does not contain
> + * range with a value greater or equal to given value
> + */
> +int linear_range_get_selector_high_array(const struct linear_range *r,
> +					 int ranges, unsigned int val,
> +					 unsigned int *selector, bool *found)
> +{
> +	int i;
> +	int ret;
> +
> +	for (i = 0; i < ranges; i++) {
> +		ret = linear_range_get_selector_high(&r[i], val, selector,
> +						     found);
> +		if (!ret)
> +			return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL_GPL(linear_range_get_selector_high_array);
> +
>   /**
>    * linear_range_get_selector_within - return linear range selector for value
>    * @r:		pointer to linear range where selector is looked from
> 


-- 
---
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

