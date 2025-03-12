Return-Path: <linux-pm+bounces-23904-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B10A5D766
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 08:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B5D617A695
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 07:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C145A1F03C2;
	Wed, 12 Mar 2025 07:38:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC761EFFA0;
	Wed, 12 Mar 2025 07:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741765085; cv=none; b=uoluRYSQdZO71DP4wYsVC3JYbSqAkGhh8JX5gG2ESMny80/lYhn+fDBgUMItFi5Tvv0vi/dN1jPwrkvk7jvsEiWi1lSKEcF8JCqsOIzUDelW+7hZD/76bObgCCL6+YoTsYbID7Yf/WiASqC/aejPx86Vc0pdThaK7sTr/cXDW6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741765085; c=relaxed/simple;
	bh=kPxDmp3bNU+SrN1H+9TwyTdeRqaYQeKep/ARnX59Og4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aFGjNYrlHpbfVXjd4w0ATDazNEi2zcGAwhBHFzJLnY5RK4VdXVPlg1qEU/kc1pD05xjgyybcjClATuS74tB+u5VqISHjbmU9eb28291AlQ5iQ3eoQf8za4W7lrbDzjxEz1M44WHqfCT1GHtmBGCJ0r4+s0R1JgO9YLY9V8bAfX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-01 (Coremail) with SMTP id qwCowADX39PTOdFn7DZ9FA--.4424S2;
	Wed, 12 Mar 2025 15:37:56 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: sre@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] power: supply: mt6370: Remove redundant 'flush_workqueue()' calls
Date: Wed, 12 Mar 2025 15:37:29 +0800
Message-Id: <20250312073729.1430053-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADX39PTOdFn7DZ9FA--.4424S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKF1xZFy7tr1DuryrtFyxZrb_yoW3tFcE93
	y7Ja4kKrWDWF1jk34Dtr1rXFyvk3srZF17Aan0qry3Ka4Y9wn0yryDZF40qr1UX34UGrnx
	ZasIgay3Zr9rGjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbV8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r1q6r43MxkIecxEwVAFwVW8CwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
	DU0xZFpf9x0JUHuWLUUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

'destroy_workqueue()' already drains the queue before destroying it, so
there is no need to flush it explicitly.

Remove the redundant 'flush_workqueue()' calls.

This was generated with coccinelle:

@@
expression E;
@@
- flush_workqueue(E);
  destroy_workqueue(E);

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/power/supply/mt6370-charger.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/power/supply/mt6370-charger.c b/drivers/power/supply/mt6370-charger.c
index a6939c6059c7..98579998b300 100644
--- a/drivers/power/supply/mt6370-charger.c
+++ b/drivers/power/supply/mt6370-charger.c
@@ -772,7 +772,6 @@ static void mt6370_chg_destroy_wq(void *data)
 {
 	struct workqueue_struct *wq = data;
 
-	flush_workqueue(wq);
 	destroy_workqueue(wq);
 }
 
-- 
2.25.1


