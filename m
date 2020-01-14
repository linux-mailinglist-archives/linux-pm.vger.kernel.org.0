Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9587813B2A4
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2020 20:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbgANTG3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jan 2020 14:06:29 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46657 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbgANTG2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jan 2020 14:06:28 -0500
Received: by mail-pg1-f194.google.com with SMTP id z124so6804341pgb.13;
        Tue, 14 Jan 2020 11:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vD4wTJSOL9eulpsTOv7Le84ncUzkM09cyPSOhtdnfmU=;
        b=sRB5dAWcX/qUSYqbrlWhiWc0MnbvpoatmZ6LCpB0UwOkZrtsYHqNLBFUVULx4jVB1h
         yzSnkzLcqPStLhkUXefgdfCUNhyhmMU7OVnpe7kimMEjwIOAxXVt06nuJ/SH3MyNhDsG
         gpEXvDKXO3QEkIDdR518cafxevtrh4gXvsAAYp8oLHNwvuOTsyijwX9qstj/kSBzYDh3
         j4YPo83hJw4RNS3iqKSBngW7p2yQRuiEU5Wv6f7Qc3GhmjQR/TsfS8EFEVn5ezuPOGfO
         SKoxuyzlOjbR1H0EIMHWm17hUa91GfSalnFWWkiK7XQNcU185sOSEM7qofNsbaRGyh6f
         7CBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vD4wTJSOL9eulpsTOv7Le84ncUzkM09cyPSOhtdnfmU=;
        b=sgxaJvuyBwgJ/0/pfFRj8WgO3oVm4n2hZX3BsMtTYlW/QVWH5TrF3SNGCxW7opE8pu
         lpCR2436izLNHeD0zYcv2UMbedBgxvI7Kj80p/eFVVoEo6yqky5GOBaiVd7Y3GwNpX/c
         QFLna1Gs9QN7GFvfMoKqktPHrBeItPgCpzIx8/VfalHDTVfuFWPNu9IRc9IH6k7YJ2x9
         fgrlxLAOXtzvqArsY96E8r1bgctbwxJaZRgzJD9a3FJmKx+IxwdHqAa2Oso2TmL53WqK
         f8aXE/fT3+nqRSPrphGitiEyUyFhtmgqbazaMlOF2u9Dnk0M+y1OwNYPC2+1prTwBsl2
         2DgQ==
X-Gm-Message-State: APjAAAVuczivlVB6mdDoz2iyrZwj0bY7aWupXUv5rzHlwKQ7DG5A14Ml
        expvc7nu5uz7tvn+YlrlGXSm8ENL
X-Google-Smtp-Source: APXvYqwCWirANusXlzS5wVKhPR+K7LLYkWVsiIK/0rFOHoFwJJOpRuMfg3cj6pr0b/4klXZYXW5G/Q==
X-Received: by 2002:aa7:9306:: with SMTP id 6mr26753037pfj.36.1579028787478;
        Tue, 14 Jan 2020 11:06:27 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a195sm19284528pfa.120.2020.01.14.11.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 11:06:27 -0800 (PST)
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
Subject: [PATCH v3 4/6] thermal: brcmstb_thermal: Add 16nm process thermal parameters
Date:   Tue, 14 Jan 2020 11:06:05 -0800
Message-Id: <20200114190607.29339-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200114190607.29339-1-f.fainelli@gmail.com>
References: <20200114190607.29339-1-f.fainelli@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Match the 7216 compatible string in order to derive the correct 16nm
process thermal parameters to obtain correct readings.

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/thermal/broadcom/brcmstb_thermal.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
index 2d555e7b884a..4b328586959f 100644
--- a/drivers/thermal/broadcom/brcmstb_thermal.c
+++ b/drivers/thermal/broadcom/brcmstb_thermal.c
@@ -292,12 +292,18 @@ static const struct thermal_zone_of_device_ops of_ops = {
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

