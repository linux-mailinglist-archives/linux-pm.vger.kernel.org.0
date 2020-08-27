Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D43B253D20
	for <lists+linux-pm@lfdr.de>; Thu, 27 Aug 2020 07:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgH0FOI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Aug 2020 01:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgH0FOE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Aug 2020 01:14:04 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DFEC061240
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2020 22:14:04 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o13so2516715pgf.0
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2020 22:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cBHoE76BRmIWjK8GBasxXIFwFSuyPmo/sqEtV0bmcP4=;
        b=qSnnev9F/aZWHDr5/8MADrCSBktScfoAZvPVSqSgnZdkziAqjFfTRRcxe4Ewqh0sYs
         XeEhcux2DoeJwCgpnte2jo+Tb5IgC/gyag4xlBz0QWgANA/PNEiiEeicsD/PC3fozLm7
         3vrVjrTtNAonXrOcT4sWCsQmSY/UAjtjypb2+6BDa7Cif8XCMh6A3uRK8FW7LMmYYjeO
         ytQZ1CvUKwcq9zNIXW6giAXvavTGYs0FOqyMdSWkwUR1uJ04iVGndaI37i03jdrzP8mG
         14xh5z8mNaR0wCuWBJdX0gLiyj6k5mDswyq8av8csip/G83PUPyh/BjqzADRBCZdf68l
         8nXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cBHoE76BRmIWjK8GBasxXIFwFSuyPmo/sqEtV0bmcP4=;
        b=faMENqNPqda8qE7dFC7ndCN9XWr9b8vH/KFU0bZICm8cPcqfiFdsd+PxnodpvKIgqS
         cSFsBjfKl5Wo7++8v8mDYPqmMepaaVt4u/9Yghv+IST4ty2GCoNFBfcxlHoNqQQn7VKI
         2kiqw4U8VJl/R66bi7Uq/Qhtkm6a4WjGnf4p8tk6hADhx771AD92J18HXI/BXMYdRggu
         wgl7LTMki7uR/zNisongzjaUx/1CWgfgc79MPnAeX403OF3PhvtKLbxaZVRzO4dph+3Z
         RP63yl5i4N1JfmfmMLJqc2NQONMpNSRzwcGVBnwWP2pRV2oyjE+cPDbJLynsgAhgA+6M
         J3TA==
X-Gm-Message-State: AOAM533QbQt8CpsA7PiaQKO2R/uYBqQfwJPjDevYnjlGNAfX69VUjKPW
        wJX9ZZLDmQfXCD4VerRQPg5ifw==
X-Google-Smtp-Source: ABdhPJw2o3vKKmT5+jk9Yh7g4SdntLbf3XgImV3KGAJcmCCFpFNBAB55zgqUX2cTpO2gqRBSlzvkjw==
X-Received: by 2002:a17:902:ee8b:: with SMTP id a11mr15130201pld.30.1598505243978;
        Wed, 26 Aug 2020 22:14:03 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id z15sm856087pjz.12.2020.08.26.22.14.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Aug 2020 22:14:03 -0700 (PDT)
Date:   Thu, 27 Aug 2020 10:44:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yue Hu <zbestahu@gmail.com>, rafael.j.wysocki@intel.com
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, huyue2@yulong.com, zbestahu@163.com
Subject: Re: [PATCH] thermal: sysfs: fall back to vzalloc for cooling
 device's statistics
Message-ID: <20200827051401.yryitpgq2gi3nkbh@vireshk-i7>
References: <20200818063005.13828-1-zbestahu@gmail.com>
 <40b69f97-46e5-d62e-0d2f-604dfd4dafa1@linaro.org>
 <20200826101319.00003048.zbestahu@gmail.com>
 <c3fd7949-b33a-aca3-8dd5-1c2df35fb63d@linaro.org>
 <20200827120327.00003740.zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827120327.00003740.zbestahu@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27-08-20, 12:03, Yue Hu wrote:
> Hi Daniel,
> 
> Now, i'm just focus on removing the kernel warning based on current code logic.
> Commit 8ea229511e06 (thermal: Add cooling device's statistics in sysfs) added
> the thermal statistics by viresh and viresh gived the patch an acknowledgement
> in anther mail thread. 
> 
> Hi viresh,
> 
> Could you review the patch again about the question above?

Yeah, I Acked it but the questions raised by Daniel are very valid and must be
answered.

I understand that you only cared about fixing the warning, but maybe we need to
fix the driver and the warning will go away by itself. If you don't want to do
it, then someone who is responsible for the driver should do it.

Was it the acpi_video.c driver that you got the warning from ? I have added
Rafael to the email in case that driver needs getting fixed.

-- 
viresh
