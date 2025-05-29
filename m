Return-Path: <linux-pm+bounces-27784-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4748FAC75B9
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 04:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F628188F246
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 02:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1B6242D67;
	Thu, 29 May 2025 02:13:30 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4895220E00A;
	Thu, 29 May 2025 02:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748484809; cv=none; b=ekwpvuWATQvd1Xim3rqC+6WIvsICmeFNUvwBi19OJWHWMHPr1V0WtX/4edcxUJSyMO5u0v95ScwJYS3Oh7tVqm7SVowFVXLjHdS2Lw6xKzA0+rRXmooza6lndBr3DLi/mIb4A8/AjDjz0MKjP/hf6BC1NW2RXaoavsCn6T1T6UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748484809; c=relaxed/simple;
	bh=mZSanUQe638eriD7FH82IeJDDHhT6E7XOweAzZTdoiY=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=an+J1qvjG1u7/EE/ZheecSioOZcBZuFa239fxUyKHf6jxK8p1xiB6BwvQw0ZjAgFBLNXuGd1xWTVAn8DE1uHo2q9TeiwUW9LHhd8l2gx3moZ6vLwIXPvEMPJbIe9uy23p0sJErocmnio77++g2yo5amIcWohC3eFziBMsIqmzHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4b78zj6vF7z51SYf;
	Thu, 29 May 2025 10:13:21 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 54T2D4GR008680;
	Thu, 29 May 2025 10:13:04 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 29 May 2025 10:13:05 +0800 (CST)
Date: Thu, 29 May 2025 10:13:05 +0800 (CST)
X-Zmail-TransId: 2afb6837c2b10a1-40778
X-Mailer: Zmail v1.0
Message-ID: <20250529101305686S2ehGmiFg5bnKwSa__96W@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <ulf.hansson@linaro.org>
Cc: <geert+renesas@glider.be>, <magnus.damm@gmail.com>,
        <linux-pm@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yang.yang29@zte.com.cn>,
        <xu.xin16@zte.com.cn>, <yang.tao172@zte.com.cn>,
        <ye.xingchen@zte.com.cn>
Subject: =?UTF-8?B?cG1kb21haW46IHJlbmVzYXM6IHJjYXI6IFVzZSBzdHJfb25fb2ZmKCkgaGVscGVyIGluwqByY2FyX3N5c2NfcG93ZXIoKSBhbmQgcmNhcl9nZW40X3N5c2NfcG93ZXIoKQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 54T2D4GR008680
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6837C2C1.000/4b78zj6vF7z51SYf

From: Shao Mingyin <shao.mingyin@zte.com.cn>

Remove hard-coded strings by using the str_on_off() helper function.

Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
 drivers/pmdomain/renesas/rcar-gen4-sysc.c | 3 ++-
 drivers/pmdomain/renesas/rcar-sysc.c      | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/renesas/rcar-gen4-sysc.c b/drivers/pmdomain/renesas/rcar-gen4-sysc.c
index e001b5c25bed..c8aa7538e95f 100644
--- a/drivers/pmdomain/renesas/rcar-gen4-sysc.c
+++ b/drivers/pmdomain/renesas/rcar-gen4-sysc.c
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
+#include <linux/string_choices.h>

 #include "rcar-gen4-sysc.h"

@@ -171,7 +172,7 @@ static int rcar_gen4_sysc_power(u8 pdr, bool on)
  out:
 	spin_unlock_irqrestore(&rcar_gen4_sysc_lock, flags);

-	pr_debug("sysc power %s domain %d: %08x -> %d\n", on ? "on" : "off",
+	pr_debug("sysc power %s domain %d: %08x -> %d\n", str_on_off(on),
 		 pdr, ioread32(rcar_gen4_sysc_base + SYSCISCR(reg_idx)), ret);
 	return ret;
 }
diff --git a/drivers/pmdomain/renesas/rcar-sysc.c b/drivers/pmdomain/renesas/rcar-sysc.c
index 047495f54e8a..dae01ca0ef6a 100644
--- a/drivers/pmdomain/renesas/rcar-sysc.c
+++ b/drivers/pmdomain/renesas/rcar-sysc.c
@@ -17,6 +17,7 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/soc/renesas/rcar-sysc.h>
+#include <linux/string_choices.h>

 #include "rcar-sysc.h"

@@ -162,7 +163,7 @@ static int rcar_sysc_power(const struct rcar_sysc_pd *pd, bool on)

 	spin_unlock_irqrestore(&rcar_sysc_lock, flags);

-	pr_debug("sysc power %s domain %d: %08x -> %d\n", on ? "on" : "off",
+	pr_debug("sysc power %s domain %d: %08x -> %d\n", str_on_off(on),
 		 pd->isr_bit, ioread32(rcar_sysc_base + SYSCISR), ret);
 	return ret;
 }
-- 
2.25.1

