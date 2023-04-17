Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53B76E4C11
	for <lists+linux-pm@lfdr.de>; Mon, 17 Apr 2023 16:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjDQO4M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Apr 2023 10:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjDQO4L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Apr 2023 10:56:11 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1948EBB93
        for <linux-pm@vger.kernel.org>; Mon, 17 Apr 2023 07:55:41 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id hg25-20020a05600c539900b003f05a99a841so21180642wmb.3
        for <linux-pm@vger.kernel.org>; Mon, 17 Apr 2023 07:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1681743340; x=1684335340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WYXjd3dFJZ9jr+MGGQSiH1V/fToahIVAv131sffor2E=;
        b=Zm2XgoDOA75WQWE4pUBOyhAaKt4rChqJXPd2U4SDduyp7hzwaAQLaIcR20Jt2Lpgyf
         hIlQNQ0PTGSGxd4qXNZ528dmBs2In0QMGxSZQmi6ZJSxd6soU4VnYHqQKKD4VTPPJWJo
         7BRcgWO4NCTlOhDpaxTEGc86JbBde6eXvQmXxotnI9t2KK9NsQD5mhiCFY3T0WzRG9fg
         UadOwpuTg06D3LK7lyxPsaP/nYiTYkaOqlNxiE/hKVevkyaHRNN9qmPRIWQnCaUugtLK
         0wupbIfkOUYs4F9R5dghg/sL6LHpjLwYH/cJR2Xk7T0yj78/GeLNn4JZYbEgVHcQovyC
         Okxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681743340; x=1684335340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WYXjd3dFJZ9jr+MGGQSiH1V/fToahIVAv131sffor2E=;
        b=YWqwEIp+SV+58uhhx1IjV7lSfUb2CA1A5gEeLRjjrEYTOhqm3y9guyqv8rsLAQdtfm
         N3dS/lBxgVp4gdKtDzDOCKUNI2encNyZzej1NIC2IqIcqp5JE4MydJ0db3JBBxH5eDTL
         dLH8nCRDOVTAWXQtSeD49zjlMUkCXHtYMhjAo9iaZri26QsludFUzfr6ApGDirlbe6wK
         /VzgQ5iM4AFWfeInCVrGr62NHRHk7h7ljBWSOLin2/NU+DGegWBKiilQsvBZRAIIbbhC
         QqilsjL8irGp/5f1NSh3cNDim8aq7YIPrkUZQZEU186xBZVANJbsa4h1Y5TRs7zhPjil
         FJhw==
X-Gm-Message-State: AAQBX9e/VPIjObNdHp3kJBtd/Z7pPB633WlJMSw0Fbu1j9Xu8f//t0Aj
        rUulHIYt/lkFZBGwzT5RsqoqsQ==
X-Google-Smtp-Source: AKy350YHd53wDWHSAIoI+eaEBU7aieJy/+jXCwJTxDQ9E371C+xJFImg+dYi6jM7Ob7gntTWWkvquQ==
X-Received: by 2002:a05:600c:1d20:b0:3f1:76d9:c788 with SMTP id l32-20020a05600c1d2000b003f176d9c788mr766508wms.8.1681743339907;
        Mon, 17 Apr 2023 07:55:39 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:374a:ffae:fd26:4893])
        by smtp.gmail.com with ESMTPSA id j15-20020a5d564f000000b002f7780eee10sm7998301wrw.59.2023.04.17.07.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 07:55:39 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 0/3] arm64: qcom: fix the reboot reason handling on sa8775p
Date:   Mon, 17 Apr 2023 16:55:33 +0200
Message-Id: <20230417145536.414490-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

SA8775P uses nvmem to pass the reboot reason magic value to the bootloader.
Remove the reboot modes from the PON node and introduce an SDAM node passed
to the nvmem-reboot-mode driver. While at it: convert the bindings for
nvmem-reboot-mode to YAML and enable it for arm64 in defconfig.

v1 -> v2:
- dropped the defconfig patch as it went upstream already
- in patch 1: explained better why we need to drop the reboot-modes from the
  PON node
- fixed formatting and order of properties in dt-bindings
- fixed naming of nodes in device tree

Bartosz Golaszewski (1):
  dt-bindings: power: reset: convert nvmem-reboot-mode bindings to YAML

Parikshit Pareek (2):
  arm64: dts: qcom: sa8775p: pmic: remove the PON modes
  arm64: dts: qcom: sa8775p: pmic: add the sdam_0 node

 .../power/reset/nvmem-reboot-mode.txt         | 26 ----------
 .../power/reset/nvmem-reboot-mode.yaml        | 52 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi   | 23 +++++++-
 3 files changed, 73 insertions(+), 28 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.yaml

-- 
2.37.2

