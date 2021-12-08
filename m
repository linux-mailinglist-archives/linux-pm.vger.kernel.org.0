Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD90846CDE4
	for <lists+linux-pm@lfdr.de>; Wed,  8 Dec 2021 07:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239337AbhLHGuE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Dec 2021 01:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234104AbhLHGuC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Dec 2021 01:50:02 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4232DC061746
        for <linux-pm@vger.kernel.org>; Tue,  7 Dec 2021 22:46:30 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id c32so3621065lfv.4
        for <linux-pm@vger.kernel.org>; Tue, 07 Dec 2021 22:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=UaAasmnyvAH3PLHl3CbNfGf6pXvvQWsOQSQHXcQ3Tkw=;
        b=q7iIhd/Yr6c+dxBElsS1uyQ4PX/LkH4gafi3qXCd6acLoWkUX4a1oHTOF46craXqwO
         DmoYywOLYfuw1oXxE+fRVrxqNL38U4mRekiltFdq1nA05rXAnq1hYXo5ndqIAahi94KX
         vbh3yn0BbOjhm3elMAbFdOqib3c8LCnMp9nFOKB4um862XbZvW4MvcIVEQu+LT1G6hfS
         N8wcLMHh9pnVoU3H18RRMeD4WjJNLWDTAt88omUikdvlpR1DYrrtvp3VYIsTQ//0TXg0
         i/h4Ew0g6vqCXzgtg5wVXzFXxAxczi83VlcqYbM5BZskQJEtxz0QQczmZw99U7y5wv9K
         E87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=UaAasmnyvAH3PLHl3CbNfGf6pXvvQWsOQSQHXcQ3Tkw=;
        b=sVU4q/ySTireOdfslYFsG2jPrPaxw0iAYos+PmwM5xa18yl0ADsBlvhkM2OIaW5Lx5
         D+951F1Mwimf35pddaOorlG6g/Gbe2DJ+gcGiTSwC8o9Ou3aahsD6TIsKjZ+GM1wWnHq
         sEgGKCkdlmUU+94kw8rPS200EGH3PWdko2Tvt2fkR+lDglRMwUlFzD4l3qMNF3LmBsvB
         cE4UadVwn7Ee1JGjDgCKbEh2F/B8h53l5qn4Tw1lBbgGt9obozv5L6HKx0orr6TQZdGk
         ba824CmOHSroQfgrqJYTjpQo7siB8+d+tpZbThhWUds2bPIJmRhmFfruGL/JI8dVGf+8
         xHiA==
X-Gm-Message-State: AOAM530tMwlYyDXMUiixDf2ATyOhTK4epVd1MtHdLdeTnvQWyxPXKU0o
        /TdKNKUgr6GPdeOJQWBeSGz0PDTqqZk=
X-Google-Smtp-Source: ABdhPJxguSJem87vpgfzw50BLGqEKcuJQQpcFXB4XhuqcyJH++guIAUOG3J90HhqcXjQutuRgBlHQA==
X-Received: by 2002:a05:6512:2350:: with SMTP id p16mr47230810lfu.482.1638945988419;
        Tue, 07 Dec 2021 22:46:28 -0800 (PST)
Received: from ?IPV6:2001:14ba:16ee:fa00::4? (dc73szyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16ee:fa00::4])
        by smtp.gmail.com with ESMTPSA id f5sm161107lfh.188.2021.12.07.22.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 22:46:27 -0800 (PST)
Message-ID: <7228bbd0-4428-18d2-8cef-df9a9c789d41@gmail.com>
Date:   Wed, 8 Dec 2021 08:46:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org
References: <20211206000651.4168035-1-linus.walleij@linaro.org>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2] power: supply_core: Pass pointer to battery info
In-Reply-To: <20211206000651.4168035-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Good Morning Linus,

Hmm.. LKML skipped on purpose(?)

On 12/6/21 02:06, Linus Walleij wrote:
> The function to retrieve battery info (from the device tree) assumes
> we have a static info struct that gets populated by calling into
> power_supply_get_battery_info().

I kind of see the value of having the static info structure. It is damn 
easy to use and works well for small items. IMNAAHAWBA-O (In My Not 
Always As Humble As Would Be Appropriate - Opinion) the mistake has been 
adding the large, fixed size arrays in the same struct.

> This is awkward since I want to support tables of static battery
> info by just assigning a pointer to all info based on e.g. a
> compatible value in the device tree.

Do you have a case where you have battery data in multiple DT nodes? 
Some kind of multi-battery use-case? I'd like to understand how you plan 
to do mapping to compatibles - AFAIR, at the moment the compatible must 
be "simple-battery". Do you plan to have multiple compatibles in the DT, 
one of them matching the "simple-battery", rest being used as a key? Or 
do you plan to use the charger compatible (charger which references the 
battery with the monitored-battery as a key? My initial feeling is that 
it kind of makes sense).

I was wondering how it would work out if the battery info was splitted 
to smaller (optional) pieces instead of being just one big struct? It 
kind of makes no sense to always reserve space for all of the 
calibration data arrays when some of them are likely to be missing...(?)

something like:

struct static_batinfo static_info;
struct dynamic_batinfo *dynamic_info;

power_supply_get_battery_info(bd->charger, &static_info, &dynamic_info)

dynamic_info can be NULL if it is not expected.
dynamic_info will be NULL'ed by call if it is not populated
dynamic_info will be allocated if it is not NULL when called and if 
dynamic data is found from the firmware.
The dynamic data must be freed by (keep put batttery info API or just 
allow user to kfree?)

Or is this just adding a lot of extra complexity in order to save few 
bytes? I am not pushing this - it's up to you guys. I am "just a random 
guy from the streets" as someone once put it ;) For me it is just 
troubling to always have all the arrays in battery data - and I still do 
like the ability to avoid dynamic allocation when we don't have much of 
the info in the DT.

> 
> We also have a mixture of static and dynamically allocated
> variables here.
> 
> Bite the bullet and let power_supply_get_battery_info() allocate
> also the memory used for the very top level
> struct power_supply_battery_info container. Pass pointers
> around and lifecycle this with the psy device just like the
> stuff we allocate inside it.
> 
> Change all current users over.
> 
> In the bd99954 charger driver we need to stop issuing
> power_supply_put_battery_info() at the end of the probe since
> the struct continues to be used after probe().

Hm. Are you sure?
The patch didn't apply on v5.16-rc4 so I may have missed something as I 
was just reading the diff. AFAIR, the original idea was that the batery 
info lifetime is only the fw_probe - where the value from battery info 
was used to get the initialization register values which are then stored 
to init data. The init data was allocated at probe.

	/* Allocated at probe */
	struct bd9995x_init_data *init = &bd->init_data;
	struct battery_init battery_inits[] = {
	{
		.name = "trickle-charging current",
		.info_data = &info.tricklecharge_current_ua,
		.range = &charging_current_ranges[0],
		.ranges = 2,

		/* Pointer to allocated init data */
		.data = &init->itrich_set,
	}, {
		...


	ret = power_supply_get_battery_info(bd->charger, &info);
	...

	/* Use info to get correct register value */
	...
	
	/* Store info to allocated init data */
	*(battery_inits[i].data) = regval;

Maybe I am missing something?


Best Regards
	-- Matti

