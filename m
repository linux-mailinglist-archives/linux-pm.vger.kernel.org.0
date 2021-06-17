Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B053AA958
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jun 2021 05:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbhFQDIX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 23:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhFQDIX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jun 2021 23:08:23 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41ACFC061574
        for <linux-pm@vger.kernel.org>; Wed, 16 Jun 2021 20:06:16 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id q15so3719465pgg.12
        for <linux-pm@vger.kernel.org>; Wed, 16 Jun 2021 20:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4WB1jB6nT0GNnkzEivbgMBJeFx8gT0oJK+hi8Kq4WRE=;
        b=iAC/lcEidMUL1pgEoRjyMcGeyXnDOa+uxS/umBrfkwR6yOKHrkNuZno2a+GxRLlnFO
         XGBMYrQeOR/pyBbykQqFUCP+xjHLC+YLGs+N2CFiKnZxtCDCdFDYuJOiVu6vJ5xY6f01
         u3/5Cbmyaa8+cQfetYAgNKoBVeEuTXuVEvedRNeFqdd/xSc7Rn6U+RoNp6JoM5kmWAO1
         byFkVS7uH0iTHMGTtEaEAvJsXW2SsPCHVlvOwMuRMMdfsP65DrTtxJH/oIhW6ojUnON6
         5SmmRq4gGHTk1ndN0YrsNpDzjo///ADA/4yJLBQ6OXRAF5Wabgw7nLb4ZJV0LDk3Tva1
         Z9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4WB1jB6nT0GNnkzEivbgMBJeFx8gT0oJK+hi8Kq4WRE=;
        b=cSB/AgvzA3/RIK01dPQPkvRPx7S7txd3jTQt2qgTx77JqyiExe02p79oWRbbaZrbKR
         fWdgI4Vyahku1Kx73hQBysQy+pBE67sOpqjw4a8yYfu2/CLrMxImxVS9ZiBIGixqfhWw
         CxNHy3ZUvOwUks46AsnAbLEG9dRbDnj5RklUYhCTPU5OtbEaWsmvk2Ahr+pAXUriTBKT
         pyKqCCxSE+Em3/LdiXCvkT6y+wdPFD8TviBVmVx6klK6zfZbyv9ljxYdodj8J/qiBZbX
         sYO40p2iebRXFw8EpQ1nEbbxQm1So5Y04LUA9O3/DJ+LzAwZli1/Bf7a/phDm6vJUoty
         u9Cg==
X-Gm-Message-State: AOAM531rRKORXVJv52VdrDtTiS0ZooDLcVfWIXLvtCbvmq2FWIC8w+TV
        KWinpc3DWw/JxQFsHzgPgzVQbQ==
X-Google-Smtp-Source: ABdhPJxO+4Dx6Cgg1M5OJYvF0W8ZkqKGbRTflVIy7v8Nm4WlFrTzqKT6e9gideff3WV12/k8hZkpFA==
X-Received: by 2002:aa7:9515:0:b029:2e9:c6f4:2c44 with SMTP id b21-20020aa795150000b02902e9c6f42c44mr3204136pfp.28.1623899175589;
        Wed, 16 Jun 2021 20:06:15 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id o20sm3191289pjq.57.2021.06.16.20.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 20:06:14 -0700 (PDT)
Date:   Thu, 17 Jun 2021 08:36:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/3] arch_topology: Avoid use-after-free for
 scale_freq_data
Message-ID: <20210617030612.sksyutwjgwmozka5@vireshk-i7>
References: <cover.1623825725.git.viresh.kumar@linaro.org>
 <9dba462b4d09a1a8a9fbb75740b74bf91a09a3e1.1623825725.git.viresh.kumar@linaro.org>
 <20210616112544.GA23657@arm.com>
 <20210616113604.e4kc3jxb7ayqskev@vireshk-i7>
 <20210616120057.GA23282@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616120057.GA23282@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-06-21, 13:00, Ionela Voinescu wrote:
> I would agree if it wasn't for the fact that the driver provides the
> set_freq_scale() implementation that ends up using driver internal data
> which could have been freed by the driver's own .exit()/stop_cpu()
> callbacks. The API and the generic implementation has the responsibility
> of making sure of sane access to its own structures.

How do you see timer core or workqueue core then ? Why do they make
sure they don't end up calling user's function once we ask them not to
?

And also scheduler's own util update mechanism, the exact thing
happens there. Users (cpufreq governors) call
cpufreq_add_update_util_hook() and cpufreq_remove_update_util_hook()
to pass their own data structure "struct update_util_data", which has
ia callback within. This is what happens from scheduler's context in
those cases.

static inline void cpufreq_update_util(struct rq *rq, unsigned int flags)
{
	struct update_util_data *data;

	data = rcu_dereference_sched(*per_cpu_ptr(&cpufreq_update_util_data,
						  cpu_of(rq)));
	if (data)
		data->func(data, rq_clock(rq), flags);
}

Also note that some kind of synchronisation mechanism is indeed
required between topology_set_scale_freq_source() and
topology_clear_scale_freq_source(), there is no race there today,
sure, but this is an API which is made generic.

> Even if we would want to keep drivers from shooting themselves in the
> foot, I would prefer we postpone it until we have more users for this,
> before we add any synchronisation mechanisms to functionality called
> on the tick.

The rcu mechanism is very much used in the scheduler itself because it
is lightweight. Honestly I don't even see any other way (w.r.t.
locking) users can fix it at their end. They don't know which was the
last tick that used their callback.

> Let's see if there's a less invasive solution to fix CPPC for now, what
> do you think?

For me, this change is required in the API despite how CPPC ends up
using it. Else we are failing at defining the API itself IMHO.

-- 
viresh
