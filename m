Return-Path: <linux-pm+bounces-18968-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCD79EBC51
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 22:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8FE3188AFBF
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 21:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAC623FA00;
	Tue, 10 Dec 2024 21:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="IcrmSo9U"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BCC23EA7E;
	Tue, 10 Dec 2024 21:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733867769; cv=none; b=K7R/B42jOidWpoKwvoYUplY7xWHLYD2yf+qNZWpvOjeSKwWYAi7Pu6tJVjDHCi1nHBDWefZ8uo5OqmXClfTJmVS4xODxuUBI2zuE4GVSDHcxDrbvrrjfKztA4NHl2c154sjXcRwTHhMaR61yXLiLMtefDCSJ2S8shgDSQXTfx6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733867769; c=relaxed/simple;
	bh=4MUBctpjIhutpInrWEdlcQerzbKY4rDQAhCW3psko/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MtJyKGpwVtBid55KiPWDwGsiPRJEtEGEUxWHKTxINQZeRDzT/7IhtZ49jrbf6uJDb7lEkGh+bDxsBJrBmwXB39cXBcC4ya9i7X4xeYu5ZCZ8e1XcIzcl24GwGRsTQ+Gtkm83W3EbrDis91dSORxPFKbZoEW5JpLUFmErQsJBxxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=IcrmSo9U; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733867761;
	bh=4MUBctpjIhutpInrWEdlcQerzbKY4rDQAhCW3psko/c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IcrmSo9UNBGk9iYn8mfde+g+K4Tg8npl1k/CRl7jKCF4J0ZkBWNeoAOeuK+NXhmvN
	 1a051wLHTGKQEpyxV+JalzMkZ1eh0vo4x6AVkSctoHn8WAmbcpZqyL4an5zWXdqy3v
	 enXQt+4LQFOP4j0qAlfpdq3xpWjwXagtTzkZJlGI=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 10 Dec 2024 22:55:54 +0100
Subject: [PATCH v2 07/14] power: supply: core: introduce dev_to_psy()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241210-power-supply-dev_to_psy-v2-7-9d8c9d24cfe4@weissschuh.net>
References: <20241210-power-supply-dev_to_psy-v2-0-9d8c9d24cfe4@weissschuh.net>
In-Reply-To: <20241210-power-supply-dev_to_psy-v2-0-9d8c9d24cfe4@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Maximilian Luz <luzmaximilian@gmail.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733867760; l=1136;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=4MUBctpjIhutpInrWEdlcQerzbKY4rDQAhCW3psko/c=;
 b=N/2OqxZVZYHGQL66BMBWZwHwhX2oXMBM2yVsb38ObNuLma5xDe6KRpC+vNYxFFQSKWd7UDdC1
 QphBTIRut2NArgnn2e0adBAsJ0nVC85FR0qkfwI8IazLt7QZcFIxQC4
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The psy core and drivers currently use dev_get_drvdata() to go from a
'struct device' to its 'struct power_supply'.
This is not typesafe and or documented.

Introduce a new helper to make this pattern explicit.
Instead of using dev_get_drvdata(), use container_of_const() which
also preserves the constness.
Furthermore 'dev' does need to be dereferenced anymore and at some point
the drvdata could be reused for something else.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/power_supply.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 3d67f4a6a1c934f387adde12fc96a63a99299923..17fc383785bf5705ef3dbe5fdebf90843684b715 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -318,6 +318,8 @@ struct power_supply {
 #endif
 };
 
+#define dev_to_psy(__dev)	container_of_const(__dev, struct power_supply, dev)
+
 /*
  * This is recommended structure to specify static power supply parameters.
  * Generic one, parametrizable for different power supplies. Power supply

-- 
2.47.1


