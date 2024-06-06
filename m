Return-Path: <linux-pm+bounces-8679-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF488FDF3F
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 09:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F9731C22BBA
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 07:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163D77346A;
	Thu,  6 Jun 2024 07:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="G+uhaYG7"
X-Original-To: linux-pm@vger.kernel.org
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E061759F;
	Thu,  6 Jun 2024 07:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717657292; cv=none; b=h2rP8if852vVp5x08r/FtLm2Rnu+2xfRCbkN38p7JDQcPZpLtpVM+ibYa8BcfiKZhBfDn/D/Vs6EuqB4W6tPI2YaVYbgpzAnCz9hfaWqTsEC81+j5/3GoBarXfrM0BLlsyz3zU26/L7Op9STAPC9zU28tpy9KlaiveBJlYsoSus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717657292; c=relaxed/simple;
	bh=u2d9y4s5C/eawWNtQmjun0YrN8mP3uli7Ja1wgYHSD8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YSypGgasn8H9qWyDtvmriIHmuK8vcA3u6qsSI8JF0x6wcJHMbQKwmwXnoO5GDAP3ajLezPHRp9uSFci6BY5R3KI5/1nYGMxVV+Gd+d0f+kLiyaEoawBjpEwcy+fnegPppTAParrJv09MyHZbCaibRr+InSCcVBMks8JrtbzNSB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=G+uhaYG7; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=1N5I57/Revtp6UrX8p8blTZYOg7DzA2Hogau3tBSvvY=; b=G+uhaYG7yrCCnSUOc58Vl1z72l
	mqrQHb/RNh6HIST9NUYkp9Mv2++m6K5lllfzvMoTcbXF29FQ8sjodHg7HYwcgSrJWCqkEQdR60fZf
	yiM2ebd8gJ74AB04SULfxqzI8Y2/sPmXoTlSRgbxEtZajnpqOKqr0QMuZUY9mhKIw+lIhS6fXkWwE
	iAhiWaPq88R0Sumrl8d54iwGYpukKwJIB4NR1bX80eIKB1HPxgjnsEZ78bGaKMKEMYSIwxAJAsRGB
	KCXB6J8oYRydUkje5BjcuBVf57EiFV5Azgg9quR0LNOLn8CtGT1Epa4imdED4nZjIpM07UqUUJujZ
	4K2hWGsg==;
Received: from [89.212.21.243] (port=54268 helo=localhost.localdomain)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1sF77o-00BMJ2-2H;
	Thu, 06 Jun 2024 09:01:28 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: upstream@lists.phytec.de
Subject: [PATCH] OPP: ti: Fix ti_opp_supply_probe wrong return values
Date: Thu,  6 Jun 2024 09:01:27 +0200
Message-Id: <20240606070127.3506240-1-primoz.fiser@norik.com>
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

Function ti_opp_supply_probe() since commit 6baee034cb55 ("OPP: ti:
Migrate to dev_pm_opp_set_config_regulators()") returns wrong values
when all goes well and hence driver probing eventually fails.

Fixes: 6baee034cb55 ("OPP: ti: Migrate to dev_pm_opp_set_config_regulators()")
Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 drivers/opp/ti-opp-supply.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/ti-opp-supply.c b/drivers/opp/ti-opp-supply.c
index e3b97cd1fbbf..ec0056a4bb13 100644
--- a/drivers/opp/ti-opp-supply.c
+++ b/drivers/opp/ti-opp-supply.c
@@ -393,10 +393,12 @@ static int ti_opp_supply_probe(struct platform_device *pdev)
 	}
 
 	ret = dev_pm_opp_set_config_regulators(cpu_dev, ti_opp_config_regulators);
-	if (ret < 0)
+	if (ret < 0) {
 		_free_optimized_voltages(dev, &opp_data);
+		return ret;
+	}
 
-	return ret;
+	return 0;
 }
 
 static struct platform_driver ti_opp_supply_driver = {
-- 
2.25.1


