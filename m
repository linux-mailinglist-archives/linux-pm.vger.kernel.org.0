Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F03073578E
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jun 2023 15:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjFSNEf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Jun 2023 09:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjFSNEf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Jun 2023 09:04:35 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E65FE
        for <linux-pm@vger.kernel.org>; Mon, 19 Jun 2023 06:04:33 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f849a0e371so4275898e87.1
        for <linux-pm@vger.kernel.org>; Mon, 19 Jun 2023 06:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687179871; x=1689771871;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=odMwPE+kVr76rwf2FvrsOpgMI17JU9nxey64c65gsoM=;
        b=L5WJNUJZQ1UzXzbQV5xRJR5I8nBN/U1tL+xzWF3yqdzWRPWOKvi6yIrszcJ/LmvbkW
         FBogTvVmCJBuglblIXvVmizEKnf3EdTadywEdWFjI5U4KwBeSH2lLZDzdDY47tIDC7Ag
         1uiwmiWv8UW7BN2Lpg7ynRQfvt/UOUv2FlQSt3uJEs8jnkdHnxIjykSm08UJFvcRAQot
         C/QDkxj2CO7mJgycRKWJtmwpoF34xYRxy6IdfKQB+s75u+ZLWvWgNfIeYFld399XZHfB
         NpZX48oc2SO+mpkcfeq7AgqgIfpEdkoMP7GKYNnmVeeaplzyP1yoSaI3MT1Jtixs4WVw
         Lhvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687179871; x=1689771871;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=odMwPE+kVr76rwf2FvrsOpgMI17JU9nxey64c65gsoM=;
        b=Fc5nh0izfBAZ06MZigYQ2L0puuSNw5s9R0rN8viM+Ciy1Gqv9jwB3IS1WbAjo+4AyC
         LsfcppeB5gq5YetDN0CAIB+YTy2Q5EAmB4JE9TTYaNrstCXgvh8+BaxfVmAcNZWVFjT0
         PkzRyAxwAz8KAcU36ovY14XHAFUJSY2RAqZaNIX/sK52ioSQE3/FOmCRTNp58d0CjKEz
         VR29MxYz9xDeCFLG/nSJ4vaBKLeaKgciQbP8U7RfL1NZ3NOoVohiQebRpDsGHioAiEOn
         4lpDQ5uPT9JvDo1Ni2GZPWSgWT4PIzhaE2cnqYYN+/w1l9timJ04aqfzH8YfDbDhaMKO
         BasQ==
X-Gm-Message-State: AC+VfDyHpBJTc9S9oVC7czNJZu7/ZEczJKfB5Gv7TlXVkSSeNraiaebw
        PCeidNvqFLG/19JqZITb5ia5vsKbtl9Zpo+0pk8=
X-Google-Smtp-Source: ACHHUZ4hawHj5hEZ9QvXPKHke/CeP4L0I4b7v6odpuatm7sHc00Vxw2pEM6BstJRa96sNuhbwZq6lw==
X-Received: by 2002:a05:6512:60e:b0:4f8:6f9e:326a with SMTP id b14-20020a056512060e00b004f86f9e326amr1602945lfe.31.1687179871028;
        Mon, 19 Jun 2023 06:04:31 -0700 (PDT)
Received: from [192.168.1.101] (abyl242.neoplus.adsl.tpnet.pl. [83.9.31.242])
        by smtp.gmail.com with ESMTPSA id q28-20020ac25a1c000000b004f643664882sm4256489lfn.147.2023.06.19.06.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 06:04:30 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v7 00/22] Restructure RPM SMD ICC
Date:   Mon, 19 Jun 2023 15:04:25 +0200
Message-Id: <20230526-topic-smd_icc-v7-0-09c78c175546@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFlSkGQC/33QS2rDMBAG4KsErasijR6Wu+o9SigaaRwLXDlIq
 UkJvnvl7Iqpl//AN68Hq1QSVfZ2erBCS6ppzi10LycWRp8vxFNsmYEAJQxYfpuvKfD6FT9TCBw
 dSNVr5w1F1gz6ShyLz2FsKn9PUyteCw3p/hzycW55TPU2l5/nzEVu1f/aL5ILLnFwZK1VQdP7l
 LIv8+tcLmxrtcAhh8bJ9Eqj6KKTasfVIVeNmwG7qHp0nR52XB9yvXH0DtAOiB523Bxysy1P3os
 +CuFgf7s95LZxsAqcklK2//3h67r+AvI2dE/7AQAA
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
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687179869; l=6825;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=yXoln1LnGd5nmDN41nEsMx0XE4W7T2ndC/bK4SKC4ho=;
 b=NN2X/D6AGjqz264cLmuUX+VQb7IvMUsxU8mZw2poDY4RVMZNqv8SZslxRheql6Jn7DVNQoz1i
 6uRVt5WftYXDo6n7kQRqqiyZYQ+r00YwGFVzPulo1KeNp/tB2PXzbr1
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
Changes in v7:
- Rebase on next-20230619
- Throw some consts at "Separate out interconnect bus clocks"
- Link to v6: https://lore.kernel.org/r/20230526-topic-smd_icc-v6-0-263283111e66@linaro.org

Changes in v6:
- Fix argument naming in "Add rpmcc handling skeleton code"
- Fix missing clk.h and reorder patch "Add missing headers in icc-rpm.h",
  drop Dmitry's rb
- Pick up tags
- Link to v5: https://lore.kernel.org/r/20230526-topic-smd_icc-v5-0-eeaa09d0082e@linaro.org

Changes in v5:
- Pass RPM context id to qcom_icc_rpm_set_bus_rate()
- Fix min_t call cutting off bits 32-63 in set() path
- Pick up tags
- Link to v4: https://lore.kernel.org/r/20230526-topic-smd_icc-v4-0-5ba82b6fbba2@linaro.org

Changes in v4:
- Only set clk rate on a context if necessary
- Mention qcom,icc.h is not the correct header in "Control bus rpmcc form icc"
- Fix the bindings (BIT vs 1<<)
- Fix one more wrong use of qcom,icc.h in "Fix bucket numer" and uninclude it
- Drop "Allow negative QoS offset" (will be handled separately)
- Export icc clocks descriptions to unbreak =m builds
- Pick up tags
- Link to v3: https://lore.kernel.org/r/20230526-topic-smd_icc-v3-0-5fb7d39b874f@linaro.org

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
Konrad Dybcio (21):
      dt-bindings: interconnect: Add Qcom RPM ICC bindings
      soc: qcom: smd-rpm: Add QCOM_SMD_RPM_STATE_NUM
      soc: qcom: smd-rpm: Use tabs for defines
      clk: qcom: smd-rpm: Move some RPM resources to the common header
      interconnect: qcom: icc-rpm: Introduce keep_alive
      interconnect: qcom: Add missing headers in icc-rpm.h
      interconnect: qcom: Fold smd-rpm.h into icc-rpm.h
      interconnect: qcom: smd-rpm: Add rpmcc handling skeleton code
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

 drivers/clk/qcom/clk-smd-rpm.c                  | 314 +++++++++++-------------
 drivers/interconnect/qcom/Makefile              |   2 +-
 drivers/interconnect/qcom/icc-rpm-clocks.c      |  77 ++++++
 drivers/interconnect/qcom/icc-rpm.c             | 220 +++++++++--------
 drivers/interconnect/qcom/icc-rpm.h             |  56 ++++-
 drivers/interconnect/qcom/msm8916.c             |   5 +-
 drivers/interconnect/qcom/msm8939.c             |   6 +-
 drivers/interconnect/qcom/msm8974.c             |   2 +-
 drivers/interconnect/qcom/msm8996.c             |  10 +-
 drivers/interconnect/qcom/qcm2290.c             |   8 +-
 drivers/interconnect/qcom/qcs404.c              |   5 +-
 drivers/interconnect/qcom/sdm660.c              |   8 +-
 drivers/interconnect/qcom/smd-rpm.c             |  23 +-
 drivers/interconnect/qcom/smd-rpm.h             |  15 --
 drivers/soc/qcom/smd-rpm.c                      |  17 +-
 include/dt-bindings/interconnect/qcom,rpm-icc.h |  13 +
 include/linux/soc/qcom/smd-rpm.h                |  20 +-
 17 files changed, 456 insertions(+), 345 deletions(-)
---
base-commit: 47045630bc409ce6606d97b790895210dd1d517d
change-id: 20230526-topic-smd_icc-b8213948a5ed

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

