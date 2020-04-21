Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330231B294B
	for <lists+linux-pm@lfdr.de>; Tue, 21 Apr 2020 16:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgDUOS7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Apr 2020 10:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728479AbgDUOS6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Apr 2020 10:18:58 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E25C061A10;
        Tue, 21 Apr 2020 07:18:58 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j1so11237894wrt.1;
        Tue, 21 Apr 2020 07:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XZzndPnYtYbbEF/KUZVNIJz+EcXy0p75DzfqczwlSe8=;
        b=kgLmPLwxUl5/Ma+EDAS7OwNd58zyhTcO0jxcdmbufGrysR7FvlZ9M7c2Vqs4uYk//I
         NtCsPb+nsu2eUmQfKxg/RNmFIlU8jpRgqkqImtzJnDsA4j1bIJaxTVEnJDJcfRdrNS+b
         QcY172YKngn+A8fR6B4Rw1TUti4r0pKIcRjzANa3rOsg/9O1hNm3hzTsu0mxBGaFAlnu
         HreuzgMaUwKocNly5bo3jhPzAU7Ax2qiBcJh3EoAi3de3PVLgISOxVGSoFvxo9v5giVM
         +9LIeVtljWhNV3LEbQ0Tb06ND/qEGg6kIH3Y0Bp8SeWeHcMs74C30d9mjAZDmxmzAjQd
         KpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XZzndPnYtYbbEF/KUZVNIJz+EcXy0p75DzfqczwlSe8=;
        b=QOx63j9YHlLxsD2NkUIJ3d9hkW3g9NH68HBxbNOK4cysTeHNNCtU6qW45QDDoxNLDg
         9B1HBpmyTn591LmdFy/86Y68veFtdtqWenYZ2VIeozMOtVvU9b8kfrQYxxQzzxqcWU4C
         eAp8PCUGF60RCc5yPr5Z8b1/e+CE/G251DFRxtHBoWqeBR/+1C4dzDLptyCTdEcekb7X
         41JYQQnHrdtZZRXKKWsMWGh5uQIKbJARg9598p7TcZP0NoL1JXb9WPVdYI+t5r3UZuA9
         6xOwZ7BrPK3XKyemkspBO06+48y0I6UnNizTYzqqKRAo8GQtxa+lU1MuIuwzhxOQx400
         /3zQ==
X-Gm-Message-State: AGi0PuZi3qWkwtW1sp/mtdrG4UYfYJjQhBAdASr/h/8jHublWnXvxjrC
        W5ie3BaGlr42zMOCjk6jESUcoSUUneiYzbV2juI=
X-Google-Smtp-Source: APiQypJ4ai2ZaRvEMbuZeelgSbTJL39HJnQ583AlT1gQuWTbnZsztUo86fQBN9mjsQkbukzDpzbexYNN1zF/4xAZ5dY=
X-Received: by 2002:a5d:45cf:: with SMTP id b15mr23682887wrs.78.1587478736843;
 Tue, 21 Apr 2020 07:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200304121943.28989-1-daniel.baluta@oss.nxp.com>
 <20200304121943.28989-2-daniel.baluta@oss.nxp.com> <CAPDyKFp6KLuuuVFcEWGxn5NkuDSkhM-MjRiiYj_zC4mFxhOBag@mail.gmail.com>
In-Reply-To: <CAPDyKFp6KLuuuVFcEWGxn5NkuDSkhM-MjRiiYj_zC4mFxhOBag@mail.gmail.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 21 Apr 2020 17:18:45 +0300
Message-ID: <CAEnQRZDX8PZ7V+c8zfoxK-+oGp2pt8N3oTAC6=Ps1W33LGY7WA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] PM / domains: Introduce multi PM domains helpers
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Daniel Baluta <daniel.baluta@oss.nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Len Brown <len.brown@intel.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Kevin Hilman <khilman@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Olaru <paul.olaru@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Anson Huang <anson.huang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 21, 2020 at 5:01 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 4 Mar 2020 at 13:20, Daniel Baluta <daniel.baluta@oss.nxp.com> wrote:
> >
> > From: Daniel Baluta <daniel.baluta@nxp.com>
> >
> > This patch introduces helpers support for multi PM domains.
> >
> > API consists of:
> >
> > 1) dev_multi_pm_attach - powers up all PM domains associated with a given
> > device. Because we can attach one PM domain per device, we create
> > virtual devices (children of initial device) and associate PM domains
> > one per virtual device.
> >
> > 2) dev_multi_pm_detach - detaches all virtual devices from PM domains
> > attached with.
> >
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
>
> First, apologize for the delay.
>
> In general I don't mind adding helpers that can be used to decrease
> open coding. However, in this case, I wonder how useful the helpers
> would really be.
>
> More precisely, according to the information I have, a device may not
> always need all of its PM domains to be turned on together, but
> perhaps only a subset of them. Depending on the current use case that
> is running.
>
> Of course, some cases follow your expectations, but as stated, some
> others do not.
>
> Do you have an idea how many users that would be able to switch to
> these new APIs as of today?

IMX Sound Open Firmware driver will immediately be available
to use this new API.

https://elixir.bootlin.com/linux/latest/source/sound/soc/sof/imx/imx8.c#L221

Aside, from that there are the ACM clock modules for i.MX8QXP / i.MX8QM. Also,
looking at our internal tree there are XUVI, VPU, DPU drivers that need multi
power domain support.

Anson, Aisheng do you have a number of users on your side for
multi power domain?

thanks,
daniel.
