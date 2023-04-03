Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9526D41FC
	for <lists+linux-pm@lfdr.de>; Mon,  3 Apr 2023 12:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjDCK1Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Apr 2023 06:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbjDCK1Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Apr 2023 06:27:24 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA48728F
        for <linux-pm@vger.kernel.org>; Mon,  3 Apr 2023 03:26:48 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l37so16778670wms.2
        for <linux-pm@vger.kernel.org>; Mon, 03 Apr 2023 03:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680517601;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uJqJCfXYsKrauWQ1VzvumsEN640d4PkwxnqFIZ8sjg4=;
        b=vYyXyZIon/EizW+NXgKhpk0havOfXPqISSQhL9lsTu9/m92Lodhn4bKB4Ot5wuUM3F
         WKj/muGRtrUUWlBVpOEuMwqWZL9T4xu648PG+TsTmD/KWTl/A6biSUS0W41DmrabNy3/
         sRu1NwKfcwgSsl414b/wXytQJzQEnlbvoXKC8w/D7K4LtQXYMuBuDG5xpoNySCDI7G3i
         qPDxRnUI7Pzn7j6zngUl3fhwQ9RPp8FfTtjnITZ2VZtkZgiQ9mx9plRkhgaSVcRWcOXA
         Fs6STndGzx7tkpKp7VK7cbDG8DshTEwIIo3TtDIT2QXbiGqfl0q/5+FehMLFtqvdQLyI
         8GHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680517601;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uJqJCfXYsKrauWQ1VzvumsEN640d4PkwxnqFIZ8sjg4=;
        b=CrkAjTf9Wx7EiHw4M51hvuTFOSWeLSkFw72jFTKT3aRlc20FgBWc8Puld/TtX4Bj5v
         b5cGSKQE8ba2viFOY7zGwZMNEn5aidLeO4kn7gXewbCPm9IXJBxYqTEs8E1tlCzwgTr2
         U6y/PZww1Uxe6ry6SyJPLX3BXM60CKki2yieP32OF4PEcK/XIQto8VrBqmOane/Qb8QH
         8p6Urir1AShzLhU9yd2ZSsG2vO3JKmCHo9uQieLEVCf8nNjQdjq0tlZAGbupuAtGOI7v
         Ztp8I/wkm29FewztSb5BpD0dY5aq0xpNWTFJPXa9674BOOKzUxMlrzZu8KuzxqbMq4ld
         4Hew==
X-Gm-Message-State: AAQBX9dQCFyingvIDwNFHg2xGO7vfKxEEbrM6+9fHZFtxN68vKljuZTK
        qp1LM64OnipZvumJI4Idy44klw==
X-Google-Smtp-Source: AKy350YKX9loEpC/aa7UcSmpn4QvLYOnjAUIpqPaJ3ERSh3FCOLOMkxwpPSHzNxBOFfj3nU8n2WH4Q==
X-Received: by 2002:a7b:c3ce:0:b0:3f0:3a9a:516e with SMTP id t14-20020a7bc3ce000000b003f03a9a516emr10482522wmj.15.1680517601510;
        Mon, 03 Apr 2023 03:26:41 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:8052:c9eb:6b69:e69a? ([2a05:6e02:1041:c10:8052:c9eb:6b69:e69a])
        by smtp.googlemail.com with ESMTPSA id u17-20020a7bcb11000000b003ef5db16176sm11758625wmj.32.2023.04.03.03.26.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 03:26:41 -0700 (PDT)
Message-ID: <2c37a786-0ae5-273e-f82b-4f9c82663053@linaro.org>
Date:   Mon, 3 Apr 2023 12:26:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] thermal: tegra-bpmp: Check if BPMP supports trip points
Content-Language: en-US
To:     Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Mikko Perttunen <cyndis@kapsi.fi>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20221129153914.2699041-1-cyndis@kapsi.fi>
 <Y9KTrO+WqJJwuEDf@orome> <a08355e1-c393-2b2e-4a44-360e08607bb9@linaro.org>
 <Y9KfcSwYt7utbcg5@orome> <e716eda4-edfc-5946-4e6f-42aab5f73b0f@linaro.org>
 <d7435a96-3480-280e-d996-73fea690c373@nvidia.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <d7435a96-3480-280e-d996-73fea690c373@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03/04/2023 12:22, Jon Hunter wrote:
> Hi Daniel,
> 
> On 26/01/2023 16:07, Daniel Lezcano wrote:
>> On 26/01/2023 16:42, Thierry Reding wrote:
>>> On Thu, Jan 26, 2023 at 04:08:03PM +0100, Daniel Lezcano wrote:
>>>>
>>>> Hi Thierry,
>>>>
>>>> On 26/01/2023 15:52, Thierry Reding wrote:
>>>>> On Tue, Nov 29, 2022 at 05:39:14PM +0200, Mikko Perttunen wrote:
>>>>>> From: Mikko Perttunen <mperttunen@nvidia.com>
>>>>>>
>>>>>> Check if BPMP supports thermal trip points, and if not,
>>>>>> do not expose the .set_trips callback to the thermal core
>>>>>> framework. This can happen in virtualized environments
>>>>>> where asynchronous communication with VM BPMP drivers is not
>>>>>> available.
>>>>>>
>>>>>> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
>>>>>> ---
>>>>>>    drivers/thermal/tegra/tegra-bpmp-thermal.c | 52 
>>>>>> +++++++++++++++++++++-
>>>>>>    1 file changed, 51 insertions(+), 1 deletion(-)
>>>>>
>>>>> Applied, thanks.
>>>>
>>>> I prefer you provide an Acked-by and I take the thermal related 
>>>> patches.
>>>> Especially in this period where we are reworking the framework with the
>>>> thermal trip points ;)
>>>
>>> Sorry, my bad. I misread this as belonging to drivers/firmware/tegra
>>> which goes in via ARM SoC.
>>
>> No worries ;)
>>
>>> I'll drop this from the Tegra tree. Feel free
>>> to pick this up:
>>
>> Ok, thanks
>>
>>> Acked-by: Thierry Reding <treding@nvidia.com>
> 
> 
> I don't see this one in -next. Are you able to pick this one up now?

Before going in -next, it will go through bleeding-edge then -next, 
logically tomorrow.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

