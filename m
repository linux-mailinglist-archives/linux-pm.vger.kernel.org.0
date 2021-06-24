Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C43D3B2534
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jun 2021 04:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhFXC4i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Jun 2021 22:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhFXC4h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Jun 2021 22:56:37 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B140CC061574
        for <linux-pm@vger.kernel.org>; Wed, 23 Jun 2021 19:54:18 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id p9so3506481pgb.1
        for <linux-pm@vger.kernel.org>; Wed, 23 Jun 2021 19:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EZtiIZXLAbCl5jLHqK1+lf6V6SP0mpZsmLqgJ+RTBrs=;
        b=KoqtnfhMV/W89LhqRLh+1OYFx2USIS1tsVLx3UrSx4S2C7B0Z4mLY8a+2OXNMx5q+0
         K6V3ArCZj2DR+pxF/qc+VOp+NAyw/e6CHy+3iPOA1T1QJ9LHi17n/GNeNXmMkbi84CbB
         UGdafLOOKt+P/JHZ/Pj+ZgVbU2KeiBHjBIJdscNugzv0do1i6lzsLmW19hk7eaJfR/ET
         hrH1Lx6GC4RFbsPHWa6BQWyBpSdkGPUqpZrh4CvwuK4SGDxZoAJApRko0f8PVZK+k7qC
         Eh2yyjxIA/OY69soXQVe9K8Wx0sQi8k1L4SyE/iPoR7JunGU44NThR9AE3YEokZKGiQW
         YDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EZtiIZXLAbCl5jLHqK1+lf6V6SP0mpZsmLqgJ+RTBrs=;
        b=MRgYhosnCG3RPF78dDKclxcGtf70qvShSG77RbY6/iKfHZGog7abb5LaafHOtY8uP8
         dMBuvnaHzhsMIkAtk0yit4r7wmLzJXjhhgwuqD5tGYw1aM+6ocT+1dOQbOlUV0GKB1ud
         F0eY0nRkGuQkS4BV447rAKJpDWHOx8wcFd5o1WkP+N2O/kcZKkAagiGt3LoXDRjdWBAA
         cavrT46ArpQ2DhDKp9fi51ZIlej4o6ISK76JXUdJdN6XmurSd0voSO0YSkMuSGw5nFfZ
         BKfBGK6/ySMYv9ACNjaeX45BfTXg42zrO+zArFfYHyjhTdtGYFtPoxiWIuyP5l+h2mFF
         YnPw==
X-Gm-Message-State: AOAM532JkZMKnWgjD5fnvyw1PQ2wsf50ir7pPMXEDqHoehwSitwGX+H3
        uJGK4O9IPEHc/tiyDuFgpzoMIA==
X-Google-Smtp-Source: ABdhPJzpz4Wdmkby5CYYPfvOjumLHTc525MdbSaDIp32RKEwPpxu3eR2dbF6bbqAhfzcT/S5BC265Q==
X-Received: by 2002:a65:6a12:: with SMTP id m18mr2561679pgu.229.1624503258102;
        Wed, 23 Jun 2021 19:54:18 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id y7sm6524339pja.8.2021.06.23.19.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 19:54:17 -0700 (PDT)
Date:   Thu, 24 Jun 2021 08:24:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Will Deacon <will@kernel.org>, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH V3 0/4] cpufreq: cppc: Add support for frequency
 invariance
Message-ID: <20210624025414.4iszkovggk6lg6hj@vireshk-i7>
References: <cover.1624266901.git.viresh.kumar@linaro.org>
 <09a39f5c-b47b-a931-bf23-dc43229fb2dd@quicinc.com>
 <20210623041613.v2lo3nidpgw37abl@vireshk-i7>
 <2c540a58-4fef-5a3d-85b4-8862721b6c4f@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c540a58-4fef-5a3d-85b4-8862721b6c4f@quicinc.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23-06-21, 08:57, Qian Cai wrote:
> Viresh, I am afraid I don't feel comfortable yet. I have a few new tests in
> development, and will provide an update once ready.

Oh sure, np.

> Also, I noticed the delivered perf is even smaller than lowest_perf (100).

> # cat /sys/devices/system/cpu/cpu8/acpi_cppc/feedback_ctrs
>  ref:103377547901 del:54540736873
> # cat /sys/devices/system/cpu/cpu8/acpi_cppc/feedback_ctrs
>  ref:103379170101 del:54541599117
> 
> 100 * (54541599117 - 54540736873) / (103379170101 - 103377547901) = 53
> 
> My understanding is that the delivered perf should fail into the range between
> lowest_perf and highest_perf. Is that assumption correct? This happens on
> 5.4-based kernel, so I am in process running your series on that system to see
> if there is any differences. In any case, if it is a bug it is pre-existing,
> but I'd like to understand a bit better in that front first.

Vincent:

Can that happen because of CPU idle ?

-- 
viresh
