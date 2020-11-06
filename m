Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66FEA2A8E20
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 05:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgKFEOw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 23:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbgKFEOt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Nov 2020 23:14:49 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F938C0613CF
        for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2020 20:14:48 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id p4so77331plr.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2020 20:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yo3AW3Al21SU/5tsHqsd5ykrA2rze4CjwWzLUbsw78k=;
        b=suixD1TtCdQB6b0br0QxOvj74GH2MPhsxmA04eVKHkV9MLXcQ9E87ob1nDb/ZF8Pfy
         spDPe/8bfSKj0wy1hWCjVf8KzCfbcqEZZSjM0mM2xUidXJ0isM7luLEV6oK0vSD9PHdM
         qoSeBNf7xR7BISYqfABAynzTirWqFJ367b9gG+ZAuH/YB+b/LtyF6yJ+6XncGmYUpNUD
         9uOlKb4PQA3UsL/f6Xh8wQ/jstlaaLt79gNkt9K4v+i6Rx5p1gdX14SF/0JZtP4AAW+Y
         msvJA3OWuSHluJpM6ReblkRkxNs0Jg1HL2dyRam7lDBilfEv4ekA1JnRXqKhCDjENI0n
         HXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yo3AW3Al21SU/5tsHqsd5ykrA2rze4CjwWzLUbsw78k=;
        b=gn2GhYLxr5hUAuHnhxylcs9Qro6jMAfmdFo2CYlmHCQnN4f9smF4ZXSnuhK3APFrk4
         C84JzIjNrvxSGWrmfAxKLAWRMiqvsghApXMqnG/EDaMNmXIrpvkI0SBZTzQU3QEUnUxP
         jUtfXTt4ZGQ0jytSTeGuvU+qh8h5RJSWShH2tylHLnc90IEIH6MikttmBUl2BR71bZdc
         tEgslJdHkgaj+JDQxps8+cxTcsW4jWq7OlQ5ZNa7DfKfcOF8hKKi3mzTY5F3oss1BIZL
         HxWEX2tPq/mqyVcbGsHcmZSMo7D7FwTzd6wJiDxf2Mc4OgXWKM1hClMbDU9B/bbvCmgl
         FnVw==
X-Gm-Message-State: AOAM533WV7KnOfMld7WC+xCVOssEDyjblj3fZAUf0HRvVP/wWzML/qzp
        5Yhyd/oZD4RULV8z+w1ksOWfr62O9NRWFg==
X-Google-Smtp-Source: ABdhPJz7Wzvu7Y2qs31wP/ioFNTCrcydLd+O+8Qt+NDYekXpmGTSjIL5tD8R9SW/WiDzKfMsziDBpA==
X-Received: by 2002:a17:902:7487:b029:d6:c03b:bce4 with SMTP id h7-20020a1709027487b02900d6c03bbce4mr178476pll.36.1604636087566;
        Thu, 05 Nov 2020 20:14:47 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id b185sm4082621pgc.68.2020.11.05.20.14.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2020 20:14:46 -0800 (PST)
Date:   Fri, 6 Nov 2020 09:44:41 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     stephan@gerhold.net, rjw@rjwysocki.net, khilman@kernel.org,
        ulf.hansson@linaro.org, vireshk@kernel.org, nm@ti.com,
        sboyd@kernel.org, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, letux-kernel@openphoenux.org
Subject: Re: [REGRESSION] opp: Allow dev_pm_opp_get_opp_table() to return
 -EPROBE_DEFER
Message-ID: <20201106041441.uuz5vrtqeyn6ijdv@vireshk-i7>
References: <20201106001018.02200778@aktux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106001018.02200778@aktux>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06-11-20, 00:10, Andreas Kemnade wrote:
> Hi,
> 
> On the GTA04 (DM3730, devicetree omap3-gta04*) I get my console flooded
> up with the following:
> [   24.517211] cpu cpu0: multiple regulators are not supported
> [   24.523040] cpufreq: __target_index: Failed to change cpu frequency: -22
> [   24.537231] ------------[ cut here ]------------
> [   24.542083] WARNING: CPU: 0 PID: 5 at drivers/opp/core.c:678 dev_pm_opp_set_rate+0x23c/0x494
> [   24.551086] Modules linked in: usb_f_ecm g_ether usb_f_rndis u_ether libcomposite configfs phy_twl4030_usb omap2430 musb_hdrc overlay
> [   24.563842] CPU: 0 PID: 5 Comm: kworker/0:0 Tainted: G        W         5.9.0-rc1-00008-g629238068eb9 #14
> [   24.573852] Hardware name: Generic OMAP36xx (Flattened Device Tree)
> [   24.580413] Workqueue: events dbs_work_handler
> [   24.585083] [<c010e6b4>] (unwind_backtrace) from [<c010a194>] (show_stack+0x10/0x14)
> [   24.593200] [<c010a194>] (show_stack) from [<c0464ad0>] (dump_stack+0x8c/0xac)
> [   24.600769] [<c0464ad0>] (dump_stack) from [<c01276a8>] (__warn+0xcc/0xe4)
> [   24.608001] [<c01276a8>] (__warn) from [<c0127a3c>] (warn_slowpath_fmt+0x74/0xa0)
> [   24.615844] [<c0127a3c>] (warn_slowpath_fmt) from [<c06364ac>] (dev_pm_opp_set_rate+0x23c/0x494)
> [   24.625061] [<c06364ac>] (dev_pm_opp_set_rate) from [<c063ec08>] (set_target+0x2c/0x4c)
> [   24.633453] [<c063ec08>] (set_target) from [<c063a950>] (__cpufreq_driver_target+0x190/0x22c)
> [   24.642395] [<c063a950>] (__cpufreq_driver_target) from [<c063d4e0>] (od_dbs_update+0xcc/0x158)
> [   24.651489] [<c063d4e0>] (od_dbs_update) from [<c063e090>] (dbs_work_handler+0x2c/0x54)
> [   24.659881] [<c063e090>] (dbs_work_handler) from [<c013f71c>] (process_one_work+0x210/0x358)
> [   24.668731] [<c013f71c>] (process_one_work) from [<c0140014>] (worker_thread+0x22c/0x2d0)
> [   24.677307] [<c0140014>] (worker_thread) from [<c0144eac>] (kthread+0x140/0x14c)
> [   24.685058] [<c0144eac>] (kthread) from [<c0100148>] (ret_from_fork+0x14/0x2c)
> [   24.692626] Exception stack(0xde4b7fb0 to 0xde4b7ff8)
> [   24.697906] 7fa0:                                     00000000 00000000 00000000 00000000
> [   24.706481] 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [   24.715057] 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [   24.722198] ---[ end trace 038b3f231fae6f81 ]---
> 
> endlessly after the $subject commit. Any hints?

The fix for this has been in linux-next for a couple of days and it
made it to linus/master yesterday.

47efcbcb340c opp: Fix early exit from dev_pm_opp_register_set_opp_helper()

-- 
viresh
