Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7EDEA333
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2019 19:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfJ3SWL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 14:22:11 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45806 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfJ3SWL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 14:22:11 -0400
Received: by mail-pg1-f193.google.com with SMTP id r1so1990118pgj.12;
        Wed, 30 Oct 2019 11:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3+WJZITHEScydX2UgU8wnfwVYy4vjzlr7uIujJK9hic=;
        b=NsVh2jqs6cpcVXqN9XUwDu1LIbUb3xENxLQxoDG8mViO2A+agXwhe3aS8BkRHjsJXB
         4KBEsZpbOHk1zIGNcYVbmNNGZr8XnI40pHE1AXOSFZ/OO/cILBs3zRmRjrdj1JBaRgqs
         E0jA2lh0I+mjtxSUWzDmaEh650tqvNt2nx1bmPhuZ0zGXYNNzLLFi7P8tEqFbzKjdFPd
         BUenvIwxxSjReMry8lJXaZVnQ7SxX8m0ZMXgYxA/NuKokUCbG+Jx9ajKgtRvtqkRBWOZ
         //Vp4Bk0EmsPOum7+O3P61sILtb/8fvCqYP1tkAnDGqqKIItX8Sobqbdld7o4Wc+s9Z7
         fhkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3+WJZITHEScydX2UgU8wnfwVYy4vjzlr7uIujJK9hic=;
        b=HbUi9J9m/or94Z8pH1Xwklo5UYkc7suhmnanlK2Rr+G51ZHNjS53l/d9RBdDP13yph
         3GnOVsdblnNL+f7p3eX+SsnbDW/CeaG9rkJDiCtSt2uwlFyzdPcGJq1w3Bgyo3uYSs1U
         SiWjLNMEY8TL3YagVdqfK/0gtkJtbBp7/eexjHDS6nKZyYFcG22frsenFkYWGgOGXc+U
         dI9DvylqmUQ5V6THN5KdfYwHwYUHCQBh0ne00YcJySX4tme5alHDcLpvikNhEuAFhAij
         zrZnTntCU1sUE4UfhNBSd0wf/louN378BAVNs3x1Et0C9OBvkCjAtHYuPRvjQEay1wkp
         YOWQ==
X-Gm-Message-State: APjAAAV/S9fadddL6f4KRhOw5lvt7KIUa1dEFb4Jr7Rp69Z0YeMRM9QT
        1wYsNRI1JwyNYRg7e/zTl5K9yZj5
X-Google-Smtp-Source: APXvYqzEOJDvlRsEdpaIpz0TiH5s2gJTnqNYLuN/D1JJ4h+Rh3lygNNSMKzWVm0azoAsKFm3sj/ubg==
X-Received: by 2002:a65:628e:: with SMTP id f14mr943359pgv.114.1572459729662;
        Wed, 30 Oct 2019 11:22:09 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z5sm521637pgi.19.2019.10.30.11.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 11:22:09 -0700 (PDT)
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
Subject: [PATCH 4/6] thermal: brcmstb_thermal: Add 16nm process thermal parameters
Date:   Wed, 30 Oct 2019 11:21:30 -0700
Message-Id: <20191030182132.25763-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191030182132.25763-1-f.fainelli@gmail.com>
References: <20191030182132.25763-1-f.fainelli@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Match the 7216 compatible string in order to derive the correct 16nm
process thermal parameters to obtain correct readings.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/thermal/broadcom/brcmstb_thermal.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
index 2ad4eeb79f9c..41d4a142707c 100644
--- a/drivers/thermal/broadcom/brcmstb_thermal.c
+++ b/drivers/thermal/broadcom/brcmstb_thermal.c
@@ -283,12 +283,18 @@ static const struct thermal_zone_of_device_ops of_ops = {
 	.set_trips	= brcmstb_set_trips,
 };
 
+static const struct brcmstb_thermal_params brcmstb_16nm_params = {
+	.offset	= 457829,
+	.mult	= 557,
+};
+
 static const struct brcmstb_thermal_params brcmstb_28nm_params = {
 	.offset	= 410040,
 	.mult	= 487,
 };
 
 static const struct of_device_id brcmstb_thermal_id_table[] = {
+	{ .compatible = "brcm,avs-tmon-bcm7216", .data = &brcmstb_16nm_params },
 	{ .compatible = "brcm,avs-tmon", .data = &brcmstb_28nm_params },
 	{},
 };
-- 
2.17.1

