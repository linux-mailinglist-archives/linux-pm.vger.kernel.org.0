Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 391EA13779D
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2020 21:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgAJUAt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jan 2020 15:00:49 -0500
Received: from [167.172.186.51] ([167.172.186.51]:40708 "EHLO shell.v3.sk"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727650AbgAJUAt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 10 Jan 2020 15:00:49 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 80194DFB44;
        Fri, 10 Jan 2020 20:00:53 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id R-LYu2JMYi6f; Fri, 10 Jan 2020 20:00:52 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id B47D2DFDCA;
        Fri, 10 Jan 2020 20:00:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id C0kBNO04okiY; Fri, 10 Jan 2020 20:00:52 +0000 (UTC)
Received: from nedofet.lan (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 28E4DDFB44;
        Fri, 10 Jan 2020 20:00:52 +0000 (UTC)
Message-ID: <1bbf1ea76949f6ef4e856ed799f75d03bf20f293.camel@v3.sk>
Subject: Re: [PATCH] power: supply: olpc_battery: fix the power supply name
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Date:   Fri, 10 Jan 2020 21:00:43 +0100
In-Reply-To: <CAHp75VcYoWqvgLv-PmgxqhrHmYOH5=Nru6Msj3rryT=jL+y9xw@mail.gmail.com>
References: <20191221071751.269025-1-lkundrak@v3.sk>
         <CAHp75VcYoWqvgLv-PmgxqhrHmYOH5=Nru6Msj3rryT=jL+y9xw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2020-01-09 at 17:09 +0200, Andy Shevchenko wrote:
> On Sat, Dec 21, 2019 at 9:18 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
> > The framework is unhappy about them, because it uses the names in sysfs
> > attributes:
> > 
> >   power_supply olpc-ac: hwmon: 'olpc-ac' is not a valid name attribute, please fix
> >   power_supply olpc-battery: hwmon: 'olpc-battery' is not a valid name attribute, please fix
> 
> I'm wondering if it's an ABI change and how user space is supposed to
> cope with it.

It changes the sysfs path. It is rather unlikely that udisks or
anything else userspace cares.

If it does, then I guess the warning that suggests that it's a bug that
should be fixed should be removed instead.
> 
> > See also commit 648cd48c9e56 ("hwmon: Do not accept invalid name
> > attributes") and commit 74d3b6419772 ("hwmon: Relax name attribute
> > validation for new APIs").
> > 
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > ---
> >  arch/x86/platform/olpc/olpc-xo1-sci.c  | 4 ++--
> >  arch/x86/platform/olpc/olpc-xo15-sci.c | 4 ++--
> >  drivers/platform/olpc/olpc-xo175-ec.c  | 4 ++--
> >  drivers/power/supply/olpc_battery.c    | 4 ++--
> >  4 files changed, 8 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/x86/platform/olpc/olpc-xo1-sci.c b/arch/x86/platform/olpc/olpc-xo1-sci.c
> > index 99a28ce2244c7..09bd195cc9012 100644
> > --- a/arch/x86/platform/olpc/olpc-xo1-sci.c
> > +++ b/arch/x86/platform/olpc/olpc-xo1-sci.c
> > @@ -53,7 +53,7 @@ static const char * const lid_wake_mode_names[] = {
> > 
> >  static void battery_status_changed(void)
> >  {
> > -       struct power_supply *psy = power_supply_get_by_name("olpc-battery");
> > +       struct power_supply *psy = power_supply_get_by_name("olpc_battery");
> > 
> >         if (psy) {
> >                 power_supply_changed(psy);
> > @@ -63,7 +63,7 @@ static void battery_status_changed(void)
> > 
> >  static void ac_status_changed(void)
> >  {
> > -       struct power_supply *psy = power_supply_get_by_name("olpc-ac");
> > +       struct power_supply *psy = power_supply_get_by_name("olpc_ac");
> > 
> >         if (psy) {
> >                 power_supply_changed(psy);
> > diff --git a/arch/x86/platform/olpc/olpc-xo15-sci.c b/arch/x86/platform/olpc/olpc-xo15-sci.c
> > index 6d193bb36021b..7bc1ea6a47974 100644
> > --- a/arch/x86/platform/olpc/olpc-xo15-sci.c
> > +++ b/arch/x86/platform/olpc/olpc-xo15-sci.c
> > @@ -75,7 +75,7 @@ static struct kobj_attribute lid_wake_on_close_attr =
> > 
> >  static void battery_status_changed(void)
> >  {
> > -       struct power_supply *psy = power_supply_get_by_name("olpc-battery");
> > +       struct power_supply *psy = power_supply_get_by_name("olpc_battery");
> > 
> >         if (psy) {
> >                 power_supply_changed(psy);
> > @@ -85,7 +85,7 @@ static void battery_status_changed(void)
> > 
> >  static void ac_status_changed(void)
> >  {
> > -       struct power_supply *psy = power_supply_get_by_name("olpc-ac");
> > +       struct power_supply *psy = power_supply_get_by_name("olpc_ac");
> > 
> >         if (psy) {
> >                 power_supply_changed(psy);
> > diff --git a/drivers/platform/olpc/olpc-xo175-ec.c b/drivers/platform/olpc/olpc-xo175-ec.c
> > index 83ed1fbf73cfd..5e1d14e35f20b 100644
> > --- a/drivers/platform/olpc/olpc-xo175-ec.c
> > +++ b/drivers/platform/olpc/olpc-xo175-ec.c
> > @@ -410,7 +410,7 @@ static void olpc_xo175_ec_complete(void *arg)
> >                 dev_dbg(dev, "got event %.2x\n", byte);
> >                 switch (byte) {
> >                 case EVENT_AC_CHANGE:
> > -                       psy = power_supply_get_by_name("olpc-ac");
> > +                       psy = power_supply_get_by_name("olpc_ac");
> >                         if (psy) {
> >                                 power_supply_changed(psy);
> >                                 power_supply_put(psy);
> > @@ -420,7 +420,7 @@ static void olpc_xo175_ec_complete(void *arg)
> >                 case EVENT_BATTERY_CRITICAL:
> >                 case EVENT_BATTERY_SOC_CHANGE:
> >                 case EVENT_BATTERY_ERROR:
> > -                       psy = power_supply_get_by_name("olpc-battery");
> > +                       psy = power_supply_get_by_name("olpc_battery");
> >                         if (psy) {
> >                                 power_supply_changed(psy);
> >                                 power_supply_put(psy);
> > diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/olpc_battery.c
> > index ad0e9e0edb3f8..e0476ec06601d 100644
> > --- a/drivers/power/supply/olpc_battery.c
> > +++ b/drivers/power/supply/olpc_battery.c
> > @@ -88,7 +88,7 @@ static enum power_supply_property olpc_ac_props[] = {
> >  };
> > 
> >  static const struct power_supply_desc olpc_ac_desc = {
> > -       .name = "olpc-ac",
> > +       .name = "olpc_ac",
> >         .type = POWER_SUPPLY_TYPE_MAINS,
> >         .properties = olpc_ac_props,
> >         .num_properties = ARRAY_SIZE(olpc_ac_props),
> > @@ -605,7 +605,7 @@ static const struct attribute_group *olpc_bat_sysfs_groups[] = {
> >   *********************************************************************/
> > 
> >  static struct power_supply_desc olpc_bat_desc = {
> > -       .name = "olpc-battery",
> > +       .name = "olpc_battery",
> >         .get_property = olpc_bat_get_property,
> >         .use_for_apm = 1,
> >  };
> > --
> > 2.24.1
> > 
> 
> 

