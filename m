Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5CE7C94C6
	for <lists+linux-pm@lfdr.de>; Sat, 14 Oct 2023 15:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbjJNNin (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 14 Oct 2023 09:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbjJNNil (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 14 Oct 2023 09:38:41 -0400
Received: from srv01.abscue.de (abscue.de [IPv6:2a03:4000:63:bf5:4817:8eff:feeb:8ac7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDDFCA;
        Sat, 14 Oct 2023 06:38:37 -0700 (PDT)
Received: from srv01.abscue.de (localhost [127.0.0.1])
        by spamfilter.srv.local (Postfix) with ESMTP id 3DCF11C071B;
        Sat, 14 Oct 2023 15:38:33 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
Received: from fluffy-mammal.fritz.box (dslb-088-078-204-065.088.078.pools.vodafone-ip.de [88.78.204.65])
        by srv01.abscue.de (Postfix) with ESMTPSA id BDDE71C071A;
        Sat, 14 Oct 2023 15:38:32 +0200 (CEST)
From:   =?UTF-8?q?Otto=20Pfl=C3=BCger?= <otto.pflueger@abscue.de>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        =?UTF-8?q?Otto=20Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Subject: [PATCH v4 0/3] pmdomain: qcom: rpmpd: Add MSM8917 and similar SoCs
Date:   Sat, 14 Oct 2023 15:38:20 +0200
Message-Id: <20231014133823.14088-1-otto.pflueger@abscue.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add RPM power domain definitions for the Qualcomm MSM8917, MSM8937 and
QM215 SoCs. These SoCs all have the same power domains (VDDCX and VDDMX
in voltage level mode), but different regulators are needed for QM215
because it is used with a PM8916 PMIC instead of a PM8937 PMIC.

---
Changes in v4:
- Rebase on latest next as of 2023-10-14 with new SM7150 compatible
- Add missing Reviewed-by (if there were no changes to rebase on, I
  would have simply resent the patch)
Changes in v3:
- Sort compatibles in device tree binding documentation (suggested by
  Krzysztof)
- Rebase on latest next with genpd subsystem renamed to pmdomain
Changes in v2:
- Fix typo in patch description: VDDMD -> VDDMX
- Split MSM8917 and QM215 changes (suggested by Konrad)
- Remove redundant qcom,msm8937-rpmpd entry from rpmpd_match_table
  and use a fallback compatible instead (suggested by Konrad)

Otto Pflüger (3):
  dt-bindings: power: rpmpd: Add MSM8917, MSM8937 and QM215
  pmdomain: qcom: rpmpd: Add MSM8917 power domains
  pmdomain: qcom: rpmpd: Add QM215 power domains

 .../devicetree/bindings/power/qcom,rpmpd.yaml | 81 +++++++++--------
 drivers/pmdomain/qcom/rpmpd.c                 | 91 +++++++++++++++++++
 include/dt-bindings/power/qcom-rpmpd.h        | 21 +++++
 3 files changed, 156 insertions(+), 37 deletions(-)


base-commit: e3b18f7200f45d66f7141136c25554ac1e82009b
-- 
2.39.2
