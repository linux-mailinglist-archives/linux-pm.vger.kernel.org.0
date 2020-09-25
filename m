Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEF0278C54
	for <lists+linux-pm@lfdr.de>; Fri, 25 Sep 2020 17:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgIYPQl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Sep 2020 11:16:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:59786 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728527AbgIYPQk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 25 Sep 2020 11:16:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C6B13B02E;
        Fri, 25 Sep 2020 15:16:39 +0000 (UTC)
From:   Thomas Renninger <trenn@suse.de>
To:     linux-pm@vger.kernel.org
Cc:     rafael@kernel.org, Len Brown <len.brown@intel.com>
Subject: tools/x86_energy_perf_policy: Make destination directories overridable via env variable
Date:   Fri, 25 Sep 2020 17:16:38 +0200
Message-ID: <1677754.PRGFiW9HIp@c100>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

cmp with other tools/../Makefiles:
tools/lib/bpf/Makefile
tools/lib/traceevent/Makefile
...

and consolidate 2 install calls to one without any functional change.

Signed-off-by: Thomas Renninger <trenn@suse.de>

---
 tools/power/x86/x86_energy_perf_policy/Makefile |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

--- a/tools/power/x86/x86_energy_perf_policy/Makefile
+++ b/tools/power/x86/x86_energy_perf_policy/Makefile
@@ -1,8 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 CC		= $(CROSS_COMPILE)gcc
-BUILD_OUTPUT    := $(CURDIR)
-PREFIX		:= /usr
-DESTDIR		:=
+BUILD_OUTPUT    ?= $(CURDIR)
+PREFIX		?= /usr
+mandir          ?= $(PREFIX)/share/man
+DESTDIR		?=
 
 ifeq ("$(origin O)", "command line")
 	BUILD_OUTPUT := $(O)
@@ -22,8 +23,6 @@
 	@rm -f $(BUILD_OUTPUT)/x86_energy_perf_policy
 
 install : x86_energy_perf_policy
-	install -d  $(DESTDIR)$(PREFIX)/bin
-	install $(BUILD_OUTPUT)/x86_energy_perf_policy $(DESTDIR)$(PREFIX)/bin/x86_energy_perf_policy
-	install -d  $(DESTDIR)$(PREFIX)/share/man/man8
-	install -m 644 x86_energy_perf_policy.8 $(DESTDIR)$(PREFIX)/share/man/man8
+	install -D $(BUILD_OUTPUT)/x86_energy_perf_policy $(DESTDIR)$(PREFIX)/bin/x86_energy_perf_policy
+	install -D -m 644 x86_energy_perf_policy.8 $(DESTDIR)$(mandir)/man8/x86_energy_perf_policy.8
 



