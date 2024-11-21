Return-Path: <linux-pm+bounces-17841-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEAC9D46F8
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 05:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21B51F222DA
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 04:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D364B13B59E;
	Thu, 21 Nov 2024 04:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dgsZv4of"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B7F13BC0E;
	Thu, 21 Nov 2024 04:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732164704; cv=none; b=UmccYZRHB4IgRJgzZaQH5e6y2TAbq2vAaXpK8WnVD1r7B0rTXozMrDD35w7/UtLNAgSfyCGgbh/5vXfLoOm1ZOCHk6EMoRdCVhFuagmbAZUXegPul3TceVYoLwwNc/dCCbWxPOuJb1/qS5ZQRvMue6J5Y6wZiAaw7qsHM9dCjyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732164704; c=relaxed/simple;
	bh=bp/gBvv620y1D/z62I8Fj8hOJD08AiQeAqZ8SoTXwV0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZIwT+UQ+WiIgi+LQQz0ng3tG203ah2b7cIjkSz3z4Ltye4IzMwFLPwsKfJ2RxyAOjGNySwnrLQsy0Z9JySYRngkPYChnU9LS/67+NVwovMGqqQolVDqfiRXE0+QXcaaz+ouSwTXup97fK3K9y7H9i8HmXhS1w8jhuShMFSOTTTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dgsZv4of; arc=none smtp.client-ip=192.19.144.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 18A63C000C9D;
	Wed, 20 Nov 2024 20:43:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 18A63C000C9D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1732164235;
	bh=bp/gBvv620y1D/z62I8Fj8hOJD08AiQeAqZ8SoTXwV0=;
	h=From:To:Cc:Subject:Date:From;
	b=dgsZv4ofHQ0qxyLjfssoC6M6hgvs0OAQK+ummiBcT4CoGda0LR4ZVzgBfuepT+SpA
	 SHhisNbH23goT02Yxl2LcUzbuyn0coOuZTeSfKUw7lvzX8eN5SAs/IdC7YaHhY1XXl
	 sZYaKCOyd+/z0hzsul97sU/5iluEkTZxiG9qtazU=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id BD0C518041CAC6;
	Wed, 20 Nov 2024 20:43:54 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Peng Fan <peng.fan@nxp.com>,
	linux-pm@vger.kernel.org (open list:CPU POWER MONITORING SUBSYSTEM)
Subject: [PATCH] pm: cpupower: Makefile: Fix cross compilation
Date: Wed, 20 Nov 2024 20:43:53 -0800
Message-Id: <20241121044353.1753244-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After f79473ed9220 ("pm: cpupower: Makefile: Allow overriding
cross-compiling env params") we would fail to cross compile cpupower in
buildroot which uses the recipe at [1] where only the CROSS variable is
being set.

The issue here is the use of the lazy evaluation for all variables: CC,
LD, AR, STRIP, RANLIB, rather than just CROSS.

[1]:
https://git.buildroot.net/buildroot/tree/package/linux-tools/linux-tool-cpupower.mk.in

Fixes: f79473ed9220 ("pm: cpupower: Makefile: Allow overriding cross-compiling env params")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Change-Id: Id98f2c648c82c08044b7281714bc6a8e921629ad
---
 tools/power/cpupower/Makefile | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index 175004ce44b2..96bb1e5f3970 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -87,11 +87,11 @@ INSTALL_SCRIPT = ${INSTALL} -m 644
 # to something more interesting, like "arm-linux-".  If you want
 # to compile vs uClibc, that can be done here as well.
 CROSS ?= #/usr/i386-linux-uclibc/usr/bin/i386-uclibc-
-CC ?= $(CROSS)gcc
-LD ?= $(CROSS)gcc
-AR ?= $(CROSS)ar
-STRIP ?= $(CROSS)strip
-RANLIB ?= $(CROSS)ranlib
+CC = $(CROSS)gcc
+LD = $(CROSS)gcc
+AR = $(CROSS)ar
+STRIP = $(CROSS)strip
+RANLIB = $(CROSS)ranlib
 HOSTCC = gcc
 MKDIR = mkdir
 
-- 
2.34.1


