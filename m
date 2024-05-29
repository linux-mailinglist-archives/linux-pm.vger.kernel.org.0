Return-Path: <linux-pm+bounces-8387-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 614018D3AC8
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 17:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAD8F1F246F5
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 15:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E211802BC;
	Wed, 29 May 2024 15:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ChGCLx22"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7C017DE0F;
	Wed, 29 May 2024 15:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716996394; cv=none; b=q2qCZ0wffEzFGcp/I8JoHVSpzkBcJ0X90CPW5ocCgTO1fwnvMk8t6DS+RpSCjU0gZZ3SX6C7YcVfZrhYqtJujPGojxwWUBf9oIHjj3UWtddAMUUj5ARmvw1Eo3iMtClis34HIFIx80DMprz1LjfTPqmoqzlI0pQQMTd+3UDzMgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716996394; c=relaxed/simple;
	bh=wo336CkD1y3kvT7y2cjNBDeC4dlb8iXbUrJSZN/WcXw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=k6Eh2py9qBKteHNuldKXRUltpb1Ja04kZEdW/QJ4l7mYuXAkuq96/TscFBfIQBBA0H9R4buyCOB1bNBOfckb5/QdGDmfp9IgfrIMwoDz1G0zfu6KicM6nGsZBySOaLMDQwCmMibpp3RsuLecW4/EJ3QgaSi+MM3bWBLLwxZyFCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ChGCLx22; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716996393; x=1748532393;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=wo336CkD1y3kvT7y2cjNBDeC4dlb8iXbUrJSZN/WcXw=;
  b=ChGCLx2258aBNZscjFfzVD8MU+ajUsD5TveRR/mLD9uOAz5li0WCbu8O
   0dJePwhEzujPXfPTq2CH0fLDvzbCJTJieeDK5j/jWhalnduK954OSCfjW
   tDrXpWOMgcM8MD0NcZWsacrEjgQ4xuIzvrH9Adesaz+wuDJQLNi+UDU8S
   fjUadPIqP30u1JBxWfkfWafUbt6FisgVcWl4iU+9d1sxqLFU2nCQtCkJx
   RMqbV8gtNdbxbyZ816T03btnMsKlav/fYL8zbi1yohw3smClxD3/MyBrh
   JbTc3UCl4lUrKFfy32bISdu1FhRcogTTgYD4nLfjY2sM3udk55461UG95
   A==;
X-CSE-ConnectionGUID: /MTqi3cSTn6zBorId+rASw==
X-CSE-MsgGUID: aW9qEvI9QGKjFdf6pYNUhw==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="16357618"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="16357618"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 08:26:16 -0700
X-CSE-ConnectionGUID: tFxFCcgbRZanUkkNBCx9rg==
X-CSE-MsgGUID: QvoOnNOCTS+PgaWckhHpqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="35533515"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.149])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 08:26:11 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 29 May 2024 18:26:07 +0300 (EEST)
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
    Hans de Goede <hdegoede@redhat.com>, 
    Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
    Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Konrad Dybcio <konrad.dybcio@linaro.org>, linux-pm@vger.kernel.org, 
    devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org, linux-usb@vger.kernel.org, 
    linux-arm-msm@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>
Subject: Re: [PATCH v4 3/6] usb: typec: ucsi: add Lenovo Yoga C630 glue
 driver
In-Reply-To: <CAA8EJproC_mW4pZ_C-BUUm73xfqja0EKVLvCZ+C_1dhW3xoEnw@mail.gmail.com>
Message-ID: <97448807-e567-05a4-9361-efcc84b5f07f@linux.intel.com>
References: <20240528-yoga-ec-driver-v4-0-4fa8dfaae7b6@linaro.org> <20240528-yoga-ec-driver-v4-3-4fa8dfaae7b6@linaro.org> <ce6cbe69-f1de-1224-2a6e-3c7b07203d84@linux.intel.com> <CAA8EJproC_mW4pZ_C-BUUm73xfqja0EKVLvCZ+C_1dhW3xoEnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-268320193-1716996253=:1108"
Content-ID: <a301cc47-942d-3661-b1ec-5130087bf169@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-268320193-1716996253=:1108
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <6d420af6-f53c-8618-6400-2923bec3ea61@linux.intel.com>

On Wed, 29 May 2024, Dmitry Baryshkov wrote:

> On Wed, 29 May 2024 at 17:20, Ilpo J=E4rvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> >
> > On Tue, 28 May 2024, Dmitry Baryshkov wrote:
> >
> > > The Lenovo Yoga C630 WOS laptop provides implements UCSI interface in
> > > the onboard EC. Add glue driver to interface the platform's UCSI
> > > implementation.
> > >
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > ---
> > >  drivers/usb/typec/ucsi/Kconfig          |   9 ++
> > >  drivers/usb/typec/ucsi/Makefile         |   1 +
> > >  drivers/usb/typec/ucsi/ucsi_yoga_c630.c | 189 ++++++++++++++++++++++=
++++++++++
> > >  3 files changed, 199 insertions(+)
> > >
> > > diff --git a/drivers/usb/typec/ucsi/Kconfig b/drivers/usb/typec/ucsi/=
Kconfig
> > > index bdcb1764cfae..680e1b87b152 100644
> > > --- a/drivers/usb/typec/ucsi/Kconfig
> > > +++ b/drivers/usb/typec/ucsi/Kconfig
> > > @@ -69,4 +69,13 @@ config UCSI_PMIC_GLINK
> > >         To compile the driver as a module, choose M here: the module =
will be
> > >         called ucsi_glink.
> > >
> > > +config UCSI_LENOVO_YOGA_C630
> > > +     tristate "UCSI Interface Driver for Lenovo Yoga C630"
> > > +     depends on EC_LENOVO_YOGA_C630
> > > +     help
> > > +       This driver enables UCSI support on the Lenovo Yoga C630 lapt=
op.
> > > +
> > > +       To compile the driver as a module, choose M here: the module =
will be
> > > +       called ucsi_yoga_c630.
> > > +
> > >  endif
> > > diff --git a/drivers/usb/typec/ucsi/Makefile b/drivers/usb/typec/ucsi=
/Makefile
> > > index b4679f94696b..aed41d23887b 100644
> > > --- a/drivers/usb/typec/ucsi/Makefile
> > > +++ b/drivers/usb/typec/ucsi/Makefile
> > > @@ -21,3 +21,4 @@ obj-$(CONFIG_UCSI_ACPI)                     +=3D uc=
si_acpi.o
> > >  obj-$(CONFIG_UCSI_CCG)                       +=3D ucsi_ccg.o
> > >  obj-$(CONFIG_UCSI_STM32G0)           +=3D ucsi_stm32g0.o
> > >  obj-$(CONFIG_UCSI_PMIC_GLINK)                +=3D ucsi_glink.o
> > > +obj-$(CONFIG_UCSI_LENOVO_YOGA_C630)  +=3D ucsi_yoga_c630.o
> > > diff --git a/drivers/usb/typec/ucsi/ucsi_yoga_c630.c b/drivers/usb/ty=
pec/ucsi/ucsi_yoga_c630.c
> > > new file mode 100644
> > > index 000000000000..ca1ab5c81b87
> > > --- /dev/null
> > > +++ b/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
> > > @@ -0,0 +1,189 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Copyright (c) 2022-2024, Linaro Ltd
> > > + * Authors:
> > > + *    Bjorn Andersson
> > > + *    Dmitry Baryshkov
> > > + */
> > > +#include <linux/auxiliary_bus.h>
> > > +#include <linux/module.h>
> > > +#include <linux/platform_data/lenovo-yoga-c630.h>
> > > +
> > > +#include "ucsi.h"
> > > +
> > > +struct yoga_c630_ucsi {
> > > +     struct yoga_c630_ec *ec;
> > > +     struct ucsi *ucsi;
> > > +     struct notifier_block nb;
> > > +     struct completion complete;
> >
> > Add includes for what you used here.
> >
> > > +     unsigned long flags;
> > > +#define UCSI_C630_COMMAND_PENDING    0
> > > +#define UCSI_C630_ACK_PENDING                1
> > > +     u16 version;
> > > +};
> > > +
> > > +static  int yoga_c630_ucsi_read(struct ucsi *ucsi, unsigned int offs=
et,
> >
> > extra space
> >
> > > +                             void *val, size_t val_len)
> > > +{
> > > +     struct yoga_c630_ucsi *uec =3D ucsi_get_drvdata(ucsi);
> >
> > Missing include for ucsi_get_drvdata
>=20
> I'll review my includes, but this comment and the comment for
> ucsi_operations are clearly wrong. There is a corresponding include.

Ah, sorry about that. I completely missed there was that local include.

--=20
 i.
--8323328-268320193-1716996253=:1108--

