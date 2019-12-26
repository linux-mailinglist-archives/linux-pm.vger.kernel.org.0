Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77E3A12AC42
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2019 13:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfLZMsf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Dec 2019 07:48:35 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:35908 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbfLZMsf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Dec 2019 07:48:35 -0500
Received: by mail-io1-f67.google.com with SMTP id r13so13114328ioa.3;
        Thu, 26 Dec 2019 04:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Qyu5/qGz7cbokfaVr/Hbo6e3ec8nfhc/yTVZxVcJAHc=;
        b=YefnrY+EbXXFw6NCNms+uP2FauCYX8EKKW7IStqcgZ54KItrEGn/LydFpjMviil83f
         IW1I3cuFJuujnMkaahO8vjHIvrmwA2q81wpVQCAVyvqSefBHQd6tnGsnfs70RejWHS45
         9M3N3yI3DsqIK6LzRuXKOBTf6Rkkyra6B55MxKyi7GiAlGbcApJ2snZ6JYLsUp4tChO9
         +FUQkpP5R3u0L9oJhT8ittb4GYvz6lo/boEJwrBNG5+BL2XERJCWwtoiABAshfGI4jVC
         9hZxJMGZUN+z+Zxks+onaDk2szb+ZRO3a0mWxmJFRVlb5Xz7drOwssgD6oCH6BmfRFt9
         wkjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Qyu5/qGz7cbokfaVr/Hbo6e3ec8nfhc/yTVZxVcJAHc=;
        b=RYJTdnj3nSnXGjXRnPWbnkr/jVbFECX8x8ogAeB40krJgvCnwtYxpGltw2hgSaL4u/
         2dALbl4qiHnLH/emODaXNH2dKI8jH4e6uAzqkHsErH26Chk/VrlgEjVpOhnm56n4A2Sr
         6h2oJLWyuKpLnp7EPUleeHy2LzrXL/5pRhZj5KlVNmB2T9MTudIi/jj1/86gIfVQG07m
         OWYx+PR5SXYQP4/k3e+wd0kRgZX/59oKTruBs44xbLmDDIt5IpFJYZobeVZW6nBcS/e8
         bshYA7tNu+wNCxwIKkFnbp1bbCap5MOQZb3BQKQ/VpU9sXxx3Kdw3BfQJ1k5AR43/mlP
         m0sw==
X-Gm-Message-State: APjAAAW4b5J1ziC2wZ5BMkmoBtDTwj4WX5QSgwAXLvVl8ybD9LFXbaf8
        patI31KXJwX5gOWSzGkxXUhFPqQOnsMASiYFFJQ=
X-Google-Smtp-Source: APXvYqzgTHGdCwlE1xHWPIw+T/zvXXg/5Q23YMQERnKG40D0J11GZjNSHiZT89pjLxBM19FDQcJcvzXznwVR1Scakqc=
X-Received: by 2002:a6b:c410:: with SMTP id y16mr28959521ioa.18.1577364514436;
 Thu, 26 Dec 2019 04:48:34 -0800 (PST)
MIME-Version: 1.0
References: <20191219172823.1652600-1-anarsoul@gmail.com> <20191219173321.bni4tbrhfkkphv7k@gilmour.lan>
 <4015380d-33ef-312c-a886-6e8bf65c976a@linaro.org> <20191226092751.dc3boaxsaeivuhw4@hendrix.home>
 <20191226104419.GA26677@Red>
In-Reply-To: <20191226104419.GA26677@Red>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Thu, 26 Dec 2019 20:47:47 +0800
Message-ID: <CAEExFWtNZM3QSSMEksK=-opKZqxvCqyG2=3=iCo3VU6tfie64w@mail.gmail.com>
Subject: Re: [PATCH v8 0/7] add thermal sensor driver for A64, A83T, H3, H5,
 H6, R40
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>,
        "David S. Miller" <davem@davemloft.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 26, 2019 at 6:44 PM Corentin Labbe
<clabbe.montjoie@gmail.com> wrote:
>
> On Thu, Dec 26, 2019 at 10:27:51AM +0100, Maxime Ripard wrote:
> > On Tue, Dec 24, 2019 at 07:30:55PM +0100, Daniel Lezcano wrote:
> > > On 19/12/2019 18:33, Maxime Ripard wrote:
> > > > Hi,
> > > >
> > > > On Thu, Dec 19, 2019 at 09:28:16AM -0800, Vasily Khoruzhick wrote:
> > > >> This patchset adds driver for thermal sensor in A64, A83T, H3, H5,
> > > >> H6 and R40 SoCs.
> > > >
> > > > Thanks again for working on this.
> > > >
> > > > I'll merge the DT patches when the driver will have been merged.
> > >
> > > I've applied patches 1 & 2.
> > >
> > > They are in the testing branch and will go to the linux-next branch a=
s
> > > soon as the kernelci passes.
> >
> > I just merged all the other patches (except the patch 6, for the H6,
> > as requested by Vasily on IRC).
> >
>
> Hello
>
> Vasily asked to not apply H6 due to my test failling on h6 and since he d=
idnt own any H6 hw.
> But it was failling due my fault (a failling build).
>
> So the patchset work perfect on H6 (opi1+, opi3, pineH64 both model A and=
 B) as reported by my answer to this thread.

HI Corentin,

Although it is not calibrated, it should work on the R40. Can you give
my patch a try?

Thx=EF=BC=8C
Yangtao

>
> Regards
