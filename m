Return-Path: <linux-pm+bounces-38670-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97752C87ABE
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 02:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 60ED44E15B6
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 01:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDE52F530E;
	Wed, 26 Nov 2025 01:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pxpSk3bT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6881E1DDC2C
	for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 01:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764119969; cv=none; b=iiQ+68bGh9YnXI3zheG/N09HwG8JR217ONhwx0GKlYvPVcD7JuicluDJEALT5DgHEDAqJsPFpnPKtLB01b03buQA+/D2KEyaxTiSUtXjFIER74sx6bU9YtnkHaklQKHQmHnpWYpIDXKrbPCLj13y9gxw0t6lP+7+6RNg2cdjvr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764119969; c=relaxed/simple;
	bh=G7ZNDNiR8Djja/TvyR9CLyYYZM1cA+rALARCuQmH59Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QxNZKflTZefbjNw/cpKM8nuJfj9mOknj6Tkpz6wmx4OMRIpFhy2UBAnTItN+qKuPzGBFlprsUA812mRZ6LjYd+zlIhRSq8q+BUDCoStW2RXwBZJWwdwvxlb1FjK8PleGd7cBl8l8fmBfvyEBh6NlhdjO/xvp4ZCPIrf0oGapQUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pxpSk3bT; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-bc0d7255434so3408753a12.0
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 17:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764119967; x=1764724767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ONQMnRlPCQWGLqZuet9LBiEJ0IZkYpFPjI5nCq6R0G0=;
        b=pxpSk3bTCdrqI0/hGfTwDSWmA1Ae/c6VVXHVR6i7LxRQ1XjdCPQt5Xw36GS3uFW2Db
         yh9fdw0KUKP8Fy+nZv/8zMkTgEmjk1MARz9zK2UlqXsVF2gQIacY+4JFyK7HhhH4JTDh
         bla1WZUox51rprOi+n0Ma0omV7K49ntby/qKxfXjNo+kLSSthSTbcZYRkDXSJCIng2Ra
         9MdWyGnosmOwR4NGRgipUhaSkcU1noLKZWMkR0/anT/EcjlTlMDZ9IbnolLHmozJqOFP
         pAG26EhmHanwv0eqaSfhTuBi/cou30WvJ/EYMHUKOPMRmI68o6LiJ6i2UcEl0Cmwu8ln
         CkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764119967; x=1764724767;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ONQMnRlPCQWGLqZuet9LBiEJ0IZkYpFPjI5nCq6R0G0=;
        b=qyykBA5QFQK95TwUCeMDzANekVy4YPFVaXxGoqYivavaSEnBF1pRlAoQbwn8cz1Ub3
         gIyYpUnwhW1VfrJlRS9nBwHNwS5VHXaOCTuLj7/ky+4oil0ZXT0yBta4fXde1YZ4iRPE
         iYQzrdSnjj2/XgXISrjyJN73YaIaC+fPN+Wu9c04ofqK3q7cabsHD5yOEoxeL6OO8DYr
         2qRLvykLrudO1ptE6o8nqlheiFHYCRzSCP68+MZYSb7zt4gJlmtZFFOkSDrWVwkv+vIh
         9M+ydJ7RMM2RF2Tq7Z7H2cfysHAS0qc+Mk2/vHIl9E6ugfp4tFdR+elOtp1NeXxHy97F
         AFDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDcgCeQzKhjiRqn0krtsQRTTnMAV0XrzVc0N2bh53jvg2XSLEgSQ4tYVryjhDYYSgLDIAfvosM5A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt1pQxrbZ+/qQ60h3lIKa8+vfRelBKHRkeyMrQ1EhF1ZeLpz5e
	BsawPSuW/X6uWlfPFDGEuBbvBzL2auMe+hxAkDUnFzeZWMfywSU57NrLQ7sKZEONuA==
X-Gm-Gg: ASbGncsgtFTYYqzOWgVhi67Swe3dcZycbsaVaU8UX/g5Gh/NyktCMdZxXVLColkubvT
	frHYKBtKHs+nQ4U+AtDvV2tgZ+mnCsmxO0MKQRQULJvpcKPtW0hH9iCzctOclT9K9zcshOW91RY
	SilhFMG94BqOMPeotMXjIGgDHCtx12xWnM05yHWU+skWScxEabgfc7tcG/zHd6HyrMaE1BV42uH
	X4q2wOzMonK1K7cu76XiKvENGIkloyjvKMGeqOSsZ+dNybfMK8JXnQ6V3Xd9B1I6aCL63FIYcAX
	t82c8+beEC1UQUX4dgJsONie6hSss5n+gplp/LPiy4ig9bF/edKg9jh9GN1e8H9oK+eVuL5ZZx+
	Ku/lzlEbmLoEUR0FP0GBV7VpQUExiw9qKGswSWC6/nZEn7W899sNAv+VcQ6mRnoFEpDpdu6PJNZ
	fNXkFF+mmCkTH/rkZ9oPFFEVqFixzEV/vJkfapSv6ZeXbiK25zgjRPLgS7R1YPRL5QJJdbbXqtD
	aB+8eic6Ae5+A==
X-Google-Smtp-Source: AGHT+IG7vAAdnJdBV1xPAxMSocFYLV08aRb8J8ZFA9YU4wW1fgRuVRFaXJs0v7uY7YYTEmsaJSmrhw==
X-Received: by 2002:a05:7301:da82:b0:2a4:4e8f:5861 with SMTP id 5a478bee46e88-2a94188c7d0mr2414680eec.28.1764119967060;
        Tue, 25 Nov 2025 17:19:27 -0800 (PST)
Received: from ?IPV6:2a00:79e0:2e7c:8:c98d:9e96:d0be:bc30? ([2a00:79e0:2e7c:8:c98d:9e96:d0be:bc30])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a6fc3d0bb6sm95954083eec.2.2025.11.25.17.19.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 17:19:26 -0800 (PST)
Message-ID: <bb2ecf99-6153-4623-81ae-0fd41e4d306a@google.com>
Date: Tue, 25 Nov 2025 17:19:25 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] mfd: max77759: modify irq configs
To: Krzysztof Kozlowski <krzk@kernel.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Badhri Jagan Sridharan <badhri@google.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>
References: <20251123-max77759-charger-v1-0-6b2e4b8f7f54@google.com>
 <20251123-max77759-charger-v1-4-6b2e4b8f7f54@google.com>
 <5c901a6c831775a04924880cc9f783814f75b6aa.camel@linaro.org>
 <d2184e6b-ba22-423a-8d3c-3b8c2f8ec329@kernel.org>
Content-Language: en-US
From: Amit Sunil Dhamne <amitsd@google.com>
In-Reply-To: <d2184e6b-ba22-423a-8d3c-3b8c2f8ec329@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/23/25 11:39 PM, Krzysztof Kozlowski wrote:
> On 24/11/2025 07:21, André Draszik wrote:
>>>   	if (ret)
>>>   		return dev_err_probe(&client->dev, ret,
>>>   				     "MAX77759_MAXQ_INT_APCMDRESI failed\n");
>>> @@ -633,7 +643,7 @@ static int max77759_probe(struct i2c_client *client)
>>>   		return dev_err_probe(&client->dev, -EINVAL,
>>>   				     "invalid IRQ: %d\n", client->irq);
>>>   
>>> -	irq_flags = IRQF_ONESHOT | IRQF_SHARED;
>>> +	irq_flags = IRQF_ONESHOT | IRQF_SHARED | IRQF_TRIGGER_LOW;
>> I don't believe IRQF_TRIGGER_LOW should be added here, as this is board-specific.
>> The polarity is meant to be set via DT (and the only current user of this driver
>> does so).
>>
> If this is the main chip interrupt, then you are right and the code is
> obviously wrong. What's more, it is completely unexplained in the commit
> msg, because that vague statement cannot be taken as any reasonable
> explanation.

You are right. As discussed in the thread with André, I will drop this 
particular change in the next rev.

BR,

Amit

>
> Best regards,
> Krzysztof

