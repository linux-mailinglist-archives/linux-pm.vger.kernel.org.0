Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B508A65A7C
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2019 17:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbfGKPaH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Jul 2019 11:30:07 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:42908 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728594AbfGKPaG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jul 2019 11:30:06 -0400
Received: by mail-vs1-f68.google.com with SMTP id 190so4485210vsf.9;
        Thu, 11 Jul 2019 08:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NKwh0BaKc7HdLVY/44p+/9uGqJilXs/pFH756+9dwa4=;
        b=pWNqSiF0wI+NAhKUO9jeUT5ddMPc4IWrwifKWWXllUwVCKeE7nkFPXKD/OTuDl+7zE
         r5YMnOFNfrvWr3wNDsqvEtjxgi43PgnPfifLNFD0znDVYw3QjzufMDUOxPj7jM7Kx2zG
         dMB90OfJ7gdvM3hVMVoITiVJO+y2/x1NAfphjoOcE1sc2u55FCTGkL8m4NR9zpOy52Zs
         U+8l+AAaYyDoDiC4V1daq19Ag8wP59d+QTQmV1YFziXr9qldRdiS2U/xHMPtCh140S88
         V9hJ7AYrOymLb5WnV96LZoEvmt6gKwMm2vYtzFmxitS1wPtZj8LwfPYM0p+Ucd3OVPNs
         u2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NKwh0BaKc7HdLVY/44p+/9uGqJilXs/pFH756+9dwa4=;
        b=t41VuBiemAJnqueBQBYT4y+ynH2AO7tvfDrlAboeCuNHP9EudRK9WHnLfCLk/wIXhy
         O7jmvpkwhH3GoVcNxYz0WnT9oGu0vg6f7gFKrZunnDsle/ducYhQ/ynCl6D9/gBnPuRC
         9q2BwSPloPjVhuNzPf7yZGZyxuyCRiXLoBZaqLRTPEwZdaF00+Y16PJ9Rpbx0Kl48fvS
         F1jLcWRMIATIZL/3+5f4oYnVB07Ou6scslIvOkIMHMB0aIADH/R3Km4Y9kzeOyFFLHyF
         2rlYP1o8CfKnUBVtdNy09/HpzcFkeW/FPIddsDe8S5Er15/3bs2JHd3OtgWHJARxrgd/
         I/VQ==
X-Gm-Message-State: APjAAAWiBTuUuZ4MvSpYTN8ub/SlgQLnLBCaPIOflZLCozqPajzJBM7c
        /HnYafdTBQqkNTz0q9BdtTjwEEJTO5zQ+7goLbNhGa1N828=
X-Google-Smtp-Source: APXvYqyD0lSKwc7ImB95W3u/TfjlUbYrn4b/hJuAi+NA5A4U1ZHu5NVT6j14kb0e1Cw62+NTPEJ+C5zvLalN1NjiCws=
X-Received: by 2002:a67:fc19:: with SMTP id o25mr5269898vsq.106.1562859005683;
 Thu, 11 Jul 2019 08:30:05 -0700 (PDT)
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
 <CAOMZO5CD-QQaZwNfiX6mOLAup4J8dBiqEb_V_6jz_z5jXZ5cEw@mail.gmail.com>
 <CAOuPNLj=L_3RoC=9ws4yn1Q7QLoS3OEZ8FLRrF04HRQtQvc0Jg@mail.gmail.com> <CAOuPNLg5A1bB-Tmndm4PvsJ40tj0yn-bJ2mfifEpjAF-t84wiQ@mail.gmail.com>
In-Reply-To: <CAOuPNLg5A1bB-Tmndm4PvsJ40tj0yn-bJ2mfifEpjAF-t84wiQ@mail.gmail.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Thu, 11 Jul 2019 20:59:54 +0530
Message-ID: <CAOuPNLjdSh+pw196PAcBO9B-OgRb=f7sKcMFyGJPW3PNFwEyZA@mail.gmail.com>
Subject: Re: [IMX] [DRM]: help in analyzing clock_summary rate difference
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

Hi,

I need one general help in analyzing difference in clock_summary rate
before and after the system resume.

I am using custom IMX7 board with 4.9 Kernel.
With this I am trying to support some functionality during suspend/resume.
I am trying to analyze clk_summary from:
# cat /sys/kernel/debug/clk/clk_summary

I observed that there are difference in "clock rate" after system
resume and module install. However the enable/prepare count remains
the same.

Since I am not much familiar with clock framework, I am looking for
some help to analyze this issue. It's an internal issue.

May be someone which is familiar with clock analysis or fixed the
similar issue earlier can give me some guidance.
What does the difference in clock rate indicates?
What analysis can be done to narrow down the root cause?
Any example of reference could be helpful to understand.


Thank You!
Regards,
Pintu
