Return-Path: <linux-pm+bounces-16055-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AEA9A56A6
	for <lists+linux-pm@lfdr.de>; Sun, 20 Oct 2024 22:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25CDC1C20362
	for <lists+linux-pm@lfdr.de>; Sun, 20 Oct 2024 20:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C03194A54;
	Sun, 20 Oct 2024 20:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kn+tdqob"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E48D195980
	for <linux-pm@vger.kernel.org>; Sun, 20 Oct 2024 20:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729455544; cv=none; b=VFAhp+dc9DpM2HRUtNyyPPgHbE6SeOg12sjd2Pv5iCOvawlnfa9/+nkV2chn1h14PcRLedHelFA8ty11j0KqARH0/b+NRrJmJsMC4PsaL3FfLeLBhE8g9MK260xv3NI1+tvuCpxqv2auUceqFOpCokDswVU0gmvFxCAj3eeDLE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729455544; c=relaxed/simple;
	bh=CssCQm+6l29hv6brftWqlElgI+HrNHVyrGQ4XIVgCPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zls6l11qRZW2RlNG2pU7y6hxl6BBdSZut79gjTzVt07Lozk6O4cUnsBNhVyCPuh1jKZ5BFGEEmuo4RELi5BvAfSpGa1Xzk0vDOAwEmF9vwbC0+OJcua2IFR1s4XCaIWbuVNhTO5PR/R7BsuCnOnUju/TilFWzwuZzdW9C0POTzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kn+tdqob; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d4d1b48f3so2744348f8f.1
        for <linux-pm@vger.kernel.org>; Sun, 20 Oct 2024 13:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729455540; x=1730060340; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wrJzllM3RoVHcLYtwNcRLxYySq6Y9MbwFZco87SqGWg=;
        b=kn+tdqobwbiZ7/mSOLOS8C+mLaXhjdoucP0SlwJoejr0ZWKFA0N/PFO43hCokRyR3/
         XZn+cEDguERb68FN2cU+UE+WTlGvfdCQ+WjN1FyWSxybt7ceHm1BXF9KgWDmlp7n1Fkq
         HgFe0eDqE2ZJo+jduqVNuk5RpRQohYNWG4eN6ioEvoIHRncinzptXluOqebfngMw3ejD
         wfPaDpYknulZMFbUscFAnWGcF86MwZhTuriRvBaUgspgOVOH3L+ThwgDSXN1BmMsNIk4
         L7Snuky1p1++MbSbY78SecPNpEz2827daGx9e/TbVRBZLtSfqO620ETmtyEyAftiZ+Ke
         NO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729455540; x=1730060340;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wrJzllM3RoVHcLYtwNcRLxYySq6Y9MbwFZco87SqGWg=;
        b=QAp97Qu/Evuj6+LxzNkAybDgp7Wzlso2P5r4HPn9yjQOehVKORHntrYs6keW/DNMID
         jerBUEoaPpNuQYsBVXe923cW0b3SIGSS4YpSVkPNcicmyQbIDllf5E4dHJTHACiD6iXO
         JshoQd9snk4LOA1BxCMm4Esk1YWD9VcjARMoxboLaEpyZkaCMulUAVjz1TTWzgdFvFQz
         GlT256XVB3dI7b9lh2Jmu9YZMT9tbdUHABQfm7sDsj0UUJ2FXFhhuymrphtNctlTiYct
         QcMvUj66BbZi97+oxgM+8Su8ze3aKkC4Zn3nddVufuxHkBxYk5hfpPYugsgbbh4jt+zN
         RhaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnoFYu2HnvFzNmyT5vycsbk0XPgtlS03xPqszM1VHnTQLg/RVsMhli8ZN8KeCz0XCzikLY/mGn7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YygY6UhK15kKtzlOcrQYI+ziBc6PddhjVFiVXNb2CBpaUHia/T+
	nb3PqKf3Obbebs/IM4bWgrYp1wemBE3h4+TxjpVm/glnMfFILtbG3dsMbTxPf0w=
X-Google-Smtp-Source: AGHT+IG78rRPQuarBnayEBUXbO8lPtaj5aqFzsnSvrw5i5NGzYbsrg6hFImRhIax0JFAYXcp1QKJoA==
X-Received: by 2002:a5d:5449:0:b0:374:c3a3:1f4f with SMTP id ffacd0b85a97d-37eab6ee8b6mr5856991f8f.24.1729455540477;
        Sun, 20 Oct 2024 13:19:00 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37ee0a4856fsm2462477f8f.33.2024.10.20.13.18.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2024 13:18:59 -0700 (PDT)
Message-ID: <c1696a4f-d6af-4445-ab30-c95d3dc63f6b@linaro.org>
Date: Sun, 20 Oct 2024 22:18:58 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: Switch back to struct platform_driver::remove()
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 linux-pm@vger.kernel.org
References: <20241019163412.304422-2-u.kleine-koenig@baylibre.com>
 <xrrogvkxtepavpmxnfj7mlggv3lubrgzx4jobdq2rdzyzduczc@kyatfjnrb73j>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <xrrogvkxtepavpmxnfj7mlggv3lubrgzx4jobdq2rdzyzduczc@kyatfjnrb73j>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/10/2024 17:42, Uwe Kleine-König wrote:
> Hello,
> 
> On Sat, Oct 19, 2024 at 06:34:11PM +0200, Uwe Kleine-König wrote:
>> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
>> return void") .remove() is (again) the right callback to implement for
>> platform drivers.
>>
>> Convert all platform drivers below drivers/thermalto use .remove(), with
> 
> while using this commit log as template for the next patch of this type
> I noticed a missing space in the line above. s/thermalto/thermal to/.
> 
> Would be great if this could be fixed up when applying, or should I
> resend with this fixed?

Hi Uwe,

no worries, I'll take care of fixing the typo



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

