Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6394C525AC8
	for <lists+linux-pm@lfdr.de>; Fri, 13 May 2022 06:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353790AbiEME3a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 May 2022 00:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiEME33 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 May 2022 00:29:29 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0980C28F1F8
        for <linux-pm@vger.kernel.org>; Thu, 12 May 2022 21:29:28 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id n18so6844055plg.5
        for <linux-pm@vger.kernel.org>; Thu, 12 May 2022 21:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kOkWkR9Ocy2CU7QPzBKs2WmW8Yr7OVdgCwKhMEH1vEU=;
        b=pr9XuWJgiU/uRmmT5fZbBoUYR2ZQfOvIP/fG8IH7DKeqmuojFuDZ5c8c4YUHPmqBmh
         zXNWMD3IgW8+O/7EHImSmJOMWPbw4I/GwppQwL8wZOPiK6LvvlpuBjNBTHMbMwZqiD8y
         hXkWpEI31SeVpwZGidBW3OrJdvIc1VSzXbPDMG45/V9kihbRiwTFLZdv3bmc2a9zzgEj
         yzGnffWVkfmvcPTQeqLwmZIq34n4O5wVfPfXE/Ebg4edrwrZE9reXxaAFO42AqvAMI6V
         KA6K1ScFTbKuf+vbjXXUv0zz2w8of7sO+JSJwKPDa4ZO9gJlXH+fbjEA1MHINOZ3fxbd
         EIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kOkWkR9Ocy2CU7QPzBKs2WmW8Yr7OVdgCwKhMEH1vEU=;
        b=2brhxajIGuKoeGMxkrC8nyuax3ZJgT/R5oNX60ADm+vtvs1iRr2+XW29G/qZ+COQ/f
         VZ4pUdGlMFskWg2EweTkCQ10hmkmkEXQqnZW8cgkDmF9To9aiaUC80Tp6kC1I7ljNI2k
         h4tvCyMY6UrF59vSF3uhl/hAc5lFeWAJSYo3ymatXUNT5OeGGzPgaZavUXM1nL4/QVRG
         uBpk/UGXX+71QqsNfsA6sncuZudCKVWnsy0+fVbiSMijUVOPYOI65hlrw1S1cQ5CvIiU
         9D5UFpquoTyqjzG3PlJNWa69y/TLFquGTQrCEtUchYysH43K4WgsQFBGo/Hxdif6vsJA
         hrJg==
X-Gm-Message-State: AOAM530biBpiIb0Xasue9JEk76Pb4Cvz56gllPxoODWI9cxWZlk4qY2P
        /4FG6OOCbHwsej3QSgzzWltIZg==
X-Google-Smtp-Source: ABdhPJzXX3SKeWx7mB3jrDkUEdCdK+qjACy3ZkK/roOebknMQ5MhRsCd4gkNu9EYHwd4fa4whpthOw==
X-Received: by 2002:a17:90b:4c85:b0:1dc:5778:5344 with SMTP id my5-20020a17090b4c8500b001dc57785344mr14165956pjb.8.1652416167522;
        Thu, 12 May 2022 21:29:27 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id m21-20020a17090aab1500b001cd4989fed4sm2555583pjq.32.2022.05.12.21.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 21:29:26 -0700 (PDT)
Date:   Fri, 13 May 2022 09:59:25 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Schspa Shi <schspa@gmail.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] cpufreq: make interface functions and lock
 holding state clear
Message-ID: <20220513042925.42hvv26ejup6js3h@vireshk-i7>
References: <20220512135231.10076-1-schspa@gmail.com>
 <20220512135231.10076-2-schspa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512135231.10076-2-schspa@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12-05-22, 21:52, Schspa Shi wrote:
> cpufreq_offline() calls offline() and exit() under the policy rwsem
> But they are called outside the rwsem in cpufreq_online().
> 
> This patch move the offline(), exit(), online(), init() to be inside
> of policy rwsem to achieve a clear lock relationship.
> 
> All the init() online() implement only initialize policy object without
> holding this lock and won't call cpufreq APIs need to hold this lock.
> 
> Signed-off-by: Schspa Shi <schspa@gmail.com>
> ---
>  drivers/cpufreq/cpufreq.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
