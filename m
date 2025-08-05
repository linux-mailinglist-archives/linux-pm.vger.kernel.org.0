Return-Path: <linux-pm+bounces-31961-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CD5B1B1B6
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 12:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E61B0162FDB
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 10:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7CC26A0A6;
	Tue,  5 Aug 2025 10:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F00kzYyM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9BA260575
	for <linux-pm@vger.kernel.org>; Tue,  5 Aug 2025 10:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754388349; cv=none; b=d6Dkc3NKfGxRoRf1t4WsGDDnb3GOOM+M+9zKreYFr1ZFrABqQ37ZFVIu5rx42NSEc4c/QLI49m60u6eH5XvjjNKrnrit9o60+lYRJ1OH4fEs/Vq+z8Myj05SW+RU6h++7OhzbqF9U8skr+ikYIRoA05yZomHOggNEoS1e54OYvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754388349; c=relaxed/simple;
	bh=6C+1KQrRGEVs5yevENfdWXMJjYaH1qtssIzaEcKbKsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qXLx4Y3ccYLGYErOt6gC6BnV3gaG+N/qB7PuXto6TZI91guw79eqCSCukUKlGY5wtDWwGADDL3fGYs4dXKVAzB+4rmIiAja40Fc0bOoAifJsrIplSoE9bPvXglyV7IpoaP7kELPxHPjzoCBQ6MoKMLnRKG/gXWe51qxUz2Diu/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F00kzYyM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-459e210bd2dso1748785e9.1
        for <linux-pm@vger.kernel.org>; Tue, 05 Aug 2025 03:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754388346; x=1754993146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5WlJi9cGntow0MX8lCUDCRyZGY71FSIx/7fRRzmtG1E=;
        b=F00kzYyMEQxFqtv/g7wiZp8ZAX+n9IM+PU13a4ryesbNAm/oz67tgIoAWgp/ew5csO
         t1a9JCOh1M42LRjpYYfz/n2q3m74KxqJGSxBaqn40Dh3xURAMvytxKoL9rnmy9FP4bZj
         JILZ4hObWOjKVyg6wYrk6YoTKZZhfwRjBdaJDmAacMripyQZV8MtYjjtyqyZqRwmxzTE
         JA6OvyPcq01D1xZO1gWeq8nClslaS/cTTgHpwfgO7jgZYyrS/Ida5cPA4ek2Em8spxP0
         Z99BQB9qBvnV4nDCNBmlbzIyxppy8ZoRGlaGxyGJaS5aGsafHUsCI44y7sjFMzm1jqbk
         xxkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754388346; x=1754993146;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5WlJi9cGntow0MX8lCUDCRyZGY71FSIx/7fRRzmtG1E=;
        b=PGKU46611q7o9LhpZlkQI3fVLAHlgA/vVmbkW7EUl+UccPD351XUy0a5Uo2s+h3JYV
         CC+l/U9PoyfmdaodG1QhWF7c/ENhY+0VCqN27hY7jMOaDLHjvlipFgNjqpE4lJGcbbFr
         PoCKXWVF6WcSi7bUv92jLjMSIXOvcrlp4McGgOZDfFmlpf4dzMswOGzlhL7EZSh7qO7b
         BDbhBLIONuEt0AR35I7iUJVkQBy+ocyJqA9uMRC8dArGSCFwOqngoPBYsj86PfYWw2Ar
         /uWgCWaIO6y+ddrFjzMG6UIy12LsH5/7MKve6CXvNdKA9YRBH2Tuf/1tAK1eW3MU8kzx
         CSpw==
X-Forwarded-Encrypted: i=1; AJvYcCUEiRWWIu+Kx6t5+WtX0aRddU0IP9IbeZE/3/XZK8Z0/XXbGik9545laywQO5BgHbiU3oaCrd2nSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPz8lVM50mOquoGZcWv+WHc2VXAwHlBApz9pvz+2wMasqGBfXn
	eSTrcbpVjER1LLcqlFBTWUwhkXuCCWYqoDkTcJrXi6C2RN80bL/ExNCYVq7HQ+2epx0=
X-Gm-Gg: ASbGncsCk0nZ3CwfIuvyxw5vqdztdTQurPpCLNUm1YwEiOQ+0bzUh8ieeN+09+WTTK6
	rSpBApf7Z5YPPU+Jue+iYYWvtWJrZ96HkjkRdMdJB3a14JvC8TEwnWDyykXKxpnOlBu56rIjHJj
	oel5LvBor7CFnfLvxLT//L9tZodEz7j8AP8NKZ3r471MDLJqDqMmmAhCD5lkngvtTWPN9Y1Dqk2
	pZnrXSYXWJuGLUBXQ8uBp4Am69bH3ohaAwXCJ/6v5I8LXa35ZtjILZa0sLbsK/ujxVj7/s0EK3R
	3exiIFKy/ocmlbbLloIBf5qSzfUx28bTGKYIzddTaXpIBeZMZelzejB+jZW8WpEnKyyjZVCA7KD
	hnDZuDWAjznRBVncmH8/w35Icz0lJjrOqZ8ywxU6pGG2z/SGZYJD72rayZ/xp6cc/2rPhns0r
X-Google-Smtp-Source: AGHT+IH+DQ96eXMvvGEe+t/KMa5/NOiWF9sy7ZABIms9qVBZ7ZnokCJwIj+c1GxCOC9C5xJiKziJOg==
X-Received: by 2002:a05:600c:6748:b0:456:1d06:f37d with SMTP id 5b1f17b1804b1-459e0d12436mr25547225e9.16.1754388346499;
        Tue, 05 Aug 2025 03:05:46 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-458ba0a133bsm124646055e9.0.2025.08.05.03.05.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 03:05:46 -0700 (PDT)
Message-ID: <6e496737-3cec-425e-a4a1-29b576f8eade@linaro.org>
Date: Tue, 5 Aug 2025 12:05:45 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] thermal: renesas: rzg3e: Add thermal driver for
 the Renesas RZ/G3E SoC
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "geert+renesas@glider.be" <geert+renesas@glider.be>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "rafael@kernel.org" <rafael@kernel.org>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "john.madieu@gmail.com" <john.madieu@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "lukasz.luba@arm.com" <lukasz.luba@arm.com>,
 "magnus.damm" <magnus.damm@gmail.com>, "robh@kernel.org" <robh@kernel.org>,
 "rui.zhang@intel.com" <rui.zhang@intel.com>,
 "sboyd@kernel.org" <sboyd@kernel.org>,
 "niklas.soderlund+renesas@ragnatech.se"
 <niklas.soderlund+renesas@ragnatech.se>
References: <20250522182252.1593159-1-john.madieu.xa@bp.renesas.com>
 <20250522182252.1593159-4-john.madieu.xa@bp.renesas.com>
 <aHgVe0YwPWapIYed@mai.linaro.org>
 <OSCPR01MB14647DE009925C982AE6BB5D2FF27A@OSCPR01MB14647.jpnprd01.prod.outlook.com>
 <64622ffd-05d1-43c3-85d0-cf98f3012477@linaro.org>
 <OSCPR01MB1464771054F720542F817E84FFF22A@OSCPR01MB14647.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <OSCPR01MB1464771054F720542F817E84FFF22A@OSCPR01MB14647.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi John,


On 05/08/2025 09:49, John Madieu wrote:

[ ... ]

>>> I might not get what you are asking, but since I compute the
>>> temperature in the hard IRQ handler, I just wait for it to complete
>>> and notify the completion so I can grab the processed value to notify
>>> the thermal core.
>>>
>>> Please let me know if this does not answer your question.
>>
>> Can you describe how the sensor works ? And perhaps if you have a pointer
>> to some documentation ?
> 
> Here is the documentation [1]. The thermal device is referred to as TSU.
> 
> [1] https://www.renesas.com/en/document/mah/rzg3e-group-users-manual-hardware?r=25574493
> 
>>    [ ... ]

Thanks for the pointer. I got it now ;)

I'm a bit worried about the latency introduced by this mechanism when 
the system is entering in a thermal pressure episode.

The get_temp function wait for a completion up to 100ms, it is a lot. 
Especially if the userspace can be reading the temperature and blocking 
the read.

There is also the spin_lock taken introducing another lock while the 
get_temp function is holding a mutex on the thermal zone.

Did you it that under stress ?

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

