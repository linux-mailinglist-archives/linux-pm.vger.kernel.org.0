Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E64712F15
	for <lists+linux-pm@lfdr.de>; Fri, 26 May 2023 23:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243572AbjEZVol (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 May 2023 17:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjEZVok (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 May 2023 17:44:40 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7608CE62
        for <linux-pm@vger.kernel.org>; Fri, 26 May 2023 14:44:17 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-30957dd7640so728090f8f.3
        for <linux-pm@vger.kernel.org>; Fri, 26 May 2023 14:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685137456; x=1687729456;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UYFopvK0TbM2VEpCPpkGXSYwRCmtfEBkrHRwu/VEJOc=;
        b=F/kZ01mNxkvFZgeTbJjlskpUIhbm68Rlr9vZiScRbRrplQHX8VbIoQbljdyzomnydh
         1jbP7FZAQhNRaaVSoydeBoH9UMCGAwsWbKdKFPRrbPmav4/G4IHL+jdmGpox/2gT0MJJ
         AbTyP6RZhh0I9GHymf7QI77rMQsLM9AO0vlh4hrbZ91rhH6iV/rkQyA1LGkyrmwmLc9W
         +845mvxzQ67iQXl7herPj3SdoK+10g1dHk7Y2fepYDPJENzizvaPwU6Cy5iozx9hLyWr
         XPDiqWAxc4ssZ+q7URsLLRpSNy83CziEydqZerf0aAcinxArUrfCVnsrY8uq+RcjY/zz
         4o8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685137456; x=1687729456;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UYFopvK0TbM2VEpCPpkGXSYwRCmtfEBkrHRwu/VEJOc=;
        b=G6z8QhyhwdXBoxOPvrXBGhBQsgEEyHV2HBtwXdqdJp7sqcQjU0aietj/3eP/AkPLxM
         qu2euEZTKf1VgVn2pvhXvaAaFNrniZqlbNnzbZdmZ4eZkNXa35+4dl29pedxSyvj1//x
         qCnBwd+1MtTDtgvYg7xNbscQOR5mCRII/dH6CXkUdZcaKNNsD7+XmMsiYfyeSd/QJwQG
         ZsIbYSoU0cI9pxfDW1PG+m80X9R3fnvcq+CRD52SZp+KmLk9jJY8a8ezlb0nqJIORd0T
         wSMMLd1JCQB5N1EVn2LjF3Us9aica2zQadCN7W7mDGWK1o+G5tvLnSzhGyO3HyLYTDg+
         nN4w==
X-Gm-Message-State: AC+VfDyoBBixmXaZ5nGA9BLJ+hzjpHtkRUqCl3Oo4TugD7pN2VvYCnkZ
        apm9cQRaBCcl22RGuMT7ivgiAw==
X-Google-Smtp-Source: ACHHUZ6ZSG+H1ULJSKW01PE/Ox8Ma/fXVIZNcxWpuXW639bkievCG+xl6m7FFwsBPNcfaPfetl5l+g==
X-Received: by 2002:adf:f0c5:0:b0:306:2d28:d556 with SMTP id x5-20020adff0c5000000b003062d28d556mr2477923wro.34.1685137455881;
        Fri, 26 May 2023 14:44:15 -0700 (PDT)
Received: from lion.localdomain (cpc76484-cwma10-2-0-cust274.7-3.cable.virginm.net. [82.31.201.19])
        by smtp.gmail.com with ESMTPSA id d16-20020adff850000000b0030903d44dbcsm6138905wrq.33.2023.05.26.14.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 14:44:15 -0700 (PDT)
From:   Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v9 0/2] power: supply: introduce support for the Qualcomm
 smb2 charger
Date:   Fri, 26 May 2023 22:44:13 +0100
Message-Id: <20230524-pmi8998-charger-v9-0-cd7f6d03c0ab@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC0ocWQC/3WOTQ6DIBCFr2JYF0so6tBV79G4ABmUpIoZGtLGe
 Pei+y6/95P3NpaQAiZ2rzZGmEMKcSmgLxUbJrOMyIMrzKSQN9FIxdc5gNbAi0sjEgcptLPWd60
 CVlrWJOSWzDJMRy+5GVRzbWvFHeYjsBL68Dknn33hKaR3pO/5IMOh/h/LwAW30Hk/OA2tco9XW
 AzFOtLI+n3ff7rKH1fQAAAA
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        Joel Selvaraj <joelselvaraj.oss@gmail.com>
X-Mailer: b4 0.13-dev-46309
X-Developer-Signature: v=1; a=openpgp-sha256; l=1638;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=ossN8nvmsJ0dCCuZ5FP76rbpQnytfD6/+O9I3aGsBDw=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBkcSguwmasYNUd62k34L/rVRuK2+Jm8FA8pU7EE
 Yrc4bdHPHCJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZHEoLgAKCRAFgzErGV9k
 tublD/4yBtake5gCD6+StCy+oKpRyabsjHm2vzy3oftvXH/GyDLklER0cHR04bnBF9vAVhYjpcv
 Oy08mbDZjlzuV1Mqo6E8zhkAEd8rlkgsthXQ4mzjOl0TWvDm6RAtwoP3AhU2pkGVk5xcjAI/V8h
 Uzq4kkKJ8YS1f3Rqv32enx4Sx6Kt8QWTTVIE+lu6OUoUdmJ0Fr3PrC6H76dB92iU/L3do4DOmD2
 rkdvUA9hPEcLhb3p2+s/YHFx9syohDnib1xO0Jcf3/UR/tbcnMsVRk3QPqpQ9Qqg+qmoklhIdkU
 HcAKaZn+RavNn6m4BF0KAmTcdIHBTwjv9oOSdd2KOD1xMDXBlpjiM/k9N5zLGfp8N8Uopwq0gAL
 kgyfUt43j7nq5LaV87Yt3TNoIy3UhZEw0eWb+qY2tFIJRr1NUig2wvmq69zBrNo380bgS9rdpif
 0K0V1dKSUwQTWh3t0oqglluV9VsfXPhOpye0DoMtFSG//Vf6dB0Rxg3ev7uZO4BAzOUSTwbNsDr
 tDGHMafPTMSLz1q937Dyw8P9YhI2/3LcjDR+5Rx7yWhi7TtbAXt9wv6nRPfdiH+5ax0hw8W0v6w
 KTj++vB8nwbc2ni6qvBsYFgotFigfYaSQ1ICKdGoY9xu+X7a5wnS4lcMN8GTlx3iZDpXjUIlJyW
 yem9YqFQDDqydzw==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a driver for the Qualcomm PMI8998/PM660 Switch-Mode Battery Charger.
This is the second generation SMB charger, and replaces the previous
SMBB hardware found in older PMICs.

Changes since v8:
 * Add charger bindings reference to qcom,spmi-pmic.yaml
V8: https://lore.kernel.org/all/20230524-pmi8998-charger-v8-0-b87ffcd9864d@linaro.org/

Changes since v7:
 * Implement fixes suggested by Sebastian
 * Fix format warning
V7: https://lore.kernel.org/linux-arm-msm/20230127230506.3140297-1-caleb.connolly@linaro.org/

To: Sebastian Reichel <sre@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
To: Andy Gross <agross@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
To: Nathan Chancellor <nathan@kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
To: Tom Rix <trix@redhat.com>

---
Caleb Connolly (2):
      dt-bindings: power: supply: qcom,pmi8998-charger: add bindings for smb2 driver
      power: supply: add Qualcomm PMI8998 SMB2 Charger driver

 .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    |    1 +
 .../power/supply/qcom,pmi8998-charger.yaml         |   82 ++
 drivers/power/supply/Kconfig                       |    9 +
 drivers/power/supply/Makefile                      |    1 +
 drivers/power/supply/qcom_pmi8998_charger.c        | 1059 ++++++++++++++++++++
 5 files changed, 1152 insertions(+)
---
base-commit: ac9a78681b921877518763ba0e89202254349d1b

// Caleb (they/them)

