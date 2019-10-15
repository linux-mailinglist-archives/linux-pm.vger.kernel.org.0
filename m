Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4356D7B4F
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2019 18:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfJOQXk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Oct 2019 12:23:40 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:37501 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387872AbfJOQXJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2019 12:23:09 -0400
Received: by mail-wr1-f41.google.com with SMTP id p14so24618844wro.4
        for <linux-pm@vger.kernel.org>; Tue, 15 Oct 2019 09:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=At2DqHL0ULEbo28PWT+4kh8rdtcYy0zRsGcxpKfsRvo=;
        b=aHmAbdbiM4ZWtHLyoRLNmPSKJuGRCmiTdkpRf8WjvsiCX/URpSq66qVJM9NxTsXmLY
         w0tLE3GtdgXe2o4UTpGR5Q84VS6NegWrT9j+g6sqP0mswC9kfmLMSU181sq/Vc/SlQ+2
         cLX/MkSijLN2tGx8/wZ6/zTxyOboUkmvu4YXtvn1as37a84zM/3gTkSBjfsvyS6lVKLe
         LRyGKhq5JjXrz9k/DxwJVxNUMOOXRG2OmYgVI0HsaulfmJI3KqpGF4X2RRiIPJyc+jPM
         vZCLic5TJMVSsNJPXkixTK5y5Lf/Hf1z7GDoIKFpf9HekSNPlsIyUzHR2dCEp9CjMbEE
         9D9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=At2DqHL0ULEbo28PWT+4kh8rdtcYy0zRsGcxpKfsRvo=;
        b=bKBa0f6dzf4nHkuSRmZMxAm9EA8Qh++viw9DBeMCds6R5vMb3h8D9fnUm2xuqdUZQ1
         VMMGoyTwK54K9ZJZJ14xd59rXJ3Um2lWDVdZZKuc5fZquIAfXTNxGh4MItTp9taS4P6P
         pz2DLZSMeUz2EtjYXK1AxkAKwjnPpDG46/SkVbPlAbjlNwgVImcPeMIBarMxVd6Rh2po
         fzEJYb5RbLd3QZSR93aF7JzoJpXlT3gP4+gC56sJ9Bwf2oB+UQgtqD/hGud6DKEqDtCd
         m79XapMlQrDgEczxZUEaFKuPsxzH8ZVBJlqvlst+9bATT1A547Bisj/eI//pXtq0VeGh
         TR7g==
X-Gm-Message-State: APjAAAWEcyjZP5S+AFkw1FUsnV10xKFyaFLyZYA0hLVP6vFl1tH5XLdE
        OEikC0JY8LtzH/zMDU2NVSqSzw==
X-Google-Smtp-Source: APXvYqzwtJVnM0+sB/QY9mFpWS8ak0T/l8lL1nG68KLspWgJQBslTm9u8o7QI4CvpIdKwf3Ee0Y3lQ==
X-Received: by 2002:a5d:55ca:: with SMTP id i10mr21686396wrw.12.1571156585435;
        Tue, 15 Oct 2019 09:23:05 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id x129sm41427605wmg.8.2019.10.15.09.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 09:23:04 -0700 (PDT)
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
Subject: [PATCH v2 0/6] dt-bindings: max77650: convert the device-tree bindings to yaml
Date:   Tue, 15 Oct 2019 18:22:54 +0200
Message-Id: <20191015162300.22024-1-brgl@bgdev.pl>
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

Bartosz Golaszewski (6):
  dt-bindings: mfd: max77650: convert the binding document to yaml
  dt-bindings: input: max77650: convert the binding document to yaml
  dt-bindings: regulator: max77650: convert the binding document to yaml
  dt-bindings: power: max77650: convert the binding document to yaml
  dt-bindings: leds: max77650: convert the binding document to yaml
  MAINTAINERS: update the list of maintained files for max77650

 .../bindings/input/max77650-onkey.txt         | 27 +-----
 .../bindings/input/max77650-onkey.yaml        | 43 ++++++++++
 .../bindings/leds/leds-max77650.txt           | 58 +------------
 .../bindings/leds/leds-max77650.yaml          | 82 ++++++++++++++++++
 .../devicetree/bindings/mfd/max77650.txt      | 47 +----------
 .../devicetree/bindings/mfd/max77650.yaml     | 83 +++++++++++++++++++
 .../power/supply/max77650-charger.txt         | 29 +------
 .../power/supply/max77650-charger.yaml        | 42 ++++++++++
 .../bindings/regulator/max77650-regulator.txt | 42 +---------
 .../regulator/max77650-regulator.yaml         | 51 ++++++++++++
 MAINTAINERS                                   |  4 +-
 11 files changed, 308 insertions(+), 200 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/max77650-onkey.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/leds-max77650.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/max77650.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/max77650-charger.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/max77650-regulator.yaml

-- 
2.23.0

