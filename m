Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0B11048BC
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2019 03:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbfKUCwm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Nov 2019 21:52:42 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55713 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfKUCwl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Nov 2019 21:52:41 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so1960078wmb.5
        for <linux-pm@vger.kernel.org>; Wed, 20 Nov 2019 18:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=50QrlJDi7Gpaq9op5/mm2tC/ZSPgqpHtAFV7iMRaYTQ=;
        b=xZFDYMPhIIOyWZQ3bVxQUVPxAeiMI+4DuVJgqAKm62ZW9PI5XxD1c20jX6SqPxYSHI
         XrFx2wMNG2xDFkjUpN9uEYVWeRZdTYaX2PNtI6fsvNIF010djK1WwpeyMH0T2TnCkdyU
         byl7IhhS86B76iTVx2dJdI/6BfebvJp4JtXCJLVWy9mDUXicEQWA76N/Gj0c1nwKAhLX
         PGylebYXVzLMx20KZCIqhilzMuET5+mWeY7FXIzqC/LeNxWjGdzaxk0vZW3XlMoudnj5
         RUgtKuoR0+K6X6y/x4AECyKwUGkHyYGRXGqM3KeufP/dDOJhqE3TN8L3tH3aDyvhi1CQ
         IcXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=50QrlJDi7Gpaq9op5/mm2tC/ZSPgqpHtAFV7iMRaYTQ=;
        b=bzd6Ly7e666zIEM2olfTjjSWqtZb8aJLGFfpKad/8kEEmF9UKq1RgggFjYFnbEF1IR
         KTHzK2p3gHkz+OcI2mjR6AsXxIhFlItMrVHbVonftf7TMhk1ysco0Xv8AtY084llhuU6
         PhqxE8hpXXl5jvv98GTVaDW9vO68BD7KGujM9vjF13P2m7vqPHya/vAAtaDQt9h6J6m+
         Dz1t2zA6sspqbEpoV1bFUmYEXSsFXuRigsGxO9/IHBrseyRS+ohjVVQHcJIdW7t6nZ2U
         2Ifh4WCqJh5KxauG5bjT7eCm5W8TAaVj0W8aupiW2Mh0aEbQ/hPiOriGtfPWWUwU4nmG
         Ja9w==
X-Gm-Message-State: APjAAAUbIJY/CX04XlRv7WGwn7umPkkqoIJRGLWU4TaS8Ou/nZx1Yub7
        cTeWga4K2JYVQhwtoDMlepkpAg==
X-Google-Smtp-Source: APXvYqzfHy+V5e3Z1yURW9s8k4l3uYF+uqVgyqFavekIkldGLT4aaQKRbBDmCuZw9FYnDY6W3HQsmA==
X-Received: by 2002:a7b:c3ce:: with SMTP id t14mr6761601wmj.22.1574304758621;
        Wed, 20 Nov 2019 18:52:38 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id y6sm1604427wrw.6.2019.11.20.18.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 18:52:37 -0800 (PST)
Message-ID: <5dd5fbf5.1c69fb81.0938.8061@mx.google.com>
Date:   Wed, 20 Nov 2019 18:52:37 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Lab-Name: lab-collabora
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: bisect
X-Kernelci-Kernel: v4.14.155
Subject: stable/linux-4.14.y bisection: boot on odroid-x2
To:     tomeu.vizoso@collabora.com, Sasha Levin <sashal@kernel.org>,
        guillaume.tucker@collabora.com,
        Niklas Cassel <niklas.cassel@linaro.org>, broonie@kernel.org,
        khilman@baylibre.com, mgalka@collabora.com,
        enric.balletbo@collabora.com,
        Viresh Kumar <viresh.kumar@linaro.org>
From:   "kernelci.org bot" <bot@kernelci.org>
Cc:     linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>,
        linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Viresh Kumar <vireshk@kernel.org>
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

stable/linux-4.14.y bisection: boot on odroid-x2

Summary:
  Start:      f56f3d0e65ad Linux 4.14.155
  Details:    https://kernelci.org/boot/id/5dd5a12159b5143a10cf54c3
  Plain log:  https://storage.kernelci.org//stable/linux-4.14.y/v4.14.155/a=
rm/exynos_defconfig/gcc-8/lab-collabora/boot-exynos4412-odroidx2.txt
  HTML log:   https://storage.kernelci.org//stable/linux-4.14.y/v4.14.155/a=
rm/exynos_defconfig/gcc-8/lab-collabora/boot-exynos4412-odroidx2.html
  Result:     714ab224a8db OPP: Protect dev_list with opp_table lock

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       stable
  URL:        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-=
stable.git
  Branch:     linux-4.14.y
  Target:     odroid-x2
  CPU arch:   arm
  Lab:        lab-collabora
  Compiler:   gcc-8
  Config:     exynos_defconfig
  Test suite: boot

Breaking commit found:

---------------------------------------------------------------------------=
----
commit 714ab224a8db6e8255c61a42613de9349ceb0bba
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

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index d5e7e8cc4f22..8100c8769149 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -49,9 +49,14 @@ static struct opp_device *_find_opp_dev(const struct dev=
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
@@ -711,6 +716,8 @@ struct opp_device *_add_opp_dev(const struct device *de=
v,
 =

 	/* Initialize opp-dev */
 	opp_dev->dev =3D dev;
+
+	mutex_lock(&opp_table->lock);
 	list_add(&opp_dev->node, &opp_table->dev_list);
 =

 	/* Create debugfs entries for the opp_table */
@@ -718,6 +725,7 @@ struct opp_device *_add_opp_dev(const struct device *de=
v,
 	if (ret)
 		dev_err(dev, "%s: Failed to register opp debugfs (%d)\n",
 			__func__, ret);
+	mutex_unlock(&opp_table->lock);
 =

 	return opp_dev;
 }
@@ -736,6 +744,7 @@ static struct opp_table *_allocate_opp_table(struct dev=
ice *dev)
 	if (!opp_table)
 		return NULL;
 =

+	mutex_init(&opp_table->lock);
 	INIT_LIST_HEAD(&opp_table->dev_list);
 =

 	opp_dev =3D _add_opp_dev(dev, opp_table);
@@ -757,7 +766,6 @@ static struct opp_table *_allocate_opp_table(struct dev=
ice *dev)
 =

 	BLOCKING_INIT_NOTIFIER_HEAD(&opp_table->head);
 	INIT_LIST_HEAD(&opp_table->opp_list);
-	mutex_init(&opp_table->lock);
 	kref_init(&opp_table->kref);
 =

 	/* Secure the device table modification */
@@ -799,6 +807,10 @@ static void _opp_table_kref_release(struct kref *kref)
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

@@ -1702,6 +1714,9 @@ void _dev_pm_opp_remove_table(struct opp_table *opp_t=
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
@@ -1712,6 +1727,8 @@ void _dev_pm_opp_remove_table(struct opp_table *opp_t=
able, struct device *dev,
 	} else {
 		_remove_opp_dev(_find_opp_dev(dev, opp_table), opp_table);
 	}
+
+	mutex_unlock(&opp_table->lock);
 }
 =

 void _dev_pm_opp_find_and_remove_table(struct device *dev, bool remove_all)
diff --git a/drivers/base/power/opp/cpu.c b/drivers/base/power/opp/cpu.c
index 2d87bc1adf38..66e406bd4d62 100644
--- a/drivers/base/power/opp/cpu.c
+++ b/drivers/base/power/opp/cpu.c
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
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index 166eef990599..0a206c6b9086 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -124,7 +124,7 @@ enum opp_table_access {
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
# good: [775d01b65b5daa002a9ba60f2d2bb3b1a6ce12fb] Linux 4.14.154
git bisect good 775d01b65b5daa002a9ba60f2d2bb3b1a6ce12fb
# bad: [f56f3d0e65adb447b8b583c8ed4fbbe544c9bfde] Linux 4.14.155
git bisect bad f56f3d0e65adb447b8b583c8ed4fbbe544c9bfde
# good: [46af2022de198ebbf47141b7b33522e28733045d] arm64: dts: meson: Fix e=
rroneous SPI bus warnings
git bisect good 46af2022de198ebbf47141b7b33522e28733045d
# bad: [0b9c70939b60221f2210ef55a325fec6dea8cde1] media: au0828: Fix incorr=
ect error messages
git bisect bad 0b9c70939b60221f2210ef55a325fec6dea8cde1
# bad: [70c3daaa03e965d3f2bd10696be130b376f73bca] net: broadcom: fix return=
 type of ndo_start_xmit function
git bisect bad 70c3daaa03e965d3f2bd10696be130b376f73bca
# good: [45503ce9086cabc9b3faaaed4563b2da8af1ffe2] samples/bpf: fix a compi=
lation failure
git bisect good 45503ce9086cabc9b3faaaed4563b2da8af1ffe2
# good: [9bee4f9f4460db86c47fe01f9671af6a8951efda] powerpc: Fix duplicate c=
onst clang warning in user access code
git bisect good 9bee4f9f4460db86c47fe01f9671af6a8951efda
# bad: [b1fdcfbdb93cc899d19091a2385edb40a07420e3] power: supply: twl4030_ch=
arger: fix charging current out-of-bounds
git bisect bad b1fdcfbdb93cc899d19091a2385edb40a07420e3
# bad: [714ab224a8db6e8255c61a42613de9349ceb0bba] OPP: Protect dev_list wit=
h opp_table lock
git bisect bad 714ab224a8db6e8255c61a42613de9349ceb0bba
# good: [7dbc3efb7430abdddf0be186bd0ad2611d767d23] RDMA/i40iw: Fix incorrec=
t iterator type
git bisect good 7dbc3efb7430abdddf0be186bd0ad2611d767d23
# first bad commit: [714ab224a8db6e8255c61a42613de9349ceb0bba] OPP: Protect=
 dev_list with opp_table lock
---------------------------------------------------------------------------=
----
