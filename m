Return-Path: <linux-pm+bounces-19402-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 414159F5DB6
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 05:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 295887A1336
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 04:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A1C14883F;
	Wed, 18 Dec 2024 04:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="QpYoaOJd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2822146D57
	for <linux-pm@vger.kernel.org>; Wed, 18 Dec 2024 04:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734495007; cv=none; b=h++U1t5Sq4QYhp7u8XrpUEOGMxLrRTkW4aSEtRYrSKy5rfGhxolP7JftdYUIY1N6dcVwvyoxLAw9phr2ap7FbOjIhfgOPpQzR2r3cQQ1YPjpSCrvKABPsoMhCRrcPrv7rcG7y2JcG0u1/rmrcpCdBADWLQZxl7DWZ48B7R1oZWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734495007; c=relaxed/simple;
	bh=KBpmGaJUNDOzACi2g6ygduULL1m9wFGkORH+iVbVKeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jaaFv/gGYGJiOEadgyulMBChrHfuYwYCci8/GwoCeruoLGzVua8q60TShuj2u8a98vrWwaFv4EXo0IoAmVwOvEpgBNAOuMcCaMPc6fJrXztvOU9EnnqdejwXYGDKAMpUD/eSV60QusKe/Xn0uKJcLvNH6aQ91KwS7OOR+o1MSBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=QpYoaOJd; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-72739105e02so6565220b3a.0
        for <linux-pm@vger.kernel.org>; Tue, 17 Dec 2024 20:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1734495005; x=1735099805; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qQZ+ArP2M1WtbdjCyC7frKm5T9rv6YJz0AFDnWMp/T4=;
        b=QpYoaOJd9lkrbGv5fhjvszlaePbw+w8if9iE53qzUTYP1t7VmyX9UQWvzO2+5DOsxN
         a+43Tn2c1Er1xQYSQMvn4Czx+svMZwhLsrFOl04lKJCpRiqezIvzjcpDKfDKtLgmClh9
         XzbQDhCGAG9JM47w5slLVRjrrpVa2SC8dBYTJ0aU2P/ZZ0h0vunZ/LH6+tYwnxbBfVlE
         WWxMJkY3v8i6tFUqAiHhX/sb0DMfsDyWidGRjUnnQbsJBHae00EML9oxvB5iiODOkc3b
         /fhkbP88OkLso3oPpwKD8AaJrSO7MHkWc0Ym8hoJp0CiYuUvYCoKZvmyQZQmu4A1lF5d
         h8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734495005; x=1735099805;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qQZ+ArP2M1WtbdjCyC7frKm5T9rv6YJz0AFDnWMp/T4=;
        b=ZPKQReGzJKiAkHAQfLw2RozhbqH+WfhKe0eqISFOeBgyLNzMxt2ijc6m26B9EEXeXv
         FC/Qom3Xf1+Q1hKTVtkb6UghPIkrmg5U+psiNnhg/DTa9gR6vYBSuBQWgig9GoS29gpC
         CsJ7XvP3zqcahzS5SaTxgAX9atPx7uoNrKwsECZT5oocOh8sZ1rPyIYmRXjszpo2t/qT
         XGImjfrCwfVtwgXsot0ikPTfsHqEwZbGNOjEqh80NTdJX3gfCoApbztaoUPv//zNxXZa
         K0irpM4h61xWmwQD/BUXys/glplJHWd31stOUieyQ4qf1QVfglcny/4AkM3y6iSqjZxa
         3JNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvuI53xxfqGcB71hxxM6VElkjDvF2QVocVk+zGeGABwTZ240uJXg0pERIdmc+DhTsE/OKOT5anRw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqS/t5WihTvfSJN3Fozd5SGMMX/nlXSpvvOgjb2DkgrKettLEI
	PuRS3APC0YiH2eiiGra8O/kQyEfK7e2sBR7bg5RnLUzdLoHRB19tNDekamW+Hks=
X-Gm-Gg: ASbGncvGmD2i8w+t0QixP/DdPPbvsjLxuc5maYDzdAGAk4pI8RCwHebuvgGMYWZ7QVM
	2nWfPeBhAEOjnUrDV4wUvrOzLo9TkiuicG6eGPl3Hg6wfJWonrKzQuXqIj13sAYb+nHEVJ7jxbK
	5240JK9SCGEsHBMq/awYqzDD2ORDR7kxjDEfjLmPMsHvkYAVJiOwkMqbc0N9pKD5jhDItaIhaa9
	3fKB4C5Z6hYjcuJYxE7O9b907U2DpMM8sFgUDbewlN1tQghPvM7cdTwZ9Tm2jrWRe5t87ciwvnQ
	QVzzhZp16NEWgQDnt9U0JKnWEYsmdT+69A==
X-Google-Smtp-Source: AGHT+IGICG69Y5nGuAeuks1O6GuezpEUVrzzvZt5EFBdDkyHCU+18PDXrrcUpLroHyG3ndcFFMhxbw==
X-Received: by 2002:a05:6a00:3305:b0:71e:4296:2e with SMTP id d2e1a72fcca58-72a8d23b80fmr2048909b3a.11.1734495005018;
        Tue, 17 Dec 2024 20:10:05 -0800 (PST)
Received: from [192.168.0.78] (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918b7d0c0sm7488140b3a.98.2024.12.17.20.10.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 20:10:04 -0800 (PST)
Message-ID: <a114e49b-b7e6-462a-a91c-4e1b85db7b30@pf.is.s.u-tokyo.ac.jp>
Date: Wed, 18 Dec 2024 13:10:01 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PM: wakeup: implement devm_device_init_wakeup() helper
To: Dhruva Gole <d-gole@ti.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, alexandre.belloni@bootlin.com
References: <20241214021652.3432500-1-joe@pf.is.s.u-tokyo.ac.jp>
 <20241216080159.ahpzlioy7l5etn3y@lcpd911>
Content-Language: en-US
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
In-Reply-To: <20241216080159.ahpzlioy7l5etn3y@lcpd911>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thank you for your review.

On 12/16/24 17:01, Dhruva Gole wrote:
> On Dec 14, 2024 at 11:16:52 +0900, Joe Hattori wrote:
>> Some drivers that enable device wakeup fail to properly disable it
>> during their cleanup, which results in a memory leak.
>>
>> To address this, introduce devm_device_init_wakeup(), a managed variant
>> of device_init_wakeup(dev, true). With this managed helper, wakeup
>> functionality will be automatically disabled when the device is
>> released, ensuring a more reliable cleanup process.
>>
>> This need for this addition arose during a previous discussion [1].
>>
>> [1]:
>> https://lore.kernel.org/linux-rtc/20241212100403.3799667-1-joe@pf.is.s.u-tokyo.ac.jp/
>>
>> Suggested-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
>> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
>> ---
>> Changes in V2:
>> - Utilize the device_init_wakeup() function.
> 
> You took my suggestion, but forgot to put me in CC I guess :)

Sorry, added you in CC in the v3 patch.

> 
> [...]
>> +/**
>> + * devm_device_init_wakeup - Resource managed device wakeup initialization.
>> + * @dev: Device to handle.
>> + *
>> + * This function is the devm managed version of device_init_wakeup(dev, true).
>> + */
>> +static inline int devm_device_init_wakeup(struct device *dev)
> 
> Rafael, Should I submit a patch series to convert the regular device_init_wakeup from int to void?
> This anyway doesn't return anything but 0 today and I can already see
> some drivers using if(device_init_wakeup) which would essentially be
> just dead code. I can try and patch that up as well.
> The fact that this is a return type `int` is quite misleading to it's
> users I guess?
> 
>> +{
>> +	int err;
>> +
>> +	err = device_init_wakeup(dev, true);
>> +	if (err) {
>> +		device_set_wakeup_capable(dev, false);
> 
> I don't see any point to this check. I am not sure if there's any case
> where device_init_wakeup returns anything but 0. Even if it did, setting
> wakeup_capable false should be handled within init_wakeup and not here.

Makes sense. Addressed in the v3 patch.

> 
>> +		return err;
> 
> With above taken into consideration, you don't need to return err.
> 
>> +	}
>> +	return devm_add_action_or_reset(dev, device_disable_wakeup, dev);
> 
> This much maybe enough, in that case let's keep the devm_ version as
> return type int just for this.
> 
> 
> Also, please CC all involved folks in future revisions. People have
> filters setup which may prevent them from looking at all emails that
> come on a list. Best way to grab their attention is by CC-ing them on
> each patch/ series.

Understood, will keep in mind.

> 

Best,
Joe

