Return-Path: <linux-pm+bounces-12759-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDBB95BD08
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 19:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6E92B2DB98
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 17:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D741CEAD4;
	Thu, 22 Aug 2024 17:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="myViYUgn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303621CE6E3
	for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 17:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724346514; cv=none; b=E5AIpOLFtwcg4CDMjyikPmFWM2ggzqh5RIoe+xTPNL3Sbt1n+DoYBEqIIAOLveUct5dFp19N3XRO7cvEZ43Qo70D0ttpeKXTJVMr8pcPNkwvJ595HRQVvFT2VAp0WvGOgEd0gdsdR8BRJFgnsgBSakVrh+IV/Nd9Tt0ouoc9wB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724346514; c=relaxed/simple;
	bh=VQoO9aJwIZnm5JCEtxkQc4epD2eguPezyJ06xyBBFw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=omNBW0eUv9Q1R713hNHaN3CQDd9mHMJOduIcNfIYVHuhZvZJsnSrMJlCuDkZnjNMKt/Uvle+d9Vv3FQsOP5UZa0awnjl07G1pUztJ6aO6rHnNNon/02kOTgHR/22/NYrCjxuSuQxhkqbGbXzvJ2VWo8TlRqL2ax5Ucz6aebsuNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=myViYUgn; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-371afae614aso540509f8f.0
        for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 10:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724346510; x=1724951310; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OaMLX3KGLSIhIKH903StZeHGwtlsz0A3rOzQcoAh6Eg=;
        b=myViYUgn0poVhTzJ8/XnfKgH+1dwe0/5lQVmSS4yFqEocUsU4ypqa1R5YxRW159F64
         sS+kV32ELlYmgtoH2m4gffQwZQxhKtwzDitInjIqdfGPC9PBlDtWlqy6CoxSRSIRLyqK
         Xfh7vIAj8VKWCxD7fV+IHxiUOejMfgbv7GUxQM7ynMt+/5uquPoZYlOvWh7kkHpszWpA
         liXD/1QY4ba0Y4Vtwxgy8kDTw7AQRNGhU/VQiQCl21fsweKDps260o2g3MMAQR4+0FeV
         PRwm/8NXwhUoLQDrpI2ErHZ6tYf3rSqF46Xbs3Am/KYA33KwQEegvW2fUc4Duw3FclxG
         tsTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724346510; x=1724951310;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OaMLX3KGLSIhIKH903StZeHGwtlsz0A3rOzQcoAh6Eg=;
        b=QwBGCROU4cHEZBzwQcTSmPzU80UPraFpH6t1Bw1fhes+vZzoehELi3GVlRB28uezre
         gttnOy0c/h6nKW1ge/DnwYiG4jIxFUu3y7IWhLhmI4thbs9Hm7EKq6nSjgznpQx4Kozy
         qcC+y8SiN0kQTaU9rQdIX5YBEdYL6ATSSyaiAHQhy3oPsynACHCPnNcQ8vauaDnRf7EW
         ZLZbJNmkcD7xIUdDqzCebFwezMUGjASj792+SBKDfRhn3/wSddDRo5Dla1phHOtmff8y
         Q+zEjXhOOlvCzyZDWuSyLKm2seeaPiwnwGn58pxOhwYUGAQaP+6DN/p7wBGKV/aZ9D9Y
         OdzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRBTbVaOmspkCgfbZOPGGOUDOXBZ9+AHhLoLf5ZsfD99u8TQnvSUDqDNsVE1g8WC94XvskkMiAxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqLk+yTU+mvXMEWg+orDdCulY2GBi1t9R6xJNoL9hJHV7XXBDv
	2KDZ5PdsI5XrXf0kWeO3EXgcBiSmqvSPiXKadUGdebH+fYr2aQ13902D8nqiRiQ=
X-Google-Smtp-Source: AGHT+IEywulZ9TTBGo5NUKsLeBRvC2vZNOSHr2dwuUBcESFGepeg0+rnK/P4GMmUlU8VOSpmGgr54A==
X-Received: by 2002:adf:e642:0:b0:363:7bbf:efcc with SMTP id ffacd0b85a97d-3730906b0admr1573136f8f.62.1724346510057;
        Thu, 22 Aug 2024 10:08:30 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42abefcb674sm65834495e9.32.2024.08.22.10.08.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 10:08:29 -0700 (PDT)
Message-ID: <8b832b56-faf3-43d5-88b2-c91b0a0bbaae@linaro.org>
Date: Thu, 22 Aug 2024 19:08:29 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] Add thermal thresholds support
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
 "rafael@kernel.org" <rafael@kernel.org>
Cc: "lukasz.luba@arm.com" <lukasz.luba@arm.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "quic_manafm@quicinc.com" <quic_manafm@quicinc.com>
References: <20240816081241.1925221-1-daniel.lezcano@linaro.org>
 <1942ed0b96419621583d4a0928883aafd8c2f7f2.camel@intel.com>
 <CAJZ5v0gW-iaL34Mz2M0gzh-ooDbw=Rp=M_-dt1Ctqhxm3wUGQw@mail.gmail.com>
 <0494c22b09f9143d2a22e1f0ae2ae79b7d61ab63.camel@intel.com>
 <CAJZ5v0hbPRGyNYv0LjSjqFiH6uixDtsO-2Dbq8Qi_9fWhSwz4A@mail.gmail.com>
 <dec10692d8bf72b425509d2ea002eebbd7238ccd.camel@intel.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <dec10692d8bf72b425509d2ea002eebbd7238ccd.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/08/2024 14:11, Pandruvada, Srinivas wrote:
> On Thu, 2024-08-22 at 11:41 +0200, Rafael J. Wysocki wrote:
>> On Thu, Aug 22, 2024 at 12:16 AM Pandruvada, Srinivas
>> <srinivas.pandruvada@intel.com> wrote:

[ ... ]

>> So did you apply the Daniel's patches and run the test or did you do
>> something else?
> We already use netlink to send notification to user space via writable
> trip. So didn't apply any patches. I don't see these patches will do
> any different.

Actually you are missing the point of the thresholds approach.

The goal is to track the temperature easily from userspace without 
constantly polling the temperatures in all the places.

The trip points are a firmware descriptions. Their number is fixed. They 
are designed for in-kernel thermal framework. They have a type. A 
governor is supposed to be tied with it. A cooling device also.

Writable trip points means you should be able to add trip points 
dedicated to the userspace to the firmware which is not possible. Then 
reuse them from userspace which is unrelated to the in-kernel thermal 
management. It is difficult to deal with because of the need of tracking 
the low and high limits from userspace.

The thresholds are there to allow the userspace to have the benefit of 
the interrupt driven temperature monitoring.

Obviously if you set the thresholds to a temperature equal to a 
mitigation trip point then when the limit is reached you will receive 
notifications for the trip point going back and forth as well as 
notifications for the thresholds.





-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

