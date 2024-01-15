Return-Path: <linux-pm+bounces-2207-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CC682DC63
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jan 2024 16:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95E9B283CE1
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jan 2024 15:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62F917740;
	Mon, 15 Jan 2024 15:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hhucPRlf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D98A17980
	for <linux-pm@vger.kernel.org>; Mon, 15 Jan 2024 15:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55817a12ad8so6620104a12.2
        for <linux-pm@vger.kernel.org>; Mon, 15 Jan 2024 07:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705332869; x=1705937669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rmavEwniKj+GORH2KWsSxI48O1fqG3CA/6A3JkOsRZ4=;
        b=hhucPRlfCXgeN6cS7vjMBCEO3Nqpcpwi2qvTRRHXo34AxIxcSfDI2qqRSt6UZkiQkd
         nRWGr+fVvfSdwX3XHVmShmOJsLVmt6E4Ivy4JEUUfzq9LBgjcY+wA/bmLH7Vr7BVZFXz
         iWXSbF7uW7Fnl1fXt0eBMdQuykgo5O/fKDPn/2l4JCWuepp3klmCjC6E9SOlrfI7c6R9
         kvfrvUEcra5N2pZO3vD4SwlrK/MGtw4veZpez0vnlpW2J1oWewPVAIFg16oFZrm2wB2N
         gJEWdWVFNzQ7qq5Y3tTvVG3srdEcre8pZf/W5DvGGpp0cEQXzMsqK/VWDyvUx2ZtCZaE
         /ClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705332869; x=1705937669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rmavEwniKj+GORH2KWsSxI48O1fqG3CA/6A3JkOsRZ4=;
        b=cnhowJUZDq2g0jiWzIVO5whE42jdl27tvFHmeaoKNkZqSiu3NgEg34txHF/NDPdhQV
         iL5xp1qFWGWSDDnS6ATyru6aWH48S/IvEAt7ix5apVtw3V2OkeTjslYnXsDJfV1qOVD5
         p+fbX77jIq2ELQC2uLJtsO6WuTG66GDZSDiTVpk4iZ1O17u4tVgBkMlNKvNy4018jlhg
         bP/jcovaYYYp3bKhpFVfIuK10XF0RKgFkpmUlu0+06vT15OhLpzD96fDplJ4+TJIx/it
         ARuHd+dqyNsqAqv3Fv/3YJz+3FT6y6mGV92i+gl2Eh2KBGVwrHum7ssq+BMzXmKLKgne
         aCBA==
X-Gm-Message-State: AOJu0YyrQyUuKDXc7cxO0RdnpHlq5S2WODI1fy5b3o9seg2Es+h3rKI/
	H8wI5QBeLh4AiS4EiFUYxKvZ0ikUvmTeqk7iR91kR8+MkyU=
X-Google-Smtp-Source: AGHT+IEwU+HMP2ZxSul0UPiJaIrNclergG4x8eorh9X4vewB9SAVKg5i/Pw4/KLbpnvd4dGFIgmcNA==
X-Received: by 2002:a05:6402:31e4:b0:559:3aef:235a with SMTP id dy4-20020a05640231e400b005593aef235amr997796edb.13.1705332869499;
        Mon, 15 Jan 2024 07:34:29 -0800 (PST)
Received: from krzk-bin.. ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id j20-20020aa7c0d4000000b005576f4471besm5578604edp.42.2024.01.15.07.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 07:34:28 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Georgi Djakov <djakov@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH] interconnect: qcom: sm8450: Revert "interconnect: qcom: sm8450: Enable sync_state"
Date: Mon, 15 Jan 2024 16:34:20 +0100
Message-Id: <20240115153420.1525037-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Revert commit 16862f1b2110 ("interconnect: qcom: sm8450: Enable
sync_state"), because it causes serial console to corrupt, later freeze
and become either entirely corrupted or only print without accepting any
input.

Cc: <stable@vger.kernel.org>
Fixes: 16862f1b2110 ("interconnect: qcom: sm8450: Enable sync_state")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/interconnect/qcom/sm8450.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/interconnect/qcom/sm8450.c b/drivers/interconnect/qcom/sm8450.c
index b3cd0087377c..952017940b02 100644
--- a/drivers/interconnect/qcom/sm8450.c
+++ b/drivers/interconnect/qcom/sm8450.c
@@ -1888,7 +1888,6 @@ static struct platform_driver qnoc_driver = {
 	.driver = {
 		.name = "qnoc-sm8450",
 		.of_match_table = qnoc_of_match,
-		.sync_state = icc_sync_state,
 	},
 };
 
-- 
2.34.1


