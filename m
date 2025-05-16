Return-Path: <linux-pm+bounces-27225-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EF4AB9501
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 05:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E023E1BA657A
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 03:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA52F1D6DBB;
	Fri, 16 May 2025 03:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="G4dNYCWR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B585D14012;
	Fri, 16 May 2025 03:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747367248; cv=none; b=CjawvP3uv9uquH0IGME3gbsBNEGl481l4/GB6KhKuNKiptM61qr3JWLn78nEtfXadPN/almshlxvWOrictPCvN/DhxC2py7KnPbLvoA5c4QJxBK5iYI4LClRpUIjLvAynVBeXnm0Z3LqTXgYZ0aRmQ/kA4hhYulxXJB1D9axfOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747367248; c=relaxed/simple;
	bh=s2rihKl9XDtBH5mPiYwlPCYKyYdViNQfkjpgYaOGXVw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gAmx49Ll+3uD0o+CkiuwrbyOyCkFnfoopKg4D0dkjXou1L0d8dNKlbKx5pBoe58LVS1n+7FoQY2EMp06e3I2VNc7/QHyuTM0YX3OXlI6OMhF6d2inSEg1ope0puob2mPkERFcFm+G1MzeaT4dkWdo8ys9tM7HQ3mxvpvvVIEYm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=G4dNYCWR; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1747367215;
	bh=1KyIl7Rv4fR9Xm7x89ddsmf0zM0jgC8Wn8zmDSvEkX8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=G4dNYCWR8qcFqAw6Euzl76lpYCNB87LEWkOEe2dFvsftdp+UbEAn7hnf1+0jmSWCh
	 c5pgO9cfxbtY5oibkS3Ld5JUBYzD/KFXPH4WM6Iev/YiGg3RzfsA+Pe0jysxWnqBEy
	 Gigpyu6hRLNMriHqvT6YSyVlb42l3cdpTR0ALeoA=
X-QQ-mid: zesmtpip2t1747367207tc0f146ca
X-QQ-Originating-IP: vgaBzqfMUuElUlGxB27jZgCiRCcjbDssB8bQ6mUogdg=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 16 May 2025 11:46:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5041222066668530054
EX-QQ-RecipientCnt: 7
From: tuhaowen <tuhaowen@uniontech.com>
To: pavel@kernel.org,
	len.brown@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	huangbibo@uniontech.com,
	wangyuli@uniontech.com,
	tuhaowen <tuhaowen@uniontech.com>
Subject: [PATCH] PM/console: Fix the black screen issue
Date: Fri, 16 May 2025 11:46:43 +0800
Message-Id: <20250516034643.22355-1-tuhaowen@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N0zPMTspoMaf97td3EsIO7VorJ54SVVu6b/94hfk49uAVMthh5mJ6ox3
	GDjcgbcUQk/PW98Q4jwmvF+hLu2+FnogIsY/781aY9R2Q1XT8rf6I/MXdfpq9nRQT8FFU6s
	xmjBEpJYAVfizZC4Q3F7ayMGmc5gLLApZLKZUa7MCxPlpcKPF6kBgCB5Gj069Zu7EajjQYE
	XW0APoNhb+Ec5SVogBHJz93/eUwD8B8v+Lv4Kh9fO+rbq0mjrynKF6FpYBhjPbqswdVI7U0
	etpLeH1Q3LBvBHmajISwv41t3SI6vLTentL7AZ+OkYPjR3CqRfzY81E3OtiJJtt/nBgNvJq
	euwc2+05S8wM+HDN71lw6Kn74Axtd3+EfqCjz2D4ErLncXoHw2wXkrTfMCYfj3UFvDSMoMa
	YWWVGm+mEztBCBXRF5Bo3FQ8aH+FJHO1dLRwLOjF1tTiWP8TA1Z0H31AtlIvs4eSmZrxRvQ
	hu68N4LBXjsOJ7dYrUDeeY9UMJVKpFnQwakDq6z/f4WH/TNBs/CWs68MkzE4mc/T/ZPBf7f
	dgrCi0aWLpTh7O3UOktlEw2vncxX0SlVqyz5+HJkHtMBdfjBxz8dsGff+UrjGFMKHFzNQI9
	VTdEzhQYceBF55At6ocIFkBANS7DEzj/6TX9ZbeBM2/VI4GsSaBnFP/o+nxwTCf7vZyJe8w
	u2tWy8Y/zaoUc9OpoQkgOcgnV7HJGDHo/HtGeVCmY2gWCrgiK4eeBC3tdYyzpHWk6sIwavm
	pwScrq8U5UZEjkGm7UQb+SAzYLvzL8fxrVeqh3PrEobxdoniwtOrKT9ZhZ6anNhY5jzzYvo
	TVPPswu0CHDBqUcRnPg5M6jnZwt96qIx+CMftXQ3UKifCXE/rSVfm0MA5jZfaporImuHKUJ
	sMMeeqkpmOLa2Src/VLKMRj85N0GSAmwWOk5O4Mg+LCWkJ6l5Yz9ols4BV0LntxBVAgPzJ/
	WBn23iAnan99WsPuTirE4/O6iN+irXzfZZukMrT6PHU40KVSJxuh+AZbXZd6wKc7qyts=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

When the computer enters sleep status without a monitor
connected, the system switches the console to the virtual
terminal tty63(SUSPEND_CONSOLE).

If a monitor is subsequently connected before waking up,
the system skips the required VT restoration process
during wake-up, leaving the console on tty63 instead of
switching back to tty1.

Signed-off-by: tuhaowen <tuhaowen@uniontech.com>
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


