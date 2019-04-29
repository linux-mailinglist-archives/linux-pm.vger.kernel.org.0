Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36AE9DD12
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2019 09:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfD2Hpy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Apr 2019 03:45:54 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45767 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfD2Hpy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2019 03:45:54 -0400
Received: by mail-qt1-f195.google.com with SMTP id b3so10821881qtc.12
        for <linux-pm@vger.kernel.org>; Mon, 29 Apr 2019 00:45:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G1fYVX4Wl40jdZ8+GWZHzYu+3eRKXOD4apXXEPaZ4Wc=;
        b=Izy/3C2IqEkOYU91W9iiANqklE9VSsVhA0znutZj44eyQqCrYjELTDISmnbyqy8egM
         ploPxwm+s8FIBDvUJD6j8JgQSoo9wYXDOqhqyBGYwYH9IwzNf2JG9i3GMjEcVMNEdYM+
         Y2lfY5AwAtYuFij1Tm3n0ftvK2A3n1EnLtymiT77Q9C+MG+EblIsYae8A15TOV2Qf5Ks
         /t9deUeJdVaBzSuk0fFzk6yQ5WXceloTiCIE67xDYZH2yZKuxM6gUYMGdXOvaqac/GvW
         VjwTlmbHmJ1Ggif/8r+CFbl1QBgB2s0A2GkaI/THyopsudPGjZQgh57tdmg2sYgSbtvz
         OMDw==
X-Gm-Message-State: APjAAAX+u4csJKVxaHwaqLMV02xNjyq8YVMo2fen0V9d/MKxNOL5f/ec
        5aZgswI4Gd8+fh7YY7ePtBRzR8JyqJkgKTnPT3olf/8n
X-Google-Smtp-Source: APXvYqypk8m0KUmH/pdaKn2c6dXVHzcwhT3MS6/t9LfLWL9Bs64Cy4DoGt4GK6iloNtlI/ZK+yiFhuwRgID1pkwlfBw=
X-Received: by 2002:a0c:e5d0:: with SMTP id u16mr18985451qvm.48.1556523953508;
 Mon, 29 Apr 2019 00:45:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190422130814.GJ173520@google.com> <3a1139ef-10ed-6923-73c5-30fbf0c065c3@linux.intel.com>
In-Reply-To: <3a1139ef-10ed-6923-73c5-30fbf0c065c3@linux.intel.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 29 Apr 2019 09:45:42 +0200
Message-ID: <CAO-hwJKvXO6L7m0g1D6wycFP=Wu_qLDyLXTtmm0TkpxT5Z8ygw@mail.gmail.com>
Subject: Re: [Bug 203297] Synaptics touchpad TM-3127 functionality broken by
 PCI runtime power management patch on 4.20.2
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Keijo Vaara <ferdasyn@rocketmail.com>,
        Jean Delvare <jdelvare@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 26, 2019 at 2:14 PM Jarkko Nikula
<jarkko.nikula@linux.intel.com> wrote:
>
> On 4/22/19 4:08 PM, Bjorn Helgaas wrote:
> > https://bugzilla.kernel.org/show_bug.cgi?id=203297
> >
> > Regression, suspected but as yet unconfirmed cause:
> >
> >    c5eb1190074c ("PCI / PM: Allow runtime PM without callback functions")
> >
> > backported to 4.20 stable as 39e1be324c2f.
> >
> With help of Keijo it was confirmed above patch broke the Synaptics
> touchpad. Not bisected but touchpad works again by forcing the i2c-i801
> SMBus controller always on:
> "echo on >/sys/bus/pci/devices/0000\:00\:1f.3/power/control"
>
> Above patch is a generalized fix that fixed the runtime PM regression on
> i2c-i801 and re-allow the controller go to runtime suspend when idle. So
> most probably Synaptics touchpad was broken by i2c-i801 runtime PM also
> before but got unnoticed. Which is easy since on many platforms SMBus
> controller doesn't necessarily have the PCI PM capabilities.
>
> I would like to ask help from input subsystem experts what kind of SMBus
> power state dependency Synaptics RMI4 SMBus devices have since it cease
> to work if SMBus controllers idles between transfers and how this is
> best to fix?

Hmm, I am not sure there is such an existing architecture you could
use in a simple patch.

rmi-driver.c does indeed create an input device we could use to toggle
on/off the PM state, but those callbacks are not wired to the
transport driver (rmi_smbus.c), so it would required a little bit of
extra work. And then, there are other RMI4 functions (firmware
upgrade) that would not be happy if PM is in suspend while there is no
open input node.

So I think this "hack" (with Mika's comments addressed) should go in
until someone starts propagating the PM states correctly.

Cheers,
Benjamin

>
> Instead of revert I think we'd need to have some method to force SMBus
> controller on whenever the touchpad is active, like when there is a
> userspace listening.
>
> I'm not expert in this area so as quick proof of concept I had a
> following hack which forces the I2C/SMBus adapter, and eventually the
> parent PCI device of it on when the RMI4 SMBus device is probed and let
> the SMBus controller to idle when removed.
>
> According to Keijo it fixes the issue but I like to hear input experts
> for better place to put these.
>
> diff --git a/drivers/input/rmi4/rmi_smbus.c b/drivers/input/rmi4/rmi_smbus.c
> index b6ccf39c6a7b..2b11d69be313 100644
> --- a/drivers/input/rmi4/rmi_smbus.c
> +++ b/drivers/input/rmi4/rmi_smbus.c
> @@ -16,6 +16,7 @@
>   #include <linux/lockdep.h>
>   #include <linux/module.h>
>   #include <linux/pm.h>
> +#include <linux/pm_runtime.h>
>   #include <linux/rmi.h>
>   #include <linux/slab.h>
>   #include "rmi_driver.h"
> @@ -332,6 +333,9 @@ static int rmi_smb_probe(struct i2c_client *client,
>
>         dev_info(&client->dev, "registering SMbus-connected sensor\n");
>
> +       /* Force SMBus adapter on while RMI4 device is connected */
> +       pm_runtime_get(&client->adapter->dev);
> +
>         error = rmi_register_transport_device(&rmi_smb->xport);
>         if (error) {
>                 dev_err(&client->dev, "failed to register sensor: %d\n", error);
> @@ -346,6 +350,7 @@ static int rmi_smb_remove(struct i2c_client *client)
>         struct rmi_smb_xport *rmi_smb = i2c_get_clientdata(client);
>
>         rmi_unregister_transport_device(&rmi_smb->xport);
> +       pm_runtime_put(&client->adapter->dev);
>
>         return 0;
>   }
>
> --
> Jarkko
