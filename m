Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058DA2FF606
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 21:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbhAUUhg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jan 2021 15:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727696AbhAUHv5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2021 02:51:57 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC88C0613C1
        for <linux-pm@vger.kernel.org>; Wed, 20 Jan 2021 23:51:16 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id s15so812656plr.9
        for <linux-pm@vger.kernel.org>; Wed, 20 Jan 2021 23:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ppYqWAyvNKiPd/LTBNFn0qouIP/3Y6Q1DfN9sV48VsY=;
        b=h0lS53ZkB+GKey8kLUmj2tU59Up31sO8udeLACpcHlipl3iaRzEd9xz4Tv/Z+ccAfZ
         t3Eq+Lxg37SMRZ2qawcCgkGJ0hUjNvDfDvspgvT+bQtC/dzVesYambsgW2E2cCBrOHWx
         mWs7PlJT03dxD9QWqSie+h0AFX18eDZux1O1o20b8J2ETjQ7Sps3+34otgGpK1BEsH37
         bAHGToZZTtNwcJj2lAp9s58WTAgnsIs9U9PtVvBO8DKtnMYFxjnXb73nqNh1qd4F2/On
         XTDT8uBCYDkzrwZd+MVYZmSfjJ9J/LYjIWqNAjxQ3lrwz8EJevn+ZqyyhMhMt8Pvk0i5
         gtGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ppYqWAyvNKiPd/LTBNFn0qouIP/3Y6Q1DfN9sV48VsY=;
        b=COuVF8YXUJ2Ltbfn4s+nozd7/3pTuheCvFnPiYQC7p2Q6eqdmXLnA0DJHXq0H0r7qo
         2CWAovp+/eRhaulA6Hr+lit7r0Gdfrj030SSy+Kr9MuabNMsSwscGLnjn8DsosRXfnlx
         EJF2fd5v1iX2o8DDB1RpcUiFggrwVzA0EYLZONgMBHjJ9v7yQCF/eQBygEvel/o/lyAb
         LvhhxY24s7tmw2JIbbx89Ogv4li+GMUXSXWx0aWOYlRS36TKjA79X6QynaurBtkcWvod
         A4pFkhtJ84nKMhBFHr2Ht0JwRfIAPTDfWvET/i1MPcAbhUmDMaHS+nSFpYzpqX8sf1zm
         oeQA==
X-Gm-Message-State: AOAM531V0p8UQXWMgCV7OEpxDKR2EWb6DSzu3fLjzWHuyBXoj2rUH9bs
        pK4vTC58MDNMqx3oB5iVnCM+sw==
X-Google-Smtp-Source: ABdhPJz4j4GCwZMviV8tI6NKJQDIU/+Lr0p38D4zIJnPc9Vz8ACUF0DFCZ7/MjjZjY2Ua9dxHsSv4A==
X-Received: by 2002:a17:902:7684:b029:df:cfe4:6a06 with SMTP id m4-20020a1709027684b02900dfcfe46a06mr2194498pll.64.1611215475390;
        Wed, 20 Jan 2021 23:51:15 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id n3sm4853834pfq.19.2021.01.20.23.51.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jan 2021 23:51:14 -0800 (PST)
Date:   Thu, 21 Jan 2021 13:21:12 +0530
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
Message-ID: <20210121075112.jspo3klaewev6ger@vireshk-i7>
References: <20210118005524.27787-1-digetx@gmail.com>
 <20210118114613.fzq7nkrdfm53upkr@vireshk-i7>
 <1d17901f-6341-d278-f517-33d9c7aadf42@gmail.com>
 <af1044be-263e-0aa2-7061-0b217f94197b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af1044be-263e-0aa2-7061-0b217f94197b@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-01-21, 18:41, Dmitry Osipenko wrote:
> 19.01.2021 20:35, Dmitry Osipenko пишет:
> > 18.01.2021 14:46, Viresh Kumar пишет:
> >> On 18-01-21, 03:55, Dmitry Osipenko wrote:
> >>> Hi,
> >>>
> >>> This series fixes problems and adds features to OPP API that are required
> >>> for implementation of a power domain driver for NVIDIA Tegra SoCs.
> >>>
> >>> It is a continuation of [1], where Viresh Kumar asked to factor OPP
> >>> patches into a separate series. I factored out the patches into this
> >>> series, addressed the previous review comments and re-based patches
> >>> on top of [2], which replaced some of my patches that added resource-managed
> >>> helpers.
> >>>
> >>> [1] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=221130
> >>> [2] https://lore.kernel.org/linux-pm/20210101165507.19486-1-tiny.windzz@gmail.com/
> >>
> >> Hi Dmitry,
> >>
> >> I have applied 9 out of 12 patches already. Thanks.
> >>
> > 
> > Thanks, I checked that everything is applied properly using today's
> > linux-next.
> > 
> 
> Turned out that one minor issue was actually introduced, the
> devm_pm_opp_attach_genpd() lost the export. I'll make a patch to fix this.

I have fixed the original patch for that.

-- 
viresh
