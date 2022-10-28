Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1999B610B0B
	for <lists+linux-pm@lfdr.de>; Fri, 28 Oct 2022 09:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiJ1HLL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Oct 2022 03:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiJ1HLK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Oct 2022 03:11:10 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A79635F5
        for <linux-pm@vger.kernel.org>; Fri, 28 Oct 2022 00:11:06 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id y16so5736955wrt.12
        for <linux-pm@vger.kernel.org>; Fri, 28 Oct 2022 00:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UvvmpT1Wi/iq8QYoikePuB57celazJsG4rJe9Qqhu8Y=;
        b=ESb+JL/lRU1/rs2YkmnQKIQNwz3BpPlSWhDd4QNPDIsI+vjUF0IS4g990zDS1u9JCH
         OMK7IKJM6BPUq7OM9mX+MgNcQRIrvfIpwYu179xDo7eWhVCEaYkkmESL1t87+p4SUYlr
         cVOCeM39nQmtzD2iqdeki1zoD8b629f3Q3Px2BEjD1nVYEr8JoyeENUKzk70RBjNISLY
         pmeE3Iv5RfrPPrdfMgYWWk7X+xQAtirBpNNxzMaYECXg20iYZcEAcCJiGwLv7l9eAUX1
         A0PUKD0q+9blvpsdbErEG/XMJ7yT91Flo5PlqFzC7JA6pL2nRMBAHW0yavD8f96sesOe
         r+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UvvmpT1Wi/iq8QYoikePuB57celazJsG4rJe9Qqhu8Y=;
        b=onVG/2zpSHJgsL8yyXat+9o+PuYNbqFdgRH4ckJiBaMwGPUBfePTYf9NsN8JiMKvdI
         Klsb84N6FzEjZQvwDF0HNE2kUBIsAH6pe3zIcHJZLHwHMeTQScka1mmo1M14aLQ7lAT2
         HsM9F+/6HQNgWUtI11WR06BjE5r50u+Y43Nd8azB5R6CdpN68AGet3OiHONQojnBUMmy
         r7qYiGmWIhsyweRxMrruQxZVz/e2JCqIIJUWSrIKNHNvvjzp7EF6rrIX29Izx464A9Is
         Iiyez3fQ1y/JLbxiEVvVNgjo3fp+j7uUM1LZNkyINiyDo5euR51z1PZCa9f2W0mM3CfQ
         erwA==
X-Gm-Message-State: ACrzQf1CgNaRtQIIZdU5LEX1gt0dmNROIVwDewznvjPx2/5J6Pe6yeYZ
        kofclL9q3HPw2wR6UPH6JT1GRw==
X-Google-Smtp-Source: AMsMyM6fr2+Tog4T3va1myCB6jVen5md9kkIfTie2eyj9+He9Ow097JG0ay5MNgiUddtP7IZARHmPg==
X-Received: by 2002:a5d:6101:0:b0:236:6542:c65b with SMTP id v1-20020a5d6101000000b002366542c65bmr19577836wrt.438.1666941064783;
        Fri, 28 Oct 2022 00:11:04 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:973f:a8b:7c4d:b6c4? ([2a05:6e02:1041:c10:973f:a8b:7c4d:b6c4])
        by smtp.gmail.com with ESMTPSA id r18-20020adfda52000000b002365730eae8sm2850422wrl.55.2022.10.28.00.11.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 00:11:04 -0700 (PDT)
Message-ID: <ac249d3c-6907-daf5-1047-0b3823eef1aa@linexp.org>
Date:   Fri, 28 Oct 2022 09:11:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC PATCH v2 0/1] cpuidle: teo: Introduce optional
 util-awareness
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Dietmar.Eggemann@arm.com, dsmythies@telus.net,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        yu.chen.surf@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20221003144914.160547-1-kajetan.puchalski@arm.com>
 <CAJZ5v0hoe=8nY9vR=+Bjvexrg+E6fcO-S=W+PDkfD=Li6Uy__g@mail.gmail.com>
 <Y1F0GYlJJOnFQeYe@e126311.manchester.arm.com>
 <71438330-dbfe-a10c-f289-24ba25c0d55f@linaro.org>
 <2e02056b-24ef-6262-03bd-63fd6f3a5754@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
In-Reply-To: <2e02056b-24ef-6262-03bd-63fd6f3a5754@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URI_DOTEDU autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28/10/2022 09:08, Lukasz Luba wrote:

[ ... ]

>> [1] Dynamic workload characterization for power efficient scheduling 
>> on CMP systems : https://cseweb.ucsd.edu//~tullsen/islped10.pdf
>>
>> [2] 
>> https://git.linaro.org/people/daniel.lezcano/linux.git/commit/?h=cpuidle/mobile-governor-v5.1&id=de1edb05e3c342f0738b414aa84263d6555b7462
>>
>>
> 
> Thanks Daniel! I forgot about your work in this area. As I have
> responded in some other email in this thread, we might start
> from a new small governor and than others can contribute.
> 
> Even this small governor that Kajetan showed me performs really
> good on pixel6.

Do you have others ARM64 platforms to compare with ?

