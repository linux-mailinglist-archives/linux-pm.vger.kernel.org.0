Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956FB570FCD
	for <lists+linux-pm@lfdr.de>; Tue, 12 Jul 2022 04:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiGLCAA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Jul 2022 22:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiGLB77 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jul 2022 21:59:59 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A65BF79
        for <linux-pm@vger.kernel.org>; Mon, 11 Jul 2022 18:59:58 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id s206so6298555pgs.3
        for <linux-pm@vger.kernel.org>; Mon, 11 Jul 2022 18:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nuPaTFh2Jga2agTt76o8SxVao6/hBHeRLv1L+lXtpKc=;
        b=A6Vl3aAo29Lrw7iukb8BVzlEBUgyaaS37tchXpXISf6ejKGXczbIM76hB5D2ZCe29/
         akqxL2Xxf832noIPekRGPzj1/BHh31Ft989cR3kQo10bNrvx8rQ7c0XsFKbGVNMLS/OV
         IBWbwVHvYPKVT5cx2L0ksdbk07yxayfq1jv7eCPMY7advvkypA0wvGr/ZsT1rUSplBH0
         LAHdXtNmeGvPk73OFmWdm4kaBpqyp+Q/aPeOYxwuQ4aXEOGp0SmYkUZSA4D2FUaUQspW
         yGkclTVvtq6vpBdcEl1C+AlhiRBm9XYSED/OD3BVKDjxYHOiotP41Hlyxs/azqQJ2VpS
         hvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nuPaTFh2Jga2agTt76o8SxVao6/hBHeRLv1L+lXtpKc=;
        b=Ywe34UKiF0MN2t2XQBsqBNJ2GEa1WnYn7ExCjdKBjF0pBoYMs2Rr31x/GXDR/lp8Hb
         GhSKRJ5K/Rufb2nf/0Tyc8OuIQHpc+wx3AU1lGQmKjKNnKyo+IIfKpi7S0mwCd2Eb4W2
         wM7oMNyOnryco3PFfPVy+NkF0MCJNekRe7hgMFFyAyHJW4SClPqTvjbz8TpZNh3TJ9Rw
         wm4dFoIXqSM6k/mENMzJHKtAFLjQfzjk8+rWRDG71OHme9OtQQ1qFHVVgGlB/xQhPb7M
         h30sGWYVmb0H6Ja1gPhidPTTvMDMzH0U4WZSo/5lhCZYlYKJ//8W9Ha00CxzfbXdfWUx
         7IKg==
X-Gm-Message-State: AJIora+E+SPJCv01bb7WLRjQVA0QNgMf+4Bx3R2RtFM1ColXBadRPxtG
        PQZk/BxWoUXIW9zsIqOXNIiBSA==
X-Google-Smtp-Source: AGRyM1tdOwL20X8SEOTykDxB0KxybM4JcZmj2jVohgfsBKX2aVF8ZzZRARsY2B62DXSSRdy5asBBhw==
X-Received: by 2002:a63:fb12:0:b0:412:b113:f537 with SMTP id o18-20020a63fb12000000b00412b113f537mr18786804pgh.256.1657591197553;
        Mon, 11 Jul 2022 18:59:57 -0700 (PDT)
Received: from leo-build-box.lan (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id x5-20020a17090a6b4500b001ef76dbae28sm5425821pjl.36.2022.07.11.18.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 18:59:56 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v6 0/5] interconnect: qcom: icc-rpm: Support bucket
Date:   Tue, 12 Jul 2022 09:59:24 +0800
Message-Id: <20220712015929.2789881-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch set is to support bucket in icc-rpm driver, so it implements
the similar mechanism in the icc-rpmh driver.

It uses interconnect path tag to indicate the bandwidth voting is for
which buckets, and there have three kinds of buckets: AWC, WAKE and
SLEEP, finally the wake and sleep bucket values are used to set the
corresponding clock (active and sleep clocks).  So far, we keep the AWC
bucket but doesn't really use it.

Note, this patch set is dependent on an out of tree patch "interconnect:
icc-rpm: Set destination bandwidth as well as source bandwidth" [1].
With the dependent patch, this patch set can be cleanly applied on the
Linux kernel master branch with the latest commit 32346491ddf2
("Linux 5.19-rc6").

[1] https://lore.kernel.org/linux-pm/20220707093823.1691870-1-bryan.odonoghue@linaro.org/T/#r304f7b103c806e1570d555a0f5aaf83ae3990ac0

Changes from v5:
- Removed unsed local variable 'max_agg_peak' in qcom_icc_set() (Georgi).

Changes from v4:
- Added Krzysztof's Acked tag for DT binding document patch;
- Fixed the unalignment between function qcom_icc_pre_bw_aggregate() and
  its comment (Georgi);
- Simplified qcom_icc_bus_aggregate() with removing unused parameter
  'max_agg_peak';
- Removed unsed local variable 'max_peak_bw' in qcom_icc_set() (Georgi).

Changes from v3:
- Removed $ref and redundant sentence in DT binding document for
  '#interconnect-cells' (Krzysztof Kozlowski).

Changes from v2:
- Fixed for DT checker error for command ''make DT_CHECKER_FLAGS=-m
  dt_binding_check' (Rob Herring).

Changes from v1:
- Added description for property "#interconnect-cells" (Rob Herring);
- Added Dimtry's reviewed tags for patches 02 and 03 (Dmitry Baryshkov);
- Rebased on the latest mainline kernel and resolved conflict.


Leo Yan (5):
  dt-bindings: interconnect: Update property for icc-rpm path tag
  interconnect: qcom: Move qcom_icc_xlate_extended() to a common file
  interconnect: qcom: icc-rpm: Change to use qcom_icc_xlate_extended()
  interconnect: qcom: icc-rpm: Support multiple buckets
  interconnect: qcom: icc-rpm: Set bandwidth and clock for bucket values

 .../bindings/interconnect/qcom,rpm.yaml       |   6 +-
 drivers/interconnect/qcom/Makefile            |   3 +
 drivers/interconnect/qcom/icc-common.c        |  34 +++++
 drivers/interconnect/qcom/icc-common.h        |  13 ++
 drivers/interconnect/qcom/icc-rpm.c           | 129 +++++++++++++++---
 drivers/interconnect/qcom/icc-rpm.h           |   6 +
 drivers/interconnect/qcom/icc-rpmh.c          |  26 +---
 drivers/interconnect/qcom/icc-rpmh.h          |   1 -
 drivers/interconnect/qcom/sm8450.c            |   1 +
 9 files changed, 176 insertions(+), 43 deletions(-)
 create mode 100644 drivers/interconnect/qcom/icc-common.c
 create mode 100644 drivers/interconnect/qcom/icc-common.h

-- 
2.25.1

