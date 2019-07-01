Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 904A85BE2D
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2019 16:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbfGAOZw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jul 2019 10:25:52 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:38831 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729532AbfGAOZw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jul 2019 10:25:52 -0400
Received: by mail-vs1-f68.google.com with SMTP id k9so9021339vso.5;
        Mon, 01 Jul 2019 07:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=prX1E0RG7UeUBzCLq0Q5Oi12RHYXNZyfW5bTMLlL8JI=;
        b=arAwgdST9DjY9vxXrFWg7C4mcvo7W/JT82sW+gnGtZsku0jghjgd5ceLmlW/DD9MeW
         SXkWG25P0KqPSmuIRtC+91B/URngWnXzXO8GJCmxhhbMGJQqlEiWIiugydsHUWvn4xMP
         fLUMKKSyPDRVGraoestBcMoB/SGklheTHS1bG1NorskLUwMXCHe8BQZPTckzxHVWrkH0
         dSgyjWmIUs2c0Togy+4bsvPsYEpRzGGfMHrKl0nRw4vnMSAFdwJFAi62yo8VoJYFgkFK
         k+mbzCq1HV6m3HieHAh0vw3OvFpjQBSH70WCR/VZt+fI0mNEPME9QrW2RFWol/gfdiYe
         BMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=prX1E0RG7UeUBzCLq0Q5Oi12RHYXNZyfW5bTMLlL8JI=;
        b=fWcH1c2e2BWsgAVqJBzDq1uO+5UTSeiEbml5rmhhoubanbWfTubZtiL3jkVVYSaMNB
         FjoSUcYxXhhGiYrwLEsZjRKmr5tv/T3oNXnpXr/BY91NEXkFI3okG2oRrr41oMpElMHw
         Lhe/Oo0MpEj10dS5lL3EN/WCVgz4LVLXDTFYoVQGQpGewst0JX/0OJh2Dp/zXeGB4f84
         ht3c0LWh6YsBAk3RSfqM4bnWWSKvY3MjFhbZLIPGpLvE0zxzZvq899mSJQyDmVSAUZx/
         Ymag80MuDT7k9NWyiAM1SS8+rXGGJkJoDZ4ynFCzMectXmauiizmseYMbstShiwwTCh7
         i9+Q==
X-Gm-Message-State: APjAAAVBVg5PzvajzcbhHHbD8uK6k+A8clL/MMEIjsyomqGVQuMILCU0
        wmIOO2Inm3alzqRMl8Yaj98cwcgz9epZ1yYtGtI=
X-Google-Smtp-Source: APXvYqzWTG5NkVuWmj3+DO56fz33iIrbZisyvuVAbbQwtuyydaLXGbJH3yLGRx0Z49Q2eGRBQaNkmTqk5JK8s6+zHXM=
X-Received: by 2002:a67:3195:: with SMTP id x143mr15188071vsx.144.1561991151262;
 Mon, 01 Jul 2019 07:25:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLiBA9VjEoG_D2y2O5mKiqsDNW1VZXOk1eWXpGY+h86acg@mail.gmail.com>
 <CAOMZO5BcLaS0gXUPi6oN6vjqagS5yf+rHh+EUjmi-Wi1OX7vqQ@mail.gmail.com>
 <CAOuPNLgEEfDca4aeT1+q8GfUfGzbJ4x6JwGf-ROB1pgpXUBHSw@mail.gmail.com>
 <CAOMZO5BY8JcLNMCRCC_d=emy8HR6kE=dB9f5qfZ=ci_c+Jak0w@mail.gmail.com>
 <CAOuPNLjYhkP_kL+q-ZpiDZMMpOHrU88BFBc2agtnCzXt8dihOg@mail.gmail.com>
 <CAOMZO5ADK1L5UMM9XZetHvmjTvmvUg99G7VPdeXitgpctGLCkw@mail.gmail.com>
 <CAOuPNLhZhgN26rquLQq9zHBct1QxK-7hXAza0xk-0QooPGYLNw@mail.gmail.com>
 <CAOMZO5BsJWTw0nCeUboam4kuKyCO3N_Ch5ZW8k5Y9KFtQBanhQ@mail.gmail.com>
 <CAOuPNLjrAU_C_TUKFMs1d0eGsw=AxuG6d6FhNHtHFwVhfYZGgA@mail.gmail.com>
 <CAOuPNLhstoCjxijrnKNmV1iKWjAXvSZ38Z13tfd5bvGbYSqPAA@mail.gmail.com>
 <CAOMZO5CD-QQaZwNfiX6mOLAup4J8dBiqEb_V_6jz_z5jXZ5cEw@mail.gmail.com> <CAOuPNLj=L_3RoC=9ws4yn1Q7QLoS3OEZ8FLRrF04HRQtQvc0Jg@mail.gmail.com>
In-Reply-To: <CAOuPNLj=L_3RoC=9ws4yn1Q7QLoS3OEZ8FLRrF04HRQtQvc0Jg@mail.gmail.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Mon, 1 Jul 2019 19:55:39 +0530
Message-ID: <CAOuPNLg5A1bB-Tmndm4PvsJ40tj0yn-bJ2mfifEpjAF-t84wiQ@mail.gmail.com>
Subject: Re: [IMX] [DRM]: suspend/resume support
To:     Fabio Estevam <festevam@gmail.com>, s.hauer@pengutronix.de,
        p.zabel@pengutronix.de
Cc:     open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jun 22, 2019 at 1:43 PM Pintu Agarwal <pintu.ping@gmail.com> wrote:
>
> On Fri, Jun 21, 2019 at 9:09 PM Fabio Estevam <festevam@gmail.com> wrote:
> >
> > On Fri, Jun 21, 2019 at 12:13 PM Pintu Agarwal <pintu.ping@gmail.com> wrote:
> >
> > > Okay there is some update on the 2nd part.
> > > Now I am able to successfully install all imx modules after the resume
> > > (no hang).
> > > But, I got some errors after install finish:
> > > [drm] disabling vblank on crtc 1
> > > [IMX]: imx_drm_disable_vblank - called
> > > [drm:drm_atomic_helper_commit_cleanup_done] *ERROR* [CRTC:24:crtc-0]
> > > flip_done timed out
> > >
> > > Also I am able to start the weston successfully.
> > > But I see LCD/HDMI display is not working (only some backlight is visible).
> > >
> > > And, I noticed, weston also reports the following errors:
> > > imx-ipuv3 2400000.ipu: DC stop timeout after 50 ms
> > > [IMX]: drm_crtc_vblank_off - called
> > > [IMX]: imx_drm_disable_vblank - called
> > > INFO: rcu_preempt detected stalls on CPUs/tasks: { 1} (detected by 0,
> > > t=6002 jiffies, g=289, c=288, q=8)
> > > Task dump for CPU 1:
> > > weston          R running      0   306      1 0x00000000
> > > [<c05282d8>] (__schedule) from [<00080193>] (0x80193)
> > >
> > > Do you have any clue about these errors ?
> >
> > Which kernel version is this?
>

Now, I am using Kernel 4.9 (custom) with some internal changes.
After the hibernate-resume, I am trying to install the modules in
following order:
insmod imxdrm.ko
insmod parallel-display.ko
insmod dw-hdmi.ko
insmod dw_hdmi-imx.ko
insmod imx-ipu-v3.ko
insmod imx-ipuv3-crtc.ko
insmod imx-ldb.ko

I noticed that if I don't install the "crtc" or "ldb" module at last,
then system will hang.
Otherwise, the modules are installed successfully.

But, I get following errors:
[drm:drm_atomic_helper_wait_for_flip_done] *ERROR* [CRTC:24:crtc-0]
flip_done timed out
[drm:drm_atomic_helper_commit_cleanup_done] *ERROR* [CRTC:24:crtc-0]
flip_done timed out

But, hdmi could be detected from the logs:
dwhdmi-imx 120000.hdmi: Detected HDMI controller 0x13:0x1a:0xa0:0xc1

However, after I start weston, there is no display in LCD and HDMI.
I can only see the backlight.

One more thing, I observed that, there was a huge delay after
component_bind_all():
[IMX]: imx_drm_driver_load - component_bind_all - DONE
<-------------- delay --------------->
Then we get flip_done timeout.

So, my question is:
1) If we have to test hibernation on iMX6/7 then which is the suitable way?
2) Is it possible to support this feature by performing module
installation after resume?
3) If yes, then which modules should be chosen as loadable, and which
can be in-built?
    (So, we don't have to implement suspend/resume for each module)

4) I also compared clock_summary in normal boot and after resume (with
module installed).
    I found below difference in clock frequency (pll5, pll4)
    Example:
-    pll5                        1           1            1188000007
+    pll5                        1           1            1040000015

what does this indicates? Is there any issue?
