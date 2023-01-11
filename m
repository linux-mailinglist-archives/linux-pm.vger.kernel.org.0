Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD92665097
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jan 2023 01:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbjAKAwY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Jan 2023 19:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbjAKAwW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jan 2023 19:52:22 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1F6C52;
        Tue, 10 Jan 2023 16:52:21 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id r72so6988924iod.5;
        Tue, 10 Jan 2023 16:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4viZlpwyxWqP3jFFUpzO0V1Vc+FGPQcgPSJWYIU7qWo=;
        b=M8OrgXbSrXkD39pvFp57+Mckum45IN9ITTU17EV6eDfALnYULLzjGRHvM4/IB0GdZ9
         D8lP8BSILuxJ4Qs6r33s16BsKBOMPFMPvIdqn/t8bEtIPc5G0sCJdD5zWihx6Z5Zsnf4
         E1IcYGDhA/GfTUYIdpIm1eEtvS5YnK6EG1Ag9q/sgk+5SAqfWQygJPV9cmoWo0dAm5PW
         0mngealglnR5Oc0CRhbBBXQfqiaHLgNJhhStGxhd45peC1Z0wHJpyhW2UVXuPsjK8DgH
         bmu9EwxzabmgQk2Jv3qLTIT5yROp+1gb3sY1T1HK1ZoH3iev6eMYL4HohaV2ZRtu1TTQ
         r7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4viZlpwyxWqP3jFFUpzO0V1Vc+FGPQcgPSJWYIU7qWo=;
        b=buDdjhQiqxvEdON2QZWrk0lk/Rj5pldihvBFcjifq3HOhQMLbXol3Pm89YBXSP5m0c
         mx990QwK73lHf1YeI14oafMvMdE9l6m5LQVmC0CAr2x92h1lJXe7P9xv0x7u+UZ2ku5S
         iUJhlvcdzKbvRmlVeg/ScBXT1W8aM69a1/Lgxd8y03A6L0naSTcitG4Ns8HyBHdV8t61
         CEjdbu7Tm/DR8DlHKaD67DdbMghUBS/9VUwlswwnEOF1440MAxbBU5kD7nSL9t2ffYB0
         4wUeYcoLK+2pnLxjtdRMqwGMFpYv94wQzW7ndtewOqnptxQ2O5IxbyQ5QfqhQrnup0rd
         r5+Q==
X-Gm-Message-State: AFqh2koEMtRsQf0o/Gk8uZXihU1GcGPhW8hyvfSEH0CE+/WEJsJLAH6o
        7prulwBcIs0+VSitGgabo4zeQzacWIw=
X-Google-Smtp-Source: AMrXdXvdMzvtAz+9HnTHGtstz2ViN35e8QT/TLqLWqp/YoS1bG0kBXv+YSvluOLVemlp6z/u0Bxh9Q==
X-Received: by 2002:a05:6602:809:b0:704:60cd:8812 with SMTP id z9-20020a056602080900b0070460cd8812mr1645122iow.9.1673398341017;
        Tue, 10 Jan 2023 16:52:21 -0800 (PST)
Received: from localhost ([2607:fea8:a2df:3d00::11ab])
        by smtp.gmail.com with ESMTPSA id d97-20020a0285ea000000b0039deb26853csm4072656jai.10.2023.01.10.16.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 16:52:20 -0800 (PST)
From:   Richard Acayan <mailingradian@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Odelu Kukatla <quic_okukatla@quicinc.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH v4 0/4] SDM670 Interconnects
Date:   Tue, 10 Jan 2023 19:51:51 -0500
Message-Id: <20230111005155.50452-1-mailingradian@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Changes since v3:
 - fix a merge conflict on linux-next (1/4)

Changes since v2:
 - change qcom,sdm670.h to qcom,sdm670-rpmh.h (2/4)
 - use SPDX v3 license identifiers (1/4, 2/4)
 - accumulate ack tag (1/4)
 - format changelog (0/4)

Changes since v1:
 - change qcom,sdm670.h to qcom,sdm670-rpmh.h (1/4, 4/4)

This series adds interconnects and consumers to the Snapdragon 670.

Richard Acayan (4):
  dt-bindings: interconnect: add sdm670 interconnects
  interconnect: qcom: add sdm670 interconnects
  arm64: dts: qcom: sdm670: add interconnects
  arm64: dts: qcom: sdm670: add opps for peripherals

 .../bindings/interconnect/qcom,rpmh.yaml      |   8 +
 arch/arm64/boot/dts/qcom/sdm670.dtsi          | 165 +++++++
 drivers/interconnect/qcom/Kconfig             |   9 +
 drivers/interconnect/qcom/Makefile            |   2 +
 drivers/interconnect/qcom/sdm670.c            | 440 ++++++++++++++++++
 drivers/interconnect/qcom/sdm670.h            | 128 +++++
 .../interconnect/qcom,sdm670-rpmh.h           | 136 ++++++
 7 files changed, 888 insertions(+)
 create mode 100644 drivers/interconnect/qcom/sdm670.c
 create mode 100644 drivers/interconnect/qcom/sdm670.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sdm670-rpmh.h

-- 
2.39.0

