Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 300022204E7
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 08:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbgGOG02 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 02:26:28 -0400
Received: from mga17.intel.com ([192.55.52.151]:63476 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbgGOG00 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 Jul 2020 02:26:26 -0400
IronPort-SDR: EIk66CuYAmNXFYycqxpyN7WddBRdTmh1FnMd5GiZQ7/2MeBvbZPSUqtHesbLkF6zgE3hmgHa+P
 klUXRM56du5A==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="129180712"
X-IronPort-AV: E=Sophos;i="5.75,354,1589266800"; 
   d="scan'208";a="129180712"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 23:26:26 -0700
IronPort-SDR: qyzu3FoXm2tWkSwHG44a1k2Dibq2ur1AEhKJ2qK5pwbqGYObv0eKKmB+cCWpy2dkClBDTDc34V
 DBnAWqrbBvCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,354,1589266800"; 
   d="scan'208";a="485615838"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga006.fm.intel.com with ESMTP; 14 Jul 2020 23:26:24 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michal Miroslaw" <mirq-linux@rere.qmqm.pl>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 0/2][RESEND v3] Extend trace point to cover all runtime usage count
Date:   Wed, 15 Jul 2020 14:27:27 +0800
Message-Id: <cover.1594790493.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently some code flow of runtime usage count changes is not covered by 
the rpm_runtime_usage tracepoints. Adjust corresponding tracepoints to monitor
all the runtime usage count changes.

Chen Yu (2):
  PM-runtime: Move all runtime usage related function to runtime.c
  PM-runtime: change the tracepoints to cover all usage_count

 drivers/base/power/runtime.c | 50 ++++++++++++++++++++++++++----------
 include/linux/pm_runtime.h   | 12 ++-------
 2 files changed, 38 insertions(+), 24 deletions(-)

-- 
2.17.1

