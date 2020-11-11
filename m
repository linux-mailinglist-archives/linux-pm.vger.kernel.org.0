Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54A82AEA5A
	for <lists+linux-pm@lfdr.de>; Wed, 11 Nov 2020 08:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbgKKHyH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Nov 2020 02:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgKKHyG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Nov 2020 02:54:06 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7922AC0613D1
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2020 23:54:06 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id j5so559337plk.7
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2020 23:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=BR1T4epV+HHBrX5I3Lx7g9aCKzjxl36+gayU6Vo90zk=;
        b=SeyOkpJ8VAnb9K1v6QHwyuE+XDQ7Xb5qgsNsN17V6pSCy+q1aUZltHVrwUB6hoVNUJ
         kyi1hz3GZB0PUzYnYm5NHuDH4DtZLQ6r7LinuCTWmBnv++Pcns6Z44NLADK8nCUPq+2Z
         lUAZJJD/ofBTydNaZsP70StUTV3P14W4YTnOf2MmHlIO00RSoHGw/LnoMgUFva/t02jt
         Cq7ItmcBBwiJsCiFGCnQ6OwdXO7K2pdOTRCxVVRlJlC9Ivp6OLV2wqZm0q7JGzPRVz7B
         ewCJe+iAbFC6PK7GZk/6Vnj4udyUn6bTmvaD+GiJHFydjtBRGzYuyAAJkgFvEKUueX/h
         fT3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BR1T4epV+HHBrX5I3Lx7g9aCKzjxl36+gayU6Vo90zk=;
        b=NJlri7lQyRMK1udtDG+u82YBqFBquvf/8LgQ6wAcUiWhf/bbOTinwbmbvFu4NisPNR
         sdbiOcSSSoEUrxhOxy4zy0WDlW/+gCj1vcXXO6gx+TPWm5mx4Ab2h7TY3djz80WuQwcq
         ly8bsOgoWXF/JbPcfBSwHvbLbhvFZiY7NifPFPKuZ1sOgQDomw+pvRo6ozFEvrx7E5FJ
         bVbUwgdtCNNLGGr+Otutbn4oCVhDcMMhD4lbtmd0AQo9nZ8XjJoOX6EUhH+LSqjMYcOI
         4Zw01O3qqiCLd89K3DZ404lJKZAR3rHraqa/QdDAHNIAMF5WG9F/I9/fW8pI5o2VKDcU
         HS9w==
X-Gm-Message-State: AOAM530bM1XTKaItiiWMX5IcXLSDp2/USqpeEKVHCbee8XqIN7egBM9a
        6cvAQKq09JMJwHRXr4IgPBHVxw==
X-Google-Smtp-Source: ABdhPJxOHg/sWON4ePkTuSAP4y8SzDQlWRi72cjAP6aV88j0N4jbC+I/d/e9bu0uQlLakGN5MNj7pg==
X-Received: by 2002:a17:902:82c3:b029:d6:c377:c87d with SMTP id u3-20020a17090282c3b02900d6c377c87dmr19915711plz.37.1605081245903;
        Tue, 10 Nov 2020 23:54:05 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id v18sm1450609pfn.35.2020.11.10.23.54.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2020 23:54:04 -0800 (PST)
Date:   Wed, 11 Nov 2020 13:24:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
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
Subject: Re: [PATCH v8 09/26] memory: tegra30: Support interconnect framework
Message-ID: <20201111075402.y52c2zwcw74eeyko@vireshk-i7>
References: <20201111011456.7875-1-digetx@gmail.com>
 <20201111011456.7875-10-digetx@gmail.com>
 <20201111055313.tefidnmc7f4yb3jk@vireshk-i7>
 <185e9140-fdce-29ef-68c3-aa7da02b249d@gmail.com>
 <20201111061855.2azilyhfoxwzpoir@vireshk-i7>
 <7f5c15c6-44d2-c997-442c-8f6670794f0e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7f5c15c6-44d2-c997-442c-8f6670794f0e@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11-11-20, 10:32, Dmitry Osipenko wrote:
> 11.11.2020 09:18, Viresh Kumar пишет:
> > On 11-11-20, 09:14, Dmitry Osipenko wrote:
> >> The dev_pm_opp_of_add_table() will produce a error message which doesn't
> >> give a clue about what's wrong, i.e. that device-tree needs to be updated.
> > 
> > If you think that you need to print something more, then you can do
> > that in the error message you print when dev_pm_opp_of_add_table()
> > fails. I would suggest to drop this redundant check here.
> > 
> 
> Please give the rationale.

The rationale is that the check is already performed by
dev_pm_opp_of_add_table() and it isn't going to add *any* benefit to
check it again here. Such a check for matching compatible platforms is
normally fine, but not for this. This is like open coding part of
dev_pm_opp_of_add_table(), and so is redundant. The
dev_pm_opp_of_add_table() helper also checks for OPPv1 bindings in the
DT (yes you won't be using them on your platform) and so relying on
that API is a better thing to do.

As you already said, you just wanted a better print message and so you
have added this check. If you really care only about the print
message, then you can add a print of your choice in the driver but
otherwise this check is not going to benefit you much I am afraid.

Having said that, this isn't the code I maintain. I need to guarantee
that the OPP core APIs are used properly and are not misused and so I
have a higher say there. But in this case all I can do is _suggest_
and not enforce. And as I said earlier, I suggest to drop this
redundant check in order to make your code better and faster.

Thanks.

-- 
viresh
