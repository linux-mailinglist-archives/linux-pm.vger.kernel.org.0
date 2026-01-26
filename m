Return-Path: <linux-pm+bounces-41489-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AADVG4C4d2nKkQEAu9opvQ
	(envelope-from <linux-pm+bounces-41489-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 19:54:56 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1891A8C3BC
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 19:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01CC4301FA7A
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 18:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D47D25BF13;
	Mon, 26 Jan 2026 18:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O08VUooE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AC725487B
	for <linux-pm@vger.kernel.org>; Mon, 26 Jan 2026 18:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769453691; cv=none; b=r6Rf521CwPdF2XO9ll5kw5HYaY1H5j2cJiUAs33bpSzT2qtUOFT93tinzX2Azei++nL31fqQF1LCCcxV2zMLPqkBKH4LaMx81yzFfahaAAJ1SHCyF6tpnSwMviuHPEqwQcpexpBFjbnGgU3e+ShdCdLmgZwoh4YvsIuB+bsYBhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769453691; c=relaxed/simple;
	bh=1+5DCp6OHuKcpHx/26jzXFcnmrgHGTiIgTauDkixbRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gMI0qSAFCRBJOxNvsmVjbxJPgK48MkoQ84sTuLPuQQEpmohzcx7LkBUoi2UX7tpsR8zG9zeFC+h0rBti192n3Rc1/rhmBx4Ca+WayWc7qrL+5qOIzyLDZjcEEDvYIJOvypCN55Ogh1VLHqifx4tbcKlU7SIRpTe1DZ8+nAo6Mmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O08VUooE; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4801d24d91bso50773275e9.2
        for <linux-pm@vger.kernel.org>; Mon, 26 Jan 2026 10:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769453688; x=1770058488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DkYHBbf51iPoTKTb/DYQ1Urxy3yreGvpCuibSsYjEfk=;
        b=O08VUooEHqZP99OBKgphpyM1x2G+l5I83pvvSWY9ZwHkn1mCOD35UmFETDnntnW4wY
         O82qDe1A4AWpVU6hIU0ONs97tn/Jt3/5HDXq767wXz/AqcB7ZEj7GMFAHS1IEClI2uYM
         eJk2kkeXJAMgiB4AG3Nfjb8H6nIYDce4WgIwFVDJ/sNzY2BrWOep5IArk/lXcIt+yji5
         lYbkKmkpTj7ilGFYe4K7nsot9Quyl+G9HX5GyrrzZSfcsFMYAIXjn/hRwXuGZqshHrls
         H6ORjnI/4w9WQpou0iDtR6H4NCm/8lsuVk9ySQZ5vPdExrJWywdlG3xEFLaOcVI6qL2D
         dWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769453688; x=1770058488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DkYHBbf51iPoTKTb/DYQ1Urxy3yreGvpCuibSsYjEfk=;
        b=WBgya4GRi+7sbro8umqvakeKiOh5jq9FX5ks9CCUDFrR2/EkKQoGkkN3paZkctCtY3
         3Wj+gWLjVVL6cmW/4LqZTl5TmKI+u1VJXSKfmVZ/j3bDPXfyLEBdPql8lyyAmFGFmn5p
         EbxswzEliQSrS05IcI0/fk8sUKi9JlNpwj6a2LO0W/zzK0UT8L94za1viV3RvRSU5hiv
         PAs/VoFzcwY9CqXLMM6wslYAKX2cpMODWb8Vrnw6GF7j1i4CoWUgXKionxjgf+HjI65M
         DbmigebgibqgkNL2qGsxW63CaZM4erkKgdO+YUeoLKWcKVrBc5I6P9UhGvEFxyJA3bqk
         swCQ==
X-Gm-Message-State: AOJu0YxtTPh7SaAmS0xgJy+uIZPKlPUo3He+PDEulzVzxcpeISpATd3R
	S30LyWzijyerFaVXFrUCaJRFH9pgsPQNikttAQh2O3PDmgKsf5UjFLA6
X-Gm-Gg: AZuq6aIgJV32vDEpn3bA1BDqNllFZRrw20C2FHb93WAKVM724z4GV9VtwhookftimW5
	T7/Io+/0kodqpFiWvbn/lrEGRmuYeB4EFlOS8+kHxM900gEq2WqB8CL+0B3fYw5sHEPsUnkPbF8
	c/DmHmFTOhkWX5b5kL/IspEF3zC0+H+JrUIVw/2UrYpalR5giQ4zisHkQBp+hsQEiXExkANFsdD
	lQx3maZh9inZ/Vr1oXSM1jg3qzmQ0cjN0WMGkTmorFEEaiGvc0cNJpRJGDHmQyz/4u88SW6Y0n1
	xy/ygWobvD7KW0Fs/UWsacZ/yCFucJRprvATGGlPJYKLd1X9RomLpBX/WQyo1RfjZqrhvMZShB3
	ilhNS45i2g14zyUpv5xtyyEl8yuRMJFACQL2OcYfM6q7Cs3sJin9x00JU55CvquXFIS0rh5PP/r
	75
X-Received: by 2002:a05:6000:2313:b0:430:fa58:a03d with SMTP id ffacd0b85a97d-435ca3ac2aamr9067059f8f.63.1769453687994;
        Mon, 26 Jan 2026 10:54:47 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f742d6sm31793947f8f.30.2026.01.26.10.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 10:54:47 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] devfreq: tegra30-devfreq: add support for Tegra114
Date: Mon, 26 Jan 2026 20:54:23 +0200
Message-ID: <20260126185423.77786-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126185423.77786-1-clamor95@gmail.com>
References: <20260126185423.77786-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-41489-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,samsung.com,nvidia.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-pm];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1891A8C3BC
X-Rspamd-Action: no action

Lets add Tegra114 support to activity monitor device as a preparation to
upcoming EMC controller support.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/devfreq/tegra30-devfreq.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 8ea5b482bfb3..fa83480a923f 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -963,16 +963,22 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	return 0;
 }
 
+/*
+ * The activity counter is incremented every 256 memory transactions. However,
+ * the number of clock cycles required for each transaction varies across
+ * different SoC generations. For instance, a single transaction takes 2 EMC
+ * clocks on Tegra30, 1 EMC clock on Tegra114, and 4 EMC clocks on Tegra124.
+ */
 static const struct tegra_devfreq_soc_data tegra124_soc = {
 	.configs = tegra124_device_configs,
-
-	/*
-	 * Activity counter is incremented every 256 memory transactions,
-	 * and each transaction takes 4 EMC clocks.
-	 */
 	.count_weight = 4 * 256,
 };
 
+static const struct tegra_devfreq_soc_data tegra114_soc = {
+	.configs = tegra124_device_configs,
+	.count_weight = 256,
+};
+
 static const struct tegra_devfreq_soc_data tegra30_soc = {
 	.configs = tegra30_device_configs,
 	.count_weight = 2 * 256,
@@ -980,6 +986,7 @@ static const struct tegra_devfreq_soc_data tegra30_soc = {
 
 static const struct of_device_id tegra_devfreq_of_match[] = {
 	{ .compatible = "nvidia,tegra30-actmon",  .data = &tegra30_soc, },
+	{ .compatible = "nvidia,tegra114-actmon", .data = &tegra114_soc, },
 	{ .compatible = "nvidia,tegra124-actmon", .data = &tegra124_soc, },
 	{ },
 };
-- 
2.51.0


