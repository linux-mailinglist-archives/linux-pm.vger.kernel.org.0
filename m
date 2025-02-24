Return-Path: <linux-pm+bounces-22777-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA5DA41681
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 08:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD0F03ACD8F
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 07:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8C918B464;
	Mon, 24 Feb 2025 07:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="TFGJj6fQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107F0134AB;
	Mon, 24 Feb 2025 07:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740383282; cv=none; b=A+48xRjumtX5VRMdcSuB/0ILZ3GSYsFqyVLGGfraI9lUooEYz02867xk3FTXBEvUo3Fn+BqGVy2TLXWXqUkx+76QsCPVkrjR6RM7slxaeDrIZUoTe3Wlz/kW3gY7Bv8ShEJPoLa0g0/ffiXd5kNXg7IBBCWsJ4kAXwwXYHBscEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740383282; c=relaxed/simple;
	bh=QgMoDqFA4Xm41gdv7f4UTTcLqqWKoOdtzL+m3RfcUu0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=toLHSnxwyyz1YptaPrkTnMLkqf7kmtu6XDKsbUzYPlIER3WxJU+jCLAW/rC/gRwII2nmy4cfBTnXm7EGQngsGEVvxFrTyFHe58dsIRIiIs00JnYcceiKtjcoiRwoONg5ZJZGq4Q2UwYBaTUkp7nf28s10lqJ3SS2e+JCV2X0p1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=TFGJj6fQ; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1740383109;
	bh=Jf6ITo4s7xR7v45XyJbqqJSz6q1dIgPfXfKuSzS6Ki4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=TFGJj6fQ9wPoOoam22GCZPy68sjQSlMvRE4PofrlHym4tMh5liBke8sXRC1aH5sJ6
	 Pd05tPzKfAKQ1ggmLEnDsXGy+glF8X6LZ8Ns0rX28QIrQTyODnuzfJiLvVFat8yBlt
	 IiAlYr10W7zolh42m17/hzDxpartih0kgm8U1i1M=
X-QQ-mid: bizesmtpip4t1740383055tuh3phr
X-QQ-Originating-IP: qNhz+YbDATmHpQzl00uFaa4wQn8B9O7SEGBWcl535dQ=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 24 Feb 2025 15:44:12 +0800 (CST)
X-QQ-SSF: 0002000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16862361414539914337
From: WangYuli <wangyuli@uniontech.com>
To: rafael@kernel.org,
	pavel@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	chenlinxuan@uniontech.com,
	WangYuli <wangyuli@uniontech.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [RFC PATCH] x86 / hibernate: Eliminate the redundant smp_ops.play_dead assignment
Date: Mon, 24 Feb 2025 15:43:57 +0800
Message-ID: <CF154B5C3C8E7E64+20250224074357.673094-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OSUW9vQLVhiZDMc2mapvkNNMYirSW4aQzdAAOeLSRTDkbg3sQfKJ1UN8
	Foua3YWLdUW8D2rNhnsJFMuVqKG4ZyUAMjw7WFlfByV6t3gaSyIFEa/uEbx/lRtmAmmU8CG
	Ol2WPd8lfGDFbMwCuZqTJ2CzSkXiC0a/8ZOjDtnSh/lE5QtXPPelKoz3sKKyVkl2wf3cVN9
	N74wZ009zx5ZHKI+FUxAduOk3vNPx9YMYgZwRTyPXGgLBCpopyvL8lsE0nSjTsW43xQcEdv
	1JJ86hi5xcZdsXCO15TOKhf/nl3Sh+cJWwI/GY5wSju0OoROHhlKpO7rbtMIS2WNxjVH7ZH
	6vqW9ItrC9RRy0nT90iltfvOjmDAuFe2a5W1p5wRlzFWwPYLzbK9yQPr85jQZRur1gkkQ7f
	pWozDgrsVfXPBF2K2R9EocKWkcr9648Xo94Rc5onBaSpzKQWHvsVgCU4tPdRSXRa8s6A2Ac
	R9Y1yM1odz/6IgfEjlCFjpruW6ECFAvbUFpyzjsdCHZPREom/il3pdwedFr5vtApWneYb6c
	weD5VjwSoDPKiZvQS7tSUf0zyAJ2If0aD0ve4tyNsoez7xGv3oQkiU5UxeYQH0zcQD5rFhr
	+cDNOrLe9zAYxkO6gasZz5joECmuHaGdD3rWzrs71iKLEnWUX8nn3ChwCfL1b96rFW1DuU4
	Oec82nrGWWcB4de7gZfVbXWSYgZrI6t4jm6Vuts4Owtgg0M/wCX/BWRTr5ANtf0xOJpWiw8
	SbjQneP7lZMdT4sISp+Yc6R1Oics2oZ7Kuo9Tqep+LOpZWefr2O22P0J2ik84kcJEltNDlR
	+EIRKU3skvV3uGMMbm/YZfwWn6RX8eALGsCRirD4EcalT1ush4ltQQUn8B9UpRChGAPtMTP
	fjaGyvu+WANSpbJ3aJC7yzCvFVglV2N+a1B4M9JZmYQVYv96dieJ1vQHhTppqWeGnC6IcjF
	SdZ6ImgnqbIIKNt0pPU4Hi17FdETls243apInlu39yoriTAfclYFg9Q1N1lqb6PT57OoJuB
	7z/EDShEqQm1lc2ByoRuuPps8VeJWiJAC0eKDEbAjFSwCRoUkJzOhK3+CEZk4=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

It's unnecessary to re-initialize smp_ops.play_dead to play_dead as
it naturally goes back to play_dead in the freshly booted kernel upon
device resume.

Suggested-by: Huacai Chen <chenhuacai@loongson.cn>
Co-developed-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 arch/x86/power/cpu.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index 63230ff8cf4f..023cf9421467 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -297,9 +297,6 @@ static void __noreturn resume_play_dead(void)
 
 int hibernate_resume_nonboot_cpu_disable(void)
 {
-	void (*play_dead)(void) = smp_ops.play_dead;
-	int ret;
-
 	/*
 	 * Ensure that MONITOR/MWAIT will not be used in the "play dead" loop
 	 * during hibernate image restoration, because it is likely that the
@@ -316,13 +313,11 @@ int hibernate_resume_nonboot_cpu_disable(void)
 	 * resume) sleep afterwards, and the resumed kernel will decide itself
 	 * what to do with them.
 	 */
-	ret = cpuhp_smt_enable();
+	int ret = cpuhp_smt_enable();
 	if (ret)
 		return ret;
 	smp_ops.play_dead = resume_play_dead;
-	ret = freeze_secondary_cpus(0);
-	smp_ops.play_dead = play_dead;
-	return ret;
+	return freeze_secondary_cpus(0);
 }
 #endif
 
-- 
2.47.2


