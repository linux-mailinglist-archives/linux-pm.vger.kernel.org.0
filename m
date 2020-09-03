Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6662C25BFF4
	for <lists+linux-pm@lfdr.de>; Thu,  3 Sep 2020 13:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgICLO3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Sep 2020 07:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728415AbgICLLy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Sep 2020 07:11:54 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EAFC06124F
        for <linux-pm@vger.kernel.org>; Thu,  3 Sep 2020 04:02:35 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id a12so2172132eds.13
        for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2020 04:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+xnePO0CiG3I+2yx8Df65fwZr0ywdv3YH3EkMLvbo+8=;
        b=ufTPGObNFERWaHp8r72ICqODDqVS3TrOXStNpe4HMFUvqiLa9RFJT4/Al3/I1lRjiR
         coR1xujXHH17vSzvAeL8q14R/1uMXybC0rhLzJlRUI8WK4N3i3136x9xuotbN06YeEL0
         nu1bepiR8V3mqlwh/bbxDdzSro54/VsnoQjNHzSVhnxXpjg0WII3VxbGtao2b4f5nQHP
         SoX9ZD06USM0W9VDObRpk7kXThI5Pc7ygtXeZHgyKxAv2LHKFTXJcy9GPePse73ZQWMf
         mU10JPlcA4m2b59uptwujzktXJIKipTD8xPrRlvOdA4Lz72Sr9LkL6crurOzUYFribD1
         YQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+xnePO0CiG3I+2yx8Df65fwZr0ywdv3YH3EkMLvbo+8=;
        b=Yu8C4194pwwis5AdrpQ4i9w4hyltH8B0k2n3fQOeiHpxFazKel3oyCrhocGl+9VyIK
         ydoHUJRL0M1hoiKdMX0T7+PX+Zx3iFASRbqkY4Dz1v7wDM/UR5aLKn3bJ3ff8iXMum6T
         +4+Qho1UPQAu2/jk4Q2/nsE4h4rqqGhyTvEapOkNeSf/A8ophQUiNRNo2In8gNVK33IX
         f48ucljOzXQ9jF2vx4jzmEhuprHorijxCxoHhdSLsrPXRV1gVoTpdaSvbSGxhK6zBnVE
         aKbxozWttRmKjVsIHDx3eu8hQO4A5+er46eJ+b2V3HFa76BoRRGj9N29VlLxW1+Nst1z
         bqFA==
X-Gm-Message-State: AOAM530j7L3a95IcSCR+NlErlyxhdl90F866/J18pc7IocD1+WjZqCRy
        FNYSzrO3HcgnL0eLssghZGx9RqJnIh10n2ZXvd8=
X-Google-Smtp-Source: ABdhPJwaN82KJzCKThVEHzllzImuZKmSYkShXXc0VcaRnFjTXrw6rqotOJfLo84dc+9Q3qAmN4oXi9cYMHNo8dCdkjM=
X-Received: by 2002:a05:6402:220d:: with SMTP id cq13mr2395332edb.260.1599130950009;
 Thu, 03 Sep 2020 04:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <6dfd665.397441d8.1733eff4aa2@lechevalier.se>
In-Reply-To: <6dfd665.397441d8.1733eff4aa2@lechevalier.se>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Thu, 3 Sep 2020 16:32:18 +0530
Message-ID: <CAOh2x=m=mUf56DW+4pMFvUVEs1s+6T45hoQqhcJUdTuWbxNGig@mail.gmail.com>
Subject: Re: Schedutil scaling governor is missing time_in_state
To:     A L <mail@lechevalier.se>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jul 11, 2020 at 11:22 PM A L <mail@lechevalier.se> wrote:
>
> Hello,
>
> I am testing the 'schedutil' scaling govenor.
>
> So far it seems to give good results in terms of reduced thermals and energy consumption.
>
> One difference compared to 'ondemand' that I noticed is that /sys/devices/system/cpu/cpu*/cpufreq/stats/time_in_state is never updated. It is always empty. This creates a problem for my munin graphs that log the average CPU frequency for each core.
>
> Example with 'ondemand'
> cpu0/cpufreq/stats/time_in_state:3500000 3869872
> cpu0/cpufreq/stats/time_in_state:2300000 581995
> cpu0/cpufreq/stats/time_in_state:1600000 6895937
> cpu0/cpufreq/stats/total_trans:1746213
> cpu0/cpufreq/stats/trans_table:   From  :    To
> cpu0/cpufreq/stats/trans_table:         :   3500000   2300000   1600000
> cpu0/cpufreq/stats/trans_table:  3500000:         0     49335     62476
> cpu0/cpufreq/stats/trans_table:  2300000:     58219         0    756854
> cpu0/cpufreq/stats/trans_table:  1600000:     53591    765738         0
>
> Example with 'schedutil'
> cpu3/cpufreq/stats/time_in_state:<empty>
> cpu3/cpufreq/stats/total_trans:1751092
> cpu3/cpufreq/stats/trans_table:<empty>
>
> Is this a known problem or perhaps a design choice?
>
> This is on kernel 5.7.8 on and AMD Athlon 3000G CPU using 'acpi_cpufreq' scaling_driver.

With fast switching (done from within scheduler's context) we disable
recording cpufreq stats and so
this information isn't available as such. total_trans shouldn't get
updated as well, it should be a
stale value from the time when schedutil wasn't the governor.

Here is an attempt to fix it though.

http://lore.kernel.org/lkml/cover.1599031227.git.viresh.kumar@linaro.org
