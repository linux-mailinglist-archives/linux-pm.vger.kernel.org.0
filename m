Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B14255D964
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jun 2022 15:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbiF0Gpa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jun 2022 02:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbiF0Gp3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jun 2022 02:45:29 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29975599
        for <linux-pm@vger.kernel.org>; Sun, 26 Jun 2022 23:45:28 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id n16-20020a17090ade9000b001ed15b37424so8466499pjv.3
        for <linux-pm@vger.kernel.org>; Sun, 26 Jun 2022 23:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bH3Vt7XX7aybZeFwi1CTdnlCoZZeRmTfAiO/nez5hfo=;
        b=ykFyF40ED8ltV1C22vrrCu2Ahxrq6lDUEHVRJJMWmLISGsTYVnUmByK/WyYZAoFJEs
         B77swVbdEz6e+oEZpaCTgE7Hylf9Yb4qjD1AgGIoCJ8RD+MrjKrI5Jzy6D9vBdJplVae
         7c4aw1Z1c1SkbrHp2rQGTuUna8Soo5ErVHrT5kZo6hpBqOGkEiYtHauCfhmOFHxhV3E+
         zgN/C30pAgiLj6MF5qA727QeEDMlQ1tRsxevl8fyMpQ981JkaJ8cqYjKcrHG0nMcghWE
         P9Yz0E5CiyTfhYjTcXLUNV7+9waiX+sM8Fhix46lgrs218sgFUTqtBihxvmnWEXWe4aY
         xJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bH3Vt7XX7aybZeFwi1CTdnlCoZZeRmTfAiO/nez5hfo=;
        b=kAgHtwDs87A7soOgyThr4FRVWkme3wDR8LNhcWnSNMWhBB63LMsItKN1Pu4KBQcZsB
         Z++LAStPUvcP/J92bAagnJUP2mk2AqiEVzM0Lh3atwUQLYjjPSvzhRWvv0gzqhlZsS2O
         sKgGaKBpcWsa0P8J4DZdWezQQXjUDMsbm7x0slVLVNmu/+1h8/da8pcBrwN495yYmPf4
         Po3DYgPOuV+Dzkbnu+AI4TJzfbsyWQU4oKGpvrzudnXbxT08DwDKv6Ve2K2yWXXHrDNv
         gAd9JrxTD+Uq/T9VluZ2W2wDEyaiNwsHoHM4kptbSMEh7i6CNWIwh0fe6QI4agsiGkaY
         ZdQA==
X-Gm-Message-State: AJIora8pJ4s+AnoJa4h/UiopbE/13Li60f9EnXTvP+EiWAZ29sx8+VOY
        idhpyTfJWOioi4kIrX7DhTSRnA==
X-Google-Smtp-Source: AGRyM1skjSIr2LG5qz1p7HriNtf5RQBG+zI/jwqerqVBvWNFUvR0glyAewRI0itDcsi27L2Yi8fzKw==
X-Received: by 2002:a17:902:f20a:b0:16a:22ef:b17f with SMTP id m10-20020a170902f20a00b0016a22efb17fmr13305957plc.168.1656312328184;
        Sun, 26 Jun 2022 23:45:28 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id jf5-20020a170903268500b0016a1d007637sm6295143plb.110.2022.06.26.23.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 23:45:27 -0700 (PDT)
Date:   Mon, 27 Jun 2022 12:15:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 22/31] soc/tegra: Migrate to dev_pm_opp_set_config()
Message-ID: <20220627064526.2nkezq4nufpkl4y2@vireshk-i7>
References: <cover.1653564321.git.viresh.kumar@linaro.org>
 <449b344f037c7ef1970bc84d31e0d4c4cb4d2951.1653564321.git.viresh.kumar@linaro.org>
 <20220624004831.po35sowzfo4c47b3@vireshk-i7>
 <20220624005700.oj4etaajbutvsym7@vireshk-i7>
 <73d39022-c6fc-0c21-cb68-9714846f02bf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73d39022-c6fc-0c21-cb68-9714846f02bf@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27-06-22, 01:14, Dmitry Osipenko wrote:
> Looks okay. If you'll solve the cpufreq problem where OPP config is set
> by two drivers for the same cpu device

This is supported, there is some early freeing of resources on the
removal path though, the reasoning for which I already gave in another
email. Though, I am open to sorting that out as well, but nothing
breaks the code for now AFAICT.

> and will keep the set_opp()
> helper that is needed by the Tegra 3d driver, then it all should work
> for Tegra.

I have responded to that as well on another thread.

> Looking forward to the next update of the OPP patches, thank you.

All that I have is already pushed to linux-next, I don't have any more
changes. Yes I still need to send the updated changes to list.

-- 
viresh
