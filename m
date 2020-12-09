Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F44A2D39E6
	for <lists+linux-pm@lfdr.de>; Wed,  9 Dec 2020 05:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbgLIEvs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 23:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbgLIEvs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2020 23:51:48 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5BBC0613D6
        for <linux-pm@vger.kernel.org>; Tue,  8 Dec 2020 20:51:08 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id t6so310011plq.1
        for <linux-pm@vger.kernel.org>; Tue, 08 Dec 2020 20:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Eb/8xbSHuZmM/twerPX5ivX38XIkT6DJa1nEgFyOgQE=;
        b=Zw9yO1wXt09oPCCeEc9/TpEx8qFjQhf3DlWSUl7KdvdMaKtGYKSD7KQDkACg9U4rCG
         qRXkQ7J1uFST0yqQp9GfVsj25W1qWk93No1ms6snwm7DIwfD1JbJCcf9CAkACcS4JSQR
         /iJLA1RzXm8hPiHlptXO1a/AW2eH8p50QYLM/+6Wagg56UT5UadWtIizqOWy1lsthbBG
         oi5WBPd214ITvYlDztSCF4IXrtKdreM8lOAXo/ous3auHgvjCQpaFktl+EvBnQE4x0s0
         i2rpV4vNt1jpc5gRMl4G+Ra4jFLjbPaU+kE5pYpJnyMjXhmNDKN9zB3lveLQgJkDCu9K
         PVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Eb/8xbSHuZmM/twerPX5ivX38XIkT6DJa1nEgFyOgQE=;
        b=agOm4Q65RF2h9p3da/2ubk/z45YAUrh2JgyiIlRB5soJvvmFFwAEmZ41bZ/Mv0/MPB
         127MeVeitz9BiuSKPmzGA1Yvo/2zT341kA6aa3sBVbZPPBZPOKPAcrH+QPFEi3Cf7eFg
         bPlhk3HKqPrf2t6xRbqcwG1lUHQKhGIrMLsEALGH1KIAENqlRDkYupSVXUO1XXQH6X7g
         ukNM5TssIjO8bUCUiWqKGYuO/UfqoMAT/lvVhDUSGqMo1DqeAR4VPqyw0/H2pJR61c07
         kXv8Mj7E4+l2k8r4ypJEJKmykxuWF/xmvgbLxP1U1TmZ4A48EeD8eTXLouBpIELfklV8
         pg3A==
X-Gm-Message-State: AOAM531IPJ+0+Wxh4GMbJ42tCl0JWjS9rqD4W3Ptb0wdu5YAiuaLrE/K
        z3p46pLM/V0oLQZojSYd+iGofQ==
X-Google-Smtp-Source: ABdhPJxjWpFm14QYtvlJ85cl36utzHZBLwJeaEeHBkFGYSaxab+K4BfrtaRCEZggOCFIO27KCDWrng==
X-Received: by 2002:a17:902:900c:b029:da:b7a3:d83a with SMTP id a12-20020a170902900cb02900dab7a3d83amr462212plp.57.1607489467457;
        Tue, 08 Dec 2020 20:51:07 -0800 (PST)
Received: from localhost.localdomain (2001-b011-3814-7903-632e-aa12-9563-de14.dynamic-ip6.hinet.net. [2001:b011:3814:7903:632e:aa12:9563:de14])
        by smtp.googlemail.com with ESMTPSA id k64sm498196pfd.75.2020.12.08.20.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 20:51:06 -0800 (PST)
From:   Chris Chiu <chiu@endlessos.org>
To:     sre@kernel.org, wens@csie.org, hdegoede@redhat.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessos.org, Chris Chiu <chiu@endlessos.org>
Subject: [PATCH] power: supply: axp288_fuel_gauge: Add the ECS EF20EA to the blacklist
Date:   Wed,  9 Dec 2020 12:50:57 +0800
Message-Id: <20201209045057.9509-1-chiu@endlessos.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The ECS EF20EA laptop ships an AXP288 but it is actually using a
different, separate FG chip for AC and battery monitoring. On this
laptop we need to keep using the regular ACPI driver and disable the
AXP288 FG to avoid reporting two batteries to userspace.

Signed-off-by: Chris Chiu <chiu@endlessos.org>
---
 drivers/power/supply/axp288_fuel_gauge.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index 148eb8105803..a15c322c79ea 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -739,6 +739,12 @@ static const struct dmi_system_id axp288_fuel_gauge_blacklist[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Z83-4"),
 		}
 	},
+	{
+		/* ECS EF20 */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "EF20"),
+		},
+	},
 	{}
 };
 
-- 
2.20.1

