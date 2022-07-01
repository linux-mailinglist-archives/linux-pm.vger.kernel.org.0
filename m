Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C55562BF6
	for <lists+linux-pm@lfdr.de>; Fri,  1 Jul 2022 08:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbiGAGrO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Jul 2022 02:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbiGAGrM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Jul 2022 02:47:12 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D76A5A2D0
        for <linux-pm@vger.kernel.org>; Thu, 30 Jun 2022 23:47:11 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id bo5so1587414pfb.4
        for <linux-pm@vger.kernel.org>; Thu, 30 Jun 2022 23:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=egN+UcRccyuVdeQkEYj2+EifXHdLgxW8lFptDJxiZwA=;
        b=fMSzBwcdGpl7JiujKWe7RLNNTZJ/speGjpvF1eCWyvbWO1dWRU1Se2M584shUWZXhN
         x8E6xce+MYk59dVHkITbamMpqowTtcIdK2XWHOASpJSUhz3YVBo4xN5psSO098BBixGR
         61o/GgsaHhZ2PR3YgkJqYuj7EEx5PBHoz/8oVyYk8kb4/FQL7c3gSesgY7cZe2/uMiED
         7mIxavqpSwPrJVLS9oyTpuSRJ2NqrKentqHN/rKtAZnGG+WIAXBnBRd6VaT54kWqM3Oz
         gq61W+NXzU/DxP9r2lQAesaS94F80OFLRk+b4k8KIAxQ//79EtvfyPiJo2JQzYVwpyZn
         gruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=egN+UcRccyuVdeQkEYj2+EifXHdLgxW8lFptDJxiZwA=;
        b=GoTgfkJ9q9k4oPoTqGYKuXkAa4AtRLobwkuxf6fkwA6Eo07a8oL4cGIHa/wkzvclov
         QbI4tSBuxhrpPfu2LyEXlNEOlmXa6imoHDhyN7R8CZN3LLn6GUZXGmPavNdznmgoUGxf
         EnA6XutPKnXa4N7J8UE2da/bUu22npN+v6flr3rap+lkR14lNCAGXRtOKYDDY1O1/Qw4
         CP2JUf2EJIHQsRRmcuA/hYcY1zuKUKLKSfvZD+J2wATCuCL1OWuhQpEiD2UArG2z89dE
         LOrJW5xWTxmeM1jR5n2ZmUbP1wS22+prAnlBEC2Sx3ir5Rd1Gbw9wpFuu8zX8mQP24ZE
         s8Pw==
X-Gm-Message-State: AJIora8IMV4NWv4HQulMyj74qXl0RzeH6v8cKKVq3JpCi4MepazbH3y/
        8VcQguPLGs+u6sDvf/yj7jQl2IPYPwnO6Q==
X-Google-Smtp-Source: AGRyM1u9PssLfCNx6VYufOEdSrkkUB1v4i9u0kQQRnf7duxhEmTfCshLrmwaMvtoDk6mwibMC1N5pA==
X-Received: by 2002:a63:1a52:0:b0:40d:9515:c113 with SMTP id a18-20020a631a52000000b0040d9515c113mr11220337pgm.312.1656658030839;
        Thu, 30 Jun 2022 23:47:10 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id n63-20020a17090a5ac500b001ec8c53544esm5713373pji.46.2022.06.30.23.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 23:47:10 -0700 (PDT)
Date:   Fri, 1 Jul 2022 12:17:06 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] OPP: Allow multiple clocks for a device
Message-ID: <20220701064706.jgm5q6k7yzumhqdy@vireshk-i7>
References: <cover.1654849214.git.viresh.kumar@linaro.org>
 <8b29fa207024dc295639f9ba52c28e45782e3baa.1654849214.git.viresh.kumar@linaro.org>
 <de13cca4-3a33-6482-7b02-f89796f45325@linaro.org>
 <4cac6c79-ea9a-1f48-c6f1-2e04b54590a4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cac6c79-ea9a-1f48-c6f1-2e04b54590a4@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30-06-22, 14:39, Krzysztof Kozlowski wrote:
> > Shouldn't this be >=1? I got several clocks and this one fails.
> 
> Actually this might be correct,

Right.

> but you need to update the bindings. Now
> you require opp-level for case with multiple clocks.

Will do.

-- 
viresh
