Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CC4656590
	for <lists+linux-pm@lfdr.de>; Mon, 26 Dec 2022 23:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbiLZWuU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Dec 2022 17:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbiLZWuA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Dec 2022 17:50:00 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C3D25E7;
        Mon, 26 Dec 2022 14:49:59 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id z144so6215192iof.3;
        Mon, 26 Dec 2022 14:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R8ZQWcOuaItNqEqb8fb1Ttbkxvq+QX//Eo34yPc/SMY=;
        b=QSRhxgXe7bU4RLcuceAdMdRQSzG12VFnijUx/NrTFF519FnvufvDnbPQVgV66f6TBo
         Egbh/J6bKhi5I4hFqfk9P4/32MaXaJfX63IwjBYZMowezMSJu3EvbTw6MaTJx3zQ0+J4
         /zk0WO7DnCQTwChTQ9kPWVDeSRbZi5wTuhm0flCG6rxZ7SJ7gYwKH99tA65PMRdsCLhf
         e9t2A6ZzHAGxLYH8CiikEO+vgVAQz4asv5wlU3e45sLTEnzBjugwueze+/295GatjrPX
         zDVSw1bdABVxEIoNkNYRTCn8q0AtgO+lGMH2VByrL5Uij4vwookyQvHnaFRBQAh/GAW+
         UDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R8ZQWcOuaItNqEqb8fb1Ttbkxvq+QX//Eo34yPc/SMY=;
        b=q8fS2ekO0j11PxfdpnKDNRhxKfHzjI6RU2OgEkKKclXM7rhXE5QSxrCTEm6zHCPFBB
         hH9UOax3ptT+NKdDPD739UzmKxTJND3XVr7UjDSXX9k7BfzUKUVyMD0f5SWpxp2RXL0r
         eC0ZFkcqHwrFC5BsZfYq2X9fpbDbiUCpzhGCRDK88v7Gtc6c3eU7r/so5qJpELbNlg/X
         OV5tYVfP1EK550Lf0OuA0wPRLM54owlmTw4nX+XOiu4L2LXcGq6fsEzRtX9krsl1cnly
         YCpnNC2xCx0pZMQQZP9HX7620zRfQyuHuJUxBt5Kb7GycV7vAH3yjWvcLZ9Of9cpHfFq
         PSMQ==
X-Gm-Message-State: AFqh2koCpZMH4PzY3shL33fMXl6FfzD6qEnVlhJfHFSF0cQfMvYZWsS+
        JhenuddQLtV3ruKoDZ6eoLe8pjPO8fVuPw==
X-Google-Smtp-Source: AMrXdXtpZ/WPCbaIcnT65q0BQg3Fx3H9SOAXrdmoAvhflOwDpIZlgtp7vu7RJem9vfO6tZDqea9SDw==
X-Received: by 2002:a6b:7206:0:b0:6e5:d1b2:d921 with SMTP id n6-20020a6b7206000000b006e5d1b2d921mr13004146ioc.18.1672094998713;
        Mon, 26 Dec 2022 14:49:58 -0800 (PST)
Received: from localhost ([2607:fea8:a2df:3d00::e694])
        by smtp.gmail.com with ESMTPSA id j1-20020a5e9e41000000b006e2d21ab686sm4398142ioq.38.2022.12.26.14.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 14:49:58 -0800 (PST)
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
Subject: [PATCH 0/4] SDM670 Interconnects
Date:   Mon, 26 Dec 2022 17:49:40 -0500
Message-Id: <20221226224944.37242-1-mailingradian@gmail.com>
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
 .../dt-bindings/interconnect/qcom,sdm670.h    | 136 ++++++
 7 files changed, 888 insertions(+)
 create mode 100644 drivers/interconnect/qcom/sdm670.c
 create mode 100644 drivers/interconnect/qcom/sdm670.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sdm670.h

-- 
2.39.0

