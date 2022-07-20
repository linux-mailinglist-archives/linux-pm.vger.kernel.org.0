Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C02057BE68
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jul 2022 21:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiGTT2R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jul 2022 15:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiGTT2Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jul 2022 15:28:16 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326D6481F8
        for <linux-pm@vger.kernel.org>; Wed, 20 Jul 2022 12:28:14 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id t1so31828901lft.8
        for <linux-pm@vger.kernel.org>; Wed, 20 Jul 2022 12:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0GjIsq4ywCMZXZcSe/Hf1BCEstclfZZ3cilI89j5ThU=;
        b=VUIJn85eBQCXeFv5mdrrzsLBNUAt9WG148HwPKkxPIcLV9nQdHlwKzSyZPCWNsDu0D
         EaZkrTRZGwFT/hxSAAnrfAXenbIZ58SsfWIUeKq4izcEqyMRWcUZv3J2WclotkCp0lGv
         7ZqMyX5kbGy7HceJWeP5YwKHaX5MDYQoY/RDOh/1q/XZN4+sYHuKKEU79nCLtstDrPd2
         0LT+hMFVZ/AEpnOWYdRaj7RuplQVQUie04hkklYQnDwWj4ie9EYDNVKLljVIrEAc4VMK
         1wBraaAyDep6BKeNvif0NmPXd8URKcDOwN6hf0k9BokK7W5UrPJr9RGhBXyoaACgl2a8
         1TnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0GjIsq4ywCMZXZcSe/Hf1BCEstclfZZ3cilI89j5ThU=;
        b=DLQj5MpF7SiCg7Yk7qIqhl7Xy9Hflj1ZCiigUGnyUIL6gDW/Qpay/I4xfZKn+2dumC
         MusYTUZdGBiCUCv+QelJDRxOgQDMRvTxteFpK5Wtw7dGbrzwY9ZI3uAjdgftoxGxqZKu
         i7iy+EzSiT3W4TjhpNxC4BGf38c3Ws1wSFSohMQTTf6Dra20pbw/UAGei9ag+bXY3dgL
         1skM2IDpc0YGoAPMbhxzzoQlvuwAIrPWbqrvQZ+WgezZlVUKqRiKaGc322ha8zCFXt7W
         M4MusjVSAzQ/CPmfv2gRkSQsRblVBdMiVWpmDVgBQ/maD+0N+wPB1aRJ+MQnPMMRgkXS
         oKzQ==
X-Gm-Message-State: AJIora9kez9Pq5kDYxpuiPf1H1SX9ZEsIWH+oDNDVKUDSKkG/SsUmWfi
        ywBItwcM1jwTEvYYH0nma6eMqw==
X-Google-Smtp-Source: AGRyM1vxjzudKtDoj2CRWGRK26Dg2bD6DVCG7roFoWMzGuV6/hnE3BtccVtN9boNXJVFpSnhFh5U/g==
X-Received: by 2002:a05:6512:1054:b0:489:d273:be3a with SMTP id c20-20020a056512105400b00489d273be3amr21837278lfb.615.1658345292532;
        Wed, 20 Jul 2022 12:28:12 -0700 (PDT)
Received: from krzk-bin.. (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id h32-20020a0565123ca000b0047fac0f34absm3985771lfv.196.2022.07.20.12.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 12:28:11 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: [PATCH 00/10] soc/arm64: qcom: Add LLCC BWMON on SDM845
Date:   Wed, 20 Jul 2022 21:27:57 +0200
Message-Id: <20220720192807.130098-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Description
===========
BWMON is a data bandwidth monitor providing throughput/bandwidth over certain
interconnect links in a SoC.  It might be used to gather current bus usage and
vote for interconnect bandwidth, thus adjusting the bus speed based on actual
usage.

Qualcomm SoCs might several BWMON instances.  Extend existing support for CPU
BWMON (called v4) to LLCC BWMON (called v5).

Cc: Rajendra Nayak <quic_rjendra@quicinc.com>

Best regards,
Krzysztof

Krzysztof Kozlowski (10):
  dt-bindings: interconnect: qcom,msm8998-bwmon: add support for SDM845
    LLCC BWMON
  soc: qcom: icc-bwmon: re-use IRQ enable/clear define
  soc: qcom: icc-bwmon: drop unused BWMON_ZONE_COUNT
  soc: qcom: icc-bwmon: store reference to varian data in container
  soc: qcom: icc-bwmon: clear all registers on init
  soc: qcom: icc-bwmon: store count unit per variant
  soc: qcom: icc-bwmon: use regmap and prepare for BWMON v5
  soc: qcom: icc-bwmon: add per-variant quirks
  soc: qcom: icc-bwmon: add support for SDM845 LLCC BWMON
  arm64: dts: qcom: sdm845: add LLCC BWMON

 .../interconnect/qcom,msm8998-bwmon.yaml      |   1 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  37 ++
 drivers/soc/qcom/icc-bwmon.c                  | 465 ++++++++++++++----
 3 files changed, 405 insertions(+), 98 deletions(-)

-- 
2.34.1

