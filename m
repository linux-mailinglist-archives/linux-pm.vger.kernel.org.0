Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB5CBE6CCF
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2019 08:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732467AbfJ1HTv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Oct 2019 03:19:51 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46795 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730751AbfJ1HTv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Oct 2019 03:19:51 -0400
Received: by mail-pf1-f194.google.com with SMTP id b25so6265602pfi.13
        for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2019 00:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ruFTA66AHlVe9lksioBMwwIdADskrYqVYX9wRS0DjSA=;
        b=vTL+jOMSUKziFxGvmULpDuosEPrE9KNb5fxyiR+KvMpwfnMbiRIvHpP2o5MjkeTB7D
         p9IzmnmSdzH9Ebhsgv9/FEJ3GvtMf7K0tcnXKQUEuX02OlyaqugYFxSTQoFmQ8ZVki6R
         oms977+Ts142oOpF5S2arRJX+8lgoKQAYGD23LlOqe4Fo/ZNpttBx6kqD2o1kJBUjj9G
         gCQKnJxj+vAPwE0GDYuhcZj9GXOEQJS0u2ZDtQYOwt2kq74qAJ0UDhKxoMBgk2SutMI1
         8XCULjpZnMYTYz+Cvs0NaAyWVsjaeDwquo63f33xc4yZrvZ76gbBILwyNUGSLaNNN+Dk
         iPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ruFTA66AHlVe9lksioBMwwIdADskrYqVYX9wRS0DjSA=;
        b=sF47JvwJlh6gZRIN+ozQRMFrxJvUufVBKPl0ILn0VKnF7KiBRCM/uB7p+YPXY4HDvE
         2v8R3p65hIF3MLw2z51sBS5M8yQNPWMQAjMJSv9Bt+FY0Qqy31hIz7BXwHSguLHKWb4y
         K8aXnCxfuSscaUoJAu7o8wfcTurFK6aFvuFIiGDsB//oai76GPUPgJlvVsOnKbGBvEkS
         QJRpxBDkuaixbqeTs1dA46iI47xaOtzpOebTQWd5f7obx6sLYUZvcQbRpiuieDnLEFLN
         zxbY/B/CrYlLrBc1JaeQNr2CdpfPkhlixi352KUGpFEU1TtnXu5EO0V9xySXLPZ+WfC9
         IZzw==
X-Gm-Message-State: APjAAAVnuLEY2XMfMjPcCr5DHP7Vh6Ipyj5ffaP2NDIhwPZ0Dm80/Wkn
        g0Yz3bwJhTcRRaS0BaC/Zb8lbQ==
X-Google-Smtp-Source: APXvYqykCw0rNzi3pE0X43+v5Bhy9g1kQP5vUS1px1WVWvFUlOsJdC9QkPi2amj89VM5Vk26EpLSvw==
X-Received: by 2002:a17:90a:9a9:: with SMTP id 38mr10789292pjo.45.1572247190245;
        Mon, 28 Oct 2019 00:19:50 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 13sm11504703pgq.72.2019.10.28.00.19.46
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Oct 2019 00:19:49 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, baolin.wang7@gmail.com,
        zhang.lyra@gmail.com, orsonzhai@gmail.com
Subject: [PATCH 0/5] Improve the SC27XX fuel gauge controller
Date:   Mon, 28 Oct 2019 15:18:56 +0800
Message-Id: <cover.1572245011.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

This patch set adds one battery resistance-temperature table to optimize
the real battery internal resistance in different tempertures, and
calibrates the resistance of coulomb counter to improve the accuracy
of the coulomb counter.

Any comments are welcome. Thanks.

Baolin Wang (4):
  dt-bindings: power: Introduce one property to describe the battery
    resistance with temperature changes
  power: supply: core: Add battery internal resistance temperature
    table support
  dt-bindings: power: sc27xx: Add a new property to describe the real
    resistance of coulomb counter chip
  power: supply: sc27xx: Calibrate the resistance of coulomb counter

Yuanjiang Yu (1):
  power: supply: sc27xx: Optimize the battery resistance with measuring
    temperature

 .../devicetree/bindings/power/supply/battery.txt   |    5 ++
 .../devicetree/bindings/power/supply/sc27xx-fg.txt |    2 +
 drivers/power/supply/power_supply_core.c           |   67 +++++++++++++++++++-
 drivers/power/supply/sc27xx_fuel_gauge.c           |   49 +++++++++++++-
 include/linux/power_supply.h                       |   10 +++
 5 files changed, 129 insertions(+), 4 deletions(-)

-- 
1.7.9.5

