Return-Path: <linux-pm+bounces-20655-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D15ABA16236
	for <lists+linux-pm@lfdr.de>; Sun, 19 Jan 2025 15:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BC4D1644D5
	for <lists+linux-pm@lfdr.de>; Sun, 19 Jan 2025 14:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DB31DED70;
	Sun, 19 Jan 2025 14:39:12 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1893B1C68A6
	for <linux-pm@vger.kernel.org>; Sun, 19 Jan 2025 14:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737297552; cv=none; b=I33H+/ig/2HU4Oqd2iiXNlmBmBS4ASKlnTeGrZZnENYpmZQBvYz8cghNECgcEbeCm+QI+6s/KPw3cPpPgOtblYJYYA5KmDhUxo5eHUc9yy+1HJhv0dV/kqyR9o5V+wDgIHfSCN4QR+MEaPbtDrRMBHM+MFIRNEZbmM/fg/+wJwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737297552; c=relaxed/simple;
	bh=cXH03GzoOH91H4XGZV5QdmIV6z49MPb/7cP0A0xBBFw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qr5/Zglch7opURUvo9talQYuIAoLJFqCquSmhjItF7wqPevOALTxK6IVZYGttTzMNxmSy8j5hJ4LfWnhwgF+o1sPHEb4ywxcuyIMdBsVvzKN8nygwtrnVav5H7Grv+/w8yclflyo199F1fUWRaLMXf9RDb+NFBrqpEcYjxk6GoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [220.197.226.102])
	by APP-01 (Coremail) with SMTP id qwCowAAHNPv4DI1ngjU9CA--.14058S2;
	Sun, 19 Jan 2025 22:32:29 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: rafael@kernel.org,
	quic_nprakash@quicinc.com,
	liangwentao@iscas.ac.cn
Cc: linux-pm@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] PM: hibernate: Add error handling for syscore_suspend()
Date: Sun, 19 Jan 2025 22:32:05 +0800
Message-ID: <20250119143205.2103-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAHNPv4DI1ngjU9CA--.14058S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr4kGrW3GrykuF1UXFyfCrg_yoW8XryUp3
	4xG3ykt348GFyjya1xtFy0vFWkC395K3y5CFWkGw4fAwnxCwnYgr1Yqr1YqFW0krW5Ga18
	Xr12y3ykZFy7CF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUjuHq7
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQ4HA2eMvrtizgAAsB

In hibernation_platform_enter(), the code did not check the
return value of syscore_suspend(), potentially leading to a
situation where syscore_resume() would be called even if
syscore_suspend() failed. This could cause unpredictable
behavior or system instability.

This commit modifies the suspend/resume sequence to properly
handle errors returned by syscore_suspend(). If an error occurs
during the suspend process, the code now jumps to 'Enable_irqs'
label, skipping the resume call, and only enabling interrupts
after setting the system state to SYSTEM_RUNNING.

Fixes: 40dc166cb5dd ("PM / Core: Introduce struct syscore_ops for core subsystems PM")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 kernel/power/hibernate.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 1f87aa01ba44..8e5702811732 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -608,7 +608,11 @@ int hibernation_platform_enter(void)
 
 	local_irq_disable();
 	system_state = SYSTEM_SUSPEND;
-	syscore_suspend();
+
+	error = syscore_suspend();
+	if (error)
+		goto Enable_irqs;
+
 	if (pm_wakeup_pending()) {
 		error = -EAGAIN;
 		goto Power_up;
@@ -620,6 +624,7 @@ int hibernation_platform_enter(void)
 
  Power_up:
 	syscore_resume();
+ Enable_irqs:
 	system_state = SYSTEM_RUNNING;
 	local_irq_enable();
 
-- 
2.42.0.windows.2


