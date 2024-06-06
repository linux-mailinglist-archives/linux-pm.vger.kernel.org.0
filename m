Return-Path: <linux-pm+bounces-8682-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 624AE8FE062
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 10:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12531285DBC
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 08:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C18A13AA37;
	Thu,  6 Jun 2024 08:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="gc02nB3m"
X-Original-To: linux-pm@vger.kernel.org
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007BBDDD2;
	Thu,  6 Jun 2024 08:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717660815; cv=none; b=eOO7EFZsoPq6m32wzGSFL4PLAUKNm2lH0/sJiuN69VedD3pkXPBNhBOAZuONb26nt0TKYiT8v8zEc9eATafsBhK3dKZh34S7Pr5BNGOSeIdqkSiuwChNDzonFfz3zf7ITrsSLyFGJ2sI4VnWbNZfEjvlUuqw7Ck8XBhUF4scoCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717660815; c=relaxed/simple;
	bh=Ak1BS+N2hxN31gVoTINk9MkwbzX3wDaas+UKq8Y0N+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oOkRv/JW/oyOfhBVMgVBPKuHw8M5/YvQv7pj9vonpAG7cJ+nLJJVruDrfCWR3EWYA/7oOJehquIL8haIifCu/cCocSTxu+P1K3xA6Xegj2DMEbUlOcFoU3Wh+k69V64GmowbYurxGg1LhPBV16ejVkXLrGmG5rvsA71Z1QU7gmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=gc02nB3m; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=2w3JhfpwL0Tvop0IRVooZ6F1QlwSS/l8vdkwdoCQSuk=; b=gc02nB3mxbwZZjvNel5sOKAvHz
	Uq61HZWhCMY4KlHGmkl87C2s2N9Qhqana3xNSWZAAvuQo0bdotXV7e3OeXxL7O+mGpzkSBo84zzh/
	Ycad7ATmYdxsASaroMgps1HAALNI3R/7OhX9kMCxIT+ETJqgu+1K68Y0Yd3bNpiyb30XGvkq3VyqC
	6QXrm2MPYMgQYom7JRcctVvTrdaAVqDhj4Jsdde9e9xs24ebeTMaPvoEI12BYGwCWJCcnDrFBX3r3
	CAtjVeI5kXYL9Psbly50khY/Gx+y1r803cq1lrs9/JpZZCAVqNKZFLbChMc/Ly+cLYqqEcAi6I2h8
	Q33eVyaA==;
Received: from [89.212.21.243] (port=47232 helo=localhost.localdomain)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1sF75E-00BLkc-39;
	Thu, 06 Jun 2024 08:58:48 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: upstream@lists.phytec.de
Subject: [PATCH] cpufreq: ti-cpufreq: Handle deferred probe with dev_err_probe()
Date: Thu,  6 Jun 2024 08:58:47 +0200
Message-Id: <20240606065847.3499145-1-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Handle deferred probing gracefully by using dev_err_probe() to not
spam console with unnecessary error messages.

Fixes: f88d152dc739 ("cpufreq: ti: Migrate to dev_pm_opp_set_config()")
Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 drivers/cpufreq/ti-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index 714ed53753fa..5af85c4cbad0 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -417,7 +417,7 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
 
 	ret = dev_pm_opp_set_config(opp_data->cpu_dev, &config);
 	if (ret < 0) {
-		dev_err(opp_data->cpu_dev, "Failed to set OPP config\n");
+		dev_err_probe(opp_data->cpu_dev, ret, "Failed to set OPP config\n");
 		goto fail_put_node;
 	}
 
-- 
2.25.1


