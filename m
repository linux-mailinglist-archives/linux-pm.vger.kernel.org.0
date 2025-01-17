Return-Path: <linux-pm+bounces-20641-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E39A15826
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 20:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 276D4188A0DB
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 19:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A435E1A76BC;
	Fri, 17 Jan 2025 19:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PcmyZM42"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705A3647;
	Fri, 17 Jan 2025 19:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737142230; cv=none; b=ALfhR8NjqHDQBg+cWq50x+SLFjHoDMokjCqO/ZPmg05knZ7S3wRprczC1Z7zh+n82w0/LP8IJ25Y7VRGgdDe422wxx0/PiSMS6haFw75RWe2FK95PvWJbt26925B117W5LlG7eFs615ddQPHt26GZXIkQ0PeZdZVYvrkAGGHCuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737142230; c=relaxed/simple;
	bh=foNB1y1uq0V8qV5aIiltQZucaZ3/EtCVUoN7QygiX5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bsH6Xujyjr8yV0GdkIUDfDhpRKAGBGLMJ7n4ptInCM4abflYibjHtzjAYoysdDFFIbBmISf5mIIym8X3A28rwXzWKsnnUDYxsgtuHT8qO/i4G1R6lmjci1vykWJxrXW3Aa2lRO1yDksgW7MvQBat445SOzhcxYSafRJPUPz0Bqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PcmyZM42; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EECCEC4CEE3;
	Fri, 17 Jan 2025 19:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737142230;
	bh=foNB1y1uq0V8qV5aIiltQZucaZ3/EtCVUoN7QygiX5Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PcmyZM42OBbUN2s+eMJMWvVKqqjZr4qKzBrGmV7jIAMV0JFtG5sZ+wh5O3YcmKftS
	 G3gKho6KPMSGYMCPoa0ni7euRpnJ9cki2DiLySsFoanbzl+2S1gcHj6gLpMsEZu1HM
	 114n/v9wwuIE1WF4XCKogkOMXjll4Lk9wr/T2dpAuvwdIOZ26HGBl2r3T/UlYiyQKx
	 +PyRPWHOedh7ByLlqUQ1/DkBfzi3RCQjrByM5PKYnUHz4obNDvDsr+XiC48gBJF76i
	 IxMo6Zsw/xB3AgHbijeBJdE3c47qoXpm2CCA68ThQ11RR5KMIIg1VLc41oJYIy7uwx
	 DXTQAyGot5wzQ==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5f6497fbccbso2013702eaf.0;
        Fri, 17 Jan 2025 11:30:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUu6XDZ85bG6E4cwAd9di3yjprVtfGuYFkKC/fVOpBX4KXjiDvP2sivvewExPTfj0l+jIK7unwt7KQ=@vger.kernel.org, AJvYcCWjSBS0K8TBtB2wsXltnc3AF3pbS7DzDqrCdUTRGJrTzH0h99h1VOd8KXzOO8WxOlnQe6L23aYYXlh6qQjy@vger.kernel.org, AJvYcCX0l4HUxkT+UE7+NW7zYI+w1231ZL4Ogckg3rsix+Fkaf1x2geNZRRmRjzd8J99jVNF/x8MiEvYTtEtbf0=@vger.kernel.org, AJvYcCXcAzS7Aq0Mf1Nx1toI1TE5ELe/WV/KXtRey2zusqt0Bd5FN1UyITzOzY7qZ4J3I1djMTsdd77HTIY2@vger.kernel.org, AJvYcCXoNZ3gM3vGEftXnlmJBigY99TfU5RzAHLXgFa5kW6cRjLS6m6a1O1SAGhQJjmDc/xnM3u4rgrK3OrJ3K0H@vger.kernel.org
X-Gm-Message-State: AOJu0YyeCWt6Rrew9YdZBYPnnyyEnrecKw/pGXmp4uaNm96mI2FLs+Rj
	0FvagisT05cpS2KIFX5wq3Pf63t/llIK9Sv0zvPUTySBud0t9PztpJS6RYarn1yK/reg66qA+1E
	xMODdvdMq0BmwnfmIVgg8RP9LnA4=
X-Google-Smtp-Source: AGHT+IEOihIY7mUOa4hVP1bqotPmsr69h5OgdfXyZbu/sRbspauTxsDS8YOdvCTlZN7dTpnC3uxq7LK3T+tCxi8e13Q=
X-Received: by 2002:a05:6871:296:b0:29e:2a06:8405 with SMTP id
 586e51a60fabf-2b186ca0224mr7419767fac.19.1737142229222; Fri, 17 Jan 2025
 11:30:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103-wake_irq-v2-0-e3aeff5e9966@nxp.com> <20250103-wake_irq-v2-1-e3aeff5e9966@nxp.com>
 <CAJZ5v0hj7wUU3f_j5QH3fNUFKokaXr0octaP2M1Ho_L_BspoUA@mail.gmail.com> <PAXPR04MB8459EE38DBDBCA29FB81B6B788192@PAXPR04MB8459.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB8459EE38DBDBCA29FB81B6B788192@PAXPR04MB8459.eurprd04.prod.outlook.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 17 Jan 2025 20:30:18 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jb=0c5m=FeA-W-aG30H4706Ay_xCHTsiC1S-7MuGxqTQ@mail.gmail.com>
X-Gm-Features: AbW1kva3YRwOs-mqOCr7xIZ_pL_VsK5_Sa-oqdUbd008qjcQYrdbDr5ihs4pOnQ
Message-ID: <CAJZ5v0jb=0c5m=FeA-W-aG30H4706Ay_xCHTsiC1S-7MuGxqTQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/12] PM: sleep: wakeirq: Introduce device-managed
 variant of dev_pm_set_wake_irq
To: Peng Fan <peng.fan@nxp.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, 
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Conor Dooley <conor.dooley@microchip.com>, Daire McNamara <daire.mcnamara@microchip.com>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, 
	"linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>, 
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 2:28=E2=80=AFAM Peng Fan <peng.fan@nxp.com> wrote:
>
> > Subject: Re: [PATCH v2 01/12] PM: sleep: wakeirq: Introduce device-
> > managed variant of dev_pm_set_wake_irq
> >
> > On Fri, Jan 3, 2025 at 9:42=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp=
.com>
> > wrote:
> > >
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > Add device-managed variant of dev_pm_set_wake_irq which
> > automatically
> > > clear the wake irq on device destruction to simplify error handling
> > > and resource management in drivers.
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  drivers/base/power/wakeirq.c | 26 ++++++++++++++++++++++++++
> > >  include/linux/pm_wakeirq.h   |  6 ++++++
> > >  2 files changed, 32 insertions(+)
> > >
> > > diff --git a/drivers/base/power/wakeirq.c
> > > b/drivers/base/power/wakeirq.c index
> > >
> > 5a5a9e978e85f3fc9d89cb7d43527dc1dd42a9b1..8aa28c08b2891f3af
> > 490175362cc
> > > 1a759069bd50 100644
> > > --- a/drivers/base/power/wakeirq.c
> > > +++ b/drivers/base/power/wakeirq.c
> > > @@ -103,6 +103,32 @@ void dev_pm_clear_wake_irq(struct device
> > *dev)  }
> > > EXPORT_SYMBOL_GPL(dev_pm_clear_wake_irq);
> > >
> > > +static void devm_pm_clear_wake_irq(void *dev) {
> > > +       dev_pm_clear_wake_irq(dev);
> > > +}
> > > +
> > > +/**
> > > + * devm_pm_set_wake_irq - device-managed variant of
> > > +dev_pm_set_wake_irq
> > > + * @dev: Device entry
> > > + * @irq: Device IO interrupt
> > > + *
> > > + *
> > > + * Attach a device IO interrupt as a wake IRQ, same with
> > > +dev_pm_set_wake_irq,
> > > + * but the device will be auto clear wake capability on driver detac=
h.
> > > + */
> > > +int devm_pm_set_wake_irq(struct device *dev, int irq) {
> > > +       int ret;
> > > +
> > > +       ret =3D dev_pm_set_wake_irq(dev, irq);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       return devm_add_action_or_reset(dev,
> > devm_pm_clear_wake_irq,
> > > +dev); } EXPORT_SYMBOL_GPL(devm_pm_set_wake_irq);
> > > +
> > >  /**
> > >   * handle_threaded_wake_irq - Handler for dedicated wake-up
> > interrupts
> > >   * @irq: Device specific dedicated wake-up interrupt diff --git
> > > a/include/linux/pm_wakeirq.h b/include/linux/pm_wakeirq.h index
> > >
> > d9642c6cf85211af603ce39e280a5b4de6617ee5..25b63ed51b765c2c6
> > 919f259668a
> > > 12675330835e 100644
> > > --- a/include/linux/pm_wakeirq.h
> > > +++ b/include/linux/pm_wakeirq.h
> > > @@ -10,6 +10,7 @@ extern int dev_pm_set_wake_irq(struct device
> > *dev,
> > > int irq);  extern int dev_pm_set_dedicated_wake_irq(struct device
> > > *dev, int irq);  extern int
> > > dev_pm_set_dedicated_wake_irq_reverse(struct device *dev, int irq);
> > > extern void dev_pm_clear_wake_irq(struct device *dev);
> > > +extern int devm_pm_set_wake_irq(struct device *dev, int irq);
> > >
> > >  #else  /* !CONFIG_PM */
> > >
> > > @@ -32,5 +33,10 @@ static inline void
> > dev_pm_clear_wake_irq(struct
> > > device *dev)  {  }
> > >
> > > +static inline int devm_pm_set_wake_irq(struct device *dev, int irq) =
{
> > > +       return 0;
> > > +}
> > > +
> > >  #endif /* CONFIG_PM */
> > >  #endif /* _LINUX_PM_WAKEIRQ_H */
> > >
> > > --
> >
> > I can apply this patch for 6.14, but the rest of the series will need t=
o be
> > picked up by the respective driver maintainers.
> >
> > I hope this works for you?
>
> Yes. please just pick up patch 1.

OK, applied.

Thanks!

