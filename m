Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5029E22B3FB
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jul 2020 18:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbgGWQ4a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Jul 2020 12:56:30 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:42561 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726621AbgGWQ43 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jul 2020 12:56:29 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 97CED5803E3;
        Thu, 23 Jul 2020 12:56:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 23 Jul 2020 12:56:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm3; bh=K
        g1waUoyA+NkTIudzcDA7EYsIpv+8sxwcxiRVeSkViE=; b=LHhJBmkpXMoLlBGlq
        jKFJhh+YxPr3fQiICWg55PbLzpTYxX09tFLlPgJYRXfmhXxwJnUlTPzlh4kopqBR
        Nq96KwXiw3ouV+AuGle3rsTCPe7tUtCJ/wZWYSv2KoHu3V74T93ImaR1NCBI51tw
        wKpIdtkvpgTDRUgGduKX0JM22IF7XG+IJJ1qeM2Qzt/cI+9U/P1YvW9m8fvzRAv7
        l4u/QjCQx/Co1+4Nj8EMrfhKa9o3NKaURwGGOY4dopNEp5mfukJN+QhX7aVLFKsK
        rBjlcHJq+u/FUjXQPEIQ0RvIeG15ThSP9jjjSWKhoKdxaVaIgY4jX3dLb2Juf0eb
        auHLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=Kg1waUoyA+NkTIudzcDA7EYsIpv+8sxwcxiRVeSkV
        iE=; b=XL3SPegnwB5spUxfsdsmxNVGfReZ+zHLQ32sFNVZNXlZt+j1K6t6cieEQ
        otyWGD1Jq7lpcDUIMSuj3yjIJbd195LKLOdLTqxezYOIcdWdriHEpaLCvzDURYUz
        qzRj9LgFxpDBgAC502d7syXjgWEQEMBTi2odi1pQunqzs5XijqxPW+ruFclsTscI
        DYuRkc1hxCKfr+P5wS9ZBwEaqpk2xF0UwtK9HZamyh/1wd0ab6Zni9Ro8V0np3IK
        eSqv8+kh29px2JseVCJ6Q84js81Qyi36IvDmI2n5UCWrcf8KDl+oocPZ81vkRXVs
        3Q3cOjfdEC1zPCJzaqHVxGgtbRfag==
X-ME-Sender: <xms:O8EZX51gu4H5M_KLxhNbpodK-NPAN6uUsUTcEXKqNnGxTp2i6Xkorg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrhedugdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtugfgjgesthhqredttddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpefgjeettdejgffgffdvteeutdehtdehgeehueetkeefgefhtdetjeekledu
    gedvudenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedune
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:O8EZXwFNRxTX-vv8gbd6potrbSHikN1ayiMUWvEc8Es9VV2qpicZlQ>
    <xmx:O8EZX54H14OfvgkTKaLSoq29PRZi0c7y5p5aptPnm6RC2z82KPpiwA>
    <xmx:O8EZX22e8aGChumKz5WFkdOHoMd8pB0vmatT4YaOSMMnuhQt_5fLpA>
    <xmx:PMEZX6YT7xKGkWPltsNU2rpI8AqDFXqK0LTeAv-G8Ftal7hnJCE0_A>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 226EF30600DC;
        Thu, 23 Jul 2020 12:56:27 -0400 (EDT)
Date:   Thu, 23 Jul 2020 18:56:25 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Frank Lee <tiny.windzz@gmail.com>,
        Frank Lee <frank@allwinnertech.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?utf-8?B?6buE54OB55Sf?= <huangshuosheng@allwinnertech.com>,
        liyong@allwinnertech.com
Subject: Re: [PATCH v4 08/16] thermal: sun8i: add TEMP_CALIB_MASK for
 calibration data in sun50i_h6_ths_calibrate
Message-ID: <20200723165625.zo5d4sv27y3dtcbb@gilmour.lan>
References: <cover.1594708863.git.frank@allwinnertech.com>
 <b8761e036b25f20873534e5f8d10b37b5d2ce72c.1594708864.git.frank@allwinnertech.com>
 <4771acd6-ecd3-b8e1-8605-75d78720b1d3@linaro.org>
 <CAEExFWv9_1kec_b+t+nnvT3cziXzmVa8GzJT3pQAZiCf4KA0ig@mail.gmail.com>
 <836e1b23-1c75-57fe-6e45-f7141272071c@linaro.org>
 <CAEExFWsJBizFArd+9Mh6D=o6rvD7GLPZ-1pNFzTvBiE+uKwVhQ@mail.gmail.com>
 <c1491845-ebd0-27d2-cf50-a8c5847869ab@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c1491845-ebd0-27d2-cf50-a8c5847869ab@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 20, 2020 at 12:38:10PM +0200, Daniel Lezcano wrote:
> On 20/07/2020 11:27, Frank Lee wrote:
> > HI,
> > On Fri, Jul 17, 2020 at 3:56 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 17/07/2020 09:35, Frank Lee wrote:
> >>> On Fri, Jul 17, 2020 at 12:26 PM Daniel Lezcano
> >>> <daniel.lezcano@linaro.org> wrote:
> >>>>
> >>>> On 14/07/2020 09:13, Frank Lee wrote:
> >>>>> From: Yangtao Li <frank@allwinnertech.com>
> >>>>>
> >>>>> For sun50i_h6_ths_calibrate(), the data read from nvmem needs a rou=
nd of
> >>>>> calculation. On the other hand, the newer SOC may store other data =
in
> >>>>> the space other than 12bit sensor data. Add mask operation to read =
data
> >>>>> to avoid conversion error.
> >>>>>
> >>>>> Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> >>>>> Reviewed-by: Yangtao Li <tiny.windzz@gmail.com>
> >>>>
> >>>> Can you clarify these SoB ?
> >>>
> >>> Previously I used 'Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>',
> >>> maybe this should be removed directly?
> >>>
> >>>>
> >>>> Frank Lee=3D=3DYangtao Li=3D=3Dfrank@allwinnertech.com=3D=3Dtiny.win=
dzz@gmail.com ?
> >>>>
> >>>
> >>> Yeah.
> >>
> >> You are not supposed to add reviewed-by yourself. Please remove it.
> >=20
> > Should I resend the entire series or just the thermal patch?
> > What about those that have been applied.
>=20
> I can not speak on behalf of other maintainers.
>=20
> The simplest would be to ask them directly.
>=20
> If you want to go forward with the thermal changes, you can send them
> separately but Maxim's Ack will be needed anyway.

Given that I had a few other comments on the other patches, I guess you
can resend the whole series, it will be simpler to track down.

Maxime
