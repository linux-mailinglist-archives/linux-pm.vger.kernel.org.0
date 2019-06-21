Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 399F54E765
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2019 13:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfFUL4L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Jun 2019 07:56:11 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40840 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfFUL4L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Jun 2019 07:56:11 -0400
Received: by mail-lj1-f194.google.com with SMTP id a21so5697902ljh.7;
        Fri, 21 Jun 2019 04:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ugUVWXWMVXcaAwnseDuI0N6YdKSEHVPEFC1bDrIcGrs=;
        b=RGgmEhyFGECpAX+cM76C3DLVWvacbPO0qzf1TElpWEFkkRvs/u5H8I6rxdnvgp+o5f
         15cCkWOBbCsjpkb/ktIiR/6DCmQ8MIPTA9bLDofrd83I9p5oP3SM7BkZ6LpbINVTtmU5
         ldMNhOCAv7MQ1N8WruAxq1GQXNu3jQASIAvdBmj6eoiBEnQGUgk4+i4ZjmCKIFXrZkh3
         X4NtfKQogBF1bJ9ILMHoHclxs2/ij28CGOInyT204IrF9J5j6V+0kefB2O7Bj9BV30rO
         UxfL7sD2+Er11blPRN/ri8LkuM72jZQSX36FmOPxVQMyK8j20s3p4hsQDtJRKU067wTc
         LlfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ugUVWXWMVXcaAwnseDuI0N6YdKSEHVPEFC1bDrIcGrs=;
        b=uWSeNwbxhKV4XNEr8EVNFLbA5fxAMOHnne5HLX3LcDylcnXpFBqw/j1JIPyThEJdXk
         6H8EkHgUi4G1VwGK17jNiYxssaDGTaq4CTlJgKgpSfAVincMIkvIkPq3gW+OjlFZ5DdO
         Mo1Jal1pDUC+GMNgsmS8Va0lpU+sY0mXX3PM865gOnhXsS1I2Q2L2rVCgU73GyREbd/3
         8fH3b6eGg83oYTv9aDaOEx7irCyfYq16QbotjssRyEO36gdHJFgTZwOCvQH1kXqr5hRz
         uKMgY4PeHPt2EzAApxgP/mCCD+l17X6QwxAkUABiMC2kdBOSwttkCKcnkCdnvO9By1SA
         U0kA==
X-Gm-Message-State: APjAAAUvoe9W2oHU9chQ4/xTtX7Hg7BGOHLaXAMqUw9kfxuV+N1mh05J
        Z4OipnY+yUx9hi7acSjElVHgq1o6
X-Google-Smtp-Source: APXvYqwIMPNIKRN928QP9Aq4yj1J80u+3cYzgmA6mPWfSmN771PQsdn/wsJQy0q6UK3P1WtqHYBK5g==
X-Received: by 2002:a2e:5b5b:: with SMTP id p88mr62453859ljb.192.1561118168864;
        Fri, 21 Jun 2019 04:56:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a315:5445:5300:a5e4:32fe:c6e4:d5eb])
        by smtp.googlemail.com with ESMTPSA id s14sm356791ljd.88.2019.06.21.04.56.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 04:56:08 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     sre@kernel.org
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v4 0/2] power: supply: max8998-charger: Device Tree support
Date:   Fri, 21 Jun 2019 13:56:00 +0200
Message-Id: <20190621115602.17559-1-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch series compose of 2 patches.

First patch, updates max8998 charger driver, so it's possible to parse
devicetree for configuration.

Second patch, updates max8998 documentation, so it includes new node 
and properties, needed for charger.

Patches has been tested on, Samsung Galaxy S (i9000) phone.

Changes from v3:
  - Property prefix should be maxim, not max8998
  - Changed property name to more meaning full
  - Describe what End of Charge in percent means

Changes from v2:
  - Make charge-restart-level-microvolt and charge-timeout-hours
    properties optional. If they're not present, assume they're disabled.

Changes from v1:
  - Removed unneeded Fixes tag
  - Correct description of all charger values
  - Added missing property unit for charger properties
  - Removed already applied patch

Paweł Chmiel (2):
  power: supply: max8998-charger: Parse device tree for required data.
  dt-bindings: mfd: max8998: Add charger subnode binding

 .../devicetree/bindings/mfd/max8998.txt       | 26 ++++++++
 drivers/power/supply/max8998_charger.c        | 60 +++++++++++++++++++
 2 files changed, 86 insertions(+)

-- 
2.17.1

