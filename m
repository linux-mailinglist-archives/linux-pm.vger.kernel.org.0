Return-Path: <linux-pm+bounces-21130-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE03A232C1
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 18:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9264B1667AB
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 17:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E5E1EF08F;
	Thu, 30 Jan 2025 17:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rsa9f5ku"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBEE1EEA37
	for <linux-pm@vger.kernel.org>; Thu, 30 Jan 2025 17:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738257887; cv=none; b=UlF3bcaR0iLCUzeURInRn9ttEylsSW1gT+aYCeVK6FAiSm555XeOFfb4/FENzTK1b+PlmM9pXgHEeXX2wZPTME5zGDkKbW4rDWLIlpJ7EBywbrCNpvDYB6r5BWs/F8XWX8lOzWJ0QIpFlZlOpOLtlpJHf+z/UZ6Ymp9EJcUSEWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738257887; c=relaxed/simple;
	bh=lhgUmgTEIT/vBwhj68pfvvbInab5tq3uuxQ9tFQKC3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=flTzrdDNmeHtKnZfcfSwgI7jYB+xTxklRXGiZXDzIAcTa5WL68m0kWi8sv685DjhdmUlur2mB1pnDoZhhdpFK7Js5wx3BGJ9b1uQD/Ahb76vN1pcj6yxS+TDIEZcHpA6/D6ScOoB+VBC1rNKF3rY7ApWuXdKjtJzAt5IIbwKX+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rsa9f5ku; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso673458f8f.3
        for <linux-pm@vger.kernel.org>; Thu, 30 Jan 2025 09:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738257883; x=1738862683; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XyeDfNgF8wSUnxJsK4c0ibCBKb5iWxSmVaedgdkZ/qE=;
        b=rsa9f5kuF/qfLSmiWJdpoofhGH81/rcL7eupFaAbtfsJfFjsYXwusoVMGSkta+NOQJ
         rsGWqUcf/Kw6padrDj75HTJwZ2INUAArnhcxlCaTRDElPQ0UT4rPdhecRn96PmhpC0Y0
         RZx76cgRq2wAxLbNglfXxcGcWw7U8rea3vWPOJx/D+wGeotjJA1UWP70L9zLel7dtV61
         4aXksx6NqkeukoWuLCRiGLDuAwLAFcKbam/Uu6g+Vux2zMhTBl6nfA9MB/Fd04TubxI/
         zFYShFOjY2OmCB8eDOsmrBQ6JBognAdRYK+pUwfSqGIQ1b9Nymah82RzfvJHjg8/Klzg
         DjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738257883; x=1738862683;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XyeDfNgF8wSUnxJsK4c0ibCBKb5iWxSmVaedgdkZ/qE=;
        b=BKclC/vCnxi0zLBspMs07e/VMxNRRITtkaNRBXoPpSh/yXPw5EEx7SvjZYpYZvkxSv
         UdN1pP+9eAtFenv6SYRKqAFwqa6x/jDF1szPQdYL7aMZc1s9fMl0VEDXInhm6FhOhkL8
         PBkayNQT8LjF/EJAx2AZA57ei/j66WexpMf4M37OPA6/ZtatHnXM1+pPL0Dgndlt6ize
         KFWjFRLpNhA3T07xNBxzTsQpgDSPXCx793Mozez0YXM8v06VU0yZqV9/QOQ4UAyLdUm5
         KIxQyqNgAdwII+ft6WHb6OlaTBEXjhpWo4Tw2EA4YlXyDRyyzDZDzbaNd/yZUNnC+96s
         POLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJoLkcN+yYxknBXaeHrtU416GAvtBFbV4QYLVMDB1GjuUO0UKUmcZJtSZDZOM4Umvnxm2AwxLXTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzDBrdFTz6LkNlw9r7oaWT+btblP+xeCtCWW/JBwTGhxT8H+L5
	gUTniQwC4706UKOVBryYB60JTTl11vSHdB5nKYwZLjWndnLGIPMIZ74YUjHYpZM=
X-Gm-Gg: ASbGncvFL6LlFwKHxx+vpkJCuTELXgJrErzQ2ZIQkhztTqtBD9VkDNBd0siOgY5fj7G
	LrxIn8NU1BQw9UiNZsx5X2ZW/E9d0OrQkiltVPS/B63yxtPZ84aZo4zRcbBLINB2S7LqK5Qc9MZ
	QV55/8zqtYdTkql0PQBsTLK8s+UtMKMqOqVUjnOF3U52/51WxIIKNt5Rbo4NxqzPWLy/1NOk3Gr
	RWwIAC7XUIQESGZFqCMwXRGkfl1yjN8O4K74EUWakiy9c1y4mEsBS3JExnbUJz6nFvllpeU36BR
	9s+l3IzrLqagUlZ8fYhi+pm8pmVYTNoHcMt9hBeieITzT2lHy0CRRS0=
X-Google-Smtp-Source: AGHT+IFOKhwS7SVTZlAgB/KmUq5YUcsnKXwUcdqRruGMwNm81PK27tTx5RK+9qsQBjRXDr0I6E36aQ==
X-Received: by 2002:a5d:6d02:0:b0:385:f092:e1a with SMTP id ffacd0b85a97d-38c5194c3b6mr6343222f8f.11.1738257883252;
        Thu, 30 Jan 2025 09:24:43 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38c5c0ebfdasm2599755f8f.17.2025.01.30.09.24.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 09:24:42 -0800 (PST)
Message-ID: <b496d933-3c57-4b02-ab65-0582a30939af@linaro.org>
Date: Thu, 30 Jan 2025 18:24:41 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] thermal: of: Export non-devres helper to
 register/unregister thermal zone
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: rafael@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, mturquette@baylibre.com,
 sboyd@kernel.org, p.zabel@pengutronix.de, ulf.hansson@linaro.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20250103163805.1775705-1-claudiu.beznea.uj@bp.renesas.com>
 <20250103163805.1775705-3-claudiu.beznea.uj@bp.renesas.com>
 <Z5pkUNNvsWPjRQvy@mai.linaro.org>
 <65a16c3f-456e-40ec-91b0-afb57269ed46@tuxon.dev>
 <Z5tPR_tv7vWDkUI7@mai.linaro.org>
 <6ed7d545-82d7-4bca-95ec-95447586bb58@tuxon.dev>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <6ed7d545-82d7-4bca-95ec-95447586bb58@tuxon.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30/01/2025 11:30, Claudiu Beznea wrote:
> 
> 
> On 30.01.2025 12:07, Daniel Lezcano wrote:
>> On Thu, Jan 30, 2025 at 11:08:03AM +0200, Claudiu Beznea wrote:
>>> Hi, Daniel,

[ ... ]

>>>> Would the IP need some cycles to capture the temperature accurately after the
>>>> clock is enabled ?
>>>
>>> There is nothing about this mentioned about this in the HW manual of the
>>> RZ/G3S SoC. The only points mentioned are as described in the driver code:
>>> - wait at least 3us after each IIO channel read
>>> - wait at least 30us after enabling the sensor
>>> - wait at least 50us after setting OE bit in TSU_SM
>>>
>>> For this I chose to have it implemented as proposed.
>>
>> IMO, disabling/enabling the clock between two reads through the pm runtime may
>> not be a good thing, especially if the system enters a thermal situation where
>> it has to mitigate.
>>
>> Without any testing capturing the temperatures and compare between the always-on
>> and on/off, it is hard to say if it is true or not. Up to you to test that or
>> not. If you think it is fine, then let's go with it.
> 
> I tested it with and w/o the runtime PM and on/off support (so, everything
> ON from the probe) and the reported temperature values were similar.


Did you remove the roundup to 0.5°C ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

