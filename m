Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3801C2E2549
	for <lists+linux-pm@lfdr.de>; Thu, 24 Dec 2020 08:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgLXHuI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Dec 2020 02:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgLXHuH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Dec 2020 02:50:07 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CC9C061794;
        Wed, 23 Dec 2020 23:49:27 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id b8so955332plx.0;
        Wed, 23 Dec 2020 23:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SlolyWi3tYq1xjC+al0ttrUuofdE52UVAA6blmH9sEM=;
        b=eTO6Wl+eK8gwXywAW6K3qck/icFb64N4GiVqAC6ycJ0TvwhrHEGsqxJTc28XXz8UQh
         sQ+4XClMQ4xTmp8MeCoIn9nfIP5NrZUk5xXcgaiGlPy2ojq8RkJn2ZmSQ/c4hcWWa/tM
         +fOX5ycpLqJ+zQbLWj13ir6d8v4PisJ3h/qyr2wwjo9qQ5CtOD9sapYerjRgzJjRE5mR
         AmB3fWQSqFtF4+4hXnKWYIYccmbTWy8hrpbYLR7R/7Z4NoxlGFy2SCF2GFSnP5A65pWF
         581q1BaK0rteZyOJeidlnIPsc3+TxR0VDYq290OuokHMBqIEL5/cXWkF6MOd3Vt8VC+4
         08Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SlolyWi3tYq1xjC+al0ttrUuofdE52UVAA6blmH9sEM=;
        b=XQlQSJAUC5DjcGsmJHGXLnw1/rxH6mYRr0b7YUkHrS76XhYgIac5ShjoxJch9ht2yz
         cJ4tk/qxlWoJHZw0gMny6dGEz2YslXqtI9yUfK42oI4+n9KRhwKGlOHmgwpmRXeCeg6t
         1c/frDNGf6Ttqqz5feEx1DJ5L58Op16Sle6XkIQ+frhT46KwY25Q95dvmHmEWnqypD6y
         xXAJp1oSpVmcIiB0PvVvWTZ7P8+4sMaif4+YSO5grnT/ag+E6O8iGZ9ZO2YBNsIAsY13
         8m7QEVYUU3fsw08gBBbo1NrLhtH6nRPIVIxICDmPhEfXUB5lFKM7oY5TQUTkexKLsBcB
         BFmQ==
X-Gm-Message-State: AOAM531oxUCeNHXGZUTwoUCzpmNN6QyM8HTHFrwDXyINE8qWNhAX6aPx
        h6OpKAfR0zVP5zjIMDbt0FI=
X-Google-Smtp-Source: ABdhPJyi/7Wn4+jU196A5/CLHyiFSodaESpmG4ccXdU5u3v9F0vaAteF6Thcaq8a0pY4cd4y/bGevw==
X-Received: by 2002:a17:90a:a382:: with SMTP id x2mr3320685pjp.178.1608796166985;
        Wed, 23 Dec 2020 23:49:26 -0800 (PST)
Received: from localhost.localdomain ([2402:7500:492:86cf:7e4a:b265:b394:eefd])
        by smtp.gmail.com with ESMTPSA id y9sm1743507pjt.37.2020.12.23.23.49.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Dec 2020 23:49:26 -0800 (PST)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     sre@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH v3 0/2] power: supply: mt6360_charger: add MT6360 charger support
Date:   Thu, 24 Dec 2020 15:48:02 +0800
Message-Id: <1608796084-29418-1-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch series add MT6360 Charger support contains driver and binding
document

Gene Chen (2)
 dt-bindings: power: Add bindings document for Charger support on MT6360 PMIC
 power: supply: mt6360_charger: add MT6360 charger support

 Documentation/devicetree/bindings/power/supply/mt6360_charger.yaml |   48 
 drivers/power/supply/Kconfig                                       |   10 
 drivers/power/supply/Makefile                                      |    1 
 drivers/power/supply/mt6360_charger.c                              | 1022 ++++++++++
 4 files changed, 1081 insertions(+)

changelogs between v1 & v2
 - Add binding property with unit and custom name prefix
 - Remove extcon device, redundant brackets and interrupts
 - Fix power supply prop "charger type"

changelogs between v2 & v3
 - Add register selector to value mapping

