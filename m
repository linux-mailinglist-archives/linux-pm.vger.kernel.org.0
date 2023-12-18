Return-Path: <linux-pm+bounces-1286-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED678170AF
	for <lists+linux-pm@lfdr.de>; Mon, 18 Dec 2023 14:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C3D8282D52
	for <lists+linux-pm@lfdr.de>; Mon, 18 Dec 2023 13:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7111D127;
	Mon, 18 Dec 2023 13:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YquedR+o"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8F41D159
	for <linux-pm@vger.kernel.org>; Mon, 18 Dec 2023 13:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40c69403b3eso29263675e9.3
        for <linux-pm@vger.kernel.org>; Mon, 18 Dec 2023 05:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702906965; x=1703511765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xyEG4+5CWlynpKgbnqEksNZUKPX7fzBsT3XPQGSore8=;
        b=YquedR+oCDpFK2QO1vifa6qmqchNGSs6FM34pFufOPCCqjZ5n3nXHrH2UQsgQqUI7Y
         Jn2gjr6+Fy1MZRnrUmICAAZdQ3lWF4szuqHFGY4OVCLErUoexf1NzhCCZaxuQTRhxwq3
         PMer1zr6X/hjNDi26Z3AWlz2A450Lv+8U0IqjN63zW0n7rGFjatz8M/ZxohqvgHqOs8n
         YNnZNrQ88N3kzMTn3BPwRgiuZaqq6SSguX+jMi9FbY7MI/V+da0Ku4ZcKMKA8E3Vussi
         DJXvX8vGldWHg7uwHEzXOLRmirBDXvm0oye+QPbQrO2q43DoeGETTad/O7Qnp/EmRFQP
         VCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702906965; x=1703511765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xyEG4+5CWlynpKgbnqEksNZUKPX7fzBsT3XPQGSore8=;
        b=GpY/QojRM8EWXZTx60GRMqYLfKK3vOKUF9FDcJv19TgMeAmUnr4Tr21YxG/L77Mrig
         DYd+Qh5MvrVa48+RwIm4sKNOKTgbzr0W3+j70JgcH1nbC0r5nk+dX31IYqU1Wd1a/oxR
         t9MKo1t8Wa0Wp5Rizgkw8w/lK4uk6rc5QARquxpp4tgD/qcOwazKthx2x+DMjdXXhWYf
         hjbO4FbYhHPO+0ao2XbcusQ8F3r+d6/FKIrOLGmmOz3hUlqcpUz5Jx140TRlbHZYXNTh
         iDlIS7oW315A4QwDkw5Cp4tP9Uw4m9CU8UKhSroXyvhVcU/H9//wROC6mFxzmIXhvAfQ
         Lt8Q==
X-Gm-Message-State: AOJu0Yz3MJchcs9q1H5GA+DzaTDvaSHFhfaPbKTTewFiMPMggsYNl3AF
	9yq5NCouK+gLbUHVLxOd/mg75N90SPGl3syX9XBqCg==
X-Google-Smtp-Source: AGHT+IFEsHmQvoI+lwVFUNs2ikaUGdgRgCy7+Zn0cnWHJ6oZBH16pyO7uuiglM/OBqgJBBq7eFjBgg==
X-Received: by 2002:a7b:cd12:0:b0:40c:33aa:4ef5 with SMTP id f18-20020a7bcd12000000b0040c33aa4ef5mr8025674wmj.91.1702906964902;
        Mon, 18 Dec 2023 05:42:44 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id h7-20020a170906530700b00a1b32663d7csm14242327ejo.102.2023.12.18.05.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 05:42:44 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] power: supply: drop maintainer-less BQ27XXX
Date: Mon, 18 Dec 2023 14:42:41 +0100
Message-Id: <20231218134241.50284-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BQ27XXX charger driver does not have maintainers nor status:

  ./MAINTAINERS:21808: warning: section without status 	TI BQ27XXX POWER SUPPLY DRIVER

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 MAINTAINERS | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cdf1575dc851..28b98fc4637c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21763,11 +21763,6 @@ L:	linux-omap@vger.kernel.org
 S:	Maintained
 F:	drivers/thermal/ti-soc-thermal/
 
-TI BQ27XXX POWER SUPPLY DRIVER
-F:	drivers/power/supply/bq27xxx_battery.c
-F:	drivers/power/supply/bq27xxx_battery_i2c.c
-F:	include/linux/power/bq27xxx_battery.h
-
 TI CDCE706 CLOCK DRIVER
 M:	Max Filippov <jcmvbkbc@gmail.com>
 S:	Maintained
-- 
2.34.1


