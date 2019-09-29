Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02838C1661
	for <lists+linux-pm@lfdr.de>; Sun, 29 Sep 2019 18:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbfI2Qyc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Sep 2019 12:54:32 -0400
Received: from mail-ua1-f44.google.com ([209.85.222.44]:36330 "EHLO
        mail-ua1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfI2Qyb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Sep 2019 12:54:31 -0400
Received: by mail-ua1-f44.google.com with SMTP id r25so3416715uam.3;
        Sun, 29 Sep 2019 09:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=hKXN3UH5ikId6K7/+YiazTXZNhGquUsUZgxZDxQd10Y=;
        b=WPB7OKJ3oTtP+x/hIwIN+DcngOG06NPx4RnjbFvVdD5u4DcrIV3MH8ThyUMtF0kf3N
         6F9Q1x3IuEEWjxDXJqyI4pwOe/YijKNoeX9GqDmU6sactOcUEQzAsXtBZ3gIcnI2V+d7
         L3kh2zZTFQfzwka3oNMQv1wRsdHVXXc2/Ma4tj0uIoEK1eIb3cc4HHOsYP4vft0UMmu1
         x5BO/okxSAyM2+lYQ3SUsuEBQgNcQ9VPsnnb0kTVhWeSQKemee1QEsDjnhhvooBgyE8t
         i32kEcogqZX+90pYCbjUE1jdamhMT/ntak6Ke7MOWnwhLFPBCnYiPOdHgpn9IiDKQKMW
         gt9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=hKXN3UH5ikId6K7/+YiazTXZNhGquUsUZgxZDxQd10Y=;
        b=kTJ+3q1Rtpe7USiAzVP2N5ZWhJI2/DMPsQWWGPZ6l298XBSRyywKyXeVnDLzAmii38
         PEiF6uTwvTmV4JuipFjv5GzhE0qcQbVXULUXTjfcd1qsb+P+9R63ExbKH42YprosG/tf
         hGKTm7ZOv2wNw9JBbvYKY9i0CDvNiiCRm8FXkrlD0YRS1Ll1W400tSfguen5h25bYmEs
         TzjKj0VtqMf+BX0kbMA2rcqyhndu3wI02MKJlN4D3xY5c58OxwChFNiqnydhb6PeY8x4
         fipntDi+I5AWZRR15dH1/StXSDfYCqZN2QhCVVSF7vvXZopWYzP/EqmMYlJat7Y5asXH
         wtMA==
X-Gm-Message-State: APjAAAW9kdesNvLdGWHfr7u7QpMwYgtt1pj9UGNfIUBSxeg/SiSZxU0U
        CFZJUBr62Ohw/TC5E/T2Olr4bUDIH5c+DTCppZs=
X-Google-Smtp-Source: APXvYqzgyzbvTiXo3YBeaDoGYv87AhsnV9Wj2PykCpUkpRDq9o4W3/XL83+x1tUr7skuswWAXfuvFe5bAeU+1n3sJns=
X-Received: by 2002:ab0:3310:: with SMTP id r16mr4589762uao.22.1569776070321;
 Sun, 29 Sep 2019 09:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLgH=JQeT3=tZ_AdBsV0e-S_JNEe4CtpFW8Wj5NfYW5PsA@mail.gmail.com>
 <CAOuPNLjqm+Dv5RARP6dzZRKSttCvqoLe7MNYOeChAGUWX1krRA@mail.gmail.com>
In-Reply-To: <CAOuPNLjqm+Dv5RARP6dzZRKSttCvqoLe7MNYOeChAGUWX1krRA@mail.gmail.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Sun, 29 Sep 2019 22:24:19 +0530
Message-ID: <CAOuPNLgZ3kjBaCmXkXHZrncYqUxsNYKiXQqptoDBT_EWfjpNqg@mail.gmail.com>
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

>
> On Mon, Sep 23, 2019 at 1:28 PM Pintu Agarwal <pintu.ping@gmail.com> wrote:
> >
> > Dear Philipp,
> >
> > I have a iMX6dl custom board with custom Linux Kernel 4.8.
> > I have both LCD and HDMI connected to the board.
> > And we are using weston/wayland as the display interface.
> > In normal boot, both LCD and HDMI display is working fine.
> >
> > But, currently, for one of the requirement, I am trying to explore and
> > support hibernation image booting on it.
> > Currently, we are able to resume the system without display.
> > Also, if we make the entire imx-drm as modules, and then install the
> > modules after resume, even LCD is also coming up.
> > But HDMI display is black out.
> >
> > After, resume, when I try to launch the weston, I noticed the following errors:
> > enabling vblank on crtc 0, ret: 0
> > drm_vblank_get: CALLED: vblank->refcount: 1
> > ------------[ cut here ]------------
> > WARNING: at drivers/gpu/drm/drm_atomic_helper.c:1121
> > drm_atomic_helper_wait_for_vblanks+0x228/0x24c [drm_kms_helper]()
> > [CRTC:24] vblank wait timed out
> > .....
> > [drm:drm_atomic_helper_commit_cleanup_done [drm_kms_helper]] *ERROR*
> > [CRTC:24:crtc-0] flip_done timed out
> >
> > ....
> > [00:06:42.600] Warning: computed repaint delay is insane: -5069 msec
> > [00:06:42.665] unexpectedly large timestamp jump (from 397522 to 402648)
> > ....
> >
> > And, when I try to reboot the system, the system does not reboot.
> > And I get the following error:
> > /wayland # reboot
> > ....
> > [17:55:01.180] destroy output while page flip pending
> > ...
> > imx-ipuv3 2400000.ipu: DC stop timeout after 50 ms
> >
> >
> > -------------
> > If you have any clue about this issue, please let me know.
> >
> > Any help will be really appreciated!
> >
> >
> > Thank You!
> >
> > Regards,
> > Pintu


Hi All,

I need some help, on the above issue.
Finally, I could boil down the issue to be vblank refcount issue.
After system resume, vblank ref count is getting screwed up, because
of which vblank_enable is not happening.
As per below code path: drivers/gpu/drm/drm_vblank.c:
drm_vblank_get()
{
[...]
/* Going from 0->1 means we have to enable interrupts again */
if (atomic_add_return(1, &vblank->refcount) == 1) {
    ret = drm_vblank_enable(dev, pipe);
} else {
    if (!vblank->enabled) {
        atomic_dec(&vblank->refcount);
        ret = -EINVAL;
    }
}
[...]
First time, everything seems fine.
drm_vblank_get: CALLED: pipe: 0, vblank->refcount: 0, vblank-enabled: 0
..
drm_vblank_enable: calling - enable_vblank
enabling vblank on crtc 0, ret: 0
...

But, after resume, somewhere during HDMI initialization, the refcount
is getting incremented.
drm_vblank_get: CALLED: pipe: 0, vblank->refcount: 1, vblank-enabled: 1
Thus, due to the above logic, drm_vblank_enable() will not be called,
if previous refcount is not 0.

What I further noticed is that, after resume, during hdmi_setup the
refcount is automatically getting updated.
drm_update_vblank_count - storing vblank count: diff: 1

This does not happen in normal case.
Now, I am not sure, why the vblank counter is getting incremented
during hdmi setup.
Is it like, hdmi setup is taking slightly longer time for
initialization, after resume??
Because of which the vblank timestamp counter is getting disturbed.

If anybody observed this issue, or aware about the fixes, please let me know.
It will be of great help.

Meanwhile, I am further continue to debug this more..

Regards,
Pintu
