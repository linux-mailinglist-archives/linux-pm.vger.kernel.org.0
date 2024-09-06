Return-Path: <linux-pm+bounces-13795-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDB696F6EA
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 16:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61A321C2437F
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 14:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7711D1F4D;
	Fri,  6 Sep 2024 14:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVS+jTnC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3541D1730;
	Fri,  6 Sep 2024 14:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725633244; cv=none; b=Q5SM6BY+/W+OEOrCWBv1x8/+LsjgoHYZ3q3QErXzkKD3JWgQrNGEn2hW5Dm5nTDHs/ZmvDTAGboBdCYnKW2fvhXssMaiuQgfZp4v/f9GIj5pIVPdu3BvF0jcXIEjtv3GulA0XLjh54qAMbcWqG8NTAI1wTMpj5h6gcmENr6b6LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725633244; c=relaxed/simple;
	bh=newoIDJ1OgtiNmjdak9gX3uCNZevuui6ab/VqSq1b4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qJeAeGvjx8vuAVOLeg43q495+tAZj9mVjMkyY57b8LZjcjJsenXNJ2JJ/3p9cU4jGQR9heDQ+Lg9QB2Atnr+B07fUttcnRj0FxhxxKUhQU3OxduK0K8yMbVXRCFVjUarHaR9rLWpTRQ1dojgvwNhfEllJHmXh5POiN7RWuxURbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVS+jTnC; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2055f630934so16230905ad.1;
        Fri, 06 Sep 2024 07:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725633242; x=1726238042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=rQxHhYmeBoBu/rIwurRqs3OXFL2vLEg6vwA1TCTFzFY=;
        b=aVS+jTnCs2C4P0V6+L8msVwYmpmCLfl3fs1qw04YxpG7FUz82JpoiT4mjkhnyUKl9m
         cqp8/89MPhAuWMlJy7Ow7409OuaOpUJKHYfouqu//Rzl4m+CCjPNfW0jIL7fXD8SH1/Y
         vhgxY5O97xSUw73k20NE1Z8KXrtL2HR1Nx8eAeTwWWk7rVzaarKB8Znt05ZEM8atY8Rd
         rKoMRvF2P6UdkfN4gjGm3IeqAJ9dEyOndxuWejV+j0lZRWcr+6qMuZk0FblZ9khgeRgM
         O0NUpsvNPU5aZ8lGejwK7A0e+C0SwaFi+CA9Euf7nGx+1qo44IB2qTQNWnWxJbrspM+a
         b3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725633242; x=1726238042;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQxHhYmeBoBu/rIwurRqs3OXFL2vLEg6vwA1TCTFzFY=;
        b=Max9toUrXI5iYR1uwMvT56JNwU6qKh7w8HaYJCq9nVLC0bzuGrIdfGnn1aVHLsEdaV
         WtIbFi/ToPtuwWFdGSkOEL1VwAFRLbSa4PxuEnl9xXlhfjwAqx+9mwqIGjUvo7pNgebY
         E0m3azQYNaM8Mr6wAkbMHFyue837W1/VQvK9lfXNBZJSCDh6cEPXszEp0ucu2jnVJA3d
         xgmFWy+MlKT/PnkWWTcE4PTtVr32xz28Y84KjQlwdN9J+1imir+5fgjvLnKaelLPKtBP
         ztH8BKnbtDe8Mhxc6ari7w1oNKTPNHTLDsPXdO4Iuy+cgbXxeZk2ShRZ9VYPBij3JSRQ
         /n2g==
X-Forwarded-Encrypted: i=1; AJvYcCVcza7tfHSomus8Qe1yqWBfrFdOypLdgmMDQr2BaxEbIJdTfQHXEjTeiWmDTdxjNGFt6UguW4dkaRdAMhEOd5A=@vger.kernel.org, AJvYcCW62AayX1Ttd164hGHiMPxPlyEwNNzqgVZJdycz2ZxY8cIDdhYwSGp8hFM3TK8sXHAAM70kRL/oTa4cJEMi@vger.kernel.org, AJvYcCWL+YBKl7HhjfxVDLq23BDITAGm3Fp0W/fIRzwsU2n9lVsImbGr+nbgP7Lqn/7LHWvJF1uQoQWCndXvMg==@vger.kernel.org, AJvYcCWRFCk3CQhtUiBlKPloqvj3kITYL6MXwrPD+ZmA/mIfa5qeH7+/oh9QXIz7xMAymtSV+zK30eARwMzA@vger.kernel.org, AJvYcCWa6iahZrHzKQBmih4Q8kjE1uzGyn20BF7VLBUsigPXeZ321/S3BtpQWPXHSGFyB7x4f4Kam0gAbiI=@vger.kernel.org, AJvYcCXGYzY16qH4nIWaQOX2se4QTeUJU92BhCysKiovl7GORpaetvqU0iaGO6dMNfUypY2OPiWqq/vOPwhnuw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZI1Hza0G9IJpUDlAP3EgxPCo7PYMXjVasMfNHGmyTsgR3vwy7
	E3Veers1O+kD3dsQYlfpZYkAAdmi7HUvmp7kGyoyKHY4pi+u4/Vn
X-Google-Smtp-Source: AGHT+IFZ7t97k9Fjh6irQkkAHRokvsBfUc/k7I1Ur60NalXFGzebn9eSQlD04+UbvR/fnBWwM3DpkQ==
X-Received: by 2002:a17:902:f606:b0:205:410c:f3b3 with SMTP id d9443c01a7336-205410cf6c0mr252742545ad.59.1725633242214;
        Fri, 06 Sep 2024 07:34:02 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea531bfsm43440315ad.219.2024.09.06.07.33.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 07:34:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ef31a8de-346e-4cf1-89bf-b5bfcb69cf11@roeck-us.net>
Date: Fri, 6 Sep 2024 07:33:58 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] hwmon: Add support for Photonicat PMU board
 temperature sensor
To: Junhao Xie <bigfoot@classfun.cn>
Cc: devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, Jean Delvare <jdelvare@suse.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 "Conor Dooley," <conor+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Heiko Stuebner <heiko@sntech.de>,
 Chukun Pan <amadeus@jmu.edu.cn>
References: <20240906093630.2428329-1-bigfoot@classfun.cn>
 <20240906093630.2428329-7-bigfoot@classfun.cn>
 <a33633be-800c-4ca0-9d1e-f190e23384d5@roeck-us.net>
 <e1f98265-ab75-45fe-a7a9-8e65cc13908e@classfun.cn>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <e1f98265-ab75-45fe-a7a9-8e65cc13908e@classfun.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/6/24 06:49, Junhao Xie wrote:
> On 2024/9/6 19:41, Guenter Roeck wrote:
>> On 9/6/24 02:36, Junhao Xie wrote:
>>> Photonicat PMU MCU will send status reports regularly,
>>> including board temperature.
>>>
>>
>> This is not an appropriate description.
> 
> I will change to a better description.
> 
>>
>>> Signed-off-by: Junhao Xie <bigfoot@classfun.cn>
>>> ---
>>>    drivers/hwmon/Kconfig            |  10 +++
>>>    drivers/hwmon/Makefile           |   1 +
>>>    drivers/hwmon/photonicat-hwmon.c | 129 +++++++++++++++++++++++++++++++
>>
>> Documentation missing.
> 
> Does it need to be placed in Documentation/hwmon/photonicat-hwmon.rst?
> 

Yes.

Thanks,
Guenter


