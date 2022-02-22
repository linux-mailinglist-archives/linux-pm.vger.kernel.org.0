Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170224C0103
	for <lists+linux-pm@lfdr.de>; Tue, 22 Feb 2022 19:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbiBVSNI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Feb 2022 13:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234654AbiBVSNH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Feb 2022 13:13:07 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29DE53732
        for <linux-pm@vger.kernel.org>; Tue, 22 Feb 2022 10:12:39 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id s13so6462336wrb.6
        for <linux-pm@vger.kernel.org>; Tue, 22 Feb 2022 10:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CViuJUBfJYi0QSGuWN6PduP5lx8TFrmj/SDHviOF4gk=;
        b=RZa/ygJlSynG5jIAzj/b9lalbmSAGQftTk25TNuPvZfXd7AMTDlAaocg2Dioq8Lc+x
         aJ9Kayy7MchcekYcE57NEv+fjrctPQANNG5x4969Jvi3ZQfiKa+p6TxlWwIXlTSL/Pfk
         U8GE2Lo1xNdEG7wJNt15CCDoX0Q476qXS0zeaMjx/7kH3VwVeqrI2PwIckxAlNkdD4zG
         05dBbGfOjxSwjZ+Yf+CmQ5W/uF63jGvaFFHKq7P1d0QygsGgxWl9K5zngzUiAbTLsaGe
         XbP7/z1P6bTvzWeAZmtk0Fdk/uxslU9eTYYFtGQogschHdZzSu0sA+DqxR+pm5GMsSHA
         p+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CViuJUBfJYi0QSGuWN6PduP5lx8TFrmj/SDHviOF4gk=;
        b=vZC8QKV36q6kxc9Z3q2ETFuYx6mQTsQlAV/LSCPUEH2mFD1GjISOL4m3YS+xUSnYQy
         NfUyb5JC6FW4NIAHghDkXNSI59RCl2/4gIghuwP0UVr+DDY0OyntbV/2pDFyFWvUssj1
         Dwvp3QsFzm3KCkQE4uUu+juc9w6R2x2eNIb4aul3kcvu1Elbs+W7K4a1Fu8lOZFH3/mo
         /xtoo1+68PH/x60dr+WBG0IqmO4GgbgGD6fpsSdtOi5h+MEzaRVQ5uDmFMMTabeAItu+
         Qg5bXA25NflffSkAVQpA39jwmUp1p8d34agzFNIZ14qvBUwFd/SRn5avHpAfJD85kdo1
         rdlg==
X-Gm-Message-State: AOAM532bw4DTQh8NgA5Q2gLQNnSMJCQ0s2QAbc6o7r5yNoXMv7cZcy2c
        o3P2eX97bPfvxKUa1brXz1qpnQ==
X-Google-Smtp-Source: ABdhPJwneH1rvl3r4JbBWVekYHd+/txEjIgTX59EnUongOc//lBqjjlWeHh01jhjRbWD6wptabsvqg==
X-Received: by 2002:a5d:64e5:0:b0:1e7:6860:606c with SMTP id g5-20020a5d64e5000000b001e76860606cmr20815875wri.467.1645553558226;
        Tue, 22 Feb 2022 10:12:38 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:7f69:edd5:61dd:b18a? ([2a01:e34:ed2f:f020:7f69:edd5:61dd:b18a])
        by smtp.googlemail.com with ESMTPSA id g22sm2964522wmh.12.2022.02.22.10.12.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 10:12:37 -0800 (PST)
Message-ID: <3d1719ca-d4a4-f904-e284-b857414669ba@linaro.org>
Date:   Tue, 22 Feb 2022 19:12:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] thermal: cooling: Check Energy Model type in
 cpufreq_cooling and devfreq_cooling
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     amit.kachhap@gmail.com, viresh.kumar@linaro.org, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, dietmar.eggemann@arm.com,
        Pierre.Gondois@arm.com, Matthias Kaehlcke <mka@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220207073036.14901-1-lukasz.luba@arm.com>
 <20220207073036.14901-2-lukasz.luba@arm.com>
 <4e090ffe-c19b-8e2c-0396-72dc33361f35@arm.com>
 <211a3606-2f4c-227b-33aa-177ef68a49a3@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <211a3606-2f4c-227b-33aa-177ef68a49a3@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Lukasz,

I don't think it makes sense to remove the support of the energy model 
if the units are abstracts.

IIUC, regarding your previous answer, we don't really know what will do 
the SoC vendor with these numbers and likely they will provide 
consistent abstract values which won't prevent a correct behavior.

What would be the benefit of giving inconsistent abstract values which 
will be unusable except of giving a broken energy model?

Your proposed changes would be acceptable if the energy model has a 
broken flag IMO

On 22/02/2022 18:05, Lukasz Luba wrote:
> Hi Daniel,
> 
> gentle ping
> 
> On 2/17/22 18:18, Lukasz Luba wrote:
>> Hi Daniel,
>>
>>
>> On 2/7/22 7:30 AM, Lukasz Luba wrote:
>>> The Energy Model supports power values either in Watts or in some 
>>> abstract
>>> scale. When the 2nd option is in use, the thermal governor IPA should 
>>> not
>>> be allowed to operate, since the relation between cooling devices is not
>>> properly defined. Thus, it might be possible that big GPU has lower 
>>> power
>>> values in abstract scale than a Little CPU. To mitigate a misbehaviour
>>> of the thermal control algorithm, simply not register a cooling device
>>> capable of working with IPA.
>>>
>>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>>> ---
>>>   drivers/thermal/cpufreq_cooling.c |  2 +-
>>>   drivers/thermal/devfreq_cooling.c | 16 +++++++++++++---
>>>   2 files changed, 14 insertions(+), 4 deletions(-)
>>
>> The discussion in below this patch went slightly off-topic but it was
>> valuable. It clarified also there are no broken platforms with this
>> change.
>>
>> Could you take the patch into the thermal tree, please?
>>
>> Regards,
>> Lukasz


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
