Return-Path: <linux-pm+bounces-35040-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 301BCB8A3E3
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 17:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17C9A164F83
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 15:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE238316918;
	Fri, 19 Sep 2025 15:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RjSGabaD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A52315D34
	for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 15:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758295235; cv=none; b=XNUe6NYtRLDmaqDTXn4ix4FtK16lS2jOv89ylwOLDSg7XbFesCl6qwB7kXDlTwkLzsiY1bfJAEYXjkpKvkYy7Y1Q1M58Q9Own+2pmoaRkpxwqunJLbBnV65NWtVwnCa13IkbOUMJaal0Aq9AU8R53tDkIF0xrlsxFdM8Ds3Y5jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758295235; c=relaxed/simple;
	bh=6MasVt/aSu1l1BXxhKpjh1yxZ8Y8jhzf28ZPi2XqySw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eMYi6hdyK2rhMyqybyWtCvrZNfynl//Cb4w/NCetE8Mgrkq9ZdH9Tx3CLutebPRqP/hdIE8YQwMJeccQb67XfAoH21alfjJpZ3bubV+826DGyEbVVfp3VZuSF6OSNOS/PpVmb894K2X8qCyxAugK3mH2RKK6j9iVTTfj2XAJsRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RjSGabaD; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-328466c2aedso2009906fac.2
        for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 08:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758295232; x=1758900032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=58QddYy9doQYGj9OGULI81m9rz5X5nvBb+nMrO6L4+k=;
        b=RjSGabaD+6QxdK2upMChFfx4/Rw85dSxclzrvanLtp1MHkdURVfYlv+6MyYBA3JVHK
         Do8IuS9SONMXfjn/Wh25IqpQ1opTwiI80qo1Vafzos8g3FCGCRi/S4RX/xyM6lfiS/1k
         L02k7XGg1fjH9CBc45P4Z/0tiySauTrcUc8YECBwYJoExoRpDkCKpLmkVRm2Dsmmkqle
         ibHNJ0nsftwUj8ZCZuTFlLjzL78fH0v474S+S4q1pXVgS6weibPF4cil3+O2UyzdI2rs
         J7K/0gqPd3ipWN6D1UEiBupXN7L/J6wM181jdVo7S+LFgPDGT+BU41+yTM6FCkmkfVBl
         D4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758295232; x=1758900032;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=58QddYy9doQYGj9OGULI81m9rz5X5nvBb+nMrO6L4+k=;
        b=LqtBzi7FYa/+w5ox85ncq+9W/33V7afNcwZayG8MRKs4eciEpYoSGFHe7rs1l+gNvW
         bndoP39dlLgleUCo4Cxn68/JZX9b+KkBFdZl7Xu2Velm1i71TTigPTkF5gi7UsS2/mdg
         E2knawcktVtsIKRPf9XY8tdXCZ0MRwrsAGsuNAtXqQYSMr0rlyj3/As9N2u62PTZjXId
         4L4H2fj7GAq3qammW/0mkZpIbNBHqKAQHhB8jH4XNBk/URj9qmvp0azWT9l9zujzHxLH
         0vJOPFS2iXFoTTGYYaHT37I9aUzZUakEmzCdju8YSPwZCEz9MmnzgTDHQ17jxwYNLMzv
         8BgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYbzJi1ofLgCkoZgtunzK34UOylisyc82eybzcENIkkHoDf5tae5yTJ3YYKp6Q1ldqlHFaqjvpQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxeytBdGyI/XDc1VwqmAsO8ZGHBgT6LHNzkcgTnUcL935oPAWqV
	MMK42KqyCfeOA0A8gqFmf1pQU+P1PjY1T6HYDPGN4njhFoVzwR0yq5CRC0HMe1gwrqg=
X-Gm-Gg: ASbGncuLHzhJiWxTqGpI1t7DaY3kD5H/H4j9Qb55LCBpfUkcb4lonQj7bOAClgKlBiI
	LXGytFtk75o3eRf3nrYap6kzawvK9wPAk/6XJhrNIYE/us3X/DGALWawKThZ8MRG4E9MpKUZDzx
	BOfVFfSzlHLrDoCZHn4fOnJ2VgDKT+7077Wc+EuOVc1+GVEjlTa+Ff/PYC1fgUxl5vBNyT4Y8SX
	XtGKI6QZ0/yetCmFWeR6uQgj2+1SwcK1RYi4xjPt3hrHHnxhZu1Qi5q/lUFkekfNPtucq0CbAFb
	Cu0NdoLC+q14c6w2IzjULR7gEikEBddOftROKmaPJKfaSYN2QsMsSF6HnxQLgod7tJikMvZDx08
	k20Rz3kk71wlVuAV7zeBYlmyCo9YvbGRXKS1JWgBnkyCWPhTRLlpp5uIJJvLmyNAiTrY6VT7ybj
	k=
X-Google-Smtp-Source: AGHT+IEJT0izziTZ06yN6CmHd6vD3fLc3H/jpNESoHp4Nt7QllNscgV8/EofsSLRMMmL3uPtY7Wo0w==
X-Received: by 2002:a05:6808:5094:b0:439:b674:d9a3 with SMTP id 5614622812f47-43d6c26736fmr1642625b6e.35.1758295232364;
        Fri, 19 Sep 2025 08:20:32 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:3838:157c:c9f9:2e3f? ([2600:8803:e7e4:1d00:3838:157c:c9f9:2e3f])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43d5c6bf8adsm2068096b6e.9.2025.09.19.08.20.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 08:20:30 -0700 (PDT)
Message-ID: <8702fd35-945a-4d20-bc37-410c74c70da6@baylibre.com>
Date: Fri, 19 Sep 2025 10:20:29 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] nvmem: qcom-spmi-sdam: Migrate to
 devm_spmi_subdevice_alloc_and_add()
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 sboyd@kernel.org, jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org,
 arnd@arndb.de, srini@kernel.org, vkoul@kernel.org, kishon@kernel.org,
 sre@kernel.org, krzysztof.kozlowski@linaro.org,
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-pm@vger.kernel.org, kernel@collabora.com, wenst@chromium.org,
 casey.connolly@linaro.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20250916084445.96621-1-angelogioacchino.delregno@collabora.com>
 <20250916084445.96621-3-angelogioacchino.delregno@collabora.com>
 <t3uk3k4h3l53yajoe3xog2njmdn3jhkmdphv3c4wnpvcqniz4n@opgigzazycot>
 <aMlnp4x-1MUoModr@smile.fi.intel.com>
 <mknxgesog6aghc6cjzm63g63zqbqvysxf6ktmnbrbtafervveg@uoiohk3yclso>
 <CAHp75Vf7KrsN7Ec9zOvJoRuKvkbrJ5sMv7pVv6+88tPX-j_9ZA@mail.gmail.com>
 <er7dkmzutsu3ooegeihjzngi6l3hol5iaohecr3n5bolfse3tj@xeedlx2utwym>
 <aMxWzTxvMLsVWbDB@smile.fi.intel.com>
 <2025091925-thirsting-underuse-14ab@gregkh>
 <f16ea5eb-cbda-4788-956b-d41c2af51745@baylibre.com>
 <2025091918-glancing-uptown-7d63@gregkh>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <2025091918-glancing-uptown-7d63@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/19/25 10:13 AM, Greg KH wrote:
> On Fri, Sep 19, 2025 at 10:05:28AM -0500, David Lechner wrote:
>> On 9/19/25 8:59 AM, Greg KH wrote:
>>> On Thu, Sep 18, 2025 at 10:00:29PM +0300, Andy Shevchenko wrote:
>>>> I,o.w. I principally disagree on putting MODULE_IMPORT_NS() into the header
>>>> file.
>>>
>>> Yes, please never do that, it defeats the purpose of module namespaces
>>> completly.  If you don't want to have module namespaces, don't use them
>>> for your subsytem.  Don't use them and then make them moot by putting
>>> MODULE_IMPORT_NS() in the .h file for the symbols as that's pointless.
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>>
>> Could someone suggest some additional explanation to add to
>> Documentation/core-api/symbol-namespaces.rst to explain the
>> reasoning behind this?
>>
>> Right now, the only part of that document that say _why_ we have
>> module namespces says:
>>
>> 	That is useful for documentation purposes (think of the
>> 	SUBSYSTEM_DEBUG namespace) as well as for limiting the
>> 	availability of a set of symbols for use in other parts
>> 	of the kernel.
>>
>> So I don't see the connection between this explanation and and:
>>
>> 	[Putting MODULE_IMPORT_NS() into the header] defeats
>> 	the purpose of module namespaces completely.
>>
>> I am guilty of putting it in a header, so if I need to fix that
>> I would like to actually understand why first. Andy has mentioned
>> something about potential abuses, but without any example, I haven't
>> been able to understand what this would actually actually look like.
>> Or maybe there is some other reason that Greg is thinking of that
>> hasn't been mentioned yet?
> 
> Let me turn it around, _why_ would you want your exports in a namespace
> at all if you just are putting a MODULE_IMPORT_NS() in the .h file at
> the same time?  What is this giving you at all compared to just a normal
> MODULE_EXPORT() marking for your exports?
> 
> I know what it gives me when I don't put it in a .h file, but I think
> that might be different from what you are thinking here :)
> 
> thanks,
> 
> greg k-h

Up to now, my (naive) understanding was that the point module namespaces
is to reduce the number of symbols in the global namespace because having
too many symbols there was starting to cause problems. So moving symbols
to another namespace was a "good thing".



