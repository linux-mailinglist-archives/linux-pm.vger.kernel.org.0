Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4145E104A5D
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2019 06:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbfKUFrv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Nov 2019 00:47:51 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34232 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfKUFru (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Nov 2019 00:47:50 -0500
Received: by mail-wm1-f68.google.com with SMTP id j18so6805640wmk.1
        for <linux-pm@vger.kernel.org>; Wed, 20 Nov 2019 21:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=gTEdr4fMCDOfJYIm//pZFxmPw/yHAYaoiKikPn0vbq0=;
        b=qJHZTTHPvNQonP79pGDeCnaBnFkZ24dabsVTTk7NUIxXERN+bp+m8w+NRZBccgMNZj
         GcaOT6UjxEb9YGJT6bn5v5xvqWfY0eMI/b95EXWTqxz1MuKRzgbZCZStm1MLTaDPp/OI
         GQvVwjY9AJY3CQjsMPm6a3HqkslnYtMGMX82tyeTyvTgUpJHrMsIk72oVOgeFy+uQ2AH
         gqozKOU/9K1wiBHAkQ/F3jaUWPfdh15P/9Y3PjvW/62nphH15ZXnl4PAgsvg+7WZMnUq
         2TfYpHllSOBjIue2G66QE5csfYzbn1b28e+esIaz2f+GZ2DFc65kn/11g5RTSYAP3/PC
         ab3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=gTEdr4fMCDOfJYIm//pZFxmPw/yHAYaoiKikPn0vbq0=;
        b=Ht4sQrac6HADa534nhG43sPLh7ih0oakSIGGmlq6XDUsOK6G6mOqo129MAP8bxfpbu
         8IBOE3vkVLoKQLrdWGpLiH0nKOa0OB3ZzeWqVMw8VhqJ1r3CFNyRjeRYYIkuPF2bOi8C
         DkXHOSOl6jhXmTN7rU0bJBN4Bmxwjz6PV5D/+ll2dtOSBCHll+gnyu01LsTcF9X/OFiu
         4CLi28wUXvmHUHno3ZItYLSUrqBI3W4w9WWP6zWo8gGycGHBR31MVqQ5wN/MTopvVdsF
         2Bgo6+t0tUGzEdXML80upBpz2sl+5oQYt9DL6oVxgmrWgAPaLHa5i22HPfCwzCCE6dbu
         /TRw==
X-Gm-Message-State: APjAAAUSk04O9j5d2g3ABse0ECKkTGtGnRY7xBsZTzHEhKN8DcRnBgRg
        pODngyU8nPMRikfdbvp2odKjiw==
X-Google-Smtp-Source: APXvYqzVuiNkuuXvwm9hc1GJxK7x9vNKXJq5NPZIvuMuX1HpsXsx+CpbJNyJ6VgutVIyaiWyYdDnYA==
X-Received: by 2002:a1c:7fd8:: with SMTP id a207mr7747412wmd.10.1574315266886;
        Wed, 20 Nov 2019 21:47:46 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id n13sm1640681wmi.25.2019.11.20.21.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 21:47:45 -0800 (PST)
Message-ID: <5dd62501.1c69fb81.62add.72ab@mx.google.com>
Date:   Wed, 20 Nov 2019 21:47:45 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Lab-Name: lab-collabora
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: bisect
X-Kernelci-Kernel: v4.19.85
Subject: stable/linux-4.19.y bisection: boot on odroid-xu3
To:     tomeu.vizoso@collabora.com, Sasha Levin <sashal@kernel.org>,
        guillaume.tucker@collabora.com,
        Niklas Cassel <niklas.cassel@linaro.org>, broonie@kernel.org,
        khilman@baylibre.com, mgalka@collabora.com,
        enric.balletbo@collabora.com,
        Viresh Kumar <viresh.kumar@linaro.org>
From:   "kernelci.org bot" <bot@kernelci.org>
Cc:     linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <vireshk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* This automated bisection report was sent to you on the basis  *
* that you may be involved with the breaking commit it has      *
* found.  No manual investigation has been done to verify it,   *
* and the root cause of the problem may be somewhere else.      *
*                                                               *
* If you do send a fix, please include this trailer:            *
*   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
*                                                               *
* Hope this helps!                                              *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

stable/linux-4.19.y bisection: boot on odroid-xu3

Summary:
  Start:      c63ee2939dc1 Linux 4.19.85
  Details:    https://kernelci.org/boot/id/5dd5baaa59b5145b6ecf54c3
  Plain log:  https://storage.kernelci.org//stable/linux-4.19.y/v4.19.85/ar=
m/exynos_defconfig/gcc-8/lab-collabora/boot-exynos5422-odroidxu3.txt
  HTML log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.85/ar=
m/exynos_defconfig/gcc-8/lab-collabora/boot-exynos5422-odroidxu3.html
  Result:     4c64ce947cfa OPP: Protect dev_list with opp_table lock

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       stable
  URL:        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-=
stable.git
  Branch:     linux-4.19.y
  Target:     odroid-xu3
  CPU arch:   arm
  Lab:        lab-collabora
  Compiler:   gcc-8
  Config:     exynos_defconfig
  Test suite: boot

Breaking commit found:

---------------------------------------------------------------------------=
----
commit 4c64ce947cfa447993efe005cbaad7ba31a91612
Author: Viresh Kumar <viresh.kumar@linaro.org>
Date:   Fri Aug 3 07:05:21 2018 +0530

    OPP: Protect dev_list with opp_table lock
    =

    [ Upstream commit 3d2556992a878a2210d3be498416aee39e0c32aa ]
    =

    The dev_list needs to be protected with a lock, else we may have
    simultaneous access (addition/removal) to it and that would be racy.
    Extend scope of the opp_table lock to protect dev_list as well.
    =

    Tested-by: Niklas Cassel <niklas.cassel@linaro.org>
    Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
    Signed-off-by: Sasha Levin <sashal@kernel.org>

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index f3433bf47b10..14d4ef594374 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -48,9 +48,14 @@ static struct opp_device *_find_opp_dev(const struct dev=
ice *dev,
 static struct opp_table *_find_opp_table_unlocked(struct device *dev)
 {
 	struct opp_table *opp_table;
+	bool found;
 =

 	list_for_each_entry(opp_table, &opp_tables, node) {
-		if (_find_opp_dev(dev, opp_table)) {
+		mutex_lock(&opp_table->lock);
+		found =3D !!_find_opp_dev(dev, opp_table);
+		mutex_unlock(&opp_table->lock);
+
+		if (found) {
 			_get_opp_table_kref(opp_table);
 =

 			return opp_table;
@@ -766,6 +771,8 @@ struct opp_device *_add_opp_dev(const struct device *de=
v,
 =

 	/* Initialize opp-dev */
 	opp_dev->dev =3D dev;
+
+	mutex_lock(&opp_table->lock);
 	list_add(&opp_dev->node, &opp_table->dev_list);
 =

 	/* Create debugfs entries for the opp_table */
@@ -773,6 +780,7 @@ struct opp_device *_add_opp_dev(const struct device *de=
v,
 	if (ret)
 		dev_err(dev, "%s: Failed to register opp debugfs (%d)\n",
 			__func__, ret);
+	mutex_unlock(&opp_table->lock);
 =

 	return opp_dev;
 }
@@ -791,6 +799,7 @@ static struct opp_table *_allocate_opp_table(struct dev=
ice *dev)
 	if (!opp_table)
 		return NULL;
 =

+	mutex_init(&opp_table->lock);
 	INIT_LIST_HEAD(&opp_table->dev_list);
 =

 	opp_dev =3D _add_opp_dev(dev, opp_table);
@@ -812,7 +821,6 @@ static struct opp_table *_allocate_opp_table(struct dev=
ice *dev)
 =

 	BLOCKING_INIT_NOTIFIER_HEAD(&opp_table->head);
 	INIT_LIST_HEAD(&opp_table->opp_list);
-	mutex_init(&opp_table->lock);
 	kref_init(&opp_table->kref);
 =

 	/* Secure the device table modification */
@@ -854,6 +862,10 @@ static void _opp_table_kref_release(struct kref *kref)
 	if (!IS_ERR(opp_table->clk))
 		clk_put(opp_table->clk);
 =

+	/*
+	 * No need to take opp_table->lock here as we are guaranteed that no
+	 * references to the OPP table are taken at this point.
+	 */
 	opp_dev =3D list_first_entry(&opp_table->dev_list, struct opp_device,
 				   node);
 =

@@ -1719,6 +1731,9 @@ void _dev_pm_opp_remove_table(struct opp_table *opp_t=
able, struct device *dev,
 {
 	struct dev_pm_opp *opp, *tmp;
 =

+	/* Protect dev_list */
+	mutex_lock(&opp_table->lock);
+
 	/* Find if opp_table manages a single device */
 	if (list_is_singular(&opp_table->dev_list)) {
 		/* Free static OPPs */
@@ -1736,6 +1751,8 @@ void _dev_pm_opp_remove_table(struct opp_table *opp_t=
able, struct device *dev,
 	} else {
 		_remove_opp_dev(_find_opp_dev(dev, opp_table), opp_table);
 	}
+
+	mutex_unlock(&opp_table->lock);
 }
 =

 void _dev_pm_opp_find_and_remove_table(struct device *dev, bool remove_all)
diff --git a/drivers/opp/cpu.c b/drivers/opp/cpu.c
index 0c0910709435..2868a022a040 100644
--- a/drivers/opp/cpu.c
+++ b/drivers/opp/cpu.c
@@ -222,8 +222,10 @@ int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev=
, struct cpumask *cpumask)
 	cpumask_clear(cpumask);
 =

 	if (opp_table->shared_opp =3D=3D OPP_TABLE_ACCESS_SHARED) {
+		mutex_lock(&opp_table->lock);
 		list_for_each_entry(opp_dev, &opp_table->dev_list, node)
 			cpumask_set_cpu(opp_dev->dev->id, cpumask);
+		mutex_unlock(&opp_table->lock);
 	} else {
 		cpumask_set_cpu(cpu_dev->id, cpumask);
 	}
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 7c540fd063b2..e0866b1c1f1b 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -126,7 +126,7 @@ enum opp_table_access {
  * @dev_list:	list of devices that share these OPPs
  * @opp_list:	table of opps
  * @kref:	for reference count of the table.
- * @lock:	mutex protecting the opp_list.
+ * @lock:	mutex protecting the opp_list and dev_list.
  * @np:		struct device_node pointer for opp's DT node.
  * @clock_latency_ns_max: Max clock latency in nanoseconds.
  * @shared_opp: OPP is shared between multiple devices.
---------------------------------------------------------------------------=
----


Git bisection log:

---------------------------------------------------------------------------=
----
git bisect start
# good: [c555efaf14026c7751fa68d87403a5eb5ae7dcaf] Linux 4.19.84
git bisect good c555efaf14026c7751fa68d87403a5eb5ae7dcaf
# bad: [c63ee2939dc1c6eee6c544af1b4ab441490bfe6e] Linux 4.19.85
git bisect bad c63ee2939dc1c6eee6c544af1b4ab441490bfe6e
# good: [8ac08053744cdd9cc88c26857f5ff48583e995ac] ARM: dts: socfpga: Fix I=
2C bus unit-address error
git bisect good 8ac08053744cdd9cc88c26857f5ff48583e995ac
# bad: [cab175f881c578cb16679cb2777c9d6ececafd31] net: micrel: fix return t=
ype of ndo_start_xmit function
git bisect bad cab175f881c578cb16679cb2777c9d6ececafd31
# good: [eb355ccfdf1dc692670a0fb46feeda02e6cf7af9] powerpc: Fix duplicate c=
onst clang warning in user access code
git bisect good eb355ccfdf1dc692670a0fb46feeda02e6cf7af9
# bad: [59d6e59f32cc01848dd31a932f22769bba5c4598] s390/vdso: correct CFI an=
notations of vDSO functions
git bisect bad 59d6e59f32cc01848dd31a932f22769bba5c4598
# bad: [5d52c10c345ddd0a2974db3819348318883dd0c7] net: amd: fix return type=
 of ndo_start_xmit function
git bisect bad 5d52c10c345ddd0a2974db3819348318883dd0c7
# bad: [773fb69e430751062015467e9f97f35158bd3bf9] power: supply: twl4030_ch=
arger: fix charging current out-of-bounds
git bisect bad 773fb69e430751062015467e9f97f35158bd3bf9
# bad: [4c64ce947cfa447993efe005cbaad7ba31a91612] OPP: Protect dev_list wit=
h opp_table lock
git bisect bad 4c64ce947cfa447993efe005cbaad7ba31a91612
# good: [51e509caf5fad3a50860d588227bb6ae4388c7f2] ARM: dts: atmel: Fix I2C=
 and SPI bus warnings
git bisect good 51e509caf5fad3a50860d588227bb6ae4388c7f2
# first bad commit: [4c64ce947cfa447993efe005cbaad7ba31a91612] OPP: Protect=
 dev_list with opp_table lock
---------------------------------------------------------------------------=
----
