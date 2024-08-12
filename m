Return-Path: <linux-pm+bounces-12074-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0240194EE63
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 15:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2795A1C21C61
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 13:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21F2183CD8;
	Mon, 12 Aug 2024 13:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JVu+Gb9T"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AB817C7CC
	for <linux-pm@vger.kernel.org>; Mon, 12 Aug 2024 13:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723469669; cv=none; b=dGPL0RmOi7oJaZKP/SK0anurKjHwiNnieGQTkrdyD4TYGkcQR1p3mDpAK9pgQ+tEvi6e8cA01yr/M4VV4zG1/iJztUrHvouIjZc50CJp92b/+M3Teth3yORCaLQkGJS2kPIgc+mdiY6oNSqixo+nqUGelEUNuxs+VXXDkXOu5DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723469669; c=relaxed/simple;
	bh=h5GVRyPEyZM7BuYLl+uIGy5XE4aa3GH8V2JRysNGv/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aTuRotnYjsSftFXiCMY3ZNzlplZLDbDI+bhDDjbIe4lPVwK/kmCzkybyK+Vx6IfCrNpwf5o8DuQIFjLjiXHuLbQGN5B3cBkLOw47aXuWZMY8UDHRg7bv7lDSnGj+KhPsGe9xiGi8yp2b7kASmi8Ll1X951zSjlfUqjaCO0cwSrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JVu+Gb9T; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-428243f928fso43314065e9.0
        for <linux-pm@vger.kernel.org>; Mon, 12 Aug 2024 06:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723469666; x=1724074466; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CxelJ2EbVi7FPWoh5bPyWxBtOLrcrZXgDmweNSFWgLY=;
        b=JVu+Gb9T2YnwV2e7VCdPafQID0NQhXmfyPKZqfwvGLJ14MYIfVbv3GMpnzuSgnlb+T
         OSXzTUictx7oLOMB/ykvp1371oO93jG9a+1GZMI6EkVScfGpnyu3UhEyY9c1a/cpGmfw
         PReoGF4o6uz2pn/P/XLXBaAIYoBzUdMaCzLdHZbX4dddwvuyttPItItgpCV5Iau9dxc8
         TofpPBzHEfZ5BgiSb2K/aDY8lDF3R0GQz8ujyqolTi3JaasWBU3l3L0nA+Uv1JUIXvr/
         M2+hsxmlaCecIeaXBOrzuYlbOAk0aoqFcH9i04TKqxFuPFo1e7VIorSBwYSJVdmtIVVR
         rM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723469666; x=1724074466;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CxelJ2EbVi7FPWoh5bPyWxBtOLrcrZXgDmweNSFWgLY=;
        b=vRlf9aPJR5eemZIl4oH1MLSSYrVJJjEZ1rFwnu8xYR1h2OekpdRtzM9rEKU6JbfS5h
         nvaLVH6t1uTntYPeMOhzPVil0/fEV+ysJM663waxSvs3K6sTdZe+IiXfnd7bQY4keWFm
         vLFzj+n00q42w/dPcq+0ckHQvAP2OAxJ6kcCqRf0/O58lOd1v+++9NdyvKW5wbQuQl3I
         OZc6WqBrmPNEVF2iQOLZI1o8EwuqB+ef24/iM+XNTNU05w5ChNXZ04SAH/16AkT8T5Hk
         +5TOFHLAU6D2joMPpCjhK4aOIZsRDEOZp8Io4kJVNtCIBAGrNJNLy7o0EN81ugEE4K0Q
         1adA==
X-Forwarded-Encrypted: i=1; AJvYcCWau52EobQUp50BeLiwBvxe3/oJiAtg5a3IG/xWomOSoFlhufsGXiUKurOs0dFcgnHPQHjAIoI+IAxo6icCSLNlZPZBvnkWmEY=
X-Gm-Message-State: AOJu0YxG3AlMmbQ7e1xOh5rn04Z6/cNWqStxW9ELsFOlfR7MHc3knIyy
	jZI8Lg1q+Yc7QlH0JLrWdv8HgCFcd8Q/Q89D098W0ugOcQAvYJBWB/5Ga/eOuVM=
X-Google-Smtp-Source: AGHT+IF/xqgp3fX5/73q32JxRWI738lXHcWaaxk8rQf5ZvZitjmwwt4tX7txoPGOt9wBMUleQlFSDw==
X-Received: by 2002:a05:600c:1c82:b0:426:59fe:ac27 with SMTP id 5b1f17b1804b1-429d486efd0mr4284805e9.26.1723469665903;
        Mon, 12 Aug 2024 06:34:25 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c7737c64sm102733975e9.31.2024.08.12.06.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 06:34:25 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 12 Aug 2024 15:33:58 +0200
Subject: [PATCH 4/9] memory: stm32-fmc2-ebi: simplify with scoped for each
 OF child loop
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240812-cleanup-h-of-node-put-memory-v1-4-5065a8f361d2@linaro.org>
References: <20240812-cleanup-h-of-node-put-memory-v1-0-5065a8f361d2@linaro.org>
In-Reply-To: <20240812-cleanup-h-of-node-put-memory-v1-0-5065a8f361d2@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Lukasz Luba <lukasz.luba@arm.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-tegra@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1886;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=h5GVRyPEyZM7BuYLl+uIGy5XE4aa3GH8V2JRysNGv/A=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmug9UQ2G2MLUWfrT/ljckUzPqu+/Ti/gpvU3bj
 vLbozfzG9+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZroPVAAKCRDBN2bmhouD
 1/h1D/9FBIcRGxE/iNnzoy6kaQiSTt/zZow9zS313YkYxSmkqUcdnFL2JyYULkVMPta7hVQ9v9O
 bZJQVD0bif8TRwAQp1cB71a4T1IENrkqzP4iwFZ8087G4vZ9NdHeU9aLruLynBs9/U631XugQ9o
 SFXgY5vliVBY1jbiRMwrIPbvEPecG1O1/TKbCJYd8ZhjkDXln2l1HIVce++fZhyE07IJqPqBnI1
 8sUFAOB8Eme5pmhnTfeYVvoJ56i+shfDHmsBeEdwbG2M/iv38XN2rrE5+q79M5epLsDdyQr5doq
 0fafsJQocAYUgPZVgrdmnBcjhb9zEKgFVsPdEXvdPU1QW4t1RvSS+RzzrLbus/05ljfhwM5Ot0K
 Z6DywmDKh3uT+EdqtuVpHhIs6rcfAKyjHyEPg4r++MXTNRVWw1062emp7mAlljObs/Tqllgiu78
 uP9yE2NcARpF16zI4YXRDne98RDnw4oBeRx5oFD74w1SudLrioM1ouoFicZqJwMjrSAjuhcRb8K
 +dGLLs8fPAVE+GsBu9pu6z++punmdkhJfIqdCX1VCPrYHcYg0aOPPsaA2MgzrD9+gd5o0lRsQY8
 BAQtw11HqnTQwABAZ1MS5FtvJDkJelkJxE9hWQZZskoCPIq6vj45Ab7Ud2anz27txnCtpZ3ZNwe
 CmOBzjUDD19MKwg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use scoped for_each_available_child_of_node_scoped() when iterating over
device nodes to make code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/memory/stm32-fmc2-ebi.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/memory/stm32-fmc2-ebi.c b/drivers/memory/stm32-fmc2-ebi.c
index 1c63eeacd071..7167e1da56d3 100644
--- a/drivers/memory/stm32-fmc2-ebi.c
+++ b/drivers/memory/stm32-fmc2-ebi.c
@@ -1573,29 +1573,25 @@ static int stm32_fmc2_ebi_setup_cs(struct stm32_fmc2_ebi *ebi,
 static int stm32_fmc2_ebi_parse_dt(struct stm32_fmc2_ebi *ebi)
 {
 	struct device *dev = ebi->dev;
-	struct device_node *child;
 	bool child_found = false;
 	u32 bank;
 	int ret;
 
-	for_each_available_child_of_node(dev->of_node, child) {
+	for_each_available_child_of_node_scoped(dev->of_node, child) {
 		ret = of_property_read_u32(child, "reg", &bank);
 		if (ret) {
 			dev_err(dev, "could not retrieve reg property: %d\n",
 				ret);
-			of_node_put(child);
 			return ret;
 		}
 
 		if (bank >= FMC2_MAX_BANKS) {
 			dev_err(dev, "invalid reg value: %d\n", bank);
-			of_node_put(child);
 			return -EINVAL;
 		}
 
 		if (ebi->bank_assigned & BIT(bank)) {
 			dev_err(dev, "bank already assigned: %d\n", bank);
-			of_node_put(child);
 			return -EINVAL;
 		}
 
@@ -1603,7 +1599,6 @@ static int stm32_fmc2_ebi_parse_dt(struct stm32_fmc2_ebi *ebi)
 			ret = ebi->data->check_rif(ebi, bank + 1);
 			if (ret) {
 				dev_err(dev, "bank access failed: %d\n", bank);
-				of_node_put(child);
 				return ret;
 			}
 		}
@@ -1613,7 +1608,6 @@ static int stm32_fmc2_ebi_parse_dt(struct stm32_fmc2_ebi *ebi)
 			if (ret) {
 				dev_err(dev, "setup chip select %d failed: %d\n",
 					bank, ret);
-				of_node_put(child);
 				return ret;
 			}
 		}

-- 
2.43.0


