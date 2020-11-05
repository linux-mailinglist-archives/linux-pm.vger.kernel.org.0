Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C58612A7FB6
	for <lists+linux-pm@lfdr.de>; Thu,  5 Nov 2020 14:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725468AbgKENc5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 08:32:57 -0500
Received: from mout.gmx.net ([212.227.17.21]:33151 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbgKENc5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Nov 2020 08:32:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604583172;
        bh=WXWqVPBjfnkHgVdtqc5dpKUrZCQoFGqzf6HcefboL6A=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=ltizhNKw2TpjPCiO5ZzXgJLYCSEg3GLYaVXCregAcLaKOHbTJTP2Jfjd1vJ2zNP3i
         gdFfLn6k7CesLgZOfpHBeZr0paQTcSaBNTdSjtTHhDSUjK34qYkxoCnrBqcQgakfaj
         JO1lLKpVXyiQs1we/JS4bLEwQ9zzAqjmFGsCEEDs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.156.55]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MpDJX-1jzL6h1Ahr-00qgWE; Thu, 05
 Nov 2020 14:32:52 +0100
Date:   Thu, 5 Nov 2020 14:32:50 +0100
From:   Helge Deller <deller@gmx.de>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] power: reset: Use printk format symbol resolver
Message-ID: <20201105133250.GA26205@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:S0kLow3uJ4eZPClWFH/wfLiJn+vLhrXnvk9I2mmBzSlSYvNvLQh
 qzUd0IGY8sRGvy0fo6SnPvNiRx3ijPK/3HIbKyNfiRCsK9lQZr+GIea7ixvjSYWwyve7lYi
 cIuSmJwV8z6N5lAZcJA+0s6KtezATpTYDVXQRWXKX6queMztzkuOzgXHZZoHekZ0q+BtPxt
 Px5b1Vg8tUslOglcuzcwQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:oDPAsaUk6aw=:y7CFXBLNOvYYmSTJDZuyZ0
 +b13BklFuX7SyIjA/dU3lLzS7ruybY9NKY3XJAtXVMQPm/dkiYUzzRdqLmU0HKlmSlZa2GWLr
 ekoZxVfHKbwI9jOK8Cf1Nca7s3soM8kBEOLt03s4+dbzNb0yMZu7ut+4n8na7ij2qg/9UzCrv
 pnRtA9kTcK19ljps/qN7Fq+/WJeJrz1l5K9SRSTbeEt46fwYkGhJJRBCQFCm2UeuHFLA747ED
 PUEF/okTr/+QFQUzZa6mqofYHgo6yKyouHGXAFgGgbcfpziz8JJA9n5VJS8sLIEV/JOPY49mQ
 KqXLtw7n9o3TZls86myOk9gKMJ0Jkp/AQoOU90FDtZ2bbgGPS2p98nVcSTcP0QZ1/gfneF+i6
 tpdrQ8ibmUWwNoq+f1wU0wbMbKDz1R1nFxxRl+ZH8c3ZgA/BsFykqvR9GKG8sS37UNrw3W5rl
 3UomUp5BOwh58LKTOBZxV3IcCW7cMDIOj7h7b3aRamhKntCxeUu9dsK+fmI2uw1qLobkyxd+3
 d5i73LIjNu0vjtZUjooC6ohWRVwhJSFUTKgE9RW3hK7JlrAA4KDuObT55YdiOYeTMV6hiIp5D
 UIfzO9CqcyjpRENdl3tljhgPrDE53LXo9/uL0h4KdiFhCMGjyeul6sGQTplz3bW0SJF7ptMxf
 ETwxiw5QrSV7TJQ1UNOi87b1nSBi2tbPNJXeRhyBm0V3YvnZzceCkqPUvLMDTc8cQXp7vluiK
 dar+0ONrFkayG3jm357jYfwBqeHzAHVWStXqMJxaK9bYVokfQMN5//pvSQdCS4B5nFCltv0WA
 3IFL7KhHtGP3o9irLnnNgvAeZ1Q1LPu1h+54qqcx0klLUqaKDvaEqj7uQ0EmBhlsfIhznH2fr
 te16iohuRluJ5eYgPUaQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Instead of looking up a symbol name by hand, use the %ps printk format
specifier.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/drivers/power/reset/qnap-poweroff.c b/drivers/power/reset/qna=
p-poweroff.c
index 52b7dc61d870..0ddf7f25f7b8 100644
=2D-- a/drivers/power/reset/qnap-poweroff.c
+++ b/drivers/power/reset/qnap-poweroff.c
@@ -14,7 +14,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/serial_reg.h>
-#include <linux/kallsyms.h>
 #include <linux/of.h>
 #include <linux/io.h>
 #include <linux/clk.h>
@@ -75,7 +74,6 @@ static int qnap_power_off_probe(struct platform_device *=
pdev)
 	struct device_node *np =3D pdev->dev.of_node;
 	struct resource *res;
 	struct clk *clk;
-	char symname[KSYM_NAME_LEN];

 	const struct of_device_id *match =3D
 		of_match_node(qnap_power_off_of_match_table, np);
@@ -104,10 +102,8 @@ static int qnap_power_off_probe(struct platform_devic=
e *pdev)

 	/* Check that nothing else has already setup a handler */
 	if (pm_power_off) {
-		lookup_symbol_name((ulong)pm_power_off, symname);
-		dev_err(&pdev->dev,
-			"pm_power_off already claimed %p %s",
-			pm_power_off, symname);
+		dev_err(&pdev->dev, "pm_power_off already claimed for %ps",
+			pm_power_off);
 		return -EBUSY;
 	}
 	pm_power_off =3D qnap_power_off;
diff --git a/drivers/power/reset/syscon-poweroff.c b/drivers/power/reset/s=
yscon-poweroff.c
index 4d6923b102b6..ed58bdf41e27 100644
=2D-- a/drivers/power/reset/syscon-poweroff.c
+++ b/drivers/power/reset/syscon-poweroff.c
@@ -6,7 +6,6 @@
  * Author: Moritz Fischer <moritz.fischer@ettus.com>
  */

-#include <linux/kallsyms.h>
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/notifier.h>
@@ -34,7 +33,6 @@ static void syscon_poweroff(void)

 static int syscon_poweroff_probe(struct platform_device *pdev)
 {
-	char symname[KSYM_NAME_LEN];
 	int mask_err, value_err;

 	map =3D syscon_regmap_lookup_by_phandle(pdev->dev.of_node, "regmap");
@@ -65,10 +63,8 @@ static int syscon_poweroff_probe(struct platform_device=
 *pdev)
 	}

 	if (pm_power_off) {
-		lookup_symbol_name((ulong)pm_power_off, symname);
-		dev_err(&pdev->dev,
-		"pm_power_off already claimed %p %s",
-		pm_power_off, symname);
+		dev_err(&pdev->dev, "pm_power_off already claimed for %ps",
+			pm_power_off);
 		return -EBUSY;
 	}

