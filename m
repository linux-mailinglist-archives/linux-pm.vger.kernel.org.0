Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6712441154D
	for <lists+linux-pm@lfdr.de>; Mon, 20 Sep 2021 15:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbhITNLz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Sep 2021 09:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238713AbhITNLy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Sep 2021 09:11:54 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06864C061760
        for <linux-pm@vger.kernel.org>; Mon, 20 Sep 2021 06:10:26 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t18so29610904wrb.0
        for <linux-pm@vger.kernel.org>; Mon, 20 Sep 2021 06:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=N6K8ConCBxplODVGreBkUy4Oa7+JBEry738dFoxNBUQ=;
        b=N00YFoVU4+Vq0hKIRzFy48WMm/j4o9Aybke1uNu+tT51OUYjizcIDCxr9bIvObJIb9
         QAN33timr+kMiH737C9t2T6cD2DPTAhDZJWVV3sS27kZr2MouwFbTd6QtYYs+qjSxITn
         0kPsfWf+rchHZGOH3z+lWqnemAFte6Eg75H6wE3PF24ZOfJc0Ssalh8JEg5TFfgpcfTA
         YACIgoU5tRrD24q5Y25flWZel0v9qtpTg5kyCukiXJlo3ZLRs+TS+t69rPvDhB3wowVd
         O7krWLmvS2wyy7uwqc8GpMM3i4yv8pmjI2Us/qjx50VSgIJpPPfSMTNpJPySx1dE1LwQ
         AAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=N6K8ConCBxplODVGreBkUy4Oa7+JBEry738dFoxNBUQ=;
        b=H8o5cm6d9wHX2sF0V2Y/fcOGnNppQ8BrQ1GlvxGWRCs9jZMveZkZn9ZkGsh+D9h62y
         l4kWtDFFkIF8LVXtus/OTYlQOuwer8pFx11LhfvKqQ91hPQoI011U/97TBJVHpRxz6um
         tiSADPg50CDKsU0bmg2dVEjwhy3+/5FIMaHe9nHhgWuSz4zsO/uIqsf2bfhzJKfUmql+
         VJqREYKBfYxAZUTiZTejvam6E1jNj2dyrxPu9+nCXikutxyVE/7l2VWZl5rvvF8LhXAi
         AVCsiJDhrk1xb+wPdShRHXOtHNmCmfd0b4E/vGLyLCIYaweHwKkDH5KBNxgSzNTZFJW9
         VbnQ==
X-Gm-Message-State: AOAM532h0P9cOsd7nnQHfO9BdZ7BnkxS8IyiBAZOlQB1LyxtShuaBM6T
        sKG/eTr0quvVtsnex7HTavDy5w==
X-Google-Smtp-Source: ABdhPJyBCLWdiZm9YH/EuWmrJ2451uajr6mM2jDd/R8S638gaN3HBh4Y4z+PLCJi+PnGLPl+1+XMuw==
X-Received: by 2002:a05:600c:3548:: with SMTP id i8mr1796780wmq.106.1632143425503;
        Mon, 20 Sep 2021 06:10:25 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id k18sm15870527wrh.68.2021.09.20.06.10.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 06:10:24 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Add a generic virtual thermal sensor
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.tseng@mediatek.com, khilman@baylibre.com, mka@chromium.org
References: <20210917072732.611140-1-abailon@baylibre.com>
 <bd347d14-0b42-f9ed-bf15-080c929e1cb7@linaro.org>
 <7cddcdb7-4efd-bfdb-3d86-f5862ea0b7fe@baylibre.com>
 <8a9e5f13-6253-2d0d-35a8-789090af4521@linaro.org>
From:   Alexandre Bailon <abailon@baylibre.com>
Message-ID: <c395abad-598b-c06a-9252-c8e62c977188@baylibre.com>
Date:   Mon, 20 Sep 2021 15:12:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <8a9e5f13-6253-2d0d-35a8-789090af4521@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 9/17/21 4:03 PM, Daniel Lezcano wrote:
> On 17/09/2021 15:33, Alexandre Bailon wrote:
>> Hi Daniel,
>>
>> On 9/17/21 2:41 PM, Daniel Lezcano wrote:
>>> On 17/09/2021 09:27, Alexandre Bailon wrote:
>>>> This series add a virtual thermal sensor.
>>>> It could be used to get a temperature using some thermal sensors.
>>>> Currently, the supported operations are max, min and avg.
>>>> The virtual sensor could be easily extended to support others
>>>> operations.
>>>>
>>>> Note:
>>>> Currently, thermal drivers must explicitly register their sensors to
>>>> make them
>>>> available to the virtual sensor.
>>>> This doesn't seem a good solution to me and I think it would be
>>>> preferable to
>>>> update the framework to register the list of each available sensors.
>>> Why must the drivers do that ?
>> Because there are no central place where thermal sensor are registered.
>> The only other way I found was to update thermal_of.c,
>> to register the thermal sensors and make them available later to the
>> virtual thermal sensor.
>>
>> To work, the virtual thermal need to get the sensor_data the ops from
>> the thermal sensor.
>> And as far I know, this is only registered in thermal_of.c, in the
>> thermal zone data
>> but I can't access it directly from the virtual thermal sensor.
>>
>> How would you do it ?
> Via the phandles when registering the virtual sensor ?
As far I know, we can't get the ops or the sensor_data from the phandle 
of a thermal sensor.
The closest solution I found so far would be to aggregate the thermal 
zones instead of thermal sensors.
thermal_zone_device has the data needed and a thermal zone could be find 
easily using its name.

But, using a thermal_zone_device, I don't see how to handle module 
unloading.

Thanks,
Alexandre
> Or is the problem you are mentioning related to the sensor module
> loading after the virtual sensor ?
>
