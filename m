Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94A8526AD2
	for <lists+linux-pm@lfdr.de>; Fri, 13 May 2022 22:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383976AbiEMUFq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 May 2022 16:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383970AbiEMUFp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 May 2022 16:05:45 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B8117E02
        for <linux-pm@vger.kernel.org>; Fri, 13 May 2022 13:05:43 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id p12-20020a9d4e0c000000b00606b40860a3so5680049otf.11
        for <linux-pm@vger.kernel.org>; Fri, 13 May 2022 13:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sw0Ty2i6m6ijMnudqcgyBhV3WU+F7zBQ1znaTdumRLw=;
        b=yN/cY5iqTHXB8k2VpjjflFaePUiVfE7b9NgfkkKpfc1W4BgCgu5HgoxpvBW1nQtNGr
         Sl8fpm796k1/TqQYr0fLp4PCPoytDblbbdu0gQosjOW9xhEPESQajc20EAkOecNVJ86n
         AP+CeHEc7lURKHAMx/sSzOErjekz5b2VaY1ZUF+PevEmoar0TChsFKbAXS0Xv2p0p9z+
         4HY3SUDqolk/MiFgwj9u5OFpun5IeagRB3o5xzl4BqF8v7eeWMPdPwlXW8CofRXmbbXR
         o01CYhOL+K6jq7wtQFjbTh8nVLqTjIduc5d4vwMUwWLTG0NR+XDFfa5UKLrC6B52XQem
         zerw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sw0Ty2i6m6ijMnudqcgyBhV3WU+F7zBQ1znaTdumRLw=;
        b=mq6vPg72RnNv+gL9zEES/jVg4VU0Ta+VrBd/qVG1+1uoKb/QnBwbYaydWhfyq3V0aT
         g3sy3FDUkIYnAr9j85/qwJ3+IOH3QO9IafekpxCUX7v8C3b41nVkPS4Nbx3m6z4ZjnoS
         VCcNrYOMbpS40SDKMcPxIM0qSa1a0RWdc6c6vbuYk5fkkg/+Pkju4nQXz7SJVvpLyxi7
         ub55I4+aITSy7oKcLY4yA/4Z1Y4goceYGRH42h9tY3cOQJu6EkA5gKJcsUfHczPUnTjM
         ksj59EU9sOii4Wz9QGGe27DQoAXFxYkgRyOpk1ydnOouvv199NuEY4IBoxMWIcxYIf7a
         jU6g==
X-Gm-Message-State: AOAM532kphbd0g3ytwHJEnCVwRg9Wio5saYtoDl7tkGXUXSseRhP2Eqs
        V9YA/oiwZaSG3dp1ClMnhkXgpw==
X-Google-Smtp-Source: ABdhPJzLs77QbT8u4Xwn/WdpDQnnzbI7KkSNrknx8GnCTltAk1TfOI2fdEfQZG9Xt5zFux0GgjGHDw==
X-Received: by 2002:a9d:6c87:0:b0:606:1000:bf5a with SMTP id c7-20020a9d6c87000000b006061000bf5amr2479769otr.7.1652472342230;
        Fri, 13 May 2022 13:05:42 -0700 (PDT)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id a1-20020a9d5c81000000b0060603221240sm1456962oti.16.2022.05.13.13.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 13:05:41 -0700 (PDT)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: [PATCH v3 0/6] power: supply: introduce support for the Qualcomm smb2 charger
Date:   Fri, 13 May 2022 21:05:06 +0100
Message-Id: <20220513200512.501156-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.36.1
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
https://lore.kernel.org/linux-arm-msm/20220429220904.137297-1-caleb.connolly@linaro.org/

Changes since v2:
 * Use devm_delayed_work_autocancel
 * Minor driver fixes
 * Pick up Krzysztof's R-b on the DT patch

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

 .../power/supply/qcom,pmi8998-charger.yaml    |   82 ++
 arch/arm64/boot/dts/qcom/pmi8998.dtsi         |   17 +
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts    |   18 +
 .../boot/dts/qcom/sdm845-oneplus-common.dtsi  |    4 +
 .../dts/qcom/sdm845-oneplus-enchilada.dts     |    4 +
 .../boot/dts/qcom/sdm845-oneplus-fajita.dts   |    4 +
 .../boot/dts/qcom/sdm845-xiaomi-beryllium.dts |   13 +
 drivers/power/supply/Kconfig                  |    9 +
 drivers/power/supply/Makefile                 |    1 +
 drivers/power/supply/qcom_pmi8998_charger.c   | 1074 +++++++++++++++++
 10 files changed, 1226 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
 create mode 100644 drivers/power/supply/qcom_pmi8998_charger.c

-- 
2.36.1

