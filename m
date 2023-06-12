Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B1472CDE2
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jun 2023 20:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234857AbjFLSZV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jun 2023 14:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237548AbjFLSYm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2023 14:24:42 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6408196
        for <linux-pm@vger.kernel.org>; Mon, 12 Jun 2023 11:24:39 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f63ea7bfb6so5275937e87.3
        for <linux-pm@vger.kernel.org>; Mon, 12 Jun 2023 11:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686594278; x=1689186278;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I0jwkA7/rSvxCzo/5oEBszypLTaj6eJfu7GYxEO0M80=;
        b=q2UrYYmEacXUZmB4aneqPyrAAOmshXI3y5KColG+QKBW/mgdB5bbSeZaj+Chm5c2Ar
         1Xij5nYhaMBLHk2B+FIPAERHCF0urWF5rfpnN0Cq5QCPNsniauzeMSeFq5YsC2giMj7A
         Sor2iFDawaXlFvn3h8JmZC23O/R1syNgmlrCRatFdPf9fEvTWmOH/WG4WzdOh/m/k0vi
         YhZHDGBv2ajwJNtZ26WVKlDS4Lb/gbhcTokwAEUTFuRhTPv68aAmX5qfDyhhosSvI1RR
         gvceGB7x6zDJhyhXolWbPWbM1+DiU1Mt6MFHyaRx+dQFV/EEkQ03zpNieaItZyl5VtLl
         JS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686594278; x=1689186278;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I0jwkA7/rSvxCzo/5oEBszypLTaj6eJfu7GYxEO0M80=;
        b=KYLl/TyModo9b3LDEo6Eq4iaALTXDGMbSgQDFUkcGeXYO09D5pP47i+bm32eWc0NdM
         8cfNQcYNQHzYtBJIKnrQAPdoeSmvxzkF4hhg7ls/VNeNO1xWz6oPnrSPtpkWqejXdoZH
         KoL6xHXkHYxnzXtbnoMKtbg0eAYOLPzqKK7E66Za8TrhKOmxwOQlbkZJm7EE01OD8w0H
         0Hr02Ry/UPFcFCWnU96ZN3FwKaeI0fpD3y3o1MPVOpQ1vT2RMHoW1000kI/RJoG9MtRx
         g81svw5TNtO5mTScYoXjV+VRzZLhwT4toXKH/az848imRT6eEKP056D8bYx681lo2+4m
         vseQ==
X-Gm-Message-State: AC+VfDzewFpV0+e51LA9QtRyt72VM0u7tDw8rqmaylCsrf4eX7WQx+jR
        wmVkYqg/YUW4WioeN73J995mivTgorLfysW42Ew=
X-Google-Smtp-Source: ACHHUZ6SLOVvgqA4iuzbES4gwItAaPNOlc/z5yNvJAGehy2DmguYAUk1qJ/6+QEolG4NffOcmnQ/PQ==
X-Received: by 2002:ac2:5f96:0:b0:4f4:d41b:f416 with SMTP id r22-20020ac25f96000000b004f4d41bf416mr4816606lfe.4.1686594277897;
        Mon, 12 Jun 2023 11:24:37 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id v24-20020ac25938000000b004f64073a252sm1502035lfi.96.2023.06.12.11.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 11:24:37 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v3 00/23] Restructure RPM SMD ICC
Date:   Mon, 12 Jun 2023 20:24:17 +0200
Message-Id: <20230526-topic-smd_icc-v3-0-5fb7d39b874f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANFih2QC/32Nyw6CMBQFf4V0bQ1toYIr/8MY08cFboItabHRE
 P7dws6FLuckM2chEQJCJOdiIQESRvQugzgUxAzK9UDRZia85KKsuaSzn9DQ+LB3NIbqhjPRVo2
 qwZLsaBWB6qCcGbLlnuOYxylAh6/95HrLPGCcfXjvn4lt6698YrSkTHcNSCmFqeAyolPBH33oy
 ZZK/K/Osw51KypdnmzDxJe+rusHNewzVf8AAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686594276; l=5680;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=2mU+lcWQyGFMfbZQko5j/VVFBTYLJ6Qos1PhJn0q/gc=;
 b=mVtJoiNtZdWfMZW1gG0aU6g7O9wOv2VbXzOurK76aEEziCZXx8FtXw+C76aHT7DcV4ZW75MRV
 vVAqcgsWXTbBxY7qWsjZjgIr+PJ9I+SddEJVG++RCJu8dNbjLudcCwG
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series reshuffles things around, moving the management of SMD RPM
bus clocks to the interconnect framework where they belong. This helps
us solve a couple of issues:

1. We can work towards unused clk cleanup of RPMCC without worrying
   about it killing some NoC bus, resulting in the SoC dying.
   Deasserting actually unused RPM clocks (among other things) will
   let us achieve "true SoC-wide power collapse states", also known as
   VDD_LOW and VDD_MIN.

2. We no longer have to keep tons of quirky bus clock ifs in the icc
   driver. You either have a RPM clock and call "rpm set rate" or you
   have a single non-RPM clock (like AHB_CLK_SRC) or you don't have any.

3. There's less overhead - instead of going through layers and layers of
   the CCF, ratesetting comes down to calling max() and sending a single
   RPM message. ICC is very very dynamic so that's a big plus.

The clocks still need to be vaguely described in the clk-smd-rpm driver,
as it gives them an initial kickoff, before actually telling RPM to
enable DVFS scaling.  After RPM receives that command, all clocks that
have not been assigned a rate are considered unused and are shut down
in hardware, leading to the same issue as described in point 1.

We can consider marking them __initconst in the future, but this series
is very fat even without that..

Apart from that, it squashes a couple of bugs that really need fixing..

--- MERGING STRATEGY ---
If Stephen and Georgi agree, it would be best to take all of this through
the qcom tree, as it touches on heavily intertwined components and
introduces compile-time dependencies between icc and clk drivers.

Tested on SM6375 (OOT), MSM8998 (OOT), MSM8996.

MSM8974 conversion to common code and modernization will be handled separately.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v3:
- Use devm_clk_get_optional and only get() the clock once
- Drop unnecessary NULL-checks for qp->bus_clk
- Handle ARM32 CCF limitations, add an explicit comment about them
- Use Stephan's alternative rpmcc readiness check
- Fix one more wrong usage of QCOM_ICC_NUM_BUCKETS in icc-rpm.h
- Introduce new dt-bindings for icc rpm tags
- Mention the rpm tags situation in the commit message of
  "Fix bucket number"
- Pick up tags
- Link to v2: https://lore.kernel.org/r/20230526-topic-smd_icc-v2-0-e5934b07d813@linaro.org

Changes in v2:
- Sort entries properly in "Add missing headers in icc-rpm.h"
- Fix the check for no clocks on a given provider
- Replace "Divide clk rate by src node bus width" with a proper fix
- Add "Set correct bandwidth through RPM bw req"
- Split "Add QCOM_SMD_RPM_STATE_NUM" into 2 logical changes
- Move "Separate out interconnect bus clocks" a bit later in the series
- Link to v1: https://lore.kernel.org/r/20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org

---
Konrad Dybcio (22):
      dt-bindings: interconnect: Add Qcom RPM ICC bindings
      soc: qcom: smd-rpm: Add QCOM_SMD_RPM_STATE_NUM
      soc: qcom: smd-rpm: Use tabs for defines
      clk: qcom: smd-rpm: Move some RPM resources to the common header
      interconnect: qcom: icc-rpm: Introduce keep_alive
      interconnect: qcom: icc-rpm: Allow negative QoS offset
      interconnect: qcom: Fold smd-rpm.h into icc-rpm.h
      interconnect: qcom: smd-rpm: Add rpmcc handling skeleton code
      interconnect: qcom: Add missing headers in icc-rpm.h
      interconnect: qcom: Define RPM bus clocks
      interconnect: qcom: sdm660: Hook up RPM bus clk definitions
      interconnect: qcom: msm8996: Hook up RPM bus clk definitions
      interconnect: qcom: qcs404: Hook up RPM bus clk definitions
      interconnect: qcom: msm8939: Hook up RPM bus clk definitions
      interconnect: qcom: msm8916: Hook up RPM bus clk definitions
      interconnect: qcom: qcm2290: Hook up RPM bus clk definitions
      interconnect: qcom: icc-rpm: Control bus rpmcc from icc
      clk: qcom: smd-rpm: Separate out interconnect bus clocks
      interconnect: qcom: icc-rpm: Fix bucket number
      interconnect: qcom: icc-rpm: Set bandwidth on both contexts
      interconnect: qcom: icc-rpm: Set correct bandwidth through RPM bw req
      interconnect: qcom: icc-rpm: Fix bandwidth calculations

Stephan Gerhold (1):
      soc: qcom: smd-rpm: Move icc_smd_rpm registration to clk-smd-rpm

 drivers/clk/qcom/clk-smd-rpm.c                  | 312 +++++++++++-------------
 drivers/interconnect/qcom/Makefile              |   2 +-
 drivers/interconnect/qcom/icc-rpm-clocks.c      |  66 +++++
 drivers/interconnect/qcom/icc-rpm.c             | 210 ++++++++--------
 drivers/interconnect/qcom/icc-rpm.h             |  59 ++++-
 drivers/interconnect/qcom/msm8916.c             |   4 +-
 drivers/interconnect/qcom/msm8939.c             |   5 +-
 drivers/interconnect/qcom/msm8974.c             |   2 +-
 drivers/interconnect/qcom/msm8996.c             |   9 +-
 drivers/interconnect/qcom/qcm2290.c             |   7 +-
 drivers/interconnect/qcom/qcs404.c              |   4 +-
 drivers/interconnect/qcom/sdm660.c              |   7 +-
 drivers/interconnect/qcom/smd-rpm.c             |  35 ++-
 drivers/interconnect/qcom/smd-rpm.h             |  15 --
 drivers/soc/qcom/smd-rpm.c                      |  17 +-
 include/dt-bindings/interconnect/qcom,rpm-icc.h |  13 +
 include/linux/soc/qcom/smd-rpm.h                |  20 +-
 17 files changed, 449 insertions(+), 338 deletions(-)
---
base-commit: 53ab6975c12d1ad86c599a8927e8c698b144d669
change-id: 20230526-topic-smd_icc-b8213948a5ed

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

