Return-Path: <linux-pm+bounces-36914-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4BBC0DDE6
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 14:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DFA442290B
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 13:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C89277C96;
	Mon, 27 Oct 2025 13:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwFg2t9S"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77E9278E5D
	for <linux-pm@vger.kernel.org>; Mon, 27 Oct 2025 13:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761570133; cv=none; b=TaNZgp6a5rRnF5Xq22dQ9g6LuiSeJNgT0n0H/PUPhFxetd3K7FoFPujd715u5S3KGQnmjcOUhiCmtzJBo39xOVwo8Nfad6GJk4yf2WoIke6PfxCocN5v/BZihPF2qeTfEOMVJi1SYSYgpJc0Z1Z1BXUricT0cU3hq/NVXezr32o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761570133; c=relaxed/simple;
	bh=1bB7L68kzJayTBvOhwCV/SjorHR+hB0GqpWfqKFMQiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mv7X46hKV0KFBvzMhqk5mZ3Hs7hQHk94xU/TBu8Um/1OW/eiNAG6VfV4Z6XKvnw8eKtHUrHrhg+JDbdxgQSg6jo22ctm4NJ9lmtDcAF55MRBpYrgNPIVNemJaze3O81igsl0+EGiMMoDtVUCnPvL2WFjY/N0R5wRwVeBEuaWC4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwFg2t9S; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-378ddb31efaso54663371fa.3
        for <linux-pm@vger.kernel.org>; Mon, 27 Oct 2025 06:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761570130; x=1762174930; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pxCTtcPsN8230LeCJx3j5DlRF4pEORPX1pABk9GNfEI=;
        b=fwFg2t9SG/sQuwHr+iOuOpC3wwIySvcp88EAW5Qw6/Py2Yfu/2U3pqbMMiloyGL1yn
         G9+B5zMpSpXM4hzVroUx7nDp4F1WdWzgZg3/FxjVAiX/Cn2Qg5zLHAX0lZEjldlbL2p3
         sByH1SDT+v5XdZLtuZLBrns3GsT6co610lr6RHkGvnsXR3xhPpteK5/q/8y+qpLRVKv9
         tqxel4Y+g408wgC2IBHHrud94bIMJraSCJnK06sYsrH0aUCYiyPkLl3PKUu3WFvxd7fU
         BmmnRXhLT5m0u7X26zANng3rEGNz/8K0OXYPDigWUZrtMZdikTBFGHkLk6rpt4Ib2ehe
         kBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761570130; x=1762174930;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pxCTtcPsN8230LeCJx3j5DlRF4pEORPX1pABk9GNfEI=;
        b=mzeziWCOCisD0S8HzutiANgS9jiABcj7CNRvzTwMdbc4IIbNYwv5b96sDvRl9d87UJ
         Qh/jSFq1pLTdAJk9paj87qzTWHhDR+OLKzuAIi0D+EYpo1ojeEolzQaJXb0RnaqA0vBX
         +ifMtnL/41K6H1tDdcudSptmRCICxwvRp3FFLiE0tA6M2BhGRtbCoH/QcC8zhwuzzx2T
         5uR4k+f9fBf5RwhAsXQdHNa+PmuvOtle01MbVlGZW4gXrkqH8ZBxCmZpZuJGgrc2RiUc
         +aow6ZO+HrnOTZ39Bqj+5MA57ClDXun2xnMlG99cpzz/FJ/YWBFh3XRrjLhqfMrbPGG5
         7RDQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5l2LOx+7FPc8Z2soL49QcwrPhsLqy8TBnp4RxF36Tg2GQ71U6wYSXmyjdm69JcvdpBgXtFG45eQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8v4i6ywG3BrPyJqze95Op+566veDH2aq1iJULWVonPqUI5Adl
	3Iq/pio6ES88n+JN5r7etmZ4Z0TCRir7fYf8CSYEMvHz0XDkoh6VDuX6
X-Gm-Gg: ASbGncvLs7ePVIuqBQ48hT+jgc2P10m3iCyLZ6jynKFieXZladFNzFN+xUVaaZcGS08
	2WndWkjADixZVW21oEIVmi/fjZJxtygZBwYxFCB+URuXFpS8Z5TqDzMrQhKIHzYGErHfw6mjQoh
	aFPbY0uFrcGT3moM9gd/p5JJrsIPUPsU2X+8+LYqoDkh7CpvskSuBLYZFiEX59KD3f6j9a9uAg0
	0KGWyrQ+2zyciN5BE5L641eIFTqQ3PN4rV4AWLEMVa7eoxDWC9C+FvsR2bwaWvN3Ucw8IgtbYo4
	74XtFKzui9o/vjE5Lxh8B4aptMa4L8xS2rJflLS/qz7SepzHEudhu4uJlS7Gcfsir0tZo8TTODB
	ix1c6SgJgMOwqREk6FtcD43MSRjARe5hd0IN8hz8qnfz/+uCYU9bIKTGld0XDEOD6RwlHnwUXK5
	3JjB19F8raQ24zhJf7P5Ow6PV2sdP3xpvyjAcuIn2qXfV8Ae8nS1DjPOGyVw+VrrmaD6OL
X-Google-Smtp-Source: AGHT+IEl/ogSJ08y9LQ2dV4OaLLEyD6Fjj0ThgIRaIYYP5R3v0fiFqlQt8CBQpsPUF3Equew6ssOkw==
X-Received: by 2002:a2e:b893:0:b0:36c:f6:a4e1 with SMTP id 38308e7fff4ca-377978c6d84mr104935861fa.14.1761570129393;
        Mon, 27 Oct 2025 06:02:09 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378ee0d0028sm19860371fa.35.2025.10.27.06.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 06:02:08 -0700 (PDT)
Message-ID: <a74c9c52-7c39-4c66-bdcf-0fb9e1b8f77c@gmail.com>
Date: Mon, 27 Oct 2025 15:02:07 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/15] rtc: bd70528: Support BD72720 rtc
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Andreas Kemnade <andreas@kemnade.info>,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-rtc@vger.kernel.org
References: <cover.1761564043.git.mazziesaccount@gmail.com>
 <380ea1fdbb94a796418e8f463c6a9436001d572d.1761564043.git.mazziesaccount@gmail.com>
 <202510271238195ef3bdfb@mail.local>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <202510271238195ef3bdfb@mail.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/10/2025 14:38, Alexandre Belloni wrote:
> On 27/10/2025 13:47:51+0200, Matti Vaittinen wrote:
>> The BD72720 has similar RTC block as a few other ROHM PMICs.
>>
>> Add support for BD72720 RTC.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
> 
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> Note that we didn't get 07/15 that adds linux/mfd/rohm-bd72720.h which
> this patch depends on.

Thanks for the heads-up Alexandre!

For some reason the SMTP server seems to be blocking the 7/15 :/ I will 
try to figure out a way to send it :(

Yours,
	-- Matti

