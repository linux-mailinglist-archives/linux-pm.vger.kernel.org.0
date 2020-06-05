Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110541F002E
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jun 2020 21:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgFETEa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jun 2020 15:04:30 -0400
Received: from mga07.intel.com ([134.134.136.100]:24698 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgFETEa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Jun 2020 15:04:30 -0400
IronPort-SDR: 5gXGJKfbZ9le2ln8qvFYnEGCrMn1CsJl0kZDZjdGyDXNtl94WicWhxp3jWFL+Db5wnnGSMIhD1
 PtLWzIpJRdeg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2020 12:04:29 -0700
IronPort-SDR: hIs2PARmVA7t5j4Ut9QpsLkNVPribi9l3YwrsX8M1nZZsPkzIoFjVTkfTjrMTaAEf/4jSxrE1K
 35V3+JdKGwEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,477,1583222400"; 
   d="scan'208";a="273561287"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga006.jf.intel.com with ESMTP; 05 Jun 2020 12:04:26 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Miroslaw <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 0/2][RFC] Add more trace point for runtime usage count
Date:   Sat,  6 Jun 2020 03:05:09 +0800
Message-Id: <cover.1591380524.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currentlt some code flow of runtime usage count changes is not covered by 
the tracepoints. Add corresponding tracepoints to monitor all the usage_count
changes.


Chen Yu (2):
  PM-runtime: Move all runtime usage related function to runtime.c
  PM-runtime: add more tracepoints for usage_count changes

 drivers/base/power/runtime.c | 49 +++++++++++++++++++++++++-----------
 include/linux/pm_runtime.h   | 14 +++--------
 2 files changed, 39 insertions(+), 24 deletions(-)

-- 
2.20.1

