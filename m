Return-Path: <linux-pm+bounces-24126-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE79A6369C
	for <lists+linux-pm@lfdr.de>; Sun, 16 Mar 2025 18:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31857188F6E4
	for <lists+linux-pm@lfdr.de>; Sun, 16 Mar 2025 17:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8714A1A5B9D;
	Sun, 16 Mar 2025 17:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="aUeQiB1C"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD2D39ACC;
	Sun, 16 Mar 2025 17:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742144630; cv=none; b=VvjszPDoMzbTYtAok/jMTwHIww0mNWQc6bdXQncaORAEPez8eNl7z5jskf8ahOg/XZtoLVhRGkNSyUy9u1dZQW/0xxNiLVIbvf5dFWXwnJB544QuB7mb0kkyFz949OOk/ol46//Kmv4tJcMv/pSe1pHEYrRMCo10QFlkUL5mYPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742144630; c=relaxed/simple;
	bh=JCOen0Yjc5kuRPMnNops9FUQayFyNuqmzNJgEPw1MLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W3brXY9YLNHiqAEaqeiTnxVBnRqlWdSS/lr/7ngAhWwO0PA0eIl+r4noM4ik9pocJEyxmhbzvhTm0U+xpPW5zy63kqFE9GMIRzxlICvKRJ5c+4l+d+55laAXX2keSMuefa0ZsC4glLq5Ge2Jh2k66BZNU00Finn4oGVz5f6JztI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=aUeQiB1C; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 2D7D52E096C5;
	Sun, 16 Mar 2025 19:03:45 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1742144626;
	bh=sjK/AJ290GlZDlkgrocRCDS9ISArx/Rj8lTyTCDoaGI=;
	h=Received:From:Subject:To;
	b=aUeQiB1Cf0HgT5Y+o6UHc9/V7rbL8CBzPti1vLvuVm54Dm04OiujeKvFAdBsmx0N+
	 2TWsamgcn0OjoHRAqTOULI2Eye8mP3xsTNiyn0WjnxcPM/FSloJR38ROdVnvPxQ3z/
	 Yjos6Ca/V1+FwQ5hflMA6k6oaz4ukPjkOvnNBNtQ=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.176) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f176.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f176.google.com with SMTP id
 38308e7fff4ca-30613802a59so40869061fa.0;
        Sun, 16 Mar 2025 10:03:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVe74/nu3C39nP6s7TzM7p4RQeHdwoedF5H7VK1mC9YCXRny5D7V1MH4NgT3qvlqHvraCBVxwU+GhpK5nRMRHpkFiJLOQ==@vger.kernel.org,
 AJvYcCXDW7JVogKDqEE1otaYdF2UXzkroa1hDGTdvInuVyuR52qCapCDDa0+/Nue0HblWxiRo00ttHg0IgM=@vger.kernel.org,
 AJvYcCXFpSQf5ksXkI8VOp2fnqw96hLlOx4d+jabbfLyL9pCMZj9xuw4X082QxiEfhiaGJTGGNjT4ks3pDt/2sk=@vger.kernel.org,
 AJvYcCXLkTmhrN9TcjUeyQ8TsHAqu3mdB9um7NP/SjII4hZYGD2MtLUi6sXbONghVKgStTyze2SaCrMxUbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiclaA/nMBAKWI8lYFnf5jPNeBIiwr9kZBhuEZTBi0ToSWfmIb
	/OQHWPpngKyuN/Ir0yfqO1rJ2JmxkWf+aoLWWm+G46kAkbxJgWLtwnDkJzVuqyI3AOcGRfwne09
	oeujnbMTS+Q8PPzwPsVl6gLWYfpc=
X-Google-Smtp-Source: 
 AGHT+IEQrS36+R1Z6waDCCkqZ3F0JC1xg5qDDC+IhufOMzf2Nqwfk+L31MbLJc/KuBqzVUSJoN8NoInwuaEzu1DXoP8=
X-Received: by 2002:a2e:bea2:0:b0:30c:7a7:e85a with SMTP id
 38308e7fff4ca-30c4a8769f1mr44483331fa.21.1742144624203; Sun, 16 Mar 2025
 10:03:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311165406.331046-1-lkml@antheas.dev>
 <20250311165406.331046-6-lkml@antheas.dev>
 <CAGwozwELmp7v_46wmo_bbORWMEeA-NWRjXeRML4Jd=p=huLNaw@mail.gmail.com>
 <0aec1406-00cd-44ee-959f-48b646d3dad3@roeck-us.net>
 <CAGwozwHEoTb4uC=aoSXV2AMFjpZ_7+pDbMS1c_zs_QGAzC_qdA@mail.gmail.com>
 <CAFqHKTmYE+TYT9kpJXXoG0eZ36kJqrAfwQ397_7ssaYYsgh9KA@mail.gmail.com>
In-Reply-To: 
 <CAFqHKTmYE+TYT9kpJXXoG0eZ36kJqrAfwQ397_7ssaYYsgh9KA@mail.gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sun, 16 Mar 2025 18:03:32 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwH5+5X1eBLnAT7G5Gd3mwptNvRF=U6sTggyT90Kdg2a1g@mail.gmail.com>
X-Gm-Features: AQ5f1Jo5LUTySlK9F6ulBP2WnbiGVV-tpL8LEeNIgrb2Hb3KUtOl9m4vjLUQlOc
Message-ID: 
 <CAGwozwH5+5X1eBLnAT7G5Gd3mwptNvRF=U6sTggyT90Kdg2a1g@mail.gmail.com>
Subject: Re: [PATCH v4 05/13] power: supply: add inhibit-charge-s0 to
 charge_behaviour
To: Derek John Clark <derekjohn.clark@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
	"open list:AMD PMF DRIVER" <platform-driver-x86@vger.kernel.org>,
 linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
	Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Joaquin Ignacio Aramendia <samsagax@gmail.com>,
 Kevin Greenberg <kdgreenberg234@protonmail.com>,
	Joshua Tam <csinaction@pm.me>, Parth Menon <parthasarathymenon@gmail.com>,
	Eileen <eileen@one-netbook.com>, Hans de Goede <hdegoede@redhat.com>,
	Armin Wolf <W_Armin@gmx.de>, ij@kernel.org,
	"Limonciello, Mario" <Mario.Limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <174214462569.8468.10420902998555077563@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Sun, 16 Mar 2025 at 17:50, Derek John Clark
<derekjohn.clark@gmail.com> wrote:
>
>
>
> On Sun, Mar 16, 2025, 09:47 Antheas Kapenekakis <lkml@antheas.dev> wrote:
>>
>> On Sun, 16 Mar 2025 at 14:56, Guenter Roeck <linux@roeck-us.net> wrote:
>> >
>> > On 3/16/25 04:40, Antheas Kapenekakis wrote:
>> > > On Tue, 11 Mar 2025 at 17:54, Antheas Kapenekakis <lkml@antheas.dev> wrote:
>> > >>
>> > >> OneXPlayer devices have a charge bypass feature
>> > >> that allows the user to select between it being
>> > >> active always or only when the device is on.
>> > >>
>> > >> Therefore, add attribute inhibit-charge-s0 to
>> > >> charge_behaviour to allow the user to select
>> > >> that bypass should only be on when the device is
>> > >> in the s0 state.
>> > >>
>> > >> Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
>> > >> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
>> > >> ---
>> > >>   Documentation/ABI/testing/sysfs-class-power | 11 ++++++-----
>> > >>   drivers/power/supply/power_supply_sysfs.c   |  1 +
>> > >>   drivers/power/supply/test_power.c           |  1 +
>> > >>   include/linux/power_supply.h                |  1 +
>> > >>   4 files changed, 9 insertions(+), 5 deletions(-)
>> > >>
>> > >> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
>> > >> index 2a5c1a09a28f..4a187ca11f92 100644
>> > >> --- a/Documentation/ABI/testing/sysfs-class-power
>> > >> +++ b/Documentation/ABI/testing/sysfs-class-power
>> > >> @@ -508,11 +508,12 @@ Description:
>> > >>                  Access: Read, Write
>> > >>
>> > >>                  Valid values:
>> > >> -                       ================ ====================================
>> > >> -                       auto:            Charge normally, respect thresholds
>> > >> -                       inhibit-charge:  Do not charge while AC is attached
>> > >> -                       force-discharge: Force discharge while AC is attached
>> > >> -                       ================ ====================================
>> > >> +                       ================== =====================================
>> > >> +                       auto:              Charge normally, respect thresholds
>> > >> +                       inhibit-charge:    Do not charge while AC is attached
>> > >> +                       inhibit-charge-s0: same as inhibit-charge but only in S0
>> > >> +                       force-discharge:   Force discharge while AC is attached
>> > >> +                       ================== =====================================
>> > >>
>> > >>   What:          /sys/class/power_supply/<supply_name>/technology
>> > >>   Date:          May 2007
>> > >> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
>> > >> index edb058c19c9c..1a98fc26ce96 100644
>> > >> --- a/drivers/power/supply/power_supply_sysfs.c
>> > >> +++ b/drivers/power/supply/power_supply_sysfs.c
>> > >> @@ -140,6 +140,7 @@ static const char * const POWER_SUPPLY_SCOPE_TEXT[] = {
>> > >>   static const char * const POWER_SUPPLY_CHARGE_BEHAVIOUR_TEXT[] = {
>> > >>          [POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO]            = "auto",
>> > >>          [POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE]  = "inhibit-charge",
>> > >> +       [POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_S0]       = "inhibit-charge-s0",
>> > >>          [POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE] = "force-discharge",
>> > >>   };
>> > >>
>> > >> diff --git a/drivers/power/supply/test_power.c b/drivers/power/supply/test_power.c
>> > >> index 2a975a110f48..4bc5ab84a9d6 100644
>> > >> --- a/drivers/power/supply/test_power.c
>> > >> +++ b/drivers/power/supply/test_power.c
>> > >> @@ -214,6 +214,7 @@ static const struct power_supply_desc test_power_desc[] = {
>> > >>                  .property_is_writeable = test_power_battery_property_is_writeable,
>> > >>                  .charge_behaviours = BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO)
>> > >>                                     | BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE)
>> > >> +                                  | BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_S0)
>> > >>                                     | BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE),
>> > >>          },
>> > >>          [TEST_USB] = {
>> > >> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
>> > >> index 6ed53b292162..b1ca5e148759 100644
>> > >> --- a/include/linux/power_supply.h
>> > >> +++ b/include/linux/power_supply.h
>> > >> @@ -212,6 +212,7 @@ enum power_supply_usb_type {
>> > >>   enum power_supply_charge_behaviour {
>> > >>          POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO = 0,
>> > >>          POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE,
>> > >> +       POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_S0,
>> > >>          POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE,
>> > >>   };
>> > >>
>> > >> --
>> > >> 2.48.1
>> > >>
>> > >
>> > > Hi Guenter,
>> > > I think I need an ack here, and then someone from platform-x86 to
>> > > triage the series.
>> > >
>> > > Do I need to cc anyone extra?
>> > >
>> >
>> > You need to cc the maintainers of affected subsystems. Copying the mailing
>> > list is insufficient.
>> >
>> > Guenter
>> >
>>
>> Can you tell me who to cc from platform-x86 and linux-pm?
>>
>> Is it Armin and Rafael?
>
>
> Hans, Ilpo, Armin, and Mario
>
> - Derek

Sure. Full series on [1].

Antheas

btw, your reply was non-text.

[1] https://lore.kernel.org/all/20250311165406.331046-1-lkml@antheas.dev/

