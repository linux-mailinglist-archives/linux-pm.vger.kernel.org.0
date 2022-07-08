Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C634F56B42B
	for <lists+linux-pm@lfdr.de>; Fri,  8 Jul 2022 10:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237181AbiGHIMi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Jul 2022 04:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237608AbiGHIMh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Jul 2022 04:12:37 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F028804B2
        for <linux-pm@vger.kernel.org>; Fri,  8 Jul 2022 01:12:36 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id l12so10399528plk.13
        for <linux-pm@vger.kernel.org>; Fri, 08 Jul 2022 01:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vc+eezlfPnzWYHGSMVP9Zv55im3/1gxewNG9+41SKHQ=;
        b=GEuY25tkvfR+qMvbD0fCszzdfYTU4NF5Ad0EdTtSbTbd5b4ECbjymsy5SjPeuDYENL
         PKHzDRk1W56+xDKWluThcfnIudP5kv7vhviC78tW9yJONmwWlQYDhdK4NBCehRygfd9H
         DX7CiJv2JVaT4Vb2Y9mnpNlF5TrSRUUSoqt65o8gukiEqQ/Gi82UzaIuapKefZ6XrMem
         T6ljE7wt0qZ7c9fiG22d+N1VoY+HGdDNglqniIlbjYr6yXbDq5DSojuosLT4gSK7O7V1
         APYsyiGYQg2RAhndyVGT/aJD1S+HVPtNnXA+SngnAjbMSfuCRvU3uCH/IuswwT9T24Xj
         wzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vc+eezlfPnzWYHGSMVP9Zv55im3/1gxewNG9+41SKHQ=;
        b=H5dj/zinDm9VzuY9S7ndcuNH8DJyVDIftC7mmgetkoHz3BMhsHwsg1jE7LHawEa9kR
         CZyb/KENkzzsMXMciP6fyB0Det4sc1wJj7DCDcK0zvcB0d3AoAFNNS0FENUrnFRlOB9V
         U1rgwSaRuFHVGxKJDulw4UDMnwNZFcDU9xgnomcWXIMxHJijc6Inb1MeYzIjeZYanz3t
         pgMtuuijJ8aI0Th2YM86FxS9IC7M+nY6NSZyEC4ukBzahCfvQdRClfXB5k3nH0Vf8vfx
         acs6HQ6KI4ttSkdbgjrzXVY84R7AkP9A5zbnyBQdTGIJC07TZjePLfGYz2Ce1KDgUO0j
         oUnw==
X-Gm-Message-State: AJIora865JKhCuLMwerc3p0eYC3moJHHXLImjL5eOrkOK8UUdyTqiVcb
        iEk8XDfkZBC+M/m/e6wBXxxPZA==
X-Google-Smtp-Source: AGRyM1tB6s3CEGsSYt8UjK8u2lu2OyolxM22P8Pu7PnItHcD07cQTGZypwxfxyU28F9ynAVDHrwFTA==
X-Received: by 2002:a17:902:b198:b0:16c:1c13:cd8d with SMTP id s24-20020a170902b19800b0016c1c13cd8dmr2566479plr.92.1657267955732;
        Fri, 08 Jul 2022 01:12:35 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id j14-20020a170902da8e00b0016bd67bc868sm2679388plx.210.2022.07.08.01.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 01:12:35 -0700 (PDT)
Date:   Fri, 8 Jul 2022 13:42:33 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V2 00/13] OPP: Add support for multiple clocks*
Message-ID: <20220708081233.pncnill6dqe4ghko@vireshk-i7>
References: <cover.1657003420.git.viresh.kumar@linaro.org>
 <d557bbd0-2afb-12dc-1287-1aeb44ef55f5@collabora.com>
 <20220708071926.zehurtbcf35s5tv6@vireshk-i7>
 <8c52e1d2-6c6d-9a09-e426-e5292f68a3f0@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c52e1d2-6c6d-9a09-e426-e5292f68a3f0@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08-07-22, 10:26, Dmitry Osipenko wrote:
> On 7/8/22 10:19, Viresh Kumar wrote:
> > On 07-07-22, 22:43, Dmitry Osipenko wrote:
> >> This patch breaks Tegra again, please take a look:
> > 
> > Damn, not again :(
> > 
> >>    OPP: Remove dev{m}_pm_opp_of_add_table_noclk()
> > 
> > Why did you mention this patch ? This just removed an unused API,
> > Tegra should have broke because of something else, isn't it ?
> 
> This patch is the cause.

I was tracking the crash too closely it seems. :(

> I see that previously dev_pm_opp_set_config() had "_add_opp_table(dev,
> false)", now it's "_add_opp_table(dev, true)".

That's definitely a mistake, I still don't understand though how it
can lead to the crash we got.

I have fixed this in my tree now, can you check again please.

-- 
viresh
