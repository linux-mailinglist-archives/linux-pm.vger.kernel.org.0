Return-Path: <linux-pm+bounces-8706-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2569D8FE569
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 13:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C14AF281554
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 11:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751C51953BD;
	Thu,  6 Jun 2024 11:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="BwGdYzfi"
X-Original-To: linux-pm@vger.kernel.org
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7210645C14;
	Thu,  6 Jun 2024 11:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717673619; cv=none; b=q3ClBHokdh3pEMYGkIvZL1l5+2Auu/G4lCFThnlFkUi4f8dRDoQU1Sox1yfvjQ3kWYSyYRxXhA5NUd6XZNM+MkPymVklbTe4ylZsFd5fs5UY2qMvzZg0EIHhH0L8B0c0M4wRt4aGeTmh/bNJC6JBkUfYAl9cZIoB1kwc7AbXLAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717673619; c=relaxed/simple;
	bh=iD12U2vZ3kJgaV3rF7gRkielB0EuCxSPUs71nz4e1As=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q0T1MDaVhxs7TOSfw3XrR4HBIL5hjmihWc+O8u40ONXct/5A5xBs0CuPo2MmLI95NF1gnqR8D/5u7w+pEyVQ+jGTD8Rq0A69PSqzfk7SwNoDvkqYOraJXsOnOjrsHVdJ0/zm7K0FSlDEdq4kLkyRFgR+Uj9JBsX7ajDuPgI/Qpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=BwGdYzfi; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=OBceoEMMl03Lp422w48FgUCjPnYhwQJduQ50LiJeZ/I=; b=BwGdYzfiw+YRO2rOmXo9ipbLml
	L2yhAxArLo7KC5B5R29mdMMVggK5eoWM3GKymLgV3AgkWJMq5VNW+NNeQKY2BokhXYjj44bET0XSc
	PWOjnAUD11BXImo4c18OpOAaceJycDqaLx1ZRDFzw5rq4pNYeGkFx8kkqbqxdz7xbGGh53/OlqylZ
	/uK6kkfESzamc2XTQumND1xsT62oAJYfFx4/YZZPGx1/j55Qy/aq9Klw1nQPwsWzQA818ktAcBKO5
	3TqecXIDg15+vlYFaag5teOaV5fbLsansEQK5NdM766OnHjcWuY7n1KEo33UB5So9i4PWvSkJ9D46
	WsRQUlqg==;
Received: from [89.212.21.243] (port=42304 helo=localhost.localdomain)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1sFBN9-00CBT8-1Z;
	Thu, 06 Jun 2024 13:33:35 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: upstream@lists.phytec.de
Subject: [PATCH 2/2] OPP: ti: Use devm_pm_opp_set_config_regulators
Date: Thu,  6 Jun 2024 13:33:34 +0200
Message-Id: <20240606113334.396693-2-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240606113334.396693-1-primoz.fiser@norik.com>
References: <20240606113334.396693-1-primoz.fiser@norik.com>
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

Switch to using devm_pm_opp_set_config_regulators() function that
correctly handles return values and doesn't require us to handle
returned tokens.

Fixes: 6baee034cb55 ("OPP: ti: Migrate to dev_pm_opp_set_config_regulators()")
Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 drivers/opp/ti-opp-supply.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/opp/ti-opp-supply.c b/drivers/opp/ti-opp-supply.c
index e3b97cd1fbbf..8a4bcc5fb9dc 100644
--- a/drivers/opp/ti-opp-supply.c
+++ b/drivers/opp/ti-opp-supply.c
@@ -392,7 +392,7 @@ static int ti_opp_supply_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	ret = dev_pm_opp_set_config_regulators(cpu_dev, ti_opp_config_regulators);
+	ret = devm_pm_opp_set_config_regulators(cpu_dev, ti_opp_config_regulators);
 	if (ret < 0)
 		_free_optimized_voltages(dev, &opp_data);
 
-- 
2.25.1


