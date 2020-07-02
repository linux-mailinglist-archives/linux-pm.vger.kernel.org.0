Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5265D211A40
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jul 2020 04:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbgGBCoV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 22:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgGBCoV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2020 22:44:21 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7931C08C5C1
        for <linux-pm@vger.kernel.org>; Wed,  1 Jul 2020 19:44:20 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id s14so10682936plq.6
        for <linux-pm@vger.kernel.org>; Wed, 01 Jul 2020 19:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=isbOQd2LXqwGe2XN0v2Rojr+1zs/7ikiY6hJeRf2GTI=;
        b=G+p15q+UuPQNWHWqucs1rYYMutVsji8peFDbApoyy1FGnP1H6aEfT1xCUCwIQpco32
         3oSrVqU5wQZIYJ0dhrXAbV3UB+jigBuUhKq1r986X+Ca2h0TtTGowGkCp2qBty7AzL2s
         SyP7d4DdbDJzxPmeVnXWNOZVrU8dphNb3KjC9pQDTsey7ANzmV9rQZ+zpBARkA/iGrfE
         Xr1KoWZr8+YZ0d9KHTYglvu7UV8y6xP5gDpmS+FTiIq5LiEZLH3E9rH9Pi6r+QjyOqB+
         tgYg3Caxwujlck4Zhvh0GpyErSicwsTELHrH4uyYLkyQMiK0ks+hUph51yX1m9In05eK
         kW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=isbOQd2LXqwGe2XN0v2Rojr+1zs/7ikiY6hJeRf2GTI=;
        b=N5rDx7jk9zqfbkjp76QeldvZ79tYMXE+OR3Osms05Ku/95tQCv1u5xlcFt/yne/Ip4
         3LBgIgVj3pQkJY3quP3wpwduO4OhH3EGKZF1n9FzWBytZDLae0LzwBnY/THAljlDuIai
         pZSFTz5i7sJEcGx4QqixFoHDTOVk5Z8m/laomwUD7Uckt4g+LgP14jIXEYJkUsZUDhA2
         cesPcFVg8k/2V73ITTXk6LD7WH7NLOkYjAbrQdCRYHxwfNIF4i6DQ7+1aJENqH9zAahE
         RM7cl8EfIBPdljB+YI+XNDK+vcTPiuZxNGDkxaTO7PXCMXjeZ2jTKPwJ/MDgIISHzGX9
         tXtw==
X-Gm-Message-State: AOAM531k7MgIVy4KlPKVbafhwWaoSYghA4zBWTBeaB2FzhRkofyuUZIn
        Nvp8bLX9JLp1Zn8XrqDlCaOxTQ==
X-Google-Smtp-Source: ABdhPJyJU07M66YziF91QRH1/LMXAx/FTAxftvnXR+Z1169X1189zk4H4aPpwxzhbmmIqGfdCr4cxQ==
X-Received: by 2002:a17:90a:2048:: with SMTP id n66mr8924797pjc.71.1593657860287;
        Wed, 01 Jul 2020 19:44:20 -0700 (PDT)
Received: from localhost ([223.235.247.110])
        by smtp.gmail.com with ESMTPSA id 2sm7199723pfa.110.2020.07.01.19.44.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2020 19:44:19 -0700 (PDT)
Date:   Thu, 2 Jul 2020 08:14:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: mvebu: ARMADA_AP_CPU_CLK needs to select
 ARMADA_AP_CP_HELPER
Message-ID: <20200702024417.ot2llwnwkfjohjcs@vireshk-i7>
References: <20200701201128.2448427-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701201128.2448427-1-natechancellor@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01-07-20, 13:11, Nathan Chancellor wrote:
> When building arm32 allmodconfig:
> 
> ld.lld: error: undefined symbol: ap_cp_unique_name
> >>> referenced by ap-cpu-clk.c
> >>>               clk/mvebu/ap-cpu-clk.o:(ap_cpu_clock_probe) in archive drivers/built-in.a
> 
> ap_cp_unique_name is only compiled into the kernel image when
> CONFIG_ARMADA_AP_CP_HELPER is selected (as it is not user selectable).
> However, CONFIG_ARMADA_AP_CPU_CLK does not select it.
> 
> This has been a problem since the driver was added to the kernel but it
> was not built before commit c318ea261749 ("cpufreq: ap806: fix cpufreq
> driver needs ap cpu clk") so it was never noticed.
> 
> Fixes: f756e362d938 ("clk: mvebu: add CPU clock driver for Armada 7K/8K")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
> 
> I do not know who should actually take this patch since the problematic
> patch is on Viresh's cpufreq/arm/linux-next

That patch just enabled the config option and I have picked it up for
5.9.

> but the problem originated
> from a patch in the clk tree in 5.4. I assume all that would be needed
> is a clk maintainer's ack? Please let me know if I did something wrong.

This patch should go through clk tree and get pushed for 5.8 if
possible (which makes sense as well).

-- 
viresh
