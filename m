Return-Path: <linux-pm+bounces-1180-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BA1813992
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 19:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43140283003
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 18:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFD467E9B;
	Thu, 14 Dec 2023 18:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lEKAGWxt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5DA10F
	for <linux-pm@vger.kernel.org>; Thu, 14 Dec 2023 10:13:48 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50bf2d9b3fdso11435591e87.3
        for <linux-pm@vger.kernel.org>; Thu, 14 Dec 2023 10:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702577626; x=1703182426; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tuFQiYL7mCE3oHKRLdSCc7s+Ncls7kZmn2fblqIRkx8=;
        b=lEKAGWxttiG8opPmSYECmRkCasDywhDUbwhDnWQ5h/gtYb2cE9tth947CEERZ/EM6e
         RfH7IoEvs/3Labqb0pZSDVKN222/fs1cxNtUot9gs30OZ91nBp7AOGzH4oAh/H4+SHGH
         TpRTgWZIpnurrGaiF2cRvZIm3QDsILpOB73WVS7TZBj0EtMC//thFcjlO11qKVAGOTmw
         omcsNHcrhruSBWmRKGP1c0iW9M0VLGlIZb4QZ0bfsEp6OyR6GuVE/jrPO6pv/jDHaGnX
         L5l+0Znob8a8KJDNrCl9bqS6acQBSGTd3/7ekyi6DC3+8Hm0FW1fvPzEp9MgH1v1Ee4x
         gygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702577626; x=1703182426;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tuFQiYL7mCE3oHKRLdSCc7s+Ncls7kZmn2fblqIRkx8=;
        b=SVcAZ/3dm1JLiHM7wop64Ef0TvmaY9JRXi1/sJS9cu1FORJ065ODn9NJ+AeGnJunjB
         ubWEXcn0ElI6SCHPaWqiRBvIBja5JhQKBu98NrpTLo98KVOJKV63NDYfel/d9dMY16Pv
         rQG6jhH5dMNNdB6boYwk2WQT00Wdn6CggcvYElqA8Lq893Rzf+LEC7TusEgTN0w/DsPl
         h8TubxYX4OKO5m3lusNMf5kCOF/XdZmXvUEASwN1RIdpiQ272DFqMTMRRCnZDrV92eYg
         vqEHeR6h+nRBPBNQHfvRHrvoQuKCj3cdqEgHvNSogZEJ9k+wG3De94OlO0CrgJ/rroNC
         BBqA==
X-Gm-Message-State: AOJu0Yw+7Mcrl3DW7rJvvsUO4TFrNf2T6TPSaT7BYAueNEAjZ0BVONo2
	mZZ+/dnbeBkngFhfEvaFMoX0AQ==
X-Google-Smtp-Source: AGHT+IHgvuEzeQl5Y//pNTWvJizo/K4IYlbci5jNuAt/NSrN6gr53RX9i01j4tZOo06pQX29pJn91w==
X-Received: by 2002:ac2:44ba:0:b0:50e:15df:5462 with SMTP id c26-20020ac244ba000000b0050e15df5462mr944396lfm.94.1702577626399;
        Thu, 14 Dec 2023 10:13:46 -0800 (PST)
Received: from [127.0.1.1] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id n11-20020a0565120acb00b0050be6038170sm1928838lfu.48.2023.12.14.10.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 10:13:46 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/6] SC8180X fixes
Date: Thu, 14 Dec 2023 19:13:37 +0100
Message-Id: <20231214-topic-sc8180_fixes-v1-0-421904863006@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANFFe2UC/x3LQQqAIBBA0avErBMcNZKuEhFhU80mxYkIpLsnL
 R+fX0AoMwkMTYFMNwvHswLbBsKxnDspXqvBaGPRoFNXTByUBI9ezxs/JKr3rl9Q+9V2BuqYMv2
 hfuP0vh8kepQFZAAAAA==
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Georgi Djakov <djakov@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Maximilian Luz <luzmaximilian@gmail.com>, 
 Gustave Monce <gustave.monce@outlook.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.13-dev-0438c
X-Spam-Level: *

8180 has quite a big of bugs, this series fixes some of them.
clk_ignore_unused & d_ignore_unused are no longer necessary (at least
as far as I could test, through remote console access..)

p1 for Georgi, rest for qcom

The keen-eyed among you (hi Krzysztof) will notice that there are no
bindings updates, mostly because half of 8180x is undocumented.. I
intend to help fix that up in a separate series, hopefully soon :)

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (6):
      interconnect: qcom: sc8180x: Mark CO0 BCM keepalive
      arm64: dts: qcom: sc8180x: Add UFS GDSC
      arm64: dts: qcom: sc8180x: Add missing MDP clocks
      arm64: dts: qcom: sc8180x: Add interconnects to UFS
      arm64: dts: qcom: sc8180x: Describe the GIC redistributor
      arm64: dts: qcom: sc8180x-primus: Allow UFS regulators load/mode setting

 arch/arm64/boot/dts/qcom/sc8180x-primus.dts |  6 ++++++
 arch/arm64/boot/dts/qcom/sc8180x.dtsi       | 19 +++++++++++++++++--
 drivers/interconnect/qcom/sc8180x.c         |  1 +
 3 files changed, 24 insertions(+), 2 deletions(-)
---
base-commit: 11651f8cb2e88372d4ed523d909514dc9a613ea3
change-id: 20231214-topic-sc8180_fixes-7847a108d352

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


