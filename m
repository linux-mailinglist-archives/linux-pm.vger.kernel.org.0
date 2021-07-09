Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8A43C1F7D
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jul 2021 08:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbhGIGqP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Jul 2021 02:46:15 -0400
Received: from mga05.intel.com ([192.55.52.43]:41600 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230178AbhGIGqO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 9 Jul 2021 02:46:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10039"; a="295293985"
X-IronPort-AV: E=Sophos;i="5.84,226,1620716400"; 
   d="scan'208";a="295293985"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2021 23:43:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,226,1620716400"; 
   d="scan'208";a="648869584"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.79])
  by fmsmga005.fm.intel.com with ESMTP; 08 Jul 2021 23:43:27 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, Avri Altman <avri.altman@wdc.com>,
        Bean Huo <huobean@gmail.com>, Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/2] driver core: Add ability to delete device links of unregistered devices
Date:   Fri,  9 Jul 2021 09:43:39 +0300
Message-Id: <20210709064341.6206-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi

There is an issue with the SCSI UFS driver when the optional
BOOT well-known LUN fails to probe, which is not a fatal error.
The issue is that the device and its "managed" device link do not
then get deleted.  The device because the device link has a
reference to it.  The device link because it can only be deleted
by device_del(), but device_add() was never called, so device_del()
never will be either.

These V2 patches fix the issue by amending device link removal to accept
removal of a link with an unregistered consumer device, as suggested
by Rafael.


Changes in V2:

	Take approach suggested by Rafael


Adrian Hunter (2):
      driver core: Add ability to delete device links of unregistered devices
      scsi: ufshcd: Fix device links when BOOT WLUN fails to probe

 drivers/base/core.c       | 11 ++++++++---
 drivers/scsi/ufs/ufshcd.c | 23 +++++++++++++++++++++--
 2 files changed, 29 insertions(+), 5 deletions(-)


Regards
Adrian
