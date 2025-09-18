Return-Path: <linux-pm+bounces-34991-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C69B863A0
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 19:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15C797C8693
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 17:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E719131A579;
	Thu, 18 Sep 2025 17:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="UUX3oyxl"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393A731A54D;
	Thu, 18 Sep 2025 17:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758216849; cv=pass; b=NZpfh4+mh3pgq4G/BdNsoMbgUvALHpCaCAYBCjxmK6AMtFGDjp0zWbJ6tMiFuzLkigQIuP/RyyxSTa6r8B+KV+iUj2Noejprjfcb6NDcmq9qvcwuj+79GJeqtpKR3FNk4vVpOzDS9o8Sd31e5jIC0jWi1sX7wwLqCf9KMjKPJxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758216849; c=relaxed/simple;
	bh=+nfB0fQiINFxD7VnPVNGxeX2KZATIEwRDmxJnHC1ZQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vry6KglCXa8M0rQ9jXAiKOW3Rr5qoZvSgycY/pmH+mo07lVtLKeihDZdG3aSCwf5jSk+R50HkXiBTgOwnt41XmQU5onKt1ayzkxCe0kh3DCXubf/LveihcXDZPnIfGqjcxJRHl+8sI/o3cTAB+Hngg/v0MQUESRyR6ynUNRfUcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=UUX3oyxl; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1758216834; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jQ4Z/FhppDPJRcR308Tfk3OtC4kU9/BoPy/iN5RHx2Z9lVLsihsl6Ypd5PhDxferk6ZfWWtZBCwcDMdbvWdB571xMEJBBDRQMQXt++Dpjz7umlpKfSCU6nhBkwBejK3dv691rjNwUdCvegS+8X7A/R1iCd87gyWH6+fp7pjvhC8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758216834; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=lEFxTFHiyI2q/oDLkp6vLKAusartnU5WLpPBBCAmUB4=; 
	b=XL0LoWTCect3d6Ld7kol6d0cVSQxdghvMQ68o3EpiECEDamc+4hemSM+XT8WEhas7Kgz1q+gaNlwvd7jHF13xqYw9ccp7N0m+LtemC8KGEyVNs4D63d4KG9vaLL4zRoLBbiPwYvC68dEAz0A8gl06RqifFcdXV4adfqtX8LNPEI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758216834;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=lEFxTFHiyI2q/oDLkp6vLKAusartnU5WLpPBBCAmUB4=;
	b=UUX3oyxl32yNEYujg2yPxxXKznw0246z9eigktItrIPWUPNddSJa6IySPM0PWpng
	Lks207vEty3vTFFkW7ryb72EyJgKyifzvr+LcwIzy+iQiXOHGBoLtPV4ME+Pf/HSyqH
	dB2WvL8EUY7DD4XxU7OJSHGBLPuvCv7svs8dj7WH6cusy6PsB/qvGycacDMJ1a7lS9r
	7gN7YhoTN0VHY+WV4lZCsNGzWmFnp6jSg1hvojsS8Sw1VGP91IZrwIQ1j08XrxTzGxf
	AACyr2yBjtbNirZlegdshDwW3g77maPfpkSxG0zlreiKZX99eugecBzK53L9DfrHH45
	u7+u+k0xcg==
Received: by mx.zohomail.com with SMTPS id 175821683282116.852562929362648;
	Thu, 18 Sep 2025 10:33:52 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sebastian Reichel <sre@kernel.org>
Cc: Han Gao <rabenda.cn@gmail.com>,
	Yao Zi <ziyao@disroot.org>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-pm@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH v2 2/2] pmdomain: thead: create auxiliary device for rebooting
Date: Fri, 19 Sep 2025 01:33:23 +0800
Message-ID: <20250918173323.340738-3-uwu@icenowy.me>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918173323.340738-1-uwu@icenowy.me>
References: <20250918173323.340738-1-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The reboot / power off operations require communication with the AON
firmware too.

As the driver is already present, create an auxiliary device with name
"reboot" to match that driver, and pass the AON channel by using
platform_data.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
Changes in v2:
- Rewritten to use devm_auxiliary_device_create.

 drivers/pmdomain/thead/th1520-pm-domains.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pmdomain/thead/th1520-pm-domains.c b/drivers/pmdomain/thead/th1520-pm-domains.c
index 9040b698e7f7f..5213994101a59 100644
--- a/drivers/pmdomain/thead/th1520-pm-domains.c
+++ b/drivers/pmdomain/thead/th1520-pm-domains.c
@@ -173,6 +173,16 @@ static int th1520_pd_pwrseq_gpu_init(struct device *dev)
 					adev);
 }
 
+static int th1520_pd_reboot_init(struct device *dev,
+				 struct th1520_aon_chan *aon_chan)
+{
+	struct auxiliary_device *adev;
+
+	adev = devm_auxiliary_device_create(dev, "reboot", aon_chan);
+
+	return PTR_ERR_OR_ZERO(adev);
+}
+
 static int th1520_pd_probe(struct platform_device *pdev)
 {
 	struct generic_pm_domain **domains;
@@ -235,6 +245,10 @@ static int th1520_pd_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_clean_provider;
 
+	ret = th1520_pd_reboot_init(dev, aon_chan);
+	if (ret)
+		goto err_clean_provider;
+
 	return 0;
 
 err_clean_provider:
-- 
2.51.0


