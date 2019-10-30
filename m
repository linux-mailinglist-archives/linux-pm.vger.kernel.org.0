Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28CDDEA326
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2019 19:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfJ3SVq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 14:21:46 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41136 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfJ3SVq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 14:21:46 -0400
Received: by mail-pl1-f193.google.com with SMTP id t10so1349997plr.8;
        Wed, 30 Oct 2019 11:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=m5V1c15U0TRN6vcPfIUexZJlP17sTsMG1spksDWqkgo=;
        b=VIYtnp2tw82TUaocPbDHIebvaM6KlLz6C/l7fT8PzqeQNmI0H+TPWMF/EmeD4WdzJO
         k1YC1RjTzBGMjHIo0QbbsAKn1/SgaRR0BlN1wku1+2W9TQNBg8Fbq2kgyQ28KCSaQj5H
         PdCUEacbKLwm6rE6FcUGzhH7fixaUBu3t143lVuAq8QHm6m8KQBZ1Dx3G4dn42t+Zz/2
         dbkzOnaSwRhOMq/GM53ACClQcNFPHV1NhH7BROnh1onPesk1t3nnKCMCWhxuNk3vW9Wh
         9fQ2KqmF8+Az5hvlsGD61dZ4VAXRmI2z0yCeMZyi+fU6BlYo4QnSMlC42B0Gt2MTpTST
         J34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=m5V1c15U0TRN6vcPfIUexZJlP17sTsMG1spksDWqkgo=;
        b=KA5yW/Gfc2sPayxdNLZmjGpW1FhB2HL5FpQzfCkwfVgIiY3oORjsuL57DScH05Rj/R
         ggMrpu3uYeSyq3HSzZme3NczNwBOxvO1h3qFHoRluIE5uz0qcEiTfckfKzw5T/dqsniG
         WZNnIsFIaFHEqYMkyfA9mefyWjcwW+nHJxDMfl/wJ9RwTwxhRRB3mEA2UsSCoBFvhutj
         BjCN9xUGNS/NduFpbzeK0FscQTpOmUBtmPwWhH0WkO7i6tfy26/HdX+/EWRA/pcptmV0
         Z993Izi0dqJCcUS5H4VCsKp6NskH8d+g5mYpQOYYv4z7Fa+A6NFSDyjYrOQlHX56T4Tq
         7VHw==
X-Gm-Message-State: APjAAAUCu5SiHsd3vXwmfblLcJ6Lhda8QIrj0yWml1HHAkiINn7ICO8e
        BmUpoMAAYIY/c6RVaOLRC6Y5hvq/
X-Google-Smtp-Source: APXvYqwovkeawEjQc8Fpc4nu8GD5wMmrSR/nUwd//Arjwauo1SKoqktzbXGHyeUCWuR0WQRs5GRFPA==
X-Received: by 2002:a17:902:b7c2:: with SMTP id v2mr1464868plz.202.1572459704769;
        Wed, 30 Oct 2019 11:21:44 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z5sm521637pgi.19.2019.10.30.11.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 11:21:43 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM STB AVS TMON
        DRIVER), Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-pm@vger.kernel.org (open list:BROADCOM STB AVS TMON DRIVER),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH 0/6] brcmstb_thermal updates for new processes
Date:   Wed, 30 Oct 2019 11:21:26 -0700
Message-Id: <20191030182132.25763-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

This patch series contains a bug fix for the existing platforms and then
paves the way for adding support for Broadcom STB's latest chips in 16nm
processes, and finally updates the driver with pecularities introduced
with the 16nm, like the lack of interrupt notification from the HW.

Please queue up the first patch for -stable if you want, thanks!

Florian Fainelli (6):
  thermal: brcmstb_thermal: Do not use DT coefficients
  thermal: brcmstb_thermal: Prepare to support a different process
  dt-bindings: thermal: Define BCM7216 thermal sensor compatible
  thermal: brcmstb_thermal: Add 16nm process thermal parameters
  thermal: brcmstb_thermal: Restructure interrupt registration
  thermal: brcmstb_thermal: Register different ops per process

 .../bindings/thermal/brcm,avs-tmon.txt        |   8 +-
 drivers/thermal/broadcom/brcmstb_thermal.c    | 108 ++++++++++--------
 2 files changed, 67 insertions(+), 49 deletions(-)

-- 
2.17.1

