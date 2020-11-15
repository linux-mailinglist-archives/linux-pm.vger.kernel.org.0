Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805342B3335
	for <lists+linux-pm@lfdr.de>; Sun, 15 Nov 2020 10:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgKOJ0H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Nov 2020 04:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbgKOJ0B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Nov 2020 04:26:01 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2026C0613D1;
        Sun, 15 Nov 2020 01:25:58 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id 142so2482267ljj.10;
        Sun, 15 Nov 2020 01:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1l1hwffIjqjNt9GhUbePPVmTyJTeUW4Yv+243TWcPf4=;
        b=lieK4LR33y1aZ1fap+D73ZumMoVL6M6468po+NR+gyGMCEQBUSJjgqTFMr6hER6WfB
         U/oEFvAuY+SrclwCLNpGUMrex3vA1wy59VOYYk7fZNpc57VlEVHtj6RKqpsAn80oM0Z2
         Mo+p0cSbnAnQGOau+OjoIyQFeCcrmmveBOMzHv5D/OCZhYZtF4Tc7TZgEQxqouMcvULn
         9V70vXKnmnjwHw412JpQiKAtzWYPr4LXwz6zZqCPP36mY4krJyjfujSJAeSH3zHMtpDB
         o+DUoAUq5Ry6GcotqKtVg31Q+MvRKmZQQ9QT2dV0mpmKH/sNPWbmqtXHpi8uf6Fg+n+S
         RYbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1l1hwffIjqjNt9GhUbePPVmTyJTeUW4Yv+243TWcPf4=;
        b=SdD6p+Ar91ILLUhDGtYxHPjsUmZta53CyFBAgeiQuh2mjSwIdAOq3W8Ied7kXR0lRE
         y9OIfQWMaey/5muFC4hW1CKjsORcosLl4Vkq3USEMqNdBRUbaLtxvA6nZaCAB6Lu20xp
         3BO2IeKKRuCFTkfXE4NVGX4exxPUjqis2KTft7+pRyKUZ13f2ma7ZaNdIbXfscfA86tV
         6FddSHaj+VNWsmYEKJJ330F84DRRjdJQ7ic+6MxUBvzeEevEEBWHHy/UMSeyA9QidRkL
         RdqsAS+5cNVJnpNFXphShpN7dmb8cATAZBBgsNkFNB+3JU4ZCke/IcQJiYd64BRgbKgN
         Z8+g==
X-Gm-Message-State: AOAM533VpKif+RzGR2zmty2Ebp7d+NAy5k/eLinxbMml3lBr/blb1cdo
        kmBMztWTB2Lqr8/eWhGdVZM=
X-Google-Smtp-Source: ABdhPJx1nXm+/KmGOYLgm50Vcu3V6KYIGD4YCXPL3AWVXb0ez8GMZN7O40WHA127zZg9J7ACD8dKCQ==
X-Received: by 2002:a2e:bc1a:: with SMTP id b26mr4226326ljf.359.1605432357253;
        Sun, 15 Nov 2020 01:25:57 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id j25sm1170497lja.98.2020.11.15.01.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2020 01:25:56 -0800 (PST)
Subject: Re: [PATCH v8 08/26] memory: tegra30-emc: Continue probing if timings
 are missing in device-tree
To:     Krzysztof Kozlowski <krzk@kernel.org>
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
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20201111011456.7875-1-digetx@gmail.com>
 <20201111011456.7875-9-digetx@gmail.com> <20201114154227.GB14208@kozik-lap>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <90201243-b31e-29fc-a3e6-337f78afa9d2@gmail.com>
Date:   Sun, 15 Nov 2020 12:25:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201114154227.GB14208@kozik-lap>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

14.11.2020 18:42, Krzysztof Kozlowski пишет:
> On Wed, Nov 11, 2020 at 04:14:38AM +0300, Dmitry Osipenko wrote:
>> EMC driver will become mandatory after turning it into interconnect
>> provider because interconnect users, like display controller driver, will
>> fail to probe using newer device-trees that have interconnect properties.
>> Thus make EMC driver to probe even if timings are missing in device-tree.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/memory/tegra/tegra30-emc.c | 29 +++++++++++++++--------------
>>  1 file changed, 15 insertions(+), 14 deletions(-)
> 
> Thanks, applied 1-8.  For the rest I see discussion on going, so I guess
> there will be a v9.

The v9 will be ready soon, thank you.
