Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B317BDEC85
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2019 14:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbfJUMog (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Oct 2019 08:44:36 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:44304 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728784AbfJUMog (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Oct 2019 08:44:36 -0400
Received: by mail-wr1-f53.google.com with SMTP id z9so13813162wrl.11
        for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2019 05:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VpVTW+WZL6DdTi8R1egFqPRwhOG2T/BnlrI0vbGyKSo=;
        b=dr7wEaSY8UQJ/AGGF8UXvMrEs1GBk4PDp/qRe60BXnj7SOebY0ws+tP9IK08OXd3WA
         kJoq8fetsUi4FkHh+sBV/YmnRD6gIjEH4N1Am4Ke2muT28aQSeyApTI3r+2/dP9N+0t7
         onSwyMIwTu7ueIJ+elRnh3UjKkx+mEYmzWe1tFb7MvYeii774AU19xwhKT/Zt8V6uotq
         02Em+Q3qsSDWgWOGt+RSYtRMl1ZmT4ZbyjojQJE7RlUNLYaVhOzGY+ZEGj9ZKpTzwIOe
         gR5kB15y/ls8Ufg9q5zq1voYnC1BU+xBenMeFh562h8p/UmuHrVeS1dCHx8ihObV8JOk
         ZBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VpVTW+WZL6DdTi8R1egFqPRwhOG2T/BnlrI0vbGyKSo=;
        b=IYsCpxCEjDsjZfyIPTwerfniAzRX/tE9KDLC/hm0ftGQxo3lCWL5TAWh5tTr0vCv4f
         b9YQ8eeKozOFCjI6e6f8QEgRPuMBvm9WcxqWRg38mEPdwxU1qEe67xAIESFFiypPfu6F
         P2urpR076WIH0NvfAFRw5ZdBtoKUIMOQHViTFlwmYOTOJ3fweR7x8rQw3mGP9QNPm5JB
         h+Q5BnD/RSJqhVfE3idgT8TBekrm38ob1YwjMSRbjasCQOKTZEib4gI8rFifSyUNBx+G
         1v552uiN6Bq+EksgehzOQKgokgPh5n5UUmHArk+P30GFx43Do76aoCeH5oZD4ObyS8gN
         CfQw==
X-Gm-Message-State: APjAAAX8kHt7JCQtERySREd5jlM+12jNvWjYKLYOtgXWPOtcQxHbFY0S
        OVjgD/r7JfV06M9Gihpo5NC+1Q==
X-Google-Smtp-Source: APXvYqyQZq9D7JNE8PCA9bjbf3OX5gqPK3dKrKLOL8KxWrUV3Y0cO+9DD/86Di3mogYOVO6kiCvOTA==
X-Received: by 2002:adf:e2c5:: with SMTP id d5mr18874464wrj.283.1571661873402;
        Mon, 21 Oct 2019 05:44:33 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id a17sm10216150wmb.8.2019.10.21.05.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 05:44:32 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 0/6] dt-bindings: max77650: convert the device-tree bindings to yaml
Date:   Mon, 21 Oct 2019 14:44:22 +0200
Message-Id: <20191021124428.2541-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This series converts all DT binding documents for MAX77650 PMIC to YAML.

v1 -> v2:
- use upper case for abbreviations in commit messages

v2 -> v3:
- pull all example fragments into the binding document for the core MFD module
- fix all dt_binding_check errors
- add references to submodules to the main binding document
- drop the type for gpio-line-names
- drop the description for the interrupts property
- completely delete the previous txt files

v3 -> v4:
- remove unnecessary parts of descriptions, added details on the chip
- correct file references (.txt -> .yaml)
- fix mixing scalar and array constraints
- dropped type refs for globally defined properties

Bartosz Golaszewski (6):
  dt-bindings: input: max77650: convert the binding document to yaml
  dt-bindings: regulator: max77650: convert the binding document to yaml
  dt-bindings: power: max77650: convert the binding document to yaml
  dt-bindings: leds: max77650: convert the binding document to yaml
  dt-bindings: mfd: max77650: convert the binding document to yaml
  MAINTAINERS: update the list of maintained files for max77650

 .../bindings/input/max77650-onkey.txt         |  26 ---
 .../bindings/input/max77650-onkey.yaml        |  35 ++++
 .../bindings/leds/leds-max77650.txt           |  57 -------
 .../bindings/leds/leds-max77650.yaml          |  51 ++++++
 .../devicetree/bindings/mfd/max77650.txt      |  46 ------
 .../devicetree/bindings/mfd/max77650.yaml     | 149 ++++++++++++++++++
 .../power/supply/max77650-charger.txt         |  28 ----
 .../power/supply/max77650-charger.yaml        |  34 ++++
 .../bindings/regulator/max77650-regulator.txt |  41 -----
 .../regulator/max77650-regulator.yaml         |  31 ++++
 MAINTAINERS                                   |   4 +-
 11 files changed, 302 insertions(+), 200 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/max77650-onkey.txt
 create mode 100644 Documentation/devicetree/bindings/input/max77650-onkey.yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/leds-max77650.txt
 create mode 100644 Documentation/devicetree/bindings/leds/leds-max77650.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/max77650.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/max77650.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/supply/max77650-charger.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/max77650-charger.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/max77650-regulator.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/max77650-regulator.yaml

-- 
2.23.0

