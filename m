Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFE155C5F5
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jun 2022 14:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbiF0HVJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jun 2022 03:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbiF0HVI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jun 2022 03:21:08 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACE35FE4
        for <linux-pm@vger.kernel.org>; Mon, 27 Jun 2022 00:21:07 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id m14so7394819plg.5
        for <linux-pm@vger.kernel.org>; Mon, 27 Jun 2022 00:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wyrrdp6ZR/KZgVEp5poQj+i3E9eGqReZcI/auQwwlWc=;
        b=BkvnEDt4HcVPkd5HP+4U52Luwmi19snFvXLAI3jjaCiTljpncxTijrvpJKtOFk9e2x
         psarxdf2qldfH3UYVc0sM/Ye8aPo25K/6yvFil341ahR/Nhsx9py9HvBTRPGRrN5+Nfw
         msf1t57q1hxW2ll+l0hRhgfrF5l9AtyEQ5c6EhJVOre2nZqXMRd20IWNWlaB/dMHV+c4
         /dM7/ugJHryhO81BSa1GNFat7PRSmkZYSr9dgrDunTalLaGSi5An4FBkApU/JG+0I/08
         qv8Hw8VSbh7dRrQUwYWtiUwAYirhj24Bp6TFVDXnDqE7+djIpABRsmwLSMhAa1mvdbGr
         5Bzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wyrrdp6ZR/KZgVEp5poQj+i3E9eGqReZcI/auQwwlWc=;
        b=22/FDlQL0suJADUJGJZcnFbMfgYUpb6l8NCDG7mzycpK3ILeO500LNGGWkaVf7MxOx
         zxQta1zP7hvJtsrSgPCvLCL62uSgLsv5rL5f3wlscxLiW48bgkURsYA0gxvCjLTuZwFA
         WZBV1jNtDAYCWo0O2jg6MhHsjJA8dbap8t89GR0yRXm6MuLbpVTNsymWE1DIeD5K8fwp
         +l8lD0wF9hRrt2zYjYlx4zflsjojlOPg/m33qukZ552tKDqBQS/9CWo65rW5vqxhdFF0
         PBSVpzReogWV31B98H3VyP3Cm2DplvipnGrs9oSvcBgl61k/FPfUu/+obqOOanPYOJrr
         hVAA==
X-Gm-Message-State: AJIora+pyi+rmA4TdFoGD6NQ+Suy/BvPv9hWxLi3nVfsFxEpgN6LoV1D
        076GjRYSe9ERFQdkeT4Q2GCTTQ==
X-Google-Smtp-Source: AGRyM1v0kLQ6NUqZ0WLXEvX11q0gyO9xbbZoyOMKNqo7N/Tgq4JPecjgW9cSnG/95uoXrNrshqXMTg==
X-Received: by 2002:a17:902:d48f:b0:16a:755f:86db with SMTP id c15-20020a170902d48f00b0016a755f86dbmr12899380plg.77.1656314466798;
        Mon, 27 Jun 2022 00:21:06 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id o7-20020a17090a55c700b001cd4989feebsm8573650pjm.55.2022.06.27.00.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 00:21:06 -0700 (PDT)
Date:   Mon, 27 Jun 2022 12:51:04 +0530
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
Message-ID: <20220627072104.ir7kujhezxhzl6a7@vireshk-i7>
References: <cover.1653564321.git.viresh.kumar@linaro.org>
 <449b344f037c7ef1970bc84d31e0d4c4cb4d2951.1653564321.git.viresh.kumar@linaro.org>
 <20220624004831.po35sowzfo4c47b3@vireshk-i7>
 <20220624005700.oj4etaajbutvsym7@vireshk-i7>
 <73d39022-c6fc-0c21-cb68-9714846f02bf@gmail.com>
 <20220627064526.2nkezq4nufpkl4y2@vireshk-i7>
 <ecc72279-0892-d5ab-689d-87b8fba5147e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ecc72279-0892-d5ab-689d-87b8fba5147e@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27-06-22, 10:14, Dmitry Osipenko wrote:
> 27.06.2022 09:45, Viresh Kumar пишет:
> >> Looks okay. If you'll solve the cpufreq problem where OPP config is set
> >> by two drivers for the same cpu device
> > This is supported, there is some early freeing of resources on the
> > removal path though, the reasoning for which I already gave in another
> > email. Though, I am open to sorting that out as well, but nothing
> > breaks the code for now AFAICT.
> > 
> 
> In case of Tegra, we use tegra-cpufreq driver that sets supported_hw and
> registers cpufreq-dt. If cpufreq-dt driver defers the probe, then the
> supported_hw will be lost on the re-probe. I haven't checked yet, but I
> suppose that cpufreq-dt driver defers on Tegra30 because of the CPU
> regulator and that's why we get the "OPP table is missing" error.

Aha, I get it now. I see, this is a real problem. Will fix it. Give me
some time to think. Thanks.

-- 
viresh
