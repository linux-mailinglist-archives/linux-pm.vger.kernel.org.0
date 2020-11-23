Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A796D2C0021
	for <lists+linux-pm@lfdr.de>; Mon, 23 Nov 2020 07:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgKWGdM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Nov 2020 01:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgKWGdL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Nov 2020 01:33:11 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925B4C061A4C
        for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2020 22:33:11 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id t4so4491760wrr.12
        for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2020 22:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=bA6PxX8QLzsGPO0mHBN+3Dtvap+C8KIb1Z8Udw0nO2Q=;
        b=dWLZqofKsdhEgABif3Bioetz8qih1qcB80fqacMhJo3qbRlmgvkSjpf6KfOnapZooC
         XkowLImJFECW49B/96Na1+iiQILiX339zOB9wPpVpQDC5DBYTsboBByQ1HfKYJg+o8LD
         CkaxrP/J0mgb7TYTF9Aan+MwAfRu68XJ9cQoEHzUwvGpVq5MyCkZyM9MgstYMeZifXda
         +PdO08Q3Q2Qvy82Z4zlD1IjzS2e3VdNmCF+McBtr1esqW5YHW7rBOO3khdGd5lbZvwo7
         pgkiLIGXoUHWGa/z6YUu2svO38+07/OlvlO0gIhuv9cmtUJgH/moRnI83yALB50jIUGw
         Ufiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bA6PxX8QLzsGPO0mHBN+3Dtvap+C8KIb1Z8Udw0nO2Q=;
        b=Kp1rtJgzEBNW4NR06XvAWY0KrgdLYVroOvdXe7dyupXkP4uhGZgLWhxkmnsL9HN/3I
         weORDy8Ve7bKmHkGiYdYXW0JRtJKH8RUhXvE9Wa5QucjiAIlId0aSF6eRuFOh8vc8sC8
         k1LKROz7RhUMIzlp2IHt5K39kwyvfhh5zb4tjsP/jFsmx/cuDGQnwXa6BhehRZYgxx+N
         rB56lOkmzYA0EM/z7ZKyst+9aqLYK9GXJbhN4w1CWhDUsezrj/JkhVsx/xVDKiLdUpBz
         CF7PcyebtgX//oH+6vmQ+KzNcm9QDgJV3SNdn4yT73hC9U3Te7Iv6AgSUUfK4zynNKsI
         05ww==
X-Gm-Message-State: AOAM530cO3K+D4dVqnXEwAJfQsk3suGAFVO67OCHXS6lh5PB3lx3fKBN
        1ztdj2crcAlUXaRix21hjCMkIg==
X-Google-Smtp-Source: ABdhPJxj3l+5ygzvJnGvao/pLWVRCcUon/irO3mlsfmWiGjI66Lp7ac+52xe4O+T97k2/Htaikrpsg==
X-Received: by 2002:adf:f24a:: with SMTP id b10mr29509390wrp.352.1606113190342;
        Sun, 22 Nov 2020 22:33:10 -0800 (PST)
Received: from MacBook-Pro.local ([212.45.64.13])
        by smtp.googlemail.com with ESMTPSA id l23sm11165881wmh.40.2020.11.22.22.33.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2020 22:33:09 -0800 (PST)
Subject: Re: [PATCH v10 06/19] memory: tegra124: Support interconnect
 framework
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
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
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20201123002723.28463-1-digetx@gmail.com>
 <20201123002723.28463-7-digetx@gmail.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Message-ID: <8871a6d3-23da-01e2-18b6-b0dcd4df1a54@linaro.org>
Date:   Mon, 23 Nov 2020 08:33:08 +0200
MIME-Version: 1.0
In-Reply-To: <20201123002723.28463-7-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23.11.20 2:27, Dmitry Osipenko wrote:
> Now Internal and External memory controllers are memory interconnection
> providers. This allows us to use interconnect API for tuning of memory
> configuration. EMC driver now supports OPPs and DVFS.
> 
> Tested-by: Nicolas Chauvet <kwizart@gmail.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Acked-by: Georgi Djakov <georgi.djakov@linaro.org>

Thanks,
Georgi

> ---
>   drivers/memory/tegra/Kconfig        |   1 +
>   drivers/memory/tegra/tegra124-emc.c | 320 +++++++++++++++++++++++++++-
>   drivers/memory/tegra/tegra124.c     |  82 ++++++-
>   3 files changed, 391 insertions(+), 12 deletions(-)
