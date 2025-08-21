Return-Path: <linux-pm+bounces-32831-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4D3B301FB
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 20:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FF12AE068D
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 18:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8963834DCF2;
	Thu, 21 Aug 2025 18:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="jexVNv3A"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D2F34DCE9;
	Thu, 21 Aug 2025 18:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755800650; cv=none; b=H6JvPX/FFsdPgGzWkAbOcsV1Wtam0SaR2k9o41F7G5DLuzBAtdgL1LZ9HVNbE8NpVeZ19aEmXSIWA1HHQ3WcpNye4sdgLbQ8NeMnfJxPI+RSuccXbDSyiT4ly2JGGjUtmQ/NAqbBEkA0SfybcWHkTfurs0uvnzxA54P6cMRqh/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755800650; c=relaxed/simple;
	bh=ix8UZC+EqZXL4QNGiPcRXqoiT3yqqPD+8DafDO2neXo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CV4NAwL2/E8gcpTUMVZ5serSEzQcTBgMau93zS42cPtJiNXRdu2dglzrPDjL6kRScBD0Sa0BasHYuvYR9Iy33UYpaHD/8NblSLvBQoQMdCkk8Kc28+q47k/vQmuo+6VBEFu6uq5V71J/YuN+AHW0udJnZFIRhtXCaaZYC7ApdHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=jexVNv3A; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:In-Reply-To:References:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=NNDoMJVpUDTsPfeJbaKGe9uW+T8LaeB/vq7nDS90alM=; b=jexVNv3AzizNqRxTJeDLrBJj2g
	rVs8Bsh6AHMggD0eOli3aMa1ZP1uKtEY1POzmvv4V0vsglc2aoCKWhDlLT4oYFAieqQmp8s/dinJ/
	FXNO1iyKJ2JQ795oxv/q2b1ZlKpCzYWRPUHw6V6PNfcrcyHlsbAkmQastsEBtiHzI8s1vJrDTUZ1a
	UR1YS0qH8vxehWvlGzcS+4ednMNbY2xhXJAQv6buaSBkixeEOjp0akaneeZIDI0gHLfPEyD+S4f8E
	XClnV+v6P2mzT+RRF+yepS3OCnQ9PxGcuI2l93ZIgkMQGIWxCmh7KOw/WnFZIT1k8r+K0kKwkBDRP
	AnsaAkxQ==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Thu, 21 Aug 2025 20:23:36 +0200
Subject: [PATCH v3 3/3] MAINTAINERS: Add entry for BD71828 charger
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-bd71828-charger-v3-3-cc74ac4e0fb9@kemnade.info>
References: <20250821-bd71828-charger-v3-0-cc74ac4e0fb9@kemnade.info>
In-Reply-To: <20250821-bd71828-charger-v3-0-cc74ac4e0fb9@kemnade.info>
To: Matti Vaittinen <mazziesaccount@gmail.com>, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Andreas Kemnade <andreas@kemnade.info>
X-Mailer: b4 0.15-dev-87983
X-Developer-Signature: v=1; a=openpgp-sha256; l=725; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=ix8UZC+EqZXL4QNGiPcRXqoiT3yqqPD+8DafDO2neXo=;
 b=owGbwMvMwCEm/rzkS6lq2x3G02pJDBnLU+zrXcStJl7g5nq9RuuCmcpny7abe080eQtUiS3gE
 eIMZK7oKGVhEONgkBVTZPllreD2SeVZbvDUCHuYOaxMIEMYuDgFYCLPlzL8FW+3yOq6+E+30Fhv
 lQXvIk6x4I47Xf2zzOS8X9cvEtGRYWR4kBB9tMnkRdCTkPXaPrXhBdtcGKK+3+UWquIqnqwQFsk
 OAA==
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

Add an entry for BD71828 charger driver.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Suggested-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa45..044eb41ba4797 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21848,6 +21848,12 @@ L:	linux-serial@vger.kernel.org
 S:	Odd Fixes
 F:	drivers/tty/serial/rp2.*
 
+ROHM BD71828 CHARGER
+M:	Andreas Kemnade <andreas@kemnade.info>
+M:	Matti Vaittinen <mazziesaccount@gmail.com>
+S:	Maintained
+F:	drivers/power/supply/bd71828-charger.c
+
 ROHM BD79703 DAC
 M:	Matti Vaittinen <mazziesaccount@gmail.com>
 S:	Supported

-- 
2.39.5


