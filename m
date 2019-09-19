Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C07E1B8130
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 21:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392257AbfISTJO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 15:09:14 -0400
Received: from mga17.intel.com ([192.55.52.151]:63966 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392256AbfISTJO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Sep 2019 15:09:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2019 12:09:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,524,1559545200"; 
   d="scan'208";a="189704708"
Received: from mfwrenn-mobl1.amr.corp.intel.com (HELO technocore.fios-router.home) ([10.251.13.23])
  by orsmga003.jf.intel.com with ESMTP; 19 Sep 2019 12:09:13 -0700
From:   Todd Brandt <todd.e.brandt@linux.intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        rjw@rjwysocki.net
Cc:     todd.e.brandt@linux.intel.com, todd.e.brandt@intel.com,
        len.brown@intel.com
Subject: [PATCH] pm-graph info added to MAINTAINERS
Date:   Thu, 19 Sep 2019 12:09:12 -0700
Message-Id: <20190919190912.8386-1-todd.e.brandt@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b2326dece28e..309ab30d3f07 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12944,6 +12944,15 @@ L:	linux-scsi@vger.kernel.org
 S:	Supported
 F:	drivers/scsi/pm8001/
 
+PM-GRAPH UTILITY
+M:	"Todd E Brandt" <todd.e.brandt@linux.intel.com>
+L:	linux-pm@vger.kernel.org
+W:	https://01.org/pm-graph
+B:	https://bugzilla.kernel.org/buglist.cgi?component=pm-graph&product=Tools
+T:	git git://github.com/intel/pm-graph
+S:	Supported
+F:	tools/power/pm-graph
+
 PNP SUPPORT
 M:	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
 S:	Maintained
-- 
2.17.1

