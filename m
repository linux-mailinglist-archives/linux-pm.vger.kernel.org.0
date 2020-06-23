Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C692F2049EC
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jun 2020 08:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbgFWGaX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jun 2020 02:30:23 -0400
Received: from mga07.intel.com ([134.134.136.100]:48920 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730395AbgFWGaX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Jun 2020 02:30:23 -0400
IronPort-SDR: Nu3Gc0Y9dlI+gDp4D2ADUj64OZJCbF2H1xKLNvvypAU7dw6r8X2aow+PlawkZM5Z4NMTN5Brxy
 pwNTHkjLVZOQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="209177388"
X-IronPort-AV: E=Sophos;i="5.75,270,1589266800"; 
   d="scan'208";a="209177388"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 23:30:23 -0700
IronPort-SDR: XE6v9h5pzfQ/W9LnwjMZ8WxUjPUMJvdrMXd6aYsQlTxm69N1Idkzz7G9HMtW2CdtA47DTbmbTd
 sPhic+o+Lh4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,270,1589266800"; 
   d="scan'208";a="275245005"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga003.jf.intel.com with ESMTP; 22 Jun 2020 23:30:21 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 0/2][v3] Fix IPI missing issue when woken from suspend to idle
Date:   Tue, 23 Jun 2020 14:31:08 +0800
Message-Id: <cover.1592892767.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

After an recent optimization on IPIs among idle Cores, the Goldmont failed to
resume from suspend to idle due to missing IPIs. This is because
Goldmont could only be woken up from idle via IPIs rather than POLLING.
Clear the POLLING flag before suspend to idle so that Goldmont will always
get IPIs during suspend to idle.

Chen Yu (2):
  PM / s2idle: Clear _TIF_POLLING_NRFLAG before suspend to idle
  PM / s2idle: Code cleanup to make s2idle consistent with normal idle
    path

 drivers/cpuidle/cpuidle.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

-- 
2.17.1

