Return-Path: <linux-pm+bounces-4236-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B9C85F64C
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 11:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F0ED1F2730F
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 10:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF47D405EB;
	Thu, 22 Feb 2024 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zqLWrpMc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320BF45943
	for <linux-pm@vger.kernel.org>; Thu, 22 Feb 2024 10:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708599524; cv=none; b=rKiWxhqylbUf+40gZap61MjZ4Nm4w4nAtl89uVWU0QnryDYcU7ydI3m5PaEIC/PHcdGk4UvIU6ApmrRT1x8pdNCv7CnC3W8lz2LjQlOastq+HTCFzN78WCIcNn6CbOztHEiqlEeBpRkAO6ZWiYrRlYnf7rjRRvBWvKUkr5i/nXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708599524; c=relaxed/simple;
	bh=MbaHf0aFoYZ+N6o8Nx8FO/BRhrHStIeFx08AcHel/Do=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j6z1lzR5+skNdhARhQ0rtLv0NEeYJoxAJrkIO9YXaz+3U3RjQz8CGDe4bn8/9ARbzc8FfsYQeubBpUPNXKhHO6ZFCEu/SsQ5OZ6H1u7/WPvfBSjoT1RREn+SQCalw8anf+yia1FVeSjC/BTccM3jiqt6dMsB1qQjX6jEBi16TbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zqLWrpMc; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d2533089f6so22267641fa.1
        for <linux-pm@vger.kernel.org>; Thu, 22 Feb 2024 02:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708599509; x=1709204309; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jnb5VAlV+t+Y6J33nYp+vDGASZ6SUQSeVwjB1F0eU9Y=;
        b=zqLWrpMc31DPV52P7E2MWBZx2wG4KfI3J015mydlxCdL43yn7hfpkKKWxV5Ff549cO
         Iap0yoUPQMELFnbK225/8FxVzrKWst0rsKUrvNFgQ3XsFIRI0fKGZflY7IOqerY5VUpX
         LWtkg0LOQzI7YsF0N7eRDSQjKpw8FxG8KT9fT64GbYyjtmTQkuOK+rkrvJ3MCY9GpCN2
         /sTgVtcYzer2EVvNOxw0RDmlM+W5sovIs6IddtOZzt+sElQM45PBVpCeUtCQfrGfXj3P
         OCUoRsg+MZcQvvOu7WhUWiUIZlDkPBWX/40XvmDszGiFnQ7UaT49ww+0phweOunvx2t9
         D2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708599509; x=1709204309;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jnb5VAlV+t+Y6J33nYp+vDGASZ6SUQSeVwjB1F0eU9Y=;
        b=d46uHcvCwLt1CH4/6gmr1OUZdD00svCCfC6LUI0TLOq2qIvBaON7jHbmmiBzKR5ZEH
         hFm9pMd8in3lrvrs1fkMBCJGlZzCwGxT1AE0zCdxA+Uk5hos4K2Cw5DgaXHIMMpT7JDo
         POLPU/KHjuVC6vYCF9GvOYDYrYy/Dq6I8NavpNqbGZksgSSzxM/2n+/PgNDmpKD4fMaF
         7fLt8SI7lfdrew0MlvjgLbGvGhSnGNcdHbl1OSwQNIGI98hGEhkgj/Mwd8/HXYos2KWu
         iGnWLmnS5JAnZ+tvPoYi55cTRTflku59lbQIgJPouLIREPsp8n4SECGbXsZKPjrDkWAn
         yWVw==
X-Forwarded-Encrypted: i=1; AJvYcCUzWrWUWJi6PuGquCjMsG0wCbgYIskJWR5aV3/hzvknbiLeCe/SgcunivpU5PMBth7igs7nfenQqOQyKptpRHYylHa3RnikNPs=
X-Gm-Message-State: AOJu0Yw25cwrOq3h8lyFc97l0+bpRnIz4HuiMNOXmpf4EZyUtbuJogrt
	uUTok9FPCbCWGCejXcHmxKfEuSLtlPbsNQC8XxHt1a2S1sGN0LMhq/SzAtH4xb8=
X-Google-Smtp-Source: AGHT+IGr8NDaBQu8UKrwVQ47LhttNlg1oJ/gu5tCjMflzuA048UVvteS2JzYGOYXFhZEhVqvA7rygw==
X-Received: by 2002:a2e:a98e:0:b0:2d2:6182:6ca7 with SMTP id x14-20020a2ea98e000000b002d261826ca7mr1203484ljq.39.1708599508674;
        Thu, 22 Feb 2024 02:58:28 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id co18-20020a0560000a1200b0033d4c3b0beesm14836608wrb.19.2024.02.22.02.58.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 02:58:28 -0800 (PST)
Message-ID: <ccf63280-bad1-4450-bf36-44cd1dcb69b2@linaro.org>
Date: Thu, 22 Feb 2024 11:58:27 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] thermal: core: Store zone ops in struct
 thermal_zone_device
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
References: <4551531.LvFx2qVVIh@kreacher> <2262393.iZASKD2KPV@kreacher>
 <ffa37950-d850-44e2-a33e-837466238d6d@linaro.org>
 <CAJZ5v0hqCbxChYmvADZJAFiuS1yPnRmj6ZZJfD032tnLB7ZZAA@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0hqCbxChYmvADZJAFiuS1yPnRmj6ZZJfD032tnLB7ZZAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/02/2024 11:52, Rafael J. Wysocki wrote:
> On Thu, Feb 22, 2024 at 11:47 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 14/02/2024 13:45, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> The current code requires thermal zone creators to pass pointers to
>>> writable ops structures to thermal_zone_device_register_with_trips()
>>> which needs to modify the target struct thermal_zone_device_ops object
>>> if the "critical" operation in it is NULL.
>>>
>>> Moreover, the callers of thermal_zone_device_register_with_trips() are
>>> required to hold on to the struct thermal_zone_device_ops object passed
>>> to it until the given thermal zone is unregistered.
>>>
>>> Both of these requirements are quite inconvenient, so modify struct
>>> thermal_zone_device to contain struct thermal_zone_device_ops as field and
>>> make thermal_zone_device_register_with_trips() copy the contents of the
>>> struct thermal_zone_device_ops passed to it via a pointer (which can be
>>> const now) to that field.
>>>
>>> Also adjust the code using thermal zone ops accordingly and modify
>>> thermal_of_zone_register() to use a local ops variable during
>>> thermal zone registration so ops do not need to be freed in
>>> thermal_of_zone_unregister() any more.
>>
>> [ ... ]
>>
>>>    static void thermal_of_zone_unregister(struct thermal_zone_device *tz)
>>>    {
>>>        struct thermal_trip *trips = tz->trips;
>>> -     struct thermal_zone_device_ops *ops = tz->ops;
>>>
>>>        thermal_zone_device_disable(tz);
>>>        thermal_zone_device_unregister(tz);
>>>        kfree(trips);
>>
>> Not related to the current patch but with patch 1/6. Freeing the trip
>> points here will lead to a double free given it is already freed from
>> thermal_zone_device_unregister() after the changes introduces in patch
>> 1, right ?
> 
> No, patch [1/6] doesn't free the caller-supplied ops, just copies them
> into the local instance.  Attempting to free a static ops would not be
> a good idea, for example.

I'm referring to the trip points not the ops.

The patch 1 does:

tz = kzalloc(struct_size(tz, trips, num_trips), GFP_KERNEL);

Then the last line of thermal_zone_device_unregister() does:

kfree(tz);

That includes the trip points in the flexible array.

Now in thermal_of_zone_unregister(), we do:

trips = tz->trips;
thermal_zone_device_unregister(tz);
kfree(trips);

Hence double kfree, right?



> BTW, thanks for all of the reviews, but this series is not applicable
> without the one at
> 
> https://lore.kernel.org/linux-pm/6017196.lOV4Wx5bFT@kreacher/



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


