Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E424506C9B
	for <lists+linux-pm@lfdr.de>; Tue, 19 Apr 2022 14:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241928AbiDSMnY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Apr 2022 08:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbiDSMnY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Apr 2022 08:43:24 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F302E6BC
        for <linux-pm@vger.kernel.org>; Tue, 19 Apr 2022 05:40:41 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id lc2so32575740ejb.12
        for <linux-pm@vger.kernel.org>; Tue, 19 Apr 2022 05:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3mFrRGZ2hFvP8O4X+CuKmWb2rkzJm3vVXdrSrkWv/zg=;
        b=cjosF7poiXNd0rfz6mXjywOG7hZq92kjmu1s+0SRlGUO40CwLaZs+070XiXHG1VFrY
         FstDX8T0mZC39VkKY3v7X1GlDDNf7+WXE/HsHLCgvlnVSZA5BoVqsB2mTn4GzIkNVDNy
         ck549tq8tRuD64t9SqYw0ylLLrbpUt4Z0Ahro0UmxfCPapgYV5RfrBwTfyJAouDLjP9D
         UBMUrIpbMOTAlrLfhclT7EV2go8Hdksg+au2fp/2NQmccKopHUGbttF8J3YWzHpwixCB
         OWxfod8jJpW6VRFmfAOheAnDv2VTBh7kX/wl3meQ8vvP+w9GGNuvYuz3ZfGjxwTgCM7o
         kjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3mFrRGZ2hFvP8O4X+CuKmWb2rkzJm3vVXdrSrkWv/zg=;
        b=3CQGH++GVrEAQvTzCJkgaSGebfe+FJrTVqgTSIENL9xdhDdq0wd1yazfqPam4eejFN
         uKvxrfU6sUUchBrtDZ+0avU5ZwUUhKfUTx0n//rZW89dN6/rNsgWIm/1kvj3aBmXq6uQ
         YQbxhC4c+B3fE9Rku9ibm6CVUfu6Y0IDN+D8FOZg5Y9kS1+wFdRx5RyQTX7f+5/R/Kk+
         tPUx8WciXLW64gQHj4nj0krEyuNWVK23GkzVvYwUaV0KzDL6NzwyCXuWvNLB4qLKy/o+
         Q/ob0DGNRjXCdYykEv/KczasZlzvX/1ft/4qeST8VTvGPjt1QKAL73lPgb0YFS8RRnO0
         T2iw==
X-Gm-Message-State: AOAM530b5JkC5Qgi6lmJ0ERcI2b7ShyG/gBg7D9iVQu4WZ3NLqmwYxc8
        MIiCLc+HfVFjAS6hvj4hNdlxcr9m6Zpusg==
X-Google-Smtp-Source: ABdhPJyVbGwvledAKMJPoCayIO5+opfeoj4KbZI87HqtQiKuhBGcWMaL+ILbHZfyTw5IwfsSlLDNWg==
X-Received: by 2002:a17:907:96a8:b0:6ef:6a93:2e55 with SMTP id hd40-20020a17090796a800b006ef6a932e55mr13389481ejc.603.1650372040259;
        Tue, 19 Apr 2022 05:40:40 -0700 (PDT)
Received: from [192.168.0.217] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g1-20020a170906348100b006efc26c7b1dsm1572142ejb.195.2022.04.19.05.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 05:40:39 -0700 (PDT)
Message-ID: <e9815733-3b65-d1ad-9af9-ca32e656f643@linaro.org>
Date:   Tue, 19 Apr 2022 14:40:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] PM: opp: Fix NULL pointer exception on a v2 table
 combined with v1 opps
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220404123757.798917-1-krzysztof.kozlowski@linaro.org>
 <20220411024915.7zmoyphgongzorci@vireshk-i7>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220411024915.7zmoyphgongzorci@vireshk-i7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/04/2022 04:49, Viresh Kumar wrote:
> On 04-04-22, 14:37, Krzysztof Kozlowski wrote:
>> dev_pm_opp_add() adds a v1 OPP.
> 
> That's not correct, it adds a simpler version of OPP and doesn't
> support complex types. A opp v2 table with just freq and voltage
> should be supported by dev_pm_opp_add() and we shouldn't disallow it.
> 
> I think all we need here is a couple of checks to make sure the
> earlier OPPs don't have anything which the new OPP can't support. For
> example checking required-opps field, etc.

Would be useful to have list of such new-OPP properties somewhere. I'll
try to rework the patch based on this.


Best regards,
Krzysztof
