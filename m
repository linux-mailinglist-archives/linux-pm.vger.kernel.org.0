Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4B12AE8AF
	for <lists+linux-pm@lfdr.de>; Wed, 11 Nov 2020 07:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbgKKGPF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Nov 2020 01:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgKKGPF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Nov 2020 01:15:05 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82DFC0613D1;
        Tue, 10 Nov 2020 22:15:04 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id l2so1675084lfk.0;
        Tue, 10 Nov 2020 22:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ueu5uW+Gs7n1BlGQ4zVO3Hsje+5ZnemXOi5VWUiWGgY=;
        b=B77ZmpGxWBBTkp1chXDUgCnFrzSt2oMPFfzzELNlHLy/hWt7Bz40l/E7AdVmHlNAe/
         GQiwqC350cm1FN+e4kLUYym16afqIhO6GK/gWnm4E1uE4DtGcjF1ijk4UaEUFYTuqmbV
         oNQ9AEAdbBldaT1bkmctoSbFwT/shQLdatDwkD+6mEdbPFUpRZ2722HOYZ3jznCoT3UB
         uLD4XTTof3/n1eAJdg8kMSxld4srAjxNUUeFJucfeffzi+sfoEw0N5ilzpuJGCsW8OSv
         G48nZOGz8WldSdc00oOfooJ46G2iy78kbk08qlZ/PTGfME8tZfYeX5LJ2c50g0Z+NNk+
         rWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ueu5uW+Gs7n1BlGQ4zVO3Hsje+5ZnemXOi5VWUiWGgY=;
        b=g+jCpG7BFn9ABFkai6aH3QE7+zjg6P2fLXQIJtJjPHINrgbIezhFrsywSCacZfGeYf
         1Cu8eav2pJzuOGmLkJy0ZpSrdm3ude+lyR83b5v+XlecjW1uaxEa1NoeWtSdUUXRwQxk
         4M7R3KMopQh3veOPcTWAjk85Zie0KdLdqsRwVVDCjr+C7UiF6lCUel+baiwl98IzQgfs
         xVUa8EFM6C+ftGMjm6vaIT0XjN1ljWmze+wjqqFr7LIDT+GVy2rPfa6QjeYkXwEJXiVs
         eHgfwqj2XKgel7t0zYKEh9xmZqCctsjMoAkBncwtABRv94M/E5hu9LLKnRo81Vrdbx4G
         9IaA==
X-Gm-Message-State: AOAM532xtFsGhWFKUBzWUHGgevZOqKSrdHI0tQJIQU4YR9aeT5ZFvk/n
        XBUrm+5xPFHV7Eq/hBcL++g=
X-Google-Smtp-Source: ABdhPJxJk8T85hwOVfVjS0XWnFK0/rvXThAoaYy5jAyF+4dT/D0sNZH+aAJc7/fNjBpkY1l846JyEQ==
X-Received: by 2002:a05:6512:34d3:: with SMTP id w19mr8452924lfr.418.1605075303375;
        Tue, 10 Nov 2020 22:15:03 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id j19sm118257lja.100.2020.11.10.22.15.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 22:15:02 -0800 (PST)
Subject: Re: [PATCH v8 02/26] memory: tegra20-emc: Use
 dev_pm_opp_set_clkname()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20201111011456.7875-1-digetx@gmail.com>
 <20201111011456.7875-3-digetx@gmail.com>
 <20201111054541.hstqrlvtpwxxbv4m@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <dcc85e86-0660-03ce-a4df-d40dbf77e570@gmail.com>
Date:   Wed, 11 Nov 2020 09:15:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201111054541.hstqrlvtpwxxbv4m@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

11.11.2020 08:45, Viresh Kumar пишет:
>> +put_reg_table:
>> +	if (reg_opp_table)
> This won't be required after my other patchset and yeah it is a
> classic chicken and egg problem we have here :)
> 
> Maybe you can fix them separately in 5.11 after everything is applied.
> 

I already prepared patch in the "core voltage scaling" series that will
remove this code.
