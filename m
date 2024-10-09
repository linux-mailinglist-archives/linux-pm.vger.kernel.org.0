Return-Path: <linux-pm+bounces-15404-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EFB997067
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 18:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F16071C218ED
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 16:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F826188933;
	Wed,  9 Oct 2024 15:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PkONJvEN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3B11F941F
	for <linux-pm@vger.kernel.org>; Wed,  9 Oct 2024 15:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728488408; cv=none; b=oo75RXs48tbx7uxknlFltBfA8pcmcInB1EY8Zd9oOCUShOOcXwsw3+ZKHFRnM+ZtXNEiSzcS3E3I3w5l7UAJ+nM1kfT8oPt5kLV2nRBQ8lEm0Cz3D8S4PrKHMSlFp+L+JfGUN5Ddz+cmqpqrCc7ru6hPtLn8FyVEqHb4caSxHhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728488408; c=relaxed/simple;
	bh=mSoYez4TWnPgCP5vr7VlFkpaLGlDgSQMrQ3kmpTbE1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X4o6KTtb20MSVcbzj1zHD0Pnu8AvlUsOY60oCR55qWJ3kSxHUS7B+VFUIvgQRQBd/PMt5EDlUAEqe7tvBGLC2jk0Ba6OJ9SFiOHD23vcq9sjdsvoxs4QwnomFosvCQKEPeWlTbkFA9jadB7shKcrIxeX4z8vel5eGRG5x4ciGms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PkONJvEN; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-430f6bc9ca6so7811345e9.2
        for <linux-pm@vger.kernel.org>; Wed, 09 Oct 2024 08:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728488405; x=1729093205; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NYMPi8CmZ3ngkhFaVHFKAUjC/m+g8LtQIOYX+DED77k=;
        b=PkONJvENQW0z2NtN6/VQJ0ZvmCUlF3QGGJFpJ5KtDqQ/wgq45FP+w/7Z/vQcRCN284
         l4zZ7M6qXe0cPRtvyXCJmEO+wVA6CmB9WSydL87/ojIH8Kndhjh+ZCE6BhtS+Mhi4S7K
         GAhIuGk4VY65ZSeeHHQ+0ZbLEM113CKdZtKAGx3CKaxCtj5zLlaLz6+MLmODgPthVf2A
         BsarmmGYIlKf/26tj/wuvXSnSGh/P+UCNC6Aw2ljmNu+Ip18DXwMvwfw4bfezcfTLZPf
         Mpj4ysVjoq9tlWu9AsuCv3Gp0kTULmfF0aN3mtiZHcLUVyjZiBfn1deah8J0fA3BR9u6
         biww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728488405; x=1729093205;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NYMPi8CmZ3ngkhFaVHFKAUjC/m+g8LtQIOYX+DED77k=;
        b=pllKuIDFhrb7n/al458yyVY2GkIwX4ziK/V7JTYnkDlpO696fAkEIyVY3nEPux6pJt
         +24tL7U1Fe0Bchf5yxmKQgZUENTWUI6E9BUUtQLbcWEsx8ZajoN+B1VCbw0hKoQ+fu7H
         WQF0wqmsifDTi8LmGyMfxdghnZurwNDY++DLcd+8txiGHG7dXNw8jeb/C+P/FmwNX47b
         LcNn8V3FD9Im6KJkEKU1vTBmSeBEj4D9gw5ywjWbnHFx0IhRSBI5CS39NjLBIzBXQ6p2
         zDkZeTkWDRcSwHv8ds9Qv00yUhgMFf8lnfh0zgqAC+cqUvVG+I6lKyL8Q9ooY0D0PYhk
         tbbg==
X-Gm-Message-State: AOJu0YwQ1tdQXy2YkprdK6+osZaTqmiiuae/qyCo6DKW8LgEua6eK2Uh
	3nul5yQ8X7YR/escqBoUsIQva9T8k58mwGgAI0B1U8GIef9wCVTZIkd5HA1mbvA=
X-Google-Smtp-Source: AGHT+IHriasfxt1zCW+kQUbMH8hbmIK2TVOn+WmEegpCURuadVy8IaMYzS27umFJzcrTTTeq+HuVmg==
X-Received: by 2002:a05:600c:1d09:b0:42f:68e8:d874 with SMTP id 5b1f17b1804b1-430d70b3e15mr21203045e9.31.1728488404736;
        Wed, 09 Oct 2024 08:40:04 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37d32ea1d98sm3782610f8f.68.2024.10.09.08.40.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 08:40:04 -0700 (PDT)
Message-ID: <d9682276-1068-4b90-8478-bf1f5047d306@linaro.org>
Date: Wed, 9 Oct 2024 17:40:03 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] thermal/core: Add user thresholds support
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, lukasz.luba@arm.com, quic_manafm@quicinc.com
References: <20240923100005.2532430-1-daniel.lezcano@linaro.org>
 <20240923100005.2532430-2-daniel.lezcano@linaro.org>
 <CAJZ5v0i9N_ie_duMXYSumQSnFDVxHj1h1ikSyrApJyEjXs_mQg@mail.gmail.com>
 <CAJZ5v0jCOHAmpmniVRuGCrtvKj6+YtCKidKSJf1t+HitwpKrwg@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0jCOHAmpmniVRuGCrtvKj6+YtCKidKSJf1t+HitwpKrwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Rafael,

On 02/10/2024 14:22, Rafael J. Wysocki wrote:
> On Tue, Oct 1, 2024 at 9:57 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Mon, Sep 23, 2024 at 12:00 PM Daniel Lezcano
>> <daniel.lezcano@linaro.org> wrote:
>>>
>>> The user thresholds mechanism is a way to have the userspace to tell
>>> the thermal framework to send a notification when a temperature limit
>>> is crossed. There is no id, no hysteresis, just the temperature and
>>> the direction of the limit crossing. That means we can be notified
>>> when a threshold is crossed the way up only, or the way down only or
>>> both ways. That allows to create hysteresis values if it is needed.

[ ... ]


> I'm inclined to apply these 2 patches with the change mentioned above,
> so that I can base my 6.13 work on them.

I was expecting you to pick these two patches and do the modifications 
but I don't see them in your tree. Did I misunderstood your comment?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

