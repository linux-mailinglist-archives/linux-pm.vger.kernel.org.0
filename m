Return-Path: <linux-pm+bounces-43227-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJERA2zWn2kYeQQAu9opvQ
	(envelope-from <linux-pm+bounces-43227-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 06:13:16 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 764DE1A0FFC
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 06:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3062B303338E
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 05:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7B138759D;
	Thu, 26 Feb 2026 05:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g2K/x+Ve"
X-Original-To: linux-pm@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E03332909;
	Thu, 26 Feb 2026 05:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772082793; cv=none; b=pfmmvzPXdhaKgHZuQy2WL0IyG+o4L1GSzULzdvcjMwxmjbaOK9Vtj40boJrS5+V8pByieAc0D4W3Zq1KGSbmGcMmR8RPVAMdx3+FKvxTDW9f+7ZtyjwJrI5oqSrR8DdChOeu4/3sILAYRuzKql3K55UqYZFAKlp+4bCZUtpogMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772082793; c=relaxed/simple;
	bh=eFPYhuNy8TxNqW9jD4iHTaORDXnolL2txJksnZrmDPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fu05YhEUtouZfjNFYRTDV7nuThO9dk+QmfRj7LMvWWLbInGQCfEUWNwOFcq6aEfg81YJCIau3tyLYovOiVOd/beuW62PcjGSN1HDk6ceTo7lg67uRF0b1ih7WM9wFf0VP5ojE9oCq6qJzEnF/gwH03tEzv/jLEVppHMhsWebfHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=g2K/x+Ve; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=XvnQFmWPOqtM26r08jbEIIkm7MyHEar1yt10naK31Dw=; b=g2K/x+Ve61snUiz/iMNWhXlkL/
	CxayqxV7j8VYEff/JxXKoUlgV6VNzpFqBPwwhxZc55mS3IUq1g55EjYcWlXMAJ6zve2LeCvRN/F0U
	vnFi5IQYrZgmzOXTYI4kaGQyMGEK4ILn9X1OoQjGPJlVc+xcOUNvHT1hbjicI5Vq2EsrlFWzIVDNP
	+nwvGwCy2X2I8LcQcdgYrOdJ9yP8FdKQTFBThEuZBsZ0ePBH5NxixtGnxl4/LWEMGty0LLeTGNK6C
	bbh7SDwjW9SDTNFGLm7rob6Opd29XXprGzXbfLMmHJthVocQkHBFt+wA2XUSIVs3i9RMhN665CFC+
	JWbDIKnQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvTgU-00000005PMM-0yX1;
	Thu, 26 Feb 2026 05:13:10 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Nishanth Menon <nm@ti.com>,
	linux-pm@vger.kernel.org,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Tony Lindgren <tony@atomide.com>,
	linux-omap@vger.kernel.org,
	Kevin Hilman <khilman@kernel.org>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>
Subject: [PATCH] ARM: omap: fix all kernel-doc warnings
Date: Wed, 25 Feb 2026 21:13:09 -0800
Message-ID: <20260226051309.556228-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,ti.com,vger.kernel.org,iki.fi,gmail.com,atomide.com,kernel.org,kemnade.info,baylibre.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-43227-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:mid,infradead.org:dkim,infradead.org:email,atomide.com:email,ti.com:email,kemnade.info:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 764DE1A0FFC
X-Rspamd-Action: no action

Use the correct struct member names to avoid kernel-doc warnings:

Warning: include/linux/platform_data/voltage-omap.h:27 struct member
 'volt_nominal' not described in 'omap_volt_data'
Warning: include/linux/platform_data/voltage-omap.h:27 struct member
 'vp_errgain' not described in 'omap_volt_data'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Nishanth Menon <nm@ti.com>
Cc: linux-pm@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Andreas Kemnade <andreas@kemnade.info>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>

 include/linux/platform_data/voltage-omap.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20260225.orig/include/linux/platform_data/voltage-omap.h
+++ linux-next-20260225/include/linux/platform_data/voltage-omap.h
@@ -10,14 +10,14 @@
 
 /**
  * struct omap_volt_data - Omap voltage specific data.
- * @voltage_nominal:	The possible voltage value in uV
+ * @volt_nominal:	The possible voltage value in uV
  * @sr_efuse_offs:	The offset of the efuse register(from system
  *			control module base address) from where to read
  *			the n-target value for the smartreflex module.
  * @sr_errminlimit:	Error min limit value for smartreflex. This value
  *			differs at differnet opp and thus is linked
  *			with voltage.
- * @vp_errorgain:	Error gain value for the voltage processor. This
+ * @vp_errgain:		Error gain value for the voltage processor. This
  *			field also differs according to the voltage/opp.
  */
 struct omap_volt_data {

