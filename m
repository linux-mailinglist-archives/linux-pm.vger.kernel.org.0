Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8422F328187
	for <lists+linux-pm@lfdr.de>; Mon,  1 Mar 2021 15:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236700AbhCAO4j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Mar 2021 09:56:39 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:64241
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236699AbhCAO4K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Mar 2021 09:56:10 -0500
X-IronPort-AV: E=Sophos;i="5.81,215,1610406000"; 
   d="scan'208";a="374413047"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 15:55:24 +0100
Date:   Mon, 1 Mar 2021 15:55:23 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Saravana Kannan <skannan@codeaurora.org>
cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kbuild-all@lists.01.org
Subject: [PATCH] PM / devfreq: fix odd_ptr_err.cocci warnings (fwd)
Message-ID: <alpine.DEB.2.22.394.2103011553490.2899@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

There seems to be an inconsistency, but the patch proposed by Coccinelle
does not look correct.  There should be a test on opp_table.

julia

---------- Forwarded message ----------
Date: Mon, 1 Mar 2021 16:35:52 +0800
From: kernel test robot <lkp@intel.com>
To: kbuild@lists.01.org
Cc: lkp@intel.com, Julia Lawall <julia.lawall@lip6.fr>
Subject: [PATCH] PM / devfreq: fix odd_ptr_err.cocci warnings

CC: kbuild-all@lists.01.org
TO: Saravana Kannan <skannan@codeaurora.org>
CC: Chanwoo Choi <cw00.choi@samsung.com>
CC: Sibi Sankar <sibis@codeaurora.org>
CC: MyungJoo Ham <myungjoo.ham@samsung.com>
CC: Kyungmin Park <kyungmin.park@samsung.com>
CC: linux-pm@vger.kernel.org
CC: linux-kernel@vger.kernel.org

From: kernel test robot <lkp@intel.com>

drivers/devfreq/governor_passive.c:318:7-13: inconsistent IS_ERR and PTR_ERR on line 319.

 PTR_ERR should access the value just tested by IS_ERR

Semantic patch information:
 There can be false positives in the patch case, where it is the call to
 IS_ERR that is wrong.

Generated by: scripts/coccinelle/tests/odd_ptr_err.cocci

Fixes: 82d4ff586ae2 ("PM / devfreq: Add cpu based scaling support to passive governor")
CC: Saravana Kannan <skannan@codeaurora.org>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git devfreq-testing-passive-gov
head:   82d4ff586ae2fb6d89cad871949004bed3438ccb
commit: 82d4ff586ae2fb6d89cad871949004bed3438ccb [3/3] PM / devfreq: Add cpu based scaling support to passive governor
:::::: branch date: 3 hours ago
:::::: commit date: 3 hours ago

Please take the patch only if it's a positive warning. Thanks!

 governor_passive.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -316,7 +316,7 @@ static int cpufreq_passive_register(stru

 			opp_table = dev_pm_opp_get_opp_table(cpu_dev);
 			if (IS_ERR(devfreq->opp_table)) {
-				ret = PTR_ERR(opp_table);
+				ret = PTR_ERR(devfreq->opp_table);
 				goto out;
 			}

