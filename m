Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01AEB4F445
	for <lists+linux-pm@lfdr.de>; Sat, 22 Jun 2019 10:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbfFVINO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 22 Jun 2019 04:13:14 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:39290 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfFVINO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 22 Jun 2019 04:13:14 -0400
Received: by mail-vk1-f196.google.com with SMTP id o19so1786995vkb.6;
        Sat, 22 Jun 2019 01:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ymA/9yBKawIC9AWwAvSD2s34Dx6xSFjTiT44S3SfquU=;
        b=b339sLmQAe+unMpoelxrVE0PlDrsmwAKLlJc2aWO9uZTL2X0z/UpMf1LAKKp7+GyNI
         axZOaAOocD9iRmLSjKCgTgHgRCBaqYWedcQCliN9LQCKGO0iyy+rJTwPvoXoJ7ElPwrj
         R2Yd6Ub1lEV60kYZYMzIvKlzc5J2PS9h9C2t0Zyh3OBlo759tL37p/u98HCUITSlCX6Z
         k5AVjx1pgmWAyEAUbgLzuFqdC8XUVaP4ZjrBCybLZbyR6U+PcwsPE5uPzKiBSm5NzSng
         1wLFyGbAhIstMM5W70Gedpyvd4ZCXp/HA0XAxuw21Aq8CN5dmfHicpH+GeVjcbXs62GJ
         5ZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ymA/9yBKawIC9AWwAvSD2s34Dx6xSFjTiT44S3SfquU=;
        b=R/GINlDgmBUqma4m/OBp1d6Jzk0AK1NUK0yIAtDE9VirTyRtCQOTk/+RPx2BHpx+DM
         8kKbYhp3bXGWLiOHiNa6RHy30G7qBcTq4DOgbgWrBJbqepSYvnenTQTxgJjiklPWPNA/
         jM50oUJ1qDB8WXgjTvohrn664NoahWOVCkZfsQrw9RdRZycxP4EM2hENvMV+1bRIaS6G
         ae79oALQscACupBt9gxr5Tg0kDsv9qE6rHxVrrDeBg0qFz1ENkG9MQRnGM1n1DJx1RBY
         YsIDmp27g2dyuV/RtudfIlqwIrV7+uKIcIfyRgKUmV4GmOJZbM/K9D60slHIlOQmb98B
         7jMQ==
X-Gm-Message-State: APjAAAUWWmbQnW02PBTiLb8BRRSfHi5d/gG8hobgvEXgFZz+H57JOLZh
        vNDa36/qhJfx5Fa9DVTj5SmzT4j/CU3eU67U3/LW0A==
X-Google-Smtp-Source: APXvYqwbJJHwrbXk97wpkvnicdIyvUw9qn195B4TTuwW4r9kqbrQvG/gO16g9Jlf+GYXz6b6OO9aKuK1D3XFvAFaT0k=
X-Received: by 2002:a1f:1b0a:: with SMTP id b10mr11176492vkb.19.1561191192828;
 Sat, 22 Jun 2019 01:13:12 -0700 (PDT)
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
 <CAOuPNLhstoCjxijrnKNmV1iKWjAXvSZ38Z13tfd5bvGbYSqPAA@mail.gmail.com> <CAOMZO5CD-QQaZwNfiX6mOLAup4J8dBiqEb_V_6jz_z5jXZ5cEw@mail.gmail.com>
In-Reply-To: <CAOMZO5CD-QQaZwNfiX6mOLAup4J8dBiqEb_V_6jz_z5jXZ5cEw@mail.gmail.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Sat, 22 Jun 2019 13:43:01 +0530
Message-ID: <CAOuPNLj=L_3RoC=9ws4yn1Q7QLoS3OEZ8FLRrF04HRQtQvc0Jg@mail.gmail.com>
Subject: Re: [IMX] [DRM]: suspend/resume support
To:     Fabio Estevam <festevam@gmail.com>
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

On Fri, Jun 21, 2019 at 9:09 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> On Fri, Jun 21, 2019 at 12:13 PM Pintu Agarwal <pintu.ping@gmail.com> wrote:
>
> > Okay there is some update on the 2nd part.
> > Now I am able to successfully install all imx modules after the resume
> > (no hang).
> > But, I got some errors after install finish:
> > [drm] disabling vblank on crtc 1
> > [IMX]: imx_drm_disable_vblank - called
> > [drm:drm_atomic_helper_commit_cleanup_done] *ERROR* [CRTC:24:crtc-0]
> > flip_done timed out
> >
> > Also I am able to start the weston successfully.
> > But I see LCD/HDMI display is not working (only some backlight is visible).
> >
> > And, I noticed, weston also reports the following errors:
> > imx-ipuv3 2400000.ipu: DC stop timeout after 50 ms
> > [IMX]: drm_crtc_vblank_off - called
> > [IMX]: imx_drm_disable_vblank - called
> > INFO: rcu_preempt detected stalls on CPUs/tasks: { 1} (detected by 0,
> > t=6002 jiffies, g=289, c=288, q=8)
> > Task dump for CPU 1:
> > weston          R running      0   306      1 0x00000000
> > [<c05282d8>] (__schedule) from [<00080193>] (0x80193)
> >
> > Do you have any clue about these errors ?
>
> Which kernel version is this?

Please let me know in which version this issue is fixed.
I will try that.
I think I saw some commit that mentions about it, but I forgot.
Anyways, I am checking again.
Thanks!
