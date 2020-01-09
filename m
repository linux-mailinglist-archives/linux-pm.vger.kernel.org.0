Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFCD135C53
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2020 16:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbgAIPKH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jan 2020 10:10:07 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34736 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729483AbgAIPKH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jan 2020 10:10:07 -0500
Received: by mail-pl1-f194.google.com with SMTP id x17so2691431pln.1;
        Thu, 09 Jan 2020 07:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1DdEpgV3qSTUavFzlgz+OfLM8pMDHuE+us22+FmCcxA=;
        b=AaSXI6prgQa5mOunsrwbxtu/8XiUkd6z17wEwhka38z+UxSftRqeY5dWFJYUmiAkhr
         q5n704lrCTYwTx5SMsA9okpdE4eHneDbPzCwy6tHGxKpw0+dMXKO4XWI0DLGIfDre9el
         z2SBGi/394Z8/2WFduIjqWn9lxkC+XLiRjhcLUhcK4TZg+6H1gmg3jWjw4E3jgdMD6tp
         BFieUZHHq2BQ+xTbAwUCtBSy8gzDlzp0Jce+8Ro8I2fc79gBclaKLIuHZoVhLrR5jgV/
         9JtTBM/chAVC6sh4ngcmTGWIQtG2IsFKP6mi7KskRnA72Pua4zeda2qT4ryy1Howykce
         iW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1DdEpgV3qSTUavFzlgz+OfLM8pMDHuE+us22+FmCcxA=;
        b=JtlFylI1SCQwPkpdsPBXKy0QeNjohrMUvfsyDK2BQpBhn/5VtKK5EBb4d3ncWipKiq
         4Mf+q08/zGLcpublnxfrMH9hAozUToDDu6EQTn5HpAxXC82U+2v1smP57oFtyZ5oAlKc
         elKUYHPxIHobpHxSh8Gc/XZzHE4z+YhGkzdCXctKMBEp1I2jUSWZ9xgyP19xf3ycc+If
         jQkRLxG6CQqdLiivuUV8/pOpbn6DUGhOcKJSLSdLZyuCMoUUjahFwAPyk4CZvJ9E8yEo
         DiYKl5epV/4bTaUhAxKIZLYKK3UrvKi6FtYJfvDYRelqPkYd7jZ0u8fF1MwKzmohuIF9
         nbOA==
X-Gm-Message-State: APjAAAXSB2sTSEYpcNK/5/7iiuAa1W6Lv2eMqRmhKBScYLNWHpTq26Z0
        JekheOt7PeCgdVQHvquPi4O2AtElAISQg8nj/bg=
X-Google-Smtp-Source: APXvYqxW4/RLnKlf959Q6Ahn+JSRYHZfjihIXmV92wTSiJEu+KPYezvWYFBC44j20+G4RoCdssnDt+ehSt3D62Pt7wM=
X-Received: by 2002:a17:90a:b10b:: with SMTP id z11mr5945398pjq.132.1578582605791;
 Thu, 09 Jan 2020 07:10:05 -0800 (PST)
MIME-Version: 1.0
References: <20191221071751.269025-1-lkundrak@v3.sk>
In-Reply-To: <20191221071751.269025-1-lkundrak@v3.sk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 9 Jan 2020 17:09:57 +0200
Message-ID: <CAHp75VcYoWqvgLv-PmgxqhrHmYOH5=Nru6Msj3rryT=jL+y9xw@mail.gmail.com>
Subject: Re: [PATCH] power: supply: olpc_battery: fix the power supply name
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Dec 21, 2019 at 9:18 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> The framework is unhappy about them, because it uses the names in sysfs
> attributes:
>
>   power_supply olpc-ac: hwmon: 'olpc-ac' is not a valid name attribute, please fix
>   power_supply olpc-battery: hwmon: 'olpc-battery' is not a valid name attribute, please fix

I'm wondering if it's an ABI change and how user space is supposed to
cope with it.

>
> See also commit 648cd48c9e56 ("hwmon: Do not accept invalid name
> attributes") and commit 74d3b6419772 ("hwmon: Relax name attribute
> validation for new APIs").
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  arch/x86/platform/olpc/olpc-xo1-sci.c  | 4 ++--
>  arch/x86/platform/olpc/olpc-xo15-sci.c | 4 ++--
>  drivers/platform/olpc/olpc-xo175-ec.c  | 4 ++--
>  drivers/power/supply/olpc_battery.c    | 4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/platform/olpc/olpc-xo1-sci.c b/arch/x86/platform/olpc/olpc-xo1-sci.c
> index 99a28ce2244c7..09bd195cc9012 100644
> --- a/arch/x86/platform/olpc/olpc-xo1-sci.c
> +++ b/arch/x86/platform/olpc/olpc-xo1-sci.c
> @@ -53,7 +53,7 @@ static const char * const lid_wake_mode_names[] = {
>
>  static void battery_status_changed(void)
>  {
> -       struct power_supply *psy = power_supply_get_by_name("olpc-battery");
> +       struct power_supply *psy = power_supply_get_by_name("olpc_battery");
>
>         if (psy) {
>                 power_supply_changed(psy);
> @@ -63,7 +63,7 @@ static void battery_status_changed(void)
>
>  static void ac_status_changed(void)
>  {
> -       struct power_supply *psy = power_supply_get_by_name("olpc-ac");
> +       struct power_supply *psy = power_supply_get_by_name("olpc_ac");
>
>         if (psy) {
>                 power_supply_changed(psy);
> diff --git a/arch/x86/platform/olpc/olpc-xo15-sci.c b/arch/x86/platform/olpc/olpc-xo15-sci.c
> index 6d193bb36021b..7bc1ea6a47974 100644
> --- a/arch/x86/platform/olpc/olpc-xo15-sci.c
> +++ b/arch/x86/platform/olpc/olpc-xo15-sci.c
> @@ -75,7 +75,7 @@ static struct kobj_attribute lid_wake_on_close_attr =
>
>  static void battery_status_changed(void)
>  {
> -       struct power_supply *psy = power_supply_get_by_name("olpc-battery");
> +       struct power_supply *psy = power_supply_get_by_name("olpc_battery");
>
>         if (psy) {
>                 power_supply_changed(psy);
> @@ -85,7 +85,7 @@ static void battery_status_changed(void)
>
>  static void ac_status_changed(void)
>  {
> -       struct power_supply *psy = power_supply_get_by_name("olpc-ac");
> +       struct power_supply *psy = power_supply_get_by_name("olpc_ac");
>
>         if (psy) {
>                 power_supply_changed(psy);
> diff --git a/drivers/platform/olpc/olpc-xo175-ec.c b/drivers/platform/olpc/olpc-xo175-ec.c
> index 83ed1fbf73cfd..5e1d14e35f20b 100644
> --- a/drivers/platform/olpc/olpc-xo175-ec.c
> +++ b/drivers/platform/olpc/olpc-xo175-ec.c
> @@ -410,7 +410,7 @@ static void olpc_xo175_ec_complete(void *arg)
>                 dev_dbg(dev, "got event %.2x\n", byte);
>                 switch (byte) {
>                 case EVENT_AC_CHANGE:
> -                       psy = power_supply_get_by_name("olpc-ac");
> +                       psy = power_supply_get_by_name("olpc_ac");
>                         if (psy) {
>                                 power_supply_changed(psy);
>                                 power_supply_put(psy);
> @@ -420,7 +420,7 @@ static void olpc_xo175_ec_complete(void *arg)
>                 case EVENT_BATTERY_CRITICAL:
>                 case EVENT_BATTERY_SOC_CHANGE:
>                 case EVENT_BATTERY_ERROR:
> -                       psy = power_supply_get_by_name("olpc-battery");
> +                       psy = power_supply_get_by_name("olpc_battery");
>                         if (psy) {
>                                 power_supply_changed(psy);
>                                 power_supply_put(psy);
> diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/olpc_battery.c
> index ad0e9e0edb3f8..e0476ec06601d 100644
> --- a/drivers/power/supply/olpc_battery.c
> +++ b/drivers/power/supply/olpc_battery.c
> @@ -88,7 +88,7 @@ static enum power_supply_property olpc_ac_props[] = {
>  };
>
>  static const struct power_supply_desc olpc_ac_desc = {
> -       .name = "olpc-ac",
> +       .name = "olpc_ac",
>         .type = POWER_SUPPLY_TYPE_MAINS,
>         .properties = olpc_ac_props,
>         .num_properties = ARRAY_SIZE(olpc_ac_props),
> @@ -605,7 +605,7 @@ static const struct attribute_group *olpc_bat_sysfs_groups[] = {
>   *********************************************************************/
>
>  static struct power_supply_desc olpc_bat_desc = {
> -       .name = "olpc-battery",
> +       .name = "olpc_battery",
>         .get_property = olpc_bat_get_property,
>         .use_for_apm = 1,
>  };
> --
> 2.24.1
>


-- 
With Best Regards,
Andy Shevchenko
