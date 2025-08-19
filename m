Return-Path: <linux-pm+bounces-32624-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF481B2C035
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 13:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C9217986E
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 11:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A13284887;
	Tue, 19 Aug 2025 11:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="gE6XjuLL"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4594827876E;
	Tue, 19 Aug 2025 11:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755602545; cv=pass; b=hTCpIOWGEuyKQ/aWKdHNlgcmOC8DB8+R+uUBMECWcmyX/4ociGRIATs4R5BuqJl2UgEngDIoLj1OGRJVda6WsODfYhhz5yvJThJNvrC02meydhBr+7Nqe2hKea3tXiHh4bbjtp4UUtLF1P3YrN9N2vid4Xme0zmVqARo+ogQmxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755602545; c=relaxed/simple;
	bh=PwxyD5Nd4Inf8ouIOSPYmKwVDesQhiuJ04jPckGEnDg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tuSaEKi0Ipoj9BuLicaCCRPhuwcJZ5EtJsXTPeBU5RS1tJvOsfLROifVBbhiCNqjBw/x7f2fR3N9kZa0hNk/+oiOPqMkTvAFngUUzOCsePyTO72usepkOtJlol4vuqeH0U5wmoGvwaN1kbdHKer7zEmTLA9c6K7kmhDX64FfSUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=gE6XjuLL; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1755602528; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=U6mim+bj1DPuhw+mUqGMsaZIBQpViqTSNcsjW1k6mqrfip4/xz6tmvNEQXvmYGNbJvqjTteqkAzG6YYe7EeJ0oACJlg74QyOpfFR7l4ZfpHi99ajVjtoEFPWctPdogxJozHkLjMFZUmFTbHjSdlhZng8eyXxCFzP3ZtrgUpkrV4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755602528; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ceXQjJPZTjxdNgGeYxtuRD2GWkq7Nnr+y3XAJ3hERGc=; 
	b=HC7BT6cLRtDpd8eAZva6lW6GmtfitIRgWkQeiPJPieDlCfug/rb0qHZhYVtuGo7g+GKJ6BbZTrWimf4EibVubG916ezXPzUCgWNqskaz8grP6OH0ay4/haiMdhkvXMrbcxjI+By9qHdK9KNsJZXJzhg/NG8suwzjS2vMuE9ZDCQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755602528;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=ceXQjJPZTjxdNgGeYxtuRD2GWkq7Nnr+y3XAJ3hERGc=;
	b=gE6XjuLLjtBAdC9wso2XRrgBBJPvPoiTOGKbmiXrft0GnskTx2C7+qwqJBka5JYc
	hmEq7sbQII8WQYi5zhED0HNLNv2U8YPakBzPl8kLLi4PMq1fa3XZMnL7E9r7HUajJ6S
	Ch8QUiN5vNk+KYe3Zgs+fXHTPFFo6cqBVq6pEnPQ=
Received: by mx.zohomail.com with SMTPS id 1755602526685939.769654379773;
	Tue, 19 Aug 2025 04:22:06 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Tue, 19 Aug 2025 13:21:42 +0200
Subject: [PATCH] cpufreq: mediatek-hw: don't use error path on NULL fdvfs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-mt8196-cpufreq-fix-v1-1-adb60a3082dc@collabora.com>
X-B4-Tracking: v=1; b=H4sIAEVepGgC/zWMwQrDIBBEf0X23AUVTNr8SsnB2rXdgyZVUwIh/
 94loZeBN8y8DSoVpgqD2qDQlytPWcBcFIS3zy9CfgqD1dbpq7lhapIdhnmJhT4YeUXdO9eH4C1
 FA3KcC0l9SO/jyTJdxN3OEh6+EoYpJW6DyrQ2/Pth3PcfO849wJUAAAA=
X-Change-ID: 20250819-mt8196-cpufreq-fix-07557cca2ef1
To: Dan Carpenter <dan.carpenter@linaro.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: kernel@collabora.com, 
 AngeloGioacchino Del Regno <angelogiaocchino.delregno@collabora.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

The IS_ERR_OR_NULL check for priv->fdvfs is inappropriate, and should be
an IS_ERR check instead, as a NULL value here would propagate it to
PTR_ERR.

In practice, there is no problem here, as devm_of_iomap cannot return
NULL in any circumstance. However, it causes a Smatch static checker
warning.

Fix the warning by changing the check from IS_ERR_OR_NULL to IS_ERR.

Fixes: 32e0d669f3ac ("cpufreq: mediatek-hw: Add support for MT8196")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-pm/aKQubSEXH1TXQpnR@stanley.mountain/
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/cpufreq/mediatek-cpufreq-hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
index e4eadce6f937ceff51b34d22da83c51b4e9aa813..fce5aa5ceea033bb70537ad9280e9ee02e3671cc 100644
--- a/drivers/cpufreq/mediatek-cpufreq-hw.c
+++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
@@ -72,7 +72,7 @@ static const struct mtk_cpufreq_variant cpufreq_mtk_base_variant = {
 static int mtk_cpufreq_hw_mt8196_init(struct mtk_cpufreq_priv *priv)
 {
 	priv->fdvfs = devm_of_iomap(priv->dev, priv->dev->of_node, 0, NULL);
-	if (IS_ERR_OR_NULL(priv->fdvfs))
+	if (IS_ERR(priv->fdvfs))
 		return dev_err_probe(priv->dev, PTR_ERR(priv->fdvfs),
 				     "failed to get fdvfs iomem\n");
 

---
base-commit: 73df59e80dc7cab098b4581b89459d18f8410c7d
change-id: 20250819-mt8196-cpufreq-fix-07557cca2ef1

Best regards,
-- 
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>


