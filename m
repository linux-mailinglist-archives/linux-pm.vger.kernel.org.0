Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842CD3D71E9
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jul 2021 11:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236131AbhG0J0P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Jul 2021 05:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236110AbhG0J0N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jul 2021 05:26:13 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA78C061760;
        Tue, 27 Jul 2021 02:26:10 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id da26so14482263edb.1;
        Tue, 27 Jul 2021 02:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=upca8ZIRnBjP2uwyl9H9KklVRdJGlttXPnnXYpx4650=;
        b=n+ApQm+ESRJgkZY/kH6iEMGP5oHiEDw3WMeMrmJ8b71V/CF5oFY0O/GP2NfJ6RRdvr
         CwB06TaWH/O0rjuw1BtN40x+t9gHviKxW4l51lfq//5k98Ko2Lj17OJ2/KtJ3YeayB0S
         BJzJbRdAtUp875qq76gpIOFjvKaz2cdjKwc9mSDCWwNDmIpL/uFHswA2uZk0xIY0VsT/
         uHiBta5Nac1yyGx/TXxwVl35368A0Lo7cZD7wOEzIrA3THl4wCp81c71edFumu7PntDM
         lh4BWU3O7aK/x0ec4Mf2wxWdsMpKSeZYMoq9hg5rq+rvDviri5JZWtN+eOI0KJvsvVwX
         piVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=upca8ZIRnBjP2uwyl9H9KklVRdJGlttXPnnXYpx4650=;
        b=WlQ/5GAL4Jj6GD5J3AtgUvQmqAaAXqjGCn/ml+u7UX6SEJYxyhQ0KrNGfFkix3BN5x
         LhIIfVIvVCbEeLEVOW6myJswcYA1vWmpqTQ/6DagDH5/ACmwFLUA+TBclYCXkIYW3EQZ
         Epdb9g+wSi5KvPRL0x1MlhXQ9naLGwsOhyuaMguuL27cGEhg15kTKnkgTDw49D42g2ZQ
         7mS9wyZAdryaotRp/PYP/IULUNZ20CuRxe5vw40FoENwWoYYS8fbpe7TKlcenUmpwwrF
         Hp/G9V5O6YbM+4AuYzfuopTpqqng88dpttsctrovORJVC7WG2kSbkATwi6Ss+quVcrst
         4olg==
X-Gm-Message-State: AOAM532Jrh50IgF3qtX5wq4lpSlM26hiJT6pqv/sJxfbG/0iAahLhII8
        IsZw2hBXl2j+jN20qrvxgUI=
X-Google-Smtp-Source: ABdhPJyh15E5Fl4c8g3ZAoAI5k1TiBU0gBvaYrBD85ktOxeao55OE5ppu0SMgR2m4zljYIbGzKUBlQ==
X-Received: by 2002:aa7:c042:: with SMTP id k2mr25839116edo.104.1627377968648;
        Tue, 27 Jul 2021 02:26:08 -0700 (PDT)
Received: from stitch.. ([82.192.166.82])
        by smtp.gmail.com with ESMTPSA id g3sm692369ejp.2.2021.07.27.02.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 02:26:08 -0700 (PDT)
Sender: Emil Renner Berthing <emil.renner.berthing@gmail.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Emil Renner Berthing <kernel@esmil.dk>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] mfd: tps65086: Add cell entry for reset driver
Date:   Tue, 27 Jul 2021 11:25:54 +0200
Message-Id: <20210727092554.1059305-5-kernel@esmil.dk>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210727092554.1059305-1-kernel@esmil.dk>
References: <20210727092554.1059305-1-kernel@esmil.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The only way to reset the BeagleV Starlight v0.9 board[1] properly is to
tell the PMIC to reset itself which will then assert the external reset
lines of the SoC, USB hub and ethernet phy.

This adds an mfd cell entry for the reset driver doing just that.

[1] https://github.com/beagleboard/beaglev-starlight

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/mfd/tps65086.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/tps65086.c b/drivers/mfd/tps65086.c
index cc3478ee9a64..3bd5728844a0 100644
--- a/drivers/mfd/tps65086.c
+++ b/drivers/mfd/tps65086.c
@@ -24,6 +24,7 @@
 static const struct mfd_cell tps65086_cells[] = {
 	{ .name = "tps65086-regulator", },
 	{ .name = "tps65086-gpio", },
+	{ .name = "tps65086-reset", },
 };
 
 static const struct regmap_range tps65086_yes_ranges[] = {
-- 
2.32.0

