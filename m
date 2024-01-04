Return-Path: <linux-pm+bounces-1827-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBC1824358
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jan 2024 15:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AE7D1F225A1
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jan 2024 14:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AC2210E7;
	Thu,  4 Jan 2024 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p6NiO/bv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538FC2230B
	for <linux-pm@vger.kernel.org>; Thu,  4 Jan 2024 14:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40e3485f0e1so4270935e9.3
        for <linux-pm@vger.kernel.org>; Thu, 04 Jan 2024 06:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704377451; x=1704982251; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1IG/HNz7wTqJE1bnao0AkkiNoHMZAFUZYED8cZloi6g=;
        b=p6NiO/bvtsW3YgLbwGmiWFFzwZrIF9zVcp+Y9ShaOBsDq7xLIhIwCI9SLV1A2Zf8DA
         Qn8QwXpjOBBYY2rIrUKxWYdnIdrP/Smh5mCdTje7QVQmPCi1lID09nnghil9d/UlEx7d
         cBfIBbGnl7QJy3ez3fIudQ0udOPpI3G8qc30PKlaBseCzsX3VuwgWIj0MAW4giPS0E7+
         mRhBMdv64ZDXUB9VoUt3gnUPahsVi8GwZRzMjhAe/0tSOMB22UlVXZd4Ctioy250DIXx
         r2F/PlrH7tpSta3rPkxiqjPTq8d1dK5o4HlT+EcvIl02Ie+FrdagcCaCuTRUQNAoOAGB
         xjmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704377451; x=1704982251;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1IG/HNz7wTqJE1bnao0AkkiNoHMZAFUZYED8cZloi6g=;
        b=A5KKLWZbpn+6rPW2AL1yLFDmWvjt9kPE//V1+TU717kbGHmVUEgu+F3Z63aKlDpigZ
         /x/+Pe/FjXy2EgzZzESBSTYMgSzVe2zsD9UP6mQPHOYLv6XOtETZ8eSETvl3EkjnCHAZ
         h04m9kOayH8LDAdULZ3ASrT/uHyKcsz8XZwTzD/O4S/BIoCc79G8L+U9ao6KCVOZa7LC
         BQUZMNtl7y2Uvw70aI5U8MYriqaRmt9PXi/wYN3xhasXudGzj3B/dPV/nLRPQbodzVJz
         5RWtXeNenVO0WxT1LvDpve6NdVV1D2mXF2U1sXCkJJdVLRiVKxlAZHsuDWB1kNymijrf
         352A==
X-Gm-Message-State: AOJu0YzOg8vfh7/xundPHxmYngCptC8Wnjdz0OCo2W82zM4kjryNxZ5C
	6xPIEsl/0NOu60qpN7RimxVkWwL9ajXEtA==
X-Google-Smtp-Source: AGHT+IGvfF8iQXUpHTP+ygPHMlMeDihW13RCa/olJo9wziP2tZDKBt9hQ+LpDxlLi2AYnJJ5mjPeng==
X-Received: by 2002:a05:600c:3007:b0:40c:486d:6cb4 with SMTP id j7-20020a05600c300700b0040c486d6cb4mr411001wmh.83.1704377451520;
        Thu, 04 Jan 2024 06:10:51 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id g15-20020a05600c310f00b0040d53588d94sm5857865wmo.46.2024.01.04.06.10.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 06:10:50 -0800 (PST)
Message-ID: <abd91e5a-cf01-4b86-965b-ed315a58355d@linaro.org>
Date: Thu, 4 Jan 2024 15:10:49 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] thermal: k3_j72xx_bandgap: implement suspend/resume
 support
Content-Language: en-US
To: Thomas Richard <thomas.richard@bootlin.com>, rafael@kernel.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 gregory.clement@bootlin.com, theo.lebrun@bootlin.com, u-kumar1@ti.com,
 Keerthy <j-keerthy@ti.com>
References: <20231130164953.2043305-1-thomas.richard@bootlin.com>
 <d8f52066-323d-4622-b6b0-32834a504dfe@bootlin.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <d8f52066-323d-4622-b6b0-32834a504dfe@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/01/2024 12:31, Thomas Richard wrote:
> On 11/30/23 17:49, Thomas Richard wrote:
>> From: Théo Lebrun <theo.lebrun@bootlin.com>
>>
>> This add suspend-to-ram support.
> 
> Hello,
> 
> Could someone please take a look at this patch ?

Seems like the MAINTAINER file not up to date regarding ti_bandgap.c and 
ti_j*bandgap.c

[Added Keerthy]



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


