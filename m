Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D7D6B6E70
	for <lists+linux-pm@lfdr.de>; Mon, 13 Mar 2023 05:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCME2z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Mar 2023 00:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjCME2x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Mar 2023 00:28:53 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3262A6DF
        for <linux-pm@vger.kernel.org>; Sun, 12 Mar 2023 21:28:51 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id i5so11586735pla.2
        for <linux-pm@vger.kernel.org>; Sun, 12 Mar 2023 21:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678681731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TAvGM9A2vDOzZdyZgN/PhkShf6xY7yJiV2Tqe3Nl+SQ=;
        b=vgSzyJf6wycqYZ/VP28K2uAd0g5ZW4Z17ATSTMj8bm/53X2tJN6kLXOuJUq2qi31px
         yTLOEvIj36P32blXlmvFWEpkRyIyz6ATGjFYQ99xtcsCFHsc2JewOeL8a0bqcWQhue0K
         Z5knfx4nBfuz7GdB05icBFRp6tGwuynWdlqAsAt0+7J16rlNB1iwp70JepKXzgvD38M0
         ifWATre3vYuJ0aduoRvF3Bakmn6wIVtpHx7H288oyWgmd0dvzyus7St6jM9vCxoDphRJ
         WCDeXAK4kePRLuHWAPz7O8Z+/yQDo4YzoXMueK6qhRQmHigR4daFHTCI5iuSZ6Um6HSk
         5iQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678681731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAvGM9A2vDOzZdyZgN/PhkShf6xY7yJiV2Tqe3Nl+SQ=;
        b=l9hEswQNHaYYPrms8Ca1Haolt1mutmM0sW2EZtXm7qy88ActmJngkviKaq1f3dFsFY
         EfUoXZybUUQ6s62vO7Mgq5qnqFvQepu8cjkR/gm7ElA4tJcBPwWGhZdx1/qRnSOVSb6K
         aRrAZyOGV533n/kJHDiyMmmNeyH6JUtV6TORFNd6uwh3uPjfbjs21qo5vHdBr7+ysAxG
         WPAbd5TFSpf5pB0Bs0ztbHwYA2GPm0Erj427ueetM/zUDQbGVONE52Uf/deO8WyrixNA
         jpRapAU5Xa6IgfkidXI6QDueZU4cAMTcnZZVZTa61AsI4GWP9Z/4kPdSHA8xhwYwTI+d
         AnBg==
X-Gm-Message-State: AO0yUKVrbc7E6p0FSgiqFXJiHnaU0oeEGyqXU6pXto0+Vefkago2jfyl
        QpsVYeBAODay6d7M13KpWDdiEQ==
X-Google-Smtp-Source: AK7set9p4bFVrpjWBwosOcH7++GcaLBhSfedNIG7sXxnuN2cWJ9UqlzAa/4KGepgTsY0V/w5bofLMg==
X-Received: by 2002:a17:90b:943:b0:23d:198c:a5ec with SMTP id dw3-20020a17090b094300b0023d198ca5ecmr565374pjb.39.1678681730991;
        Sun, 12 Mar 2023 21:28:50 -0700 (PDT)
Received: from localhost ([122.172.83.155])
        by smtp.gmail.com with ESMTPSA id y2-20020a1709029b8200b0019f0f5704besm3557029plp.236.2023.03.12.21.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 21:28:50 -0700 (PDT)
Date:   Mon, 13 Mar 2023 09:58:48 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Use of_property_present() for testing DT
 property presence
Message-ID: <20230313042848.bt4vl3tjjdb6qs34@vireshk-i7>
References: <20230310144702.1541730-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310144702.1541730-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10-03-23, 08:47, Rob Herring wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties. As
> part of this, convert of_get_property/of_find_property calls to the
> recently added of_property_present() helper when we just want to test
> for presence of a property and nothing more.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 2 +-
>  drivers/cpufreq/imx-cpufreq-dt.c     | 2 +-
>  drivers/cpufreq/imx6q-cpufreq.c      | 4 ++--
>  drivers/cpufreq/scmi-cpufreq.c       | 2 +-
>  drivers/cpufreq/tegra20-cpufreq.c    | 2 +-
>  5 files changed, 6 insertions(+), 6 deletions(-)

Applied. Thanks.

-- 
viresh
