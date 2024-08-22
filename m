Return-Path: <linux-pm+bounces-12757-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BCE95BC7C
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 18:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AC45285A83
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 16:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808321CDFDB;
	Thu, 22 Aug 2024 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E0zDLofd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CE01CDFA7
	for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 16:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724345517; cv=none; b=shCchxJNsCxYUl/dZrNx1uRQjr4hJGAuUNz0dWbLsgIjMGE0kaNhHgCEb4X/2bGkMgWTOATSg4hYFIwQpZ5f8neHRmMh0BKHC5wmWRWMAWjoMsafY0em5ReyNC6/eXzGmm3W3DR1mynZsnQpK/faxcR3ZelfZrL+/vPUTNGMTwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724345517; c=relaxed/simple;
	bh=oLIJM3dkx4gpkmxONFhmWnfzNx8afusGPQ/5tTMEa4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tiU1ADh0oQjBhksEWMhtq/EGh2EKUkN9KzXyxVDAP/nPaRhXRS+gRToGl0VeiCdMsLGRRqNEqhqZueJAnb/ZduISQ62eD4OGRhhC1lbQdVzQPZRWBPGOrDNX/lrLbOZLv1XJBng2K9Uxjbb0tWLs2gTZoxUmGAXWCR20rFtJbeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E0zDLofd; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-429da8b5feaso10450765e9.2
        for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 09:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724345514; x=1724950314; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ermzs72qj4kk2+oXK4Hi/XTE7j8kCrSXMz0pySRJJrk=;
        b=E0zDLofdtLTk5mqvl6BVkI7Zovx0CXmBnhaotlsXYKYwnicOMVppmq6gDk6yBr6ABo
         dy+82cm2Tsf1g48J9Tsa+MGQ59jRQAbTWgtFJ/oV+vHybjwkivrU7FHIjloS1Z9RuqGg
         xQX6rDJTESJxLFzCRsX1gw4niQguKP1w40EMLLgxc+RBeOfQLkX8FqRCC20AYv7hDlMq
         hATHXPyI9W9JHHAXKEoOD45o4GqBlBQ8qGB8NZIBQrdidNcp5O5+TPmfC57QKKVBPnJx
         qUoLpgMTYiT+7TftrjulDv9N4y3atr0Dkym3NO9bK7hxMf6w1oSEV2IW5bzJaNaiSQH1
         y7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724345514; x=1724950314;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ermzs72qj4kk2+oXK4Hi/XTE7j8kCrSXMz0pySRJJrk=;
        b=PSVM6VXjSl54/LSnbM0i7vEalLgR+K7cPYhHoIdtUYLwculn1QaW3eYBEdaSaVlV81
         0i/fL2FOJzwP0Xw43tiaTAxagvshzxGGFZvLnmhMQfNVuPLehlwPwb49LJBtQsAHfs0S
         adc4Y/xwWmSaFtxAN/r4WfjhvZ66PXHhBSesHz2AATLmLromtZ2VNsBQ4w4i+dgwyDYV
         1Jzzh+CyYXg1Lr2QYO37cQPiukwa7BXdP90yyRTlpXz8ESMdx1opJkzJ+46MvFtALDPj
         R55yXHR9h4lXGxf640vnhuE608F2w3R7QfdWFpUuOE8DgB25Hx4AO1fqYe9zD2JggFrv
         2Qvg==
X-Forwarded-Encrypted: i=1; AJvYcCVHGLa1d/ez2XKXWBhjVmidO2sneUFKe0q6UPdvC7GP+ck6AGY0RP7Tf8GvlcVe6ysjwo63ndgjoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ/YdXNkzlPBfETM0WpochQ1eBYx+cO222eKTXUssrN7GSpZ5t
	Vaou/nry08JymysLw4CmndnrNvGJ5DDjyiZHIlnK5R9iFfoIhKYZlGv5ZDhuXEnRozs40JIuCJZ
	L
X-Google-Smtp-Source: AGHT+IFUZiLshIHoEsi6ElAiik6O68dOBZCba2HOBvCMYqRPRDmtQLT744En68Ce2PbI8sgznYK0cA==
X-Received: by 2002:adf:b306:0:b0:368:7f53:6b57 with SMTP id ffacd0b85a97d-37308c18ce6mr1848953f8f.18.1724345513385;
        Thu, 22 Aug 2024 09:51:53 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-373081ffb4dsm2094193f8f.74.2024.08.22.09.51.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 09:51:52 -0700 (PDT)
Message-ID: <81b47ef0-cc1e-4ec2-aa15-bada0f9bc522@linaro.org>
Date: Thu, 22 Aug 2024 18:51:52 +0200
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
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1942ed0b96419621583d4a0928883aafd8c2f7f2.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Srinivas,

On 21/08/2024 22:04, Pandruvada, Srinivas wrote:
> Hi Daniel,
> 
> On Fri, 2024-08-16 at 10:12 +0200, Daniel Lezcano wrote:
>> The trip points are a firmware description of the temperature limits
>> of a specific thermal zone where we associate an action which is done
>> by the kernel. The time resolution is low.
>>
>> The userspace has to deal with a more complex thermal management
>> based
>> on heuristics from different information coming from different
>> places. The logic is much more complex but based on a bigger time
>> resolution, usually one second based.
>>
>> The purpose of the userspace is to monitor the temperatures from
>> different places and take actions. However, it can not be constantly
>> reading the temperature to detect when a temperature threshold has
>> been reached. This is especially bad for mobile or embedded system as
>> that will lead to an unacceptable number of wakeup to check the
>> temperature with nothing to do.
>>
>> On the other side, the sensors are now most of the time interrupt
>> driven. That means the thermal framework will use the temperature
>> trip
>> points to program the sensor to trigger an interrupt when a
>> temperature limit is crossed.
>>
>> Unfortunately, the userspace can not benefit this feature and current
>> solutions found here and there, iow out-of-tree, are to add fake trip
>> points in the firmware and enable the writable trip points.
>>
>> This is bad for different reasons, the trip points are for in-kernel
>> actions, the semantic of their types is used by the thermal framework
>> and by adding trip points in the device tree is a way to overcome the
>> current limitation but tampering with how the thermal framework is
>> supposed to work. The writable trip points is a way to adjust a
>> temperature limit given a specific platform if the firmware is not
>> accurate enough and TBH it is more a debug feature from my POV.
>>
>> The thresholds mechanism is a way to have the userspace to tell
>> thermal framework to send a notification when a temperature limit is
>> crossed. There is no id, no hysteresis, just the temperature and the
>> direction of the limit crossing. That means we can be notified when a
>> threshold is crossed the way up only, or the way down only or both
>> ways. That allows to create hysteresis values if it is needed.
>>
>> A threshold can be added, deleted or flushed. The latter means all
>> thresholds belonging to a thermal zone will be deleted.
>>      
> 
> So you are proposing to add threshold via netlink, not adding any new
> sysfs attribute? That is not clear here.
> 
> I think you are adding"
> THERMAL_GENL_CMD_THRESHOLD_GET
> THERMAL_GENL_CMD_THRESHOLD_ADD
> THERMAL_GENL_CMD_THRESHOLD_DELETE
> THERMAL_GENL_CMD_THRESHOLD_FLUSH
> 
> We need to document our netlink messages including old ones.

We can do that but I would prefer to do that in a separate series.

> Also we should add "MODIFY" as we tend to change them quite often.

We can not change a threshold, only delete or add it.

> Also no hysteresis, that is practically we can't use. Temperature
> changes so much that that will flood user space. 

A threshold with a direction allows to create an hysteresis. Instead of 
one threshold, you will have two with different directions and temperature.

> You will get 100s of
> events on CPU temperature if you set temperature threshold in CPU.
> We have a whole filtering in driver to avoid this.
> You need a rate limit here.

I disagree, the user space is not supposed to monitor at a high rate a 
particular thermal zone. If the CPU is sending 100s notifications per 
second that means the threshold is set close to the mitigation trip 
point temperature which is a bad user space configuration.

> There are multiple user processes can add threshold and there is no
> ownership. So one process can cause too much noise to others as it is
> multicast.

ownership is something we may want to handle later.

What about restricting the thermal netlink to the 'root' user only ATM?

> We worked on a change to filer these as discussed during last LPC, but
> not posted yet. This will really need this as this will be too many
> messages.

With a correct configuration, that would not happen because it is 
different from receiving events from the trip points.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

