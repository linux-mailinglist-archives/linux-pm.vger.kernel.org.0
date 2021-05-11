Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAFA37A379
	for <lists+linux-pm@lfdr.de>; Tue, 11 May 2021 11:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhEKJ0A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 May 2021 05:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbhEKJ0A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 May 2021 05:26:00 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89E4C061574;
        Tue, 11 May 2021 02:24:53 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id l14so19391519wrx.5;
        Tue, 11 May 2021 02:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0AnzXgxK5+cy961so+pTR7J0BblhwCS+zVpCGXvjqdo=;
        b=ieJPlSPQaOPMpkp1QEnOTFySECTBfclW4E6F8a/7lJ9uiyLsCTeMDRdtOlM2UeNKGl
         TqYUVG0Lch2kLgk/9QCiZxGvPrx9tAwpwIh0gDfnJHKZ6wbIwQ3TIe8Y/4pXEqA+cUIs
         KHE4Ky7nGtgSpXHCAOil0Y8S5yqKbx7jpwrRGOMIOsF4avBY5en0wTiUHGgTEDSVd5HL
         nndO3aJ+XtuayCbMYhLSjPE/ekmvDbQIYeL4EANurxakWmZoUgUGPpy0fUi/YXQplWjI
         E7OvHLm0aQFfdzU00VrvIEiPUv2jvd3eNDpfbuWxXZE7wgSRgjnfkVy9oQTJouwcGFLI
         VXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0AnzXgxK5+cy961so+pTR7J0BblhwCS+zVpCGXvjqdo=;
        b=PcbAWZJIV9P2YculFIejsi+Hzy97b6u4lKGXQgLy80ULl0XG6HcZaiR+AmKLDI+ZgR
         eY5RRa+z274berj+OzumLjRu5TPuHkinzHHBaFdlRp32XqRWEAtAPXVFwb8um8x5eUh7
         l8MCYMgjhwNMwNdDyPbMZa69HDQJuZaV8Nu7IHsFqCbVqfD6CKy9QGRmyPTi+ifU2Gm4
         QZn/LX/m67RGrweSPtck9ZSZz5y3cVKhdKasF/ILISDucE0DJZygq/4JR6xyh3d82lXx
         C9/HVq4Saz2X+82uc3ZMr359bBkjFxcIRE1vxtYmUFC5dKrIuSiPT394aDuTIoHRrhf6
         IU2g==
X-Gm-Message-State: AOAM5330ai2YQcTS2SnXTHnrBn3U85L7Vno/WC+pEIafBtkOruvK4Wh4
        13lzCfdIWr0qQZ8vsJ8L9i4=
X-Google-Smtp-Source: ABdhPJyMRsl8JTK7CTbJ+SmjbzjXRAnZiZ/bn+ZsTGOjiniALMJALvbAqVvMMCik+eIXIU3EIREY7g==
X-Received: by 2002:adf:f750:: with SMTP id z16mr36378020wrp.10.1620725092679;
        Tue, 11 May 2021 02:24:52 -0700 (PDT)
Received: from xws.localdomain (p5487be9d.dip0.t-ipconnect.de. [84.135.190.157])
        by smtp.gmail.com with ESMTPSA id z9sm23100614wmi.17.2021.05.11.02.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 02:24:52 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH] power: supply: surface-charger: Fix type of integer variable
Date:   Tue, 11 May 2021 11:24:21 +0200
Message-Id: <20210511092421.1928586-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The ac->state field is __le32, not u32. So change the variable we're
temporarily storing it in to __le32 as well.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: e61ffb344591 ("power: supply: Add AC driver for Surface Aggregator Module")
Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/power/supply/surface_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/surface_charger.c b/drivers/power/supply/surface_charger.c
index 81a5b79822c9..a060c36c7766 100644
--- a/drivers/power/supply/surface_charger.c
+++ b/drivers/power/supply/surface_charger.c
@@ -66,7 +66,7 @@ struct spwr_ac_device {
 
 static int spwr_ac_update_unlocked(struct spwr_ac_device *ac)
 {
-	u32 old = ac->state;
+	__le32 old = ac->state;
 	int status;
 
 	lockdep_assert_held(&ac->lock);
-- 
2.31.1

