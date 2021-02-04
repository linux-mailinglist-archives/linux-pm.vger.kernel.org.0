Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFDE30ED98
	for <lists+linux-pm@lfdr.de>; Thu,  4 Feb 2021 08:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234702AbhBDHli (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Feb 2021 02:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234750AbhBDHl2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Feb 2021 02:41:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CD2C0613ED
        for <linux-pm@vger.kernel.org>; Wed,  3 Feb 2021 23:40:48 -0800 (PST)
Date:   Thu, 04 Feb 2021 07:40:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612424446;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1lh6uaHQifMDtHh9mupc8ntP1hfl8K2baZn6QMWvSDE=;
        b=ualkLkvwC2gXrWNDLdYYLpfvwE2yzKkQsr3OLl2oz4Cq3uqg8d2AJ7KJFhLri4q625p6iW
        SUYi7PoQtavfE/P9utpwZr4DO9OB3ghr+5g64jDh8pEpmK64Nh9TGXCO1FrlA7j/N4mjs4
        QlIjPYtB1G7wEhUDJVOdYkRVRG8+rWHUZg91JL+jC8v6PG7ia39oBbCuMtwXAidpS2/e3N
        7A/OYvxeSvTro+fCcRc6JCaG+qqGVryuX5m+cFg1MHjupQiK78C3UY2/URI0gmo8mJdJtH
        HxTV+A3dM6yswkJYMjlqZmplomTWwH6amrQ7eIo7bLnAZqAdJSG3Oy2mTM+T1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612424446;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1lh6uaHQifMDtHh9mupc8ntP1hfl8K2baZn6QMWvSDE=;
        b=6AfRgGd/R7EM6CVbP4vneM3xZqjM+NxZ9ke1YVuMJV405FGCVJ0pv2HirAwTNvWCPpyV8s
        v0w3W94jxturMlDg==
From:   "thermal-bot for Kai-Heng Feng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: int340x: Fix unexpected shutdown at
 critical temperature
Cc:     "Kai-Heng Feng" <kai.heng.feng@canonical.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20201221172345.36976-1-kai.heng.feng@canonical.com>
References: <20201221172345.36976-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Message-ID: <161242444551.23325.8894385262578414322.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     dd47366aaa9b93ac3d97cb4ee7641d38a28a771e
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//dd47366aaa9b93ac3d97cb4ee7641d38a28a771e
Author:        Kai-Heng Feng <kai.heng.feng@canonical.com>
AuthorDate:    Tue, 22 Dec 2020 01:23:43 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 19 Jan 2021 22:30:25 +01:00

thermal: int340x: Fix unexpected shutdown at critical temperature

We are seeing thermal shutdown on Intel based mobile workstations, the
shutdown happens during the first trip handle in
thermal_zone_device_register():
kernel: thermal thermal_zone15: critical temperature reached (101 C), shuttin=
g down

However, we shouldn't do a thermal shutdown here, since
1) We may want to use a dedicated daemon, Intel's thermald in this case,
to handle thermal shutdown.

2) For ACPI based system, _CRT doesn't mean shutdown unless it's inside
ThermalZone namespace. ACPI Spec, 11.4.4 _CRT (Critical Temperature):
"... If this object it present under a device, the device=E2=80=99s driver
evaluates this object to determine the device=E2=80=99s critical cooling
temperature trip point. This value may then be used by the device=E2=80=99s
driver to program an internal device temperature sensor trip point."

So a "critical trip" here merely means we should take a more aggressive
cooling method.

As int340x device isn't present under ACPI ThermalZone, override the
default .critical callback to prevent surprising thermal shutdown.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201221172345.36976-1-kai.heng.feng@canonica=
l.com
---
 drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c b/d=
rivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
index 6e479de..d1248ba 100644
--- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -146,12 +146,18 @@ static int int340x_thermal_get_trip_hyst(struct thermal=
_zone_device *zone,
 	return 0;
 }
=20
+static void int340x_thermal_critical(struct thermal_zone_device *zone)
+{
+	dev_dbg(&zone->device, "%s: critical temperature reached\n", zone->type);
+}
+
 static struct thermal_zone_device_ops int340x_thermal_zone_ops =3D {
 	.get_temp       =3D int340x_thermal_get_zone_temp,
 	.get_trip_temp	=3D int340x_thermal_get_trip_temp,
 	.get_trip_type	=3D int340x_thermal_get_trip_type,
 	.set_trip_temp	=3D int340x_thermal_set_trip_temp,
 	.get_trip_hyst =3D  int340x_thermal_get_trip_hyst,
+	.critical	=3D int340x_thermal_critical,
 };
=20
 static int int340x_thermal_get_trip_config(acpi_handle handle, char *name,
