Return-Path: <linux-pm+bounces-34909-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 516F0B81394
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 19:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 146C41C807D9
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 17:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1462FFDE0;
	Wed, 17 Sep 2025 17:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="lmGhiiIt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B9D2FF16B;
	Wed, 17 Sep 2025 17:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758131321; cv=none; b=Eylruk6XsmWkbRDYViArxFPDwb4lA/Zc625bAbz4SNYzLarjpZVqLU9SFLg8VbNOXkmTIFKubRK46qvzsNLjbExtA83KlWuxM2o1x0+TBcEjNvNxljJZP4YQGdwEpY+rp5WGFdXVcpfcRICtqnjuhVXAwlxEltpqocfFxVGLFNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758131321; c=relaxed/simple;
	bh=/tS5VN8wqJ0W6f79Uht7zyfEMcAvhg6Jn1SC8qgkuXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UFpZ2JqLqU1v9ExRR9RwJbtgSBNsT9lY2u7i6JTURZPwl2XH/YdsuHO/pKWqIhvgQjouLqABEuC+MBg7ySk9hb6g72l6Iq91nm7CT3FErQC9ivqIy8T+6WM/IeER9epih7v9suy9ekVwFiFKmvdN/YRujAjh7EmPfNgUvqxxF/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=lmGhiiIt; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:In-Reply-To:References:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=3q5kiib1kd62l3L+MK1D9QnKWb3L2UjvT/k4OiP6KHs=; b=lmGhiiItEIEn4oHqn9ygwJ2xTy
	p3yRTkwf/diZ/RkOkOFIij3iPe7/Is1o2vW3k3imaDonJYd0Bn36PUoIb/DpRbfN9jP2JdJTDG4TE
	umakduLqcB7QFk7k6idX3t8/GFVrJ2nPeQYWD0xFCyBO+94uMEkUFqPSZ4Sa2mrOWBiZYptxEBrhZ
	9RFucdZT1SmlQwT4eqxuesEr6dpQ1QA/0Y63APO36ZDkyYwMFaOLE92u1id0BGfr7gxai7fKBp6W+
	EtujfNVwHJbyWqL7H3dHq/6GcRmfuJEN1FNoArCuCdiRad9Co8/QIfbnYlbCSftt1qhs1tSYR5KyI
	wSPrSAkw==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Wed, 17 Sep 2025 19:48:04 +0200
Subject: [PATCH v4 3/3] MAINTAINERS: Add entry for BD71828 charger
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-bd71828-charger-v4-3-fbc85a910499@kemnade.info>
References: <20250917-bd71828-charger-v4-0-fbc85a910499@kemnade.info>
In-Reply-To: <20250917-bd71828-charger-v4-0-fbc85a910499@kemnade.info>
To: Matti Vaittinen <mazziesaccount@gmail.com>, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Andreas Kemnade <andreas@kemnade.info>
X-Mailer: b4 0.15-dev-50721
X-Developer-Signature: v=1; a=openpgp-sha256; l=782; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=/tS5VN8wqJ0W6f79Uht7zyfEMcAvhg6Jn1SC8qgkuXk=;
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDBmnvmRJ2/T7mJxfkTn/YuAv0ZbG29mHNK7fdt9aJj+za
 kboMhGNjlIWBjEuBlkxRZZf1gpun1Se5QZPjbCHmcPKBDKEgYtTACaS3crwV7p+qd3qBbdqBT9a
 /Tq38av1Bu2ivcciGjgjBWTfOe09KsPwT/EOm7HHDf7DJZ12n0u/hu157XZQWjQ77sqGUDFVa31
 RHgA=
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

Add an entry for BD71828 charger driver.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Suggested-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
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
2.47.3


