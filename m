Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C3937B024
	for <lists+linux-pm@lfdr.de>; Tue, 11 May 2021 22:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhEKUiW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 May 2021 16:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbhEKUiV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 May 2021 16:38:21 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0982FC061574;
        Tue, 11 May 2021 13:37:15 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id d25-20020a0568300459b02902f886f7dd43so5224477otc.6;
        Tue, 11 May 2021 13:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+1ZHtd+lPI4rsXdxkd6hfQFi/UAS7WL7S9/KvHCS20A=;
        b=AEuaaAZdU0hWx7AVW/+6SLmKMmIhl/OzXwZrSguL9Xmqa3ztiYjzP69B912u6tDOAU
         OXHJUvcKEvmU9JlpKTOB9juycvwQLGyQvQO10TbBVP3YWd6NaSr+hEHLMRHe57Qo1ybs
         +wBHvsEITNo/OF5B12GY0jYfusKectjaPD0wIJ1oqEQOHQjz3WmVHX8tz6PxRRckRwzJ
         FhNlTCVNz8cJ7KdQ+zVTssluzJT+PxQeb1vSjRLewshpJbTVUDP2C+9sKaIJ8Z5+eKlO
         CCVbLpAYRXWSryUzfNahTFLxJACedvxrgUMm72oYalfRKlvvgzEDqmu5DlmS0CsMHAnz
         2DQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=+1ZHtd+lPI4rsXdxkd6hfQFi/UAS7WL7S9/KvHCS20A=;
        b=ZgyF0bpYsKeicXlElH8/FJPm+PR20xqCC49VbdgKPV6uAv4LCKmDu3Fzgea/N3QN01
         1AbIxHBOvVls0mDQJUrMyUCxr7iCxVxfBSIayjJ/SqWBBpvfKxqHDZXLE18DK/iAZIh7
         t3xHV4+M2Ag+lAIHhikARXWSySzsBfMXUlqcB8JZGJfHA/vLH4eGqtQ56N1dt1Vm5vDW
         WDKTlf9C5YA/L3PjZOHm/IqBsFx6DRb/vc+obS2IzGezsNJ88E6j1UchYy3bSGdulZ+B
         xRvSm1KXDa/mATCUJb5VTpaidSh14jLGo85k8I2IkVkNBoIvwsU6BTd9EheVHPFn8s7z
         ceNw==
X-Gm-Message-State: AOAM530VeJ0/9pWY80v6kxoFtKThm5ZufWhiKefydC+xXWoFztb03v3L
        vD9RPaQymgEHxd8Gh6hqLf8=
X-Google-Smtp-Source: ABdhPJzIsc9mtnzXHYZAOU+N3D3CkxhZB6+aYo10ov63X3MK+gkaclj0qwyDhG3X+hiZu9UEdWtbBg==
X-Received: by 2002:a05:6830:1657:: with SMTP id h23mr665958otr.136.1620765434476;
        Tue, 11 May 2021 13:37:14 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u27sm3144188oof.38.2021.05.11.13.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 13:37:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] power: supply: ab8500: Drop unnecessary NULL check after container_of
Date:   Tue, 11 May 2021 13:37:11 -0700
Message-Id: <20210511203711.1673001-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The result of container_of() operations is never NULL unless the element
is the first element of the embedded structure, which is not the case here.
The NULL check is therefore unnecessary and misleading. Remove it.

This change was made automatically with the following Coccinelle script.

@@
type t;
identifier v;
statement s;
@@

<+...
(
  t v = container_of(...);
|
  v = container_of(...);
)
  ...
  when != v
- if (\( !v \| v == NULL \) ) s
...+>

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/power/supply/ab8500_charger.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index a9be10eb2c22..f407cec49aa3 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -3171,9 +3171,6 @@ static int ab8500_charger_usb_notifier_call(struct notifier_block *nb,
 	enum ab8500_usb_state bm_usb_state;
 	unsigned mA = *((unsigned *)power);
 
-	if (!di)
-		return NOTIFY_DONE;
-
 	if (event != USB_EVENT_VBUS) {
 		dev_dbg(di->dev, "not a standard host, returning\n");
 		return NOTIFY_DONE;
-- 
2.25.1

