Return-Path: <linux-pm+bounces-43914-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEdJNuEGrWm7xQEAu9opvQ
	(envelope-from <linux-pm+bounces-43914-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 08 Mar 2026 06:19:29 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D2222E958
	for <lists+linux-pm@lfdr.de>; Sun, 08 Mar 2026 06:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07E37304434C
	for <lists+linux-pm@lfdr.de>; Sun,  8 Mar 2026 05:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153A92F0680;
	Sun,  8 Mar 2026 05:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="W6AGXaD2";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SfPvJb9O"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAE12C0F97;
	Sun,  8 Mar 2026 05:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772947112; cv=none; b=DHmazbbPQf2Vpqsv+Y2rJjhC4SuD/HTxf/WRnNA/yYb/5sn3nQ4hB1k6aBV5nXtQKYmFj8hZyWkCgWfNfKtVMpHphy38UBsACe2HbNCEtTzT2Ga7vCMuJwa9iNn/yZ2+C3caObwGprKd37WfwPj61dC65JcsYHxWMHSaEUan6ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772947112; c=relaxed/simple;
	bh=6VCLjpSEVcMWlsqnU3sm41GHeCIIDj8fxsmOYwSNfLc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sV4EcH8N1jhO7LceRHXuCtigGzjspRIdCfh9rqQa/a8Dsq43Eomxn9NmRWM+hp+IA/sm9hx6LHFRuSohXO1hHu6ukh+6SCV48SO47wgqNHlBpuaw8vMmc95OclMm3O3akJ/mFnosTIO38+01TSq9vdA7OOpPdDoRxMpN5V+eFxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=W6AGXaD2; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=SfPvJb9O; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fT7hg3FTXz9t0N;
	Sun,  8 Mar 2026 06:18:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1772947107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xFoQRbzzGJ6GQLY9ekTrem/KHliTwSgfflqFnYv1J1I=;
	b=W6AGXaD2yCQxWQHhGQx8Lj7x3lvNGWCvnVIGE+n/s0fO58ctJNp8VsWEwHeJdeFq5DhnbY
	mefxHsAX7qTf323TVW/OFmRXA78G7NmRmKyMG8qSlMJfWa0/gNCsDPIkuJfaCeB4v/AAyl
	VGzEzp6sNQFLRmDCMi3GK+eiZevGgXiyI77paevkHup4aY2Pm0dgDHlyYkm5aXoMh4qaws
	cZO4q+FFfAlGXJOJbGMrKGc08IYlLh4iJKkn26vPzwVENzZu3F0nelRsz7EayJN8oLkHN4
	LnEQdUxesNJV6taCTGQGqqYtCAb7Q206/joWsJhnmrdh65P7fSUmrMmrXOoLug==
From: Shuwei Wu <shuwei.wu@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1772947105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xFoQRbzzGJ6GQLY9ekTrem/KHliTwSgfflqFnYv1J1I=;
	b=SfPvJb9OoCcu+7pDQ/6PzK0nnTzfuE+b6AGVMJO5+f4XPpO6eY2Y5Cotmglb3M6l0qZ70g
	WzasThc2w4qN56wg8IhWRlcFCyNqkROMUScDIRuMNvc+H1tjVfcgN8ITQMojUK84dWhzJF
	GEz9Cyo2aSheb3NPz2ABjTkBpk1Zhhr7pBcevbeqMxh5vIEW/zTEYZRtUY+TjGn4I2L4qH
	9aQAWvvr/bQqst97vgKM8nfOPYNEjutEAHWAUKkV74ymgsVDnE7Kkuonq5EeNiRvNFmuip
	SivYiEQUErdcdnrPPCOw6M9y6nZIs0sMIOypI1ImwJo3NTYXfWyAmidswJIBmA==
Date: Sun, 08 Mar 2026 13:17:39 +0800
Subject: [PATCH 1/2] cpufreq: dt-platdev: Add SpacemiT K1 SoC to the
 allowlist
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260308-shadow-deps-v1-1-0ceb5c7c07eb@mailbox.org>
References: <20260308-shadow-deps-v1-0-0ceb5c7c07eb@mailbox.org>
In-Reply-To: <20260308-shadow-deps-v1-0-0ceb5c7c07eb@mailbox.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Yixun Lan <dlan@gentoo.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 devicetree@vger.kernel.org, Shuwei Wu <shuwei.wu@mailbox.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772947080; l=808;
 i=shuwei.wu@mailbox.org; s=20251125; h=from:subject:message-id;
 bh=6VCLjpSEVcMWlsqnU3sm41GHeCIIDj8fxsmOYwSNfLc=;
 b=YNWJKGrDi++1MHi41bxD8v2brnggQZzBMTXXEScsWmdBco7Lx1xhqOA9txUyDPZ8PD9Kp8QBw
 /MS4ASbQAHmADzG0L8bQSr8hZx4hhPFhgDS3LqzFTO2MgsxZ9Uo4kau
X-Developer-Key: i=shuwei.wu@mailbox.org; a=ed25519;
 pk=qZs6i2UZnXkmjUrwO5HJxcfpCvgSNrR4dcU5cjtfTSk=
X-MBO-RS-ID: 03bc9bd0b2123aa0cdc
X-MBO-RS-META: nabprw15aooh1m1w5pegnzxrmoiopiad
X-Rspamd-Queue-Id: 44D2222E958
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43914-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.959];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuwei.wu@mailbox.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:dkim,mailbox.org:email,mailbox.org:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

The SpacemiT K1 SoC uses standard device tree based CPU frequency
scaling. Add it to the allowlist to instantiate the cpufreq-dt driver.

Signed-off-by: Shuwei Wu <shuwei.wu@mailbox.org>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index a1d11ecd1ac8..d22198d33b7d 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -81,6 +81,7 @@ static const struct of_device_id allowlist[] __initconst = {
 		{ .have_governor_per_policy = true, },
 	},
 
+	{ .compatible = "spacemit,k1", },
 	{ .compatible = "st-ericsson,u8500", },
 	{ .compatible = "st-ericsson,u8540", },
 	{ .compatible = "st-ericsson,u9500", },

-- 
2.52.0


