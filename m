Return-Path: <linux-pm+bounces-29645-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83685AEB312
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 11:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09BF47A3B80
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 09:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A952E293C63;
	Fri, 27 Jun 2025 09:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlsgBS/2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1468F293B5E;
	Fri, 27 Jun 2025 09:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751016991; cv=none; b=DHC28Sh88dRxfaOcJzjyoSx3hutcn7BBNFRi+PMQ1U7nuRFn3xBE2kXLoKEccGDmaiS8XYwwfR38kaAVwY4WX5jZTFDtr8kBAWOXkLdxKOhq0y90nHQS0wfqIfUIHakDY+Ywc/IboeqPhCn3lmuktad4AEwIPfZL26tq975eVxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751016991; c=relaxed/simple;
	bh=Wu9AW5CnKuIsby46cmtnIf8gL/Rv77+ilEl2eeG6L5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g3U50OybWorbTM5QOLzWJcT8fN58Gaq0E9oDoRb96VT1749XkSopBUaOly99zlG179Gj6x5CGbQOki5UO/hdjviOPKeomnW7zhQwM48PkssV+Eof5V5QoiSunxAoyw/q6n4Mk/A6OAsiUtzVVMKwziDjXmRT2CjbvxOlTV/7zTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlsgBS/2; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-451dbe494d6so18591045e9.1;
        Fri, 27 Jun 2025 02:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751016988; x=1751621788; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p5fCnamO77K411kdyNNvZ5VlXfxiHYsxT++vTJt6tpU=;
        b=IlsgBS/2yYOMYp6/BW4tq+sfYA9VyXhrMWdNbq3zdaqktXpmegSns7nHsJWbtexkcN
         fj8KK/FjtU+hkjckMA0L5bbhxFoXTPw8MthM9zKy9AuE8DBPFnYp4gofHiaarcpE865+
         3CRW+HheZCsAWK65LGur+dNr7GfV8h1a9qlyBLmaGrvZkJ70kd4SQ/Huu0KGGNyIQL5d
         KU2HtNxMS68w0yHHKnO7pVsmLIY1CNzvzg186ADIRNmrjYapccmp5d3vi0iOQnlUBaTc
         pNYMmT7T7vbP/KwXMd7y7+4gCi+mZirzlo8Lq7ykwcAj9YjIfPHZ6h76W4RsSkl6mOEV
         EXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751016988; x=1751621788;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p5fCnamO77K411kdyNNvZ5VlXfxiHYsxT++vTJt6tpU=;
        b=iYFTKeT7XQ80UA6aRfV2AcKHoG7gvYIAP6CWMAAhuiJOXuk8j/mT8VHq17wQRtn4Nm
         H0OC2GXK5c1My3/JVprVsNZu9uUd4Kp3wG4Lj4xE7AU/GknKlhvYXjZM2cYORO8VOXsC
         SLXt63hjiysPRdYZVUPcbsuD89TN+41C0zXzeenH5yYYbQJyUXGmXh0zUfs6Eq1inXqC
         Mgto/u7Q+qlHG5MVObxyWo0bppY0y6EAfsUcJ4l4V/Q6elP7qOzOx4tkC22yHpHO5x0N
         lXfGdRCa8DMErlQAYwBZoNKbyt4AiCD92ydCsm5SDiW6iaMP4/+b9DdXtpgFFqvQcNwY
         dLXw==
X-Forwarded-Encrypted: i=1; AJvYcCUKf7mTbZkWShz8B++ridnTJnbeQTK0d73if+dQKxFYr79KNZyTuWxy+JjLs1uF2ow27asCOwuml41gWJqf@vger.kernel.org, AJvYcCWS5pr1K3byfxlMQQb9yGTI1e6qUPSUTd/xU1LLBw99OINlb/54QFeX2bYnCiLZi2LITqrXM5CDVP/qUcXo@vger.kernel.org, AJvYcCWqh+0NQf7NbvmrSV5vIt9Q2NRpX8HCEN2xfxs1hNAaaXMle8t/cu/4Jhrj0rhvU+rPLnXM7xBUoQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK54crk91nX/uaBivXW8T8JU3R/IzOF5QDraJzCFdCa59orDAv
	agEvfX+IHDm40cXkD1E2L4t19o7RxS0wQ47T1fO8qq7W/IqvVl+W2Tdc
X-Gm-Gg: ASbGncseFrThhcg+FSsJnZPWGfmHHU9VlJdT9GCsrVR/frWDScVwNmQ4nLPQYgnPbk/
	t6woiDGd8CR2RNEEtinE/FIv7z5MYBnxHXrEQcQLvhGQL3ShEZt57tbs8vohZhhBNd/X+d3XmxA
	RBEdXAUJznSFBmvbNZQnjP8Kal5tSfS06AzUSdBIO1ZWCSQjiM324qIrTBDSZ3p3I2ZKluWouTo
	MQrACSNueQhs6v8hcZjcqgLVselcJ6T7z4O7qiEm7RehCMXScZv6wGz02UZkBByHwmosv2aXsHS
	7FUldDbvEPhptA1sHqzpx22XlHVR5pVJOuzTOnw4elu2JNbcYu1rVuS9LiULT6YZG6PjiGyJuG+
	oOuXfCOISQ5Z/6eMtEXzEUTRC/XE=
X-Google-Smtp-Source: AGHT+IHslSlEJb0qJ8a/g6NKoqQQ/b+PHsN+VXsoOgNq4hHwuu5INnGw1Tk3qJ/8yaYzQ22Rhmjf7Q==
X-Received: by 2002:a05:6000:2810:b0:3a6:e1bb:a083 with SMTP id ffacd0b85a97d-3a8f4ee111emr1797485f8f.25.1751016988077;
        Fri, 27 Jun 2025 02:36:28 -0700 (PDT)
Received: from [192.168.20.170] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a3a68d7sm45777285e9.14.2025.06.27.02.36.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 02:36:27 -0700 (PDT)
Message-ID: <b960680d-6c5a-4130-b2dd-4ddf1f800430@gmail.com>
Date: Fri, 27 Jun 2025 11:36:26 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] interconnect: avoid memory allocation when
 'icc_bw_lock' is held
Content-Language: hu
To: Johan Hovold <johan@kernel.org>
Cc: Georgi Djakov <djakov@kernel.org>,
 Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
 Johan Hovold <johan+linaro@kernel.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, linux-pm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250625-icc-bw-lockdep-v3-1-2b8f8b8987c4@gmail.com>
 <aFvr1zSkf4KmIcMT@hovoldconsulting.com>
 <aFvuiVX0kMIqXQtZ@hovoldconsulting.com>
 <84b94649-a248-46b0-a401-772aeb8777a2@gmail.com>
 <aFwBYRF0wJwVDdeX@hovoldconsulting.com>
 <ac5ba192-b538-457e-acc4-c2d358b1fd0e@gmail.com>
 <aF0TIWfDI4M1azzc@hovoldconsulting.com>
 <3b90caec-b4c0-47d8-bdd7-1a7abd5e69d9@gmail.com>
 <aF5EPhd5smrmB38Q@hovoldconsulting.com>
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <aF5EPhd5smrmB38Q@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2025. 06. 27. 9:11 keltezéssel, Johan Hovold írta:
> On Thu, Jun 26, 2025 at 05:00:42PM +0200, Gabor Juhos wrote:
>> 2025. 06. 26. 11:30 keltezéssel, Johan Hovold írta:
> 
>>> Note that this could be extended with a
>>> name-allocated flag and an appropriate warning somewhere later if anyone
>>> is worried about drivers failing to use the helper.
>>>
>>> Note that we can't use kfree_const() unconditionally as I initially
>>> intended as apparently some interconnect providers already allocate
>>> names for non-dynamic nodes.
>>
>> Not that I want to worry about anything, but for the sake of completeness I have
>> to note something. Theoretically, freeing the name in icc_node_destroy() could
>> cause the following on IPQ9574 under some circumstances:
>>
>>   [    4.003692] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffffff80047e4180 pfn:0x447e4
>>   [    4.008439] flags: 0x0(zone=0)
>>   [    4.017545] raw: 0000000000000000 fffffffec0000448 ffffff803fdbb518 0000000000000000
>>   [    4.020480] raw: ffffff80047e4180 0000000000150000 00000000ffffffff 0000000000000000
>>   [    4.028413] page dumped because: Not a kmalloc allocation
>>
>> It is not a problem of your patch though. The root cause of this is the same
>> as why I saw the lockdep warning on the platform originally. The reason is
>> that the static node ids used by the 'nsscc-ipq9574' driver are within the
>> range of dynamic ids. Nevertheless, I have sent a patch [1] to fix that
>> already.
> 
> Yeah, I saw that patch of yours the other day. Good that you tracked
> that down. I'll probably amend the commit message with a comment about
> why this triggered on IPQ in the first place too.
> 
>> Despite the note above, your proposal looks good to me. Would you like to
>> send it as a formal patch, or shall I do it?
> 
> I can post it in a bit.

Great, just saw the final patch. Thank you!

Regards,
Gabor


