Return-Path: <linux-pm+bounces-33662-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 451C6B40D19
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 20:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15159563532
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 18:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E367B34AAED;
	Tue,  2 Sep 2025 18:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="OmAC73NJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6B8342CAC;
	Tue,  2 Sep 2025 18:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756837425; cv=pass; b=h/nIbSp/dIUVcLs3sRjPhOX+DWbsnCGu77WztxUxnXy+YhfRc2Ag9Z3st87SH3Hf8BkDIMu+X5Vza2v5gmAQvgVltiZMHyJiTgmxzqRL10U/nm4lbWi4ZtAmsXzjH+yGAWKn7KBRW0RycHnj6zXT2I5oXh9USbtYPHRfnOw+mEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756837425; c=relaxed/simple;
	bh=86yFnlbFgfJOZ1JVMwGweD0cPnE4acOJf3zcLI5fsQU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BRnKU2LbyoquCMSQRexToQoCuEgjGq8oWB/qERzW2GQsY1+le9kWYfck8ZLRhQPhoIlV/IKSkkbDl+5hCsGc2BuYwjfao656G264c3eWRDBQSBi+CLiuyew923S1BwwqjMXXN4Y15tJEyQJT+aql6OrAi6csQeBBWkG7Hz2sGew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=OmAC73NJ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756837404; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iVaC1acz+cP2ZbGgsiwgo01uh/ELXH7m4/LAWjXSvaz47uaJMb2tsZOwpA9EMdRICSZMZtWP5LFhmXNM5rb0F5DW86rY04Qm6oEMYkWljZTZLpxcY7tJpexHerZK9JphzL09YFfW++8y7qI4rJ3OdVutRcxuE2VEijk/m3++Nb4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756837404; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=BCFlD1zHgQgM4xri0/j82ex/DVmcdA0YHQ4MAtyH7xs=; 
	b=asOwdXhamGQusT7/wMBK3mxp0Jye+ZDAZN8aDoTpGXFxc0uoC4IpbcSQwPJVxztRcRparxiiE+j9rmuOxdJYnt7Gu6Wp3d00R0iwN1hhg5T6xWaU0shXHZqiwAOg/MlG7g3dqI0Xux7UZiWp39PamO66/529bK5mfZEvddWYGi4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756837404;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=BCFlD1zHgQgM4xri0/j82ex/DVmcdA0YHQ4MAtyH7xs=;
	b=OmAC73NJoqFQKkZxTWM+3KfV6EGtWhyv8kt0G/CjhzhvFcvW8UyMEOHxjcoA3N7F
	e73dZRt8XRh9rOWAQXEiMPCLQw1eol5TZlXby+f22f004zYxImj3KbTbwqTvaD6ORHm
	aNRuQipJseF15Ml9savpQ9KxIoFzkmzf33o9425I=
Received: by mx.zohomail.com with SMTPS id 1756837403727645.9913468928908;
	Tue, 2 Sep 2025 11:23:23 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Tue, 02 Sep 2025 20:23:04 +0200
Subject: [PATCH] pmdomian: core: don't unset stay_on during sync_state
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-rk3576-lockup-regression-v1-1-c4a0c9daeb00@collabora.com>
X-B4-Tracking: v=1; b=H4sIAAc2t2gC/yWNQQ6CMBBFr9LM2jFttTRyFcOC1ik2CMUpEBPC3
 a2yfD9572+QiSNlqMUGTGvMMY0F1EmAf7ZjRxgfhUFLbeRNauT+YmyFr+T7ZUKmjin/JDROBRW
 cDUErKPrEFOLnn743BzO9l/IwHyO4NhP6NAxxrsVanZVF9ldo9v0LIgl9dpcAAAA=
X-Change-ID: 20250902-rk3576-lockup-regression-5b1f1fb7ff21
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, linux-rockchip@lists.infradead.org, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

This reverts commit de141a9aa52d6b2fbeb63f98975c2c72276f0878.

On RK3576, the UFS controller's power domain has a quirk that requires
it to stay enabled, infrastricture for which was added in Commit
cd3fa304ba5c ("pmdomain: core: Introduce dev_pm_genpd_rpm_always_on()").

Unfortunately, Commit de141a9aa52d ("pmdomain: core: Leave powered-on
genpds on until sync_state") appears to break this quirk wholesale. The
result is that RK3576 devices with the UFS controller enabled but unused
will freeze once pmdomain shuts off unused domains.

Revert it until a better fix can be found.

Fixes: de141a9aa52d ("pmdomain: core: Leave powered-on genpds on until sync_state")
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/pmdomain/core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 0006ab3d078972cc72a6dd22a2144fb31443e3da..4eba30c7c2fabcb250444fee27d7554473a4d0c2 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -1357,7 +1357,6 @@ static int genpd_runtime_resume(struct device *dev)
 	return ret;
 }
 
-#ifndef CONFIG_PM_GENERIC_DOMAINS_OF
 static bool pd_ignore_unused;
 static int __init pd_ignore_unused_setup(char *__unused)
 {
@@ -1393,7 +1392,6 @@ static int __init genpd_power_off_unused(void)
 	return 0;
 }
 late_initcall_sync(genpd_power_off_unused);
-#endif
 
 #ifdef CONFIG_PM_SLEEP
 
@@ -3494,7 +3492,6 @@ void of_genpd_sync_state(struct device_node *np)
 	list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
 		if (genpd->provider == of_fwnode_handle(np)) {
 			genpd_lock(genpd);
-			genpd->stay_on = false;
 			genpd_power_off(genpd, false, 0);
 			genpd_unlock(genpd);
 		}
@@ -3522,7 +3519,6 @@ static void genpd_provider_sync_state(struct device *dev)
 
 	case GENPD_SYNC_STATE_SIMPLE:
 		genpd_lock(genpd);
-		genpd->stay_on = false;
 		genpd_power_off(genpd, false, 0);
 		genpd_unlock(genpd);
 		break;

---
base-commit: 5cc61f86dff464a63b6a6e4758f26557fda4d494
change-id: 20250902-rk3576-lockup-regression-5b1f1fb7ff21

Best regards,
-- 
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>


