Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3EA278D70
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2019 16:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbfG2OHV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 10:07:21 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32874 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727539AbfG2OHV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jul 2019 10:07:21 -0400
Received: by mail-pg1-f193.google.com with SMTP id f20so19098174pgj.0
        for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2019 07:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:to:subject:cc:user-agent:date;
        bh=9Nybox5Ems434Y8f3uqSl08wrdR2vXIjQfpnAfsknyE=;
        b=m6J4d8MLpDyS0VX2HOOIiddbS2yNdkHuPM8c0SDZ1G48A3hCxTPHNGwFSpl629Rh0S
         Mx7Ji294l7tBty6/kP3U0Q9wuVavXqhq7w3cFZB5ZwBbSKuaLlIaF+Nq1xDfAtYGUYVF
         zJkWY/NjMrKnQgzpDXc0BlOgWU7R5e5kpNBXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:to:subject:cc
         :user-agent:date;
        bh=9Nybox5Ems434Y8f3uqSl08wrdR2vXIjQfpnAfsknyE=;
        b=TuYg9zJrduzQncyctaqnon6a42DvPmYBU2ZvLc0BNk8lKwul60Zmjn7Ztn41cgI1Ef
         5F5hKr5rO/8FifYl6DESRjPebj/gqOJTv5MpplK8kkXe1HbmImgCEDAofrf9D+t4avxl
         8Qwb2/qsvu/pP9UUbas1HxG2BloAYcE7wBBbePRDXbLW5MvwVgBjtcgbqszbMWP+nVIg
         ih5lCOOewA0Rc06Xhl/t53pia2Cj6s+hJZ+QALM1YchqW6JoB4W6e8/tdwmgy+sCSSdJ
         vwwiWAYAA+TA2K5BwP/xeukwOjCzOEyAOC5ScwCY4rKuol718nRfeW67JHuMOWLUs963
         PZkA==
X-Gm-Message-State: APjAAAUQEqWee3vCfWepZluuVtBZjoEWoHCfmhM1uYrRnahaT28Uehcz
        uNFMlBVZE2zdAfN2zizv7yC9iw==
X-Google-Smtp-Source: APXvYqwa80ZrMiQQWSZwZ3dtH8/0siPpnsrbdnWv4yQ+VOXFFERc9PmbfcA/ZdJfwPd71fBJTxgB2w==
X-Received: by 2002:a63:dd4e:: with SMTP id g14mr32640178pgj.227.1564409240743;
        Mon, 29 Jul 2019 07:07:20 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id m31sm69058880pjb.6.2019.07.29.07.07.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 07:07:20 -0700 (PDT)
Message-ID: <5d3efd98.1c69fb81.5f60d.059a@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJZ5v0hroRuGQ5N42Z8=yFVXiJPdid3wJrHoKqr2BZVx=sfnBQ@mail.gmail.com>
References: <20190727011040.89582-1-swboyd@chromium.org> <CAJZ5v0hroRuGQ5N42Z8=yFVXiJPdid3wJrHoKqr2BZVx=sfnBQ@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM / wakeup: Avoid dev_name collisions in wakeup class
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Tri Vo <trong@android.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>
User-Agent: alot/0.8.1
Date:   Mon, 29 Jul 2019 07:07:19 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Rafael J. Wysocki (2019-07-27 06:10:00)
> On Sat, Jul 27, 2019 at 3:11 AM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > If a device is wakeup capable and the driver calls device_wakeup_init()
> > on it during probe and then userspace writes 'enabled' to that device's
> > power/wakeup file in sysfs we'll try to create the same named wakeup
> > device in sysfs. The kernel will complain about duplicate file names.
> >
> > sysfs: cannot create duplicate filename '/devices/virtual/wakeup/1-1.1'
> > kobject_add_internal failed for 1-1.1 with -EEXIST, don't try to regist=
er things with the same name in the same directory.
> >
> > It may be advantageous to not write 'enabled' to the wakeup file (see
> > wakeup_store()) from userspace for these devices because we allocate
> > devices and register them and then throw them all away later on if the
> > device driver has already initialized the wakeup attribute. The
> > implementation currently tries to avoid taking locks here so it seems
> > best to optimize that path in a separate patch.
> >
> > Let's rename the wakeup class devices as 'wakeupN' with an IDA that's
> > simple enough to just return some sort of number. In addition, let's
> > make the device registering the wakeup the parent and include a 'name'
> > attribute in case userspace wants to figure out the type of wakeup it is
> > (in the case of virtual wakeups) or the device associated with the
> > wakeup. This makes it easier for userspace to go from /sys/class/wakeup
> > to a place in the device hierarchy where the wakeup is generated from
> > like an input device.
> >
> > Cc: Tri Vo <trong@android.com>
> > Cc: Kalesh Singh <kaleshsingh@google.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Ravi Chandra Sadineni <ravisadineni@chromium.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>=20
> I'd rather change the commit that introduced this issue which is only
> in linux-next for now.

Feel free to squash the two patches together and throw my signed-off-by
on it. I forgot to add 'name' to the Documentation directory. Here's
something to that effect.

-----8<-----
diff --git a/Documentation/ABI/testing/sysfs-class-wakeup b/Documentation/A=
BI/testing/sysfs-class-wakeup
index 30fb23eb9112..b83a87380d2c 100644
--- a/Documentation/ABI/testing/sysfs-class-wakeup
+++ b/Documentation/ABI/testing/sysfs-class-wakeup
@@ -5,6 +5,13 @@ Description:
 		The /sys/class/wakeup/ directory contains pointers to all
 		wakeup sources in the kernel at that moment in time.
=20
+What:		/sys/class/wakeup/.../name
+Date:		June 2019
+Contact:	Tri Vo <trong@android.com>
+Description:
+		This file contains the name of the wakeup source when
+		it was created.
+
 What:		/sys/class/wakeup/.../active_count
 Date:		June 2019
 Contact:	Tri Vo <trong@android.com>
