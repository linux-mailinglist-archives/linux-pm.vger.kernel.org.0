Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7F91CB80D
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2019 12:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388658AbfJDKSK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Oct 2019 06:18:10 -0400
Received: from mail-vs1-f45.google.com ([209.85.217.45]:42735 "EHLO
        mail-vs1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388656AbfJDKSJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Oct 2019 06:18:09 -0400
Received: by mail-vs1-f45.google.com with SMTP id m22so3746636vsl.9;
        Fri, 04 Oct 2019 03:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=FR8/a0jMod/hGsojz+LGnIr8+PyKD68xBHORYzblMNk=;
        b=RJmgbSUmpYIPMnsXW4fiFNIs/nVsdpLxuh/2Jl/WgsZA02vC1tEOopTRcwbYPHM5L0
         r2vkElO9koITv+QRvcZ7eWPw4X/99IQsFa1qglm8P6X6HCy8xXv5WsVfamS72xN5rYMw
         TzISRhXTwgV1pJXSjocdgc8XLqm8jZ0owy4hJmRMYenI8QXCmerUwPEafvg9lM1tQ8rU
         Qk/XRRYHCoYpI+Ufi5B0LMqpNs4TCnVpdD8rYcqHCS6I24R+H1Y9wCVsoXmceg1+1g3L
         r8ijid7u8AvvOR9BsWsNr/+nlo7QPKNheFq4GAPHjhDsRX06CmrmT9PEi5YQJ+EeCMzQ
         wUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=FR8/a0jMod/hGsojz+LGnIr8+PyKD68xBHORYzblMNk=;
        b=CXRUz/JmjRamDIHitGw1pwg+vQIjLFV0KEFC+Q5OcaKS6TUY0Fk9fuWDgb+TK/BUN4
         i5jACOVKdcRgYLcunTZXtfOq8ZpdORgpO3g9NhbJp90hxvXXcMIS+RgqfCv8tXHqCSPr
         3Y/Xy1OykoE+Jp4pTTDKpvagaALxkZj8s/ltgjhK667SP9giqVvRGdKqUW9xrXBncdWC
         HAwKREzsx32j8siDms2Psh0F1P0kuSSEjxkAkcSJqDrmd0+iU4BVeYY51sBKnbAg559L
         9gSSjvVYGqV0AAzpmPjAdpcFkbtzFOT678BB2g4rqbVfRk3qnmz9o/K3FyYFBEhnZ7l/
         XLTg==
X-Gm-Message-State: APjAAAXBhVUhOKJGOsPNUva1lxv3bmU+dqRfD4spOCJxdNOY4hcFgir4
        ZnAslo1inzUrLBPRZ1aYj86yqxRE2oFnJLa2JoY=
X-Google-Smtp-Source: APXvYqzoJg533BuJP8X9hanZyDP0L9alk4DwLrlKbxlCtR/Dh3mBh8FRwtP02LUsZBLr2AmV84eZG7uiFXxZAQO1QWo=
X-Received: by 2002:a67:e40a:: with SMTP id d10mr7102858vsf.196.1570184288590;
 Fri, 04 Oct 2019 03:18:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLgH=JQeT3=tZ_AdBsV0e-S_JNEe4CtpFW8Wj5NfYW5PsA@mail.gmail.com>
 <CAOuPNLjqm+Dv5RARP6dzZRKSttCvqoLe7MNYOeChAGUWX1krRA@mail.gmail.com> <CAOuPNLgZ3kjBaCmXkXHZrncYqUxsNYKiXQqptoDBT_EWfjpNqg@mail.gmail.com>
In-Reply-To: <CAOuPNLgZ3kjBaCmXkXHZrncYqUxsNYKiXQqptoDBT_EWfjpNqg@mail.gmail.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Fri, 4 Oct 2019 15:47:57 +0530
Message-ID: <CAOuPNLjMFPn5WLcotG26wy_ROhJZn39iywwOYG0imzjqeQ3jeg@mail.gmail.com>
Subject: Re: imx6: hdmi black screen issue after resume
To:     p.zabel@pengutronix.de, bob.beckett@collabora.com,
        dri-devel@lists.freedesktop.org,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Sun, Sep 29, 2019 at 10:24 PM Pintu Agarwal <pintu.ping@gmail.com> wrote:
>
> >
> > On Mon, Sep 23, 2019 at 1:28 PM Pintu Agarwal <pintu.ping@gmail.com> wrote:
> > >
> > > Dear Philipp,
> > >
> > > I have a iMX6dl custom board with custom Linux Kernel 4.8.
> > > I have both LCD and HDMI connected to the board.
> > > And we are using weston/wayland as the display interface.
> > > In normal boot, both LCD and HDMI display is working fine.
> > >
> > > But, currently, for one of the requirement, I am trying to explore and
> > > support hibernation image booting on it.
> > > Currently, we are able to resume the system without display.
> > > Also, if we make the entire imx-drm as modules, and then install the
> > > modules after resume, even LCD is also coming up.
> > > But HDMI display is black out.
> > >

I just found the main root cause of the HDMI screen blackout issue
after system resume.
* HDMI is trying to get EDID data from the monitor using I2C interface.
* But its seems i2c_transfer is getting timeout after 5 retries.
* Thus EDID data is failing, and HDMI could not able to detect the monitor.

This is the logs:

[  441.104989] [drm:drm_helper_probe_single_connector_modes]
[CONNECTOR:29:HDMI-A-1] status updated from unknown to connected
[  441.116080]: drm_helper_probe_single_connector_modes - inside -
else override_edid
[  441.124416]: drm_helper_probe_single_connector_modes - inside -
else - drm_load_edid_firmware: count: 0
[  441.134546]: drm_helper_probe_single_connector_modes - calling - get_modes
[  441.142157]: dw_hdmi_connector_get_modes : called
[  441.147652]: dw_hdmi_connector_get_modes : called - calling -> drm_get_edid
[  441.155346]: drm_do_probe_ddc_edid : called!
[  441.660759]: drm_do_probe_ddc_edid : i2c_transfer: ret: -110, retry: 5
[  442.170758]: drm_do_probe_ddc_edid : i2c_transfer: ret: -110, retry: 4
[  442.680755]: drm_do_probe_ddc_edid : i2c_transfer: ret: -110, retry: 3
[  443.190755]: drm_do_probe_ddc_edid : i2c_transfer: ret: -110, retry: 2
[  443.700754]: drm_do_probe_ddc_edid : i2c_transfer: ret: -110, retry: 1
[  443.707989]: drm_get_edid : called - drm_probe_ddc - failed
[  443.714303] dwhdmi-imx 120000.hdmi: failed to get edid

Is there any clue, how to resolve this i2c failure issue, after resume?
This does not happen in normal booting case.

These are the steps I follow:
* Boot the system normally (without display) and install all imx-drm as modules.
* Then uninstall the modules in reverse order.
* Take the snapshot of the system (suspend to disk).
* Reboot the system and boot with the image.
* Install all the modules again.
* Then launch the Weston.
* During the weston launch in the beginning we observe this error.


Regards,
Pintu
