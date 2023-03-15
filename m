Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9756BADD3
	for <lists+linux-pm@lfdr.de>; Wed, 15 Mar 2023 11:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbjCOKkl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Mar 2023 06:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjCOKkk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Mar 2023 06:40:40 -0400
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF1A166D0;
        Wed, 15 Mar 2023 03:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Content-Transfer-Encoding:MIME-Version:Message-Id
        :Date:Subject:Cc:To:From:References:In-Reply-To:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description;
        bh=SUExAIYL6xAykAwwtW+IW90OBx4NSv0nC4YM+9xejtQ=; b=F6VWacqY5FQtpaW2LSR5iiSxff
        a1hSY0TlJOP8n7HNQAPSbdLdUy+0JsyPrL7Kl0rIFzPRYbA5359t4e43ID32FOwfT/Dn5LaCGJO6W
        D9Bykk7AbznOdQvM+lv0AKZAwTTv7S9JmWr38MBHw7TcaKHp7RS7hJUQVfL+/pPs5Z0OQsOZEvkoV
        NThfKunmBEOMtTcWBB1X5P9lU1V+DHQBxSt1uGTOBw/F1rb/X7fqd2lx6q7ObEJ+wD745rWw23SFm
        dIBrz+eaCQUpiHCuBHcw6LBiQOtV4ZEsYN27c6ULJBumjCL9ZQ+lshPXT+MpJW/A+kpFMtTqZo2rx
        0imTSNKA==;
Received: from [10.22.3.24] (helo=kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2)
        id 1pcOYN-00GsYJ-Mu; Wed, 15 Mar 2023 11:40:19 +0100
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Subject: [PATCH v3 0/6] thermal: qcom: tsens: Fix MDM9607, add MSM8909
Date:   Wed, 15 Mar 2023 11:39:44 +0100
Message-Id: <20230315103950.2679317-1-stephan.gerhold@kernkonzept.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Make the MDM9607 thermal sensor support consistent with Qualcomm's
vendor kernel (msm-3.18) by applying the correct default slope values
and adding "correction factors" to the factory calibration values in the
fuses. Use the same functionality to add the very similar MSM8909 SoC to
the tsens driver.

---
Changes in v3: Drop now unused definition reported by kernel test robot
Changes in v2:
  - Rewrite on top of per-sensor nvmem cell changes that landed in 6.3
  - Add patches to fix existing support for MDM9607

Stephan Gerhold (6):
  thermal: qcom: tsens: Drop unused legacy structs
  thermal: qcom: tsens-v0_1: Fix mdm9607 slope values
  thermal: qcom: tsens-v0_1: Add mdm9607 correction offsets
  dt-bindings: thermal: qcom-tsens: Drop redundant compatibles
  dt-bindings: thermal: qcom-tsens: Add MSM8909 compatible
  thermal: qcom: tsens-v0_1: Add MSM8909 data

 .../bindings/thermal/qcom-tsens.yaml          | 23 +----
 drivers/thermal/qcom/tsens-v0_1.c             | 95 +++++++++++--------
 drivers/thermal/qcom/tsens-v1.c               | 22 -----
 drivers/thermal/qcom/tsens.c                  | 19 +++-
 drivers/thermal/qcom/tsens.h                  |  6 +-
 5 files changed, 80 insertions(+), 85 deletions(-)

-- 
2.30.2

