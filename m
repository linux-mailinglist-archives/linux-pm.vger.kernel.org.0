Return-Path: <linux-pm+bounces-28432-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AF6AD4947
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 05:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 936373A4EEF
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 03:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B471865E3;
	Wed, 11 Jun 2025 03:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="PwqdEJBU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3377E1A28D;
	Wed, 11 Jun 2025 03:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749612285; cv=none; b=WcoQToMUN+kGxLLNgyjahRZ71MYSK93Sx0kgiG0EidLKIHwvDZ4BupvcPgvMPguZTU9wnjOFl3ZhTEm2kvyT9j1BldEbF8IVRbnWtbTWmYcvkQZ/MJdS1NziHKi7llg9LWqNF7OvJ5UryK65kkQMEAv2/jxJZq0Qy1hSy0jG0sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749612285; c=relaxed/simple;
	bh=fyPQ/mfs2CSaeT6RM8/3j9A3OgCvFV5ebkXfbNQ6tqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YHLQ4iUhwffyIN5l1gFM5kJFsYzUliawbWgGyKO08tk5O6EcLBHrgg/5CUfqT/FzlWSl6QNZ2Ty+fG2ze2VyLPwKjofFGyeGXDj6LY0D2zpyr/RoanHWJdrM3sBGA5eNSAWjcTV4MShkF3w1613KUZR8+E1C4xvc+fNBjRKy0Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=PwqdEJBU; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1749612238;
	bh=A93XqZVqVhYz+KFT6k3LBe2oQch3w3UxJ0GXN9kjeh4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=PwqdEJBU58xv2fN/GyFrVsY4q+yUzchYh1yQdyDbOkzOLW+gsmutc3EKCPmPRdo1M
	 rK9l0TyIXN5xEF9I6iJ/vDFyQzvjEpBYWe8ugLfcU5ZI4aPiazt/TPy5NMd9iWF/oQ
	 LTfN3b4KY2nM40MFZ1WGknFJvuhlDwUT8ZVFE51I=
X-QQ-mid: zesmtpip3t1749612231t9eb799bf
X-QQ-Originating-IP: zvO0QNl2WUmxFIua18O1d7WBy41GUoKiP/HGHAcVAK0=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 11 Jun 2025 11:23:49 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12403305686698106879
EX-QQ-RecipientCnt: 8
From: tuhaowen <tuhaowen@uniontech.com>
To: pavel@kernel.org,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Cc: tuhaowen@uniontech.com,
	huangbibo@uniontech.com,
	len.brown@intel.com,
	linux-kernel@vger.kernel.org,
	wangyuli@uniontech.com
Subject: [PATCH v4 RESEND] PM/console: Fix the black screen issue
Date: Wed, 11 Jun 2025 11:23:45 +0800
Message-Id: <20250611032345.29962-1-tuhaowen@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250603010157.19121-1-tuhaowen@uniontech.com>
References: <20250603010157.19121-1-tuhaowen@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N4WhQbLQyIqSRHbDR+m8OJSMb1ieiFC7TYC7nNr51mi7zodg6KY3Muyh
	bRixKaDRMGfFZxoROozMf2qcCuSQOaGhfT2ScCIYifWOCYdcf2DwhN9oS17/Ns4pRzxAcpk
	+/xcAIikhvpsOAR3/402sskaYm12z9raPWsTkzeHER+JAufx+S+iXPCSvxw/KHxWyQRn1fR
	1x5NJwjQR3GK8wwTRSnYH6vzfRrYpFYWoC5F+ZVRH+0IUis/vKq0SIZvLpLlfjKAXHL2I/J
	jqf3G8yWOOKnbXHAWT5N9oAnT9UTo9mwJpFxdnvZS9stilP4rlop0IZx0MEszRyDVaiFomw
	xfYk9KhLWPB2omFr6zki+5jgOpAHAEDffJH+lemyNJ7I/+nEsQTT3TiKdo6hNHmAwcQQM9y
	q/IrykpJvK7HnoIp5FlmVx5X5EwHzPzd+YepwBUi3ByJDeTvGZCmrA1PpVpwSmb3zmK35Gm
	je2r9HeMyvLXKc24MX90BTrUeAx995COlmwdkL5N5omBFII/b4YxxpwGNBvjyxeVEEsdKB1
	tZNLBJveN3mMDIulGR2fIQFeWNpwsMPR3hIWhTFHm5VhmuKyszB4z/7+sakf547LiXVdodt
	SP2puRPhyooZoL9+KJ2iyg9buSdDbZ/50719v6BH7MBANI3LbtKMa33wWHH1P1ppmm7gRRg
	zYhxxsD0jV5Kh4mj9KNxJ+vR1QbQXNkZ7o6Wlm5okxltAO7Elz/+tXwIUbJD8w/e+C6XOSe
	FMgiEJPo7zBO8RNXO42dSWWNAr0przYqk1ADDg2vsK8AjKV2s8JxvxjJct7IqV2zWf8bjpf
	c+7tj/gs2GObOS0ktv1j49M/H1Xj/FAsPRkfTftKtMJLj+EpALDibdkOBkedRA2lGmhT09W
	w8g9/QRaZM7hC2ETGs+QzxMUopT9pdLxuKRUUqvYytDCUFOBK4Hz/QSWnLyATPV+en9a5KF
	1jzWClyHw+r69QycPfa1TyQ7pu9JvDPtnqwCb8GbsL0mUmb0BFmkZI5FLlL/Qyie+4XDuuF
	6Kfg0u1/ei+VbEyxrrU/jiwlX+cTM=
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


