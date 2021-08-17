Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F2F3EEAF8
	for <lists+linux-pm@lfdr.de>; Tue, 17 Aug 2021 12:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbhHQKbP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Aug 2021 06:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbhHQKbO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Aug 2021 06:31:14 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48CFC061764;
        Tue, 17 Aug 2021 03:30:41 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id t66so22469369qkb.0;
        Tue, 17 Aug 2021 03:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xnOrN2iGoAn9UBgvYsMN1rQw6SqNnGEA65qhk4XK5ec=;
        b=GzeB7875dRc7cA+MXIWU499S69pkJ49YDTTrHpW4DDVeyyZ9htMf/UHXFRO2MwYXTJ
         YYa42l+j9EK0pOS2ysFJkeOwqN/OAEAeSSIZaDMXcGBVOZlcaFu9/oH7BlyUg4n3uNQe
         bXg1E8BBrHDplZCg8ffzH3WrdWTrof1xZeMely+tPKg8FirI2dgtf+a4nnwy9YvZM2+6
         4v1xGYPVn+iLzXGT89tDiAaLGJ8nomKO5z3sxG2IJpXrfVDuxy5GDzdA0BMTLdfvetLv
         mJZRwj+G5ZPD2+lqfd1fZL69BBtdaA4CWklOVYMWZGRaFMQb/e7v66aOsiQbIqp9EQmS
         Hg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xnOrN2iGoAn9UBgvYsMN1rQw6SqNnGEA65qhk4XK5ec=;
        b=ZVPpy5gNQIGPOXvCdcqQim6I0edCXGa8FGjaVpxIylnIVcuxWH9AzFGchknQcykpOI
         dWEE4A7hUGAJEXPSZZsKfHAhVTyLRet3T4NJaxmF9r5hTr4VvfO4LVbdBv9nVTeVaMnF
         swFIueZ1NyQgpl95X9FFq8XIkRqecxI/oheJfzV6D6Q2S+HFzVJ6ojYKmnUHUgSRGyyw
         B9QI9MRwrkdd7GoDaksP78EGRQPk14asFEpKNr5fnWK7HISzSQQ54PUM0dNDQFXvscFM
         b2g27BhtxTxrIv5tjmev3ysC/qD4UJP0nOJqNmgH4lG+SwV7ChVQwJc3RLZzo4KxptD8
         EnAA==
X-Gm-Message-State: AOAM5306LnH6cwtoeZ/HPD3p00EMexTswEorHHSL4Hh4rNUirBWEHLsQ
        QMbzWKjxIeL7oTAIlAYUQa7EXTn81k85UTn/PHy88ouQfYY=
X-Google-Smtp-Source: ABdhPJxv95OAvdEijFl4LMQ6/CvYS4yZkAT6Fyf4KIXLj5z2DHsYJtzISW1lyO3J85YPhrI8tRJtgd3JddEVF6QH8vs=
X-Received: by 2002:a37:2711:: with SMTP id n17mr3123415qkn.217.1629196240999;
 Tue, 17 Aug 2021 03:30:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210705090050.15077-1-reniuschengl@gmail.com>
 <CAPDyKFotmw-HQpZKCOD_8kThEa0_KSPnn36FNFLKRyUHYRHQjQ@mail.gmail.com>
 <CAJU4x8u8JPBJ3V6MCi1XcO4Qim-COPuxOhTdUnor7JdNCUFb=w@mail.gmail.com>
 <CAPDyKFqXsn91BvkJXMYSnc7X=RP9DXxXp2nKMmv+aMPoNdK2Tw@mail.gmail.com>
 <CAJU4x8srB7skGFVcj1SPrzEZSnVkwKiW3OPN0GQxvgtRG7GAAQ@mail.gmail.com>
 <CAPDyKFq0yHxX7wb4XGeiMiSGGiOf8RKJ5ahhFQ+_vodqnyPV9Q@mail.gmail.com>
 <CAJU4x8uGxb5VD1WVV5-QeLkVzuuR09-NacL-9nuXe8Zofzb2=w@mail.gmail.com>
 <CAPDyKFpvCFYQVEp77hiRHY6CVDej-ffF5UE=LH=HSGcqMZA02w@mail.gmail.com>
 <CAJU4x8t+aOqq82EJMUNDpWiE3GPeyZkjFhy=AkmctcDE3mx6fA@mail.gmail.com>
 <CAPDyKFoSOk+4pmW60uGzKaYw3XOXshx+NSNqF_po=VLkK1-7Qw@mail.gmail.com>
 <CAJU4x8sMJSOnfBwDq7tVygRGFRw-SyrM1z8GBsF_Mur64-Y3_g@mail.gmail.com>
 <CAJU4x8uCAQoozeAqa6icVba61uo_eP+NtOxgnLzsXh6g2HeQdA@mail.gmail.com>
 <02c26834-f16e-e1c7-9ea9-36414d1c4403@intel.com> <CAJU4x8u+BtU5iUna0tSws9rfUTJWfHZ21jteB5nk8e_2iMJgNg@mail.gmail.com>
 <43448d8e-c680-62bf-7414-4620e16de524@intel.com> <CAJU4x8u-GF8usNojgwFho_vhA5aB__3xxbhxNyaErriY485+zg@mail.gmail.com>
In-Reply-To: <CAJU4x8u-GF8usNojgwFho_vhA5aB__3xxbhxNyaErriY485+zg@mail.gmail.com>
From:   Renius Chen <reniuschengl@gmail.com>
Date:   Tue, 17 Aug 2021 18:30:29 +0800
Message-ID: <CAJU4x8uX-EG44DTak8447H6Y-RCo1k6+2ufJ_5rrw_RdXtWMwQ@mail.gmail.com>
Subject: Re: [PATCH] [v2] mmc: sdhci-pci-gli: Improve Random 4K Read
 Performance of GL9763E
To:     linux-pm@vger.kernel.org, sebastian.reichel@collabora.com,
        rjw@rjwysocki.net
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Ben Chuang <Ben.Chuang@genesyslogic.com.tw>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi PM maintainers,


Thanks for being patient with me.

Do you have any comments or suggestions about the discussions?

Please kindly let me know if you have any thought on how to proceed with th=
is.

Thank you.


Best regards,

Renius

Renius Chen <reniuschengl@gmail.com> =E6=96=BC 2021=E5=B9=B48=E6=9C=8810=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8812:23=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Hi,
>
>
> First I'd like to appreciate your time reading this mail.
>
> We had some issues with submitting a patch to MMC and the reviewer
> suggested us to look for some help from the PM mailing list.
>
> GL9763e is a PCIe card reader. During a sequence of random 4K reads,
> due to the long idle period time between read requests, GL9763e will
> enter ASPM L1 very frequently. Hence the performance of random 4K
> reads is very worse.
>
> We tried to enlarge the ASPM L1 entry delay to avoid GL9763e from
> entering ASPM L1 by the idle period time during 4K reads. But such an
> adjustment also affects other use cases. It will reduce the frequency
> of entering ASPM L1 under all conditions so that the battery life will
> be shorter. This will cause the PLT test to fail.
>
> So we develop a patch to balance the performance of 4K reads and the
> battery life. Our purpose is only to improve the performance of 4K
> reads, but not to affect any other use cases. First, we monitor the
> requests, when a sequence of 4K reads is performing, we'll modify the
> value of a vendor specified register in GL9763e to disable ASPM L1 by
> the GL9763e hardware. Then re-enable ASPM L1 after the 4K reads are
> finished.
>
> But MMC reviewers think such behaviors may not be suitable for a MMC
> host driver and believe that there may be some better ways to achieve
> our goals.
>
> So I'm here to ask for your advice. Do you have any ideas for this
> case? Are this scenario and ASPM related to runtime PM? In my
> cognition, the entering and exiting of ASPM L0s and L1 are pure
> hardware behaviors and not handled by software, they are different
> from suspend/resume and runtime PM and D0/D3, right?
>
> Thanks a lot.
>
>
> Best regards,
>
> Renius
>
> Adrian Hunter <adrian.hunter@intel.com> =E6=96=BC 2021=E5=B9=B48=E6=9C=88=
4=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=882:26=E5=AF=AB=E9=81=93=EF=
=BC=9A
> >
> > On 19/07/21 12:26 pm, Renius Chen wrote:
> > > Adrian Hunter <adrian.hunter@intel.com> =E6=96=BC 2021=E5=B9=B47=E6=
=9C=8816=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=886:27=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > >>
> > >> On 14/07/21 5:15 am, Renius Chen wrote:
> > >>> Hi Adrain,
> > >>>
> > >>> What do you think of this patch?
> > >>> Or do you have any ideas or suggestions about the modification for
> > >>> Ulf's comments?
> > >>
> > >> Perhaps try to define your power management requirements in terms of
> > >> latencies instead of request size, and then take the issue to the
> > >> power management mailing list and power management maintainers for
> > >> suggestions.  You will probably need to point out why runtime PM doe=
sn't
> > >> met your requirements.
> > >>
> > >
> > > Hi Adrain,
> > >
> > >
> > > Thanks for your advice.
> > >
> > > Our purpose is only to improve the performance of 4K reads, and we
> > > hope that it doesn't affect any other use cases. If we look into the
> > > latencies, it may affect not only 4K reads but also some other use
> > > cases.
> >
> > I just meant that, if you present the problem to people on the power
> > management mailing lists,  you probably need to describe the problem at
> > an engineering level, instead of describing your solution at a
> > programming level.
> >
> > >
> > > Behaviors of ASPM is controlled by circuits of hardware. Drivers only
> > > enable or disable ASPM or set some parameters for ASPM, and are not
> > > able to know when the device enters or exits the L0s/L1 state. So the
> > > PM part of drivers may not suit this case.
> > >
> > > This patch could be simply divided into two parts:
> > > 1. Monitor requests.
> > > 2. Set a vendor specific register of GL9763e.
> > >
> > > The part 2 is no problems we think. And Ulf thinks that the behaviors
> > > of part 1 should not be implemented in sdhci-pci-gli.c. Do you have
> > > any suggestions on where we can implement the monitoring?
> > >
> > > Thank you.
> > >
> > >
> > > Best regards,
> > >
> > > Renius
> > >
> > >>>
> > >>> Thank you.
> > >>>
> > >>>
> > >>> Best regards,
> > >>>
> > >>> Renius
> > >>>
> > >>> Renius Chen <reniuschengl@gmail.com> =E6=96=BC 2021=E5=B9=B47=E6=9C=
=887=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=889:49=E5=AF=AB=E9=81=93=
=EF=BC=9A
> > >>>>
> > >>>> Ulf Hansson <ulf.hansson@linaro.org> =E6=96=BC 2021=E5=B9=B47=E6=
=9C=887=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=888:16=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > >>>>>
> > >>>>> [...]
> > >>>>>
> > >>>>>>
> > >>>>>> Thanks, I understand what you mean.
> > >>>>>>
> > >>>>>> I simply searched for the keyword "MMC_READ_MULTIPLE_BLOCK" in t=
he
> > >>>>>> drivers/mmc/host folder, and found that in some SD/MMC host cont=
roller
> > >>>>>> driver codes such as alcor.c, cavium.c, ...etc, there are also
> > >>>>>> behaviors for monitoring the request in their driver. What's the
> > >>>>>> difference between theirs and ours?
> > >>>>>
> > >>>>> Those checks are there to allow the HWs to be supported properly.
> > >>>>>
> > >>>>>>
> > >>>>>> And if the code that monitors the requstes does not belong the d=
river,
> > >>>>>> where should I implement the code and how to add some functions =
only
> > >>>>>> for GL9763e in that place, in your opinion?
> > >>>>>
> > >>>>> Honestly, I am not sure what suits your use case best.
> > >>>>>
> > >>>>> So far we have used runtime PM with a default auto suspend timeou=
t, in
> > >>>>> combination with dev PM Qos. In other words, run as fast as possi=
ble
> > >>>>> to complete the requests in the queue then go back to idle and en=
ter a
> > >>>>> low power state. Clearly, that seems not to be sufficient for you=
r use
> > >>>>> case, sorry.
> > >>>>>
> > >>>> Yes, the runtime PM, auto suspend, and PM Qos are all about the
> > >>>> suspend/resume behaviors of the system or related to power states =
such
> > >>>> as D0/D3 of the device. But these are totally different from the A=
SPM
> > >>>> L0s/L1 for link states. Entering/exiting the ASPM is pure hardware
> > >>>> behavior on the link layer and is not handled by any codes in
> > >>>> drivers/mmc/core or drivers/mmc/host. We'd like to try to modify t=
he
> > >>>> patch by your opinions, but we are also confused about what or whe=
re
> > >>>> suits our use case best. So we wonder how to start the modificatio=
n
> > >>>> and may need some suggestions to deal with the work, sorry.
> > >>>>
> > >>>> Thank you.
> > >>>>
> > >>>>
> > >>>> Best regards,
> > >>>>
> > >>>> Renius
> > >>>>
> > >>>>
> > >>>>> Kind regards
> > >>>>> Uffe
> > >>
> >
