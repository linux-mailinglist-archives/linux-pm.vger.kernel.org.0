Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17F49DA606
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 09:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407944AbfJQHMl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 03:12:41 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:40822 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728295AbfJQHMl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Oct 2019 03:12:41 -0400
Received: by mail-wr1-f53.google.com with SMTP id o28so1001316wro.7
        for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2019 00:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ycUh96qu7Qeb2/OqBRaIXG5bF+f+x1C5nZ4WXE/7KGs=;
        b=ETXvlQBJ3Y5EkrhzyFRZRu+ng3aMpSuYl30Vc47qL1j2DslM1Vk1igbKojGQ/3yaug
         tUwSfQLld8axTYQjQYdhv7j3D5AnXc/O1kUfYKmtBDthY7Y3O4tREApuGP283V82ibwI
         6gVRo8cKQkB77NTN2fuZJjNkBjuSNDdkkCY0cWAoXMQV6lw3ZlwlAwBIm6e1Tv4ffYyH
         QS9tqCiiZsOWtxuAOp24wmYfxDFIHnIb0XSZAPLTdJO+ehPbE090wF8hsdAwvx2IgW8s
         hwKeqRqTG62NRRgtIokbPkim6SilSiJsr3Q8jOVgoRoHCLfuG+C+GofArRlH5tdI+ODF
         9nDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ycUh96qu7Qeb2/OqBRaIXG5bF+f+x1C5nZ4WXE/7KGs=;
        b=HkKr42keBjW8rGJcM6e6ICrNupTwZAt51dxEB4X0vhKdCjH4sPLF8SZISOQHFHoWHH
         rZEj6yEX4TXtGxsOBIeNX0y4cUUqEx8/94rwKuFMagpGdDvH6kSsNuIsVC498hZDANrl
         ehXoLVWEcmbwBK3pKlwH2eYYbc6VN40MSjBXz6NdvRlpcNYX6oCZCN63iPxhxqwKww/w
         3gvkLxYcE2Z9MwA2koO48pBTptLqSxN1Y9o9LQIOn3eqis5yYt3rLtqcPSg/D/JEYBo8
         s2ChLwGj9gJLwvYMJC8oEbKcE6kM6v33j0I5WKnUSzP3YWd9sK0Pcnc7qDVmfSMkFjeG
         wv1g==
X-Gm-Message-State: APjAAAVZAZOl1JrStxpT++zRQsoYwkJh/7vVfGB60WQC9u7TqgSqUdOD
        4iGuSAp3T7kqak+mAVJ44qZkfA==
X-Google-Smtp-Source: APXvYqyuEmEGEmZzcCODblXwV4dNYq8zprqYQKx4JnNQqfOFIAWHDrLQ+JHpjgaTLWfh5BR86lOdcA==
X-Received: by 2002:a5d:5587:: with SMTP id i7mr1371578wrv.289.1571296358768;
        Thu, 17 Oct 2019 00:12:38 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id n22sm1156689wmk.19.2019.10.17.00.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 00:12:38 -0700 (PDT)
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
Subject: [PATCH v3 0/6] dt-bindings: max77650: convert the device-tree bindings to yaml
Date:   Thu, 17 Oct 2019 09:12:28 +0200
Message-Id: <20191017071234.8719-1-brgl@bgdev.pl>
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

Bartosz Golaszewski (6):
  dt-bindings: mfd: max77650: convert the binding document to yaml
  dt-bindings: input: max77650: convert the binding document to yaml
  dt-bindings: regulator: max77650: convert the binding document to yaml
  dt-bindings: power: max77650: convert the binding document to yaml
  dt-bindings: leds: max77650: convert the binding document to yaml
  MAINTAINERS: update the list of maintained files for max77650

 .../bindings/input/max77650-onkey.txt         |  26 ---
 .../bindings/input/max77650-onkey.yaml        |  35 ++++
 .../bindings/leds/leds-max77650.txt           |  57 -------
 .../bindings/leds/leds-max77650.yaml          |  58 +++++++
 .../devicetree/bindings/mfd/max77650.txt      |  46 ------
 .../devicetree/bindings/mfd/max77650.yaml     | 151 ++++++++++++++++++
 .../power/supply/max77650-charger.txt         |  28 ----
 .../power/supply/max77650-charger.yaml        |  34 ++++
 .../bindings/regulator/max77650-regulator.txt |  41 -----
 .../regulator/max77650-regulator.yaml         |  31 ++++
 MAINTAINERS                                   |   4 +-
 11 files changed, 311 insertions(+), 200 deletions(-)
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

