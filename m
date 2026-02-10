Return-Path: <linux-pm+bounces-42393-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBaAMUfFimm9NgAAu9opvQ
	(envelope-from <linux-pm+bounces-42393-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 06:42:31 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 433971172B5
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 06:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54B803019063
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 05:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344D632C929;
	Tue, 10 Feb 2026 05:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SB+qbyuE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC4432C94D
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 05:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770702063; cv=none; b=rS6inuQ6b5slN+kwiBB/qYA8NofUSyqrL9uSdNuJccRJsakkC5Wy3uPXKQ6tR19GWFVWxV82YkjZiJnnCRWiUzDcJ306Py5grvMHNIQciinMdbluRz6roLBIWa2rGJLPgIdFzo2upm+uAVBMf+D9krXob1ZDoebRl1Diz9Nu6Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770702063; c=relaxed/simple;
	bh=XUvAjMb0BWEQ8WU28cISXZNoyB0oJxZ5JKVyBPGZXm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tM2/i+77eF4SZ3Ez+BBbuBRzDD/bSHGZ4i5l72bKG2CfDB3l5aV7rsdnbytaGyQ/wpRco9Q9NwTmakCbj0XjptwQr4YFsSnvaModI7Tq+wzvCyadoBiQFUAkrEnzjRYppfldceHsk6UNOFoP3iLL31savGdRy5R4lm27ylQhkXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SB+qbyuE; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8c6d8751c88so548333785a.2
        for <linux-pm@vger.kernel.org>; Mon, 09 Feb 2026 21:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770702059; x=1771306859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3tE87q+qfGSEa6Oly0BwPABhpAUQacJ2LeCqBjkgvs=;
        b=SB+qbyuEMCueCNXVAN2qCjA9MBgLy2V5R5F4A/9HvmyoXR4N3Ssln2B2xbHwAPNoIX
         SeJl0cV1jr3xHxjYOb6dcW2Q4TsI4gM6BBjrbBScuv6VQokWrNN4wPJpRRdn95xJFssZ
         AxS+FU4tfolivLgvOZitspCsoMcRPkJzCtxKs9bO3QLRmpanR9A17xcwn4q8Hl6btuV8
         JyR+1q896BZp5l0DE4uVKKqZB6X3NPUPa3NrIr1K2m1Ug3fzWrh6OREkHLBZ1Z2IRUVv
         gELmlR/+VFdhRE29FvmDEvy/rwMx11/5nLdbIJBXT0QxgPKBniPkHgOOLCLNBtH1yst0
         XztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770702059; x=1771306859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b3tE87q+qfGSEa6Oly0BwPABhpAUQacJ2LeCqBjkgvs=;
        b=N4/qVIXj4pZMy72ha1SLwEkGw/O6pVBQB1E+ZkzQCsAiXHkbfQ5RdW6vDUGC/A/u8D
         DM/VNz7FNgKd9018eQ0clJDnhQuvZS5VYciJ1DBZB6+WS2suml6htl9TSu0AzOhU8hQS
         lb8CMipntDf2yjaRRv60vpjdFHDmBh+5tU3npClkVmpuX2gZ2QNDd7EcFBxb0wxnCd3r
         SOoa4xmDkeEcqT6TWn6AfKLFqDGDZ7MeAyzzsN14WInVW4d5j4NfyZC2KFDx7t6U0hRW
         ZPgHiVbySS9O/tUniP8l0NTFAT4ibJIGtKyWeKnyrQZ5r/81dn655kZEU4risMZAzGvs
         BbPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDkYRR5LMGwRD8IU4BYz13+sBKijEAz8a4KQTkHy/VYX842Q9qIbSZQbaM8/TJoLw+LjgTQCF04w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyM3wegZbaLmV99+owo3623Fr/BXvYpncdlwuOnSL6uqRhSqMr4
	mliliMEHGdSMsCoATygXOvtQzJ6Ate0YVhEt1mCchPThUivWevlY6fgc
X-Gm-Gg: AZuq6aI9PtkJHIEuQpx5mfCdG+GMkf60TQZseTN1nYxUycA370EYHTMZt4X5sakRVuQ
	9LG1TB6tBd5UO6qIPj8MAPE5Z075j6av1iXhRUzpORQhnJFzz3o0efcHuJiOYtBfAS3mfgx1QDQ
	kWXUzPzJNWt+S5f/vkFKM8pQco7Op1Q9Un0IV4oRUNjeIk/D9imT5ZqnPncpfduPidw6b/2hoOd
	1dMGnFvufrG1RsCIM6fqENZq1sTdbLooIQe784Y9Nm8DF8ZgdrNnFjkj4TBToTwCBVW6viDNWtw
	vYKzElY+ri9QOOcYBMcuKqvb8yH6dIePiibZy8fhGcsehwpLpZkKqCtfXJVSHWZbBKV3fEDcdYl
	8yTt+i6yZXMjrK0wg13R7GFZ+4Az0nJtqtY4rdtl5ctSkQCNFnLUc2ylpkaes4s7ySPiBePXRgD
	aRmYJt+ir+NEJEEB38iojsTn0KRvhq6C096UTdkY4Zz9RXw2320++ZVoQZTm/S8+wjFBW9Ce4FR
	w==
X-Received: by 2002:a05:620a:4041:b0:8ca:305b:748e with SMTP id af79cd13be357-8cb1f6ec283mr118885285a.57.1770702058705;
        Mon, 09 Feb 2026 21:40:58 -0800 (PST)
Received: from aford-System-Version.lan (c-68-46-10-116.hsd1.mn.comcast.net. [68.46.10.116])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf9ee9fbasm978632285a.39.2026.02.09.21.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 21:40:58 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: angelogioacchino.delregno@collabora.com,
	Adam Ford <aford173@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Laura Nao <laura.nao@collabora.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 4/5] regulator: mt6363: Fix interrmittent timeout
Date: Mon,  9 Feb 2026 23:37:04 -0600
Message-ID: <20260210053708.17239-4-aford173@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260210053708.17239-1-aford173@gmail.com>
References: <20260210053708.17239-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[collabora.com,gmail.com,baylibre.com,kernel.org,linaro.org,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-42393-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aford173@gmail.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 433971172B5
X-Rspamd-Action: no action

Sometimes, the mt6363 regulator would fail to initialize and return with
a TIMEOUT error, so add an extra instruction to wake up the bus before
issuing the commands.

Fixes: 3c36965df808 ("regulator: Add support for MediaTek MT6363 SPMI PMIC Regulators")
Signed-off-by: Adam Ford <aford173@gmail.com>
---
 drivers/regulator/mt6363-regulator.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/mt6363-regulator.c b/drivers/regulator/mt6363-regulator.c
index e0fbf92e7685..03af5fa53600 100644
--- a/drivers/regulator/mt6363-regulator.c
+++ b/drivers/regulator/mt6363-regulator.c
@@ -861,7 +861,7 @@ static int mt6363_regulator_probe(struct platform_device *pdev)
 	struct irq_domain *domain;
 	struct irq_fwspec fwspec;
 	struct spmi_device *sdev;
-	int i, ret;
+	int i, ret, val;
 
 	config.regmap = mt6363_spmi_register_regmap(dev);
 	if (IS_ERR(config.regmap))
@@ -870,6 +870,13 @@ static int mt6363_regulator_probe(struct platform_device *pdev)
 	config.dev = dev;
 	sdev = to_spmi_device(dev->parent);
 
+	/*
+	 * The first read may fail if the bootloader sets sleep mode: wake up
+	 * this PMIC with W/R on the SPMI bus and ignore the first result.
+	 * This matches the MT6373 driver behavior.
+	 */
+	regmap_read(config.regmap, MT6363_TOP_TRAP, &val);
+
 	interrupt_parent = of_irq_find_parent(dev->of_node);
 	if (!interrupt_parent)
 		return dev_err_probe(dev, -EINVAL, "Cannot find IRQ parent\n");
-- 
2.51.0


