Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7195E7D1680
	for <lists+linux-pm@lfdr.de>; Fri, 20 Oct 2023 21:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjJTTqQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Oct 2023 15:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjJTTqP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Oct 2023 15:46:15 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88580D60
        for <linux-pm@vger.kernel.org>; Fri, 20 Oct 2023 12:46:12 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9bc6447193so1540249276.3
        for <linux-pm@vger.kernel.org>; Fri, 20 Oct 2023 12:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697831171; x=1698435971; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VY26jasGvoK52ErKJqQiLhyEvSJKvdG2hTJjnfxEGsM=;
        b=ZNgOLavC8fzTZrLtjT8LABBsjAACnBHp8y++tiCif+Z3Xa6VKsWJsEIrSBnRbITeXn
         oMbBpSVzGVD0q7C72jAGMelMWToILzy7pf8Q9Q564+4fxxTDSFVBINmfMaUuboZXNsT0
         JbE2r02Kxv2O9H33zAgHz+SVQji/wWScrIAt9gRvcJXHQVWvRqVD5CQT2OMLcUGC9o+R
         QU0Rn0o1WXno6dXr8FgSCfV+6Fnevy7xPkSei+SAFQolzfraAOarhyaJmsIzc70RFq4i
         ICVRtqjt6NgYwWQRKVKF2yA2ZT8Aob+bviA5ZwxBvo1agAOUoFSge7x5kyRWcQ9TlMBJ
         Gkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697831171; x=1698435971;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VY26jasGvoK52ErKJqQiLhyEvSJKvdG2hTJjnfxEGsM=;
        b=MsNJduK9aYmpQHwMaQ0o+sJktRt+ntY9tOKcNhJ0voDYlRC5nD04MNo2Kq2ialxA8/
         2dnrxEFi3BwJCjEOBrKatt8x8ptH0m2FdlfyGzKjHLjRT2d16a5jM+Z5wCNQlvHibo6O
         lxLJQHdmvfe9YP3XUrOHKoUGgxiDQI6OyllUKiSxP50q19CmOWsoEaPbe8CqlDLlK1Dr
         qV54Gke7+5w/D3Su/6mXEUGjCFTeidVsYGSmOu0MlbsjpaWOyqaNglGRKut06hvSvwol
         NnbgQTpYM/VtEkz3JMYn1mOCS0YvTrcfIfZ7k5kO3STSP1Z8EgOd8+RN2FdM72MsRuWC
         fHLw==
X-Gm-Message-State: AOJu0YzwcqrQdlHhcsPV/309YfW0S6MRlAI7pkhfDoeVNNYs9xCkkwQ2
        u7CrK8IFqXgh+zOKH1z4V5LOJQDLtLpIDDykCA==
X-Google-Smtp-Source: AGHT+IG97zohXV8c60rF/wNzxWx2VFDqrZjuW/RKQVsOoHrGomIA9J+a4stpEs9Ol6SfQRsZL3Blf2RTmc7HiEy5xQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:5008:0:b0:d77:f7c3:37db with SMTP
 id e8-20020a255008000000b00d77f7c337dbmr57402ybb.8.1697831171763; Fri, 20 Oct
 2023 12:46:11 -0700 (PDT)
Date:   Fri, 20 Oct 2023 19:46:11 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAALZMmUC/x2NUQrCQAxEr1LybWB3LUW9iojUbbYGZBuSWi2ld
 zf4NbyBN7OBkTIZXJoNlBY2nqpDPDSQn30dCXlwhhTSMYYU0GatWVYclBdSQ5k+pGhvkdfqoaX PdHdVR68ztl13TqE8YmlP4KOiVPj7P7ze9v0H31wQnoAAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697831170; l=2331;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=MoENqRWLCZfJlaomoU9I/5Gv5zHSfuvBj5Ts109QtOo=; b=AGIAqvvph99TN7o26x2Jna1GEQQbXsXDNhvBOWVmAJ4nDa1gz+pDDw6NLF4IDqEqLdmoBb7dh
 eSFv7SOqwvQDEk2QPNb16gHfi0TAPdg5TkfUSc3zf/NMuwfjv7hn8ew
X-Mailer: b4 0.12.3
Message-ID: <20231020-strncpy-drivers-power-supply-surface_charger-c-v1-1-93ddbf668e10@google.com>
Subject: [PATCH] power: supply: surface-charger: replace deprecated strncpy
 with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect ac->name to be NUL-terminated based on its usage with format
strings:

surface_charger.c:
190: ac->psy_desc.name = ac->name;

...

power_supply_core.c:
174: dev_dbg(&psy->dev, "%s: Found supply : %s\n",
175:   psy->desc->name, epsy->desc->name);

Moreover, NUL-padding is not required as ac is already zero-allocated
before being passed to spwr_ac_init():

surface_charger.c:
240: ac = devm_kzalloc(&sdev->dev, sizeof(*ac), GFP_KERNEL);
241: if (!ac)
242:   return -ENOMEM;
243:
244: spwr_ac_init(ac, sdev, p->registry, p->name);

... this means any future NUL-byte assignments (like the ones that
strncpy() does) are redundant.

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Let's also opt for the more idiomatic strscpy() usage of:
(dest, src, sizeof(dest))

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/power/supply/surface_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/surface_charger.c b/drivers/power/supply/surface_charger.c
index cabdd8da12d0..7a6c62d6f883 100644
--- a/drivers/power/supply/surface_charger.c
+++ b/drivers/power/supply/surface_charger.c
@@ -175,7 +175,7 @@ static void spwr_ac_init(struct spwr_ac_device *ac, struct ssam_device *sdev,
 			 struct ssam_event_registry registry, const char *name)
 {
 	mutex_init(&ac->lock);
-	strncpy(ac->name, name, ARRAY_SIZE(ac->name) - 1);
+	strscpy(ac->name, name, sizeof(ac->name));
 
 	ac->sdev = sdev;
 

---
base-commit: bb55d7f7f7445abcc8db50e6a65d4315e79f75c7
change-id: 20231020-strncpy-drivers-power-supply-surface_charger-c-466920fb1f48

Best regards,
--
Justin Stitt <justinstitt@google.com>

