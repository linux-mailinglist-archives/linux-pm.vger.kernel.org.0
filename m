Return-Path: <linux-pm+bounces-10691-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 834AF9287F9
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 13:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DFA8284BBC
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 11:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B56149C61;
	Fri,  5 Jul 2024 11:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r+xCSguV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0A1146D45
	for <linux-pm@vger.kernel.org>; Fri,  5 Jul 2024 11:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720179081; cv=none; b=CmmrvBXnFCD8yAWZwJpT7z3/h2BTZy8xEJ/H+fyd1HXjQ8/f5gzwcl70EH3uJD3Fh0hURhMTA9mdHAZ5MPkiePgK2alpOmSS4lWunYzUOUCHPVKx5hQPh/E2VWVqOnjJHLDMPlyrUTe7AYRfA/N01CVgmdEGafFz4Ik/PIU0OzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720179081; c=relaxed/simple;
	bh=FuBrajrqQG9XnSm84KCc44rCbv9kqxWntaHnPCAb3kM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O3AItOQkc9Kl5z6vHcuqzqHGmRWNNj61S/aTRXjK6R3/8xzNFQcHFIKXOJPeWkg9Xm/CZzRCyumYpc8X61rIbxBMpCDgERUd0iRnv1hnevoBkJtirF6k2/DZL5jjJfxqXoxFlu3FfL1M+7srSL9UW7ME5yQ87m4GERnJ6UieMnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r+xCSguV; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52ea0f18500so1436448e87.3
        for <linux-pm@vger.kernel.org>; Fri, 05 Jul 2024 04:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720179077; x=1720783877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4KHOTg83zzFfVGaUl4+JK0iTPEEAglfxmKaKcO2W6Q4=;
        b=r+xCSguVCV9dCT51vF37tpB8ekHlxtxdDfutNgl5qA3jl5awWr/F0WtF8X61BWRK5d
         pT84FPJxm9P8N184EtaFf//X87vwUQnr2LKsc2UZ5dUAjOuNsUgS2uDv78FFOzDa0sVq
         MayojkLmM41ptVoBOm/0prmuK2st5Oh74BhxvsS8z3UaTdVwrn6oE7fncbd5UV8fyzak
         z2igfyo1zA/Qc3WyfIfAQSl+E4TDamo1NxPmZQlKeSOFbVA5wr1c5p9XMqloN4f90J3D
         NnuRRz0019rrXuz5bsExzVkS4UVv5RbZ1K6H2DmU1B1o2h1nAFVOlG8b0QfU3u3CkT3X
         QcFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720179077; x=1720783877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4KHOTg83zzFfVGaUl4+JK0iTPEEAglfxmKaKcO2W6Q4=;
        b=CPkYViAUrIAWSV/KFEY1e5z/ftw6yE8C99NL/YzYdoMteRUSodTTAaQg/L7zf/sGOd
         e0XHukE4gOOB9vzLPXh5rqyA0jpVoqxmCNxkuWDqJG+SSFJf/Ru9tVDTSj6uRebJNAid
         IN1bwu6EDT1DIwTrQwQ7DSKaSXAWxrSIW0hMpp7ym+i0UhiWf9M/+35bapWPGy1Vdlno
         tMOXXuRq2UuFq6gZ13UtxjoJU1IUI+h2wUIwyn47H8IDpcGDiS1Ub5iCM6Xb3VN6E6kw
         XuKmXNQxHBRCt0BzIWNhRKF79YmHk+gK0NTylFlV7EVQLKT77/v6avAD5AS7ohJ7DR0A
         HQEg==
X-Forwarded-Encrypted: i=1; AJvYcCUaTtylOF3l1U60NEOOmh/usYWloVRJ5G0LNf9iUbj6kGIR8+rnKe5W4JRmSgMtP1obe07n3kHG3xXYonIJkbE7uZbD9qLwxAE=
X-Gm-Message-State: AOJu0Yzwkhx2qBmiJsyFYKJURjx2uvcy49FvzEtA0Sn1J9rohtjomm0Y
	OemmcGpwx51xldc7H3Ci03U7f+TC255W4kWfwv9LHK1ysew8lakptWY0eZpb2R4=
X-Google-Smtp-Source: AGHT+IHu8JpvSRGOprQzL81TsvGKBnMmQCKqCq82+aGtEZ11VImpyhljjvm/eD9bz0xqu6/70v7QyQ==
X-Received: by 2002:a19:ac45:0:b0:52d:b1c9:34e with SMTP id 2adb3069b0e04-52ea062e361mr2952258e87.21.1720179077159;
        Fri, 05 Jul 2024 04:31:17 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2fc942sm58090725e9.42.2024.07.05.04.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 04:31:16 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Sebastian Reichel <sre@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] power: supply: core: simplify with cleanup.h
Date: Fri,  5 Jul 2024 13:31:12 +0200
Message-ID: <20240705113113.42851-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allocate the memory with scoped/cleanup.h to reduce error handling and
make the code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/power/supply/power_supply_core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 8f6025acd10a..2b845ac51157 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -9,6 +9,7 @@
  *  Modified: 2004, Oct     Szabolcs Gyurko
  */
 
+#include <linux/cleanup.h>
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/init.h>
@@ -756,10 +757,10 @@ int power_supply_get_battery_info(struct power_supply *psy,
 
 	for (index = 0; index < len; index++) {
 		struct power_supply_battery_ocv_table *table;
-		char *propname;
 		int i, tab_len, size;
 
-		propname = kasprintf(GFP_KERNEL, "ocv-capacity-table-%d", index);
+		char *propname __free(kfree) = kasprintf(GFP_KERNEL, "ocv-capacity-table-%d",
+							 index);
 		if (!propname) {
 			power_supply_put_battery_info(psy, info);
 			err = -ENOMEM;
@@ -768,13 +769,11 @@ int power_supply_get_battery_info(struct power_supply *psy,
 		list = of_get_property(battery_np, propname, &size);
 		if (!list || !size) {
 			dev_err(&psy->dev, "failed to get %s\n", propname);
-			kfree(propname);
 			power_supply_put_battery_info(psy, info);
 			err = -EINVAL;
 			goto out_put_node;
 		}
 
-		kfree(propname);
 		tab_len = size / (2 * sizeof(__be32));
 		info->ocv_table_size[index] = tab_len;
 
-- 
2.43.0


