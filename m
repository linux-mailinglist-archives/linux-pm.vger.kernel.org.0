Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 164575FBD9
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2019 18:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfGDQew (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Jul 2019 12:34:52 -0400
Received: from mga17.intel.com ([192.55.52.151]:33035 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727459AbfGDQet (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 4 Jul 2019 12:34:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2019 09:34:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,451,1557212400"; 
   d="scan'208";a="169480456"
Received: from conghuic-mobl.ccr.corp.intel.com (HELO rzhang-dell-9360.ccr.corp.intel.com) ([10.249.172.41])
  by orsmga006.jf.intel.com with ESMTP; 04 Jul 2019 09:34:46 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, srinivas.pandruvada@intel.com,
        rui.zhang@intel.com
Subject: [PATCH V2 00/13] intel_rapl: RAPL abstraction and MMIO RAPL support
Date:   Fri,  5 Jul 2019 00:34:32 +0800
Message-Id: <1562258085-3165-1-git-send-email-rui.zhang@intel.com>
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

Changes in V2:
   - add kerneldoc for struct rapl_if_priv.
   - use intel_rapl_msr.c for RAPL MSR I/F driver, instead of intel_rapl.c.
   - changelog and coding style update.

thanks,
rui
