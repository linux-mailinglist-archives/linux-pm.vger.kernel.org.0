Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805D04C403A
	for <lists+linux-pm@lfdr.de>; Fri, 25 Feb 2022 09:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238554AbiBYIjt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Feb 2022 03:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235206AbiBYIjs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Feb 2022 03:39:48 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB85324FBAA
        for <linux-pm@vger.kernel.org>; Fri, 25 Feb 2022 00:39:16 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id y5so1236396wmi.0
        for <linux-pm@vger.kernel.org>; Fri, 25 Feb 2022 00:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yFGB99HaWHNqvoZKDoHvHdOk3utIeS6YgUAJuoWH7ss=;
        b=lRfQqcCi8kZGD7So/uH+f4j/9sbHVe8uriiXQ02y8JSFOCk3SP/XI+WJ9DxI85Dt3Q
         wA9VALtkeM52Gz0G+csZt0pzn6KSo8BS06a8hnm++/3nUEAulCYXSKrdBY303ZoWaqF0
         wzFBBzjdIPBhkD0M1jBCb/ngvVJ9zxOUh4Znb25ojmowRQl3F1OUWJ+wk/c0iEzszI/0
         ndhVxFbFupPGSHU0+z9xs7GsVBov/1c88Tvk1TeVWCOwwRVH8o+Fne5AClaGOq/oXf2i
         bTUxqwI8FJyueGu+J3uZqxG2n41FB/6g9xo+NRyoKqJx9aYvAvBCERvkFSzCSsEUubOv
         idmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yFGB99HaWHNqvoZKDoHvHdOk3utIeS6YgUAJuoWH7ss=;
        b=hHledDwrO/vewUdv8MlcEigIInj8i7xhjYqvjKdHESOqhjTLMGzJDhfM5zaEqmdGL+
         QQL/hIt1toStbbWd0DNyN1BZBcTjRK/ljtANKLm6z4fXCpa3C9uhidWXDhR1ewjcrvtz
         8b3DMvy4nbl6RD2ZlhV4/t5IorZngPzVe3r5dyBG0sVLzIZ8dZZ3bAHLYhOaEEYTAWCE
         L/QeppmEr8XPcf3f4mRr3XoeQHwId8I/KW6Knoy+S7jStLbyXE8/9aTFYG2WTM0rqyVj
         6v2sRmfiyq9fDw0cWrQV2OLSf2EHB12ut+6D9tddyM1XFZHVtIhnfgifXdtD2Fxfu2hD
         9F0Q==
X-Gm-Message-State: AOAM531eqW6TmFol+zgqzxsYclHvJcsmbt138PuDHBZ+kadCcuS5UZLp
        5ciHZwMW7/c8ycF3ok1HSRbeOQ==
X-Google-Smtp-Source: ABdhPJzIAwaPG8VnpVB+4HSz3IQo/RJ3sW2UFLoNAuJxgA/2TTLYOXbuo8CwIPw7kLX/Eu7A00LbNw==
X-Received: by 2002:a05:600c:3007:b0:381:271:49a1 with SMTP id j7-20020a05600c300700b00381027149a1mr1659784wmh.79.1645778355123;
        Fri, 25 Feb 2022 00:39:15 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:25a:d4d2:9383:c638? ([2a01:e34:ed2f:f020:25a:d4d2:9383:c638])
        by smtp.googlemail.com with ESMTPSA id g6-20020a05600c4ec600b0037bf934bca3sm5823991wmq.17.2022.02.25.00.39.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 00:39:14 -0800 (PST)
Message-ID: <7df5e8af-6296-4c8b-1624-65052c77a927@linaro.org>
Date:   Fri, 25 Feb 2022 09:39:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 0/4] Thermal library and tools
Content-Language: en-US
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20220218125334.995447-1-daniel.lezcano@linaro.org>
 <3a3320d1-c4a8-d5e0-63ef-dd098711f38e@linaro.org>
 <111b378d22a7c5353bbd4537e0219a4d07d015ff.camel@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <111b378d22a7c5353bbd4537e0219a4d07d015ff.camel@linux.intel.com>
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


Hi Srinivas,

On 25/02/2022 02:25, srinivas pandruvada wrote:
> Hi Daniel,
> 
> On Thu, 2022-02-24 at 22:41 +0100, Daniel Lezcano wrote:
>>
>> Hi,
>>
>> What shall I do with this series? Is everyone ok with it?
>>
> Want to try out on a system and check. But unfortunately couldn't get
> to it yet. Hope to get to it next week. Is that OK?

Oh, great! Thanks for trying it out. Yes, I think next week is fine



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
