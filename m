Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A451565B925
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jan 2023 02:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236605AbjACB6z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Jan 2023 20:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236603AbjACB6y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Jan 2023 20:58:54 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBB9127;
        Mon,  2 Jan 2023 17:58:53 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id a9so5093691ilk.6;
        Mon, 02 Jan 2023 17:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q9ep0fuIijQ2WKk1HRvET07Y4q3Esjm/P8zfecbF5PA=;
        b=mAh4DEdGGndMdRLdcoygx2jSWLH/w2Pfa0O5DPG6DRuhUdFE7Qx5QsViPMMNZFkSCB
         5r2Wqh1Gh2clSie0Y2+42jqjStQvaOFzdJlFkXoqHIvMM2KNL8XWvBJWtojEtukNZx7h
         ir81HCz+oovhNdQmsZGnvJXpFVLQOeK56RqmFkSQAWmoCBT41rv0iOn4CpJpA6hvx1Pf
         Urr8i+gh44jUctYneDAzKiOhHw0jPOlcDmbweodKP0gNqsuJkRdGrp6VAvfpo27wk5CR
         JAnyUgvXYnoKYrBjxJFib9O2lNFcnj5DR+fmj4xMZ2WdyZU/JkZjpZ2QuqYKbSguoK25
         m8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q9ep0fuIijQ2WKk1HRvET07Y4q3Esjm/P8zfecbF5PA=;
        b=f7pXJ3gnFy6whYrR0xI5SmFK5cyRWILVqclVNoifGCqrz2J49Frxrh3duc0TYidgec
         9CbNg03LFnCWPyAf36GvjLKlHfJ+GwShG9YvkPuwB1AqNy8hK5gnUHDhZtxO+cYyRL+5
         jSOzT8pgj1DIZVF/6f8urwjvR/9JI2z+U7hqkyfxdX7q3gJoy+mJdaYtX/0oo1kMfJpI
         y5v+payhTD/fy6gZNSBRBNSueXtRSb+Bae/HBBh7RnkkTSLXPBow7UU8BVXqWqAiEkIw
         gvr/0zXnYl5Ma67rpsBfq3YeY4/auoKprcaQIHLClOj9J08aqYbT/5DBPDCINnMTH8jn
         S2pg==
X-Gm-Message-State: AFqh2kpLNURR32lOdGt9RDw2fIbU59gthoCbTt3XsZIb8tPgAuWd3CMf
        F5QscP6W/g/mi06cc6As6XC275Jb9PbSew==
X-Google-Smtp-Source: AMrXdXv9vjXTaC73he/AnyjuFYBLc3RX/8a7d69JrGC++iDeVXHPTk+0Jg1BkBC3syk2C8Rlf7YF3g==
X-Received: by 2002:a05:6e02:1d0a:b0:303:67aa:e5f3 with SMTP id i10-20020a056e021d0a00b0030367aae5f3mr35360139ila.15.1672711133291;
        Mon, 02 Jan 2023 17:58:53 -0800 (PST)
Received: from localhost ([2607:fea8:a2df:3d00::d097])
        by smtp.gmail.com with ESMTPSA id a18-20020a92d352000000b002eb3b43cd63sm9552995ilh.18.2023.01.02.17.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 17:58:52 -0800 (PST)
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
Subject: [PATCH v3 0/4] SDM670 Interconnects
Date:   Mon,  2 Jan 2023 20:58:41 -0500
Message-Id: <20230103015845.314551-1-mailingradian@gmail.com>
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

