Return-Path: <linux-pm+bounces-40531-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD47BD0861D
	for <lists+linux-pm@lfdr.de>; Fri, 09 Jan 2026 11:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9371D3048DB4
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jan 2026 09:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D303358A7;
	Fri,  9 Jan 2026 09:59:42 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C54D330B0E;
	Fri,  9 Jan 2026 09:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767952782; cv=none; b=PMIxn8R8Ltj516/I5dWu4W49cpmx9o8OsWas7vguoX6/fFx6n9D3AjaYB9G0Vb2hn/4lCXnrEXfFHfpxLr2xTnQFIeYDoyqyXxSjMoAVk0wpQVBpGMiOL7lynEPx915tyWtSsTpU5C/NMVljGvzEv6ijgqRlmv1I4dlamJKHR0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767952782; c=relaxed/simple;
	bh=5dGs2EFJqJ2UinA+bYPEnGXLwuJ/Pvb1KrE1PUgDaD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UsSnXsSqw60oIJztTu6LnieslDH5Lg3ceNkaVWgGLoPt6Wg8ftY/2d1engY0ExBIK6IEZM02bTp0B+NW21zB/qGdQZgH2/zQHJ9XtUR5lZ36zDkZR8CmRCnenbhYYqmaGm3ZM22iftsG9UmUevF8E1POfolE0VA9MLu8heghmIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC5BC4CEF1;
	Fri,  9 Jan 2026 09:59:38 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: biju.das.jz@bp.renesas.com,
	cosmin-gabriel.tanislav.xa@renesas.com,
	john.madieu.xa@bp.renesas.com
Cc: conor+dt@kernel.org,
	daniel.lezcano@linaro.org,
	devicetree@vger.kernel.org,
	geert+renesas@glider.be,
	krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	lukasz.luba@arm.com,
	magnus.damm@gmail.com,
	p.zabel@pengutronix.de,
	rafael@kernel.org,
	robh@kernel.org,
	rui.zhang@intel.com
Subject: Re: [PATCH v5 5/5] thermal: renesas: rzg3e: add support for RZ/T2H and RZ/N2H
Date: Fri,  9 Jan 2026 10:59:37 +0100
Message-ID: <20260109095937.3317991-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <TY3PR01MB1134624FF7929D32670CA90F68682A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <TY3PR01MB1134624FF7929D32670CA90F68682A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Biju, Cosmin, John,

On Fri, 9 Jan 2026 at 10:06, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > From: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> > > From: Biju Das <biju.das.jz@bp.renesas.com>
> > > > From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> > > > The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs expose
> > > > the temperature calibration via SMC
> > > > SIP and do not have a reset for the TSU peripheral, and use
> > > > different minimum and maximum temperature
> > > > values compared to the already supported RZ/G3E.
> > > >
> > > > Although the calibration data is stored in an OTP memory, the OTP
> > > > itself is not memory-mapped, access
> > > > to it is done through an OTP controller.
> > > >
> > > > The OTP controller is only accessible from the secure world, but the
> > > > temperature calibration data stored in the OTP is exposed via SMC.
> > > >
> > > > Add support for retrieving the calibration data using arm_smcc_smc().
> > > >
> > > > Add a compatible for RZ/T2H, RZ/N2H can use it as a fallback.
> > > >
> > > > Reviewed-by: John Madieu <john.madieu.xa@bp.renesas.com>
> > > > Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
> > > > Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

> > > > --- a/drivers/thermal/renesas/rzg3e_thermal.c
> > > > +++ b/drivers/thermal/renesas/rzg3e_thermal.c
> > > > @@ -4,6 +4,7 @@
> > > >   *
> > > >   * Copyright (C) 2025 Renesas Electronics Corporation
> > > >   */
> > > > +#include <linux/arm-smccc.h>
> > > >  #include <linux/clk.h>
> > > >  #include <linux/cleanup.h>
> > > >  #include <linux/delay.h>
> > > > @@ -70,6 +71,10 @@
> > > >  #define TSU_POLL_DELAY_US        10      /* Polling interval */
> > > >  #define TSU_MIN_CLOCK_RATE       24000000  /* TSU_PCLK minimum 24MHz */
> > > >
> > > > +#define RZ_SIP_SVC_GET_SYSTSU    0x82000022
> > >
> > > Maybe add a comment mentioning firmware should support this index and
> > > the otp value is stored in
> > > arm_smccc_res.a0
> >
> > The fact that the calibration value is stored in .a0 is clear from the retrieval code, let's not add
> > comments where the code is straightforward.

Agreed.

> If you have just a0, then driver expect a0 from firmware
> is either error and OTP value.
>
> If you have a0 and a1
>
> Success case a0=0
> Error case a0=SMC_UNK
>
> a1 will have the value from OTP.
>
> > Regarding the firmware support, it's obvious that the firmware needs to support this and that the
> > values don't just magically appear, no?
>
> How do you share this info to customers that they have their own firmware?
>
> Eg: Customer firmware is using different service ID and driver uses different one.

Specify the service ID in DT?

> > > > +#define OTP_TSU_REG_ADR_TEMPHI   0x01DC
> > > > +#define OTP_TSU_REG_ADR_TEMPLO   0x01DD
> > > > +
> > > >  struct rzg3e_thermal_priv;
> > > >
> > > >  struct rzg3e_thermal_info {
> > > > @@ -362,6 +367,21 @@ static int rzg3e_thermal_get_syscon_trim(struct rzg3e_thermal_priv *priv)
> > > >   return 0;
> > > >  }
> > > >
> > > > +static int rzg3e_thermal_get_smc_trim(struct rzg3e_thermal_priv
> > > > +*priv) {
> > > > + struct arm_smccc_res local_res;
> > > > +
> > > > + arm_smccc_smc(RZ_SIP_SVC_GET_SYSTSU, OTP_TSU_REG_ADR_TEMPLO,
> > > > +               0, 0, 0, 0, 0, 0, &local_res);
> > > > + priv->trmval0 = local_res.a0 & TSU_CODE_MAX;
> > >
> > > Do you think it is worth to ask firmware team to return error values
> > > in a0 and actual OTP value in a1.
> > >
> > > So that driver can check the error code and propagate to the caller.
> >
> > If we do that, we will have one more variant to handle here, as we cannot make sure that the TF-A
> > running on the board is always the latest.
>
> Mainline will use new variant, that can have both a0 and a1, if we take that route.
>
> > Right now things are simple as it's either supported or not supported.

Agreed.

> > If a0 is some error value, how would you distinguish between an error in the new variant and a proper
> > value in the old variant? Both cases would only populate a0.
> >
> > Also, I'm not sure how much use we can get out of a TF-A error value.
> >
> > The error that TF-A already returns in SMC_UNK = -1, or 0xFFFFFFFF in u32, it is pretty standard for
> > SMC calls and the probe() function already checks against it.
>
> The OTP value can be 0xFFFFFFFF, if it is not programmed, if that is case
> How do you distinguish error with respect actual otp value.

What is the expected behavior when the firmware interface is not
available, or the OTP is not programmed?
Currently the thermal driver fails to probe, which is IMHO suboptimal.
An alternative would be to fallback to default calibration values,
as done on R-Car Gen3.  To handle that, rzg3e_thermal_get_smc_trim()
should store the unmasked values in trmval[01], so the probe code can
detect this case.

BTW, what are the default values of the trim registers on RZ/G3E, when
the device is not trimmed? Or is this always done, unlike programming
the OTP on RZ/T2H?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

