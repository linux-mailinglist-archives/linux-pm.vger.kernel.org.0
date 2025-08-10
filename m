Return-Path: <linux-pm+bounces-32098-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC92EB1FBC2
	for <lists+linux-pm@lfdr.de>; Sun, 10 Aug 2025 20:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B5A53B1BF8
	for <lists+linux-pm@lfdr.de>; Sun, 10 Aug 2025 18:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C251F130A;
	Sun, 10 Aug 2025 18:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uWQ6gLI1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3D01E7C18
	for <linux-pm@vger.kernel.org>; Sun, 10 Aug 2025 18:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754851782; cv=none; b=E0nBdDICkS4eUwT+u1lC/VkI4DniMZykVr846WfZZxtkEWZTgVZ+ZtRcZancW+3nZ3vqZZHqem5qurCxp2w66CuDGUSqeTg7q6Ca6Lh+WGtSvlIy/Rqt3acemGLBCiNY+Gt5EF3xR87VVh7/cYl2Q8PEqQyoKon66xRxtWbF8hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754851782; c=relaxed/simple;
	bh=+m0f/8Wz0IgJC2N6CSjY73b5CgYW14VJQOJL5q82GKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bi/v/0+fFgwMkiidgLOrtND1YPJeXUvAowXAuzNtP7xiZysvIUYZuvm5LsA3rYLWbZFJ8nZ2WQfts6QhA1siXcHSj/tHI973XFFQle8gDZsJi2pYq298JbZf2sGPxPpjxinsqwLv4bPOymiIIS7ZF4LhmXNonN6r3B1gfbpZlQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uWQ6gLI1; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b78d729bb8so2199515f8f.0
        for <linux-pm@vger.kernel.org>; Sun, 10 Aug 2025 11:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754851779; x=1755456579; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C+giQIMd7m4qZAQs1IfGLTMPlMdgW3kw3PRAxKFlO5w=;
        b=uWQ6gLI1/PCjID62RguHX1d8H1rnaAGFhYozomFEOFLDkonZXFEgdsF1WoxzWZ4X3E
         oTG2A8Hp3T6sSmR4X1EFBFlxwiNrYrGOxw9S46fIQbzn7iR/+EUHBkBv2pag1CrFmixO
         11qRjAqQofIX0JXkbB85p46zZTjlO/fZVJTMJBTY9wISmk3Nb2eAHiqrWoI3r6wsP6CC
         VJ00iElpFTud5p9TsKQIPRmI2P1KhZMSmxjGC9wmnll3U5HW9EEcAzMdh1dhYlzaQv/v
         6S9eCNtFazDU27oxPjY2gWIUDA7ipilQG5815VU5or7XIoLpCCjseehY/jxKnnswiJFY
         Q8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754851779; x=1755456579;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+giQIMd7m4qZAQs1IfGLTMPlMdgW3kw3PRAxKFlO5w=;
        b=sO2ggBLZllpd1aU9M5/MdPu26+drMbzZZKqDT2AggNOMi9DUeHfcAnRfBHQur5kxCo
         DtXVsg+ZIZnKuxBgbTjOxEqUuINH87cvJf2X25YUaSHGz0/rgSfXJcs1Av9tVRTI+m22
         9U4XiKDP2kIYSgCn6fw7GD0OlRxNgaBxfrdhgQ98Yc0y448zgWLGfhwqR+1i8qOsc662
         L+IHdPoNuxvk8PXyoYIKmKahD0N+XQQVPGnAbJDIOsoXRlFJG61Rm79uzFWqL/naywNk
         fuv54AMdZJxU+PXnZ67pIJFz4QtUSHyEDFvdv5qmIwOzXRQcVoE30iboWH4NUWRXJlTx
         2DYw==
X-Gm-Message-State: AOJu0YyIwMTlD2QP1ImhWiBrmm1T1bx3On7ME99uEis23O+GQnoI4zWD
	gyguzcEkhI07cAPUONDwBrWx6K39HopZYdIT2t/uidU6TA/XIy8nxhaajTfbYE5aD2PhrhG4kFa
	uBqZI
X-Gm-Gg: ASbGnctt+I8mq57YwKfJHrvruoVoYoQYgl++3CtAjewvWkKxg6R24vSBULxxf4dIYwG
	6aXH/nVcTIYtbUNmR6gSamb6WHFVfDIBZ5548kVuYeUYSor/xYPCcyWxTDuI5tWlPMFJ178rSLN
	84NZr/6094FhzK4a/4pr7W/v7NBs+ZagpXiZE7Jo4zcs7y06FP9C5IQ7J+ZrE6UnUknEsfXWvWz
	pxSSQtJ1jptwbQgHJglPWDCYg8Ly4pDmmyLrEKIrdgjxSBufInjsMNXh+y96wBuRG8JWxkDR6SD
	Yqh4OoF1IVvsjYMfwxEJHXXG5CNxqBYnMcYLvsKAz2nKOerogOYBJVnPcZyS2svfI3FG7EwLAjS
	UTaovr1yEF/bpY6srfjyy2vkBeW+QZmA91Dr4dbuVt9llZvVMVEqEysSKMYtinQ==
X-Google-Smtp-Source: AGHT+IFfs2joP+hTnlHJExYamGs1Mie+WylWNRVEVWEDjKYPH+QgYIc7bMaEg3+/K7QR4ekiHHl1Sg==
X-Received: by 2002:a05:6000:4308:b0:3b7:9350:d372 with SMTP id ffacd0b85a97d-3b900b4e1c5mr10053914f8f.24.1754851779122;
        Sun, 10 Aug 2025 11:49:39 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b8fc6ef28esm13316144f8f.60.2025.08.10.11.49.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Aug 2025 11:49:38 -0700 (PDT)
Message-ID: <c0aa0d9e-afc0-4be4-88ca-ea5629b0be9e@linaro.org>
Date: Sun, 10 Aug 2025 20:49:37 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Possible bug]: thermal and an scaling governor issues
To: Marcos Dione <mdione@grulic.org.ar>
Cc: linux-pm@vger.kernel.org
References: <aJjKckusX3imDMf2@ioniq>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <aJjKckusX3imDMf2@ioniq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/08/2025 18:36, Marcos Dione wrote:
> On Sun, Aug 03, 2025 at 10:18:33PM +0200, Daniel Lezcano wrote:
>> IIUC, it is a laptop.
> 
>      yes.
> 
>> There can be a couple of things. The difficult part is the firmware can do
>> actions under the hood, the userspace may change the governors depending on
>> the temperature and the kernel can do something else.
> 
>      Do we get any events about this or is 100% transparent?

It depends on the firmware and the hardware. Well all the thermal stack 
is arch specific so it is hard to give a simple answer. But if the 
system is configured with thermal zones and trip points, then it should 
be possible to monitor the temperature events when the temperature 
thresholds are crossed.

>> I suggest to investigate first the temperature sensor for the skin (or case)
>> and the battery. What are their temperature when you compile ?
> 
>      As I mention, I had to disable monitoring, but I could check
> manually. All I can say is that that was particularly not hot (much less
> heatwave-y) week, so it _should_ have been cooler than usual (for this
> period). Also, a reboot fixed it, so it was not that.

If the governors are changed, that means the userspace does an action 
and it is usually the thermal daemon. And this one IIUC is supposed to 
monitor the skin temperature.

If it happens again, you should double check the skin temperature sensor 
(or case sensor). This one is supposed to be monitored by the thermal 
daemon and should stay below 43°C. The thermald can change the governor 
if it detects the skin temperature sensor is getting hot.

One common scenario is fast charging while computing. And with the 
years, the thermal compound can lose its thermal conduction properties 
leading to the heat not being evacuated efficiently.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

