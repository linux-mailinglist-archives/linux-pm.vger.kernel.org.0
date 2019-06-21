Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C63214EC4B
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2019 17:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfFUPjw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Jun 2019 11:39:52 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46340 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfFUPjw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Jun 2019 11:39:52 -0400
Received: by mail-lj1-f194.google.com with SMTP id v24so6323144ljg.13;
        Fri, 21 Jun 2019 08:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FTokQgNx7cdPK/mv6WeJrmrK4oV61TYi+9Ysp/6TCqk=;
        b=QNGeB8au8O4X7zRxBILcHMpiRAvThsjSSlCDFzpzLn1gzxbzWjjsQK7XJrjtVI6A6W
         Tgz6QjqHyp67mHUQp8WsiowO6LVI6QEqYSp5HfPqDcCyCK45NZbldsRXJPaHCNmaNFCj
         WHUnRrkKUOgK9VcmNDl7giRvj7NBo0rW7wuad8P2OEHM+ZAWBhn3KeYsiWdxEeFhmVCY
         2IS5cVLmlChE4PS34FeFGM7AgNylk72tiCxwLE42XYJn26OcPxKxJQuzKqFPcdXLAM3b
         Uy40pnT3QPNcmLMREtzCaO9/zItQM86ctpG3iCR9c0KQjVQVqzVwtvBGsU3EoZkkbm5p
         Fi0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FTokQgNx7cdPK/mv6WeJrmrK4oV61TYi+9Ysp/6TCqk=;
        b=RuF5znzzjwSR1j7mL7C2n5Yjpc//73iRh/L/J10lMt/8aWTVbTIv4T1B3RXpHpw4lC
         7/5Ez0R0/u1DODy9hKcE4SGVcFoQmHXGehm0syECefXW026Dmv9nPOtxKU+Zzghs8Jq6
         W2ioMxq4GuE1ryGiaZUgirREciT8YmBY8IZc0aMfJKc+Fwroo+qJPF9bAPwX3JKgA1nt
         z8iOjMTYMv18jXKqeprRZ/LcxmdAUOFJMhmPP7WgtIuoPQXSDlNE8fjEj1JjaxcO9XxV
         5SrHU+RcfCZ9hxErdDLW2jwQQpK4JZ8+OfKsWU4XSk50bwsEt4mmOyKjQQhQcdo6JULr
         n/BQ==
X-Gm-Message-State: APjAAAVfxL8NHNZsN/7u7K5r8//CjEmSy0XTdOdWcHVyCv6husp9WDnX
        ARMO5MC938XzX+vj6uG6DOozVf5S2A216ZCIEz0=
X-Google-Smtp-Source: APXvYqxhyvKOX88teGy56BaP4nj6I0qAUv/MiHp1Om2bnmvacGEay3hQQw60oMQOe4cFzs8KKjanBBAqFj3PL249YRM=
X-Received: by 2002:a2e:a311:: with SMTP id l17mr52525936lje.214.1561131589876;
 Fri, 21 Jun 2019 08:39:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLiBA9VjEoG_D2y2O5mKiqsDNW1VZXOk1eWXpGY+h86acg@mail.gmail.com>
 <CAOMZO5BcLaS0gXUPi6oN6vjqagS5yf+rHh+EUjmi-Wi1OX7vqQ@mail.gmail.com>
 <CAOuPNLgEEfDca4aeT1+q8GfUfGzbJ4x6JwGf-ROB1pgpXUBHSw@mail.gmail.com>
 <CAOMZO5BY8JcLNMCRCC_d=emy8HR6kE=dB9f5qfZ=ci_c+Jak0w@mail.gmail.com>
 <CAOuPNLjYhkP_kL+q-ZpiDZMMpOHrU88BFBc2agtnCzXt8dihOg@mail.gmail.com>
 <CAOMZO5ADK1L5UMM9XZetHvmjTvmvUg99G7VPdeXitgpctGLCkw@mail.gmail.com>
 <CAOuPNLhZhgN26rquLQq9zHBct1QxK-7hXAza0xk-0QooPGYLNw@mail.gmail.com>
 <CAOMZO5BsJWTw0nCeUboam4kuKyCO3N_Ch5ZW8k5Y9KFtQBanhQ@mail.gmail.com>
 <CAOuPNLjrAU_C_TUKFMs1d0eGsw=AxuG6d6FhNHtHFwVhfYZGgA@mail.gmail.com> <CAOuPNLhstoCjxijrnKNmV1iKWjAXvSZ38Z13tfd5bvGbYSqPAA@mail.gmail.com>
In-Reply-To: <CAOuPNLhstoCjxijrnKNmV1iKWjAXvSZ38Z13tfd5bvGbYSqPAA@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 21 Jun 2019 12:40:07 -0300
Message-ID: <CAOMZO5CD-QQaZwNfiX6mOLAup4J8dBiqEb_V_6jz_z5jXZ5cEw@mail.gmail.com>
Subject: Re: [IMX] [DRM]: suspend/resume support
To:     Pintu Agarwal <pintu.ping@gmail.com>
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

On Fri, Jun 21, 2019 at 12:13 PM Pintu Agarwal <pintu.ping@gmail.com> wrote:

> Okay there is some update on the 2nd part.
> Now I am able to successfully install all imx modules after the resume
> (no hang).
> But, I got some errors after install finish:
> [drm] disabling vblank on crtc 1
> [IMX]: imx_drm_disable_vblank - called
> [drm:drm_atomic_helper_commit_cleanup_done] *ERROR* [CRTC:24:crtc-0]
> flip_done timed out
>
> Also I am able to start the weston successfully.
> But I see LCD/HDMI display is not working (only some backlight is visible).
>
> And, I noticed, weston also reports the following errors:
> imx-ipuv3 2400000.ipu: DC stop timeout after 50 ms
> [IMX]: drm_crtc_vblank_off - called
> [IMX]: imx_drm_disable_vblank - called
> INFO: rcu_preempt detected stalls on CPUs/tasks: { 1} (detected by 0,
> t=6002 jiffies, g=289, c=288, q=8)
> Task dump for CPU 1:
> weston          R running      0   306      1 0x00000000
> [<c05282d8>] (__schedule) from [<00080193>] (0x80193)
>
> Do you have any clue about these errors ?

Which kernel version is this?
