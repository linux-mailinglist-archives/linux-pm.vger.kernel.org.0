Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB87115D1BB
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2020 06:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgBNFkF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Feb 2020 00:40:05 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37457 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgBNFkF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Feb 2020 00:40:05 -0500
Received: by mail-pg1-f195.google.com with SMTP id z12so4378581pgl.4;
        Thu, 13 Feb 2020 21:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+tmH0kcp5YKexoO2OsIvb30KrHhpFBPYCCmsNiF0Z2M=;
        b=sOwRCILM1p8O2wtjVPhO/hQ8+nBgen5mzy8MGJItP4r+QZdN54KTaxQdfIQPhQ99sT
         lVIesqm503sVov3jI2Qw7RUJ91e6vIUo7fF9cm4U0Hy+aicS67YJ+zZCk45eNdTQEtJA
         p17Ew4ckEW533lOichK7KIPWJ1PVXWihxa0X66U+3uSVEsDOa7pcZUjqEHt1illfqiH0
         Sigvov6UYWn0V/5ImzqvgWJg6Z9bpqZOuzItplc30dJY4onAeNGODOi9lpvVhO0Ixp42
         6hhNHCcpQ2kedklMm2iScEfrFb0NHkOMQfftpD3euOz6lyLLH/aWTpYgOxxXCiFLX2+L
         iYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+tmH0kcp5YKexoO2OsIvb30KrHhpFBPYCCmsNiF0Z2M=;
        b=f9vbZ30AUHl3waEUEbDLme5LjI83iztg8IAwSoDMfVu1ObLvAVjCjJme9gqYJbXPr7
         JoM6P5gR91SdBbJ5Np2aomsmm9tPbBsW6/s3wrkoS6lCOs9N+GYZOiaA4nQSqeDkNBTI
         b7MHhvBu1IPgRH3rc+8qa8N7VWZyRtQmEuBcLqKoQtOngIvUEULpoN6IPtAA0Pm8LUiV
         WepMMuQnrZfVMVEQMsdy0qNmE/TUhbQGGtsUlCReA3cyJhXg7LWj0cY+ACrBUoZCxXLz
         DxP+CoyRNyq/PcZskRpWQ+Q/oVFhZQU45BJ0LWLUENSz+jInHZd6QMGtQi0h1h2YObHD
         FFww==
X-Gm-Message-State: APjAAAXnKiG3fsOhgSm2reZDhfSaDsSL3iVOT2SkZHpTM6OpXiGajOnw
        8R4xsPTfMuEOP6ZffEPIctM=
X-Google-Smtp-Source: APXvYqyZBpjPl7GsweVXzvbxZ0Mdyo0XXfpW6kVOC3DtFHsa+DO3vFOOdQCWZwaQVEzJFzEkkPKyBA==
X-Received: by 2002:a63:cd04:: with SMTP id i4mr1652725pgg.281.1581658805034;
        Thu, 13 Feb 2020 21:40:05 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id b24sm4974349pfo.84.2020.02.13.21.40.02
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Feb 2020 21:40:04 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com, orsonzhai@gmail.com
Subject: [PATCH] power: supply: sc27xx: Add POWER_SUPPLY_PROP_CHARGE_NOW attribute
Date:   Fri, 14 Feb 2020 13:38:58 +0800
Message-Id: <33dba0929575461e38c2e17ac0cc4a8a4e46fa2f.1581658633.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the POWER_SUPPLY_PROP_CHARGE_NOW attribute to allow user to get
current battery capacity (uAh) to do measurement.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/power/supply/sc27xx_fuel_gauge.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index 469c83f..a7c8a84 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -614,6 +614,17 @@ static int sc27xx_fgu_get_property(struct power_supply *psy,
 		val->intval = data->total_cap * 1000;
 		break;
 
+	case POWER_SUPPLY_PROP_CHARGE_NOW:
+		ret = sc27xx_fgu_get_clbcnt(data, &value);
+		if (ret)
+			goto error;
+
+		value = DIV_ROUND_CLOSEST(value * 10,
+					  36 * SC27XX_FGU_SAMPLE_HZ);
+		val->intval = sc27xx_fgu_adc_to_current(data, value);
+
+		break;
+
 	default:
 		ret = -EINVAL;
 		break;
@@ -682,6 +693,7 @@ static int sc27xx_fgu_property_is_writeable(struct power_supply *psy,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
 	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
 	POWER_SUPPLY_PROP_CALIBRATE,
+	POWER_SUPPLY_PROP_CHARGE_NOW
 };
 
 static const struct power_supply_desc sc27xx_fgu_desc = {
-- 
1.7.9.5

