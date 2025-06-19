Return-Path: <linux-pm+bounces-29076-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06ED8AE0679
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 15:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 472B27A5C18
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 13:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9F5242D6B;
	Thu, 19 Jun 2025 13:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHxgR996"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B485614F9F7;
	Thu, 19 Jun 2025 13:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750338235; cv=none; b=i/3AmsmEDKQCUFsUkSeaCqNpyxBHyJVt5YqM667ONoZD5OuCMwTiEY1qYS16q/fa+qAzHBviXfahcKTyGXHT8KPd/RvhDAKva1h/5RZJmxOVR/swb8Jr0uusqSGqJqJ3t+2ekM/pUTO8W9TXSHEglrjhfFKdiwDhuziO/PBLNgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750338235; c=relaxed/simple;
	bh=O4tMc9uQwIwkBDPImcC6OlkaQaioUu+RSBIBfCQ+Oc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DHOjCaxeHkHnIT+2fvpCwNQV05tCOxf9Ny33kR8+24fRyWcnLpowwO3YLbzS9msfzixuH8so5gzpg07lAetDNR3lM/RH0C11JeK2GbAEafgcoKsK7IMPkJoIG9o1pmivXX2xjXdNQxf7Q/XypBB99ephCuKrqvSqlSOgYnMRehc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHxgR996; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a6cd1a6fecso472734f8f.3;
        Thu, 19 Jun 2025 06:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750338232; x=1750943032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N7h+cG/o7uBxuFHYdxLpyYdK495YEtpak6Y3jjUql6U=;
        b=UHxgR996AkadOQNbqnyTblYTGfiYYRF/Cr4FWp14OVrpTxXZNOgaxUFeeMLbsbZB0e
         mUpbZJLW/nPaLvI0v8dGLz3Qcfv8RcqKYUvij6pBao+IJYrJG1aO5j88xpWNvKMvmGgx
         eQvLbSzAhX6Rm9BtYLcv23/xoxdJJtbWevCiuqDnz/Ia5o2z/6QJ9uPz6h3LTekWpxQY
         Sw1LNSmVCQ9k1TkHVz9mDlne0W3NaCbWxw1wuC3D2+4XuJtFA+8KDFrQmUAcFLf1ra4e
         KXgBxTAtibpU/TPuDMWmMMb/WybCpi4clk5xv9qEY7G7uyuIzd0To2Tm8UjHB5OfpA/g
         Sosg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750338232; x=1750943032;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N7h+cG/o7uBxuFHYdxLpyYdK495YEtpak6Y3jjUql6U=;
        b=Rbl4XtJG3pkq8Y9QPYguDg5plExfcYAE4tw85D9G1ULvbfWonlpLV8C3hRVIj7iwGj
         flQznn1WkqauU3O5ci29/NgSlJFBz3ufCd0FlfQ4SEXbDtJnSzYbnYYxL4WWImaWDwq2
         tYOG4P7n5oC/mErAkFeCrjCUJlCKSh/aP6TfmQK04mCLwiYKWJM7llRpLJhRcJIPl8c5
         +mqnW9trtmqr/e55/5zussFTeKUHqF2S9qvhTHuYKxk8+KNAXSXjN7spfcXnZVXOjCxD
         20Bw/mqNtBOuGhFoyEPuplctAXuMNh+LNF7zLgHw9hyvNo/2U5JNFZMw82f3HaH1iZBb
         lCpQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+fxInR51kY9HIP55LTH1JSzfwQhRDeOD2DMjP+O7lZUdDrZy2LrAFb7pZM5JJX1LgYfpqLD2eBYP/dOVI@vger.kernel.org, AJvYcCV/RkfXeQ10giSG5wqmB7NCcntmRhnrBqzWVvW9ycsBDlGhQ8HjLYIAcaMxOwPDoOoctYa5de7sOXcZn5dL@vger.kernel.org, AJvYcCX6cKrjJdywBEz3Do0HxiRVcCQdNkl4ALVe3xZa728R3w9tmXEHX5PsT0UtlE7YOrwwe1QwwXfUCEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfpMGR2g70qBrOKp5kpGcbC9S9yehht3k0r5JVcSdAuGEMIdMn
	zUwyNoXiX30GoEKEEpmZMo0SqdmzoIC/3uuW0iu9lkV30gcAdvwqOmfO
X-Gm-Gg: ASbGncsTGjbGZa7KrXgehb4A0tt7HtQtNkbTYpFoDRfPgqtex10on2EldH90cjwLFyK
	4JNY3F/h35aMkQtPQXjN+HBFc+nSLLIu07W9A1FHlHN5MNjqdjuexoBVftIyzKSsIJyDgQZom1C
	7AjFRQr/gAlKeKKiR4G9Jjiw5BZVtyrPVNR5azXhtE9cpNarZ3tbgKLQzA6+xbMzoVuZyL//151
	P0QhWSobIcM0uroN5WnOd/b0m4PKU98q576YaEpa3F0cHhhCtv6AwhMNRi+5A47YNRt3d2J2qYJ
	tBmUfXswPSRLSAUbs85RBf2OGsRDAbxHm8pMiS6lVsQ1Z7IOODOjagR5+IyjibsU8mgH6icW8O6
	q3nLx0pv1/nuDpmwk1MSvZEzgeM0=
X-Google-Smtp-Source: AGHT+IGJEuMRSr5D05+h7e+taWYrU2ob8d+XxMO4fb/RdAxNoln/QGFS/oUeCTpl3AaZ9x8V8DSlwQ==
X-Received: by 2002:a05:6000:2308:b0:3a4:deb9:8964 with SMTP id ffacd0b85a97d-3a5723a40b5mr15776186f8f.17.1750338231524;
        Thu, 19 Jun 2025 06:03:51 -0700 (PDT)
Received: from [192.168.20.170] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a6389esm19154486f8f.27.2025.06.19.06.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 06:03:50 -0700 (PDT)
Message-ID: <90bfae80-f3d3-4c1e-9a5c-9f8205bf90b9@gmail.com>
Date: Thu, 19 Jun 2025 15:03:50 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] interconnect: avoid memory allocation when
 'icc_bw_lock' is held
Content-Language: hu
To: Johan Hovold <johan@kernel.org>
Cc: Georgi Djakov <djakov@kernel.org>,
 Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
 Johan Hovold <johan+linaro@kernel.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, linux-pm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250618-icc-bw-lockdep-v2-1-3223da346765@gmail.com>
 <aFPhdWoZDOrdrbQz@hovoldconsulting.com>
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <aFPhdWoZDOrdrbQz@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2025. 06. 19. 12:07 keltezéssel, Johan Hovold írta:
> On Wed, Jun 18, 2025 at 09:58:31PM +0200, Gabor Juhos wrote:
>> The 'icc_bw_lock' mutex is introduced in commit af42269c3523
>> ("interconnect: Fix locking for runpm vs reclaim") in order
>> to decouple serialization of bw aggregation from codepaths
>> that require memory allocation.
>>
>> However commit d30f83d278a9 ("interconnect: core: Add dynamic
>> id allocation support") added a devm_kasprintf() call into a
>> path protected by the 'icc_bw_lock' which causes this lockdep
>> warning (at least on the IPQ9574 platform):
>>
>>     ======================================================
>>     WARNING: possible circular locking dependency detected
>>     6.15.0-next-20250529 #0 Not tainted
> 
>> Move the memory allocation part of the code outside of the protected
>> path to eliminate the warning, and add a note about why it is moved
>> to there. Also add memory allocation failure handling, while we are
>> at it.
>>
>> Fixes: d30f83d278a9 ("interconnect: core: Add dynamic id allocation support")
>> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
>> ---
>> Changes in v2:
>>   - move memory allocation outside of icc_lock
>>   - issue a warning and return without modifying the node name in case of
>>     memory allocation failure, and adjust the commit description
>>   - remove offered tags from Johan and Bryan
>>     Note: since I was not sure that that the added WARN_ON() is a substantial
>>     change or not, I have removed the offered tags intentionally to be on the
>>     safe side
> 
> Bah, what a mess (thanks for dropping the tags).
> 
> This dynamic id feature looks like a very ad-hoc and badly designed
> interface.
> 
> icc_node_add() should not be allocating memory in the first place as it
> is not designed to ever fail (e.g. does not return errors).
> 
> Generating the name could have been done as part of of
> icc_node_create_dyn() or yet another helper for the caller could have
> been added for that. In any case, it should be done before calling
> icc_node_add().
> 
> Perhaps the best minimal fix of the regression is to move the allocation
> into the two users of this interface. They already handle both dynamic
> and non-dynamic node allocation explicitly.

Ok, I will change the patch. Just to be clear, do you mean the
qcom_icc_rpmh_probe() and qcom_osm_l3_probe() functions, right?

> 
> Then whoever cares about this code can come up with a common interface
> for allocating the name (e.g. move it into icc_node_create_dyn() or add
> a new icc_node_init() helper or similar).
> 
>> ---
>>  drivers/interconnect/core.c | 19 +++++++++++++++----
>>  1 file changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
>> index 1a41e59c77f85a811f78986e98401625f4cadfa3..32d969c349093bc356dc66234c62484aa9b9e872 100644
>> --- a/drivers/interconnect/core.c
>> +++ b/drivers/interconnect/core.c
>> @@ -1022,6 +1022,21 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider)
>>  	if (WARN_ON(node->provider))
>>  		return;
>>  
>> +	if (node->id >= ICC_DYN_ID_START) {
>> +		char *name;
>> +
>> +		/*
>> +		 * Memory allocation must be done outside of codepaths
>> +		 * protected by icc_bw_lock.
>> +		 */
>> +		name = devm_kasprintf(provider->dev, GFP_KERNEL, "%s@%s",
>> +				      node->name, dev_name(provider->dev));
>> +		if (WARN_ON(!name))
>> +			return;
> 
> But this won't do. We'd need to return an error to the caller (even if
> this small allocation will never fail in practice).

I admit that it is ugly, but I thought that an explicit warning is better than a
hidden null pointer dereference.

Regards,
Gabor

