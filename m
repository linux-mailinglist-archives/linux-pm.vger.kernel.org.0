Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C174345E330
	for <lists+linux-pm@lfdr.de>; Fri, 26 Nov 2021 00:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346596AbhKYXJy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Nov 2021 18:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbhKYXHy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Nov 2021 18:07:54 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDA0C06175C;
        Thu, 25 Nov 2021 14:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wQuHXlBFJqnlo5nDE5hfSpy5l/NqT3aDB+7JK7woqu4=; b=BhFtjZXvSCNH7azkiOJi+/qe1N
        8y/UacMTEMpB4RGwUoM/uQHtKdYLx0D/6TBB2JdY9+ggh0kC7xU9XbzNjwNLfKXps25m87zwQkY3H
        5pXEQd+7T2qnMojZ2L/pW7zNYrAKO4QYitZtCw4uGA2x9K1t36+h/r1jwwnm0vWbsbzI=;
Received: from p200300ccff2cb1001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff2c:b100:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1mqNiK-0000SS-EK; Thu, 25 Nov 2021 23:59:36 +0100
Date:   Thu, 25 Nov 2021 23:59:35 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Alistair Francis <alistair23@gmail.com>
Cc:     Alistair Francis <alistair@alistair23.me>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>, lgirdwood@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        rui.zhang@intel.com, devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-hwmon@vger.kernel.org, amitk@kernel.org,
        linux-pm@vger.kernel.org, dl-linux-imx <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v15 1/8] dt-bindings: mfd: Initial commit of
 silergy,sy7636a.yaml
Message-ID: <20211125235935.5a1b7d33@aktux>
In-Reply-To: <CAKmqyKP_gQ1qSADMPwmyf-V0TqGOYf2GitzpDXsmBUO6_iqK7Q@mail.gmail.com>
References: <20211110122948.188683-1-alistair@alistair23.me>
        <20211110122948.188683-2-alistair@alistair23.me>
        <20211117223950.3a7eaf7a@aktux>
        <CAKmqyKP_gQ1qSADMPwmyf-V0TqGOYf2GitzpDXsmBUO6_iqK7Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 23 Nov 2021 23:29:26 +1000
Alistair Francis <alistair23@gmail.com> wrote:

> On Thu, Nov 18, 2021 at 7:40 AM Andreas Kemnade <andreas@kemnade.info> wrote:
> >
> > On Wed, 10 Nov 2021 22:29:41 +1000
> > Alistair Francis <alistair@alistair23.me> wrote:
> >  
> > > Initial support for the Silergy SY7636A Power Management chip
> > > and regulator.
> > >
> > > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >  .../bindings/mfd/silergy,sy7636a.yaml         | 79 +++++++++++++++++++
> > >  1 file changed, 79 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml b/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
> > > new file mode 100644
> > > index 000000000000..0566f9498e2f
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml  
> > [...]  
> > > +  regulators:
> > > +    type: object
> > > +
> > > +    properties:
> > > +      compatible:
> > > +        const: silergy,sy7636a-regulator
> > > +
> > > +      vcom:
> > > +        type: object
> > > +        $ref: /schemas/regulator/regulator.yaml#
> > > +        properties:
> > > +          regulator-name:
> > > +            const: vcom
> > > +  
> > hmm, this is what? If I understand it correctly, vcom means some
> > voltage for compensation. On other comparable pmics (e.g. TPS65185
> > which has also a sane public datasheet, MAX17135) I have seen some
> > methods to measure a voltage while the display is doing something
> > defined and then program this voltage non-volatile for compensation
> > during manufacturing.
> >
> > If I understand the code correctly all the bunch of voltages are
> > powered up if this one is enabled.
> > So at least a description should be suitable.
> >
> > The other comparable PMICs have at least regulators named VCOM, DISPLAY
> > (controls several regulators, started with delays configured via
> > registers) and V3P3. MAX17135 source can be found in NXP kernels,
> > TPS65185 in Kobo vendor kernels.
> >
> > So I would expect to see something similar here and a description or at
> > least not such a misleading name as vcom if it is for some reason not
> > feasible to separate the regulators.  
> 
> This is a vcom in the sense of voltage for compensation. We just
> currently don't support setting the vcom.
> 
> I had a look at the Kobo code and this is similar to
> https://github.com/akemnade/linux/blob/kobo/epdc-pmic-5.15/drivers/regulator/sy7636-regulator.c#L614
> 
> So I think that vcom is still the appropriate name for this.
> 
seems that you did not get me. If I understand the code behind it
correctly, it turns on all power rails (the +-15V stuff, VEE and so on)
with the defined delays, not just vcom because it sets
SY7636A_OPERATION_MODE_CRL_ONOFF. Controlling VCOM separately is possible
by using SY7636A_OPERATION_MODE_CRL_VCOMCTL in combintion with a
vcom_en gpio.

I do not see a reason to turn on vcom only without the other higher
voltage rails, so the behaviour is not necessarily wrong but if I read
the binding documentation I would expect that just vcom is turned on.
That is the mismatch I am talking about.

If we agree on this idea that one regulator is enabling everything, I
would adapt my EPDC drm driver and tps65185 driver (which are both in
my clean up to be upstreamable-queue). 

Just another thing to compare with:
https://github.com/Freescale/linux-fslc/blob/4.1-2.0.x-imx/drivers/regulator/max17135-regulator.c
that seems to be the starting point for kobo vendor kernel epd pmics.
They seem to have taken the source and modified things. There we have
regulators with empty ops for that step-up converted stuff, a separate
vcom and a display regulator which really controls all of these step-up
things.

Regards,
Andreas
