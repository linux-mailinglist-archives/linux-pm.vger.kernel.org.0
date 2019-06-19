Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85FBB4BC93
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2019 17:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbfFSPLh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jun 2019 11:11:37 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41894 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfFSPLh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jun 2019 11:11:37 -0400
Received: by mail-lf1-f68.google.com with SMTP id 136so12419026lfa.8;
        Wed, 19 Jun 2019 08:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c4lE+fDC/zjvYHc6bMY9y0fXVZdkPQJMI12oOjRnI+k=;
        b=sBFjUPLAQ8cjPXN9JHlZlv22CPccFqpl0Ah+uRBwMn8r1UCgPDCoEhbg46/fdDQuok
         Me2HINI71XxTkeo9la7F1nAB+b5IIrWzNrNrldg5nGsUkWbAWAFjG8kv1uLXBdG9zUt8
         LloQTMvNLcvcV9DDQMu7FuEjIdwTrNiE7fk0NVySbjzJSRwFm9be/71NIi2GITXQNVPt
         i3q+l2vt0qusV20jkNMXhHaSwhBe+wOFaTi296FszorbodLdURk0IHm/G2vutH7m8hDa
         Rokc24nejYYYW1E2BBqQP/YYfucJda/ZFDubDjJvisckgB5hzCHrOjhKqZeTv/hxpPAn
         NatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c4lE+fDC/zjvYHc6bMY9y0fXVZdkPQJMI12oOjRnI+k=;
        b=QRRvqMs2FEOXrePXEITXxF+wkPkMhpcviGi0wNjFTenHwsfrgJthGkYpmVgsfgB9m2
         mTR+nJGPY9/3YeelPIOyKrNXaHhqJOnpXkcRfjWhQ0nixZYKnhwYKN26R42N0aa3A7lZ
         ZBLtdFT4+atyE71DshfBEDBPEidba4AvbvA5VAH/Yotqy8gMtf9SV97Sbf0ZefNrY4wt
         ybuY70W3BXWv1LHyu3ZTNrtbdqFQadrMlUgNOU7a/9LjdaXPaaD/Qu30sOwg/RjYBQua
         Max+71uOpqV1whPA3eKLXCFGkr9q10w3dCmL1KksKMb/aG6+3EBnsSrhGx6HK0ZvonvW
         RM2w==
X-Gm-Message-State: APjAAAVYfZKx3IV4mJ3ylD6kTa2WNyo+keGPtrsM3QuoOqjPIlEACx9A
        tKcNfXqyTRjMLU7iwsf9Z3gqDcuWSGzt/G+oxAY=
X-Google-Smtp-Source: APXvYqyCK8YTFUBv1UQndRV7hhrkJSwGjOFnCWzcsoSyOWUwr+U9SgjEgPfsQwWEyMFD3ET+TTI6fNJRcqHDftXikr0=
X-Received: by 2002:a05:6512:29a:: with SMTP id j26mr28681961lfp.44.1560957095128;
 Wed, 19 Jun 2019 08:11:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLiBA9VjEoG_D2y2O5mKiqsDNW1VZXOk1eWXpGY+h86acg@mail.gmail.com>
 <CAOMZO5BcLaS0gXUPi6oN6vjqagS5yf+rHh+EUjmi-Wi1OX7vqQ@mail.gmail.com>
 <CAOuPNLgEEfDca4aeT1+q8GfUfGzbJ4x6JwGf-ROB1pgpXUBHSw@mail.gmail.com>
 <CAOMZO5BY8JcLNMCRCC_d=emy8HR6kE=dB9f5qfZ=ci_c+Jak0w@mail.gmail.com>
 <CAOuPNLjYhkP_kL+q-ZpiDZMMpOHrU88BFBc2agtnCzXt8dihOg@mail.gmail.com>
 <CAOMZO5ADK1L5UMM9XZetHvmjTvmvUg99G7VPdeXitgpctGLCkw@mail.gmail.com> <CAOuPNLhZhgN26rquLQq9zHBct1QxK-7hXAza0xk-0QooPGYLNw@mail.gmail.com>
In-Reply-To: <CAOuPNLhZhgN26rquLQq9zHBct1QxK-7hXAza0xk-0QooPGYLNw@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 19 Jun 2019 12:11:50 -0300
Message-ID: <CAOMZO5BsJWTw0nCeUboam4kuKyCO3N_Ch5ZW8k5Y9KFtQBanhQ@mail.gmail.com>
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

On Wed, Jun 19, 2019 at 12:05 PM Pintu Agarwal <pintu.ping@gmail.com> wrote:

> Okay. I will surely try it on another IMX6 fresh board.
> With 5.1.11 you mean the kernel from mainline kernel.org
> Or, is there a separate kernel repo for imx6. If yes, please let me know.

5.1.11 from kernel.org

> > Then you can test suspend/resume and see if HDMI hangs or not.
> >
> By this suspend/resume, you mean "suspend-to-ram" or "suspend-to-disk" ?

I tested with "echo mem > /sys/power/state"

> This scenario is not with suspend/resume.
> This hang is, when we make hdmi as a loadable module (.ko) and trying
> to install it after resume.
> In this case, suspend/resume will not come into picture. Not sure why
> it still hangs.
> Do you have any clue for this scenario?

I haven't tried this one.

Please test it with 5.1.11 and if it fails, please report.
