Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B765121B0
	for <lists+linux-pm@lfdr.de>; Wed, 27 Apr 2022 20:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbiD0SzD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Apr 2022 14:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbiD0Syk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Apr 2022 14:54:40 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42D3E78BC
        for <linux-pm@vger.kernel.org>; Wed, 27 Apr 2022 11:41:16 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id x18so3772395wrc.0
        for <linux-pm@vger.kernel.org>; Wed, 27 Apr 2022 11:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xT6txhcZ4EAYI9nKnuJpvrA0CPSdpDykVcMt05FEgHg=;
        b=EswJAvgjaKozP6htlI/2qYoE8tJVhxcnL/Cm6agqSaL8bFMdpp+q0oFRGze+oL9mgo
         /121Tbm74STe1XQcUStNRDslRQ4sUrMlYVqVLVlbIf3OpJLEufsVDjHMhndoaNhJwByO
         wI5e3Wf7qOtwf/AEPZUSRRw+kEJuJbSJg7NvfGts0uohsnQgOhUdzZ7TBS2rD+x5rmE7
         7wBmk4HBbRKtxLaS8NaIajD+9KL+ZLU3V9JxB06Xjo0O/meaZ7yEA9AXxGhuA6Cmam4U
         nJkhed3MbLkIqA4vmCzot0NkSHAkos3jsIkZUZZVPKtLxWUYio55iyThoc+jpWpCK3tJ
         ce5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xT6txhcZ4EAYI9nKnuJpvrA0CPSdpDykVcMt05FEgHg=;
        b=2swx1rUAfp8o/ehr9SoXH/CuJPmk/HVXPqIiwiih0Jn+lVKMhPSxIQMZ0LnvcPHvsA
         XY8JC5Ve5fFTTPPR7xBvRL+Qy1rJGe8MpmzuMoVwNwdwZLjWr5J8t2lhK9Qsndev8YlU
         uK+TdbgBaQkdI77txTJ2BR75whoUjQnqDPVTiJKVl2ILiSGCPVZmiSMjRWJoef1i+7FQ
         dFlejLMCIh6KhZwDg+B7Oj/nTR7qZZmWMvGUXk1ETb183AuhZDj+mJshxLrWLYS2wJb3
         G9MPB5X159hG/TsmUvnwFSKo8AkqxdP1dsUWWU2ojGfBv6XbKYO6f3hqW3D5ZbdeVwLF
         wcTQ==
X-Gm-Message-State: AOAM532psCx3uMKr242CG8t0V2GpoYEIeKri5VG+CeKF9/z3CdY6XxxR
        YqzqD7OdOW4YQRHbZczZJb4yIA==
X-Google-Smtp-Source: ABdhPJzvbaV+wwo7MxJ0teCNB2ZGmw4TVSxz76aUQwyPZh37nT/hcqzCXeDhNTeUICS6Nt/IrG4TfQ==
X-Received: by 2002:a5d:64ce:0:b0:20a:e769:d282 with SMTP id f14-20020a5d64ce000000b0020ae769d282mr7143577wri.655.1651084875133;
        Wed, 27 Apr 2022 11:41:15 -0700 (PDT)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id f3-20020a5d64c3000000b0020aef267950sm1992798wri.49.2022.04.27.11.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 11:41:13 -0700 (PDT)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     caleb.connolly@linaro.org, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Amit Pundir <amit.pundir@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH 0/6] power: supply: introduce support for the Qualcomm smb2 charger
Date:   Wed, 27 Apr 2022 19:40:25 +0100
Message-Id: <20220427184031.2569442-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.36.0
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

Add a driver for the Qualcomm PMI8998/PM660 Switch-Mode Battery Charger.
This is the second generation SMB charger, and replaces the previous
SMBB hardware found in older PMICs.

This driver provides basic support for initialising the hardware,
configuring the USB input current limit and reporting information about
the state of the charger. Features like type-c dual role support and OTG
switching will be added in future patches.

This patch series depends on my previous series adding support for
the Round Robin ADC which is used for reading the USB voltage and
current, it can be found here:
https://lore.kernel.org/linux-arm-msm/20220323162820.110806-1-caleb@connolly.tech/

Changes since v1:
 * Rename the driver to pmi8998_charger
 * Drop unnecessary (and very broken) mutex
 * Rework the driver based on feedback to v1
 * Fix some minor bugs and improve Automatic Input Current Limit support

---
Caleb Connolly (6):
  power: supply: add Qualcomm PMI8998 SMB2 Charger driver
  arm64: dts: qcom: pmi8998: add charger node
  arm64: dts: sdm845-oneplus: enable pmi8998 charger
  arm64: dts: qcom: sdm845-db845c: enable pmi8998 charger
  arm64: dts: qcom: sdm845-xiaomi-beryllium enable pmi8998 charger
  dt-bindings: power: supply: qcom,pmi8998-charger: add bindings for
    smb2 driver

 .../power/supply/qcom,pmi8998-charger.yaml    |   83 ++
 arch/arm64/boot/dts/qcom/pmi8998.dtsi         |   17 +
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts    |   18 +
 .../boot/dts/qcom/sdm845-oneplus-common.dtsi  |    4 +
 .../dts/qcom/sdm845-oneplus-enchilada.dts     |    4 +
 .../boot/dts/qcom/sdm845-oneplus-fajita.dts   |    4 +
 .../boot/dts/qcom/sdm845-xiaomi-beryllium.dts |   13 +
 drivers/power/supply/Kconfig                  |    9 +
 drivers/power/supply/Makefile                 |    1 +
 drivers/power/supply/qcom_pmi8998_charger.c   | 1070 +++++++++++++++++
 10 files changed, 1223 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
 create mode 100644 drivers/power/supply/qcom_pmi8998_charger.c

-- 
2.36.0

