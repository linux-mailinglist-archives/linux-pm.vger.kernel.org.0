Return-Path: <linux-pm+bounces-2470-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0F18364A1
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jan 2024 14:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90EB11C23464
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jan 2024 13:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAE53D0A0;
	Mon, 22 Jan 2024 13:44:53 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3173CF59
	for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2024 13:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705931093; cv=none; b=M6MuSOQDWkOce73TkZScXg8lsljCG05qZJ8jV6yJZY2avfb8XhWL2twuV4fPWYrKBJLRWyQwOy3Z1Uwk2kTOVu5BKkcB7YV21fdD2ot4YO5oIQsgGK27LjaB5JaWFs3d8AhNx+GeO5gqeefPHEIwXZTy7BM4uzIBXvRODJNfg98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705931093; c=relaxed/simple;
	bh=Ws1i+RPwsccyora2CDuFVgafFOxIP4PCN3rla7F9MVw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iSO6g/QZLpe68OmtegWTUCymmx0rhfIl8y6FAEzWmwE0aPDSKPUNiypL11PmjmBS35raXAL0HcqXn+wqxs9lxIi9PcOhal30oCnVE/DbvZF1dJ3QYm3hwzdcToZ4xwGpUJKGVuxWtmIKBLW0RiqUq5r7L9vDu0PGQDacwxvnafY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:955e:bba5:7ff4:cfb6])
	by albert.telenet-ops.be with bizsmtp
	id dpkj2B0070ZxL6o06pkj2V; Mon, 22 Jan 2024 14:44:43 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rRuaf-00GGvC-W1;
	Mon, 22 Jan 2024 14:44:43 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rRubT-00CDuK-08;
	Mon, 22 Jan 2024 14:44:43 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] pmdomain: renesas: rcar-gen4-sysc: Remove unneeded includes
Date: Mon, 22 Jan 2024 14:44:41 +0100
Message-Id: <5b440f84ab8b52499ab307c84154dcbc0f41d1d7.1705931035.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The R-Car V3U System Controller (SYSC) driver no longer needs these
includes since the factoring out of the common R-Car Gen4 SYSC driver in
commit e62906d6315f652b ("soc: renesas: rcar-gen4-sysc: Introduce R-Car
Gen4 SYSC driver").

The R-Car S4-8 and V4H SYSC drivers never needed these includes, as
these drivers always used the common R-Car Gen4 SYSC driver.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pmdomain/renesas/r8a779a0-sysc.c | 12 ------------
 drivers/pmdomain/renesas/r8a779f0-sysc.c | 12 ------------
 drivers/pmdomain/renesas/r8a779g0-sysc.c | 12 ------------
 3 files changed, 36 deletions(-)

diff --git a/drivers/pmdomain/renesas/r8a779a0-sysc.c b/drivers/pmdomain/renesas/r8a779a0-sysc.c
index 04f1bc322ae7b671..54cdf250f7c2d143 100644
--- a/drivers/pmdomain/renesas/r8a779a0-sysc.c
+++ b/drivers/pmdomain/renesas/r8a779a0-sysc.c
@@ -5,19 +5,7 @@
  * Copyright (C) 2020 Renesas Electronics Corp.
  */
 
-#include <linux/bits.h>
-#include <linux/clk/renesas.h>
-#include <linux/delay.h>
-#include <linux/err.h>
-#include <linux/io.h>
-#include <linux/iopoll.h>
 #include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/of_address.h>
-#include <linux/pm_domain.h>
-#include <linux/slab.h>
-#include <linux/spinlock.h>
-#include <linux/types.h>
 
 #include <dt-bindings/power/r8a779a0-sysc.h>
 
diff --git a/drivers/pmdomain/renesas/r8a779f0-sysc.c b/drivers/pmdomain/renesas/r8a779f0-sysc.c
index 5602aa6bd7ed1529..6ed13cd1cb249df5 100644
--- a/drivers/pmdomain/renesas/r8a779f0-sysc.c
+++ b/drivers/pmdomain/renesas/r8a779f0-sysc.c
@@ -5,19 +5,7 @@
  * Copyright (C) 2021 Renesas Electronics Corp.
  */
 
-#include <linux/bits.h>
-#include <linux/clk/renesas.h>
-#include <linux/delay.h>
-#include <linux/err.h>
-#include <linux/io.h>
-#include <linux/iopoll.h>
 #include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/of_address.h>
-#include <linux/pm_domain.h>
-#include <linux/slab.h>
-#include <linux/spinlock.h>
-#include <linux/types.h>
 
 #include <dt-bindings/power/r8a779f0-sysc.h>
 
diff --git a/drivers/pmdomain/renesas/r8a779g0-sysc.c b/drivers/pmdomain/renesas/r8a779g0-sysc.c
index b932eba1b8042d8f..249cf43af45b6445 100644
--- a/drivers/pmdomain/renesas/r8a779g0-sysc.c
+++ b/drivers/pmdomain/renesas/r8a779g0-sysc.c
@@ -5,19 +5,7 @@
  * Copyright (C) 2022 Renesas Electronics Corp.
  */
 
-#include <linux/bits.h>
-#include <linux/clk/renesas.h>
-#include <linux/delay.h>
-#include <linux/err.h>
-#include <linux/io.h>
-#include <linux/iopoll.h>
 #include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/of_address.h>
-#include <linux/pm_domain.h>
-#include <linux/slab.h>
-#include <linux/spinlock.h>
-#include <linux/types.h>
 
 #include <dt-bindings/power/r8a779g0-sysc.h>
 
-- 
2.34.1


