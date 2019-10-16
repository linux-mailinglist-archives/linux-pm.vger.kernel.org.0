Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB63D88C3
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 08:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731240AbfJPGwI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 02:52:08 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:35813 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfJPGwI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 02:52:08 -0400
Received: by mail-ua1-f67.google.com with SMTP id n41so2434269uae.2;
        Tue, 15 Oct 2019 23:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=+yZ4tUEflU1wot9Y3TZUGwsQJDcRC6cRj494J8rN2Ig=;
        b=qKznEtbUYog0qWpVHk5hQ5CTH+HjZ+1M8PCv9jYmJM6e5Ga3cJuHQMHkBxpWibX/y/
         yZYngAzpG7DbJobb3gOI18s84UnRSDk3JhgHlaUpAXge+GXf7lqnSfhT+S9HeryZcUWL
         dnDFQ5Fe42A4M1ra6hX+atjJop1QXwqd8mmVkdWy7TaCSyBuksnALn/pfJJqxs95VrU5
         MmN/8kyKRSy+G2znswjxpNWVQRUTapfSj3LXLEKg2mP6VWXPar0of9rpBSDYv1DIu96z
         1a+lM9D9GdThIthIcztKMefMzT7PgLrYLZpa0z8gpJjU7FPZzBsGiRbJggbpNQQt41qw
         yvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=+yZ4tUEflU1wot9Y3TZUGwsQJDcRC6cRj494J8rN2Ig=;
        b=kFhzdxyr6HOSSkRFJ8R3NFvnIMLAromk/FFDPUI2OXeakDXWqcGKT76GHexMk5a4ch
         Dz8Iom7oPVAEzD3agqw7H7C+UriHdrGn++7/o/lRocgmiGP5jdBonz31I5CmpWlUvkG1
         NRq0I7bPuvdp9CfXo4B9+BbI0AdDzySxHr3fgkuKCOXjDH4XvpYLm40pTOmUoczVy9Ed
         5Ch4fjMpCDcZ+JTSU8T3uHAs+7y5hBHLmBJEuP9zGYzle3oHHr9PW03jSoqHzvG20ajH
         p2A4Bj+4AFHQ3jfpSNAc4aVpvamZgx5KWz9Gky5aBXw0KquUbYxW7UFv4rDr6XSfmbop
         N2Cg==
X-Gm-Message-State: APjAAAWiPbXH+b7yndKWR+wpyJspcMX4I3IBT/D1arXtzS8vYBAOQ6Xh
        FCN8IfEXJsricp++72IlQ38/d58H5HJ3WCNAQJgtLBQ2
X-Google-Smtp-Source: APXvYqwYe2I/kz08nX4fY0/iraBX0nqPJ5J5F4ZWecritIBG2AouvIB4Clj8Mw7kT19YLKlDwJdAsmcM/nGU8rRJXww=
X-Received: by 2002:ab0:7008:: with SMTP id k8mr15269916ual.70.1571208727054;
 Tue, 15 Oct 2019 23:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLgH=JQeT3=tZ_AdBsV0e-S_JNEe4CtpFW8Wj5NfYW5PsA@mail.gmail.com>
 <CAOuPNLjqm+Dv5RARP6dzZRKSttCvqoLe7MNYOeChAGUWX1krRA@mail.gmail.com>
 <CAOuPNLgZ3kjBaCmXkXHZrncYqUxsNYKiXQqptoDBT_EWfjpNqg@mail.gmail.com> <CAOuPNLjMFPn5WLcotG26wy_ROhJZn39iywwOYG0imzjqeQ3jeg@mail.gmail.com>
In-Reply-To: <CAOuPNLjMFPn5WLcotG26wy_ROhJZn39iywwOYG0imzjqeQ3jeg@mail.gmail.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Wed, 16 Oct 2019 12:21:55 +0530
Message-ID: <CAOuPNLje_kRyEy1JEv1RSSERKGa+WKzmybmR6svqiUcSduNDcg@mail.gmail.com>
Subject: Re: imx6: i2c-transfer timeout issue after resume
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

On Fri, Oct 4, 2019 at 3:47 PM Pintu Agarwal <pintu.ping@gmail.com> wrote:
>
> Hi,
>
> On Sun, Sep 29, 2019 at 10:24 PM Pintu Agarwal <pintu.ping@gmail.com> wrote:
> >
> > >
> > > On Mon, Sep 23, 2019 at 1:28 PM Pintu Agarwal <pintu.ping@gmail.com> wrote:
> > > >
> > > > Dear Philipp,
> > > >
> > > > I have a iMX6dl custom board with custom Linux Kernel 4.8.
> > > > I have both LCD and HDMI connected to the board.
> > > > And we are using weston/wayland as the display interface.
> > > > In normal boot, both LCD and HDMI display is working fine.
> > > >
> > > > But, currently, for one of the requirement, I am trying to explore and
> > > > support hibernation image booting on it.
> > > > Currently, we are able to resume the system without display.
> > > > Also, if we make the entire imx-drm as modules, and then install the
> > > > modules after resume, even LCD is also coming up.
> > > > But HDMI display is black out.
> > > >
>
> I just found the main root cause of the HDMI screen blackout issue
> after system resume.
> * HDMI is trying to get EDID data from the monitor using I2C interface.
> * But its seems i2c_transfer is getting timeout after 5 retries.
> * Thus EDID data is failing, and HDMI could not able to detect the monitor.
>
> This is the logs:
>
> [  441.104989] [drm:drm_helper_probe_single_connector_modes]
> [CONNECTOR:29:HDMI-A-1] status updated from unknown to connected
> [  441.116080]: drm_helper_probe_single_connector_modes - inside -
> else override_edid
> [  441.124416]: drm_helper_probe_single_connector_modes - inside -
> else - drm_load_edid_firmware: count: 0
> [  441.134546]: drm_helper_probe_single_connector_modes - calling - get_modes
> [  441.142157]: dw_hdmi_connector_get_modes : called
> [  441.147652]: dw_hdmi_connector_get_modes : called - calling -> drm_get_edid
> [  441.155346]: drm_do_probe_ddc_edid : called!
> [  441.660759]: drm_do_probe_ddc_edid : i2c_transfer: ret: -110, retry: 5
> [  442.170758]: drm_do_probe_ddc_edid : i2c_transfer: ret: -110, retry: 4
> [  442.680755]: drm_do_probe_ddc_edid : i2c_transfer: ret: -110, retry: 3
> [  443.190755]: drm_do_probe_ddc_edid : i2c_transfer: ret: -110, retry: 2
> [  443.700754]: drm_do_probe_ddc_edid : i2c_transfer: ret: -110, retry: 1
> [  443.707989]: drm_get_edid : called - drm_probe_ddc - failed
> [  443.714303] dwhdmi-imx 120000.hdmi: failed to get edid
>
> Is there any clue, how to resolve this i2c failure issue, after resume?
> This does not happen in normal booting case.
>
> These are the steps I follow:
> * Boot the system normally (without display) and install all imx-drm as modules.
> * Then uninstall the modules in reverse order.
> * Take the snapshot of the system (suspend to disk).
> * Reboot the system and boot with the image.
> * Install all the modules again.
> * Then launch the Weston.
> * During the weston launch in the beginning we observe this error.
>

* Changing the subject to be more relevant.

I need some pointers in debugging this i2c_transfer timeout issue,
after system resume.
I am not so much familiar with i2c, so I am looking for some clue here.

i2c-experts (or pm experts), please help me to find the root cause and
debug further.

Thanks,
Pintu
