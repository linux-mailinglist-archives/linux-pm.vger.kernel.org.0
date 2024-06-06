Return-Path: <linux-pm+bounces-8705-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB558FE568
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 13:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 988C81C21EF4
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 11:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F901922CA;
	Thu,  6 Jun 2024 11:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="HNyvsU5o"
X-Original-To: linux-pm@vger.kernel.org
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720C33CF73;
	Thu,  6 Jun 2024 11:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717673619; cv=none; b=MukByMzLeKY5Ff0Mlcp4x6H0HMUW/ZDxIG7JcWPQudLyWWARZ2Itk6WATP/j2APKtnbYAdyTvU8XQHXOHY6rltMYPYqhX8G7T/6s2prm8FQnZMKJ2vszZECTkBpCFh+acNcOnk191PolpZZbRezSX+PTqmiMTWlubcXG6G9vIKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717673619; c=relaxed/simple;
	bh=15XVAauSQDzKB2ZTPCdoFtU+mdQmJ+2xIpBb5ozGdsw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aOe5YKblnTFyxxORSUX8nkXiw1cCSIkmGL8DvtsfQanFVrH1JyRLsfKGRJv2J/dQ+tvl2242OrjNCHEPgp9se+pD/L+8SHDa3TFT69D6LP5sCcrqqax71yCBw2Oaz663l9lhH+xItAHa74hEIdTqrs+7mEsFTY1yQujpmrQ3pVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=HNyvsU5o; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=OH86+RYooL/TwkaVFeh6+rlcLoll+q8Cw6gljIVddnM=; b=HNyvsU5oxnqEPYee8wJqKUD+5/
	v9OUHjvkaB9VE2kpJgpYcIOGuYXeC97EfzWiF+Xm4FeFaZwxG2I7FC3TeJgYkJqw9nkXOXjiZwnpw
	L3NDNA9l501pVSDjioE1NlRax3UB3E+8Qtw0b4mh1Q9Ex2BoLqrijQUvmtxTTHDmPthM2XZcarFBI
	yoSIpYS6x6RUQhDlngIM6nRH0BxUzndOymsHEv1qOaa5a8MrPLJyDOggDZlmDc313R4qOjTX1O7CV
	7qJ7TiuN471TwxF5v3hvuK5zKzdM2Swrmgd13WYZOgFvjXvt4faEl+4DdirSqV7WiCiVsP08FabhO
	tP+MJmEA==;
Received: from [89.212.21.243] (port=42304 helo=localhost.localdomain)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1sFBN9-00CBT8-1N;
	Thu, 06 Jun 2024 13:33:35 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: upstream@lists.phytec.de
Subject: [PATCH 1/2] OPP: Introduce devm_pm_opp_set_config_regulators
Date: Thu,  6 Jun 2024 13:33:33 +0200
Message-Id: <20240606113334.396693-1-primoz.fiser@norik.com>
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

Introduce devm_pm_opp_set_config_regulators() function. This is device
managed version of dev_pm_opp_set_config_regulators so caller don't need
to worry about managing returned tokens.

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 include/linux/pm_opp.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index dd7c8441af42..fa515aab47c9 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -664,6 +664,16 @@ static inline int dev_pm_opp_set_config_regulators(struct device *dev,
 	return dev_pm_opp_set_config(dev, &config);
 }
 
+static inline int devm_pm_opp_set_config_regulators(struct device *dev,
+						   config_regulators_t helper)
+{
+	struct dev_pm_opp_config config = {
+		.config_regulators = helper,
+	};
+
+	return devm_pm_opp_set_config(dev, &config);
+}
+
 static inline void dev_pm_opp_put_config_regulators(int token)
 {
 	dev_pm_opp_clear_config(token);
-- 
2.25.1


