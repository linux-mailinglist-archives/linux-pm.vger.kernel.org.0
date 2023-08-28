Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC0878A5DB
	for <lists+linux-pm@lfdr.de>; Mon, 28 Aug 2023 08:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjH1Gja (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Aug 2023 02:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjH1GjL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Aug 2023 02:39:11 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E763128
        for <linux-pm@vger.kernel.org>; Sun, 27 Aug 2023 23:39:08 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bee82fad0fso14832235ad.2
        for <linux-pm@vger.kernel.org>; Sun, 27 Aug 2023 23:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693204748; x=1693809548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F/uI82MJmFahIjQ3JIe4Lm/fff5zAxsypmeNLjmcTDE=;
        b=s9C+ZlFeazbUHsuLdqVbqTcWGL7inOGxjhgY0n91bMfEi9IyuGAzKL4SJL9Z5PUg02
         oPVBLaPpy6rhMKu550XNryjD4rSMWqHK82cbVr4a0z8aezYDZNTmaVNatr8KKQvMl4tz
         plgS3qt7THxbKDQHp5qtZxzkkZ12wFx+VWGENJNH5/w8sPLV2m5zxjb66OmyMZ1sWs4J
         p/jtA8+39m+eGNnvwEdDoFoWe0R4VubfjzpdvHGKxvV9T0GDqgZRv6K9SdOCM0cjgT8C
         OzDgSnkb6LicIF9U2Yv9QWLxk8l3EeY6beW1xoApfi6RVMtN+ayyckvE+hK9MDYyFiyu
         NOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693204748; x=1693809548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/uI82MJmFahIjQ3JIe4Lm/fff5zAxsypmeNLjmcTDE=;
        b=YCReCUI/JHsJHTRcw7qv9oQ5nkHjK/nwvWA8Y/rLxE7EVe5ZQ+MBOSPYmuxJ3ZNTVm
         Qs2DqPm5yYIS/gCpCos7uI4VojakDIvz+K/e5QAoeRtIN2mzZWzD4Ob88MayRnKI5MjA
         DuYPZnqSbEyLz26Ql/hQ5MOhYOxfQv5/Ag37I1EzzyUEFdyOG0xKwJISVxFP8s7TANL4
         7dxRsqeHVrxAK2baxCe9XtGiZYylJy650EOxm1KdyjxlM8ihgD4AQoTgc1HtNgIz8kMn
         /14gPulo2NEcPs1PPIpPppTFssxEGkD5mDAqVyCoCISbUb5ynX2xGRnxfZrJG2le8FdW
         Oomw==
X-Gm-Message-State: AOJu0YxG3876SJXr0yQDPL7zn6HdUM9ZcdrNYuaCaf71uMwc5DmFfu31
        qetkTAd7jfXf4dTBpHyqqUkJHQ==
X-Google-Smtp-Source: AGHT+IEfX5Ydlmw9kYOWkdoMlgp8wqv8sIE0zKMiecMdmtoZoTVKzBqDjPdf1q5fjId4zhZFW4u3qg==
X-Received: by 2002:a17:902:f814:b0:1bf:6ad7:2286 with SMTP id ix20-20020a170902f81400b001bf6ad72286mr16881098plb.43.1693204748067;
        Sun, 27 Aug 2023 23:39:08 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id z11-20020a170903018b00b001b89b7e208fsm6426112plg.88.2023.08.27.23.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 23:39:07 -0700 (PDT)
Date:   Mon, 28 Aug 2023 12:09:04 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Mark Tseng <chun-jen.tseng@mediatek.com>
Cc:     rafael@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, sumitg@nvidia.com,
        sanjayc@nvidia.com, rafael.j.wysocki@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH] cpufreq: mediatek: change transition delay for MT8186
Message-ID: <20230828063904.r7huxclehlblkkjx@vireshk-i7>
References: <20230818020616.4748-1-chun-jen.tseng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818020616.4748-1-chun-jen.tseng@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Mark,

I am not entirely clear by few things in the commit log.

On 18-08-23, 10:06, Mark Tseng wrote:
> For MT8186, it has policy0 and policy6 by different governor thread,so
> it may be call cpufreq->set_target_index() by different core.

Why does this matter ?

> In general
> case, it must check BCPU, LCPU and CCI together then take about 10ms.

BCPU is Big CPU ? LCPU is Little CPU ?

So are you saying that changing the frequency takes roughly 10 ms for
MT8186 ?

> Atfer 44295af5019f this patch, it may call cpufreq_out_of_sync() by
> cpufreq_verify_current_freq() because current frequency is bigger
> than clk_get_rate() ouver 1Mh. By the same time, it may call

s/ouver/over/
s/1Mh/1 MHz/

> cpufreq->set_target_index() again.

Where was it called for the first time ?

> So, the CCI freq may be too lower for
> BCPU cause BCPU kernel panic.

I am not sure how a low frequency causes kernel panic here.

> So, it should change the default transition delay 1ms to 10ms. It can
> promise the next freq setting then governor trigger new freq change.

There are few typos as well here, please fix them.

> Fixes: 44295af5019f ("cpufreq: use correct unit when verify cur freq")

I think you should drop this. The issue at hand may be visible now
after 44295af5019f is applied, but it certainly didn't cause it.

-- 
viresh
