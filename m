Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3457D1608
	for <lists+linux-pm@lfdr.de>; Fri, 20 Oct 2023 20:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjJTS7m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Oct 2023 14:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjJTS7k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Oct 2023 14:59:40 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28749D6B
        for <linux-pm@vger.kernel.org>; Fri, 20 Oct 2023 11:59:39 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d99ec34829aso1454980276.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Oct 2023 11:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697828378; x=1698433178; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aC7KxLBec/eSA4myIMpLcsC0tK2N6BssGDn4X++BO/4=;
        b=lR0PKqHJ0uJgeTJrrffRrc6cYcn29O+LJl0AFNCO7ByvoJqcCeJ1PP3ZEJAAMzULe1
         NBnk9QEOzoKJa9iN85Ixim6MmHQ5lzY8dmiK1V1GMiR8/OM7wRyiCbW6rQmWiphYz8lh
         x/bo3x/oVc3LlzMzId4F1hY6vR/sLsTNyYlYuFVDjvqDRZ7jexIetJYmyKjKIB8523JM
         XT1QilTSnCFHbivl92ujcjn8ev3ln2QDWHXpjHAoHxKLhjLbAKeYXtI+743+cAd97HNk
         mYsK8XUbS/zc4eo6xcnYpSGNokVzavTUNeiDBIAybBioY4BdIiknOukCMu1qchu5LkvC
         EJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697828378; x=1698433178;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aC7KxLBec/eSA4myIMpLcsC0tK2N6BssGDn4X++BO/4=;
        b=PcFbYlOtyWaPdNX1++rKqzaZ8Cs3DdUB2p9jdHDiRvZhQDP3FZ7reuIxX66sw7jFIX
         3zeGeHHgI599TSGUDb2GWETpQOY+9ZhX/hkniGESlpf0gLg5w1yTfqpnUKTKj9N3Y+ME
         fUN+IA/qkEovrS7mJ8mt55vnEc0SZFKiWSzQ7O8v7rsGDlCQYVoMona2//e+FGh/bdJI
         2JsqdTC0M/oeEMrzlvOXrdNI3caU9c8LzVuK1usW91BQvt3UVqNbaGrnzBtrfoeOxCE7
         MXoaITcA6Jc/jw47en8Uxl3Dkazf7BOs/CFgFFpOOZJcCxNxNORxNhMvu1QyVychcb8n
         UqPg==
X-Gm-Message-State: AOJu0YzdFlf4b9ToUGM1ilpj3RT1luI4RsEyhIP9ZHSlnzNa/tTEYR9p
        PsRkn9JiuCTGsT2U83lfaQTSkmcs9Fcrfs7/OA==
X-Google-Smtp-Source: AGHT+IEQpDs7hpOqRDtFDbh4OM23K8uXHQtjIsWC4jrd/lhbtU2hEf9NOXi6sVTehUOiNBV3H+BHO3UoNbsCMYHd+g==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:d7d8:0:b0:d9a:da03:97e8 with SMTP
 id o207-20020a25d7d8000000b00d9ada0397e8mr53942ybg.2.1697828378406; Fri, 20
 Oct 2023 11:59:38 -0700 (PDT)
Date:   Fri, 20 Oct 2023 18:59:34 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABXOMmUC/x2N0QrCMAxFf2Xk2UDTbiD+ioi4Lp0B6Wqic2Ps3
 1d8PBfOPRsYq7DBpdlAeRaTKVegUwPx+cgjowyVwTsfyHmH9tEcy4qDysxqWKYfK9q3lNeK/dt 31C33qupY54ixT3QmCqFNHuppUU6y/IPX274foYe/1oAAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697828377; l=2719;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=T+2bP/VZordKJivg0WULS6xpMGyCh5PEFbjppJMYDyw=; b=wfeBrFDrlPg11uAXCMlr1FrdbFjab3mH++hd8n+V8J6m4i2+5fSu+wTfIKW7ADNr0aV6HkBe9
 dAIOowSQjgXD6wkWvunWsFVJIEBXYJV97Ryx0HNqH5J9WFFJxzHyBii
X-Mailer: b4 0.12.3
Message-ID: <20231020-strncpy-drivers-power-supply-bq2515x_charger-c-v1-1-46664c6edf78@google.com>
Subject: [PATCH] power: supply: bq2515x: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect bq2515x->model_name to be NUL-terminated based on its usage with
sysfs_emit and format strings:

val->strval is assigned to bq2515x->model_name in
bq2515x_mains_get_property():
|       val->strval = bq2515x->model_name;

... then in power_supply_sysfs.c we use value.strval with a format string:
|       ret = sysfs_emit(buf, "%s\n", value.strval);

we assigned value.strval via:
|       ret = power_supply_get_property(psy, psp, &value);
... which invokes psy->desc->get_property():
|       return psy->desc->get_property(psy, psp, val);

with bq2515x_mains_get_property():
|       static const struct power_supply_desc bq2515x_mains_desc = {
...
|       	.get_property		= bq2515x_mains_get_property,

Moreover, no NUL-padding is required as bq2515x is zero-allocated in
bq2515x_charger.c:
|       bq2515x = devm_kzalloc(dev, sizeof(*bq2515x), GFP_KERNEL);

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Let's also opt to use the more idiomatic strscpy() usage of (dest, src,
sizeof(dest)) as this more closely ties the destination buffer and the
length.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
Similar-to: https://lore.kernel.org/all/20231020-strncpy-drivers-power-supply-bq24190_charger-c-v1-1-e896223cb795@google.com/
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/power/supply/bq2515x_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq2515x_charger.c b/drivers/power/supply/bq2515x_charger.c
index 1dbacc9b015d..b4ea1707304a 100644
--- a/drivers/power/supply/bq2515x_charger.c
+++ b/drivers/power/supply/bq2515x_charger.c
@@ -1092,7 +1092,7 @@ static int bq2515x_probe(struct i2c_client *client)
 
 	bq2515x->dev = dev;
 
-	strncpy(bq2515x->model_name, id->name, I2C_NAME_SIZE);
+	strscpy(bq2515x->model_name, id->name, sizeof(bq2515x->model_name));
 
 	bq2515x->device_id = id->driver_data;
 

---
base-commit: bb55d7f7f7445abcc8db50e6a65d4315e79f75c7
change-id: 20231020-strncpy-drivers-power-supply-bq2515x_charger-c-cbf1811334f2

Best regards,
--
Justin Stitt <justinstitt@google.com>

