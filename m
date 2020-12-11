Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835342D78F1
	for <lists+linux-pm@lfdr.de>; Fri, 11 Dec 2020 16:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437738AbgLKPQZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Dec 2020 10:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437750AbgLKPPw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Dec 2020 10:15:52 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F65C0613D3
        for <linux-pm@vger.kernel.org>; Fri, 11 Dec 2020 07:15:11 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id 3so8906989wmg.4
        for <linux-pm@vger.kernel.org>; Fri, 11 Dec 2020 07:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OECze9Jt9lBpL1kXAkGtCIUVYABJ/DIpOTJhLsdDY8Q=;
        b=mrA6CS98fHBqM2F7o5CkOmxR/FQ+0Frv9IROTP+aTdgdOKW3sZ8kkUy7plP/W4wORj
         +rHz6KGlUU7OfBbY/0S5Vyy/7AfBSCRvracsKrdX8KjTZdZX/57FMlggiM7qpV/EuO43
         3g3nIUZNVcIt7GzQ0QUv0jK4OQXkdMLVN8e9BHwk+ZtOMuj42NXigfKlpyEIqHuDDwEn
         IcRz09qkmh3lrrOGdwLaHNXGsysOHnxU1ygfA23Yg+yP3+lulT2yyrVaNXF9BPLAynHt
         UiIx7iAWky2G2z9RYC3/TANyW7JT9pwR+VQofv/CwvcPwy8cw/tfUC5QpPufsmZouZqr
         TVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OECze9Jt9lBpL1kXAkGtCIUVYABJ/DIpOTJhLsdDY8Q=;
        b=l+Hh52u9e3DAAXlFfoL4yOxs22LHUeGr8ehohL/Knqmf+Jee/uf4p5FWFn7pl78oJa
         6AjXRGBKmFD0vVawtDZ7L+qoL1Vbhhx9EC16GWKsArthOuZbEuPte949+bW0EQEDtzB1
         oeCFW4AKfGCjfvKUis+LH8jwQnhGa/eSqbkq9Dw2y6zMNMlpGp74s9Y0EuVBbphpqyXz
         V9XnyLweqfVDGxJbETsDzyxyvH7hUvC5t9XYTeId5UTvWnL+M/8vcSHYxqYuolPaeEjP
         gZ7Acsj6sgj5akKn7SKYqsQqX4L8s/FtIzMvLf3vpzIQh878JOwZelE08FyRL/7nUtuH
         QU/w==
X-Gm-Message-State: AOAM532CG1Ih2kdhZiJBnF3IZflEEdkXo52dlhTf4ea1wiC+nGhGX+pM
        RH3tSHIUU9APdnqoqBtUK6pM2A==
X-Google-Smtp-Source: ABdhPJwSw9KfkzNQCIW2g9OwTZ6Gio2UXdfnhkPfemMqHExICDIocG5KQHD4pDxGZcYwrfywZBxGMg==
X-Received: by 2002:a1c:f00a:: with SMTP id a10mr14076638wmb.83.1607699710411;
        Fri, 11 Dec 2020 07:15:10 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:fc92:290c:960a:52ef? ([2a01:e34:ed2f:f020:fc92:290c:960a:52ef])
        by smtp.googlemail.com with ESMTPSA id b9sm15302235wmd.32.2020.12.11.07.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Dec 2020 07:15:09 -0800 (PST)
Subject: Re: [PATCH v4 0/5] Thermal devfreq cooling improvements with Energy
 Model
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, orjan.eide@arm.com, robh@kernel.org,
        alyssa.rosenzweig@collabora.com, steven.price@arm.com,
        airlied@linux.ie, daniel@ffwll.ch, ionela.voinescu@arm.com
References: <20201210143014.24685-1-lukasz.luba@arm.com>
 <04bdcc7a-c264-ffd2-89a2-5606e59ff786@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <7545df9d-9cbc-d35c-6d32-39c4f96cc216@linaro.org>
Date:   Fri, 11 Dec 2020 16:15:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <04bdcc7a-c264-ffd2-89a2-5606e59ff786@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/12/2020 16:11, Lukasz Luba wrote:
> Hi Daniel,
> 
> Do you think it has chance to go to as material for v5.11?

Yes, it is in the thermal/linux-next material ATM.


> On 12/10/20 2:30 PM, Lukasz Luba wrote:
>> Hi all,
>>
>> This patch set is a continuation of my previous work, which aimed
>> to add Energy Model to all devices [1]. This series is a follow up
>> for the patches which got merged to v5.9-rc1. It aims to change
>> the thermal devfreq cooling and use the Energy Model instead of
>> private power table and structures. The power model is now simplified,
>> static power and dynamic power are removed. The new registration
>> interface
>> in the patch 3/5 helps to register devfreq cooling and the EM in one
>> call.
>> There is also small improvement, patch 2/5 is changing the way how
>> thermal gets the device status (now uses a copy) and normalize the
>> values.
>> The last patch is here for consistency and will probably go through
>> drm tree.
>>
>> The patch set should apply on top of thermal/testing. It does not
>> depend on
>> new EM API change which is queued in the pm/linux-next tree as v5.11
>> material.
>> Thus, could go in parallel. That was the main motiviation for this v4.
>>
>> changes:
>> v4:
>> - patch 3/5 - removed dependency on the EM API change
>> -- removed em_dev_register_perf_domain() and just use
>>     dev_pm_opp_of_register_em() which API has not changed
>> -- removed a helper registration function and renamed
>>     devfreq_cooling_em_register_power() to devfreq_cooling_em_register()
>>     (was actually suggested by Ionela during review)
>> -- moved energy_model.h to include in devfreq_cooling.c not .h, since
>>     there is no EM structure in there anymore
>> - adjusted comments and commit messages
>> v3 [4]:
>> - dropped direct check of device status and used just a copy of 'status';
>>    a separate patch set will be proposed to address this issue
>> - modified _normalize_load() and used 1024 scale to handle ms, us, ns
>> - removed 'em_registered' and called em_dev_unregister_perf_domain()
>>    unconditionally, so the drivers will have to make sure the right
>> order of
>>    all unregister calls to frameworks which might use EM; this call
>> must be last
>>    one; a proper comment added
>> - removed 'em' pointer from struct devfreq_cooling_device,
>> 'dev->em_pd' is used
>> - removed of_node_get/put(), since the code can handle it
>> - removed dfc_em_get_requested_power() (as missed to do it in v2)
>> - collected all Reviewed-by tags
>> v2 [3]:
>> - renamed freq_get_state() and related to perf_idx pattern as
>>    suggested by Ionela
>> v1 [2]
>>
>> Regards,
>> Lukasz Luba
>>
>> Lukasz Luba (5):
>>    thermal: devfreq_cooling: change tracing function and arguments
>>    thermal: devfreq_cooling: use a copy of device status
>>    thermal: devfreq_cooling: add new registration functions with Energy
>>      Model
>>    thermal: devfreq_cooling: remove old power model and use EM
>>    drm/panfrost: Register devfreq cooling and attempt to add Energy Model
>>
>>   drivers/gpu/drm/panfrost/panfrost_devfreq.c |   2 +-
>>   drivers/thermal/devfreq_cooling.c           | 391 +++++++++-----------
>>   include/linux/devfreq_cooling.h             |  27 +-
>>   include/trace/events/thermal.h              |  19 +-
>>   4 files changed, 198 insertions(+), 241 deletions(-)
>>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
