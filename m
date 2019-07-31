Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C14DE7D211
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2019 01:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730941AbfGaXpe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 19:45:34 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39956 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbfGaXpd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 19:45:33 -0400
Received: by mail-pf1-f194.google.com with SMTP id p184so32730506pfp.7
        for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2019 16:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:from:to:subject:user-agent:date;
        bh=2aTqXCxfS0wES19jPnEhvSwuE9w59s+Ba6S/ZSuGNNY=;
        b=ftYDBFAuvCukNdwLQxFOFw0D47LFOVpE9titYeQErJZGve6bds0/csNvRpFmz4WSSf
         VU9D98vtfozObHI2w10LxC1cOKtSNqfUMerIIaIiDDsBuKyzZOzf5VQUJbMjIXc6n43W
         aLdxS5baeyz+kNSrC5bOO13Fz8t9Fk9NROzjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:from:to:subject
         :user-agent:date;
        bh=2aTqXCxfS0wES19jPnEhvSwuE9w59s+Ba6S/ZSuGNNY=;
        b=eVyPqtQxd4mm978SG+cTFlHq9r7m/MBPgXbP8kwFEOB7ZXCrVXO+KzzjL7GqS5HB13
         ZmSWklXGwkVhz2a66IDEX8kvX/ieSfksHYXbAasw+kCvwC0Ls2gUnesYDGz7wM0sLr/V
         u7RBKpH+Adn/ij+AtdYfzPsp7ukuCVUlt6cJ5x1FRNqDY84f+Cr9iDhO6Q9RSC4kZTYp
         Awnl7Iv4sPgnFdMnmu6S/lbruoH8QzrgIOghi5nlNKKbzEPeFICVdd8w1t/xpvqkPlDQ
         4lRJ1NIwmzvTu/Q3qsxLXLCf8TG2re19uK/M9eGCbFjnsZVbvnaNrov0GuYjESmZjeZK
         3BiA==
X-Gm-Message-State: APjAAAU73Ukb85+e8Y1i2N1lpzzTYrUgd24OrGw/naSFizkhH9Z6G8YK
        iaznjVcTbTsILxfr4GUCSuj2Mg==
X-Google-Smtp-Source: APXvYqzpR+yF2tlL0G8/rKxh8Cfu9rEUYcaYuyAEnU2+suNL/2Oh/9t4urfyQDt9WpQjQE8iR5ILsg==
X-Received: by 2002:a65:4507:: with SMTP id n7mr8434326pgq.86.1564616732856;
        Wed, 31 Jul 2019 16:45:32 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id i7sm2433751pjk.24.2019.07.31.16.45.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 16:45:32 -0700 (PDT)
Message-ID: <5d42281c.1c69fb81.bcda1.71f5@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJZ5v0go-qOTyQV4D2Sj_xQxT831PxJZP0uay67rG73Q3K2pHQ@mail.gmail.com>
References: <20190731215514.212215-1-trong@android.com> <32598586.Mjd66ZhNnG@kreacher> <CANA+-vDTDq__LnLBpM5u_VHHvpFA--K5Du63vPB7HfaKzBsPtg@mail.gmail.com> <6987393.M0uybTKmdI@kreacher> <CANA+-vAPpXF1=z1=OjOhr8HWQ=Qn39qtQ3+8bUeXNTuFFTxoJQ@mail.gmail.com> <CAJZ5v0go-qOTyQV4D2Sj_xQxT831PxJZP0uay67rG73Q3K2pHQ@mail.gmail.com>
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
Date:   Wed, 31 Jul 2019 16:45:31 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Rafael J. Wysocki (2019-07-31 16:10:38)
> On Thu, Aug 1, 2019 at 12:59 AM Tri Vo <trong@android.com> wrote:
> >
> > On Wed, Jul 31, 2019 at 3:42 PM Rafael J. Wysocki <rjw@rjwysocki.net> w=
rote:
> > >
> > > That's not my point (see below).
> > >
> > > > > > > +       if (id < 0)
> > > > > > > +               return id;
> > > > > > > +       ws->id =3D id;
> > > > > > > +
> > > > > > > +       dev =3D device_create_with_groups(wakeup_class, paren=
t, MKDEV(0, 0), ws,
> > > > > > > +                                       wakeup_source_groups,=
 "ws%d",
> > > > > >
> > > > > > I thought the name was going to still be 'wakeupN'?
> > > > >
> > > > > So can't we prefix the wakeup source name with something like "wa=
keup:" or similar here?
> > > >
> > > > "ws%d" here is the name in the sysfs path rather than the name of t=
he
> > > > wakeup source. Wakeup source name is not altered in this patch.
> > > >
> > >
> > > So why wouldn't something like this suffice:
> > >
> > > dev =3D device_create_with_groups(wakeup_class, parent, MKDEV(0, 0), =
ws,
> > >                                 wakeup_source_groups, "wakeup:%s", ws=
->name);
> > >
> > > ?
> >
> > ws->name is inherited from the device name. IIUC device names are not
> > guaranteed to be unique. So if different devices with the same name
> > register wakeup sources, there is an error.
>=20
> OK
>=20
> So I guess the names are retained for backwards compatibility with
> existing user space that may be using them?
>=20
> That's kind of fair enough, but having two different identification
> schemes for wakeup sources will end up confusing.

I understand your concern about the IDA now. Thanks for clarifying.

How about we name the devices 'wakeupN' with the IDA when they're
registered with a non-NULL device pointer and then name them whatever
the name argument is when the device pointer is NULL. If we have this,
we should be able to drop the name attribute in sysfs and figure out the
name either by looking at the device name in /sys/class/wakeup/ if it
isn't 'wakeupN', or follow the symlink to the device in /sys/devices/
and look at the parent device name there.

The only problem I see is the alarmtimer code where it might register a
second wakeup source for the same rtc device. In this case, we probably
want to use whatever name is passed in ("alarmtimer") instead of the
IDA.

This approach also nicely detects duplicate wakeup source names in the
case that the string passed in to wakeup_source_register() is already
used on the virtual bus.

---8<----
diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 79668b45eae6..1c98f83c576e 100644
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
@@ -209,6 +209,9 @@ struct wakeup_source *wakeup_source_register(struct dev=
ice *dev,
 	struct wakeup_source *ws;
 	int ret;
=20
+	if (!name)
+		name =3D dev_name(dev);
+
 	ws =3D wakeup_source_create(name);
 	if (ws) {
 		ret =3D wakeup_source_sysfs_add(dev, ws);
@@ -275,7 +278,7 @@ int device_wakeup_enable(struct device *dev)
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
index a26f019faca9..11e2906dca4c 100644
--- a/drivers/base/power/wakeup_stats.c
+++ b/drivers/base/power/wakeup_stats.c
@@ -132,16 +132,22 @@ int wakeup_source_sysfs_add(struct device *parent, st=
ruct wakeup_source *ws)
 	struct device *dev;
 	int id;
=20
-	id =3D ida_alloc(&wakeup_ida, GFP_KERNEL);
-	if (id < 0)
-		return id;
-	ws->id =3D id;
+	if (parent) {
+		id =3D ida_alloc(&wakeup_ida, GFP_KERNEL);
+		if (id < 0)
+			return id;
+		ws->id =3D id;
+	} else {
+		ws->id =3D -1;
+	}
=20
 	dev =3D device_create_with_groups(wakeup_class, parent, MKDEV(0, 0), ws,
-					wakeup_source_groups, "ws%d",
-					ws->id);
+					wakeup_source_groups,
+					ws->id >=3D 0 ? "wakeup%d" : "%s",
+					ws->id >=3D 0 ? ws->id : ws->name);
 	if (IS_ERR(dev)) {
-		ida_free(&wakeup_ida, ws->id);
+		if (ws->id >=3D 0)
+			ida_free(&wakeup_ida, ws->id);
 		return PTR_ERR(dev);
 	}
=20
