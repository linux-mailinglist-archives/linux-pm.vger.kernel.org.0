Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59DF91B2BB9
	for <lists+linux-pm@lfdr.de>; Tue, 21 Apr 2020 17:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgDUP4U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Apr 2020 11:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726378AbgDUP4T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Apr 2020 11:56:19 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DF0C061A10
        for <linux-pm@vger.kernel.org>; Tue, 21 Apr 2020 08:56:19 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id e17so7583186ybq.0
        for <linux-pm@vger.kernel.org>; Tue, 21 Apr 2020 08:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=74DTtnYPeeEftI+DJz90+b857+M80IqiySHJZYpCKkE=;
        b=Ji5qhxy2FouOvLD2CFt074w2szmXScutjMXqgXYXykhjIC6PquB0ml0HhM2h4tg3IU
         mtbq00ZIIY95uzsLAgfAyuxslA4Wu+RWS443qAX4m1loUdvDV5rjEbIgYFYo1hwTKeNf
         wKgZpG/HCgMZu7tEYY6OFQ1frrLhBa+x7jL+ogBkZ9bEekWG0DwnncLqhx27pGIVNItn
         1Wmb+nTGi2C/OfEaYZqxvpByX9VKf2y5FRmEwIcAT/vqeDms1PfD06rhFOGWK01TWxYN
         a/IN7RLASBEiOfKuFGN7gdwe4hjyPTDQEHr/o2USRWhn8OKFId1kYsOXEABgOpwrzChO
         Vfjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=74DTtnYPeeEftI+DJz90+b857+M80IqiySHJZYpCKkE=;
        b=sliMkIPBE+5XxpCi496b1hikEBwsyTnvNIbkaqk3g9SwzBRW0uapOEXyUhgmah2aL/
         ItDDo1BIZ4yRJeES4RvdjnmOmx8HtXg1CfcRIufu6EcY6hm9HNa3fBZcHMuPU/Rg28P7
         8r+9p2Yjs20nwH3gwMDunlg9VAuCDurRftwKkgnv6V6VPtrCywqZ+HqIvbIbaPRPOagh
         K31UBXdGUCKlSE72inGyIIQeOf5R+uXot7ImHFK4/9MyZv+w3g6tB3mYO+wpiWwvt0fx
         RmFnEqxm2WTc2iGUf7VaF0wgviJEBfzOUpAOpPH5wmV9eMQTRtQs+zwujCfGFk3IX+Ue
         MiPg==
X-Gm-Message-State: AGi0PuYDCztAUBPGpDrNxd5LTPUxZN51rHxJiXHTIjUDOWs+pMeo3tUx
        PFep/hG2ryOHfWb2nKzV3iI3KLYZT1utQ/FS5GPhVQ==
X-Google-Smtp-Source: APiQypLsdE4YMQfgsknD/ezEkbulhYz2MuiCQ6O7zf68qUp+WNAPs6T+pVpFuKWo1YX5EXPKCNRs8pOa9QfGa9KAGyI=
X-Received: by 2002:a25:bd4c:: with SMTP id p12mr29034435ybm.140.1587484577802;
 Tue, 21 Apr 2020 08:56:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200420163657.60650-1-mathewk@chromium.org> <20200420163657.60650-3-mathewk@chromium.org>
 <AM6PR10MB2263B60191A7240E3F6E0C7A80D50@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
 <20200421124112.GA618654@kuha.fi.intel.com>
In-Reply-To: <20200421124112.GA618654@kuha.fi.intel.com>
From:   Mat King <mathewk@google.com>
Date:   Tue, 21 Apr 2020 09:56:06 -0600
Message-ID: <CAL_quvQRJXoZ3MntB_G6c-y_DL2pnkN+_Vp0D2Ykq9sP++RnCA@mail.gmail.com>
Subject: Re: [PATCH v0 2/2] typec: Add Type-C charger
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Mathew King <mathewk@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 21, 2020 at 6:41 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Tue, Apr 21, 2020 at 08:44:38AM +0000, Adam Thomson wrote:
> > On 20 April 2020 17:37, Mathew King wrote:
> >
> > > Add an option to expose USB Type-C ports that can charge system
> > > batteries as a power_supply class. This implementation only exposes
> > > three properties of the power supply.
> > >
> > > POWER_SUPPLY_PROP_ONLINE - Set to true if the Type-C port is configured
> > >                            as a sink and is connected to a partner
> > > POWER_SUPPLY_PROP_STATUS - Set to CHARGING if a partner is connected and
> > >                            the port is a sink and set to NOT_CHARGING
> > >                            otherwise
> > > POWER_SUPPLY_PROP_USB_TYPE - When a partner is conneced set to TYPE_C,
> > >                              TYPE_PD, or TYPE_PD_DRP depending on the
> > >                              partner capibilities and set to
> > >                              TYPE_UNKNOWN otherwise
> > >
> > > This implementation can be expanded as the typec class is expaneded. In
> > > particular the STATUS property should show more than CHARGING and
> > > NOT_CHARGING. Also properties like VOLTAGE and CURRENT can be added
> > > when
> > > the typec class supports getting PDOs.
> >
> > Hmm, this functionally looks almost exactly like code already available in TCPM,
> > except a much smaller subset. This looks like it would duplicate that work so as
> > it stands doesn't feel sensible to me. It may be that the work in TCPM needs
> > refactoring, but I don't believe the two should coexist.
>
> I agree. We can't register a psy for every port and partner
> unconditionally like that.
>
> I do think that for the sake of uniformity it would make sense to have
> the Type-C subsystem supply API that the Type-C drivers can use for
> registering the psy instead of every Type-C driver doing that directly
> with the psy API. So this patch should first introduce that API
> without doing anything automatically.
>
> Once things settle down, we can consider taking care of the psy
> registration for the drivers as well.
>
> Ideally the psy(s) registered here would supply the same information
> and functionality as the psy registered in TCPM. Then a separate patch
> that follows (that is part of the series) could simply convert TCPM to
> use this new API for registering the psy.
>
> thanks,

Thank you for the feedback Adam and Heikki. I will work on improving
the port API so that the psy is not created unconditionally and I will
work on getting to parity with the TCPM psy so that it can be switched
to this new method.

>
> > >
> > > Signed-off-by: Mathew King <mathewk@chromium.org>
> > > ---
> > >  drivers/usb/typec/Kconfig   |  11 ++
> > >  drivers/usb/typec/Makefile  |   1 +
> > >  drivers/usb/typec/charger.c | 204
> > > ++++++++++++++++++++++++++++++++++++
> > >  drivers/usb/typec/charger.h |  33 ++++++
> > >  drivers/usb/typec/class.c   |  48 +++++++--
> > >  drivers/usb/typec/class.h   |   2 +
> > >  6 files changed, 290 insertions(+), 9 deletions(-)
> > >  create mode 100644 drivers/usb/typec/charger.c
> > >  create mode 100644 drivers/usb/typec/charger.h
> > >
> > > diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
> > > index b4f2aac7ae8a..1040c990cb7e 100644
> > > --- a/drivers/usb/typec/Kconfig
> > > +++ b/drivers/usb/typec/Kconfig
> > > @@ -46,6 +46,17 @@ menuconfig TYPEC
> > >
> > >  if TYPEC
> > >
> > > +config TYPEC_CHARGER
> > > +   bool "Type-C Power Supply support"
> > > +   depends on POWER_SUPPLY
> > > +   help
> > > +     Say Y here to enable Type-C charging ports to be exposed as a power
> > > +     supply class.
> > > +
> > > +     If you choose this option Type-C charger support will be built into
> > > +     the typec driver. This will expose all Type-C ports as a power_supply
> > > +     class.
> > > +
> > >  source "drivers/usb/typec/tcpm/Kconfig"
> > >
> > >  source "drivers/usb/typec/ucsi/Kconfig"
> > > diff --git a/drivers/usb/typec/Makefile b/drivers/usb/typec/Makefile
> > > index 7753a5c3cd46..6fc5424761a1 100644
> > > --- a/drivers/usb/typec/Makefile
> > > +++ b/drivers/usb/typec/Makefile
> > > @@ -1,6 +1,7 @@
> > >  # SPDX-License-Identifier: GPL-2.0
> > >  obj-$(CONFIG_TYPEC)                += typec.o
> > >  typec-y                            := class.o mux.o bus.o
> > > +typec-$(CONFIG_TYPEC_CHARGER)      += charger.o
> > >  obj-$(CONFIG_TYPEC)                += altmodes/
> > >  obj-$(CONFIG_TYPEC_TCPM)   += tcpm/
> > >  obj-$(CONFIG_TYPEC_UCSI)   += ucsi/
> > > diff --git a/drivers/usb/typec/charger.c b/drivers/usb/typec/charger.c
> > > new file mode 100644
> > > index 000000000000..07c3cd065be8
> > > --- /dev/null
> > > +++ b/drivers/usb/typec/charger.c
> > > @@ -0,0 +1,204 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * USB Type-C Charger Class
> > > + *
> > > + * Copyright (C) 2020, Google LLC
> > > + * Author: Mathew King <mathewk@google.com>
> > > + */
> > > +
> > > +#include <linux/slab.h>
> > > +
> > > +#include "charger.h"
> > > +#include "class.h"
> > > +
> > > +static enum power_supply_property typec_charger_props[] = {
> > > +   POWER_SUPPLY_PROP_ONLINE,
> > > +   POWER_SUPPLY_PROP_STATUS,
> > > +   POWER_SUPPLY_PROP_USB_TYPE
> > > +};
> > > +
> > > +static enum power_supply_usb_type typec_charger_usb_types[] = {
> > > +   POWER_SUPPLY_USB_TYPE_UNKNOWN,
> > > +   POWER_SUPPLY_USB_TYPE_C,
> > > +   POWER_SUPPLY_USB_TYPE_PD,
> > > +   POWER_SUPPLY_USB_TYPE_PD_DRP,
> > > +};
> > > +
> > > +static int typec_charger_get_prop(struct power_supply *psy,
> > > +                             enum power_supply_property psp,
> > > +                             union power_supply_propval *val)
> > > +{
> > > +   struct typec_charger *charger = power_supply_get_drvdata(psy);
> > > +
> > > +   switch (psp) {
> > > +   case POWER_SUPPLY_PROP_ONLINE:
> > > +           val->intval = charger->psy_online;
> > > +           break;
> > > +   case POWER_SUPPLY_PROP_STATUS:
> > > +           val->intval = charger->psy_status;
> > > +           break;
> > > +   case POWER_SUPPLY_PROP_USB_TYPE:
> > > +           val->intval = charger->psy_usb_type;
> > > +           break;
> > > +   default:
> > > +           return -EINVAL;
> > > +   }
> > > +
> > > +   return 0;
> > > +}
> > > +
> > > +static int typec_charger_set_prop(struct power_supply *psy,
> > > +                             enum power_supply_property psp,
> > > +                             const union power_supply_propval *val)
> > > +{
> > > +   return -EINVAL;
> > > +}
> > > +
> > > +static int typec_charger_is_writeable(struct power_supply *psy,
> > > +                                 enum power_supply_property psp)
> > > +{
> > > +   return 0;
> > > +}
> > > +
> > > +/**
> > > + * typec_charger_changed - Notify of a Type-C charger change
> > > + * @charger: Type-C charger that changed
> > > + *
> > > + * Notifies the Type-C charger that one or more of its attributes may have
> > > + * changed.
> > > + */
> > > +void typec_charger_changed(struct typec_charger *charger)
> > > +{
> > > +   int last_psy_status, last_psy_usb_type, last_psy_online;
> > > +
> > > +   last_psy_online = charger->psy_online;
> > > +   last_psy_status = charger->psy_status;
> > > +   last_psy_usb_type = charger->psy_usb_type;
> > > +
> > > +   if (!charger->partner) {
> > > +           charger->psy_usb_type =
> > > POWER_SUPPLY_USB_TYPE_UNKNOWN;
> > > +           charger->psy_online = 0;
> > > +           charger->psy_status =
> > > POWER_SUPPLY_STATUS_NOT_CHARGING;
> > > +           goto out_notify;
> > > +   }
> > > +
> > > +   if (charger->port->pwr_role == TYPEC_SOURCE) {
> > > +           charger->psy_online = 0;
> > > +           charger->psy_status =
> > > POWER_SUPPLY_STATUS_NOT_CHARGING;
> > > +           if (charger->partner->usb_pd)
> > > +                   charger->psy_usb_type =
> > > POWER_SUPPLY_USB_TYPE_PD_DRP;
> > > +           else
> > > +                   charger->psy_usb_type =
> > > POWER_SUPPLY_USB_TYPE_UNKNOWN;
> > > +
> > > +           goto out_notify;
> > > +   }
> > > +
> > > +   charger->psy_online = 1;
> > > +   charger->psy_status = POWER_SUPPLY_STATUS_CHARGING;
> > > +
> > > +   if (charger->partner->usb_pd)
> > > +           charger->psy_usb_type = POWER_SUPPLY_USB_TYPE_PD;
> > > +   else
> > > +           charger->psy_usb_type = POWER_SUPPLY_USB_TYPE_C;
> > > +
> > > +out_notify:
> > > +   if (last_psy_usb_type != charger->psy_usb_type ||
> > > +       last_psy_status != charger->psy_status ||
> > > +       last_psy_online != charger->psy_online)
> > > +           power_supply_changed(charger->psy);
> > > +}
> > > +EXPORT_SYMBOL_GPL(typec_charger_changed);
> > > +
> > > +/**
> > > + * typec_register_charger - Register a USB Type-C Charger
> > > + * @port: Type-C port to register as a charger
> > > + *
> > > + * Registers a Type-C port as a charger.
> > > + *
> > > + * Returns handle to the charger on success or ERR_PTR on failure.
> > > + */
> > > +struct typec_charger *typec_register_charger(struct typec_port *port)
> > > +{
> > > +   struct power_supply_config psy_cfg = {};
> > > +   struct typec_charger *charger;
> > > +   struct power_supply *psy;
> > > +
> > > +   charger = kzalloc(sizeof(struct typec_charger), GFP_KERNEL);
> > > +   if (!port)
> > > +           return ERR_PTR(-ENOMEM);
> > > +
> > > +   charger->port = port;
> > > +   sprintf(charger->name, TYPEC_CHARGER_DIR_NAME, port->id);
> > > +   charger->psy_usb_type = POWER_SUPPLY_USB_TYPE_UNKNOWN;
> > > +   charger->psy_online = 0;
> > > +   charger->psy_status = POWER_SUPPLY_STATUS_NOT_CHARGING;
> > > +
> > > +   charger->psy_desc.name = charger->name;
> > > +   charger->psy_desc.type = POWER_SUPPLY_TYPE_USB;
> > > +   charger->psy_desc.get_property = typec_charger_get_prop;
> > > +   charger->psy_desc.set_property = typec_charger_set_prop;
> > > +   charger->psy_desc.property_is_writeable =
> > > +           typec_charger_is_writeable;
> > > +   charger->psy_desc.properties = typec_charger_props;
> > > +   charger->psy_desc.num_properties =
> > > +                           ARRAY_SIZE(typec_charger_props);
> > > +   charger->psy_desc.usb_types = typec_charger_usb_types;
> > > +   charger->psy_desc.num_usb_types =
> > > +                   ARRAY_SIZE(typec_charger_usb_types);
> > > +   psy_cfg.drv_data = charger;
> > > +
> > > +   psy = devm_power_supply_register_no_ws(&port->dev, &charger-
> > > >psy_desc,
> > > +                                          &psy_cfg);
> > > +   if (IS_ERR(psy)) {
> > > +           dev_err(&port->dev, "Failed to register Type-C power
> > > supply\n");
> > > +           return ERR_CAST(psy);
> > > +   }
> > > +   charger->psy = psy;
> > > +
> > > +   return charger;
> > > +}
> > > +EXPORT_SYMBOL_GPL(typec_register_charger);
> > > +
> > > +/**
> > > + * typec_unregister_charger - Unregister a USB Type-C Charger
> > > + * @charger: The charger to unregister
> > > + *
> > > + * Unregisters a charger created with typec_register_charger().
> > > + */
> > > +void typec_unregister_charger(struct typec_charger *charger)
> > > +{
> > > +   if (!IS_ERR_OR_NULL(charger))
> > > +           kfree(charger);
> > > +}
> > > +EXPORT_SYMBOL_GPL(typec_unregister_charger);
> > > +
> > > +/**
> > > + * typec_charger_register_partner - Register a partner with a USB Type-C
> > > Charger
> > > + * @charger: The charger to add the partner too
> > > + * @partner: The partner to add
> > > + *
> > > + * Add a partner to a Type-C charger to indicate that the partner is connected
> > > + * and may be charging.
> > > + */
> > > +void typec_charger_register_partner(struct typec_charger *charger,
> > > +                               struct typec_partner *partner)
> > > +{
> > > +   charger->partner = partner;
> > > +   typec_charger_changed(charger);
> > > +}
> > > +EXPORT_SYMBOL_GPL(typec_charger_register_partner);
> > > +
> > > +/**
> > > + * typec_charger_unregister_partner - Unregister a USB Type-C Charger partner
> > > + * @charger: The charger to remove the partner from
> > > + *
> > > + * Remove partner added with typec_charger_register_partner().
> > > + */
> > > +void typec_charger_unregister_partner(struct typec_charger *charger)
> > > +{
> > > +   if (!IS_ERR_OR_NULL(charger))
> > > +           charger->partner = NULL;
> > > +
> > > +   typec_charger_changed(charger);
> > > +}
> > > +EXPORT_SYMBOL_GPL(typec_charger_unregister_partner);
> > > diff --git a/drivers/usb/typec/charger.h b/drivers/usb/typec/charger.h
> > > new file mode 100644
> > > index 000000000000..32cdaa7c1a83
> > > --- /dev/null
> > > +++ b/drivers/usb/typec/charger.h
> > > @@ -0,0 +1,33 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +
> > > +#ifndef __USB_TYPEC_CHARGER_H__
> > > +#define __USB_TYPEC_CHARGER_H__
> > > +
> > > +#include <linux/power_supply.h>
> > > +#include <linux/usb/typec.h>
> > > +
> > > +#include "class.h"
> > > +
> > > +#define TYPEC_CHARGER_DIR_NAME
> > >     "TYPEC_CHARGER%d"
> > > +#define TYPEC_CHARGER_DIR_NAME_LENGTH
> > >     sizeof(TYPEC_CHARGER_DIR_NAME)
> > > +
> > > +struct typec_charger {
> > > +   struct typec_port *port;
> > > +   struct typec_partner *partner;
> > > +   char name[TYPEC_CHARGER_DIR_NAME_LENGTH];
> > > +   struct power_supply *psy;
> > > +   struct power_supply_desc psy_desc;
> > > +   int psy_usb_type;
> > > +   int psy_online;
> > > +   int psy_status;
> > > +};
> > > +
> > > +struct typec_charger *typec_register_charger(struct typec_port *port);
> > > +void typec_unregister_charger(struct typec_charger *charger);
> > > +
> > > +void typec_charger_register_partner(struct typec_charger *charger,
> > > +                               struct typec_partner *partner);
> > > +void typec_charger_unregister_partner(struct typec_charger *charger);
> > > +void typec_charger_changed(struct typec_charger *charger);
> > > +
> > > +#endif /* __USB_TYPEC_CHARGER_H__ */
> > > diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> > > index 9a1fdce137b9..1542d3af342c 100644
> > > --- a/drivers/usb/typec/class.c
> > > +++ b/drivers/usb/typec/class.c
> > > @@ -13,6 +13,7 @@
> > >  #include <linux/slab.h>
> > >
> > >  #include "bus.h"
> > > +#include "charger.h"
> > >  #include "class.h"
> > >
> > >  static DEFINE_IDA(typec_index_ida);
> > > @@ -489,6 +490,12 @@ static void typec_partner_release(struct device *dev)
> > >  {
> > >     struct typec_partner *partner = to_typec_partner(dev);
> > >
> > > +   if (IS_ENABLED(CONFIG_TYPEC_CHARGER)) {
> > > +           struct typec_port *port = to_typec_port(dev->parent);
> > > +
> > > +           typec_charger_unregister_partner(port->charger);
> > > +   }
> > > +
> > >     ida_destroy(&partner->mode_ids);
> > >     kfree(partner);
> > >  }
> > > @@ -580,6 +587,10 @@ struct typec_partner *typec_register_partner(struct
> > > typec_port *port,
> > >             return ERR_PTR(ret);
> > >     }
> > >
> > > +   if (IS_ENABLED(CONFIG_TYPEC_CHARGER) && port->charger) {
> > > +           typec_charger_register_partner(port->charger, partner);
> > > +   }
> > > +
> > >     return partner;
> > >  }
> > >  EXPORT_SYMBOL_GPL(typec_register_partner);
> > > @@ -1283,6 +1294,9 @@ static void typec_release(struct device *dev)
> > >  {
> > >     struct typec_port *port = to_typec_port(dev);
> > >
> > > +   if (IS_ENABLED(CONFIG_TYPEC_CHARGER))
> > > +           typec_unregister_charger(port->charger);
> > > +
> > >     ida_simple_remove(&typec_index_ida, port->id);
> > >     ida_destroy(&port->mode_ids);
> > >     typec_switch_put(port->sw);
> > > @@ -1564,7 +1578,8 @@ struct typec_port *typec_register_port(struct device
> > > *parent,
> > >     id = ida_simple_get(&typec_index_ida, 0, 0, GFP_KERNEL);
> > >     if (id < 0) {
> > >             kfree(port);
> > > -           return ERR_PTR(id);
> > > +           ret = id;
> > > +           goto err_return;
> > >     }
> > >
> > >     switch (cap->type) {
> > > @@ -1617,32 +1632,47 @@ struct typec_port *typec_register_port(struct device
> > > *parent,
> > >
> > >     port->cap = kmemdup(cap, sizeof(*cap), GFP_KERNEL);
> > >     if (!port->cap) {
> > > -           put_device(&port->dev);
> > > -           return ERR_PTR(-ENOMEM);
> > > +           ret = -ENOMEM;
> > > +           goto err_put_device;
> > >     }
> > >
> > >     port->sw = typec_switch_get(&port->dev);
> > >     if (IS_ERR(port->sw)) {
> > >             ret = PTR_ERR(port->sw);
> > > -           put_device(&port->dev);
> > > -           return ERR_PTR(ret);
> > > +           goto err_put_device;
> > >     }
> > >
> > >     port->mux = typec_mux_get(&port->dev, NULL);
> > >     if (IS_ERR(port->mux)) {
> > >             ret = PTR_ERR(port->mux);
> > > -           put_device(&port->dev);
> > > -           return ERR_PTR(ret);
> > > +           goto err_put_device;
> > >     }
> > >
> > >     ret = device_add(&port->dev);
> > >     if (ret) {
> > >             dev_err(parent, "failed to register port (%d)\n", ret);
> > > -           put_device(&port->dev);
> > > -           return ERR_PTR(ret);
> > > +           goto err_put_device;
> > > +   }
> > > +
> > > +   if (IS_ENABLED(CONFIG_TYPEC_CHARGER)) {
> > > +           port->charger = typec_register_charger(port);
> > > +
> > > +           if (IS_ERR(port->charger)) {
> > > +                   ret = PTR_ERR(port->charger);
> > > +                   goto err_device_del;
> > > +           }
> > >     }
> > >
> > >     return port;
> > > +
> > > +err_device_del:
> > > +   device_del(&port->dev);
> > > +
> > > +err_put_device:
> > > +   put_device(&port->dev);
> > > +
> > > +err_return:
> > > +   return ERR_PTR(ret);
> > >  }
> > >  EXPORT_SYMBOL_GPL(typec_register_port);
> > >
> > > diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
> > > index ec933dfe1323..0ff0a590d316 100644
> > > --- a/drivers/usb/typec/class.h
> > > +++ b/drivers/usb/typec/class.h
> > > @@ -41,6 +41,8 @@ struct typec_port {
> > >     struct typec_switch             *sw;
> > >     struct typec_mux                *mux;
> > >
> > > +   struct typec_charger            *charger;
> > > +
> > >     const struct typec_capability   *cap;
> > >     const struct typec_operations   *ops;
> > >  };
> > > --
> > > 2.26.1.301.g55bc3eb7cb9-goog
>
> --
> heikki
