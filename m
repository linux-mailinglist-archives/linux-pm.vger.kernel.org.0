Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4897A79FC5C
	for <lists+linux-pm@lfdr.de>; Thu, 14 Sep 2023 08:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjINGz1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Sep 2023 02:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbjINGz0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Sep 2023 02:55:26 -0400
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684DCCCD;
        Wed, 13 Sep 2023 23:55:21 -0700 (PDT)
Received: from srv01.abscue.de (localhost [127.0.0.1])
        by spamfilter.srv.local (Postfix) with ESMTP id 676831C3D96;
        Thu, 14 Sep 2023 08:55:18 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on abscue.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED autolearn=ham
        autolearn_force=no version=4.0.0
Received: from fluffy-mammal.fritz.box (dslb-092-072-000-199.092.072.pools.vodafone-ip.de [92.72.0.199])
        by srv01.abscue.de (Postfix) with ESMTPSA id 044411C0119;
        Thu, 14 Sep 2023 08:55:17 +0200 (CEST)
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
Subject: [PATCH v3 0/3] pmdomain: qcom: rpmpd: Add MSM8917 and similar SoCs
Date:   Thu, 14 Sep 2023 08:54:20 +0200
Message-Id: <20230914065422.5452-1-otto.pflueger@abscue.de>
X-Mailer: git-send-email 2.39.1
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

 .../devicetree/bindings/power/qcom,rpmpd.yaml | 79 ++++++++--------
 drivers/pmdomain/qcom/rpmpd.c                 | 91 +++++++++++++++++++
 include/dt-bindings/power/qcom-rpmpd.h        | 21 +++++
 3 files changed, 155 insertions(+), 36 deletions(-)


base-commit: 98897dc735cf6635f0966f76eb0108354168fb15
-- 
2.39.1
