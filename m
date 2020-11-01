Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259022A1E7F
	for <lists+linux-pm@lfdr.de>; Sun,  1 Nov 2020 15:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgKAOMq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Nov 2020 09:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgKAOMp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Nov 2020 09:12:45 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B348C0617A6;
        Sun,  1 Nov 2020 06:12:45 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id v19so7172416lji.5;
        Sun, 01 Nov 2020 06:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=REz7RPg2i02sVn5unh+ejD4RRDVKEN7sf6CTpP8ALEc=;
        b=XIySwbqwwWK+H07YdaRn27fLru1bo4Dez13BPQ7ix6EB/sGw/tnwV+eIYqXBMG1iJQ
         eNxQuFSPTOeShlcgCkryhP7JQEUKAOQ3ACRMWDC+JK1/ULlD50xlY3vVtToswKJRFnTB
         LHN/C8X+aO6ALXRC3oVmNfNewiaIj5Qq7DzFimDqgYV/yYp+EaLc5HPz6T/K/KoUdu7W
         rmO6ibHNbvVBiR52XOepxbf8DsFmORuPprPmJtOzbuV37SaJmwlZKeQ1bTjOB1EsAdaj
         vJx/5Feo9XftQF6H6Od7OKSsnFPww6gcKhFcleg0OsBo2beMyoNoYOYTEL6D4n5Uq/LN
         RYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=REz7RPg2i02sVn5unh+ejD4RRDVKEN7sf6CTpP8ALEc=;
        b=i9Iqe7dCxWjDBxC0wmPXJIwIiQ1LmDnvO56pSLlN5hWkTaAxrNBM4oiD3TG4/Pp/SO
         Po9pup2K2IV4a5eFUBKxQqDVv7zgHR39ZRREoFICRlZCCdK45ucocWMFWhbPYFQLAxcF
         /17StgZr6c1vHWsCX1bpFxPvS6RBscRtzXT7uX0BnRtRyK2hZlTU8/hIha2inq/Y6/JU
         thn9LCa1ZHf8dwg305ejyQ+z3/ggdX2ku6c+PMPq+m/rzPyv+afuaVZYR9mdDEOblQsS
         s2ThgseC9RSwJ89nwOY1Hr/fOpbYL3TaTEQYfVHk/pQrQOxHFW4OsykXttqlsWKjxwfj
         vsWA==
X-Gm-Message-State: AOAM530U9FbfVNEp0bMVJ0yQV+p18RQ0FpSe9rFhX40UV013romLvioT
        6KQixKcyi9f7C9Gtzwpu/ZJTyBeVjEc=
X-Google-Smtp-Source: ABdhPJxhAHCxnZhPTqKRzzn3oyVPFxXaMw4VchPE5jombOYQPEfMRZfjVrf1wOOg7FNtEz7hvm2v0A==
X-Received: by 2002:a2e:8145:: with SMTP id t5mr5051440ljg.311.1604239963242;
        Sun, 01 Nov 2020 06:12:43 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-177.dynamic.spd-mgts.ru. [109.252.193.177])
        by smtp.googlemail.com with ESMTPSA id a11sm1425557lfi.305.2020.11.01.06.12.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Nov 2020 06:12:42 -0800 (PST)
Subject: Re: [PATCH v6 49/52] PM / devfreq: tegra20: Convert to EMC_STAT
 driver, support interconnect and device-tree
To:     cwchoi00@gmail.com
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
        linux-tegra@vger.kernel.org,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-50-digetx@gmail.com>
 <CAGTfZH0KxyZYLZ_AgM7Lr+4s35kaWJp1AenpZ-o_FRLCCHC+6A@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0ffa84f6-625e-807c-e9af-7a67f0fe48e7@gmail.com>
Date:   Sun, 1 Nov 2020 17:12:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAGTfZH0KxyZYLZ_AgM7Lr+4s35kaWJp1AenpZ-o_FRLCCHC+6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

01.11.2020 16:31, Chanwoo Choi пишет:
> Hi Dmitry,
> 
> This patch contains the three features as following:
> 1. Use interconnect interface for controlling the clock instead of
> controlling it direclty
> 2. Use EMC_STAT instead of IMC_STAT
> 3. Change polling_interval and upthreshold for more fast responsiveness
> 
> I think you need to make the separate patches for each role.
> But, if it is difficult or not proper to split out 1,2 roles, you can
> make two patches for 1,2 and 3 roles.

Hello Chanwoo,

We will probably move the Tegra20 EMC_STAT devfreq driver into the
memory driver and remove the older IMC_STAT driver in v7, like it was
suggested by Thierry Reding. This will be a much less invasive code change.

> Also, if you want to get more responsiveness, you could use delayed timer
> instead of deferrable timer by editing the devfreq_dev_profile structure.

Thanks, I'll try the deferrable timer.
