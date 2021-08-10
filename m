Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECAEC3E51F8
	for <lists+linux-pm@lfdr.de>; Tue, 10 Aug 2021 06:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbhHJEXg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Aug 2021 00:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhHJEXf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Aug 2021 00:23:35 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4997C0613D3;
        Mon,  9 Aug 2021 21:23:13 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id js7so10301778qvb.4;
        Mon, 09 Aug 2021 21:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Sp8FbJ4QzEAWDzcfowNI+N4TCRo3Pu+niWHMhfDJzQc=;
        b=c8u4YDzTJE+6qZzp2Dt/Ebn8ecFe6iBEe/X4V930uePtzZ5uEeXQ7uTh+pvrx42Ap2
         rmyFQdUtF7nYFH5iDh6/KbtHTaBwHzPskn+RsAsWyQz0gmXgU3xfd07rPAJUY4djSez7
         vFyyVFN/IAOhA0mM1WFg+rgdPxm0yBEzM40hoBxZd+I7fn05ElP36QoPhqOSUtmLnGvj
         MnkzPS3Dabw1YS1DR5zBSjf1J7Hse0JtmASzEsHN1dPNM7P48RsPoX64Jyvso8W4U8Za
         3KF/73POtnJq7Xz0/QZH8FEkuuifB43DOy8sSDxB07yhl+RZqlXTuAX/rT7atNZCFepn
         If5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Sp8FbJ4QzEAWDzcfowNI+N4TCRo3Pu+niWHMhfDJzQc=;
        b=lW6mvQnFOvmibcyBRaxQbOdKt0FfsnBCuK3H8rgZTx6jEHF97sJH5IT9/v3mbUZwLG
         /3oPDOaCmihZnMYV988o+OLaIQzmk8CB6BUjcsOJV3AvDcLFGFUzYB1MTc8Ca9a+s+ll
         QPDse4tls4L7tzsBo/OjH1JetVYMtlxAdDxStgYgHbT6tnI4Dfs1VgH9XFKHNyj5eF3e
         AR2n0pwj/cScXEzym30+g00H8EeLr7WfyM0CFvOnD3er6IubCrdOopV5r5gifJI9trt+
         jKSw3HwN2BxLk/V69+soKMMYni3c6dY3+xw9LkqikPPr7ANupl6FNFYeFKN0X9q6GJkM
         +pyA==
X-Gm-Message-State: AOAM5314Oqk4FKQJomWMSJCORL0z/GRelA/YOiaxkUwSd354am0eKZ88
        y/9VxPB2fmeKy+P+WNngDg1zqzVjliwXbDKSOeeUKk3MZ6Q=
X-Google-Smtp-Source: ABdhPJyn5y6JBiQt1LiWDNacqAOAgU2u93wNPvKaao29IrtXgSZSSrCBLOUPeZq0cCwOOMl8ivRLGHYSMR73XogJ3sI=
X-Received: by 2002:a0c:ca09:: with SMTP id c9mr27081614qvk.61.1628569391885;
 Mon, 09 Aug 2021 21:23:11 -0700 (PDT)
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
 <43448d8e-c680-62bf-7414-4620e16de524@intel.com>
In-Reply-To: <43448d8e-c680-62bf-7414-4620e16de524@intel.com>
From:   Renius Chen <reniuschengl@gmail.com>
Date:   Tue, 10 Aug 2021 12:23:00 +0800
Message-ID: <CAJU4x8u-GF8usNojgwFho_vhA5aB__3xxbhxNyaErriY485+zg@mail.gmail.com>
Subject: Re: [PATCH] [v2] mmc: sdhci-pci-gli: Improve Random 4K Read
 Performance of GL9763E
To:     linux-pm@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <Ben.Chuang@genesyslogic.com.tw>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,


First I'd like to appreciate your time reading this mail.

We had some issues with submitting a patch to MMC and the reviewer
suggested us to look for some help from the PM mailing list.

GL9763e is a PCIe card reader. During a sequence of random 4K reads,
due to the long idle period time between read requests, GL9763e will
enter ASPM L1 very frequently. Hence the performance of random 4K
reads is very worse.

We tried to enlarge the ASPM L1 entry delay to avoid GL9763e from
entering ASPM L1 by the idle period time during 4K reads. But such an
adjustment also affects other use cases. It will reduce the frequency
of entering ASPM L1 under all conditions so that the battery life will
be shorter. This will cause the PLT test to fail.

So we develop a patch to balance the performance of 4K reads and the
battery life. Our purpose is only to improve the performance of 4K
reads, but not to affect any other use cases. First, we monitor the
requests, when a sequence of 4K reads is performing, we'll modify the
value of a vendor specified register in GL9763e to disable ASPM L1 by
the GL9763e hardware. Then re-enable ASPM L1 after the 4K reads are
finished.

But MMC reviewers think such behaviors may not be suitable for a MMC
host driver and believe that there may be some better ways to achieve
our goals.

So I'm here to ask for your advice. Do you have any ideas for this
case? Are this scenario and ASPM related to runtime PM? In my
cognition, the entering and exiting of ASPM L0s and L1 are pure
hardware behaviors and not handled by software, they are different
from suspend/resume and runtime PM and D0/D3, right?

Thanks a lot.


Best regards,

Renius

Adrian Hunter <adrian.hunter@intel.com> =E6=96=BC 2021=E5=B9=B48=E6=9C=884=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=882:26=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On 19/07/21 12:26 pm, Renius Chen wrote:
> > Adrian Hunter <adrian.hunter@intel.com> =E6=96=BC 2021=E5=B9=B47=E6=9C=
=8816=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=886:27=E5=AF=AB=E9=81=93=
=EF=BC=9A
> >>
> >> On 14/07/21 5:15 am, Renius Chen wrote:
> >>> Hi Adrain,
> >>>
> >>> What do you think of this patch?
> >>> Or do you have any ideas or suggestions about the modification for
> >>> Ulf's comments?
> >>
> >> Perhaps try to define your power management requirements in terms of
> >> latencies instead of request size, and then take the issue to the
> >> power management mailing list and power management maintainers for
> >> suggestions.  You will probably need to point out why runtime PM doesn=
't
> >> met your requirements.
> >>
> >
> > Hi Adrain,
> >
> >
> > Thanks for your advice.
> >
> > Our purpose is only to improve the performance of 4K reads, and we
> > hope that it doesn't affect any other use cases. If we look into the
> > latencies, it may affect not only 4K reads but also some other use
> > cases.
>
> I just meant that, if you present the problem to people on the power
> management mailing lists,  you probably need to describe the problem at
> an engineering level, instead of describing your solution at a
> programming level.
>
> >
> > Behaviors of ASPM is controlled by circuits of hardware. Drivers only
> > enable or disable ASPM or set some parameters for ASPM, and are not
> > able to know when the device enters or exits the L0s/L1 state. So the
> > PM part of drivers may not suit this case.
> >
> > This patch could be simply divided into two parts:
> > 1. Monitor requests.
> > 2. Set a vendor specific register of GL9763e.
> >
> > The part 2 is no problems we think. And Ulf thinks that the behaviors
> > of part 1 should not be implemented in sdhci-pci-gli.c. Do you have
> > any suggestions on where we can implement the monitoring?
> >
> > Thank you.
> >
> >
> > Best regards,
> >
> > Renius
> >
> >>>
> >>> Thank you.
> >>>
> >>>
> >>> Best regards,
> >>>
> >>> Renius
> >>>
> >>> Renius Chen <reniuschengl@gmail.com> =E6=96=BC 2021=E5=B9=B47=E6=9C=
=887=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=889:49=E5=AF=AB=E9=81=93=
=EF=BC=9A
> >>>>
> >>>> Ulf Hansson <ulf.hansson@linaro.org> =E6=96=BC 2021=E5=B9=B47=E6=9C=
=887=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=888:16=E5=AF=AB=E9=81=93=
=EF=BC=9A
> >>>>>
> >>>>> [...]
> >>>>>
> >>>>>>
> >>>>>> Thanks, I understand what you mean.
> >>>>>>
> >>>>>> I simply searched for the keyword "MMC_READ_MULTIPLE_BLOCK" in the
> >>>>>> drivers/mmc/host folder, and found that in some SD/MMC host contro=
ller
> >>>>>> driver codes such as alcor.c, cavium.c, ...etc, there are also
> >>>>>> behaviors for monitoring the request in their driver. What's the
> >>>>>> difference between theirs and ours?
> >>>>>
> >>>>> Those checks are there to allow the HWs to be supported properly.
> >>>>>
> >>>>>>
> >>>>>> And if the code that monitors the requstes does not belong the dri=
ver,
> >>>>>> where should I implement the code and how to add some functions on=
ly
> >>>>>> for GL9763e in that place, in your opinion?
> >>>>>
> >>>>> Honestly, I am not sure what suits your use case best.
> >>>>>
> >>>>> So far we have used runtime PM with a default auto suspend timeout,=
 in
> >>>>> combination with dev PM Qos. In other words, run as fast as possibl=
e
> >>>>> to complete the requests in the queue then go back to idle and ente=
r a
> >>>>> low power state. Clearly, that seems not to be sufficient for your =
use
> >>>>> case, sorry.
> >>>>>
> >>>> Yes, the runtime PM, auto suspend, and PM Qos are all about the
> >>>> suspend/resume behaviors of the system or related to power states su=
ch
> >>>> as D0/D3 of the device. But these are totally different from the ASP=
M
> >>>> L0s/L1 for link states. Entering/exiting the ASPM is pure hardware
> >>>> behavior on the link layer and is not handled by any codes in
> >>>> drivers/mmc/core or drivers/mmc/host. We'd like to try to modify the
> >>>> patch by your opinions, but we are also confused about what or where
> >>>> suits our use case best. So we wonder how to start the modification
> >>>> and may need some suggestions to deal with the work, sorry.
> >>>>
> >>>> Thank you.
> >>>>
> >>>>
> >>>> Best regards,
> >>>>
> >>>> Renius
> >>>>
> >>>>
> >>>>> Kind regards
> >>>>> Uffe
> >>
>
