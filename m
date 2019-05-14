Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 416981CE5A
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2019 19:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfENRyC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 May 2019 13:54:02 -0400
Received: from mga02.intel.com ([134.134.136.20]:60691 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727264AbfENRyC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 May 2019 13:54:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 May 2019 10:54:01 -0700
X-ExtLoop1: 1
Received: from unknown (HELO technocore.fios-router.home) ([10.254.92.80])
  by fmsmga006.fm.intel.com with ESMTP; 14 May 2019 10:54:01 -0700
From:   Todd Brandt <todd.e.brandt@linux.intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        rjw@rjwysocki.net
Cc:     todd.e.brandt@linux.intel.com, todd.e.brandt@intel.com
Subject: [PATCH 0/3] pm-graph 5.4
Date:   Tue, 14 May 2019 10:53:56 -0700
Message-Id: <cover.1557855894.git.todd.e.brandt@linux.intel.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Considerable upgrades to the summary functionality, as well as
new sources of data from turbostat and mcelog. ACPI methods are now
traceable in the timeline as well in dev mode.

Todd Brandt (3):
  Update to pm-graph 5.3
  Update to pm-graph 5.4
  pm-graph 5.4 config and other files

 tools/power/pm-graph/README             | 552 ++++++++++++++++++++
 tools/power/pm-graph/bootgraph.py       |   8 +-
 tools/power/pm-graph/config/example.cfg |  26 +
 tools/power/pm-graph/sleepgraph.8       |  16 +-
 tools/power/pm-graph/sleepgraph.py      | 857 ++++++++++++++++++++++++--------
 5 files changed, 1253 insertions(+), 206 deletions(-)
 create mode 100644 tools/power/pm-graph/README

-- 
2.14.1

