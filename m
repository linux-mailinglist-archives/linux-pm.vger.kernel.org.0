Return-Path: <linux-pm+bounces-27630-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F35A8AC378A
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 03:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A46E41710B4
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 01:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB45433D9;
	Mon, 26 May 2025 01:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="dgt9sDO6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B99EEB5;
	Mon, 26 May 2025 01:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748221784; cv=none; b=dTq2OYwAsXDvmcDwBR54BichkspwoGX3n9ChciLPgv3U6EN5DpQsShLjBKSRNt8XK67Izkhq0QRpId3punk6fsTa04rGbpCXcCeoZJwyljAWXcfMbZqp5mSi8TvFIy6/0v4WM6cAjwRtHMxZoBJqSkMvhzz1e9A0oF4nDE3tlXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748221784; c=relaxed/simple;
	bh=lyQbcMnMs8dX4DMzsRHTjruddW9G7tL/vXLm73bUpXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pLit5+l4E1YyaQVG2OW7ZuB2MKjNZGRk1guoNNQFPLPUS1vtTqWxEtZmD/SJyx7QTJkWBNd4EK+wePqS4V46fAndFsUMtlQL9uNfno+TDcYpv1XiWZWwaAzypPDEPFBfmaALLbv3uPT98Eg5SdxnRXBnfSC1Qz8CiiqEMagw7r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=dgt9sDO6; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1748221749;
	bh=0Vtc3S2mEro9O/XVJHGv22xQ3o76ZyvNYJM4dyAwtnw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=dgt9sDO689Wi5nGqPV1fjq88O628b/cy2LcLM9btd4zOOct+QvZL+/yfNF7WPD4q8
	 +PgIPxwqtgX8Vs0Ubv/dLBLrsVn4GymFmXDoilnSumis+kEKOJ/rGj1rU8bqiq49bR
	 EGI9HmxTEgbAW6SzOem3/7uPv/v3Rt02U9weT+2s=
X-QQ-mid: zesmtpip2t1748221739t553697ba
X-QQ-Originating-IP: eUnGCWoyBzA2+FGT0SFHQPqzlWFCJXGLdr9ji9qQKfs=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 26 May 2025 09:08:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10172135018990717116
EX-QQ-RecipientCnt: 8
From: tuhaowen <tuhaowen@uniontech.com>
To: rafael@kernel.org
Cc: huangbibo@uniontech.com,
	len.brown@intel.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	pavel@kernel.org,
	tuhaowen@uniontech.com,
	wangyuli@uniontech.com
Subject: [PATCH v3] PM/console: Fix the black screen issue
Date: Mon, 26 May 2025 09:08:54 +0800
Message-Id: <20250526010854.7834-1-tuhaowen@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CAJZ5v0jazfh7A8-6werFtsQ=XOYzDioYh19p4S4v=0to2Na4Hw@mail.gmail.com>
References: <CAJZ5v0jazfh7A8-6werFtsQ=XOYzDioYh19p4S4v=0to2Na4Hw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OQNQM5UP8StMNVxiEF9KO90pLI83zZkp1BXVXv0FlKAuNWI+HzXGNM81
	iDroMDgXmijz63lzi70iM4UI+yvGSZyBEQJZYzxlz8B75lPGMpdtgc9YbB661Ttmb0lk6YC
	9kdqUlm/LyzBwPO+pdLIUrMxHpt2q/4RjunYuCf+3932pjpP58GowkwZWovfpH2KB8PU2pz
	nF7E9sN+acM9qTUpQu1AoEcROzqf1RJJYTptkKFQdimySqkLeKAcFLygvtHwl+IgnAAGAWc
	kEmhzb2RQ/XfheZy4l+zi7jM4klsS+aGomx1mWMGQeEDA74Ya2qYdtkCWIgi9QmzLQ307y3
	3FowIqs3ae+aB2eWd9M317tEiaDePEtb969owGRTtmf4G+M5yw/60smDqyU4gxBJkEioH/X
	dSdoHtoOPRtc4gUBuuRBg/A5sBJB7eoQ51VJa+xURQg96bozxLJYOFc1B7gtRhWIrhDzdq1
	feI5MD4eBsdjjctYH8gmFITXXMEZiGf6vvp2d/DypZf8q30tXe+YStgOKDtt+9wAGpzrOfm
	tFGRxBpXTaqgE+rxArpU7I+0L+jFbTHeC6N0Io1a5XSFiVBp0rjIaJVCuIQJ6Wgn9u9iYBV
	HVxDxSRarWcqqczYcMl4e7BQ6H0rmnVUKZR8VUufHbVd4HE/8JbacM6oNVKmhiaCUo8boKQ
	ablzDDzFGLFgHt1bMZiByHss2uTMY4LSM6hHY0XCqTo1KAj4Mq2wps1Jg8Onrpq8YXHZjkf
	d5oWgB9LlFwQLaolyBYq4RSGY6UJa/l9oupweCw8xYZb1P9LNsFsf561fNt/H4TQJXZFi9J
	hsri9iegq4k0dj5pMwDuVp1b4F8r+Bjp9kAQbSHVQR1JZPeMljPUv20W4zi7iDRE58xBMR+
	e/uVoV0pIfgqSEhCwG2MzEUIie1tSrHQCJY00NmG4Xy/Ty5g9TCfeRlxSj4Nuu50RPbayLp
	JUgYiLsFJMZIRm/ihIWVDJBIx3dbBMQlPK9Qkf5/a3bVKG4JMc5RytNkePVPfrMou9QM1Sg
	2EYf/LVBFy0eFzOveY
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
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
Changes in v3:
- Changed the type of `vt_switch_done` from `int` to `bool`.
- Link to v2: https://lore.kernel.org/all/20250516084011.29309-1-tuhaowen@uniontech.com
- Link to v1: https://lore.kernel.org/all/20250516034643.22355-1-tuhaowen@uniontech.com
---
 kernel/power/console.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/power/console.c b/kernel/power/console.c
index fcdf0e14a47d..2a0722038f02 100644
--- a/kernel/power/console.c
+++ b/kernel/power/console.c
@@ -16,6 +16,7 @@
 #define SUSPEND_CONSOLE	(MAX_NR_CONSOLES-1)
 
 static int orig_fgconsole, orig_kmsg;
+static bool vt_switch_done;
 
 static DEFINE_MUTEX(vt_switch_mutex);
 
@@ -136,15 +137,19 @@ void pm_prepare_console(void)
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
 
+	vt_switch_done = false;
+
 	if (orig_fgconsole >= 0) {
 		vt_move_to_console(orig_fgconsole, 0);
 		vt_kmsg_redirect(orig_kmsg);
-- 
2.20.1


