Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEC13BED0D
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jul 2021 19:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhGGRcS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jul 2021 13:32:18 -0400
Received: from mga02.intel.com ([134.134.136.20]:29423 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229717AbhGGRcS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Jul 2021 13:32:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="196517848"
X-IronPort-AV: E=Sophos;i="5.84,220,1620716400"; 
   d="scan'208";a="196517848"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 10:29:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,220,1620716400"; 
   d="scan'208";a="563989969"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.79])
  by fmsmga001.fm.intel.com with ESMTP; 07 Jul 2021 10:29:33 -0700
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
Subject: [PATCH RFC 0/2] driver core: Add ability to delete device links of unregistered devices
Date:   Wed,  7 Jul 2021 20:29:46 +0300
Message-Id: <20210707172948.1025-1-adrian.hunter@intel.com>
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

It is not clear if there is a way to get rid of the device link in
this case, so here is a patch to add a function that does just that.

There is also a patch to use the new function to fix the issue with
the SCSI UFS driver.


Adrian Hunter (2):
      driver core: Add ability to delete device links of unregistered devices
      scsi: ufshcd: Fix device links when BOOT WLUN fails to probe

 Documentation/driver-api/device_link.rst |  7 +++++--
 drivers/base/core.c                      | 22 +++++++++++++++++++---
 drivers/scsi/ufs/ufshcd.c                |  7 +++++++
 include/linux/device.h                   |  1 +
 4 files changed, 32 insertions(+), 5 deletions(-)


Regards
Adrian
