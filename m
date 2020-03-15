Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B134185DDD
	for <lists+linux-pm@lfdr.de>; Sun, 15 Mar 2020 16:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbgCOPOp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Mar 2020 11:14:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34318 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgCOPOp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Mar 2020 11:14:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id z15so18051605wrl.1;
        Sun, 15 Mar 2020 08:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ztqdauPgBR6/jJXcC/G4eAbGw7jHbgKj5fkmHyJg9TM=;
        b=ePEUSzNMcY5d70nvKQ3K/OTrIlZZVKG+mZEFxdQTqlJ2ZsPDq8xz4OAVNZRpqn9fuu
         OHBCZagBPP3buzt9EhAtKG3GnYDJV5+jPrJGjr5YlP0LenPPJZhxaIB/zlzYTC/TTjHy
         dRZonpKDnREyiGnEion6Loyfurq4LdGvfI+JlBu47LeLIvbMEpuzYVHw6K+xfKXdPX/c
         IF6w+479uPEzdJM/E3P3zw9t8GKh6xVtvo5ka+x0oro6GNDOrNnRJBq+yfAZyXK4AAsK
         yTmjBLD+0OnJ9Rkbc42kRAOjfYZ4K9JCfZ9+FcuPRB+90+6AgycQAWDxNxicK7QIz5uy
         Xw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ztqdauPgBR6/jJXcC/G4eAbGw7jHbgKj5fkmHyJg9TM=;
        b=F+/BAjc9jjX2To6KYLHqKGVdCZmmkCbWldtvsEiWLm4+e0gOdFrWoo9m4bbe8Vlj6U
         YfB1SFuy3CZNJ4kDNdjQxlBy1cXkXJsDk++U/Ak2DRcmteBd65c0Vl/YzVRn1iNy1zWu
         LsZgSxehlfNpsvB4hxjwVKlLnZ39GqvJ5T+thm7vQUHlifG5Wv+5dLzOxQKo/XBxY4n1
         VFy4ec6BytxZzahT+vdTLB1hg5LLivRZwEtyZ6hgahkVc4M6UkGRFUstp5+6F1sPQMqT
         eEQ8wVzMniP7hfjVAqQz/EWZEkpLFLun44jkXH5FEzyvC7aXvMIKMQFdZeKElP4NqQGM
         knCg==
X-Gm-Message-State: ANhLgQ2ayWW175igyUv3eKkoSUsxYXHCUbEVUbtrZ77zTkNXAajUhxFb
        n3SY12zCxjERdRCT2BawEbM=
X-Google-Smtp-Source: ADFU+vvb3D9ekjFjtfjVelRtkTOOQvYVEtp3zqKRYT1UH6nvLnSQPSKmNJvziiEvJLJLryZ3y0eOmA==
X-Received: by 2002:a5d:4cc6:: with SMTP id c6mr29734006wrt.30.1584285282838;
        Sun, 15 Mar 2020 08:14:42 -0700 (PDT)
Received: from supervisor.net28 ([46.53.248.79])
        by smtp.gmail.com with ESMTPSA id i67sm67746869wri.50.2020.03.15.08.14.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Mar 2020 08:14:42 -0700 (PDT)
From:   Arthur Demchenkov <spinal.by@gmail.com>
To:     Tony Lindgren <tony@atomide.com>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>, sre@kernel.org,
        linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
Cc:     Arthur Demchenkov <spinal.by@gmail.com>
Subject: [PATCH 09/15] power: supply: cpcap-battery: Increse low voltage bound
Date:   Sun, 15 Mar 2020 18:12:00 +0300
Message-Id: <20200315151206.30909-9-spinal.by@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200315151206.30909-1-spinal.by@gmail.com>
References: <20200315151206.30909-1-spinal.by@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thus, the user will have more time to start charging when calibrating
the charge_full value.

Signed-off-by: Arthur Demchenkov <spinal.by@gmail.com>
---
 drivers/power/supply/cpcap-battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index 2f4c6669c37d..da6138df2117 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -422,7 +422,7 @@ static bool cpcap_battery_low(struct cpcap_battery_ddata *ddata)
 	struct cpcap_battery_state_data *state = cpcap_battery_latest(ddata);
 	static bool is_low;
 
-	if (state->current_ua > 0 && (state->voltage <= 3300000 || is_low))
+	if (state->current_ua > 0 && (state->voltage <= 3350000 || is_low))
 		is_low = true;
 	else
 		is_low = false;
-- 
2.11.0

