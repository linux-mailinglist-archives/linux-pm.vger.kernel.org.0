Return-Path: <linux-pm+bounces-43753-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SC4MLQ2Uqml0TQEAu9opvQ
	(envelope-from <linux-pm+bounces-43753-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 09:45:01 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1259A21D42B
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 09:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92CA7301A736
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 08:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01463793CF;
	Fri,  6 Mar 2026 08:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="N6gQ0+Z/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B42318BA6
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 08:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772786609; cv=none; b=EBchDlzOv1XFFvy+Tj9liKhxMvhXPPwCg91mcNm62v+1Z+rsldu4nIFl9eM0jbQgRb0h9TPOuqYpqKANYOlysJqSipX2OMKj9jqJJupxXUIr8l+N246Hj8fOHqDh/Tro4lsrUazb/VcK13zPeAlfJ3P0iUbMe431jq0l13iGcmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772786609; c=relaxed/simple;
	bh=WZanKgZivj3Md7uH1DiBhwaMwJGaIzHNILjWqGpE624=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:Cc; b=AwwZM0Gs2uxjC3rKphL+3f18AC0DgSCeZFyFKFGZtF7CR3tv8VoXvB+hZHOwKnrGZRTG62fD9Mu9DXF67qZ+nNf/Vu3rBV1CH+Nyygc/4vzUfWA04sx+SAnOfoJG3Z0puxM+QXkrYpTrizA4lu9lfS5zAlIKL4ISDuWaG5QFEwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=N6gQ0+Z/; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=55391f076d=ms@dev.tdt.de>)
	id 1vyQX2-0024Fk-C1; Fri, 06 Mar 2026 09:27:36 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1vyQX1-00Beh1-Nr; Fri, 06 Mar 2026 09:27:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1772785655;
	bh=MbJSwSGFbrLNcrpNoa5wXXt/vYsnrMNhsm98f+zely4=;
	h=From:Subject:Date:To:Cc:From;
	b=N6gQ0+Z/EnpaHo9yK6bZy0LDpZ+8k7aoeb+dQuVF+POl0Dv06rtcxQdzGonaNBDsv
	 dfbLu1XAlXFnD6X20wEok3Y2uMFPy+cdbV91aN9cbJmZmEnWX++sqSVjp6O0ZE1DBo
	 4Lny/J1QMQpP5JMH2x8z2fZfwGChjPtJEbGkVINf1RqEjSiWI+Q5HlBGrBwWxDhJvI
	 ygLxrAB2WquHAiwf8rwmR2IFWfLYmaHbDpQyTKWQHqV0X2BaoOArlK7abJch/dzIRI
	 +cRqYNGHmAM3rMXUzDxkenO3H3mKNPSwcR36KL3AI6vkR8CBWd82LJ+SCs+yFkWcay
	 vvjQ3c+mlW0kg==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 4C67E240042;
	Fri,  6 Mar 2026 09:27:35 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 2FCBC240036;
	Fri,  6 Mar 2026 09:27:35 +0100 (CET)
Received: from [127.0.1.1] (unknown [10.2.3.19])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id EBC3822F1D;
	Fri,  6 Mar 2026 09:27:34 +0100 (CET)
From: Martin Schiller <ms@dev.tdt.de>
Subject: [PATCH 0/2] x86/cpu: P-state support for Lightning Mountain
Date: Fri, 06 Mar 2026 09:27:23 +0100
Message-ID: <20260306-cpufreq_lgm-v1-0-47f104aed7c2@dev.tdt.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOuPqmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYwMz3eSC0rSi1ML4nPRc3WQDIwuD1DRLC8tkYyWgjoKi1LTMCrBp0bG
 1tQDp9jZ2XQAAAA==
X-Change-ID: 20260306-cpufreq_lgm-c0280ef989c3
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772785654; l=783;
 i=ms@dev.tdt.de; s=20260220; h=from:subject:message-id;
 bh=WZanKgZivj3Md7uH1DiBhwaMwJGaIzHNILjWqGpE624=;
 b=AD6Q65Rj6Yeg7fHwhi7chWYndJj90ubzkySyRi/aJxi1fbwIJ8kI0zORg4mngipH6Of71Q2Gw
 yD4ItJo+xToDx9pboBmz8jWd8tOmUNYFWlpTR6g+j6Wfavvq/VP0gzC
X-Developer-Key: i=ms@dev.tdt.de; a=ed25519;
 pk=MAojd7D5IafMnqCYSFC7hY/u/jppX58CLIEhsEsSOYE=
X-purgate-ID: 151534::1772785656-F3716836-D9F701B5/0/0
X-purgate: clean
X-purgate-type: clean
X-Rspamd-Queue-Id: 1259A21D42B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tdt.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[dev.tdt.de:s=z1-selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-43753-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[dev.tdt.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,dev.tdt.de:dkim,dev.tdt.de:mid,tdt.de:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ms@dev.tdt.de,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

This patch set contains 2 commits to get P-state support for Intel /
MaxLinear Lightning Mountain. The first adds the needed code to the
intel_pstate driver. The second adds a workaround to the x86/cpu
subsystem to enable EIST on all cpus.

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
Martin Schiller (2):
      cpufreq: intel_pstate: Add Lightning Mountain support
      x86/cpu/intel: Add EIST workaround for Lightning Mountain.

 arch/x86/kernel/cpu/intel.c    | 23 ++++++++++++++++
 drivers/cpufreq/intel_pstate.c | 62 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)
---
base-commit: 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
change-id: 20260306-cpufreq_lgm-c0280ef989c3

Best regards,
-- 
Martin Schiller <ms@dev.tdt.de>


