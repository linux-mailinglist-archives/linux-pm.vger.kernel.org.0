Return-Path: <linux-pm+bounces-27549-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EBAAC1F03
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 10:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EEF416FAC0
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 08:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721BE1DB366;
	Fri, 23 May 2025 08:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="UJ/BTkq8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF03130A73;
	Fri, 23 May 2025 08:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747990662; cv=none; b=l7GwjBCOTrf109dq4LjMxwgSD1T0i4mEYlc3PiEKj+1BwsSYC6oCcu6s9QErdi9MPQ+7ZMzOJ7skD52Tf0YAWkIxl+3gpE86/JFeI9Du3SPJJ0JuQwxglq+bi0ClEHJTKUGmZHQLIGeX01pQRrdbkRAdemAFdb5XIszcqdhqlPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747990662; c=relaxed/simple;
	bh=ga8uMoclPYWxWqyGnwmzZy2O0Wejc180iQMMhqu/Cs8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dQ9DaalxlWmJ/TErgijy1Rdw6T2vd4jGFmjtUhbcx6dOVijWdO/FPGF4e2qnpewFspl+1hkVJO9bYFl9Cd5iTfgKKFpO4simd7CV/N1hnZnZSuf/fkZvRTt1eVuSjA8Wa4qntFycvsQi2t567SBXmaHKm93JW1dnx2vJ4sFatpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=UJ/BTkq8; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1747990621;
	bh=c1YnD1TyFT+luDI+a7+0AZCF+F460a+LPXJtzr8FLFQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=UJ/BTkq8uKWwcUWY/AEduOBs8SrfU0lBTlYU08HB4AlJl84hm/KuKHvBCSnBQHlwd
	 h52pLupOAKg8mcOlGy+JEKtOIrjGLkHyhV8c18QxhHJ5+oKvVLuxE+3EGffSj8EP0D
	 iLnzOdXpNK7VSVyqPyTMI0RV4gO5SDoHSGI8vxGQ=
X-QQ-mid: zesmtpip2t1747990613t07ec8783
X-QQ-Originating-IP: X+q69QVHxeVfV8dFVJrxXnlHpZthXdCoQEBiqJs0Cnc=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 23 May 2025 16:56:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8656696932818907079
EX-QQ-RecipientCnt: 8
From: tuhaowen <tuhaowen@uniontech.com>
To: pavel@kernel.org,
	len.brown@intel.com,
	rafael@kernel.org
Cc: tuhaowen@uniontech.com,
	huangbibo@uniontech.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	wangyuli@uniontech.com
Subject: [PATCH v2 RESEND] PM/console: Fix the black screen issue
Date: Fri, 23 May 2025 16:56:45 +0800
Message-Id: <20250523085645.17695-1-tuhaowen@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250516084011.29309-1-tuhaowen@uniontech.com>
References: <20250516084011.29309-1-tuhaowen@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NRN3UPsLzYKVYGzjsdZpHcg1VTcyVaS3mWO+OOmk5FFwjcikLkOYVkZc
	2H2OacPOSbbNI20ke/Tvl7I3qpTRBGofI5ZmCgdfQlqo2OsLPQx03VR+yuO6CTLq5nkf7by
	Q2KDZDQLaaOnzV+QB4CyR7peU5rxxrTyzRXLD6fRoLPo9VtWD2iCROSQIU5Z+JDiNxjSOcv
	DAXK4lptsMRyB9/rRLcRBuTsBOaiIHv/1azNcCjShTAtzc0LtF+khr5GhtXCS7MCmNyqiLX
	D9lvIDzeGEM0dF69qRH2n4G3JhxrvB1epXic/+Jm2RK9gqhqcyql/u7wLrU0JRmcATY9vWy
	mDsc49nplGcJDXoEmWf1Mv28nqtG1/NDGkYoR37A7QrPn3wVQ4wjn4ykkTYLv7Y7LdGXf38
	/XvSsiiIn6n1VigEmT+16BhCpUEAbnjD7+s3eB0kqJEMeWg6hLRE+9oLZCIP7g766Y5oRxe
	g4h9dTVMwU8mP2jgWr/XHUSJAKgu+hKeFZyFCASfwqEZGCT5TlXymH15PNB9udG42KH3evh
	+b05JbCIZbkH2SK5nNk9FL01ql5F0lJqL34KXTv44ahKyh1RQyq9XTpGVZcdfDmf729OVxs
	nXapkPuee3a9j1CLWE7NPnxIeYUP6qJLfMocaimXi+WyukPEepNjt9KXjYqkUbNLjVBvTKH
	pT7sDvvZaHoW9SYzi9D09fYI2fDOS3FzhzUDCX/2Wi418obuyE06378b3BfxVnd13DEc5e0
	uQELhXsI4uL9IduhmXvQMMnVUkU4qBtmL/vswumu1OnWWf40MA+ck12n7EfBMUpqmTthx+l
	7d8GZ0H1Od/TxeWs9MgpbR8P5uxS4B0715KDnsdIMxbfPC+pwHCJhDBZmgEqBK5JGbGUzFQ
	77dhJZBPQMW9M9OyNJhQNHXWuo17di2Nxsmel48i/S8ymCZ8rCkllUHMn4agiygHvjf3KRY
	6mpV9yXO4dzwJxQV/gjALQCx0YilP1K85aJyQgvm6ZwGrJAFDh3PZHjMG42J2/taedKrfXm
	byxOaoiw10abC2lpVb01AbovyO86Y=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
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
Changes in v2:
- Added explanation in the commit message on how the issue is fixed.
- Link to v1: https://lore.kernel.org/all/20250516034643.22355-1-tuhaowen@uniontech.com
---
 kernel/power/console.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/power/console.c b/kernel/power/console.c
index fcdf0e14a47d..832e04bf5439 100644
--- a/kernel/power/console.c
+++ b/kernel/power/console.c
@@ -16,6 +16,7 @@
 #define SUSPEND_CONSOLE	(MAX_NR_CONSOLES-1)
 
 static int orig_fgconsole, orig_kmsg;
+static int vt_switch_done;
 
 static DEFINE_MUTEX(vt_switch_mutex);
 
@@ -136,15 +137,19 @@ void pm_prepare_console(void)
 	if (orig_fgconsole < 0)
 		return;
 
+	vt_switch_done = 1;
+
 	orig_kmsg = vt_kmsg_redirect(SUSPEND_CONSOLE);
 	return;
 }
 
 void pm_restore_console(void)
 {
-	if (!pm_vt_switch())
+	if (!pm_vt_switch() && !vt_switch_done)
 		return;
 
+	vt_switch_done = 0;
+
 	if (orig_fgconsole >= 0) {
 		vt_move_to_console(orig_fgconsole, 0);
 		vt_kmsg_redirect(orig_kmsg);
-- 
2.20.1


