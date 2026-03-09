Return-Path: <linux-pm+bounces-43923-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EqhFXU4rmlyAgIAu9opvQ
	(envelope-from <linux-pm+bounces-43923-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 04:03:17 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C0A2336EA
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 04:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB0AA3009511
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2026 03:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DDD258EFF;
	Mon,  9 Mar 2026 03:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EyjJwkFV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE54187FE4
	for <linux-pm@vger.kernel.org>; Mon,  9 Mar 2026 03:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773025374; cv=none; b=imrM2t4L8r1NwNcR9BsLTuL+4UPCvCkPKu4z4LUwP0cTjhNk1jHuPO4x1gA9s+57I13/i0O2HLtHbmXhT4FJnOHX/LQT74yrC5EnNg33SuDGUygenBxh1M5M+SG6rXjBVrdeU6dab4ByHwKnbnr6f7e5tJmmd0nBrQq+ijQ3/e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773025374; c=relaxed/simple;
	bh=BGjkXwXFeJle68octNDMR19EHMWwrZil3s7gHM3J0bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jWxWnOxJeP+eW7K6L/RTaG+0oxrczAtdUjA2lLpvjAhif1DBawRlR91MwmotVqE9UxOCMDWxO7MBNJE9sOmdOlEOHqxuPuGruk+kYriaZxvC2gKXeuFvo2YB3wj5Y3opVML19HoblH5eMmcaiDI1rfqVLqXUMycJaGuh3wrOIb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EyjJwkFV; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64c9c8f8783so11460488d50.1
        for <linux-pm@vger.kernel.org>; Sun, 08 Mar 2026 20:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773025373; x=1773630173; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DRC/SSBoLNJpBv7w3HXObuyQkJlK3e7PgCYEr0NFv4U=;
        b=EyjJwkFVWzJNjMAd6yOjTRBmZI7d9gOhHIWC21TOHKITr6YTn9n4l80Xu7Pv18+KyU
         kfWBI6ymCmL4PPjGirEcqKsY4XEHfQ+nt2VQwUr5YItaGNOJNOpIzLggBVIP4zMt5Exy
         gt0gHwPViT7fTLnvyFaqp80/4bj6v3USQOkZr3LbykPGuBMqRF5NSX+IZerO/8k1qPrM
         wph0+noQ0rCJyoiBOpuaE1cEaGDY3fDA0Fh7DCydJN4afYBApqo080AIjY7REwMFbghg
         YPZAmb7nF1afmRviKdDmGihbZWLeodHLdKmQSrywDUC1oea6A9eyaDCXwYVmWvcuwSEw
         3WNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773025373; x=1773630173;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DRC/SSBoLNJpBv7w3HXObuyQkJlK3e7PgCYEr0NFv4U=;
        b=gccdlHXQcx2wSu1nD88uzOOqjo0mYIEXvGguUkeAkxtgZhqwRTtpcqCtkVSh0FichN
         OHoL/YXWw1gA43oP6+hOlZGvvf70LDbSqhXFL+uPUhiOnkRfhb3D3pKdEVA8zLxj2Q/p
         u6nWfOXDkyOFgx4D3iZ++DYf9VeWYpBFcEjSf9eHUp2TagV/PySvHcb7Ti8Sr/EPPf85
         uMonK72analWv4/+hgWRCOJO3R4OrbT8Qk6qg5p+UskBM5ih2hBssLQquFrZ9GJWoUhB
         Ch2WdkucNi+RwtkjDugE8/gue+pvndA+NCUtPb98aVzHAkVfQMZcUNfh50srgNnCOHbb
         vsbw==
X-Forwarded-Encrypted: i=1; AJvYcCUn7oEI5N83DZ24FaURh00c9XwzKpERYW+f6W05tIRizW3AZ4b0lGk/YdTqP6JMM3C4VoQFt6eMqw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwznQO/864dRNT9mcnb0e8HUWX/e2SohcZ3jf5/aDbPR/fUGQEc
	WiREZEESEdyOqGpcL16EogAYFyrnd37c+6VVZwm4bWhZCGHhzHz0CG53TzqAFB/8Xw==
X-Gm-Gg: ATEYQzyVDey9XIZGPbWCSNopkxpvB9A2/RkmyA1bJdpLUGCdA03BzOkE+ISCYuO5L35
	eYnLJvhGFNsRG/REBdwQU8ERs9SrXzi9ez2xDWhw3Y/SCCqF8Tn/s1f3cv9ZENJEUrBKhGO542t
	s5fYDjzTTWbINPTjaMMmxYbNmHZMR34n1Mdg0/uL+UpJDRnUKeNvtETB8WEA0ZuyLiOQGISHDfY
	UkAt9v9RvE2fAATXeQ/6X7nSCR3Fnk52dTpqOrV8UQ/VKAEvCg6MlDcaguMUJotgycia+C4zA3u
	2g9ru4Th54Kr4+Iwl+4TVq9gpvKZlexbNk2LGMt1zJmZ88FuUNyUT4E0AdsbmmAraay9NCaY+SZ
	AS2hvE/SNk0QP3bg1Q0omIriJNXN66OHWZ7pO1nuVsSLI8Q0EsAsM8VVMjtd5DyDXjmY6ASHj6x
	w+LeH84t3nPrcDcqXT3yL22wynD+v/5koPezeAyZkCvbpM1CZGvM7o4BvxPZsyddkzpBCfu3M=
X-Received: by 2002:a05:690e:1186:b0:64a:7bf2:3afa with SMTP id 956f58d0204a3-64d0715a07dmr12447389d50.28.1773025372369;
        Sun, 08 Mar 2026 20:02:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:4570:89a0:3329:ea09:3c41:e7ec? ([2600:1700:4570:89a0:3329:ea09:3c41:e7ec])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64d176c59dbsm4094408d50.11.2026.03.08.20.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Mar 2026 20:02:51 -0700 (PDT)
Message-ID: <103a2828-c567-4b95-8583-e2358ccfc1f6@google.com>
Date: Sun, 8 Mar 2026 20:02:42 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/6] mfd: max77759: add register bitmasks and modify
 irq configs for charger
To: Lee Jones <lee@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Badhri Jagan Sridharan <badhri@google.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Mark Brown <broonie@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, RD Babiera <rdbabiera@google.com>,
 Kyle Tso <kyletso@google.com>
References: <20260224-max77759-charger-v8-0-eb86bd570e9c@google.com>
 <20260224-max77759-charger-v8-3-eb86bd570e9c@google.com>
 <20260306130031.GK183676@google.com>
From: Amit Sunil Dhamne <amitsd@google.com>
Content-Language: en-US
In-Reply-To: <20260306130031.GK183676@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C4C0A2336EA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,linuxfoundation.org,google.com,linux.intel.com,samsung.com,gmail.com,linux-foundation.org,vger.kernel.org,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TAGGED_FROM(0.00)[bounces-43923-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amitsd@google.com,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.990];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hi Lee,

On 3/6/26 5:00 AM, Lee Jones wrote:
> On Tue, 24 Feb 2026, Amit Sunil Dhamne via B4 Relay wrote:
>
>> From: Amit Sunil Dhamne <amitsd@google.com>
>>
>> Add register bitmasks for charger function.
>> In addition split the charger IRQs further such that each bit represents
>> an IRQ downstream of charger regmap irq chip. In addition populate the
>> ack_base to offload irq ack to the regmap irq chip framework.
>>
>> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
>> Reviewed-by: André Draszik <andre.draszik@linaro.org>
>> ---
>>  drivers/mfd/max77759.c       |  91 ++++++++++++++++++++--
>>  include/linux/mfd/max77759.h | 176 ++++++++++++++++++++++++++++++++++++-------
>>  2 files changed, 230 insertions(+), 37 deletions(-)
> Does this patch have any dependents or dependencies?
>
This patch does not depend on any other patch.

The patch that depends on this one is:
https://lore.kernel.org/all/20260224-max77759-charger-v8-5-eb86bd570e9c@google.com/


Thanks,

Amit



