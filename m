Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 133F511BDF0
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2019 21:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfLKUb4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Dec 2019 15:31:56 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38414 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfLKUb4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Dec 2019 15:31:56 -0500
Received: by mail-pl1-f193.google.com with SMTP id a17so39121pls.5;
        Wed, 11 Dec 2019 12:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3/hSvLwudWoN+XB6HWteXACnz1YCPLXglnwpmxopZ+U=;
        b=orgHVXb3Fpmfg7W8yttF3NemcT87svc1e27QdNm2SE6bOsNJk83szXiD4eT3iS6Cg0
         zpj9sfIWomAbpFUpRGeXDHCLV/yulMMmqhKceF1wYi0olUR10GZSjm/wpHjzYFmjHuUD
         eRBQa+aXghUUtmZSGpJv8ICRRkg9Lz87i9GEn13ahz63SWSsvPMjOwDrAjPEYX+mWKai
         OehB+EhlcdWumJ8b7TpB+LkoN21NJY5y3+5X8hdYYIkwCVbAxiZQsWUitSauCb2Lqktu
         ecZ/wVBxiUXVxDPDo9hCZLlYx0aNgVfZkI/M8ymac0NMVwLLNHxPEzj/vmlI20vszSRh
         OP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3/hSvLwudWoN+XB6HWteXACnz1YCPLXglnwpmxopZ+U=;
        b=PgvXlQyUEL/wfRfIp7KfkRT76Hou0RK/U/EU2A/ohceU+y5YoccAnkSwi7nbkpc8RA
         aMUzSJ8oKj9Ackf+Ux88RuoOa6RA9FC4NS2lE+VerWkhb72XoM3VqOBBl1M4Edx0Q4HN
         MJwJWwsPnsU2Z7agDHGTWobpuvN75JTDqO5rd9GogR+Jy+sBw9k08Y9WPC2xH+QatsCm
         GDY9sZFA7tp3NqqTAU4l2iz1FO9Q941HcA9unMUEJ4VZtXzS6/ni0Gkz7ORx006/oci/
         KkUR4E0kOapaHCmCrCx0frHEe0SrxxcEXb5sUbfalUGBQYolls/DUZn1AAISqTyQVU+1
         nScA==
X-Gm-Message-State: APjAAAXk6Rl5bDZIP2xSctqTChinRqNnVeWZmFf9HMjZ66v+MSyu4QLf
        vHrMQoGcJg8yFXxDcUJYoHM=
X-Google-Smtp-Source: APXvYqz9LDJfuBSN3rWSsIsBVJ8ollAAEg3nqsBeGqaPCp5Jf59583LSmX1aTye4SdtIkza1iG4nGQ==
X-Received: by 2002:a17:902:7207:: with SMTP id ba7mr5476246plb.254.1576096315871;
        Wed, 11 Dec 2019 12:31:55 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a19sm917570pju.11.2019.12.11.12.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 12:31:55 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org, daniel.lezcano@linaro.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM STB AVS TMON
        DRIVER), Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-pm@vger.kernel.org (open list:BROADCOM STB AVS TMON DRIVER),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 0/6] brcmstb_thermal updates for new processes
Date:   Wed, 11 Dec 2019 12:31:37 -0800
Message-Id: <20191211203143.2952-1-f.fainelli@gmail.com>
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
 drivers/thermal/broadcom/brcmstb_thermal.c    | 99 ++++++++++++-------
 2 files changed, 67 insertions(+), 40 deletions(-)

-- 
2.17.1

