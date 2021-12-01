Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D304647DF
	for <lists+linux-pm@lfdr.de>; Wed,  1 Dec 2021 08:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347198AbhLAH02 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Dec 2021 02:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbhLAH02 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Dec 2021 02:26:28 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A42C061574
        for <linux-pm@vger.kernel.org>; Tue, 30 Nov 2021 23:23:07 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id gt5so17282997pjb.1
        for <linux-pm@vger.kernel.org>; Tue, 30 Nov 2021 23:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OuGAO91bT9scHZ+M1kNZF+Tb/U4vNWoZYvfq/f3IMVg=;
        b=csvqKVfNLrfpigEcYFqMdY40Jpcx70IZ0qYiYOa1GiG0JGDYuA4/WlFbwiL0jTitTP
         qR8fo1vLRKYA7+ms8tK/GAlIIg71gwGM8fLDmugtv2VW9gSv0sMj8ShqBOELViSJtgf3
         t+x0l9P1vOLuaWlWwrmbMV822saINCsdEq1cyKRJPYU+yEDKkBsqwDa7lA6TBwyIERul
         Td4r9LzQY/Q6AsaYTscpziYjzlqdf3Fd/C03fjveNTg5iOX3eEgl5Sxm1PGhetTXBVFj
         OXQtGXosvFS/7OQVRXVFxdIJ4CSPuxV7SN0IhE29KpHyVtWWQfDE8CF99RqQh2RdDdW2
         IZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OuGAO91bT9scHZ+M1kNZF+Tb/U4vNWoZYvfq/f3IMVg=;
        b=OpYZOYk2YFy7B4g7MgnAfhts0PpnK/A4ZBOb850WbSdPOobrk2zzF1T4tdx37ketnA
         9DtpU/9d/IyLzVm/9lkrqDtCFq/LFmm9eWoeHB/He8IDaQFVarwA3QMKJ5seuZFfNG3i
         st8wwVnsxQGYaDCktAxE3+qPlL7kjhghQm8bTKAuCkIClZosvHlrMdJXqgvsPnj27kUg
         gsKbpWLWmgGoNKv96Lzt5pC/L8iyFRVrCRwRcTT7dkikvmHknxHoJswfSrCSfDbY2yZp
         VQVgUcGdWqGT9GZitfhTTVQHmRJ2COijwY35Zh+QWpxjBcD58or05j8bAmUgaTRjyl7V
         EiSg==
X-Gm-Message-State: AOAM532rpamIwQHhmM4amQYdIJ52bkX6foXCCSST/RSzKb98O7JgeJMy
        kMzfWjVEibKPuqY2EbOFn54j7g==
X-Google-Smtp-Source: ABdhPJx4ah0Y5CvPRiW/0gUYuUy2sHW9L897sSnRS1Y/3bO9F/06gcH0kLH9ziEC4SS+Sm+C5n4+dg==
X-Received: by 2002:a17:90b:3ecd:: with SMTP id rm13mr5227188pjb.157.1638343387412;
        Tue, 30 Nov 2021 23:23:07 -0800 (PST)
Received: from localhost ([122.171.9.64])
        by smtp.gmail.com with ESMTPSA id f21sm24843516pfe.69.2021.11.30.23.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 23:23:06 -0800 (PST)
Date:   Wed, 1 Dec 2021 12:53:04 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH] cpufreq: Fix get_cpu_device() failed in
 add_cpu_dev_symlink()
Message-ID: <20211201072304.5j44qi6bbgdx3hhv@vireshk-i7>
References: <20211129080248.46240-1-wangxiongfeng2@huawei.com>
 <20211129091039.s7bqq43o4ktuub6t@vireshk-i7>
 <CAJZ5v0hYskLTjSGOJgRRXD0cE0a5DMHh5qTvmgCmJh8bMicLzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hYskLTjSGOJgRRXD0cE0a5DMHh5qTvmgCmJh8bMicLzA@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30-11-21, 12:42, Rafael J. Wysocki wrote:
> This is the real hot-add path which isn't tested on a regular basis.

Ahh, I thought this is a simple offline/online thing. Makes sense now.

> > Anyway the patch is okay,
> 
> It would be good to add a Fixes: tag to it, though.  Any idea about
> the commit this should point to?

This is broken since a very long time then, we need to get this into all stable
kernels we care about.

As Xiongfeng pointed out, 2f0ba790df51 ("cpufreq: Fix creation of symbolic links
to policy directories") looks to be a good candidate.

-- 
viresh
