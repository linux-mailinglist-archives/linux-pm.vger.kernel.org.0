Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F522A91E0
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 09:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgKFI6O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 03:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgKFI6O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 03:58:14 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E32C0613D3
        for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2020 00:58:14 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id u4so431597pgr.9
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2020 00:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ht7beKQxIAbpTk+2MJgr9NYeCh/cHuggGDrae3UpH/0=;
        b=YBGGYWCYtBr/7OVDKg9RemOUh0t1O1mOFQv6yrW1AhI0RpUC/Xr4s7t/ll71+nsh08
         K6qdCN9M/Sb7lAfHvtwDpyrzJEpxXRwe/DQOlCw7eJ07GdQOf1az3u5dbNjY0FYz+QSk
         aJ8PmUIYSEnIf1106wDb93KkUrS5jzkW4vno0rCSNJ4ctXAJyov1SA06oK05eqJ1YKAm
         /1lmuzwYr8QrhpzeBmVeTNaBQPiLWWyetykD6XJq2YeMlzdT23q//evi86RtIZ1OzzPO
         v396v/RotM0Pi5CYnPvKb2JPiG/NfJD1z6EZwaipAfsyZaRXpoT1VATdZNJsJaLipeX9
         mmkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ht7beKQxIAbpTk+2MJgr9NYeCh/cHuggGDrae3UpH/0=;
        b=L8rMIE25+b5m/R2/bh0YDJnJXGEfV15bMzDkhHGKY81vtuvoj0Qc4UL8MRLifFQQJK
         XzAR1AkVQIJbZy88TInZ/3fkgffdz/Z4HPDCxODXEOxRo4i3EYUf93Ot+49JbPbEq2EG
         0lN11RW9+TDCAW3qgUIEWCwjsBmeA9tX4Gx2ixiZPc9FhauhRNZjfe616ZK4pSNbAdnX
         AtpL2a5QWEhHtAW4OgU1F1qbHOMVAHcUYuTyR4wu53jt+NGP/ayHy59t60xgcveogxnn
         ebbi28chXYGK597LHFIulnNMCkkPriAafpyX6gpc3SH2ci+vYw5dCFKmmfwiZZ4DJVjQ
         dJfg==
X-Gm-Message-State: AOAM530qWVg4jhgpXrKGVXAB85h3oVbcRonYpxjNsoYFIMNuZ8uDNVZv
        dS9KivVrmOYzeRGJ25zTrsJAWw==
X-Google-Smtp-Source: ABdhPJxVsk4tykFJuEalPMZNi9h0aaWjzDL5DOmhzvK58wHu2Wa5avcxVDnO2k+RgOKRqLLoUIKdVg==
X-Received: by 2002:a17:90b:4a10:: with SMTP id kk16mr1431011pjb.77.1604653093346;
        Fri, 06 Nov 2020 00:58:13 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id z21sm1221365pfa.158.2020.11.06.00.58.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Nov 2020 00:58:12 -0800 (PST)
Date:   Fri, 6 Nov 2020 14:28:10 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Andreas Kemnade <andreas@kemnade.info>, vireshk@kernel.org,
        nm@ti.com, ulf.hansson@linaro.org, stephan@gerhold.net,
        khilman@kernel.org, sboyd@kernel.org, linux-pm@vger.kernel.org,
        rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [Letux-kernel] [REGRESSION] opp: Allow
 dev_pm_opp_get_opp_table() to return -EPROBE_DEFER
Message-ID: <20201106085810.ubo3cikbg33x76lt@vireshk-i7>
References: <20201106001018.02200778@aktux>
 <20201106041441.uuz5vrtqeyn6ijdv@vireshk-i7>
 <8728D936-6583-407F-96CF-92AE95AAECDF@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8728D936-6583-407F-96CF-92AE95AAECDF@goldelico.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06-11-20, 09:44, H. Nikolaus Schaller wrote:
> 
> > Am 06.11.2020 um 05:14 schrieb Viresh Kumar <viresh.kumar@linaro.org>:
> > 
> > On 06-11-20, 00:10, Andreas Kemnade wrote:
> >> Hi,
> >> 
> >> On the GTA04 (DM3730, devicetree omap3-gta04*) I get my console flooded
> >> up with the following:
> >> [   24.517211] cpu cpu0: multiple regulators are not supported
> >> [   24.523040] cpufreq: __target_index: Failed to change cpu frequency: -22
> >> [   24.537231] ------------[ cut here ]------------
> >> [   24.542083] WARNING: CPU: 0 PID: 5 at drivers/opp/core.c:678 dev_pm_opp_set_rate+0x23c/0x494
> >> [   24.551086] Modules linked in: usb_f_ecm g_ether usb_f_rndis u_ether libcomposite configfs phy_twl4030_usb omap2430 musb_hdrc overlay
> >> [   24.563842] CPU: 0 PID: 5 Comm: kworker/0:0 Tainted: G        W         5.9.0-rc1-00008-g629238068eb9 #14
> >> [   24.573852] Hardware name: Generic OMAP36xx (Flattened Device Tree)
> >> [   24.580413] Workqueue: events dbs_work_handler
> >> [   24.585083] [<c010e6b4>] (unwind_backtrace) from [<c010a194>] (show_stack+0x10/0x14)
> >> [   24.593200] [<c010a194>] (show_stack) from [<c0464ad0>] (dump_stack+0x8c/0xac)
> >> [   24.600769] [<c0464ad0>] (dump_stack) from [<c01276a8>] (__warn+0xcc/0xe4)
> >> [   24.608001] [<c01276a8>] (__warn) from [<c0127a3c>] (warn_slowpath_fmt+0x74/0xa0)
> >> [   24.615844] [<c0127a3c>] (warn_slowpath_fmt) from [<c06364ac>] (dev_pm_opp_set_rate+0x23c/0x494)
> >> [   24.625061] [<c06364ac>] (dev_pm_opp_set_rate) from [<c063ec08>] (set_target+0x2c/0x4c)
> >> [   24.633453] [<c063ec08>] (set_target) from [<c063a950>] (__cpufreq_driver_target+0x190/0x22c)
> >> [   24.642395] [<c063a950>] (__cpufreq_driver_target) from [<c063d4e0>] (od_dbs_update+0xcc/0x158)
> >> [   24.651489] [<c063d4e0>] (od_dbs_update) from [<c063e090>] (dbs_work_handler+0x2c/0x54)
> >> [   24.659881] [<c063e090>] (dbs_work_handler) from [<c013f71c>] (process_one_work+0x210/0x358)
> >> [   24.668731] [<c013f71c>] (process_one_work) from [<c0140014>] (worker_thread+0x22c/0x2d0)
> >> [   24.677307] [<c0140014>] (worker_thread) from [<c0144eac>] (kthread+0x140/0x14c)
> >> [   24.685058] [<c0144eac>] (kthread) from [<c0100148>] (ret_from_fork+0x14/0x2c)
> >> [   24.692626] Exception stack(0xde4b7fb0 to 0xde4b7ff8)
> >> [   24.697906] 7fa0:                                     00000000 00000000 00000000 00000000
> >> [   24.706481] 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> >> [   24.715057] 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> >> [   24.722198] ---[ end trace 038b3f231fae6f81 ]---
> >> 
> >> endlessly after the $subject commit. Any hints?
> > 
> > The fix for this has been in linux-next for a couple of days and it
> > made it to linus/master yesterday.
> > 
> > 47efcbcb340ic opp: Fix early exit from dev_pm_opp_register_set_opp_helper()

I think I may have accidentally pasted the wrong commit here. This is
the one which must have fixed it for you.

commit 1f6620f87006 ("opp: Don't always remove static OPPs in _of_add_opp_table_v1()")


> Seems to fix our problems on gta04 (OMAP3).
> Otherwise we would have found that v5.10-rc3 magically solves it :)

I assume you just ran linus's/master, otherwise the patch I shared
earlier won't have fixed the issue :)

> Interestingly it did not affect OMAP5.

Based on the DT I saw for omap5, it does use OPPv1 and so it shouldn't
have worked as well. It may be worth checking why it didn't get
affected earlier.

You can see the populated OPPs for a platform with this:

ls /sys/kernel/debug/opp/cpu*/*

You shall see some difference with and without this patch. Or it may
be the case that you are adding dynamic OPPs with dev_pm_opp_add() and
so even after removing the static ones, it worked (though I wasn't
able to find that in the code).

-- 
viresh
