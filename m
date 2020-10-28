Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A218E29DE75
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 01:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgJ1WS4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Oct 2020 18:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732284AbgJ1WSv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2020 18:18:51 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DF9C0613CF
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2020 15:18:51 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id w21so620954pfc.7
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2020 15:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cfgFzKKhNnMi/GMVV82Uo8k8bscPVazRnoozeWTLycw=;
        b=rS+WVklmfAY6KhDUrbki4jt4B18LTB6p22yrLLmnk1UDDko9AbIk1TGEZWZlhqIivC
         zCU/ojARnMEbsZz7jLseoKhAWaCVUBiQBqiG10bmzVWXbEJeO5wddw/YKCkvJZrQ5cDL
         64XYdYSl6oBTARNV2zP0QvbVXEb3SNrX5EznPJZK+sPRpxJ2iiAmR6VCPX/nVsNfr3b2
         gA01p83XGuwkO/GQqc7TsoG4aedAnPeq+5XK+Mi0Aqy9CKyq7U7WchIYEap71a6n2oZ9
         0KVdoQpuYBvGradBQMMXowW1jSaXt3ejdLogjwP4DwIJhD+DNJOE1N59Xkx+E1WTiINF
         YXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cfgFzKKhNnMi/GMVV82Uo8k8bscPVazRnoozeWTLycw=;
        b=j0oaPDfH/HwhMRTn0s+r+RPJmuJ/+9REWJv01scrVBJRuo/jBFK/rW47uTIrZi9YNt
         ulPSjHBoixkxBAJ8N+Y8rNjpIFXBghLKZVgaLLpwTCY7fGOV0up4w4FN1ePf6gLcrPXk
         Gp5+ateF4ZoKnuUHC5BoFnM5wKa+Bt5/EA2/V8We6xPBmYV0hrvd/EdUYEZTf9X/JBoe
         hLvlJK+LOcf12anHnS+kr2HHRP9BjoVoxEcfKgRWrsjCn12zz5H4Njx2CAhztcUnIQlw
         Pg34Ai/ALlFuw0z8B4lO1jTKY1qFJjIxxjio3c4RTbV/61swRqQdQKsmjSnfe6Y9ii2k
         j3mQ==
X-Gm-Message-State: AOAM531mipkvqVeKzu7jt39q1B1ruZSCee8R+0ZP2dXG69Uquc0WeVa2
        RsTbhTT66LuqF7Cr5ZRvqUyOhopHEKb9eA==
X-Google-Smtp-Source: ABdhPJxEyfjVX+9NzhgMjwDCbve9fGqcrs+hg+9fV5pCpQ6gtYvRjQy7s5mLW87vm46wmiqhAncEaQ==
X-Received: by 2002:a17:902:8341:b029:d4:e3fa:e464 with SMTP id z1-20020a1709028341b02900d4e3fae464mr5788637pln.66.1603858318187;
        Tue, 27 Oct 2020 21:11:58 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id u194sm2753541pfc.176.2020.10.27.21.11.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2020 21:11:54 -0700 (PDT)
Date:   Wed, 28 Oct 2020 09:41:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] cpufreq: tegra186: Fix initial frequency
Message-ID: <20201028041152.733tkghz4vnqz2io@vireshk-i7>
References: <20200824145907.331899-1-jonathanh@nvidia.com>
 <20200825055003.qfsuktsv7cyouxei@vireshk-i7>
 <09ac354e-a55b-5300-12ae-3f24c8f8b193@nvidia.com>
 <20201016040700.wzfegk7hmabxgpff@vireshk-i7>
 <9c37db70-9406-8005-3478-dc4a5e94c566@nvidia.com>
 <c6ab92fe-e5ea-4568-6457-7a28c8496114@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6ab92fe-e5ea-4568-6457-7a28c8496114@nvidia.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26-10-20, 12:57, Jon Hunter wrote:
> Thinking about this some more, what are your thoughts on making the
> following change? 
> 
> Basically, if the driver sets the CPUFREQ_NEED_INITIAL_FREQ_CHECK,

This flag only means that the platform would like the core to check
the currently programmed frequency and get it in sync with the table.

> then I wonder if we should not fail if the frequency return by
> >get() is not known.

When do we fail if the frequency isn't known ? That's the case where
we try to set it to one from the table.

But (looking at your change), ->get() can't really return 0. We depend
on it to get us the exact frequency the hardware is programmed at
instead of reading a cached value in the software.

> >This would fix the problem I see on Tegra186
> where the initial boot frequency may not be in the frequency table.

With current mainline, what's the problem you see now ? Sorry I missed
track of it a bit :)

-- 
viresh
