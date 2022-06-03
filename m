Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4C553C909
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jun 2022 13:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243911AbiFCLEo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Jun 2022 07:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243910AbiFCLEn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jun 2022 07:04:43 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA493BFB3
        for <linux-pm@vger.kernel.org>; Fri,  3 Jun 2022 04:04:42 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id d5-20020a05600c34c500b0039776acee62so4645945wmq.1
        for <linux-pm@vger.kernel.org>; Fri, 03 Jun 2022 04:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ExK+DYLUUomIg3mRJoq7EumeoyhrwGwm615hpYO0lXQ=;
        b=K19PSH3lwY1yW8Us7aXC4yemQGjRs8tmgABDOI0vD1UaDVhaH/YnOt4TU0pQtq9eTw
         fApFgN1kibEtjP25egxeZs1kpnOQIoxViM6OsebgTbVTljxbUhODUhk8QZINAYXoUjF0
         yN6YF1mqAoVnHgWpelghaiVa7DLUlNd5j2TKIvc7CdXWlh/Q4+s8lsoZDftzXn605iiJ
         LJEfnK/vRSQdUoyQkiByR6M/kGfadO9onx4Bi27AMDPQ0lB5CVx992UzbvzdK/w1d6jw
         iYsD2DwWOaeTfUz6/rZdNt4Dv1qd3Z0QH4qcfHc/Zk+Hi/Pqh4cc/SYy17mb3beo+aFu
         Mv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ExK+DYLUUomIg3mRJoq7EumeoyhrwGwm615hpYO0lXQ=;
        b=Ua+HLCfdkl7U8JaN2IA3G0ExmWXp+/7SRt8DmpSdqS8AApNCGZUlvdVSxayw3bFwmV
         tSHnD/Teua1VMha3B01tgK5024dHUcg3+FHdF3fbL3siXr1id+RT5xuaoddwbaTXtrh6
         88oxQLIgVXyV9Mz038dzm09LudVkVAlsRJYojGiha/3kp5vhho1b5v65NDuyXu2zePq9
         1F0iTj7dlJSojfRqq/GqQMKnDW0sjVrxExZOEsB/ix2oyynPaZKU+mEwwCUQuIHwK0zp
         L7qchpeTiNYrT+6ntGCxlzMQYeU0G/RVvZ4q1clNN+uk6R5HWUw33jiW/0I3gj9+b/Xg
         uPaQ==
X-Gm-Message-State: AOAM532LrPJqbxk/ucRuycXAkvDQ43YxpFAuIOc0jyTcy4XcJjkLGYC8
        xOsQevVHIQMqXEWXAunFOs5o4pBwkkCNHA==
X-Google-Smtp-Source: ABdhPJwp2zagP6UI2fFhVdDyk5de0gUKb9cOw6NpGThJLza8s+4ag0BrvmVlDKzxY3wiX3nST3JQbg==
X-Received: by 2002:a05:600c:4f93:b0:399:e654:4481 with SMTP id n19-20020a05600c4f9300b00399e6544481mr28194292wmq.164.1654254280711;
        Fri, 03 Jun 2022 04:04:40 -0700 (PDT)
Received: from [192.168.1.41] (static-176-182-171-101.ncc.abo.bbox.fr. [176.182.171.101])
        by smtp.googlemail.com with ESMTPSA id h24-20020adfa4d8000000b0020d0a57af5esm7152854wrb.79.2022.06.03.04.04.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jun 2022 04:04:40 -0700 (PDT)
Message-ID: <0ca654c0-d7b4-b955-7e9b-542452659694@linaro.org>
Date:   Fri, 3 Jun 2022 13:04:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/3] thermal/sysfs: Remove cooling device sysfs statistics
Content-Language: en-US
To:     Todd Kjos <tkjos@google.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, quic_manafm@quicinc.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Wei Wang <wvw@google.com>
References: <20220601151441.9128-1-daniel.lezcano@linaro.org>
 <20220601151441.9128-3-daniel.lezcano@linaro.org>
 <be8395e3-98d7-7a8f-7153-c491b22d4463@arm.com>
 <cb35e356-bc90-2a67-6983-1a4c3a0ea62d@linaro.org>
 <eada018c-b857-7946-ae4b-2532e6866a45@arm.com>
 <CAHRSSEz9ExOgvByycztKYf1ncxCKeoy3uHuyQcnUC1r5nujc2w@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAHRSSEz9ExOgvByycztKYf1ncxCKeoy3uHuyQcnUC1r5nujc2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Todd,

[adding Wei]

On 02/06/2022 21:02, Todd Kjos wrote:
> On Thu, Jun 2, 2022 at 2:16 AM Lukasz Luba <lukasz.luba@arm.com> wrote:

[ ... ]

>> I see, it makes sense. Let's see if Todd and Android folks don't
>> use this thermal sysfs stats, so we could remove them.
> 
> Android HALs do use the thermal sysfs stats. debugfs isn't a viable
> replacement since debugfs must not be mounted during normal operation.

Thanks for your answer.

I'm curious, what is the purpose of getting the statistics, especially 
the transitions stats from normal operation?

There were some complains about systems having a high number of cooling 
devices with a lot of states. The state transitions are represented as a 
matrix and result in up to hundred of megabytes of memory wasted.

Moreover, sysfs being limited a page size, the output is often truncated.

As it is automatically enabled for GKI, this waste of memory which is 
not negligible for system with low memory can not be avoided.

I went through the thermal HAL but did not find an usage of these 
statistics, do you have a pointer to the code using them ?

Thanks

   -- Daniel



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
