Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6645D2152D9
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jul 2020 09:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbgGFHEL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jul 2020 03:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728466AbgGFHEK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jul 2020 03:04:10 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C416C08C5DF
        for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2020 00:04:10 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s10so39536315wrw.12
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2020 00:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aZ5WH4krufOutEeuznkFTCLVe0wuUtYABIAu0GNgr3w=;
        b=ymCCcfDdm3+d0I8S9NxsZ7JBUoWD2LltdFQEtqtuDOrFkYXpDP6P/X3SX3OxWdi8rh
         DhAspiF/QAt2XGPIsHPqAUVUgh5MYDkz/4JPzXE10R74l9sh6+t2zjKNTrDTwwVbWrtZ
         0K06oXbzZv2VQ6dJoOsMCTwBccpnIIo7tGnVg+qxvBxn3vA480wOHNN8G53QeaTlOQX9
         KPLTiEGRS3OG+r4oAj5d8u6UGfOueNPgGL9ycgG02MUgPhVkXYrdQdGZOJjFOcOM9h3E
         1shn0xsfn03MfQ7Ls9iqFFs0pUzPvNVUloqND0WO5Vj5U/GYQfEPFNFu10dJydmS6a3a
         7epg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aZ5WH4krufOutEeuznkFTCLVe0wuUtYABIAu0GNgr3w=;
        b=PVvvPiyHezDcoCYJS7FNA8tLhJ/jedzxqh9xqdHBn2MZlMu8zBal4YGaNoFKrvf4h1
         yT/hqFgsjo+dQ08BCUxo23pLMrnKtcaLcavvzba5RWfAtxNxfR1Phzf8/cY+bkwJsmLj
         V9T2ScsryKjZNVL1H0JIqJhHaJTTu6AGfbVSq+OnHTmUJ4ldfDMzRJhKWBdysViX/IEr
         J2lnGdbVGuGLPRTfCc4urPq92tMatK+THkAn29gS08uDbEUmjxSukDrVd2SIwJM8BdJ/
         1bGzPekmtnuwcfvblKZqrqpPmTnDLvJfsGYsExxyOeVhSMvSIHiSwhZHfcx+OISXgpfH
         BM6Q==
X-Gm-Message-State: AOAM531Fy2H3j/IWIl/C7+EXauOnn5ms0t+t94IlQ3eZLU+p618q3Sa9
        sSOK9NuvyvgWE7LRDTQh0nJPg09DsfE=
X-Google-Smtp-Source: ABdhPJzOHwVlufGdMdyvbO13y8E84JvvMKilovl7Xl9+qhbP3+TmLg4NNYgk3MOQkwcWdbr70GZnTw==
X-Received: by 2002:adf:f60a:: with SMTP id t10mr39529356wrp.64.1594019048656;
        Mon, 06 Jul 2020 00:04:08 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:f9e8:8c05:eb6f:1865? ([2a01:e34:ed2f:f020:f9e8:8c05:eb6f:1865])
        by smtp.googlemail.com with ESMTPSA id g14sm19944402wrw.83.2020.07.06.00.04.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2020 00:04:08 -0700 (PDT)
Subject: Re: [PATCH v3 3/4] thermal: core: genetlink support for
 events/cmd/sampling
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     srinivas.pandruvada@linux.intel.com, rkumbako@codeaurora.org,
        amit.kucheria@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20200703085309.32166-1-daniel.lezcano@linaro.org>
 <20200703085309.32166-3-daniel.lezcano@linaro.org>
 <191a868fc02f6fca93250240cf6c3f7576c6a2c3.camel@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <7215d5ab-62a7-5b68-5443-584e1323e82c@linaro.org>
Date:   Mon, 6 Jul 2020 09:04:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <191a868fc02f6fca93250240cf6c3f7576c6a2c3.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05/07/2020 08:03, Zhang Rui wrote:
> On Fri, 2020-07-03 at 10:53 +0200, Daniel Lezcano wrote:
>> Initially the thermal framework had a very simple notification
>> mechanism to send generic netlink messages to the userspace.
>>
>> The notification function was never called from anywhere and the
>> corresponding dead code was removed. It was probably a first attempt
>> to introduce the netlink notification.
>>
>> At LPC2018, the presentation "Linux thermal: User kernel interface",
>> proposed to create the notifications to the userspace via a kfifo.
>>
>> The advantage of the kfifo is the performance. It is usually used
>> from
>> a 1:1 communication channel where a driver captures data and sends it
>> as fast as possible to a userspace process.
>>
>> The drawback is that only one process uses the notification channel
>> exclusively, thus no other process is allowed to use the channel to
>> get temperature or notifications.
>>
>> This patch defines a generic netlink API to discover the current
>> thermal setup and adds event notifications as well as temperature
>> sampling. As any genetlink protocol, it can evolve and the versioning
>> allows to keep the backward compatibility.
>>
>> In order to prevent the user from getting flooded with data on a
>> single channel, there are two multicast channels, one for the
>> temperature sampling when the thermal zone is updated and another one
>> for the events, so the user can get the events only without the
>> thermal zone temperature sampling.
>>
>> Also, a list of commands to discover the thermal setup is added and
>> can be extended when needed.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---

[ ... ]

>> +static int thermal_genl_event_cdev_update(struct param *p)
>> +{
>> +	if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_CDEV_ID,
>> +			p->cdev_id) ||
>> +	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_CDEV_CUR_STATE,
>> +			p->cdev_state) ||
>> +	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_CDEV_MAX_STATE,
>> +			p->cdev_max_state))
>> +		return -EMSGSIZE;
>> +
>> +	return 0;
>> +}
> 
>> +int thermal_notify_cdev_update(int cdev_id, int cdev_state)
>>> +{
>>> +	struct param p = { .cdev_id = cdev_id, .cdev_state = cdev_state
>>> };
>>
> 
> .cdev_max_state is not set here.
> I think we need to add a second parameter for cdev_max_state when
> invoking thermal_nofify_cdev_update().

I've been trying to figure when the max state is changed and the
notification for the max state is less straightforward than the current
state.

Actually merging both changes is not a good idea.

It would be preferable to add later the max state change notification
and keep set current state as before, except changing the function and
attributes to cdev_state_update.

Sounds good ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
