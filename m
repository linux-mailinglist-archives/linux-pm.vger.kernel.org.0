Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106C762F9B1
	for <lists+linux-pm@lfdr.de>; Fri, 18 Nov 2022 16:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242228AbiKRPuY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Nov 2022 10:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242406AbiKRPuQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Nov 2022 10:50:16 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6588C48D
        for <linux-pm@vger.kernel.org>; Fri, 18 Nov 2022 07:50:08 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id w14so9863722wru.8
        for <linux-pm@vger.kernel.org>; Fri, 18 Nov 2022 07:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=CmTL+mg18Z4AepnU6eZyDbtFVjUFILiYsH5hlR5uEro=;
        b=OKMKBVZQLGFbwj7QynAdCsT1VPXH4Rioy1t2pjuIIwxWZix6jBtDy7618JyJPVVbKc
         9cyV2lgYpSqGprBK/Zo5n0gBEwNItE5wk5Gn9gntUX2rkuu0ze1qAwFs2OWCJn+nFkcl
         JAqCvez9iMlY31ZS4LunN34VGNDFXbZ3vWTgbY1e/y+4E+EpNgB7JTLS3KsHPGVn8q3D
         unjpp+2+9+3F+IeR0mpzwPO5FSgMd1PgXO5xo8ymNxjTuTysCfEcwqT0Z6UAln26Rlcv
         7+h/5k5SFS9tYojx/tMVyRFw2tCzjRc3rsQ6wEoArQ40uBTijfLSQD+45DjsTzDCm51g
         ZFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CmTL+mg18Z4AepnU6eZyDbtFVjUFILiYsH5hlR5uEro=;
        b=eQCr5AhmuSvu/0GVHTNSWy/4azrWAYi9zNdKk3APzdpObGrKxwtTu1VQACYUF6YjIp
         hOhGdPlda8Yg/7sOisWLb3K10XJeGvU1akZDZl2AbKhd0jNMAe4l9l5Bt5Ww8qz+0pdR
         poNxLQj+NIQDwhXwHfpB9sKTJiXbi4c5RaQkdWjGcmtvUwbmiZJTeBH46I13o+3L+QFP
         UAg/5QxRugpRxSjPdBuv6Mjrn7Suh80Ryfzkgq3ZGOYSGp0VLnWUGQRkTQ6lSaVjRydy
         kVE6IJ9Yi/fJ7XoYmr/JWj3n84bigHCF1SWg5cdx9toZ91nwTtEs43K8VIxVFcNQWpV2
         MaZg==
X-Gm-Message-State: ANoB5pkYUjwnGImIqL05AYgBWQ3yYFCAVxKs1Ifiwz+pcEjuXfCenxc/
        7qAuCjj4oNG7pGcuiecdsDle79aVyxV7eg==
X-Google-Smtp-Source: AA0mqf4VUH/lC1IDoaI1Aq0Zpxjp4JBMofLzpxPK1c2Yw11pg5JIQHZmyxkopn1qIikCQ7p5Weaomw==
X-Received: by 2002:adf:e78e:0:b0:22e:32ab:c37 with SMTP id n14-20020adfe78e000000b0022e32ab0c37mr4831201wrm.317.1668786606917;
        Fri, 18 Nov 2022 07:50:06 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id a13-20020a5d53cd000000b002383edcde09sm3812465wrw.59.2022.11.18.07.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 07:50:06 -0800 (PST)
Subject: [PATCH v2 0/2] arm64: amlogic: add initial Odroid Go Ultra DTS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAKypd2MC/42NQQrDMAwEv1J0rkrsxKH01H+UHuRYJAJjgZwESsjfa/qCnpbZw8wBlU24wuNygP
 EuVbQ08NcLTAuVmVFSY/Cd967rHcYBNZlKwllxy6sRSpFVKGPgMUyJA/ueoAkiVcZoVKalKcqWczsX
 qava5xfcXZvXX+7dYYeD5z5FpvuYwjNLIdOb2gzv8zy/1JQWNcoAAAA=
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 18 Nov 2022 16:50:04 +0100
Message-Id: <20221031-b4-odroid-go-ultra-initial-v2-0-a3df1e09b0af@linaro.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-pm@vger.kernel.org, Rob Herring <robh@kernel.org>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This adds initial support for the Hardkernel Odroid Go Ultra.

The Odroid Go Ultra is a portable gaming device with the following
characteristics:
- Amlogic S922X SoC
- RK817 & RK818 PMICs
- 2GiB LPDDR4
- On board 16GiB eMMC
- Micro SD Card slot
- 5inch 854×480 MIPI-DSI TFT LCD
- Earphone stereo jack, 0.5Watt 8Ω Mono speaker
- Li-Polymer 3.7V/4000mAh Battery
- USB-A 2.0 Host Connector
- x16 GPIO Input Buttons
- 2x ADC Analog Joysticks
- USB-C Port for USB2 Device and Charging

The following are not yet handled:
- Battery RK818 Gauge and Charging
- Earphone stereo jack detect
- 5inch 854×480 MIPI-DSI TFT LCD

This adds:
- Device bindings
- Initial device DT

This serie depends on:
- https://lore.kernel.org/all/20221025-rk808-multi-v2-0-d292d51ada81@linaro.org/

To: Sebastian Reichel <sre@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Kevin Hilman <khilman@baylibre.com>
To: Jerome Brunet <jbrunet@baylibre.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-amlogic@lists.infradead.org
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

---
Changes in v2:
- Dropped power off driver/bindings, will move to another patchset
- Fixed DT comments from Krzysztof
- Dropped poweroff node
- Add Acked-by from Rob to bindings change
- Link to v1: https://lore.kernel.org/r/20221031-b4-odroid-go-ultra-initial-v1-0-42e3dbea86d5@linaro.org

---
Neil Armstrong (2):
      dt-bindings: amlogic: document Odroid Go Ultra compatible
      arm64: dts: amlogic: add initial Odroid Go Ultra DTS

 Documentation/devicetree/bindings/arm/amlogic.yaml |   1 +
 arch/arm64/boot/dts/amlogic/Makefile               |   1 +
 .../dts/amlogic/meson-g12b-odroid-go-ultra.dts     | 722 +++++++++++++++++++++
 3 files changed, 724 insertions(+)
---
base-commit: 2c3c398ddfabf48b7a0b66b5f01052ba43c36337
change-id: 20221031-b4-odroid-go-ultra-initial-5e65cde5e23a

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>
