Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A542282D4C
	for <lists+linux-pm@lfdr.de>; Sun,  4 Oct 2020 21:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbgJDTcR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Oct 2020 15:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbgJDTcP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Oct 2020 15:32:15 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BDCC0613CF;
        Sun,  4 Oct 2020 12:32:15 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id u8so8352072lff.1;
        Sun, 04 Oct 2020 12:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+fGqwF3n7Dljz+v5iSvveY+aywNUa6LLSGHXGvkFn30=;
        b=L8BQAzdU/PSX9t+0NIlm1DCSDlyre77UWxfamqMy6zcHMEe1NYKccVk4lJIg4KxU1d
         xkMFxt7dj2iwS5zg3cWKDZ1l07+Z1wTxKEz5JZawnzQl0xzZIZeQjkBoUJqRc3JI3LpY
         DWPnVZaz8U8KJUzLfqkZhzD5tHRTIX4cgySko1h2J+zK1AB/fLLH6X23kd7v6Z78aorL
         3HgwLUFAsdLAXlWt+6f4UygDM+gPhdko1tKn1W0N/VEZYg1B7DGp/WeMSiRAC/kHgm/d
         r+Ev1YwOOmBqrn8FcGlSjRaByoCyU00Dn6OtUv4A8Unl8mF+XHteX0UnvZiRQAcj8TPi
         yJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+fGqwF3n7Dljz+v5iSvveY+aywNUa6LLSGHXGvkFn30=;
        b=L5/a4lqyby0SZy9q0L+7T1jiulJ8MR6EDM5vTmZWWBFBDP8Z85yzUNuU392mlxKlv2
         Iyu90Fuec5q+9p1N5rS5KHb2XymKxoa2XHC6roJ5usB4pkyKqmYSZ9PCCYkaJU0g2tE7
         iuBGblWah/IIfI8FTr3Y6r/ixRC4VGcMyt6lhUl/lGFV2Anii96ocH2Xehv7LWlRQZT5
         PzLK5+mcCZbXPGk9j2bzHOk83poZZ61YjLN27qPhLPhmwoyeFNqwZ5ZuytHIx2u6tgkz
         ulvehFOKr+JDlKtqXv2kTLRmr44+jtZhimIpFXkPp6M0TybwqUeXz4aLQU0RtCKfsFfX
         nt+Q==
X-Gm-Message-State: AOAM531GUKaALfNXst9anT/lDjUIEJ54mq29/yaqfl806Hya9+qH8Dtr
        s8lasvi41IFG4QOkrlcDBYvITbBMlFs=
X-Google-Smtp-Source: ABdhPJynug5cDd6macHoVGlfolPRJcnUlmFLf/4rvcGFZu8viUXm30zBlJt0MTNzeIjkn0JJDiqKZg==
X-Received: by 2002:ac2:4433:: with SMTP id w19mr4675150lfl.548.1601839933622;
        Sun, 04 Oct 2020 12:32:13 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-221-232.NA.cust.bahnhof.se. [155.4.221.232])
        by smtp.gmail.com with ESMTPSA id h22sm2298220ljl.101.2020.10.04.12.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 12:32:12 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH 3/3] power: supply: Constify static w1_family_ops structs
Date:   Sun,  4 Oct 2020 21:32:02 +0200
Message-Id: <20201004193202.4044-4-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201004193202.4044-1-rikard.falkeborn@gmail.com>
References: <20201004193202.4044-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The only usage of these structs is to assign their address to the fops
field in the w1_family struct, which is a const pointer. Make them const
to allow the compiler to put them in read-only memory.

This was done with the following Coccinelle semantic patch
(http://coccinelle.lip6.fr/):

// <smpl>
@r1 disable optional_qualifier @
identifier i;
position p;
@@
static struct w1_family_ops i@p = {...};

@ok1@
identifier r1.i;
position p;
identifier s;
@@
static struct w1_family s = {
	.fops=&i@p,
};

@bad1@
position p!={r1.p,ok1.p};
identifier r1.i;
@@
i@p

@depends on !bad1 disable optional_qualifier@
identifier r1.i;
@@
static
+const
struct w1_family_ops i={};
// </smpl>

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/power/supply/bq27xxx_battery_hdq.c | 2 +-
 drivers/power/supply/ds2760_battery.c      | 2 +-
 drivers/power/supply/max1721x_battery.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery_hdq.c b/drivers/power/supply/bq27xxx_battery_hdq.c
index 12b10dad77d3..922759ab2e04 100644
--- a/drivers/power/supply/bq27xxx_battery_hdq.c
+++ b/drivers/power/supply/bq27xxx_battery_hdq.c
@@ -97,7 +97,7 @@ static void bq27xxx_battery_hdq_remove_slave(struct w1_slave *sl)
 	bq27xxx_battery_teardown(di);
 }
 
-static struct w1_family_ops bq27xxx_battery_hdq_fops = {
+static const struct w1_family_ops bq27xxx_battery_hdq_fops = {
 	.add_slave	= bq27xxx_battery_hdq_add_slave,
 	.remove_slave	= bq27xxx_battery_hdq_remove_slave,
 };
diff --git a/drivers/power/supply/ds2760_battery.c b/drivers/power/supply/ds2760_battery.c
index 11bed88a89fa..695bb6747400 100644
--- a/drivers/power/supply/ds2760_battery.c
+++ b/drivers/power/supply/ds2760_battery.c
@@ -795,7 +795,7 @@ static const struct of_device_id w1_ds2760_of_ids[] = {
 };
 #endif
 
-static struct w1_family_ops w1_ds2760_fops = {
+static const struct w1_family_ops w1_ds2760_fops = {
 	.add_slave	= w1_ds2760_add_slave,
 	.remove_slave	= w1_ds2760_remove_slave,
 	.groups		= w1_ds2760_groups,
diff --git a/drivers/power/supply/max1721x_battery.c b/drivers/power/supply/max1721x_battery.c
index 9ca895b0dabb..1b1a36f8e929 100644
--- a/drivers/power/supply/max1721x_battery.c
+++ b/drivers/power/supply/max1721x_battery.c
@@ -431,7 +431,7 @@ static int devm_w1_max1721x_add_device(struct w1_slave *sl)
 	return 0;
 }
 
-static struct w1_family_ops w1_max1721x_fops = {
+static const struct w1_family_ops w1_max1721x_fops = {
 	.add_slave = devm_w1_max1721x_add_device,
 };
 
-- 
2.28.0

