Return-Path: <linux-pm+bounces-717-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 288E3805E00
	for <lists+linux-pm@lfdr.de>; Tue,  5 Dec 2023 19:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B7691C20A40
	for <lists+linux-pm@lfdr.de>; Tue,  5 Dec 2023 18:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB2460BA0;
	Tue,  5 Dec 2023 18:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fwBywtYH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293D51B1
	for <linux-pm@vger.kernel.org>; Tue,  5 Dec 2023 10:47:57 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40bd5eaa66eso42379845e9.3
        for <linux-pm@vger.kernel.org>; Tue, 05 Dec 2023 10:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701802075; x=1702406875; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U+lqwBZMK+wVpbDWjP0vhE+/JjYpGK4V388xl9U7d9A=;
        b=fwBywtYHW8DBEj635ZfuDErGYxS+MYe367T14owW8/ZE36kyvyzTxD0pcRfmS9BmAq
         m2wHHqhVvkMzXj6bUSZUzal0Y5aONCec5JhxJ20gu+C7PXmrJ7fYrLOaZp8UMxgbWb9f
         bC2o1GVRstF9bfrcCwavsRm7YvyYF7NWyGLEboNTksjT5YbVwzuPJrJQL9zKgsncEH8z
         9m/uAj6AXRzD2xglRteMtqitOUZTpq9c7RJbNKVH1z2v4OCs1arvUjrmP5mca2DZU8Zt
         v0ZMOrH3nI8mbFQqj0MQG2qzBmxrAk3cBRaZ7cNdiJStduMDX1Y39Zs6/Eh1Yzk4f0sG
         ukzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701802075; x=1702406875;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U+lqwBZMK+wVpbDWjP0vhE+/JjYpGK4V388xl9U7d9A=;
        b=GJpXr4OdiqZURwbqmslSbygxpga8m2ycVJ9jDX8pSV4utYyMq7pHA82sUAX6Z63CTt
         u4JLJ7JLR+4BrQUAh9YPyqXQBMsPwylHLm88vomqpYskT3mYA6+xd4c5OrYeVgTXH4Lv
         Xiu5TNeBgoS3Y0ByI/POknqjUNiMbF8kAiQ8tJQXe38lKAFEyx/sTFWFJP7nkwhpZcTj
         M6L+XAM2c5zWzqeablFAF3du0gsL4aEX+R1CJ/bG93nxhnEqKHrTxxSZQIt8SOda+JjH
         JST12q7FgIMjKqx3ebYoHIFp0VSNRdq2FDfc5SqLE4eTRvd4DN7vZ/MXkTmW5oq+ZkmA
         2EGQ==
X-Gm-Message-State: AOJu0YzgWYxx8dXqvMV98zZbjchKodT5aQJ5DzUx0Jcktn3TOvbcfmOz
	BObt2VSa7Gf2DhvjZ2LWAOi7aooe8IBiMJDiesI=
X-Google-Smtp-Source: AGHT+IFdkcF/6xYrN815EzdSDUEvs1R+De9+lAaI/y2qPSCw5Af7b2zOxzh1ghUeVmRTaf8scsG7lQ==
X-Received: by 2002:a05:600c:4706:b0:406:54e4:359c with SMTP id v6-20020a05600c470600b0040654e4359cmr853291wmo.19.1701802075403;
        Tue, 05 Dec 2023 10:47:55 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id w3-20020a5d6803000000b003333eadd206sm8944995wru.27.2023.12.05.10.47.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 10:47:55 -0800 (PST)
Message-ID: <3428b2af-5522-4090-995a-10eaee90c28e@linaro.org>
Date: Tue, 5 Dec 2023 19:47:54 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] thermal: Add support for device tree thermal zones
 consumers
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 rafael@kernel.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com, wenst@chromium.org
References: <20231115144857.424005-1-angelogioacchino.delregno@collabora.com>
 <09de3b1b-b725-46b8-97a6-55776fd5ca45@linaro.org>
 <99c1fd8f-4b17-4d4a-87a5-6a65745632fe@collabora.com>
 <ce110f25-5431-4c80-b037-add7fd7461bd@linaro.org>
 <03e950a1-0334-40ab-aa77-ac8175877172@collabora.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <03e950a1-0334-40ab-aa77-ac8175877172@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Angelo,

On 05/12/2023 14:48, AngeloGioacchino Del Regno wrote:
> Il 01/12/23 15:18, Daniel Lezcano ha scritto:

[ ... ]

>> Putting apart the fact the change you propose is not relevant as there 
>> is already everything in. My comment is about the current state of the 
>> thermal framework.
>>
> 
> I don't really understand this assertion, and I'm afraid that I'm 
> underestimating
> something so, in case, please help me to understand what am I missing here.

Sure. Let me clarify my understanding of you proposal and my assertion.

  - A driver needs a thermal zone device structure pointer in order to 
read its temperature. But as it is not the creator, it does not have 
this pointer.

  - As a solution, several drivers are using a specific DT bindings to 
map a thermal zone "name/type' with a string to refer from the driver a 
specific thermal zone node name. Then the function 
thermal_zone_device_get_by_name() is used to retrieve the pointer.

  - Your proposal is to provide that mechanism in the thermal_of code 
directly, so the code can be factored out for all these drivers.

Is my understanding correct?

My point is:

  - The driver are mapping a thermal zone with a name but a node name is 
supposed to be unique on DT (but that is implicit)

  - A phandle is enough to get the node name, no need to add a thermal 
zone name to get the node and then get the thermal zone. It is duplicate 
information as the DT uses the node name as a thermal zone name.

We could have:

         thermal-zones {
                 display {
                         polling-delay-passive = <0>;
                         polling-delay = <0>;
                         thermal-sensors = <&display_temp>;
                 };
         };

         papirus27@0{

		[ ... ]

---             pervasive,thermal-zone = "display";
+++             pervasive,thermal-zone = <&display>;
         };

The ux500 is directly calling thermal_zone_device_get_by_name() with the 
thermal zone node name.

> For how I see it, in the thermal framewoek I don't see any "somewhat 
> standardized"
> helper like the one(s) that I'm introducing with this patch 
> (thermal_of_get_zone(),
> thermal_of_get_zone_by_index()), and this is the exact reason why I'm 
> proposing
> this patch.
> 
> Then again - I mean no disrespect - it's just that I don't understand 
> (yet) why you
> are saying that "everything is already available", because I really 
> don't see it.

Ok said differently, thermal zone name and type are messy.

Let's clarify that and then let's see with the result if adding this 
thermal zone node/name mapping still makes sense.

>>   - A thermal zone does not have a name but a type
>>
>>   - We use the thermal zone DT node name to register as a name but it 
>> is a type from the thermal framework point of view
> 
> This is something that I didn't realize before. Thanks for that.
> 
> ...and yes, we're registering a "name" from DT as a "type" in the 
> framework, this
> is highly confusing and needs to be cleaned up.
> 
>>
>>   - We can register several thermal zones with the same type (so we 
>> can have duplicate names if we use type as name)
>>
> 
> ...which makes sense, after realizing that we're registering a TYPE and 
> not a NAME,
> and I agree about the logic for which that multiple zones can be of the 
> same type.
> 
>>   - We use thermal_zone_device_get_by_name() but actually it checks 
>> against the type and as we can have multiple identical types, the 
>> function returns the first one found
>>
> 
> The first thing that comes to mind is to rename 
> thermal_zone_device_get_by_name()
> to thermal_zone_device_get_by_type(), but then I'd be reintroducing the 
> former and
> this gives me concerns about OOT drivers using that and developers 
> getting highly
> confused (name->type, but name exists again, so they might erroneously 
> just fix the
> call to xxx_by_name() instead of changing it to xxx_by_type()).


> Should I *not* be concerned about that?

Not really :)

TBH, OOT drivers do not exist from upstream POV.

 > Any suggestion?

Yes, let's introduce a thermal zone name in the tzd.

  - There are now too many parameters to the function 
thermal_zone_device_register*(), so we can't add a new 'name' parameter. 
Introduce a thermal_zone_device_parameters structure. This structure 
will contain all thermal_zone_device_register_* parameter function. 
There won't be any functional changes, just how the parameters are 
passed. Perhaps, you should use an intermediate function to not have the 
change impacting everywhere.

  - then add a const char *name field in this structure and in the 
thermal_zone_device structure. So we can assign the name to the thermal 
zone. The name must be checked against duplicate. If no name is 
specified when creating a thermal zone, then name = type.

  - In thermal_of, use the node name for the type and the name, that 
will be duplicate but we will sort it out later.

  - Add the name in sysfs

Second step, track down users of thermal_zone_device_get_by_name() and 
check if they can use the name instead of the type. I'm pretty sure it 
is the case for most of the callers.

With that, there will be a nice clarification IMHO.

Then we will be able to restate the 'type' with something different 
without breaking the existing ABI.

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


