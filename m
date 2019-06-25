Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67BE755311
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2019 17:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfFYPQ7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 11:16:59 -0400
Received: from mga12.intel.com ([192.55.52.136]:15842 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727485AbfFYPQ6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Jun 2019 11:16:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2019 08:16:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,416,1557212400"; 
   d="scan'208";a="161946584"
Received: from syhu-mobl.ccr.corp.intel.com (HELO rzhang-dell-9360.ccr.corp.intel.com) ([10.249.173.95])
  by fmsmga008.fm.intel.com with ESMTP; 25 Jun 2019 08:16:56 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, srinivas.pandruvada@intel.com,
        rui.zhang@intel.com
Subject: [PATCH 00/13] intel_rapl: RAPL abstraction and MMIO RAPL support
Date:   Tue, 25 Jun 2019 23:16:35 +0800
Message-Id: <1561475808-24839-1-git-send-email-rui.zhang@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Besideis MSR interface, RAPL can also be controlled via the MMIO interface,
by accessing the MCHBar registers exposed by the processor thermal device.

Currently, we only have RAPL MSR interface in Linux kernel, this brings
problems on some platforms that BIOS performs a low power limits via the
MMIO interface by default. This results in poor system performance,
and there is no way for us to change the MMIO MSR setting in Linux.

To fix this, RAPL MMIO interface support is introduced in this patch set.

Patch 1/13 to patch 11/13 abstract the RAPL code, and move all the shared
code into a separate file, intel_rapl_common.c, so that it can be used
by both MSR and MMIO interfaces.
Patch 12/13 introduced RAPL support via MMIO registers, exposed by the
processor thermal devices.
Patch 13/13 fixes a module autoloading issue found later.

The patch series has been tested on Dell XPS 9360, a SKL platform.

Note that this patch series are based on the -tip tree, which contains the
latest RAPL changes for multi-die support.

thanks,
rui
