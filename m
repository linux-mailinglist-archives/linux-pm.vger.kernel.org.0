Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5202FE065
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 05:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbhAUEJV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jan 2021 23:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbhAUEJK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2021 23:09:10 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4570C0613CF
        for <linux-pm@vger.kernel.org>; Wed, 20 Jan 2021 20:08:29 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id g15so518712pgu.9
        for <linux-pm@vger.kernel.org>; Wed, 20 Jan 2021 20:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X4Jw/E+MtQCCTnL+PGuuK0p7Rc+43AmkTUUI5e9cfl8=;
        b=zNayIhusqeaJcQKJoNACth9N6WIAptS33FTJhomoi5rFhdlCG4d3T63nrUWB2tTHVC
         lWi7KXdFnO0nXBbBVghWQjlANtXi1z79PkIeDAi1VkBwIbgG1/SSc2QTDgTUxZggeTbT
         ZhyW84SuqbzH8Zr9pUCUW8rqgb9YtgOcGfddOuCAI7cRbsLkEDq7gjuE6+0QTb8cDOOs
         qm9cOa6Vf4NzBN/x7g5Wz/KoKYozCfulX++avvbOu5a07qXNTUsnojSE3j89VFxzE6eH
         Vj8beYYR8bgec4BVA6sM434V20kxQM/tEi6+cn0U7+l7yzbuf6tEbaJLUaV10f2pKQfQ
         7Zpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X4Jw/E+MtQCCTnL+PGuuK0p7Rc+43AmkTUUI5e9cfl8=;
        b=ILmUM7d/UlddawDCyeJ5anQE15sznO28VYOw0dFHH843lB0zkhH6snp5dwOTQ2t8fK
         K5CgbZIXKTIjXZRrASLiq2f0NSKGXFLpfb/ZetOdTgvf2dRfBB9Vr+cxhgru6Dn72SYL
         Elk0lQTBxTAWg8BC89A7A6NXgJEiKyp+gjSnEu7StZyAIQl5XkVge0TvJKA/IdrAEGbJ
         yy9RYCQR76pAfWJ7pHkbaeGcpxMwLDza308t4E6AgjC6VWWbE2l5HUGgk2IJIE/k3WDz
         t9IPculg5glpV9bcsTmVFzW3L+x12bNu+im0Kj1VBhsFxu6OiHLaR+Bt8S0d/x3KReZ8
         7peg==
X-Gm-Message-State: AOAM531S8inK16svz0GE3LX90k/yYxs7xAvdyvfZViUfes8VZsFAMrmS
        lRjfLJe+Dv55bIpFJwxtkNR3yg==
X-Google-Smtp-Source: ABdhPJytsWhRYcWkltf5/Tc9Fp63GWINBFAh/gZQi00WIv4gQiwq3VmsZi6nh+YyCfv8eBHuYPnT+Q==
X-Received: by 2002:a62:64c9:0:b029:1b9:6b48:7901 with SMTP id y192-20020a6264c90000b02901b96b487901mr11809332pfb.0.1611202109309;
        Wed, 20 Jan 2021 20:08:29 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id 126sm3687628pfu.31.2021.01.20.20.08.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jan 2021 20:08:28 -0800 (PST)
Date:   Thu, 21 Jan 2021 09:38:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 1/3] PM: domains: Make set_performance_state()
 callback optional
Message-ID: <20210121040826.jsxdv24vxnobq45s@vireshk-i7>
References: <20210120211232.17299-1-digetx@gmail.com>
 <20210120211232.17299-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120211232.17299-2-digetx@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21-01-21, 00:12, Dmitry Osipenko wrote:
> Make set_performance_state() callback optional in order to remove the
> need from power domain drivers to implement a dummy callback. If callback
> isn't implemented by a GENPD driver, then the performance state is passed
> to the parent domain.
> 
> Tested-by: Peter Geis <pgwipeout@gmail.com>
> Tested-by: Nicolas Chauvet <kwizart@gmail.com>
> Tested-by: Matt Merhar <mattmerhar@protonmail.com>
> [tested on NVIDIA Tegra20/30/124 SoCs]
> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/base/power/domain.c | 33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
