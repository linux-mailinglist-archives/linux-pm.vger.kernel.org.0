Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1912F2AE8BA
	for <lists+linux-pm@lfdr.de>; Wed, 11 Nov 2020 07:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgKKGS7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Nov 2020 01:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgKKGS6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Nov 2020 01:18:58 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4627CC0613D1
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2020 22:18:58 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id cp9so456721plb.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2020 22:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Zz+u4O/ExV+I0XfrOYfMwrWHftV4MOlXgA3EL9hIHsg=;
        b=Pw4a1V3nK4X2DgxHAQTdRmNKbd1BmJuxzNI33tTM8sIXZTP8qajX3ww4DaPPdFo6Zs
         5K09iJmEHBSCQeWWkFgm1Kdw94Lntwqu29hIgeB9q5TcfhzffDjNRF91zjtINBTnbBau
         fTjqe//5KYelMUFY+/ziAiHibl5AyvjTV+nKbiI3UNVy4omo3Z0iw25Yu0f3sGCVv13Q
         RfsqZ11ODtWL/A6yfCI8eBLJ3ndC1X9lI1YrBO+uIvqt1xHD4VEkDElC5Txxt+/arELA
         eTxq92w5zzdCAnEdx70ezELIxdZfJQKNBEMXwxTWa1u/BMYHRGpcWR9hIm0FaCV9vG3f
         IRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Zz+u4O/ExV+I0XfrOYfMwrWHftV4MOlXgA3EL9hIHsg=;
        b=cKWrlr0j3GshW5Z20QYzD5VYe5tRgey/F0X5FplVGTbwGJUDj9RX7/6SS8TmnZKOxI
         T4EEOqVO4WJC2bpGZ2dQ6rGxSRMs2jWKyau1b1q0vMi+0BV1kSsc8JrF/uAJItZ7yXAg
         wzhUTXUE4jeDcAtq54bNJM5PoweY9i6FnoSKmOoWvxW830tujkQAfcckmx7JmFymYnMF
         jUZZYn9wmtoP2Ni+w5vkhAMEu3XEK1sxeGdCe0pqRLNQfYFv6okX7Nk2+4Z4qMN1QJ4s
         6b3+ogSfx7xIBoIDpi+FaJNvDCW4ByaTh8W6De49Ao5p6awa1/++3o8YJIyLaSm+rIpx
         eA4Q==
X-Gm-Message-State: AOAM530ubk15+OWTRSqcPzggOVW5Ivie33mYtQIaKNK9Zf7RPtAfCJJQ
        CG4pgIPgWjNt3bh9yMqpMqamTA==
X-Google-Smtp-Source: ABdhPJx2Np21K4nEJMcurse4ukZe7jVo8P4Kg57gCpQvT0frJjcTL8LmeWw4PX37zBAzAgIYqahjpQ==
X-Received: by 2002:a17:902:59cf:b029:d7:e216:9260 with SMTP id d15-20020a17090259cfb02900d7e2169260mr11119815plj.74.1605075537774;
        Tue, 10 Nov 2020 22:18:57 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id j19sm1091459pfd.189.2020.11.10.22.18.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2020 22:18:57 -0800 (PST)
Date:   Wed, 11 Nov 2020 11:48:55 +0530
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
Message-ID: <20201111061855.2azilyhfoxwzpoir@vireshk-i7>
References: <20201111011456.7875-1-digetx@gmail.com>
 <20201111011456.7875-10-digetx@gmail.com>
 <20201111055313.tefidnmc7f4yb3jk@vireshk-i7>
 <185e9140-fdce-29ef-68c3-aa7da02b249d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <185e9140-fdce-29ef-68c3-aa7da02b249d@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11-11-20, 09:14, Dmitry Osipenko wrote:
> 11.11.2020 08:53, Viresh Kumar пишет:
> >> +static int tegra_emc_opp_table_init(struct tegra_emc *emc)
> >> +{
> >> +	struct opp_table *reg_opp_table = NULL, *clk_opp_table, *hw_opp_table;
> >> +	u32 hw_version = BIT(tegra_sku_info.soc_speedo_id);
> >> +	const char *rname = "core";
> >> +	int err;
> >> +
> >> +	/*
> >> +	 * Legacy device-trees don't have OPP table and EMC driver isn't
> >> +	 * useful in this case.
> >> +	 */
> >> +	if (!device_property_present(emc->dev, "operating-points-v2")) {
> > I don't understand why you want to check this ? The below call to
> > dev_pm_opp_of_add_table() will fail anyway and that should be good for
> > you.
> > 
> 
> The dev_pm_opp_of_add_table() will produce a error message which doesn't
> give a clue about what's wrong, i.e. that device-tree needs to be updated.

If you think that you need to print something more, then you can do
that in the error message you print when dev_pm_opp_of_add_table()
fails. I would suggest to drop this redundant check here.

-- 
viresh
