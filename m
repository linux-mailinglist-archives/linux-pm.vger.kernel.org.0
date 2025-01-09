Return-Path: <linux-pm+bounces-20158-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE8CA08028
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 19:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 932F8167F00
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 18:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B6719FA8D;
	Thu,  9 Jan 2025 18:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="caaF1k3h"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD4719D07A
	for <linux-pm@vger.kernel.org>; Thu,  9 Jan 2025 18:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736448616; cv=none; b=MnmKwRCZ5H5T9Z3gB8CPTihevk108xzArK+Rs6bxsF79pt9QP/HPSn4u/sRXhuErYmVrGS8CUoW7jxsBpu/zYY8wNtUP7KgqDtMYyd1Nf3/bgn5lKqQ+JXTZM0vdiQnunLoyhF0B3ljeWyp7zqAuPV2Cw1gXnaTIggdsca5Tbz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736448616; c=relaxed/simple;
	bh=uTe3MrIGtu5S+nv8/jZBwyWIIQ4cevLxZdYGQuVA7w0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nJpgOvZwXeXSY7SrOcPYy0N97J1A2z4uLSWpGh62UOY1EgMCIdneeG04wZjBO7rcvlOhMH4eyzlNH9V1aIxZObqnRokknlWDoFro209tvEXwJuOXQapHigL8mJpJxP2IYYY/UohPernK2ynkx+434/wmL2US9C7r6z0Or9jncJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=caaF1k3h; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-305f529a987so8875131fa.2
        for <linux-pm@vger.kernel.org>; Thu, 09 Jan 2025 10:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736448612; x=1737053412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rrTWzMSsP5ogv4o+s4jp3qUmrkJEH+yhMY3AaH9vQDc=;
        b=caaF1k3hqSiO538BloFKLzGnr2gwGP+84eKmemTSH22Qxrd0lYRq9gOah5DiITA3WZ
         Cy+8LWa00/9+rFS1CkV/7gbwe9lO0mZlgli9AnrDgeb1pwnGHy5skMYalLUkCETqYGG9
         vd+QnF/Tandail8n0oKDZ/27AKWxySZEhFfbkBkXneXDM1PtrdR/UILgx0//NKfyct8I
         QF6DlqUin3co8SNagSTMJxTI9OS5wRtWJMWres67ZHSv+bHQT0HoN8TN1+MRixVCygnm
         +jH5Injvp/dx+bETzx9ZH3RiVZzvh1STcke1Q4FEgFeN88EWc/UwWgBPwjr3MO6WhcKj
         D8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736448612; x=1737053412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rrTWzMSsP5ogv4o+s4jp3qUmrkJEH+yhMY3AaH9vQDc=;
        b=S78x+19B81eWPqDjnGNwqx8lSrJv6kUKsZWhHqd7bqx2cA0GIQxiE3+GELDf0ssS0q
         rluExZq2SOKlz40Zg75PxWS9OskaTZNXnPgAGVww0US6AFfz3A3g5qby4LUpRipeQNGr
         iECbE+5A0M9erIy84dUzlns41L+GLd+4DCSj62wEhSyDr0j8qIAN624O2CXU5fG695ns
         WpPYB1lzsK7E7m89HfB7HfRz0A0+ZQG0HuNUpnd6eFm8GcXUcSP102euFSt5xE05I8NN
         Dlt1upcXSpaBdI6e+CYuVs7UWbuikCaleMA+FdsE6TzbQ9UXKWi2pEijit/ArrurEgKg
         PGvw==
X-Forwarded-Encrypted: i=1; AJvYcCVVofid8q2GbPyRej9n4pfx3linXnzWWPEMUH7P7nlqlnyEe78aLVADdRIYpNS8fU1NlU6szkCSpA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhU6J+CyYnieWIBLxUAxfz/rmcyVfAzYKS9FraP02fxLlJp5YY
	W+CqcF1qwsfaTROzleaJ9C58qPOFAmgJ4KO7djzukUkjqnvIElAvcNxytnTsNC29luboLlLsxlH
	xQ0MGeaas02ALi5ka/IDqX9AMmHLxXm0CmtlRfA==
X-Gm-Gg: ASbGncvkOSX24slZ9m49QEL4SPWc6cbLfvfMI1sFwq6W3nU8rL/yzg+KJEFVFuXCe5Z
	f0DvB7DpO48y1lq4dNihN1nzeu2EiGLe0Qu64
X-Google-Smtp-Source: AGHT+IEf88sSRERpuW0MDTK/8Lqy7cihu2Iql/58JSvyy4x/+tgsMs/PFdxcT/7vCWJaRnWHtqHaS3Fi1s3MgFRt8jk=
X-Received: by 2002:a05:6512:1196:b0:53f:231e:6f92 with SMTP id
 2adb3069b0e04-542845491ffmr2709411e87.34.1736448612076; Thu, 09 Jan 2025
 10:50:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107113346.170612-1-hdegoede@redhat.com> <20250107113346.170612-2-hdegoede@redhat.com>
In-Reply-To: <20250107113346.170612-2-hdegoede@redhat.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 9 Jan 2025 19:50:01 +0100
X-Gm-Features: AbW1kvZHi72ZRpjuS8tflwTHrYGXrUi0FbmNPC5pjCOedZPyhj5KoK2bkrNbuks
Message-ID: <CACRpkdaStgNdQTivNb693wvzZ+3OXCeD7977JVcZqVhyv9FOgw@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] power: supply: Add adc-battery-helper
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hans,

thanks for your patch!

Overall I really like the looks of this.

Some high-level questions, and sorry for the verbiage I got
a bit carried away when refreshing my memories of this type of
work:

On Tue, Jan 7, 2025 at 12:34=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:

> +static int adc_battery_helper_get_capacity(struct adc_battery_helper *he=
lp)
> +{
> +       /*
> +        * OCV voltages in uV for 0-110% in 5% increments, the 100-110% i=
s
> +        * for LiPo HV (High-Voltage) bateries which can go up to 4.35V
> +        * instead of the usual 4.2V.
> +        */

This is a pretty bold claim, given how individual batteries are.

I challenge this and ask if this isn't really *one* *specific* battery
and not as general as it looks here.

> +       static const int ocv_capacity_tbl[23] =3D {
> +               3350000,
> +               3610000,
> +               3690000,
> +               3710000,
> +               3730000,
> +               3750000,
> +               3770000,
> +               3786667,
> +               3803333,
> +               3820000,
> +               3836667,
> +               3853333,
> +               3870000,
> +               3907500,
> +               3945000,
> +               3982500,
> +               4020000,
> +               4075000,
> +               4110000,
> +               4150000,
> +               4200000,
> +               4250000,
> +               4300000,
> +       };

Compare this to the ocv-to-capacity tables for a few batteries that exist
in drivers/power/supply/samsung-sdi-battery.c, i.e. any use of
struct power_supply_battery_ocv_table such as:

static const struct power_supply_battery_ocv_table
samsung_ocv_cap_eb485159lu[] =3D {
        { .ocv =3D 4330000, .capacity =3D 100},
        { .ocv =3D 4320000, .capacity =3D 99},
        { .ocv =3D 4283000, .capacity =3D 95},
(...)
        { .ocv =3D 3456000, .capacity =3D 2},
        { .ocv =3D 3381000, .capacity =3D 1},
        { .ocv =3D 3300000, .capacity =3D 0},
};

Apart from being upside-down, this is strikingly similar, just
slightly different
ocv vs capacity for each of the batteries in this file.

The struct power_supply_battery_ocv_table use linear interpolation
helpers in the core, see power_supply_ocv2cap_simple() in
power_supply_core.c.

Further it has been found (in the datasheet for Samsung batteries) that
the OCV table is varying with the temperature of the battery. For this
reason a two-dimensional look-up exists, power_supply_find_ocv2cap_table()
and the helper power_supply_batinfo_ocv2cap() that will look up
a proper ocv2cap for a certain temperature and then interpolate
in that table. In this case the capacity estimate is three-dimensional.
I bet this is actually true for your battery as well, if you have a datashe=
et.

> +       for (i =3D 1; i < ARRAY_SIZE(ocv_capacity_tbl); i++) {
> +               if (help->ocv_avg_uv > ocv_capacity_tbl[i])
> +                       continue;
> +
> +               ocv_diff =3D ocv_capacity_tbl[i] - help->ocv_avg_uv;
> +               ocv_step =3D ocv_capacity_tbl[i] - ocv_capacity_tbl[i - 1=
];
> +               /* scale 0-110% down to 0-100% for LiPo HV */
> +               if (help->psy->battery_info->constant_charge_voltage_max_=
uv >=3D 4300000)
> +                       return (i * 500 - ocv_diff * 500 / ocv_step) / 11=
0;
> +               else
> +                       return i * 5 - ocv_diff * 5 / ocv_step;
> +       }

This looks to *me* like someone taking a highly nonlinear problem and
trying to linearize it. LiPo batteries are not this linear.

I would rather expect a good old ocv-to-capacity table based on a
discharge diagram from a datasheet.

In any case, the above can certainly be converted into one, but I have
my doubts about the quality of that.

In any case I suggest passing in a struct power_supply_battery_ocv_table *
to this function instead and use the core interpolation.

> +static void adc_battery_helper_work(struct work_struct *work)
> +{
> +       struct adc_battery_helper *help =3D container_of(work, struct adc=
_battery_helper,
> +                                                      work.work);
> +       int i, curr_diff_ua, volt_diff_uv, res, ret, win_size;

Pls tag res with unit such as rs_mohm or (as suggested below)
res_uohm.

> +       struct device *dev =3D help->psy->dev.parent;
> +       int volt_uv, prev_volt_uv =3D help->volt_uv;
> +       int curr_ua, prev_curr_ua =3D help->curr_ua;
> +       bool prev_supplied =3D help->supplied;
> +       int prev_status =3D help->status;
> +
> +       guard(mutex)(&help->lock);

Guarded mutexes are nice!

> +       help->volt_uv =3D volt_uv;
> +       help->curr_ua =3D curr_ua;
> +
> +       help->ocv_uv[help->ocv_avg_index] =3D
> +               help->volt_uv - help->curr_ua * help->intern_res_avg_mohm=
 / 1000;
> +       dev_dbg(dev, "volt-now: %d, curr-now: %d, volt-ocv: %d\n",
> +               help->volt_uv, help->curr_ua, help->ocv_uv[help->ocv_avg_=
index]);
> +       help->ocv_avg_index =3D (help->ocv_avg_index + 1) % MOV_AVG_WINDO=
W;
> +       help->poll_count++;
> +
> +       help->ocv_avg_uv =3D 0;
> +       win_size =3D min(help->poll_count, MOV_AVG_WINDOW);
> +       for (i =3D 0; i < win_size; i++)
> +               help->ocv_avg_uv +=3D help->ocv_uv[i];
> +       help->ocv_avg_uv /=3D win_size;

This part of the algorithm needs comments to explain what is going on with
the moving average window here. It looks clever!

What I know for sure is that a battery's internal resistance also varies
with temperature so this isn't very good for all conditions, and this is
why we have the helper function power_supply_temp2resist_simple()
in the core to supply look-up interpolation tables also for this. But I
guess maybe you don't have either a temperature sensor or the
data for the temperature variation curves?

I'm pretty sure you must have a temperature sensor because it is
dangerous to make chargers without them, but whether you can
read it is another question, and whether you have a temp->ri table
is a third question so I understand there might be lacking
information here.

> +       help->supplied =3D power_supply_am_i_supplied(help->psy);
> +       help->status =3D adc_battery_helper_get_status(help);
> +       help->capacity =3D adc_battery_helper_get_capacity(help);
> +
> +       /*
> +        * Skip internal resistance calc on charger [un]plug and
> +        * when the battery is almost empty (voltage low).
> +        */
> +       if (help->supplied !=3D prev_supplied ||
> +           help->volt_uv < LOW_BAT_UV ||
> +           help->poll_count < 2)
> +               goto out;
> +
> +       /*
> +        * Assuming that the OCV voltage does not change significantly
> +        * between 2 polls, then we can calculate the internal resistance
> +        * on a significant current change by attributing all voltage
> +        * change between the 2 readings to the internal resistance.
> +        */

Interesting algorithm. It will however include any resistance in
series with the battery such as resistance in wires (negligible)
and pads, connectors and silicon circuitry (not negligible).

The algorithms I have seen carefully specify the internal
resistance vs temperature in a table and specify the
resistance in series with the battery separately. (OK the
latter is maybe a bit overzealous.)

> +       curr_diff_ua =3D abs(help->curr_ua - prev_curr_ua);
> +       if (curr_diff_ua < CURR_HYST_UA)
> +               goto out;
> +
> +       volt_diff_uv =3D abs(help->volt_uv - prev_volt_uv);
> +       res =3D volt_diff_uv * 1000 / curr_diff_ua;
> +
> +       if ((res < (help->intern_res_avg_mohm * 2 / 3)) ||
> +           (res > (help->intern_res_avg_mohm * 4 / 3))) {

I have found that micro-ohms are usually needed to get the
right precision so please consider this, mohm may be good
enough for this AD. But there is a famous paper about capacity
estimation pointing out that precise measurements of Ri
is critical for capacity estimation, and for that micro-ohms
should be encouraged IMO.

This is why factory internal resistance uses micro-ohms.

> +               dev_dbg(dev, "Ignoring outlier internal resistance %d mOh=
m\n", res);
> +               goto out;
> +       }

Ugh that looks hacky and random for a certain AD-converter
which is pretty unstable if things like this happens... oh well.
Don't know what to say about that. Maybe this is good?

Maybe there should be absurdity guards as well, such as
internal resistance being

> +       dev_dbg(dev, "Internal resistance %d mOhm\n", res);

Maybe we actually need a sysfs file for that?

> +       help->intern_res_mohm[help->intern_res_avg_index] =3D res;
> +       help->intern_res_avg_index =3D (help->intern_res_avg_index + 1) %=
 MOV_AVG_WINDOW;
> +       help->intern_res_poll_count++;
> +
> +       help->intern_res_avg_mohm =3D 0;
> +       win_size =3D min(help->intern_res_poll_count, MOV_AVG_WINDOW);
> +       for (i =3D 0; i < win_size; i++)
> +               help->intern_res_avg_mohm +=3D help->intern_res_mohm[i];
> +       help->intern_res_avg_mohm /=3D win_size;

If we want to do moving averages in general maybe we should
have a helper in power_supply_core.c for this?
Just a suggestion.

> +       if (!help->psy->battery_info ||
> +           help->psy->battery_info->factory_internal_resistance_uohm =3D=
=3D -EINVAL ||
> +           help->psy->battery_info->constant_charge_voltage_max_uv =3D=
=3D -EINVAL) {
> +               dev_err(dev, "error required properties are missing\n");
> +               return -ENODEV;
> +       }

As mentioned, I think you should pass in and use at least:

.ocv_temp[0] =3D 25, // What we use when we know nothing else...
.ocv_table[0] =3D foo_ocv_cap_table,
.ocv_table_size[0] =3D ARRAY_SIZE(foo_ocv_cap_table),

If for nothing else so for the fact that someone will want to use this
with a (proper) nonlinear table and you can test it easily by constructing
one for your battery.

> +       /* Use provided internal resistance as start point (in milli-ohm)=
 */
> +       help->intern_res_avg_mohm =3D
> +               help->psy->battery_info->factory_internal_resistance_uohm=
 / 1000;

.resist_table
.resist_table_size

would be better I think, but if you have no datasheet and no idea
how much resistance is connected in series with the battery...
well. Fair enough I guess.

Yours,
Linus Walleij

