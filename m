Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8AE34A5EA
	for <lists+linux-pm@lfdr.de>; Fri, 26 Mar 2021 11:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhCZK4O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Mar 2021 06:56:14 -0400
Received: from mga09.intel.com ([134.134.136.24]:2701 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229779AbhCZK4K (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 26 Mar 2021 06:56:10 -0400
IronPort-SDR: IkeBoMlaaZ7GcMg9dhFQwc6EiteoGHxaTdMYGpMQ5cOr092r0GisU2O9G0zv0s8xhcGDU13LfL
 yCH+KQS3CHOA==
X-IronPort-AV: E=McAfee;i="6000,8403,9934"; a="191220948"
X-IronPort-AV: E=Sophos;i="5.81,280,1610438400"; 
   d="scan'208";a="191220948"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 03:56:09 -0700
IronPort-SDR: dNzUijm14yiWaoUjLylLnmffRoKQCt5NPjryKumofxhutEDtDqqTKst3M09hOJ02ivlBBRPu26
 Rvfxv1wtEAWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,280,1610438400"; 
   d="scan'208";a="409849713"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by fmsmga008.fm.intel.com with ESMTP; 26 Mar 2021 03:56:07 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, Avri Altman <avri.altman@wdc.com>,
        Bean Huo <huobean@gmail.com>, Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>
Subject: [PATCH 0/2] PM: runtime: Fix race getting/putting suppliers at probe
Date:   Fri, 26 Mar 2021 12:56:17 +0200
Message-Id: <20210326105619.27570-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi

SCSI UFS is starting to use device links for power management but
has run into issues. Here are 2 patches that seem to help.


Adrian Hunter (2):
      PM: runtime: Fix ordering in pm_runtime_get_suppliers()
      PM: runtime: Fix race getting/putting suppliers at probe

 drivers/base/power/runtime.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)


Regards
Adrian
