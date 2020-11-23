Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89AD2C001F
	for <lists+linux-pm@lfdr.de>; Mon, 23 Nov 2020 07:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgKWGcP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Nov 2020 01:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgKWGcO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Nov 2020 01:32:14 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A14AC0613CF
        for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2020 22:32:13 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id a186so14016884wme.1
        for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2020 22:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=cvoVqwP9FE52rvFYms7Y+WcvtyD/16/j90QsV7N1aWk=;
        b=xbRF9fS5clfnIPpqfycFtmWKqkeQgkcTHmz41tiQsJghMhZkvIdgBAPvw0T3BXSA4I
         wV3Q/ntGbWkU8zpZ9heYLLMcLsHqFKKmSqoBnzkvBSDGoNJA91LlKYGzEP25u3NQF3QB
         AivQoi1x7qkh9O1LRv+4sWnBn4SvV5o/8m90JmW7oA9ZLgw8PTzUp2epvQbGiBciQtVq
         1nBVi64/QS2RAHBg5pyr15f/p7i1uqIms5dwWdfDdU25n9vNbp299oBH2IqkkTO0cDx1
         UJC3P8LeWo+IqZuJLsQ8UpHhv+M2yxn7CD9mgGWviZO1w7WI2U/islls/qAJUAon2DrE
         J/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cvoVqwP9FE52rvFYms7Y+WcvtyD/16/j90QsV7N1aWk=;
        b=M6YFEP6hf+akJ7gMIk1NKqYYcarLeXTUf2J7XqiqlPqcSgDjZQqLxqJlD2xIfbCk0y
         +RgmaS9e6m5vhjwF8rjAasxdfJkoLOF2lc5uF+3GC4X5fmFWHnvIo1MLCfaU4bAskLN+
         MOfnPBd24GirR/r3yDww6Retys8A9TDkigULKSn5IeOqeE9JschfUwX4OVfUWEffPn4f
         0ZZS+l+laALMaIlZ9tIqguV6TJ3xE0+6xQOwIbqXz0I/9U6Indy3re74g1ccqinD5a1m
         CfNOHz/wphRcLksabomn3QGa/kIP4MczqS7Ushnlo3tbjW6G5+J075A8ANm8/Nb1r7+e
         BpYg==
X-Gm-Message-State: AOAM533wtJZNExuKDm8ovP8VyKkltkSU6oxlesG0/gc/wyxiYWizB3kT
        pXqdUD9F39BGgUYNlhDElzu5lg==
X-Google-Smtp-Source: ABdhPJwTKWks2V4u6Zzj4GGmt0mUu9p9zEiVEx7S7M5Igkq/WpJwqdS3vmhU4wIkWy4oSAnhkJUiDg==
X-Received: by 2002:a1c:9901:: with SMTP id b1mr21807743wme.18.1606113131688;
        Sun, 22 Nov 2020 22:32:11 -0800 (PST)
Received: from MacBook-Pro.local ([212.45.64.13])
        by smtp.googlemail.com with ESMTPSA id a144sm15756349wmd.47.2020.11.22.22.32.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2020 22:32:10 -0800 (PST)
Subject: Re: [PATCH v10 03/19] memory: tegra30: Support interconnect framework
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
 <20201123002723.28463-4-digetx@gmail.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Message-ID: <109bc617-f7d9-8635-3db1-3f4869b32f4d@linaro.org>
Date:   Mon, 23 Nov 2020 08:32:09 +0200
MIME-Version: 1.0
In-Reply-To: <20201123002723.28463-4-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Dmitry,

On 23.11.20 2:27, Dmitry Osipenko wrote:
> Now Internal and External memory controllers are memory interconnection
> providers. This allows us to use interconnect API for tuning of memory
> configuration. EMC driver now supports OPPs and DVFS. MC driver now
> supports tuning of memory arbitration latency, which needs to be done
> for ISO memory clients, like a Display client for example.
> 
> Tested-by: Peter Geis <pgwipeout@gmail.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Acked-by: Georgi Djakov <georgi.djakov@linaro.org>

Thank you for the continuous work on this patchset!

BR,
Georgi

> ---
>   drivers/memory/tegra/Kconfig       |   1 +
>   drivers/memory/tegra/tegra30-emc.c | 344 +++++++++++++++++++++++++++--
>   drivers/memory/tegra/tegra30.c     | 173 ++++++++++++++-
>   3 files changed, 496 insertions(+), 22 deletions(-)
