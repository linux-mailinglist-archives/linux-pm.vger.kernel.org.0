Return-Path: <linux-pm+bounces-27983-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEB8ACBE06
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 03:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A6371890EDD
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 01:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F979A937;
	Tue,  3 Jun 2025 01:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="LppgaXle"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AF010E5;
	Tue,  3 Jun 2025 01:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748912578; cv=none; b=LGr/S01uQOILWbgftQ/3dA3zU084BraBSgPfX6rg/p0kjHx43QWy0zBSsUnLJVeet6sYuSjQNdZqYJSftfynlcrXjD7v1fgUp3XgrAut9CK+X/auA0oi0Ib68Co2FvWIA5PXCsATKeN1B2GiHRLwlHpQlLUS2GW8l1w5N5wuLG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748912578; c=relaxed/simple;
	bh=fyPQ/mfs2CSaeT6RM8/3j9A3OgCvFV5ebkXfbNQ6tqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XvTPiYjOCe9Q7CQOdqlT6CGY27bD3jWxyeknXWZZjfn0k/fyUWR01v0s0N/DdXHu/2eRXaloeEeN7dLumSlJwX+JYtZEY6CPQ/gB24FTiL+JHCA1DT4rT0/d9Ca3Z8x5jZ42hqZJ2lSVy4A7iFnM0KG55k0bvFrzxEpOLwpIF3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=LppgaXle; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1748912532;
	bh=A93XqZVqVhYz+KFT6k3LBe2oQch3w3UxJ0GXN9kjeh4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=LppgaXle1ssr0tAAQM/r2gVUSDJDYrpA/5RZ3VgF1ubcANm50K9XKw4fyBjUobOi3
	 JDN7uhnQ0SR68uuRuoHB22OverKxBRbSUDHf6WJPae0zL4168qk5t3GwJC8S7O0CVW
	 sYaMotoMSoOMDJC0hR3+lE1JsKb45y1rdNDFOLOA=
X-QQ-mid: zesmtpip4t1748912524taa33fcd8
X-QQ-Originating-IP: lF+E614tet5TqMgpQePt/nNBt+sipuA1E3BTD/dh+Ts=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 03 Jun 2025 09:02:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12453671181303604206
EX-QQ-RecipientCnt: 8
From: tuhaowen <tuhaowen@uniontech.com>
To: rafael@kernel.org
Cc: tuhaowen@uniontech.com,
	huangbibo@uniontech.com,
	len.brown@intel.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	pavel@kernel.org,
	wangyuli@uniontech.com
Subject: [PATCH v4] PM/console: Fix the black screen issue
Date: Tue,  3 Jun 2025 09:01:57 +0800
Message-Id: <20250603010157.19121-1-tuhaowen@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250526010854.7834-1-tuhaowen@uniontech.com>
References: <20250526010854.7834-1-tuhaowen@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OFwcIyq3IdMxWT3YhTJ2p3yaYIiOcux8PuE6O/BySTnj7so4MhmQTa8J
	KcSccOmUU0hnJ3pZztcH3ITrkWba7pENOLwbr3tO1YbTCeQN1OVYjRb3VlvTFUJ5p6uZSlI
	pTBHgBuc0cAsOAI0grw96Jd5O4VQObqHM3tlbPmgfKbK1sknF4+OR6/X4K+fJ8wNM0rGovg
	YuMMn0jrZr+DeMAygzQ8duhFvN59cUwk1cTWqxKAek4e3FYLbS58yftxzthSTcJfLzpJD6/
	fORSmEP4VVyIgx4iYzldD0jk1nSld5010aIL0o2Yi+vVL2xvQbt3fZouroTfUvtmvZN4aoi
	5w8EWvjbA5zLMd/wJyt/IbnfHLLh3TxmgSP8E0V4eY3ErMAjvLbk5jDOeg2eFIlLbyE+WjZ
	r593bq+iguZ4A701qII5oq9mkhn5EAyKQZQBO0Q7hcMjZXcsZMbzNaf1egnW9yNzSxHaTac
	I3FtRM7mHVD6nq6TLOGRFnfKEmfoGYnHbzYdUnppq4s+DtUDh6g/1xjCx5lr64soOpK8z+y
	7fPcsdK0xGhS7Tx+3NgC2aLwoQotzHO9gFz66OS5BVSS3dCyEzWcAZO3rTzOfi72vxi8P9k
	hfMRhXX7OgJQ0O200gb7pLQgymnCEl1TMbvjOu361+zf4HwNZFj5wulurEqf7drHRn+y/RD
	VC1Q2kaYSiQcYociX7fuO9ULy1CJdZDI23F9oYin/b1wIoc+sCb1Lwg4vq9p+wcrW5+FgtR
	4VdzyX3LwhuPnnUXAIuNFSRWJUq7W2HG7hZexMEhRZz1Qqw4a/770iTGi6+owLNnH79Cu3C
	Ya9ta0zaIhWfu0KUW7nn6E6MZzZlvoeL3cw8Fjr7uPW0raiyX44zGYqbZAQKIWipytWGUjL
	28dyFETHfIjJVaaqnrGXP+xL9e5RxkqRBJ7CGxFAMr9Vdvay7BW3lV9NJJ3CO/txrY7gqpW
	vs/lG3vdqK9AVH8Qh7foJCToRf+1UJZZZOvUyh4kr7JMPrn/phXZcb+IcKxnfRs6h3WfIPY
	N7mFss3rktzcn1P+2fOR5wsX8HY8A=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

When the computer enters sleep status without a monitor
connected, the system switches the console to the virtual
terminal tty63(SUSPEND_CONSOLE).

If a monitor is subsequently connected before waking up,
the system skips the required VT restoration process
during wake-up, leaving the console on tty63 instead of
switching back to tty1.

To fix this issue, a global flag vt_switch_done is introduced
to record whether the system has successfully switched to
the suspend console via vt_move_to_console() during suspend.

If the switch was completed, vt_switch_done is set to 1.
Later during resume, this flag is checked to ensure that
the original console is restored properly by calling
vt_move_to_console(orig_fgconsole, 0).

This prevents scenarios where the resume logic skips console
restoration due to incorrect detection of the console state,
especially when a monitor is reconnected before waking up.

Signed-off-by: tuhaowen <tuhaowen@uniontech.com>
---
Changes in v4:
- Moved `vt_switch_done = false;` below the `if (orig_fgconsole >= 0)`
  block to ensure it is only reset after a console switch has occurred.
- Link to v3: https://lore.kernel.org/all/20250526010854.7834-1-tuhaowen@uniontech.com
- Link to v2: https://lore.kernel.org/all/20250516084011.29309-1-tuhaowen@uniontech.com
- Link to v1: https://lore.kernel.org/all/20250516034643.22355-1-tuhaowen@uniontech.com
---
 kernel/power/console.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/power/console.c b/kernel/power/console.c
index fcdf0e14a47d..19c48aa5355d 100644
--- a/kernel/power/console.c
+++ b/kernel/power/console.c
@@ -16,6 +16,7 @@
 #define SUSPEND_CONSOLE	(MAX_NR_CONSOLES-1)
 
 static int orig_fgconsole, orig_kmsg;
+static bool vt_switch_done;
 
 static DEFINE_MUTEX(vt_switch_mutex);
 
@@ -136,17 +137,21 @@ void pm_prepare_console(void)
 	if (orig_fgconsole < 0)
 		return;
 
+	vt_switch_done = true;
+
 	orig_kmsg = vt_kmsg_redirect(SUSPEND_CONSOLE);
 	return;
 }
 
 void pm_restore_console(void)
 {
-	if (!pm_vt_switch())
+	if (!pm_vt_switch() && !vt_switch_done)
 		return;
 
 	if (orig_fgconsole >= 0) {
 		vt_move_to_console(orig_fgconsole, 0);
 		vt_kmsg_redirect(orig_kmsg);
 	}
+
+	vt_switch_done = false;
 }
-- 
2.20.1


