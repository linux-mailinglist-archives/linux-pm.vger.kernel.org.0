Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B33B2F9EAB
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 12:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390832AbhARLsq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jan 2021 06:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390934AbhARLq5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jan 2021 06:46:57 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF53C061575
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 03:46:17 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id i63so2975655pfg.7
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 03:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gzlwaPkTlP/ZmJOY5fxJliyLPQaZ8STG1NZSoSJX0e8=;
        b=AMrcT41venp9oOMLrdEMRufFZ13OH9ME5n2x86QPk+pJHIuS38ApYkNDA66+piA1ZE
         gyJglzZ56sTOHHhoCMqkQhuFBbRj6o5Z6R330X1ZBwvlVrg12Vj1VCXbRG5WUz+en+Sm
         ZcNZFE4TcnZi6PkMNFaL/poXIVQd2O7oNVTXDBFeOXYXlbFqUjZyP0HIvwjc/197jQE4
         At3I4s1SBtF19Z8xVdvYn9Znk1CvC0GRfWQaNyCdFp4hTL4MJG+NZrkFBXSP5m8G8IS2
         EsCFtpsuTheyhw5l4K88KP27axqL1IWUaBB2UPxwWc9YAHUpk9ececnBa1yKbszkcVHv
         MiZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gzlwaPkTlP/ZmJOY5fxJliyLPQaZ8STG1NZSoSJX0e8=;
        b=ddaxxylQe5J+6Qp7uHm3VqTtsACdhULj0j1dE09JPHT/SFyFJeN23SVGOAmBSQqmtE
         Ku7emYVLIIwINCG5i1thd85kpSR+qvpZlhp8QfSx/g5W+wogGBCPltgmlb2Xo/SYM8io
         35slRwl4hnyzvPkrY6Jk9XFW8ChQbmm1hMMko8a9zTuRj8GFIZYp3VSbZtLp/wO7mpdU
         vvZiWb2sHGyQhOX4SUzF0JqoSPqvaHh7c9pTv/FOXzQdkLIEG3s4xe8JBdGbhD1tguHu
         x52ZZveRZTtqZn6HAWU+OgoVNzHuTv5T+15AqNxPES6/hktOhBPNeJS79Nu8btY8Owll
         if/A==
X-Gm-Message-State: AOAM532Tu/Vtq5YPQJsRvPr+ICIvCjgUDNgT8AyIJcfIqSS4WeQ2Rdkn
        kV7rBuAS8/RK+f+h7HLmUIpTjg==
X-Google-Smtp-Source: ABdhPJziOaaMILfmkjkhAuMyBMxzmMtTG6xMcp/+fEGOYCNqSgENDW5xJ+AakPLst9AI0D1btKh8ZA==
X-Received: by 2002:a62:4e12:0:b029:1b6:7eac:c740 with SMTP id c18-20020a624e120000b02901b67eacc740mr8044883pfb.65.1610970376621;
        Mon, 18 Jan 2021 03:46:16 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id d8sm11839722pjm.30.2021.01.18.03.46.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2021 03:46:15 -0800 (PST)
Date:   Mon, 18 Jan 2021 17:16:13 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 00/12] OPP API fixes and improvements
Message-ID: <20210118114613.fzq7nkrdfm53upkr@vireshk-i7>
References: <20210118005524.27787-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118005524.27787-1-digetx@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-01-21, 03:55, Dmitry Osipenko wrote:
> Hi,
> 
> This series fixes problems and adds features to OPP API that are required
> for implementation of a power domain driver for NVIDIA Tegra SoCs.
> 
> It is a continuation of [1], where Viresh Kumar asked to factor OPP
> patches into a separate series. I factored out the patches into this
> series, addressed the previous review comments and re-based patches
> on top of [2], which replaced some of my patches that added resource-managed
> helpers.
> 
> [1] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=221130
> [2] https://lore.kernel.org/linux-pm/20210101165507.19486-1-tiny.windzz@gmail.com/

Hi Dmitry,

I have applied 9 out of 12 patches already. Thanks.

-- 
viresh
