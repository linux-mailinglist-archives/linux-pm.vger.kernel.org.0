Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D060D2FFD73
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 08:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbhAVHf0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 02:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbhAVHfY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2021 02:35:24 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F307EC06174A
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 23:34:42 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id g15so3149984pgu.9
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 23:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m4wnAXhlfjJBWJNmbaSJ7Cl4CoNWSqMxCn3MzV4rG1c=;
        b=K6+s2/k9aBt85dRhwCJnrKvowSbu1kUeq14PcOQBLsXD0mrvcABsrVgyUoBLw4kO74
         T61LHFlMUCItc0DK4qdjl3H0aFirt9POMw/etpLiYycEQwHZF1PJK/vyva0e4X3QYH0T
         sRQeqxuoKR8GJ4qNtbzP6Tt09jw3nsjHMhAU76cnXqCjpOIfp3rYVdDD6v+w0cdod/jP
         8R2TFK/9+xvgjS8dGnF6Oh0WTI42OFGDIZE0CvgvS5MrluxrfMdZyaI40CKr3NG4pQb4
         GsqlkohGri3qQkLsVz9REu9FoVdHZYmn8I2CwX+168SfZ/rSBTG8By1/+OaBmCBvy9c2
         BCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m4wnAXhlfjJBWJNmbaSJ7Cl4CoNWSqMxCn3MzV4rG1c=;
        b=SmZ3rMaiaJv/hvI87rNc8H4Bsx3hgz3YyKzirJkzqhhUC7ixLYT6aEq0Z1g4tbM//p
         A0uf+IPrPm3FnXq/hZpKl3W0mSb2CrkogWxmOt4mg5c1sdKSoeChx+8tmhdeq7ASXwGL
         bISTWje3RLQHbdRr65oEFy3+14vRZR87DFrFtmXOMmcnaosRrylpD/JNE52oBng5CIBt
         3nr60GoIQRyD6f3hCjOU3Hb3jbgS2A0inWAmaEzrYiIEd/9Ry27Dh6qKI+cgf5ddcBh2
         GvGTlQ+tRx8zxVyXgUu5JpOJcrCWhVGpIV4PslgwcacGmdWd5TLL8urBoANvk76ttI7o
         uaAA==
X-Gm-Message-State: AOAM533Wvui4x0D4SsgNtNFomA4M5GhfLjFOKKpAk6vUqmco4vg4GoY/
        tneQiutkvrfIoFeJN6Dg7WjXkQ==
X-Google-Smtp-Source: ABdhPJwrZov901RmnoRYxt1gRsC0FzQGi+lpa84GXlgP2dFI5radIUoqWU1dy94vZk5WuWGyOsENvQ==
X-Received: by 2002:a63:7748:: with SMTP id s69mr3473901pgc.81.1611300882434;
        Thu, 21 Jan 2021 23:34:42 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id f22sm7959177pfk.179.2021.01.21.23.34.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jan 2021 23:34:41 -0800 (PST)
Date:   Fri, 22 Jan 2021 13:04:39 +0530
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
Subject: Re: [PATCH v4 0/4] OPP API fixes and improvements
Message-ID: <20210122073439.yadzqwodsyscl2ac@vireshk-i7>
References: <20210120222649.28149-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120222649.28149-1-digetx@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21-01-21, 01:26, Dmitry Osipenko wrote:
> Dmitry Osipenko (4):
>   opp: Export devm_pm_opp_attach_genpd()
>   opp: Add dev_pm_opp_sync_regulators()
>   opp: Add dev_pm_opp_set_voltage()
>   opp: Make _set_opp_custom() work without regulators

Patch 1 and 3 aren't required anymore, I have applied 4th already.
Patch 2 can be applied only after the dependency patch for the stub
definition gets merge in Linus's tree. I see that Mark has already
queued that up in his for-5.11 branch, so it might be part of next
-rc. I will apply 2nd patch then.

-- 
viresh
