Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1595113C33
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 08:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfLEHUM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 02:20:12 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:48307 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfLEHUM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2019 02:20:12 -0500
Received: by mail-pj1-f73.google.com with SMTP id o34so1296861pjb.15
        for <linux-pm@vger.kernel.org>; Wed, 04 Dec 2019 23:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:cc;
        bh=FNNXF5sUDk2To9IrnQY1hGu8S5uYxVxFAu+jBAyZens=;
        b=b92J8jdHjDyp2TLoSTYcNkHxDjlQ5qxZ7Da03+LrBT04ke/jGvQoONMdEk5oSvIRTl
         CEKhj+dtAbAp6OmO3IePN8x23GL1nzmoG1zKRKbv9lLY+jhyfeLFMLADUDjyuksd9jc6
         k2qF+K82+KbAcSIbPhJaDBl3AccamQ9BXV6cyZTeIJIT/gL/iHaj8q8K0GeVA473uWsa
         DDPCe++FW0h4Aa3DiAoJLWnNbkuh0BiLV7s94B8DR0efpZarhGZiNSkqCxK/TjjA7gr8
         kzVDzv97h9o8PMPdVnVy4lFklDND5JFoMDHrX2OJvB59HHeS4qn6t2c7dOUjg3DGkMEE
         Dbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=FNNXF5sUDk2To9IrnQY1hGu8S5uYxVxFAu+jBAyZens=;
        b=lbbGq6yrl1fx4QH0PMn33nHAHCMh9Ch7gF02Q5ox2Pd2gMyKrP//Jyn1GEuzbFFtRw
         TkKHIp3pT/bHa0XO4gVMCZnuWAD+2DEPRAy3B/DLrU1cUFLxeNr3xPb2c0CcotAFbPh2
         E/wVDgupd2bnaJGyI4IYn6qTSZQO/CcW+rCp5d8GGHqELEsaihFK7MUAb1CgW9vB84sm
         FgCO+ncvURh8g/9YLF+bsRJAFRKTz2+11ZWDCjOcyAo4v9OyNS3YKch29djmkfSojpvF
         lcT+qY1ziY43CaCpcqCDechwe60tnefIvYbqvyUUZvqEGpx8GH/7Klxf/NoHExvBrhUK
         FrCQ==
X-Gm-Message-State: APjAAAUIPPfDhSOi7VoMUXWnBuSsJlkBJcwc+KgJ6re8G1eYBXcnoHuD
        l6NfJ73EFQNad4jMPVvx7XBaPCs=
X-Google-Smtp-Source: APXvYqzfr1djZRzCLhdN2stJ/Dej4cwmyYyYT2uv32U/e5C4i6hrYuFKOIEW+kE0Fwc/GDHzVHDp860=
X-Received: by 2002:a63:4303:: with SMTP id q3mr7864698pga.439.1575530411658;
 Wed, 04 Dec 2019 23:20:11 -0800 (PST)
Date:   Wed,  4 Dec 2019 23:19:50 -0800
Message-Id: <20191205071953.121511-1-wvw@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v3 0/3] thermal: introduce by-name softlink
From:   Wei Wang <wvw@google.com>
Cc:     wei.vince.wang@gmail.com, Wei Wang <wvw@google.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The paths thermal_zone%d and cooling_device%d are not intuitive and the
numbers are subject to change due to device tree change. This usually
leads to tree traversal in userspace code.
The patch creates `tz-by-name' and `cdev-by-name' for thermal zone and
cooling_device respectively.


Changes since v1 [1]:
 * Split cooling device registration into a seperate patch
Changes since v2 [2]:
 * Split improve error message in thermal zone registration

[1]: v1: https://lore.kernel.org/patchwork/patch/1139450/
[2]: v2: https://lkml.org/lkml/2019/12/4/1291

Wei Wang (3):
  thermal: prevent cooling device with no type to be registered
  thermal: improve error message in thermal zone registration
  thermal: create softlink by name for thermal_zone and cooling_device

 drivers/thermal/thermal_core.c | 55 +++++++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 11 deletions(-)

-- 
2.24.0.393.g34dc348eaf-goog

