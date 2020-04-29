Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D601BE975
	for <lists+linux-pm@lfdr.de>; Wed, 29 Apr 2020 23:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgD2VB7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 17:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726456AbgD2VB7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2020 17:01:59 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC06C035494
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2020 14:01:57 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u16so3596798wmc.5
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2020 14:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+TvQcFiU3aloZC/hJe73C/3yo1nULr9/ZJUA32G7jIE=;
        b=H9LCYrG0FR/boqVhN935EFeTEvmRileVmKdUA0aVoLMMqYWBxAGooFAv607/oc09gQ
         jcrZAm3GONS/8m39QndXY49RaLER9NEFUa653B2ngCBn7ZCGrcdAVjocnNbTrSf25qN4
         vPvKoFVeAsf11wHlPIf7AXMWs6x32q9H7Kzt+1uk4dVUYBPU4TtvcZ8TPmOVqPjx5PWT
         mBAtkgsL671JFF5+qX11uhNIFLn7WPMlr5vI+VKPn92kxe2x9O7zW+lmuKzIekqSOCzv
         Oj3bjL5fQnRn0ScVfPNGTWPkxyJaZbsHQllHV1J0X1F0BbTLG0gkXmvNdH8gq58yCwdh
         DveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+TvQcFiU3aloZC/hJe73C/3yo1nULr9/ZJUA32G7jIE=;
        b=rKzfhY6+jBkKn+rc9UmYMYR4vAbq9PSIpvuEjixvfASUP6MpCE6jdQYbDh2g7XTLeu
         hG2KkJdXuEjfp8yVrX4zoxL3AXIzK69Tjo6L744xSmbK8Ay4W9vK3BIvv8P87PVVflu1
         4KmClS6w35YKIsfDEnroPnKGST1BmmGSzQltMCQid70QDNaKICgf5AAfuUQKe4BZjtEV
         GifObo8K3fAGdetLN00F4ay5Z+I0Z3Q+lQUzvAtGnKcd91y+j0C4Un5tbf90FRrBumYQ
         I4ekcY4nyo1ivg901Oq/W3cneUjHRoABJFuFr6FZIW9JzBt6SfdT0Yua39ZswU8xekBt
         8siQ==
X-Gm-Message-State: AGi0PuZn6bjL6ORW3Atiq+jQfXuptgJhPcYNG45DPSAf4R4VBeqNtd2u
        aQGP5ooiRvpnlJG6bc7BeljzPQ==
X-Google-Smtp-Source: APiQypIvQ29o70NDaZXlBpTOIaRhPrpz0gn3DVu8Qm0SOXFFXbUtbluMOqQ01NrQtAIBEVVefhXGfg==
X-Received: by 2002:a05:600c:2f88:: with SMTP id t8mr5151772wmn.46.1588194115762;
        Wed, 29 Apr 2020 14:01:55 -0700 (PDT)
Received: from [192.168.0.41] (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.googlemail.com with ESMTPSA id i25sm9242483wml.43.2020.04.29.14.01.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 14:01:55 -0700 (PDT)
Subject: Re: [PATCH v4 4/4] thermal: cpuidle: Register cpuidle cooling device
To:     Lukasz Luba <lukasz.luba@arm.com>, rui.zhang@intel.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "open list:CPU IDLE TIME MANAGEMENT FRAMEWORK" 
        <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CPUIDLE DRIVER - ARM PSCI" 
        <linux-arm-kernel@lists.infradead.org>
References: <20200429103644.5492-1-daniel.lezcano@linaro.org>
 <20200429103644.5492-4-daniel.lezcano@linaro.org>
 <99b3bc79-f48a-3d51-a8ae-8b9ca4856d36@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <04b5da25-d591-b08a-e554-6e084d7ea908@linaro.org>
Date:   Wed, 29 Apr 2020 23:01:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <99b3bc79-f48a-3d51-a8ae-8b9ca4856d36@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29/04/2020 22:02, Lukasz Luba wrote:
> 
> 
> On 4/29/20 11:36 AM, Daniel Lezcano wrote:
>> The cpuidle driver can be used as a cooling device by injecting idle
>> cycles. The DT binding for the idle state added an optional
>>
>> When the property is set, register the cpuidle driver with the idle
>> state node pointer as a cooling device. The thermal framework will do
>> the association automatically with the thermal zone via the
>> cooling-device defined in the device tree cooling-maps section.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   - V4:
>>     - Do not check the return value as the function does no longer
>> return one
>> ---

[ ... ]

> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Thanks Lukasz for the review.

Rafael, as Lorenzo and Sudeep are not responsive, could you consider ack
this patch so I can merge the series through the thermal tree ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
