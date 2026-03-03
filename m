Return-Path: <linux-pm+bounces-43492-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Na0Oi/hpmkPYQAAu9opvQ
	(envelope-from <linux-pm+bounces-43492-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 14:25:03 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 060581F026B
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 14:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6B8B23011524
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2026 13:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5776242F545;
	Tue,  3 Mar 2026 13:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E0goQyIl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FEE423A6B
	for <linux-pm@vger.kernel.org>; Tue,  3 Mar 2026 13:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772544214; cv=none; b=jSDeyQd0agdB/1UBW4t0oXFDjM2SxmNiE1uRErjLyofpNku9XGUwcfZSQsSoF4rX7QIH7Y7ddO3Tw0kpuJTzYN2d1eI9e/Ov3Mz4+xyHojN7t1imVdQ5z+yflkUpoSuES26UhCqb/G99ApTWWsW5CTl+AFSd6Dqh0r//cx+7iJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772544214; c=relaxed/simple;
	bh=WKqv0V5RDTnIOsUpxiUcyJteviqImj57nQdHfZtzZbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F9DbgoIKXvWe7SXhOCbbkKstfJ/9ndLwFRXkEKxylI0pt0ZxjQZ+8Hw4Odl3sGmcxeJBuocOxYqB/jhYLnIt/UFtM3Gp/2fI+54o724FCTTsOiWdGHCxfKdB9abowwm6zJ5IYAmn5iGoVzAo00Nlhh2J70lFtLBumx038wcPjNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E0goQyIl; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-38706f96202so70192221fa.3
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2026 05:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772544211; x=1773149011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NdMfo9Xg2r6aJvOcLQwOOsrACKCVOknll0GbpvMaoA=;
        b=E0goQyIlS/yRgXjHPtZ+vQX8jwdijLa7DVLE4MvgiGKp/vQ1dUmCYOOa77rx2qI2aL
         cwpzxSTtlDC3DImTRM+HYjYfF1eU9tCCS2iPnrTN1Rab8x/4OMOJ2k5ZDZo6ZthpbFS/
         JGcLXTzifR4G6YT9JFieGd5/VgnqFgY31vaibxJCDZGO2MtPbAUVifYLhFR5FCbj65Il
         xtUMnToQZ73VUGzvZPCgpxBLA0mcHvnRGos7KYfPv5RS8JsWWYKoJfG+CrYdfUQsm4YO
         SuXSr6rRMl9lo8d06brZdd5eC3siLPdbroNjFydX53BZGPhgW4LOepRn9waEqX6Mega8
         f3HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772544211; x=1773149011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7NdMfo9Xg2r6aJvOcLQwOOsrACKCVOknll0GbpvMaoA=;
        b=IwTv4U9h5IwY+DfBhNasZzkRsoBmuGGi6wdVYlRahBoXfYgig88jA+XX8zZ/kmZKSI
         PXf3uAGXoWpeouptdKuTieRL0pZIjA+C2CT65lq9dV0SXHk8oFaGBwxxYJ4Awp6OGNGW
         yuuT6TwtafKvfirG42rnApWwaQhUcXOPIIQmwcGNGrX60Nw4vFwAi1audo6IzRfUTYGe
         mxkiLNoo+Q4IG/Asg3c+aKYAxkc3tnsquSPvrD3Ra6tK4EF49PFQfyfSTGw8Ftg0OZt7
         Gm2FBppJF4u6irPJgy3ofZ6MscJ8V62zaLkE8f24KBHTsd2j4xPhgfsSoSZ77u5H/Gfz
         raLg==
X-Forwarded-Encrypted: i=1; AJvYcCUidWGXARbNVIWCVO1bHyokI59l2MwzYkLAjCLbti0fa9ajDbiH/J4rMmwcS85TqLWB++5bytQL7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPpjJBvL11NsKQ7xyQBLl8IFe7DrpenkCg3vCQF7QGclLVLvXb
	it/rUsJCmM5SdyJR/Vwy7ptKHmto2wJ5CuSSEsfNNa36YC11Vz/LS+ymgybpXWH0CGk=
X-Gm-Gg: ATEYQzwu7dLxjsVSY6CbSZB/fLsxUhmIdowPkvk/Edc7HCoaOuT5G9eJh39Pb+eNyYI
	0gTFmDcMBUG7Al1N+RMQ/UEleCwnqyzu1hTrgkEioE9g9gjgLKP2Gh0BTMR8qtLP9jCWIc4dlRH
	u+C72+BElPBK7g3dAvTbNq7qVaPGlJmTGQh2LZkx2xvACkYhSKOWPakRBfleIKOUZrzMaLKUXvb
	QXGofYdYHa68BJVxtCr4hkaS8/TGP2cfBxTtZhgjl7oNwyMF5VKqy5iPK/njyqjBtii2fA9E5w4
	DguMg4l7oq/gW1/f0JMM2yzOQr0eFlias8bbtzValCQhfTvS1pTgKZsbBKbXgVMyGBdxT0n6zAz
	PkMdPspowueXCUZrr48O71yRRXCKxO4SxZV9SN/Ipb6zQWwMhmVODcnrDbYH7oWM1fEvJgp/nRT
	Qvsa+jpsnzQiDbtLXJhOVUbh7IpdJ/YHSv9FLiTUq9XE4TW4DXh2gTw0SLw4kRHuxcBNGywGypW
	/0h2lnp1J8=
X-Received: by 2002:a05:651c:552:b0:37c:c84a:99b9 with SMTP id 38308e7fff4ca-389ff34ecc7mr108930621fa.24.1772544210984;
        Tue, 03 Mar 2026 05:23:30 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a1235811e3sm587866e87.29.2026.03.03.05.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 05:23:30 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Saravana Kannan <saravanak@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>,
	Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] pmdomain: core: Extend fine grained sync_state to more onecell providers
Date: Tue,  3 Mar 2026 14:22:51 +0100
Message-ID: <20260303132305.438657-6-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303132305.438657-1-ulf.hansson@linaro.org>
References: <20260303132305.438657-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 060581F026B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,samsung.com,oss.qualcomm.com,oss.nxp.com,ideasonboard.com,gmail.com,nvidia.com,linux-m68k.org,linaro.org,lists.infradead.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-43492-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linaro.org:dkim,linaro.org:email,linaro.org:mid]
X-Rspamd-Action: no action

A onecell power domain provider driver that we can assign a common
->sync_state() callback for, should be able to benefit from the improved
fine grained sync_state support in genpd. Therefore, let's also assign the
->queue_sync_state() callback for these types of provider drivers.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 53401db2a386..e0b9dd15a949 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2921,10 +2921,12 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 
 	fwnode = of_fwnode_handle(np);
 	dev = get_dev_from_fwnode(fwnode);
-	if (!dev)
+	if (!dev) {
 		sync_state = true;
-	else
+	} else if (!dev_has_sync_state(dev)) {
 		dev_set_drv_sync_state(dev, genpd_sync_state);
+		dev_set_drv_queue_sync_state(dev, genpd_queue_sync_state);
+	}
 
 	put_device(dev);
 
-- 
2.43.0


