Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3816713B298
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2020 20:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgANTGY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jan 2020 14:06:24 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43562 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgANTGY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jan 2020 14:06:24 -0500
Received: by mail-pg1-f195.google.com with SMTP id k197so6815728pga.10;
        Tue, 14 Jan 2020 11:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+hPubKNXoscOquUFuUg8wCoFmK2UJGRL5czKa1SRJrg=;
        b=pqIDTum/4xK6Gk4dpSXs6uOcELVtrOjobja0bYjtq+TW0v0ptivJ3PzVORm7lMjVl6
         cwxPQlxjqgwWZdWyDfQDiAN+NbOYAq0r23n59uxmbTJsy1uezEWh6LpwwRg5vWLFjhHr
         1GCadP27R7lpu2NAfVuTA67uqCFfUY+cFp8IPEPrEOLQS4PA4mbd3x20+HNP35r9GT+H
         vqijWp83vVzIcfYCWdvQFKn47/tbHOs3BZEy2mBND12QS1sJcNyYb7Kuc8LZXBDxxrpz
         n4sW/TxNr2Jxm3Zy8TA++Dn9MzmUWtfdUAlchgD3GdPLQMhnzpD8Of4de4iQSE5uuBY2
         ALzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+hPubKNXoscOquUFuUg8wCoFmK2UJGRL5czKa1SRJrg=;
        b=MlqXtolzu9xhnYN36vsKieyOVV1/6RyKhBDQjw0uf87xogYYGKCvaNP5Pmocc2zBKK
         A7EWUnkesWYdVK76HN8afvBwWnYHo1becUX9nsAZ8HuBZP8oXMJ6dmtRJlCBl/zgeu2G
         7x12pfri1PnJAGnFd0mTo+NOpcktPU3ct1ivPo2sgZq3PLUUdvRz/FAo9zU7zDtmC0vC
         nDTimKXtVukioz0DBin1T7ny1ZFIoLypcQCDkTf/6fdgxFE1EM6CU70nymOlE+tph6h/
         EF8l1cdLC43ScZCW7oLDndV/13zjwtuwNyY/8wl6m4moN2UZ1aq26QK5j+y/KkUIqMRI
         7wkw==
X-Gm-Message-State: APjAAAX0JnAAkbIUe8V7mKQ1Rtvms20Yv1UJPXTYDwtsyX6lJpDxuniT
        XMehZ1aQSWsojS6GMlTYfUq6RlwO
X-Google-Smtp-Source: APXvYqy+K/IGJGx+SwbNg1zLTYiArYpJ71V2j5GV9N0ZwFn68QJAk7EFMvUS3kFclpBAcrTbht+djw==
X-Received: by 2002:a62:5343:: with SMTP id h64mr26058168pfb.171.1579028783171;
        Tue, 14 Jan 2020 11:06:23 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a195sm19284528pfa.120.2020.01.14.11.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 11:06:22 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM STB AVS TMON
        DRIVER), Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-pm@vger.kernel.org (open list:BROADCOM STB AVS TMON DRIVER),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH v3 0/6] brcmstb_thermal updates for new processes
Date:   Tue, 14 Jan 2020 11:06:01 -0800
Message-Id: <20200114190607.29339-1-f.fainelli@gmail.com>
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

Changes in v3:
- do not change AVS_TMON_TEMP_MAX with AVS_TMON_TEMP_MASK
- use of of_device_get_match_data
- maintain function pointers back to of_device_id::data

Changes in v2:

- kept defined constants in patch #1 and keep using them for subsequent
  patches
- add Reviewed-by tags to patches #3 through #6
- rebase against v5.5.-rc1

Florian Fainelli (6):
  thermal: brcmstb_thermal: Do not use DT coefficients
  thermal: brcmstb_thermal: Prepare to support a different process
  dt-bindings: thermal: Define BCM7216 thermal sensor compatible
  thermal: brcmstb_thermal: Add 16nm process thermal parameters
  thermal: brcmstb_thermal: Restructure interrupt registration
  thermal: brcmstb_thermal: Register different ops per process

 .../bindings/thermal/brcm,avs-tmon.txt        |  8 +-
 drivers/thermal/broadcom/brcmstb_thermal.c    | 96 +++++++++++--------
 2 files changed, 64 insertions(+), 40 deletions(-)

-- 
2.17.1

