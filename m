Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54A668B08F
	for <lists+linux-pm@lfdr.de>; Sun,  5 Feb 2023 16:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjBEP2O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Feb 2023 10:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjBEP2N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Feb 2023 10:28:13 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9D31B33F
        for <linux-pm@vger.kernel.org>; Sun,  5 Feb 2023 07:28:12 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id be12so9410356edb.4
        for <linux-pm@vger.kernel.org>; Sun, 05 Feb 2023 07:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DjFSnrIRGSJkdimIozAXKodrxA7+h1XiQIWKvot1aiY=;
        b=dJkr2phcC+JFaL2sbVNGXicazgKneu1SGA8XaRtnj1Zku/okz07szSaFJrBOLjpvff
         nMx7RP3R/7B7GHGauSiDkiJ3ULhjTrTjchfQVPFcmjkjdPgUWzvWvhrsXH3yZsYpR2fZ
         F/rHQwnv62J5nT4wi24QGOFQhw94V2YAkl52PFQ33NJ+VfVK2dNiIJFamehF8b7gPtUg
         XqXft35ZwGDPAjcjacdFNxSQbk5WjBakyufDNgcyzRAjaDFCGpJZCtgsk1KGajCpbv8I
         PQJ+l4473trOgY0gtEtOoyvAgNSHPydqehoNsppcE/pqSklnXOsKtcGp2Ld0BGnUaG7H
         kogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DjFSnrIRGSJkdimIozAXKodrxA7+h1XiQIWKvot1aiY=;
        b=YNsecKmCJD/0dXUM7K+iwAy1hH2lmx2alKGxhk3M2xT/RAjLbraalIhbQOauIh/sEk
         yEaRB2S1WsrBFxJVQLNSXP3lfEXOSq08sb6KKhRqDJgRRw070aIF5fd55Q2dO5U4W6LZ
         YEakDvLCGneJsSQJNu7Pxy2NQwykgTDA099I5MTc/xe1/j+HVbV/X8QNgKgPvgg6+/Fw
         SZJUoeLLZhxH9rpVpFrAO0QJVqCSzfA0FU/kujFuvCbFviLArcJ1kfaI7z/XAOv3DLHn
         kbUaE405+vKvBZfIEfYgoNgh8GV7+/QFzb9t5sefoYPEpzimkfzTHrGi9+65eE2jxb9H
         mgLg==
X-Gm-Message-State: AO0yUKVK3onpvDO/gs1WWt1IRgaLkLjRZ8Qv/gda19rSWbPrN66EOZc8
        9bSkE9Zg+06OMvy3QSxSNu46pCRqKHFSqVyb
X-Google-Smtp-Source: AK7set89cD8gkd+UryUNywAwCMwbqHCIrSf+k1vDAVAsY4lWEM30cUrmP49jhGZwL0Bpfg/4wfCzaw==
X-Received: by 2002:a50:d4dc:0:b0:4aa:a51a:7380 with SMTP id e28-20020a50d4dc000000b004aaa51a7380mr4129188edj.0.1675610890776;
        Sun, 05 Feb 2023 07:28:10 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id fg10-20020a056402548a00b004a23558f01fsm3889178edb.43.2023.02.05.07.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 07:28:10 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 0/3] power: supply: Lenovo Yoga C630 EC
Date:   Sun,  5 Feb 2023 17:28:06 +0200
Message-Id: <20230205152809.2233436-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.1
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

This adds binding, driver and the DT support for the Lenovo Yoga C630
Embedded Controller, to provide battery information.

Support for this EC was implemented by Bjorn, who can no longer work on
this topic. Thus it was agreed that I'll pick this patchset up and
update it following the pending review comments.

Changes since v1:
- Dropped DP support for now, as the bindings are in process of being
  discussed separately,
- Merged dt patch into the same patchseries,
- Removed the fixed serial number battery property,
- Fixed indentation of dt bindings example,
- Added property: reg and unevaluatedProperties to the connector
  bindings.

Bjorn Andersson (3):
  dt-bindings: power: supply: Add Lenovo Yoga C630 EC
  power: supply: Add Lenovo Yoga C630 EC driver
  arm64: dts: qcom: c630: Add Embedded Controller node

 .../power/supply/lenovo,yoga-c630-ec.yaml     |  83 +++
 .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts |  35 ++
 drivers/power/supply/Kconfig                  |  14 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/yoga-c630-ec.c           | 471 ++++++++++++++++++
 5 files changed, 604 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/lenovo,yoga-c630-ec.yaml
 create mode 100644 drivers/power/supply/yoga-c630-ec.c

-- 
2.39.1

