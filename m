Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D64417D25C
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2019 02:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbfHAApp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 20:45:45 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41921 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfHAApo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 20:45:44 -0400
Received: by mail-pl1-f194.google.com with SMTP id m9so31096722pls.8
        for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2019 17:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:from:to:subject:user-agent:date;
        bh=Gk2QCSUiXttK0DpMjrYYxGGSGPwiVtPzozTzPLwckQk=;
        b=OZNZh5RgQj+c21xd9fx1O0GKIykxqvn0eo7tx5caoozgFnc6gFlrrU00H6PijLBp/T
         8Ed2i5y7wYz0704iX7SL1rPJPnwQ7nEta0IkzPUcGhqq5UdZpxjkmXAG/EJLo9xTQAWJ
         TIZv4yn7bzDpkyXOp2JwxU+BzcaybpOJiwP90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:from:to:subject
         :user-agent:date;
        bh=Gk2QCSUiXttK0DpMjrYYxGGSGPwiVtPzozTzPLwckQk=;
        b=aWC2mskic92cdaHZ5fETBAVil8irs6gKQFx5ZpugAL/29DXoaMN/3Nz/t7EumwjB0o
         7SgdO3giSVPX9s8Ph//RNw82ZL61lpa6woYFXRWm3Tw3CoKJ5R8sk+WWHpXq3PX6Gf67
         A4oKq4nCCO7jY6DI0gIdAalkmVtBvHXneycAOH3hs9PhcqLlXQ2fTbqObbA2oDDBOmUh
         MxGABeMH3/ytewAo31imRrb5vPu7yKtGd1e9lW5PHlgT/jOzDmBnX6jvaDJ1e+ZYYTjN
         rdM1Kmt8ULodHoKQB60vQ9GI4yqEO+JcuPaytjVnwysFDuippsXXf+OBDljqbqVcxHTC
         dGtA==
X-Gm-Message-State: APjAAAUNxROKWCP5xrEvHUe/xri5OETL6ROvj3eJbynvW9KzVmjL/tjC
        KvKtQVFDX9IkP/Uu/8BcfAgfmg==
X-Google-Smtp-Source: APXvYqxHW8vfm/YSXch50SJ6dYCLCVyXFK5B8g5Aib6Vk7BXUffeZpUKJLPY+G5yqs2Ub5T4fKcFYA==
X-Received: by 2002:a17:902:e30b:: with SMTP id cg11mr22374400plb.335.1564620343901;
        Wed, 31 Jul 2019 17:45:43 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id p65sm68869957pfp.58.2019.07.31.17.45.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 17:45:43 -0700 (PDT)
Message-ID: <5d423637.1c69fb81.62114.ca6f@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5d42281c.1c69fb81.bcda1.71f5@mx.google.com>
References: <20190731215514.212215-1-trong@android.com> <32598586.Mjd66ZhNnG@kreacher> <CANA+-vDTDq__LnLBpM5u_VHHvpFA--K5Du63vPB7HfaKzBsPtg@mail.gmail.com> <6987393.M0uybTKmdI@kreacher> <CANA+-vAPpXF1=z1=OjOhr8HWQ=Qn39qtQ3+8bUeXNTuFFTxoJQ@mail.gmail.com> <CAJZ5v0go-qOTyQV4D2Sj_xQxT831PxJZP0uay67rG73Q3K2pHQ@mail.gmail.com> <5d42281c.1c69fb81.bcda1.71f5@mx.google.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
From:   Stephen Boyd <swboyd@chromium.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>, Tri Vo <trong@android.com>
Subject: Re: [PATCH v6] PM / wakeup: show wakeup sources stats in sysfs
User-Agent: alot/0.8.1
Date:   Wed, 31 Jul 2019 17:45:42 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Stephen Boyd (2019-07-31 16:45:31)
>=20
> This approach also nicely detects duplicate wakeup source names in the
> case that the string passed in to wakeup_source_register() is already
> used on the virtual bus.

This was clearly untested! Here's a better one. This is what I see on my
device with this patch squashed in:

localhost ~ # cat /sys/kernel/debug/wakeup_sources=20
name            active_count    event_count     wakeup_count    expire_coun=
t    active_since    total_time      max_time        last_change  prevent_s=
uspend_time
1-1.2.4.1       0               0               0               0          =
     0               0               0               0   0
1-1.1           0               0               0               0          =
     0               0               0               0   0
gpio-keys       0               0               0               0          =
     0               0               0               0   0
spi10.0         0               0               0               0          =
     0               0               0               0   0
a88000.spi:ec@0:keyboard-controller     0               0               0  =
             0               0               0           0
                0               0
alarmtimer      0               0               0               0          =
     0               0               0               0   0
cros-ec-rtc.1.auto      0               0               0               0  =
             0               0               0           0
                0
a8f8800.usb     0               0               0               0          =
     0               0               0               0   0
a6f8800.usb     0               0               0               0          =
     0               0               0               0   0
localhost ~ # ls -l /sys/class/wakeup/=20
total 0
lrwxrwxrwx. 1 root root 0 Jul 31 17:43 alarmtimer -> ../../devices/platform=
/soc/ac0000.geniqup/a88000.spi/spi_master/spi10/spi10.0/cros-ec-dev.0.auto/=
cros-ec-rtc.1.auto/rtc/rtc0/alarmtimer
lrwxrwxrwx. 1 root root 0 Jul 31 17:43 wakeup0 -> ../../devices/platform/so=
c/a6f8800.usb/wakeup/wakeup0
lrwxrwxrwx. 1 root root 0 Jul 31 17:43 wakeup1 -> ../../devices/platform/so=
c/a8f8800.usb/wakeup/wakeup1
lrwxrwxrwx. 1 root root 0 Jul 31 17:43 wakeup2 -> ../../devices/platform/so=
c/ac0000.geniqup/a88000.spi/spi_master/spi10/spi10.0/cros-ec-dev.0.auto/cro=
s-ec-rtc.1.auto/wakeup/wakeup2
lrwxrwxrwx. 1 root root 0 Jul 31 17:43 wakeup3 -> ../../devices/platform/so=
c/ac0000.geniqup/a88000.spi/spi_master/spi10/spi10.0/a88000.spi:ec@0:keyboa=
rd-controller/wakeup/wakeup3
lrwxrwxrwx. 1 root root 0 Jul 31 17:43 wakeup4 -> ../../devices/platform/so=
c/ac0000.geniqup/a88000.spi/spi_master/spi10/spi10.0/wakeup/wakeup4
lrwxrwxrwx. 1 root root 0 Jul 31 17:43 wakeup5 -> ../../devices/platform/gp=
io-keys/wakeup/wakeup5
lrwxrwxrwx. 1 root root 0 Jul 31 17:43 wakeup6 -> ../../devices/platform/so=
c/a8f8800.usb/a800000.dwc3/xhci-hcd.7.auto/usb1/1-1/1-1.1/wakeup/wakeup6
lrwxrwxrwx. 1 root root 0 Jul 31 17:43 wakeup7 -> ../../devices/platform/so=
c/a8f8800.usb/a800000.dwc3/xhci-hcd.7.auto/usb1/1-1/1-1.2/1-1.2.4/1-1.2.4.1=
/wakeup/wakeup7

----8<----
diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 79668b45eae6..ec414f0db0b1 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -201,7 +201,7 @@ EXPORT_SYMBOL_GPL(wakeup_source_remove);
 /**
  * wakeup_source_register - Create wakeup source and add it to the list.
  * @dev: Device this wakeup source is associated with (or NULL if virtual).
- * @name: Name of the wakeup source to register.
+ * @name: Name of the wakeup source to register (or NULL if device wakeup).
  */
 struct wakeup_source *wakeup_source_register(struct device *dev,
 					     const char *name)
@@ -209,9 +209,9 @@ struct wakeup_source *wakeup_source_register(struct dev=
ice *dev,
 	struct wakeup_source *ws;
 	int ret;
=20
-	ws =3D wakeup_source_create(name);
+	ws =3D wakeup_source_create(name ? : dev_name(dev));
 	if (ws) {
-		ret =3D wakeup_source_sysfs_add(dev, ws);
+		ret =3D wakeup_source_sysfs_add(dev, ws, !!name);
 		if (ret) {
 			kfree_const(ws->name);
 			kfree(ws);
@@ -275,7 +275,7 @@ int device_wakeup_enable(struct device *dev)
 	if (pm_suspend_target_state !=3D PM_SUSPEND_ON)
 		dev_dbg(dev, "Suspicious %s() during system transition!\n", __func__);
=20
-	ws =3D wakeup_source_register(dev, dev_name(dev));
+	ws =3D wakeup_source_register(dev, NULL);
 	if (!ws)
 		return -ENOMEM;
=20
diff --git a/drivers/base/power/wakeup_stats.c b/drivers/base/power/wakeup_=
stats.c
index a26f019faca9..0f4c59b02d5d 100644
--- a/drivers/base/power/wakeup_stats.c
+++ b/drivers/base/power/wakeup_stats.c
@@ -81,15 +81,6 @@ static ssize_t last_change_ms_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(last_change_ms);
=20
-static ssize_t name_show(struct device *dev, struct device_attribute *attr,
-			 char *buf)
-{
-	struct wakeup_source *ws =3D dev_get_drvdata(dev);
-
-	return sprintf(buf, "%s\n", ws->name);
-}
-static DEVICE_ATTR_RO(name);
-
 static ssize_t prevent_suspend_time_ms_show(struct device *dev,
 					    struct device_attribute *attr,
 					    char *buf)
@@ -106,7 +97,6 @@ static ssize_t prevent_suspend_time_ms_show(struct devic=
e *dev,
 static DEVICE_ATTR_RO(prevent_suspend_time_ms);
=20
 static struct attribute *wakeup_source_attrs[] =3D {
-	&dev_attr_name.attr,
 	&dev_attr_active_count.attr,
 	&dev_attr_event_count.attr,
 	&dev_attr_wakeup_count.attr,
@@ -126,22 +116,35 @@ static DEFINE_IDA(wakeup_ida);
  * wakeup_source_sysfs_add - Add wakeup_source attributes to sysfs.
  * @parent: Device given wakeup source is associated with (or NULL if virt=
ual).
  * @ws: Wakeup source to be added in sysfs.
+ * @use_ws_name: True to use ws->name or false to use 'wakeupN' for device=
 name
  */
-int wakeup_source_sysfs_add(struct device *parent, struct wakeup_source *w=
s)
+int wakeup_source_sysfs_add(struct device *parent, struct wakeup_source *w=
s,
+			    bool use_ws_name)
 {
 	struct device *dev;
 	int id;
=20
-	id =3D ida_alloc(&wakeup_ida, GFP_KERNEL);
-	if (id < 0)
-		return id;
-	ws->id =3D id;
+	ws->id =3D -1;
+	if (use_ws_name) {
+		dev =3D device_create_with_groups(wakeup_class, parent,
+						MKDEV(0, 0), ws,
+						wakeup_source_groups,
+						ws->name);
+	} else {
+		id =3D ida_alloc(&wakeup_ida, GFP_KERNEL);
+		if (id < 0)
+			return id;
+		ws->id =3D id;
+
+		dev =3D device_create_with_groups(wakeup_class, parent,
+						MKDEV(0, 0), ws,
+						wakeup_source_groups,
+						"wakeup%d", ws->id);
+	}
=20
-	dev =3D device_create_with_groups(wakeup_class, parent, MKDEV(0, 0), ws,
-					wakeup_source_groups, "ws%d",
-					ws->id);
 	if (IS_ERR(dev)) {
-		ida_free(&wakeup_ida, ws->id);
+		if (ws->id >=3D 0)
+			ida_free(&wakeup_ida, ws->id);
 		return PTR_ERR(dev);
 	}
=20
@@ -157,7 +160,8 @@ EXPORT_SYMBOL_GPL(wakeup_source_sysfs_add);
 void wakeup_source_sysfs_remove(struct wakeup_source *ws)
 {
 	device_unregister(ws->dev);
-	ida_simple_remove(&wakeup_ida, ws->id);
+	if (ws->id >=3D 0)
+		ida_free(&wakeup_ida, ws->id);
 }
 EXPORT_SYMBOL_GPL(wakeup_source_sysfs_remove);
=20
diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
index f39f768389c8..c9fb00fca22e 100644
--- a/include/linux/pm_wakeup.h
+++ b/include/linux/pm_wakeup.h
@@ -107,7 +107,7 @@ extern void pm_wakeup_dev_event(struct device *dev, uns=
igned int msec, bool hard
=20
 /* drivers/base/power/wakeup_stats.c */
 extern int wakeup_source_sysfs_add(struct device *parent,
-				   struct wakeup_source *ws);
+				   struct wakeup_source *ws, bool use_ws_name);
 extern void wakeup_source_sysfs_remove(struct wakeup_source *ws);
=20
 #else /* !CONFIG_PM_SLEEP */
diff --git a/kernel/power/wakelock.c b/kernel/power/wakelock.c
index 826fcd97647a..7f2fc5f9b3b3 100644
--- a/kernel/power/wakelock.c
+++ b/kernel/power/wakelock.c
@@ -192,7 +192,7 @@ static struct wakelock *wakelock_lookup_add(const char =
*name, size_t len,
 	wl->ws.name =3D wl->name;
 	wl->ws.last_time =3D ktime_get();
=20
-	ret =3D wakeup_source_sysfs_add(NULL, &wl->ws);
+	ret =3D wakeup_source_sysfs_add(NULL, &wl->ws, true);
 	if (ret) {
 		kfree(wl->name);
 		kfree(wl);
