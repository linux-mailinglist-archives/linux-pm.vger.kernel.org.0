Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B37771733F
	for <lists+linux-pm@lfdr.de>; Wed, 31 May 2023 03:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbjEaBmz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 May 2023 21:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjEaBmy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 May 2023 21:42:54 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DB510B
        for <linux-pm@vger.kernel.org>; Tue, 30 May 2023 18:42:51 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so6017116e87.3
        for <linux-pm@vger.kernel.org>; Tue, 30 May 2023 18:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685497370; x=1688089370;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xljCA29YsIP0+Y8LXCa8pJbogsbieLDmlx+5/VMZqTY=;
        b=SWqiVEQwq8FHaTqPlNJFfKiJZyzqNaGU/zfCjJgd7azcScFpxSZrpzGNhNCYs1uWlE
         9WJdMY5CZH+/IU1R3GjgtRAjcPuRpyc+opEiJJ5d5LkoxYdZrugdFjWZYNaGWeaY1+l0
         +tcEwi7LbSiyyekWSBEtRHzS3jsaM4l1YfcxykTLqQG4dAYGfxED3oQgnvWoxWfgmCCf
         8xDbio3HFhtdOZWK+bTomv38VVj7v26vPGiK6iJMZEgu290vgZwWvoE8BmOaQQPMNH92
         hr3ifiEDv3Bu3Uj/msaiFup9Kt/1p/jdk4rlQpg1m7o70S8kOVQEYrcWMJz6TWYqt0wM
         W/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685497370; x=1688089370;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xljCA29YsIP0+Y8LXCa8pJbogsbieLDmlx+5/VMZqTY=;
        b=P+MexJX7UgflWqKAW6Bxjp8AujGZXAqejAAT1k+nG4iZvyHfyXHaOc3+tIVvZcmxZ/
         aM08HbAy5xe4GBXBhLsR27IlnCitqnWE47scvdAmSFXrz4SxrOFfH5hEeEaXxfVzpUU/
         ZXxcChQfHj3CeUEN2zNJbZHc5fng7ruhAUY4yPPHYAAI2lj1glkbOm6B9jiqoE1No6Hx
         3+tCDrjrPmt0LSFod8FQIxt4z/w72KR7UF7Iel9B4bH3MvjEUlHI25y57CcNZHqjdmJl
         i/5fbvhpjzrF9sT1a9Dsifaq5ekdp/nDisndWKls4qy+Ac/kXE7kXTR/j1WTBYdAmPMx
         Uk6Q==
X-Gm-Message-State: AC+VfDxo7xZelFQXs7CUgJPOSsyjZ5KbgUJZ//wEOK0jFz/ICQKtM8gd
        Rlc4jKejFwLBQUn+3UtkFx18aQ==
X-Google-Smtp-Source: ACHHUZ4MedO+Nhhc9D9iy3fSvGi45ICLjQmEmMfqx1wmxIVXvGC2pI5+Wp/ab5tm+1MKgPkT2OYXqg==
X-Received: by 2002:ac2:4461:0:b0:4f0:345:6ceb with SMTP id y1-20020ac24461000000b004f003456cebmr1536886lfl.14.1685497370018;
        Tue, 30 May 2023 18:42:50 -0700 (PDT)
Received: from lothlorien.lan (dzdqv0yyyyyyyyyyybm5y-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::ab2])
        by smtp.gmail.com with ESMTPSA id q20-20020ac25294000000b004f3945751b2sm515994lfm.43.2023.05.30.18.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 18:42:49 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 0/4] ARM: dts: qcom: apq8074-dragonboard: enable resin device
Date:   Wed, 31 May 2023 04:42:44 +0300
Message-Id: <20230531014248.3824043-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for buttons, LEDs and coincell charger found on the APQ8074
dragonboard device.

For PM8941 we don't have a defined field to store the reset reason.
Support wrapping pwrkey and resin, but without writing the reset
reason.

Changes since v2:
- Split non-pon patches to separate patchset
- Changed schema to disallow reboot modes for pm8941-pon (Konrad)

Changes since v1 (noted by Konrad):
 - Changed to use freshly defined qcom,pm8941-pon compat
 - Fixed indentiation for LEDs definition
 - Reverted the order of pinctrl fields
 - Moved status field to the last position
 - Removed unnecessary pinconf indirection

Dmitry Baryshkov (4):
  dt-bindings: power: reset: qcom-pon: define pm8941-pon
  power: reset: qcom-pon: add support for pm8941-pon
  ARM: dts: qcom-pm8941: add resin support
  ARM: dts: qcom: apq8074-dragonboard: add resin

 .../bindings/power/reset/qcom,pon.yaml        | 12 +++++++++-
 .../arm/boot/dts/qcom-apq8074-dragonboard.dts |  5 +++++
 arch/arm/boot/dts/qcom-pm8941.dtsi            | 22 ++++++++++++++-----
 drivers/power/reset/qcom-pon.c                | 22 +++++++++++++------
 4 files changed, 48 insertions(+), 13 deletions(-)

-- 
2.39.2

