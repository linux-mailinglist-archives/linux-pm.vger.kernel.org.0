Return-Path: <linux-pm+bounces-43754-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sI4PAhCUqml0TQEAu9opvQ
	(envelope-from <linux-pm+bounces-43754-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 09:45:04 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0CC21D432
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 09:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F761301DCD5
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 08:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8DC3793D5;
	Fri,  6 Mar 2026 08:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="TuWyeYUG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DA4318BA6
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 08:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772786616; cv=none; b=uRFEicef5pOjP6WcDXa2dt88jVgRbTIqVc304rhqyaLghSAQjsgSC0c5vSV+/va83wocioE8MYiqn9HdlBvMzljev8hoImK7hpyjtnlhFQ/JWTD28JmPJy3dxXPrB+YZqCsajXIdn73RPBBfqPKImEivXn0+Nksrg1O2tm+NjSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772786616; c=relaxed/simple;
	bh=XBcUhX+9+tVjmqZS3FsSPqoEmsndYoetIvCSFJeCjBA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:Cc; b=tKJazL6/cfQqBqQBpyMrDD2Qaepw9kIpeU11do2/yYoeZrSAPONA+UFU2hR5rI5xlkmZoPZpW54cxn5JSkOJpe+O4nYniaR1JRsaLEbOwlssGMHmkz3qapgllylBZwAMxPfj13Nd5KGL3B1tQmxTWlrILVJtdN1bBF68MB9sEoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=TuWyeYUG; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=55391f076d=ms@dev.tdt.de>)
	id 1vyQX2-0024Fc-8p; Fri, 06 Mar 2026 09:27:36 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1vyQX1-00F6Ht-Qx; Fri, 06 Mar 2026 09:27:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1772785655;
	bh=H5/TaKe7u4NR6EQ6rZ7iQQrNmQdWHE1NfDo1A435cCQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TuWyeYUGiOgx7BHb8JBQyuZ6CnTKg3/DU49pw+GMrworor8D3W/TSAkMvqDTSxwwL
	 lCTg07uudJuL5Kq5CvvZy3JloOoXChpUaVji7EqLm81gQEmW9v9bWOTQ6Ua/KbS9N/
	 etUyut8HcFV0FXaGGfiLbMDbOFClwQ8iRp+w8++TOuqIFcyVgkdNgFnhxNNyjpKphp
	 PUN76cRZPEoZuaa1OFGz3zLxv4ySjIxxpPJ4PWSIy48rjl071dv/c0Gh6h8aLRawhb
	 sd+jpHpyg1mDJkfWYJ8aD6J4Dzs+zaVh6B463tKwgXCaY5R4fC9Di8dzj/mxDKdBev
	 /jeAN72PAuDVw==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 60B32240047;
	Fri,  6 Mar 2026 09:27:35 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 4369B240040;
	Fri,  6 Mar 2026 09:27:35 +0100 (CET)
Received: from [127.0.1.1] (unknown [10.2.3.19])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 210E323267;
	Fri,  6 Mar 2026 09:27:35 +0100 (CET)
From: Martin Schiller <ms@dev.tdt.de>
Date: Fri, 06 Mar 2026 09:27:24 +0100
Subject: [PATCH 1/2] cpufreq: intel_pstate: Add Lightning Mountain support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260306-cpufreq_lgm-v1-1-47f104aed7c2@dev.tdt.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772785654; l=3144;
 i=ms@dev.tdt.de; s=20260220; h=from:subject:message-id;
 bh=XBcUhX+9+tVjmqZS3FsSPqoEmsndYoetIvCSFJeCjBA=;
 b=LLEwtXt6rPzkO/7L3NXXb2//R80dftR7X7jOmT3VSbXoU2zbztF06r17D7Os8RJfvf3TDqpWv
 fhq6Fb4TGM+DaCrHUdYncAK1xzvfBb8wAbkYRBhuDdfD3vH5/ycBcsD
X-Developer-Key: i=ms@dev.tdt.de; a=ed25519;
 pk=MAojd7D5IafMnqCYSFC7hY/u/jppX58CLIEhsEsSOYE=
X-purgate-type: clean
X-purgate-ID: 151534::1772785656-AFF17836-4C2E630D/0/0
X-purgate: clean
X-Rspamd-Queue-Id: 9D0CC21D432
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
	TAGGED_FROM(0.00)[bounces-43754-lists,linux-pm=lfdr.de];
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

This adds Intel / MaxLinear Lightning Mountain (LGM) support to the
intel P-state driver.

Although the LGM is related to the AIRMONT (Atom), it uses different
register values and frequency table.

This changes are based on patched kernel sources of the MaxLinear SDK,
which can be found at https://github.com/maxlinear/linux

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
 drivers/cpufreq/intel_pstate.c | 62 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index ec4abe3745736b0130fae117d037c5204e048f80..330a04d9af15309e231c5f8f3dc78e9eea0635e6 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2150,6 +2150,58 @@ static void atom_get_vid(struct cpudata *cpudata)
 	cpudata->vid.turbo = value & 0x7f;
 }
 
+static int lgm_get_max_pstate(int not_used)
+{
+	/* The Lightning Mountain hardware seems to be designed to run up to
+	 * P-state 32 (2496 MHz), which is what atom_get_max_pstate() will
+	 * return. But the Data Sheet shows a max. supported CPU freqency of
+	 * 2028 MHz and also the code from the MaxLinear SDK tells, that "the
+	 * max. P-state is currently not supported". So we have to manually
+	 * limit the P-state here to 26 (2028 MHz).
+	 */
+	return 26;
+}
+
+static u64 lgm_get_val(struct cpudata *cpudata, int pstate)
+{
+	u64 val;
+	int index;
+
+	static const u32 vid[] = {
+		2, 2, 2, 2, 3, 3, 3, 4, 5, 6, 7, 7, 7
+	};
+
+	pstate &= ~0x1;
+
+	val = (u64)pstate << 8;
+
+	index = (pstate - cpudata->pstate.min_pstate) >> 1;
+	WARN_ON(index >= ARRAY_SIZE(vid));
+	return val | vid[index];
+}
+
+static int lgm_get_scaling(void)
+{
+	u64 value;
+	int i, xtal, div, multi;
+
+	static const u32 freq[8] = {
+		26000, 25000, 19200, 38400,
+		40000, 40000, 40000, 40000
+	};
+
+	rdmsrq(MSR_FSB_FREQ, value);
+	i = value & 0x1f;
+	WARN_ON(i != 0x1f);
+
+	xtal = freq[(value >> 32) & 0x7];
+	div = (value >> 40) & 0xff;
+	WARN_ON(div == 0x0);
+	multi = (value >> 48) & 0xff;
+
+	return (xtal * multi) / div;
+}
+
 static int core_get_min_pstate(int cpu)
 {
 	u64 value;
@@ -2669,6 +2721,15 @@ static const struct pstate_funcs airmont_funcs = {
 	.get_vid = atom_get_vid,
 };
 
+static const struct pstate_funcs lgm_funcs = {
+	.get_max = lgm_get_max_pstate,
+	.get_max_physical = lgm_get_max_pstate,
+	.get_min = atom_get_min_pstate,
+	.get_turbo = atom_get_turbo_pstate,
+	.get_val = lgm_get_val,
+	.get_scaling = lgm_get_scaling,
+};
+
 static const struct pstate_funcs knl_funcs = {
 	.get_max = core_get_max_pstate,
 	.get_max_physical = core_get_max_pstate_physical,
@@ -2695,6 +2756,7 @@ static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
 	X86_MATCH(INTEL_HASWELL_G,		core_funcs),
 	X86_MATCH(INTEL_BROADWELL_G,		core_funcs),
 	X86_MATCH(INTEL_ATOM_AIRMONT,		airmont_funcs),
+	X86_MATCH(INTEL_ATOM_AIRMONT_NP,	lgm_funcs),
 	X86_MATCH(INTEL_SKYLAKE_L,		core_funcs),
 	X86_MATCH(INTEL_BROADWELL_X,		core_funcs),
 	X86_MATCH(INTEL_SKYLAKE,		core_funcs),

-- 
2.47.3


