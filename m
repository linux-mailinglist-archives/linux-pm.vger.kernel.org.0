Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5793648B474
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jan 2022 18:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344702AbiAKRu7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jan 2022 12:50:59 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:33014
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344709AbiAKRu6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jan 2022 12:50:58 -0500
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B14253F198
        for <linux-pm@vger.kernel.org>; Tue, 11 Jan 2022 17:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641923457;
        bh=2zXFpgoXA2AXkam+aZqI+1j2Yu5tLuHo5Qd504tYlzY=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=nVPvZHtuC3Eut9zE/5H0IExv07HWxVPXU9LcSKiOVNEBz8GeCnkGlxGHzIFMBIYLl
         2QcWKt6j5DRumNZsdN6rxBCBJXLhB3FgKxaGHuAW4YueGMg4trj7Eb6KZ+xeJYM4d1
         O6P9z87e3klHP5yaNQDVb2yMFaTIdOzxoCjMa8JBLJG4GyGl+PN4HTNKGgVxA8pqce
         +bQJv/4n038KwKBI4+OsfUoSTpAoHQMYBV99CFx8bppUsifwevhRC7dCM6We5gk/LX
         RbNFLKxxfp8u5qZLx6coCBlRppDeSAZVhO76r7jItBl5r55jpQ2qjt4xL2f6FcRUM/
         DUj0CBsA6/lJg==
Received: by mail-ed1-f69.google.com with SMTP id m8-20020a056402510800b003f9d22c4d48so13979915edd.21
        for <linux-pm@vger.kernel.org>; Tue, 11 Jan 2022 09:50:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2zXFpgoXA2AXkam+aZqI+1j2Yu5tLuHo5Qd504tYlzY=;
        b=4GCoL9xTIr/kfBzE0K3E+ZR2K4XLp5DdbQQkrgAZvbANdWdMsEcpF0ynAl1NGEo7PI
         ebaZiBDc/6CbHzRHrCtl45+/TeWsEHVqAXAXONA9Cf+JBPS80a4X6o2ANgE8XGNwee5J
         +wlDaayzFG89T0RgsRVQBRpML31sX6BwYI/Tohr7eZ5I2G+oCXTdqbRcqcI4gnsW8LHH
         tnZgOUVmDzFv+5ZPXsxy3WR24mzFEJP8roVebq4r8OumEYiLUbVgPuRjuPmH88dkYBcI
         zA4DIIdZcgFf+2aMBPP7UPT+anjk97FnALWuAPGXjYzp/CopH9Fk8e2lAUGS6T9jaOLA
         cRww==
X-Gm-Message-State: AOAM533psX2ysGHmXTeRpQWY7dbvY56NAqFwJ3zl7Xahyn9qIvsiCZmY
        w8vS30F9/LcyktR3czRJedO2tmEywJaBlZcz7s+uN5kfKB+bJ0cLeO6l9N1JI5nL9jyOx15Uegr
        E4WAXcooX5pq1BoEKMCmvBzI6hoBxgULbJ4Ex
X-Received: by 2002:a17:906:d542:: with SMTP id cr2mr4549402ejc.720.1641923457290;
        Tue, 11 Jan 2022 09:50:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw2kpeA+pUdy5877+VIewlMQ8JeCRKAjmwdHfgw9/xGCtPvVu0MeRfkkHiVU84kGG8jlZaRPA==
X-Received: by 2002:a17:906:d542:: with SMTP id cr2mr4549387ejc.720.1641923457123;
        Tue, 11 Jan 2022 09:50:57 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id p25sm5265160edw.75.2022.01.11.09.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 09:50:56 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 0/4] leds/power/regulator/mfd: dt-bindings: maxim,max77693: convert to dtschema
Date:   Tue, 11 Jan 2022 18:50:13 +0100
Message-Id: <20220111175017.223966-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Changes since v1
================
1. MFD: Use absolute path to schemas, add additionalProperties=false.
2. Regulator: mention all allowed properties,
   additionalProperties=false, add min/max values for voltages and
   current, don't use patternProperties when not needed.

Dependencies
============
The final patch - MFD maxim,max77693 bindings conversion - depends on
all previous. Therefore this could go via Rob's or Lee's trees.

Best regards,
Krzysztof

Krzysztof Kozlowski (4):
  dt-bindings: leds: maxim,max77693: convert to dtschema
  dt-bindings: power: supply: maxim,max77693: convert to dtschema
  regulator: dt-bindings: maxim,max77693: convert to dtschema
  dt-bindings: mfd: maxim,max77693: convert to dtschema

 .../bindings/leds/maxim,max77693.yaml         | 105 ++++++++++
 .../devicetree/bindings/mfd/max77693.txt      | 194 ------------------
 .../bindings/mfd/maxim,max77693.yaml          | 143 +++++++++++++
 .../bindings/power/supply/maxim,max77693.yaml |  70 +++++++
 .../bindings/regulator/maxim,max77693.yaml    |  60 ++++++
 MAINTAINERS                                   |   3 +-
 6 files changed, 380 insertions(+), 195 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/maxim,max77693.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/max77693.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max77693.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77693.yaml

-- 
2.32.0

