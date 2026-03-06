Return-Path: <linux-pm+bounces-43755-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOhVHL+Tqml0TQEAu9opvQ
	(envelope-from <linux-pm+bounces-43755-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 09:43:43 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7B521D3C5
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 09:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 33C4D3015DA8
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 08:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC093793D5;
	Fri,  6 Mar 2026 08:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="PxsJxpO5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB734379974
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 08:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772786620; cv=none; b=pXD8lByU+eHCkC7vqgoaPlAy9vyELpCpr0oxLYGPqEU1Jk7UPKEWoCKAeoKWLok9q4nYzhtxJZDYbbFkcByfzHaFfUyo0FvKNApAd7O8v1UEa0k0yDNhi+YI1OhFhI8GMayZxqVZSfn43KM6XO+kOOcjxdoK5V7gVqL0b5KTbYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772786620; c=relaxed/simple;
	bh=NQZf/OEsxVfNZzzCfUgbDqJjVaITgzeMpP38x6OoxuU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:Cc; b=PxAZMpL/OOo2SPpTQXrYhDWqp/dpWU13XJJsExvbjISaD6aO7+5jS4L5OMjZD7fkVBw0fdQBo2ZpqLGLoEP8SLnrKuiwTpDx+1bRlxivtDQiRRw1Cnl2/X16zjzudi+rVB6hfGIcecrSPTI0kVRxWCVR+3DvKyeHGM6G2tLg2MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=PxsJxpO5; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=55391f076d=ms@dev.tdt.de>)
	id 1vyQX2-0024Ft-Ev; Fri, 06 Mar 2026 09:27:36 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1vyQX2-00Beh6-2K; Fri, 06 Mar 2026 09:27:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1772785655;
	bh=OddomWiS/o2+wUkBO5Mh6nGaiQK78lX0jopPH2pp1iU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PxsJxpO5pogivPYNhMnpTVKFVasIjXP6GGGyxfBy12umQLnneklhkw0i80O6xBE8k
	 3WA4OVJEDiPqFqXXyb/dlldRglV58+uyNNQVSTgMbcrWnHp1UCPFWldFkb0+8fE1QR
	 hUu12c+Y7BKCgBwtUKbGARDjqCCILvI3zo6xVh4dkGvYkY4doSFDkwx7IX3qyyarXM
	 xquxNxiCuYnkc9YheBiqmjChN2BKC8Gzp/zRjAuq3fglUTxwBrTcO+MTixzu/ECLq5
	 kEa2Z+26VWMmCcS7CGoalLhp11uoRQptDg7dSNLHZygMd9wXUxb62a6p0976vvlK3c
	 VIcG9XSdsoCyg==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 76C9224004E;
	Fri,  6 Mar 2026 09:27:35 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 5DF0A240046;
	Fri,  6 Mar 2026 09:27:35 +0100 (CET)
Received: from [127.0.1.1] (unknown [10.2.3.19])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 41FBA22F1D;
	Fri,  6 Mar 2026 09:27:35 +0100 (CET)
From: Martin Schiller <ms@dev.tdt.de>
Date: Fri, 06 Mar 2026 09:27:25 +0100
Subject: [PATCH 2/2] x86/cpu/intel: Add EIST workaround for Lightning
 Mountain.
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260306-cpufreq_lgm-v1-2-47f104aed7c2@dev.tdt.de>
References: <20260306-cpufreq_lgm-v1-0-47f104aed7c2@dev.tdt.de>
In-Reply-To: <20260306-cpufreq_lgm-v1-0-47f104aed7c2@dev.tdt.de>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Florian Eckert <fe@dev.tdt.de>, Martin Schiller <ms@dev.tdt.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772785654; l=1815;
 i=ms@dev.tdt.de; s=20260220; h=from:subject:message-id;
 bh=NQZf/OEsxVfNZzzCfUgbDqJjVaITgzeMpP38x6OoxuU=;
 b=n7kBE45BDvRVzxlmR90+0ENMU4zLf5zMABoNth93V9dE0d0H27WezM9/72+wl+4VpK/mW1MG2
 AyU3E4WxRATB/syl3Kl6uV6GHx60WZBuslcTg7OZla+hOgKDs901/Vw
X-Developer-Key: i=ms@dev.tdt.de; a=ed25519;
 pk=MAojd7D5IafMnqCYSFC7hY/u/jppX58CLIEhsEsSOYE=
X-purgate: clean
X-purgate-ID: 151534::1772785656-F2710836-2C00ADE3/0/0
X-purgate-type: clean
X-Rspamd-Queue-Id: 1F7B521D3C5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tdt.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[dev.tdt.de:s=z1-selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-43755-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[dev.tdt.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dev.tdt.de:dkim,dev.tdt.de:mid,tdt.de:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ms@dev.tdt.de,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

Add a workaround for Intel / MaxLinear Lightning Mountain to enable
Enhanced Intel SpeedStep Technology (EIST) for each cpu. Otherwise, the
frequency on some cpus is locked to the minimum value of 624 MHz.
This usually would be the job of the BIOS / bootloader, but U-Boot only
enables it on the cpu on which it is running.

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
 arch/x86/kernel/cpu/intel.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 98ae4c37c93eccf775d5632acf122603a19918a8..e49df04e8d491158cc48f8d8bef824c434256d09 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -466,6 +466,29 @@ static void intel_workarounds(struct cpuinfo_x86 *c)
 #else
 static void intel_workarounds(struct cpuinfo_x86 *c)
 {
+	u64 misc_enable;
+
+	/*
+	 * Intel / MaxLinear Lightning Mountain workaround to enable Enhanced
+	 * Intel SpeedStep Technology (EIST) for each cpu. Otherwise, the
+	 * frequency on some cpus is locked to the minimum value of 624 MHz.
+	 * This usually would be the job of the BIOS / bootloader, but U-Boot
+	 * only enables it on the cpu on which it is running.
+	 */
+	if (c->x86_vfm == INTEL_ATOM_AIRMONT_NP) {
+		rdmsrq(MSR_IA32_MISC_ENABLE, misc_enable);
+		if (!(misc_enable & MSR_IA32_MISC_ENABLE_ENHANCED_SPEEDSTEP)) {
+			misc_enable |= MSR_IA32_MISC_ENABLE_ENHANCED_SPEEDSTEP;
+			wrmsrq(MSR_IA32_MISC_ENABLE, misc_enable);
+
+			/* check to see if it was enabled successfully */
+			rdmsrq(MSR_IA32_MISC_ENABLE, misc_enable);
+			if (!(misc_enable & MSR_IA32_MISC_ENABLE_ENHANCED_SPEEDSTEP)) {
+				pr_info("CPU%d: Can't enable Enhanced SpeedStep\n",
+					c->cpu_index);
+			}
+		}
+	}
 }
 #endif
 

-- 
2.47.3


