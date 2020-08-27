Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 549DA253C6C
	for <lists+linux-pm@lfdr.de>; Thu, 27 Aug 2020 06:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbgH0EDt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Aug 2020 00:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgH0EDs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Aug 2020 00:03:48 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AFBC0612A3;
        Wed, 26 Aug 2020 21:03:27 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id m8so2465100pfh.3;
        Wed, 26 Aug 2020 21:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6bQeuePNqH7dWbqUFgjlTSNlzBof5RgofuNEIyHakwM=;
        b=X3MR6zMdfOgPqvRfgQkzGhLn/dxi02axDYvVL7GX/lmX+cA98U0F7qPCwN5R826MPt
         P6f278VM9YOweJuu39pPhgqodUBu+ASdBdcZZwSSfYTgdzpBm5DLE9iwNIUmdt9bZ/dU
         YgTTt9tbCeTgNibdS+a4BNHlRVfY0bKqaX6Rpsnx70swdhJFBmB8FNDJ4upzP7eFStyf
         xTRKRq8CRQ35RLoLaC0Ct7s+xT4NSHWhCXZ9OAAXJeSZV6VnIddS8rQbEC2ylVXwzStu
         LUXFNe8kgTUMCa337MPXi93vLwJBUj2x8ZZM/unRuBZoYo6Dmnp2RCOohjZeV6HUmy90
         VaHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6bQeuePNqH7dWbqUFgjlTSNlzBof5RgofuNEIyHakwM=;
        b=sW8nrtNQlFbJxeJ2BDWDdO4ry5+1oYO1+9RtIuYUElkuSQhb9ZGeW0LgS3sUSOb/A6
         Z64oww97SZ5dlPTDfG8klgnQTR2Y0MYSkwgbNMtbpV+a2chQv2/c4UWn4FpxtwJvso0A
         l/sblpd9oBMwHFSoGdZZqFC4sD473BlqPh6YEyIhSqw5jbXTL/xmPUEzFFBAKCSdHmPH
         m38OpHCSmx4OLApUH5Gnbnhl4qepKJpBoGUdp+ojJRYcAyI3ORPj49MCJjkp/duPLGtF
         SlHCRfHWoQhBIvFQlSzw4hQfBmsh3u9P67OvTu8PHBvkjrNWKAxj/Zmb1Z64hGdZE80W
         PCTQ==
X-Gm-Message-State: AOAM5330XpPh/wylHm26m9AatvXHN1KSFdtlXjfjOoMGmmS37+3D3YDB
        gRmTOjJuWsLsuf6gt8O2bpI=
X-Google-Smtp-Source: ABdhPJzh9mqw7jcuL/gdVISt/cqtAADn6a8e73oWM42h68OTeYpnn525+zrB4ZLZwskwsGEGF/z01w==
X-Received: by 2002:a65:6882:: with SMTP id e2mr13324535pgt.290.1598501005803;
        Wed, 26 Aug 2020 21:03:25 -0700 (PDT)
Received: from localhost ([124.156.176.71])
        by smtp.gmail.com with ESMTPSA id v78sm800705pfc.121.2020.08.26.21.03.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Aug 2020 21:03:25 -0700 (PDT)
Date:   Thu, 27 Aug 2020 12:03:27 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, viresh.kumar@linaro.org
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zbestahu@163.com
Subject: Re: [PATCH] thermal: sysfs: fall back to vzalloc for cooling
 device's statistics
Message-ID: <20200827120327.00003740.zbestahu@gmail.com>
In-Reply-To: <c3fd7949-b33a-aca3-8dd5-1c2df35fb63d@linaro.org>
References: <20200818063005.13828-1-zbestahu@gmail.com>
        <40b69f97-46e5-d62e-0d2f-604dfd4dafa1@linaro.org>
        <20200826101319.00003048.zbestahu@gmail.com>
        <c3fd7949-b33a-aca3-8dd5-1c2df35fb63d@linaro.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 26 Aug 2020 11:19:02 +0200
Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

> Hi Yue,
> 
> On 26/08/2020 04:13, Yue Hu wrote:
> > On Mon, 24 Aug 2020 12:40:35 +0200
> > Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >   
> >> On 18/08/2020 08:30, Yue Hu wrote:  
> >>> From: Yue Hu <huyue2@yulong.com>
> >>>
> >>> We observed warning about kzalloc() when register thermal cooling device
> >>> in backlight_device_register(). backlight display can be a cooling device
> >>> since reducing screen brightness will can help reduce temperature.
> >>>
> >>> However, ->get_max_state of backlight will assign max brightness of 1024
> >>> to states. The memory size can be getting 1MB+ due to states * states.    
> >>
> >> What are the benefits of a 1024 states cooling device ? Is the
> >> difference noticeable with a such small step ?  
> > 
> > Okay, this issue is happened under MSM/Android platform. QCOM spmi wled driver
> > will define the max brightness. We needs to fix the issue to get thermal statistics.  
> 
> Let me rephrase my questions:
> 
> Don't you think there is something wrong in creating a 1024 x 1024
> matrix to show transitions ?
> 
> What is the benefit of such stats ?
> 
> What is the benefit of having a 1024 states cooling device ?

Hi Daniel,

Now, i'm just focus on removing the kernel warning based on current code logic.
Commit 8ea229511e06 (thermal: Add cooling device's statistics in sysfs) added
the thermal statistics by viresh and viresh gived the patch an acknowledgement
in anther mail thread. 

Hi viresh,

Could you review the patch again about the question above?

Thank you.

> 
> 
> 
> 

