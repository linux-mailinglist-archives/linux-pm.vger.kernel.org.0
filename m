Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7007E64751
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2019 15:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfGJNom (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jul 2019 09:44:42 -0400
Received: from mga06.intel.com ([134.134.136.31]:8319 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727389AbfGJNol (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Jul 2019 09:44:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 06:44:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,474,1557212400"; 
   d="scan'208";a="170923250"
Received: from ygao39-mobl1.ccr.corp.intel.com (HELO rzhang-dell-9360.ccr.corp.intel.com) ([10.255.30.205])
  by orsmga006.jf.intel.com with ESMTP; 10 Jul 2019 06:44:39 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, srinivas.pandruvada@intel.com,
        rui.zhang@intel.com
Subject: [PATCH V3 00/17] intel_rapl: RAPL changes for 5.3
Date:   Wed, 10 Jul 2019 21:44:21 +0800
Message-Id: <1562766278-7099-1-git-send-email-rui.zhang@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch series contains two parts, a) RAPL abstraction and RAPL MMIO
interface support, b) RAPL support for latest ICL platforms.

All these patches are rebased on top of Linus' tree, which has the latest
RAPL changes for multi-die system.

Note that I have tested the RAPL abstractiona and MMIO RAPL patches on
Dell XPS 9360, a SKL platform, with 5.2-rc6 tip tree. But I have not tested
it with latest Linus' tree becase of a kernel boot crash regression.

Changes in V3:
   - rebase RAPL MMIO support on top of latest Linus' tree.
   - add RAPL support patches for ICL platforms on top to resolve the
     conflicts.
Changes in V2:
   - add kerneldoc for struct rapl_if_priv.
   - use intel_rapl_msr.c for RAPL MSR I/F driver, instead of intel_rapl.c.
   - changelog and coding style update.

thanks,
rui
