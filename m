Return-Path: <linux-pm+bounces-12359-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB038954C52
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 16:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD3AD1C232FC
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 14:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0121BCA0B;
	Fri, 16 Aug 2024 14:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwDejNxY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C97A1BC083;
	Fri, 16 Aug 2024 14:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723818352; cv=none; b=lenmJcHLaqZc0LR//BaJh5Imoa+GO05lKW2nVVRSENXCBEf+os5dLxU0XAaVQen2GPfmnH6bILh0m89bifF/YVJpXGCuPZ9HBFskyLNZRdKgv98EzNcCioGaCkMiZ+67XaPJ33DyM1x+Wjfd784/rIxOKzJWN/MzheMJy8U63PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723818352; c=relaxed/simple;
	bh=PGPKe9Z2HXEC0gw5dqeKqhDeaAxArswdRASSszm5pnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=giLzPSUgu78BcWx/kgkFtIEQsvbdiDSAMnye+1AJExjRBoty5OoD9S1LoNa9XdK+1RpaICKwJyy/02CpF5eZVeo4F7uPjo1CwC05OL3wB6gZfjIOJR/ki5mQd9lRP20JxSk6o6YyefBNZvZmcEbYYeY7zf4BZdRq3LoQFxotu24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwDejNxY; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52f04b4abdcso2583307e87.2;
        Fri, 16 Aug 2024 07:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723818348; x=1724423148; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=18z5iNYHQLy9IQXidEg4MX75zOC+06viB9VWsJ8MHWg=;
        b=NwDejNxYHIV/tLd6M2WnTfvnMHKxhcDG7N2LmdbD7aDuYFGh/xY2QCTRQmkxyRQNgf
         3WvYPRNQwpQyv1CNgu2EpHp9qMLBhkOsQjhHQU3FmTVzrjBQkREr8GCoS4mGVWBlMDRy
         E9Lqu1a3FSe65MeaxxYAFTzMSyN79xUGqho1MggV/94T+H2h1yhi/D/rGtS0xjG8/b9J
         mSksL8gmSOVfgiMD+0Re0S2uMyV9Qfu3BtVBps5K9cO4k/7kOz1jZeupUxk7lpaLYDHG
         CNgVWlVY0j6dMAdXQQ3Rl+LaoZPOfNvd+++LJRlEvvrzhwHf5KruevifqhtpZHl1SL9d
         C+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723818348; x=1724423148;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=18z5iNYHQLy9IQXidEg4MX75zOC+06viB9VWsJ8MHWg=;
        b=X/bEgm3qeG3k1hGv5A+zsb5uVLdKQf/ZIEVkextz7iY2651ZkeC1zmlULDcplDvoU3
         7kzNVn9sk1dMQLJxFqWuXoRg0GmnN7JU/qb5ZO5cIBExAlRa7aDfS7o4vunSGq1cgmTZ
         y8XYOeF9N/THMWJuLiWqe5P1u4hCVXTGilmU4UPq/3T3oUoCgfmxcnMlHnOxOX3TzD4b
         FNs16/3mOsjOvHw19NXztLCN4QoQYmygs9FM0tuVSzgYP50xuYfajh+l51cPAlo/IXjx
         r6TJZkz5QxJmOvnYRJ1wj9zcsTt1B8fdJuCDnhlETEvutcpxkEKJzzrCqcxheFBeP4U5
         U+dg==
X-Forwarded-Encrypted: i=1; AJvYcCUGtbVVRRWtZgxU6iygSStJW5Y5okxQsDU05Pg9KkT96+F4BSqEGA04bG+EIKMC0yjEZb0z9bGrgak+s9N5L5sncsU=@vger.kernel.org, AJvYcCUjXaYdqmwCCXNG6q1Z7QmPzIjmRbtk85a/9vqR1GsMl/GziSvO2YDTEtmZ/c+EKuBlRr/NJZu2TpcL@vger.kernel.org, AJvYcCV3KHsylzKR5UNMJMCDxv5SOKW6B5itx051hZ8CTnidv0jH5NwTG6lER1YupqvKOucyob+NQGWPOTA=@vger.kernel.org, AJvYcCVo3HYiQ0x0VwyxMMdpoElQGm1/fVkt2rhdhe45BcD/txZ8kVsLaMQ5dkKwUu93zV4xoiTn8pYJz0XZ1yoO@vger.kernel.org
X-Gm-Message-State: AOJu0YxxbQ1RPpshXJeisXgJloQog5loK8LNiQibjxhUFjCz01dfckr1
	+e5KtfoiOuaWbYx0Wd2OgeKiSQoLFcw1YMfRUDoEEp4ldnnyY7YqO248sQ==
X-Google-Smtp-Source: AGHT+IHwlZ63+TDjPwfyTB1uqKHtWzOZKBvQ7+La0DArb8wjIj6kPTSWKuM2IfOtSlb+ALHVhWRtGQ==
X-Received: by 2002:a05:6512:220b:b0:52e:9b92:4999 with SMTP id 2adb3069b0e04-5331c690ce0mr2188241e87.2.1723818347989;
        Fri, 16 Aug 2024 07:25:47 -0700 (PDT)
Received: from [192.168.0.124] (ip-31-0-120-26.multi.internet.cyfrowypolsat.pl. [31.0.120.26])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838396d5eesm262532566b.225.2024.08.16.07.25.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 07:25:47 -0700 (PDT)
Message-ID: <021f5a99-bbee-4d4c-b36e-49339030b869@gmail.com>
Date: Fri, 16 Aug 2024 16:25:45 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/10] power: supply: max77693: Set charge current
 limits during init
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Chanwoo Choi <cw00.choi@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht, Henrik Grimler <henrik@grimler.se>,
 Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>,
 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
References: <20240816-max77693-charger-extcon-v4-0-050a0a9bfea0@gmail.com>
 <20240816-max77693-charger-extcon-v4-4-050a0a9bfea0@gmail.com>
 <9dbaacdb-5f9c-48d4-a56a-a19ca8809344@kernel.org>
Content-Language: en-US
From: Artur Weber <aweber.kernel@gmail.com>
In-Reply-To: <9dbaacdb-5f9c-48d4-a56a-a19ca8809344@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16.08.2024 11:54, Krzysztof Kozlowski wrote:
> On 16/08/2024 10:19, Artur Weber wrote:
>> @@ -732,6 +794,15 @@ static int max77693_charger_probe(struct platform_device *pdev)
>>   	chg->dev = &pdev->dev;
>>   	chg->max77693 = max77693;
>>   
>> +	psy_cfg.drv_data = chg;
>> +
>> +	chg->charger = devm_power_supply_register(&pdev->dev,
>> +						  &max77693_charger_desc,
>> +						  &psy_cfg);
>> +	if (IS_ERR(chg->charger))
>> +		return dev_err_probe(&pdev->dev, PTR_ERR(chg->charger),
>> +				     "failed: power supply register\n");
> 
> This code move is not explained in the commit msg. At least I could not
> find it. Please explain why you need it in the commit msg.

This is done because the call to power_supply_get_battery_info in
max77693_dt_init requires chg->charger to be set. (I was considering
putting this in the commit message, can't remember why I didn't do it.
I'll add it in the next version.)

Best regards
Artur

