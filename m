Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D1A71F92B
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jun 2023 06:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbjFBENs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Jun 2023 00:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjFBENh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Jun 2023 00:13:37 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E047E1A7
        for <linux-pm@vger.kernel.org>; Thu,  1 Jun 2023 21:13:30 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso1483280a12.1
        for <linux-pm@vger.kernel.org>; Thu, 01 Jun 2023 21:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685679210; x=1688271210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CEV47gt+ZCZAA8du0k/DRIUXH34XMcva/BFXCCGFINc=;
        b=XuwSId57gjd8r07z06gEvKOJy7AhpKGKpbN238DHatkKvVPw5ZqvBupXh1owDImg8/
         KDMNQJrf10NXVNMbAJFy8W/oe6/buICZnojYYykjKrAVrhvPZASaQy/lSFoESFEZ+vXt
         I+emnc9KjBi1gSDvMsPi2P6RKqWGfZUpSD45I1Tlzl04D+XCLta/luk3K99tzO+othxz
         qHveZIELIiM7ET0h7pTtN2Iammc1GNhFIU8jUZXoWFfuJz+nbcNimueLXBbAJ0D1dYJr
         GLjbi108pvoUmcXA6mBru20GFY88sjFAKY3PEqVtgb9CynZ3KZoJgFe1IxyVxskB2lRR
         RDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685679210; x=1688271210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEV47gt+ZCZAA8du0k/DRIUXH34XMcva/BFXCCGFINc=;
        b=IMjIaL+71za9uwx5BOGbJcR8/IoaMu3WjRqwZV/QCZn6JHi4qON3+CkjZ/euYNlW4e
         2p3CTtToEsGOB6xRGN4KYHmuQoQKiQHuDSzI4bHV1gSly0t2ipgLvV3DiJqI+0Sd5WyZ
         5K+f+s7ciRK9Pi2yTzvFyQyWZ1wdGaTkm9dwLTx6v3A84LE3opz1cZl2mmmdn33fTmhD
         679a/0TY/TsazT0vv1eVp7b9OLZmUMUMutx6QZqNvkFLp/I6N8m2UvUBL4Km2AJbiXLi
         WM95vEcrBVhXwIVA5ha32REWOcJv72/0T5jaCEzNu5lL+/xrGY+4KEg1+ue1qsnQ2guA
         ve2Q==
X-Gm-Message-State: AC+VfDz/0vgbpFSJljNKoZWLTgk5+hh4iBgLAGnyyruRJ20czH3faakm
        7Av+/DoQeAw8/pblhBfFh46UWw==
X-Google-Smtp-Source: ACHHUZ62tXR3tRhbGClnMrXrJBv4svBg6ZDY81NDJr5a+svSbolCg1mmUaznB+ELePuz5sRaQK1smg==
X-Received: by 2002:a17:903:249:b0:1b0:522d:8ff4 with SMTP id j9-20020a170903024900b001b0522d8ff4mr1360769plh.21.1685679210408;
        Thu, 01 Jun 2023 21:13:30 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id w5-20020a170902904500b001ae365072cfsm187707plz.219.2023.06.01.21.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 21:13:29 -0700 (PDT)
Date:   Fri, 2 Jun 2023 09:43:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     rafael@kernel.org, ilia.lin@kernel.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, ansuelsmth@gmail.com
Subject: Re: [PATCH 1/2] cpufreq: qcom-nvmem: add support for IPQ8074
Message-ID: <20230602041327.klyjs4cevmzn6vs7@vireshk-i7>
References: <20230530165409.641661-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530165409.641661-1-robimarko@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30-05-23, 18:54, Robert Marko wrote:
> IPQ8074 comes in 2 families:
> * IPQ8070A/IPQ8071A (Acorn) up to 1.4GHz
> * IPQ8072A/IPQ8074A/IPQ8076A/IPQ8078A (Hawkeye) up to 2.2GHz
> 
> So, in order to be able to share one OPP table lets add support for IPQ8074
> family based of SMEM SoC ID-s as speedbin fuse is always 0 on IPQ8074.
> 
> IPQ8074 compatible is blacklisted from DT platdev as the cpufreq device
> will get created by NVMEM CPUFreq driver.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>

I am waiting for someone from Qcom to review this stuff.

-- 
viresh
