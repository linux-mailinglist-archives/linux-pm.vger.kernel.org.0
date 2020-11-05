Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59DFE2A8A7C
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 00:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732369AbgKEXK3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 18:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732414AbgKEXK3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Nov 2020 18:10:29 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853F0C0613CF;
        Thu,  5 Nov 2020 15:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lklUbcDEGX1h5rblqYLigXhKEzQwy5pmTZP0fAPYkD8=; b=IowxmZsIKRwq2eUovNsYjrk2JO
        da4uUld7YVgDblwZZo4OslVXcNzjWMxbCnO3gfXtNvMPsqZq4XJ1XJzxSNqdlZ/OkQjC/6gi4zrhj
        Vq90c1AQ7CwMch3lV34vCtOSqXiuq+3o+S3m9rOtGCCZBMEUdRxtUXXPZt7VRgVsyUv0=;
Received: from p200300ccff0ddc001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0d:dc00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1kaoOa-0001KU-As; Fri, 06 Nov 2020 00:10:20 +0100
Date:   Fri, 6 Nov 2020 00:10:18 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     stephan@gerhold.net, rjw@rjwysocki.net, khilman@kernel.org,
        ulf.hansson@linaro.org, vireshk@kernel.org, nm@ti.com,
        sboyd@kernel.org, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, letux-kernel@openphoenux.org,
        stephan@gerhold.net
Subject: [REGRESSION] opp: Allow dev_pm_opp_get_opp_table() to return
 -EPROBE_DEFER
Message-ID: <20201106001018.02200778@aktux>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On the GTA04 (DM3730, devicetree omap3-gta04*) I get my console flooded
up with the following:
[   24.517211] cpu cpu0: multiple regulators are not supported
[   24.523040] cpufreq: __target_index: Failed to change cpu frequency: -22
[   24.537231] ------------[ cut here ]------------
[   24.542083] WARNING: CPU: 0 PID: 5 at drivers/opp/core.c:678 dev_pm_opp_set_rate+0x23c/0x494
[   24.551086] Modules linked in: usb_f_ecm g_ether usb_f_rndis u_ether libcomposite configfs phy_twl4030_usb omap2430 musb_hdrc overlay
[   24.563842] CPU: 0 PID: 5 Comm: kworker/0:0 Tainted: G        W         5.9.0-rc1-00008-g629238068eb9 #14
[   24.573852] Hardware name: Generic OMAP36xx (Flattened Device Tree)
[   24.580413] Workqueue: events dbs_work_handler
[   24.585083] [<c010e6b4>] (unwind_backtrace) from [<c010a194>] (show_stack+0x10/0x14)
[   24.593200] [<c010a194>] (show_stack) from [<c0464ad0>] (dump_stack+0x8c/0xac)
[   24.600769] [<c0464ad0>] (dump_stack) from [<c01276a8>] (__warn+0xcc/0xe4)
[   24.608001] [<c01276a8>] (__warn) from [<c0127a3c>] (warn_slowpath_fmt+0x74/0xa0)
[   24.615844] [<c0127a3c>] (warn_slowpath_fmt) from [<c06364ac>] (dev_pm_opp_set_rate+0x23c/0x494)
[   24.625061] [<c06364ac>] (dev_pm_opp_set_rate) from [<c063ec08>] (set_target+0x2c/0x4c)
[   24.633453] [<c063ec08>] (set_target) from [<c063a950>] (__cpufreq_driver_target+0x190/0x22c)
[   24.642395] [<c063a950>] (__cpufreq_driver_target) from [<c063d4e0>] (od_dbs_update+0xcc/0x158)
[   24.651489] [<c063d4e0>] (od_dbs_update) from [<c063e090>] (dbs_work_handler+0x2c/0x54)
[   24.659881] [<c063e090>] (dbs_work_handler) from [<c013f71c>] (process_one_work+0x210/0x358)
[   24.668731] [<c013f71c>] (process_one_work) from [<c0140014>] (worker_thread+0x22c/0x2d0)
[   24.677307] [<c0140014>] (worker_thread) from [<c0144eac>] (kthread+0x140/0x14c)
[   24.685058] [<c0144eac>] (kthread) from [<c0100148>] (ret_from_fork+0x14/0x2c)
[   24.692626] Exception stack(0xde4b7fb0 to 0xde4b7ff8)
[   24.697906] 7fa0:                                     00000000 00000000 00000000 00000000
[   24.706481] 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   24.715057] 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[   24.722198] ---[ end trace 038b3f231fae6f81 ]---

endlessly after the $subject commit. Any hints?

Regards,
Andreas
