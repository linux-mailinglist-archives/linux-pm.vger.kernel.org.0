Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E64333389
	for <lists+linux-pm@lfdr.de>; Wed, 10 Mar 2021 04:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbhCJDE3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 22:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbhCJDE3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Mar 2021 22:04:29 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A4EC06174A;
        Tue,  9 Mar 2021 19:04:29 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id e45so14992035ote.9;
        Tue, 09 Mar 2021 19:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RlvYSlMGFakV6EZ71l2kmuNwcjNHwB/5cpbhUPGNlFo=;
        b=Ymhm6AGbF73/NtXz6qjQa7Nq6KQ1El27u5C9zQpjjFTtgnewFCaPulP7KpFhte+OnR
         +Bk1SUlKBn1T7dKylK81LuAJuxSdAmjcd4bIaFDcvi4r8xwhZ4094wF5CHXkm2adngzY
         jZv1BwB1SUhcoWpGQ3VI0H1Y94u/wY7hs3Q/VTDnv5LeiQ4pch2olyJqZ9fl7nJo85G0
         4HIRUOKr3cwTgUJSi1OtVDoS+lD2vm8VFS+BEsGMqnStS55K7BFRvn0H53MkQdnsrjWO
         IYQvEoFclHOBpzUhOBgZHZqxnxsXhNnAvmSYNYCEVC6qcE073GjRmROOy4vd0IHvh3rG
         EmnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RlvYSlMGFakV6EZ71l2kmuNwcjNHwB/5cpbhUPGNlFo=;
        b=uXc0qvZ96UN2huysVjvditdqZO6+R1IF8xpvVP/owF1asJwGnC1hT8IQuMdZ1sPwcs
         v2ZkLdYzjfgF4HEBlrbaRdhQTkA78fNsEgkPpGyHAileGIEXDvdaDfc5Bj+POlEVu1Xs
         Y8/sqNaY9F9EwnLPnrc7BF1nM/nQa7kQbuvfhoYm+Rv3gRaQCGsEfWppORi0TIu5ZPAN
         CHw7884T8qoB+LTSue7lZdHRzHe7CIo52wzSNGLm1brR+JzzuPtXwS8lZmN1Rkroweux
         E0j9E0fSDcoxfGWCIAlKs7R432vnoeoIYea2MzVlMN1tOSq2/w+/v0SMnlQ9wLPuYTPO
         Bpcw==
X-Gm-Message-State: AOAM533FAqC1qO9HClgLWP3c8pIt568tfmNTMGRaF8XjmAR/OtM/XqAu
        wMgPbzycTjcibMEQUygf9RYr01VXTVLFaCwejoI=
X-Google-Smtp-Source: ABdhPJwL0ArhZYYUkwkBR9P+n5Fba1TwhZrF/S2JuQ+llk3dsIR7GBNc6wPV4sBRlA3kJsIFUBmGw/Np7Sw3Ya2O7e4=
X-Received: by 2002:a05:6830:408a:: with SMTP id x10mr1040106ott.248.1615345468504;
 Tue, 09 Mar 2021 19:04:28 -0800 (PST)
MIME-Version: 1.0
References: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
 <1615294733-22761-6-git-send-email-aisheng.dong@nxp.com> <83240e9d-383a-74a9-3222-68cf42d3d0e1@gmail.com>
 <CGME20210310024415epcas1p1796666ad300fc299194df162299d389b@epcas1p1.samsung.com>
 <CAA+hA=QpAcu0OVZwm8DuqUsENMem-+59QwOt0Y9cqstuGO5VEw@mail.gmail.com> <aea8cf18-ebe3-6140-e202-5f082040bbae@samsung.com>
In-Reply-To: <aea8cf18-ebe3-6140-e202-5f082040bbae@samsung.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Wed, 10 Mar 2021 11:04:27 +0800
Message-ID: <CAA+hA=Tv9SThyu3C33Kij8XikAiT1eb666VW328bxhUyrvYgfw@mail.gmail.com>
Subject: Re: [PATCH 05/11] PM / devfreq: use more accurate returned new_freq
 as resume_freq
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Chanwoo Choi <cwchoi00@gmail.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        open list <linux-kernel@vger.kernel.org>,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        Abel Vesa <abel.vesa@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 10, 2021 at 10:50 AM Chanwoo Choi <cw00.choi@samsung.com> wrote=
:
>
> On 3/10/21 11:43 AM, Dong Aisheng wrote:
> > On Tue, Mar 9, 2021 at 11:53 PM Chanwoo Choi <cwchoi00@gmail.com> wrote=
:
> >>
> >> On 21. 3. 9. =EC=98=A4=ED=9B=84 9:58, Dong Aisheng wrote:
> >>> Use the more accurate returned new_freq as resume_freq.
> >>> It's the same as how devfreq->previous_freq was updated.
> >>>
> >>> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> >>> ---
> >>>   drivers/devfreq/devfreq.c | 2 +-
> >>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> >>> index 6e80bf70e7b3..ce569bd9adfa 100644
> >>> --- a/drivers/devfreq/devfreq.c
> >>> +++ b/drivers/devfreq/devfreq.c
> >>> @@ -390,7 +390,7 @@ static int devfreq_set_target(struct devfreq *dev=
freq, unsigned long new_freq,
> >>>       devfreq->previous_freq =3D new_freq;
> >>>
> >>>       if (devfreq->suspend_freq)
> >>> -             devfreq->resume_freq =3D cur_freq;
> >>> +             devfreq->resume_freq =3D new_freq;
> >>>
> >>>       return err;
> >>>   }
> >>>
> >>
> >> This patch fixes the previous patch[1]. So that you need to
> >> add 'Fixes' tag as following:
> >>
> >> Fixes: 83f8ca45afbf0 ("PM / devfreq: add support for suspend/resume of=
 a
> >> devfreq device")
> >>
> >
> > Will add Fixes tag in next version.
>
>
> On next version, recommend to place this patch at the first.

Yes, good practice as it's a fix.

Regards
Aisheng

>
> >
> >> commit 83f8ca45afbf041e312909f442128b99657d90b7
> >> Refs: v4.20-rc6-2-g83f8ca45afbf
> >> Author:     Lukasz Luba <lukasz.luba@arm.com>
> >> AuthorDate: Wed Dec 5 12:05:53 2018 +0100
> >> Commit:     MyungJoo Ham <myungjoo.ham@samsung.com>
> >> CommitDate: Tue Dec 11 11:09:47 2018 +0900
> >>
> >>      PM / devfreq: add support for suspend/resume of a devfreq device
> >>
> >>
> >> --
> >> Best Regards,
> >> Samsung Electronics
> >> Chanwoo Choi
> >
> >
>
>
> --
> Best Regards,
> Chanwoo Choi
> Samsung Electronics
