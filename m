Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E2E4A9EBA
	for <lists+linux-pm@lfdr.de>; Fri,  4 Feb 2022 19:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377409AbiBDSNa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Feb 2022 13:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349855AbiBDSN3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Feb 2022 13:13:29 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD0BC06173D
        for <linux-pm@vger.kernel.org>; Fri,  4 Feb 2022 10:13:29 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id k6-20020a05600c1c8600b003524656034cso4274811wms.2
        for <linux-pm@vger.kernel.org>; Fri, 04 Feb 2022 10:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=H5RG1NlLigZ3a+HzA+NMogI8AZIGVKKErA7UKMgzcRc=;
        b=WuBmH1B8vZigPDrh6FITt8iihWdrzP00zvNomzwa6MRvFPHLuEZodEOD78KVOAw0rT
         EYv1tFbzACbbZW9qW8qYm/freu7N5wUjKRMExpeHwcl7kHMx5kv3swEQR6phajrvhZyI
         7Bp9UzxkHzx7Xr2NPLNBWTqdvcSGO3khBHdSFh+ZYW7jS0QEEbwD6KvRBe+5Ism9/rb5
         Nxuf605G4bsUt2tOodECpYVIZhUXLmOMvisSJ0+mmTcEgw5kfMCTEnWG77QD1qedN3Cs
         5hzuE3gIdvl95kl4ed1Y1lZLeUPYw41g7VYYUQmMnEsbLRhsxUJR8ArQ7Y4RywUZwlf/
         KrzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=H5RG1NlLigZ3a+HzA+NMogI8AZIGVKKErA7UKMgzcRc=;
        b=kYuQAwC5TrsBIv5ZPdel+VzE5jgGqYR+eClMLvMDg/6MrC+sgr85ExPeTT/8wUNtsp
         IlNlIBeTkPvnWpzMrWGxbRqLsN5xKXG7t6yhVcsF1um65VzXHSLhmhxX5zve5bzFXKBz
         6y7tDKw9KNOC9qt8EATta3bTuLufhNQwXB48Tm3q9hy9nQ/Spdx1wPtjzS2BCb9SeVzX
         EQghmocONg8hmOoNJOJC5Agpjj+FWzt0o60sM6yGMOD4RpqeLGN1IwKxGpp3GqJB4Sta
         kgexiMRp2RfiwNHb03fouOo4pzMDlnZ9lb5Yt7uS/c01LKrtLQuuaMsCJKDtPDSMEqCJ
         uAhQ==
X-Gm-Message-State: AOAM530kYlowdfb2Wn2QXM6fWxfondOHql2HgC9B78weZ94ru+7eMRrb
        q2ztHZXptg2r+XDkJBuk68B+6Q==
X-Google-Smtp-Source: ABdhPJw9ceKqgGwdJX9RKZ1cnO/MM07FkjqzMlRQyVWl1W/eQK85RCwh4OxkvC57gu98M/5MrrMnhA==
X-Received: by 2002:a1c:f413:: with SMTP id z19mr3262806wma.144.1643998408138;
        Fri, 04 Feb 2022 10:13:28 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:46b:d462:f12b:a36? ([2a01:e34:ed2f:f020:46b:d462:f12b:a36])
        by smtp.googlemail.com with ESMTPSA id e11sm2084339wmq.16.2022.02.04.10.13.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 10:13:27 -0800 (PST)
Message-ID: <2297b79e-b99c-30a5-1e5c-560d5553e146@linaro.org>
Date:   Fri, 4 Feb 2022 19:13:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] tools/lib/thermal: Add a thermal library
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Viktor Rosendahl <Viktor.Rosendahl@bmw.de>,
        Sasha Levin <sashal@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>
References: <20220204161518.163536-1-daniel.lezcano@linaro.org>
 <CAJZ5v0gXJ8wF2ChGU1bydPiNHB4c+SVrmrTpUwxMh7ddODFV5g@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0gXJ8wF2ChGU1bydPiNHB4c+SVrmrTpUwxMh7ddODFV5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04/02/2022 18:11, Rafael J. Wysocki wrote:
> CC Rui and Srinivas
> 
> On Fri, Feb 4, 2022 at 5:15 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> The thermal framework implements a netlink notification mechanism to
>> be used by the userspace to have a thermal configuration discovery,
>> trip point changes or violation, cooling device changes notifications,
>> etc...
>>
>> This library provides a level of abstraction for the thermal netlink
>> notification allowing the userspace to connect to the notification
>> mechanism more easily. The library is callback oriented.
>>
>> As it is the very first iteration, the API may be subject to
>> changes. For this reason, the documentation will be provided after
>> those are stabilized.
> 
> So shouldn't this be an RFC?

Yes, it could be.

> Also, I would prefer documentation to be provided or at least some
> intended usage examples to be given.

Sure, no problem.

I'll resend with the RFC and the examples

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
