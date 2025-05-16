Return-Path: <linux-pm+bounces-27227-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7025CAB97E0
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 10:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F14231BA602F
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 08:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C189A22D9FF;
	Fri, 16 May 2025 08:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="BoDs1aoM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B04922DF86;
	Fri, 16 May 2025 08:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747384882; cv=none; b=lylVRebVa4ZN3VwCxBesuEDtfE8SmNQVF59WWC84ck4DNSTbFA4kas6/vCYV4D5Rq/hTKdZuEgABmt/6AAHrprF4qPSqpcPaWcug4TmK8XXX2asM0ZIwVVh3dwY+KDfZn34t0pPuePJE19+anaJ2Qk6Od4Fs9rMvk+pYOHNuWQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747384882; c=relaxed/simple;
	bh=ga8uMoclPYWxWqyGnwmzZy2O0Wejc180iQMMhqu/Cs8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E0In6Zxi7rMjzTWLYG5wapYN1SL02etkTh01aFUUI7Pey7hEx78MzzPKVle6aRdiBGr1dBM8uPBc7JG7f68yLpeOMJ0BO2QxCYBODtylpgL1MjlH+d5qK76pyJTczbbW5SRS3JiGE1Ag3iaC3G9fKIQwRTaMfX/5INWrpLSVMa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=BoDs1aoM; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1747384825;
	bh=c1YnD1TyFT+luDI+a7+0AZCF+F460a+LPXJtzr8FLFQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=BoDs1aoMlWlkSJMvWnHQQ/XlHLGgBHnwa6G1/XiIVL6xtnvNO7URTNqOLGuJeDysi
	 jjfbcz2ib0lllGeHuemnp/N+Gz+hQ+aAnFZjkjsFIprqGSQNaBJXNK8J2PdxqSpM0j
	 GjKB3TdBBc36yTKuqdcwceD3jBzODf6+mPxurKu8=
X-QQ-mid: zesmtpip3t1747384816t5b9abf65
X-QQ-Originating-IP: bhZSdmGCSMuPEf6NgEQlQqYXKfI0eW7gzxxAjCosu5s=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 16 May 2025 16:40:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 114709977927235088
EX-QQ-RecipientCnt: 8
From: tuhaowen <tuhaowen@uniontech.com>
To: pavel@kernel.org,
	len.brown@intel.com
Cc: rafael@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	huangbibo@uniontech.com,
	tuhaowen@uniontech.com,
	wangyuli@uniontech.com
Subject: [PATCH v2] PM/console: Fix the black screen issue
Date: Fri, 16 May 2025 16:40:11 +0800
Message-Id: <20250516084011.29309-1-tuhaowen@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CAJZ5v0gOa8H-yABSepfy-WyOKJqRjCMhYPdbAHox3qUVmOXS6w@mail.gmail.com>
References: <CAJZ5v0gOa8H-yABSepfy-WyOKJqRjCMhYPdbAHox3qUVmOXS6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NRN3UPsLzYKVYGzjsdZpHcg0+ccKtc0shznsOYMMQkmAKUbgDnfdqOR6
	OIQT4gb/nyhm17g6IwiK+6ltOlBNI5iuXLJxf7G+f7zQ0UrAyDf14X0U/61ysrA0aR3mzud
	6lQ/EF8B/g8kxOyEp9LmnM4OnYsaLz6z6h5uclAi4jGHSxCTxqZA7BY/OD2yALnSNlA7k/E
	0TAvffIf04KdyJFXw7RTGQTgPIFs6hhlxoQip0RT2YsOdwwPF8tae6JkIogaiPef7erYq3w
	Zh2fvUqzoa6VwjIek5xBNN6mFenPtb70dPbw3UqZ3aO2H6nVi6XAlPf/1g4eA75aQd5j9cK
	7Hb9ELdIjQPwXF7WiMNn8NfhNDba/AFaBlDfJyJu3Mvj3MLlq2DrUadUTIjGmbLLimCoaLI
	rg3I0l4XH1PYtFWjhmUvn3FlY4Wf08H4sMhA1k23KCihURgDGNw+dAnve3uFHpzPVZqgU6n
	Z4Nt6XuUujhBpPP+iPgmSDy3zmVamVKxN8coh+ZtCdQfFOpA22pYEuUaSCzV2AtyjzSGd2/
	AJkEBYU+GEfP8tQJJBfT3CA7oIwoWyiD+Q5GU48GKlvbevuLopXtGYwaGx6PMiqAdjCpz6G
	L7mf2pQecBJhnvMh7rxwY5f8KJboOUf7B2evVycW2rtG8pZ8KVcLiRqEJxRyQgcth1tiCSb
	70Y4Y6fXgE19Kevt5AZQgfBg5s5DNKtTuAkmKbUDhig8pLcqn/XHwmgMQhjLzIFBuO0oTWG
	XD5KE3h9IF0ea+ycmfBlcKr4+/+nYaTT8hESGNi+a2M6Uj0iuic8co9XL5VeUUGYLORYpu4
	pSfVlDv8dFkoWdgwb1QNXdVjQPIMi0Yqjcmh9WOrLZEYUU29JYRZopSoBV+n0Nn6Ked3Wgm
	FyXsyqmTDNFQOopTEha+QyvGWQM6qaxnYw98tYw1vnyOx3hIGQoo5psAXXQE60TuBiSqTuk
	qEGkiPFSsS7TDQH/S0tRcmb667AnxdffMh/bPcFxE86FOMRK3eY4i1EYvtJmoj/s+p9Mwtd
	m2I5KhTOOz4fwQ81LNzOQsXUQW5ogcGqhkTQzgbV99HnJIPdlLtxTBovWPHy4=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
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


