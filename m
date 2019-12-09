Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F12971165AA
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 04:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfLID5O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 8 Dec 2019 22:57:14 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35390 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfLID5O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 8 Dec 2019 22:57:14 -0500
Received: by mail-pl1-f193.google.com with SMTP id s10so5221215plp.2;
        Sun, 08 Dec 2019 19:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=b2DE6cCWenynH+3sM3YT1LF1L+GzZk/gsLFYvvT9TE4=;
        b=HNZv0zOE8dpgtmk2B3oPwnIYgyQaFVErECx5/4bdBiR8MXCFWi7cnDnB6wk1zX0432
         nc/LL9IaTGj24zce2GNyO6UDhOCmu7dbcYU+HUpNzizf1HSwMnQobBH1MkvKet8hIWiL
         gwgtgfr53bpBQ0FdymlUQDhdWSZTvkcJVZ+jlE3QTAKEcwTBne/ixmHeoN5vucOZbnDz
         QzXzt3vCBFTI88xqVhiZePxfZFKsL3wni9ThR5hTTkiUG70YIeUNtzPC2prm+RdAGb0a
         AGaZyP+40RX0jO+hNPe9FGzvMg7AbTdmtEjHTNQ+r96akB9V5R7N2G9vHEE9jk9E5pIK
         5tog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=b2DE6cCWenynH+3sM3YT1LF1L+GzZk/gsLFYvvT9TE4=;
        b=bWpmwZcQmGJaXBCD2miDm32kEpZUzfZmDhy3UENISXDYi/v91Kk+Ifvzd7EJToslEC
         Lq8wppypojRmenSeokIkUyEn5kdq0yHfryCBzhy7qGttecLixOj/TE9j7+LVMFZufL2u
         QtbKZZVeYDXBKrNKGqITPFRWyiJpGEEebelgjM8dJYuhRup8I8+3qDusrRbxHXUu1/e+
         hRYtYEJWrcZ2t3IXurVwRJdVJb3Hw95wKx1ZJfbiEYrwlcxU1fb2XwnnGxHVn7UVv8U1
         9EnXECJQD+QBqhjYmyAEsMb01rAiLzSKOwvVAJVKAqhINhY8qCH738JUSOjWh0BM80XZ
         9xdA==
X-Gm-Message-State: APjAAAWH0nQWUkZf9e69R6mTV99nsd0NMbdEGekIhHvGZX3FFkc9qWOd
        3fcjwbO2Mwdj3gPZBO8gQmA=
X-Google-Smtp-Source: APXvYqwCF8D/r1Qlk/+Xkao8PBRqa0aJvcYqEdYhDMbqWDnlAhDlI7G1GRZOja+9HFrESJ6AdzouhA==
X-Received: by 2002:a17:90a:21ee:: with SMTP id q101mr30050690pjc.94.1575863833276;
        Sun, 08 Dec 2019 19:57:13 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id b129sm24606111pfb.147.2019.12.08.19.57.09
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 08 Dec 2019 19:57:12 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, baolin.wang7@gmail.com,
        zhang.lyra@gmail.com, orsonzhai@gmail.com
Subject: [PATCH v3 0/5] Improve the SC27XX fuel gauge controller
Date:   Mon,  9 Dec 2019 11:56:20 +0800
Message-Id: <cover.1575863274.git.baolin.wang7@gmail.com>
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

Changes from v2:
 - Add reviewed tag from Rob.
 - Rebased.

Changes from v1:
 - Fix the order of values in resistance-temp-table property's description.
 - Add an unit suffix for FGU resistance property.

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
 .../devicetree/bindings/power/supply/sc27xx-fg.txt |    3 +
 drivers/power/supply/power_supply_core.c           |   67 +++++++++++++++++++-
 drivers/power/supply/sc27xx_fuel_gauge.c           |   49 +++++++++++++-
 include/linux/power_supply.h                       |   10 +++
 5 files changed, 130 insertions(+), 4 deletions(-)

-- 
1.7.9.5

