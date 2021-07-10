Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165113C342D
	for <lists+linux-pm@lfdr.de>; Sat, 10 Jul 2021 12:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbhGJKk5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Jul 2021 06:40:57 -0400
Received: from mga14.intel.com ([192.55.52.115]:34009 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232387AbhGJKk4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 10 Jul 2021 06:40:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10040"; a="209638432"
X-IronPort-AV: E=Sophos;i="5.84,229,1620716400"; 
   d="scan'208";a="209638432"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2021 03:38:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,229,1620716400"; 
   d="scan'208";a="429090400"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.79])
  by orsmga002.jf.intel.com with ESMTP; 10 Jul 2021 03:38:06 -0700
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
Subject: [PATCH V3 0/3] driver core: Add ability to delete device links of unregistered devices
Date:   Sat, 10 Jul 2021 13:38:16 +0300
Message-Id: <20210710103819.12532-1-adrian.hunter@intel.com>
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

Since V2, these patches fix the issue by amending device link removal to
accept removal of a link with an unregistered consumer device, as suggested
by Rafael.


Changes in V3:

    driver core: Prevent warning when removing a device link from unregistered consumer
	New patch split from "driver core: Add ability to delete device
	links of unregistered devices" except first chunk from that patch
	dropped as unnecessary

    driver core: Add ability to delete device links of unregistered devices
	Move warning fix to separate patch.


Changes in V2:

    Take approach suggested by Rafael


Adrian Hunter (3):
      driver core: Prevent warning when removing a device link from unregistered consumer
      driver core: Add ability to delete device links of unregistered devices
      scsi: ufshcd: Fix device links when BOOT WLUN fails to probe

 drivers/base/core.c       |  8 ++++++--
 drivers/scsi/ufs/ufshcd.c | 23 +++++++++++++++++++++--
 2 files changed, 27 insertions(+), 4 deletions(-)


Regards
Adrian
