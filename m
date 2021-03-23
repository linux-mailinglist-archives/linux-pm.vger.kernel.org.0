Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1329345632
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 04:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhCWDZm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Mar 2021 23:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhCWDZ2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Mar 2021 23:25:28 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6759C061574;
        Mon, 22 Mar 2021 20:25:27 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id d12so15536523oiw.12;
        Mon, 22 Mar 2021 20:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K7Tw0WCUQjSiYC8t7LUsVB/c7mgFoROBsLD7V9Z1Oc4=;
        b=U1BnVoCoXnGfe+QLv7at8Ir+Zzzgj3Oh6JJ+wfkwWC26wxiW9SbxQuMxSqRRpdNBeO
         4+RrhjdyUcL1y19QLs38G3bFh5gRZytMbSRa+Kd7IAdkUn+SZIdOV87qdFMGiYfp/quz
         YbYUzve5cmzpbW2KR34PPWthBEpWNj/EjWpzaw19EC/qwb1YiWO556aC12bI/WrDUXdw
         7qVKDF2aBCZ83VFaNsVOJ016I3w1F7R44kvLKQAEgrivsngqLP/IMenBs3hmeLRC38pi
         1p5EwHXy+UrEmXlVBGZJ0C5aefCmiNQtGDFRK742K8tKVpfG8T2riKdt7d7+jqRAgZo9
         fHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K7Tw0WCUQjSiYC8t7LUsVB/c7mgFoROBsLD7V9Z1Oc4=;
        b=RNANscygsT8yTwMG2XbQ0vRx7SWs4mfCr6u8HzdeK3RitWk2OWkX7HFZc+zRPsVsbo
         H85uK0nlA4JtLgzjf8L3N8UlgfNSEVbWobbH2ieFP5Un8CjJAh13GDYlUlP4JeXhiVQQ
         YdHju7CfZbgxRxqIErKD8IMtSaJF7OaZA7509ji91yA7PqfImD0ImAwEnnfKcwFthvRh
         25lRIPoVe2HOKfizZXxDdu6Aq6tg9aBQtZNjZ3rFGVWOfp05B/DBw6k50ZDakA6b9lND
         uNrwax+drFkDlU0P8FVrpDkxRoHwdzZ1dboTpfhpQpBJS3Ig/yqJVLRLeRtSuMNmL/V/
         ovHQ==
X-Gm-Message-State: AOAM531UiNX04Fwp++U8RiIckAZjEjEUUe/aQ+kuNa1Rf6OuIep4wtZK
        wWJWZj+6TwpuHr/EIKbk6RFUU0kgGJ8duqlfpCkGd9rVv5E=
X-Google-Smtp-Source: ABdhPJxOlbD5cDyzmZpcXOlOun6O7MxtpbD45eqN9K9SAVe7LtXHkPOJKmakdLnUt57bd9t48WWH1hmPE/VNeNYwcX4=
X-Received: by 2002:a05:6808:1413:: with SMTP id w19mr1771900oiv.20.1616469927194;
 Mon, 22 Mar 2021 20:25:27 -0700 (PDT)
MIME-Version: 1.0
References: <1616468359-14513-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1616468359-14513-1-git-send-email-aisheng.dong@nxp.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Tue, 23 Mar 2021 11:25:09 +0800
Message-ID: <CAA+hA=Sb+eXqaVFKtSgzM6RsnwufqEHcKrbnD_rmnDW3-qGJSQ@mail.gmail.com>
Subject: Re: [PATCH V2 0/6] PM / devfreq: a few small fixes and improvements
To:     Dong Aisheng <aisheng.dong@nxp.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        open list <linux-kernel@vger.kernel.org>,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Abel Vesa <abel.vesa@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chanwoo,

On Tue, Mar 23, 2021 at 11:13 AM Dong Aisheng <aisheng.dong@nxp.com> wrote:
>
> A few small fixes and improvements
>
> ChangeLog:
> v1->v2:
>  * squash a few patches
>  * rebase to devfreq-testing

I have to rebase to devfreq-testing instead of devfreq-next because
below two patches
only exist in devfreq-testing.
5cc75e9252e9 (devfreq/devfreq-testing) PM / devfreq: Add
devfreq_transitions debugfs file
dc9e557845c1 PM / devfreq: Add new up_threshold and down_differential
sysfs attrs
My patch 5 needs change based on it according to your suggestion. So i have to
rebase to that branch.

However, i found devfreq-testing can't build with GOV_PASSVIE enabled.
Patch 1 fixed it. You can squash to the original one when apply.

Please help take a look at this new series.
Thanks

Regards
Aisheng

>  * drop two patches which are already in devfreq-next
>
> Dong Aisheng (6):
>   PM / devfreq: fix build error when DEVFREQ_GOV_PASSIVE enabled
>   PM / devfreq: Use more accurate returned new_freq as resume_freq
>   PM / devfreq: Remove the invalid description for get_target_freq
>   PM / devfreq: bail out early if no freq changes in devfreq_set_target
>   PM / devfreq: governor: optimize simpleondemand get_target_freq
>   PM / devfreq: imx8m-ddrc: remove imx8m_ddrc_get_dev_status
>
>  Documentation/ABI/testing/sysfs-class-devfreq |  5 +--
>  drivers/devfreq/devfreq.c                     | 37 +++++++------------
>  drivers/devfreq/governor.h                    |  2 -
>  drivers/devfreq/governor_simpleondemand.c     | 31 ++++++++++------
>  drivers/devfreq/imx8m-ddrc.c                  | 14 -------
>  5 files changed, 35 insertions(+), 54 deletions(-)
>
> --
> 2.25.1
>
