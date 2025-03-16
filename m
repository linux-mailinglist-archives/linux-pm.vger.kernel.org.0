Return-Path: <linux-pm+bounces-24122-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A71BA63675
	for <lists+linux-pm@lfdr.de>; Sun, 16 Mar 2025 17:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D55F3AB226
	for <lists+linux-pm@lfdr.de>; Sun, 16 Mar 2025 16:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8DE1A3A94;
	Sun, 16 Mar 2025 16:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="QLVDr/bE"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DCC2C9D;
	Sun, 16 Mar 2025 16:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742143630; cv=none; b=LtgUxxrUbZDfva7KvAnxitNjVi/SDZlE1q0pWSOcPf8CrORpvirTC60NYzsDA5tcnHlU/y3n4ozGCEjv6JXiChm1gkSWYCtztGbnGAgl8vdpWZrJ3CRdcBdfMkbOMvqJerc05EAkGGT66d5JBCNvDcISaHucEZTUulL3f8EFSkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742143630; c=relaxed/simple;
	bh=XWnmuzI8s6aqix3POXzVr9oa2a29ncDA0uFUjwFl9V4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ujxmBgSakg5DIUAjPXU//4haH18/w2/y11zHE13DgwHyK2GKklnKx2vC5M4mo4LfCz7yv/v7F5ydLhW7lgUDTqHwsgbRa1fFC4xLra2XaUeioN4cjFffkcM8kwDk8AO0+VEnS3tpL+z+rr7WYjQieb6Z9jkOXfENQmwAv4ObL3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=QLVDr/bE; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id E24D42E09445;
	Sun, 16 Mar 2025 18:47:01 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1742143622;
	bh=zI0JEcspptG7CIE7h4QEiFoZhBVtH20+Wd0laIS8qPs=;
	h=Received:From:Subject:To;
	b=QLVDr/bERPIgMciP+HfdSoUxqMjynWT9fKFikkE9dpK4qbPg+f1/OQG0ur3RX4cuS
	 Fq2ps5JJml2Hi1jwQB0bMF2KgjbH9765iDl5jIV4WZvfMLH/WQ6ucerRROe/KGko1t
	 fPQsOi97maSNWRuKcdyDiA9QaFYXGS51dJmS/YgI=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.169) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f169.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f169.google.com with SMTP id
 38308e7fff4ca-3061513d353so44944751fa.2;
        Sun, 16 Mar 2025 09:47:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUB44jS1d9tWL4T/GH71TybvmfUbLlaz3xgpVfMTk1gPpqKzEMV7DrQH4/McAirNPLWuo6pQFdSwpk=@vger.kernel.org,
 AJvYcCUD9VguFVUmo+ho+0pc1Ii/8sHb6HuL8KZ5quNBt9B79NLu0EzPCLo8WaH3MIoQiPt/RFL/VbbR9no=@vger.kernel.org,
 AJvYcCUGBRNhwPW7BEFKYSmGwNIOtS7IkMYqRQPka6XtiW63OhnEuxzoCV21TOYYElBaxgOHiwseCV7f08FHoPo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy5Md5VtvPufLaGGTlbCZz2yXskEwaFshZ+Y6nngj/cTtI7VNv
	4JrlhhTf8w5GsPCjoKeKEwlNlI3bSKV0YOtEHXhpaOS2KN+TwfCEDMBAswUpUdjHBbD9aP3TiCP
	1T/5Hf0DI3W2N8UhfFOn5Ab8bWw8=
X-Google-Smtp-Source: 
 AGHT+IG3FZeErtg9rZBQTRsbhOI13oHLN1zVDeaPODwA0ALFD9LOB9t0xGaEa3lbo3D1tDjdqqsybMnh+KjtEn/Ymfs=
X-Received: by 2002:a05:651c:546:b0:308:f827:f8fa with SMTP id
 38308e7fff4ca-30c4a8c5671mr41362221fa.27.1742143621085; Sun, 16 Mar 2025
 09:47:01 -0700 (PDT)
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
In-Reply-To: <0aec1406-00cd-44ee-959f-48b646d3dad3@roeck-us.net>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sun, 16 Mar 2025 17:46:49 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwHEoTb4uC=aoSXV2AMFjpZ_7+pDbMS1c_zs_QGAzC_qdA@mail.gmail.com>
X-Gm-Features: AQ5f1JqRh7UbcKtCg_QoYeZ1XlLrqP5NCJmRy5KZE2uZ2fAqz1Xc-7dq1dKKB44
Message-ID: 
 <CAGwozwHEoTb4uC=aoSXV2AMFjpZ_7+pDbMS1c_zs_QGAzC_qdA@mail.gmail.com>
Subject: Re: [PATCH v4 05/13] power: supply: add inhibit-charge-s0 to
 charge_behaviour
To: Guenter Roeck <linux@roeck-us.net>
Cc: platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
	Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Joaquin Ignacio Aramendia <samsagax@gmail.com>,
 Derek J Clark <derekjohn.clark@gmail.com>,
	Kevin Greenberg <kdgreenberg234@protonmail.com>,
 Joshua Tam <csinaction@pm.me>,
	Parth Menon <parthasarathymenon@gmail.com>, Eileen <eileen@one-netbook.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <174214362241.16566.4692715306371535044@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Sun, 16 Mar 2025 at 14:56, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 3/16/25 04:40, Antheas Kapenekakis wrote:
> > On Tue, 11 Mar 2025 at 17:54, Antheas Kapenekakis <lkml@antheas.dev> wrote:
> >>
> >> OneXPlayer devices have a charge bypass feature
> >> that allows the user to select between it being
> >> active always or only when the device is on.
> >>
> >> Therefore, add attribute inhibit-charge-s0 to
> >> charge_behaviour to allow the user to select
> >> that bypass should only be on when the device is
> >> in the s0 state.
> >>
> >> Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
> >> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> >> ---
> >>   Documentation/ABI/testing/sysfs-class-power | 11 ++++++-----
> >>   drivers/power/supply/power_supply_sysfs.c   |  1 +
> >>   drivers/power/supply/test_power.c           |  1 +
> >>   include/linux/power_supply.h                |  1 +
> >>   4 files changed, 9 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> >> index 2a5c1a09a28f..4a187ca11f92 100644
> >> --- a/Documentation/ABI/testing/sysfs-class-power
> >> +++ b/Documentation/ABI/testing/sysfs-class-power
> >> @@ -508,11 +508,12 @@ Description:
> >>                  Access: Read, Write
> >>
> >>                  Valid values:
> >> -                       ================ ====================================
> >> -                       auto:            Charge normally, respect thresholds
> >> -                       inhibit-charge:  Do not charge while AC is attached
> >> -                       force-discharge: Force discharge while AC is attached
> >> -                       ================ ====================================
> >> +                       ================== =====================================
> >> +                       auto:              Charge normally, respect thresholds
> >> +                       inhibit-charge:    Do not charge while AC is attached
> >> +                       inhibit-charge-s0: same as inhibit-charge but only in S0
> >> +                       force-discharge:   Force discharge while AC is attached
> >> +                       ================== =====================================
> >>
> >>   What:          /sys/class/power_supply/<supply_name>/technology
> >>   Date:          May 2007
> >> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> >> index edb058c19c9c..1a98fc26ce96 100644
> >> --- a/drivers/power/supply/power_supply_sysfs.c
> >> +++ b/drivers/power/supply/power_supply_sysfs.c
> >> @@ -140,6 +140,7 @@ static const char * const POWER_SUPPLY_SCOPE_TEXT[] = {
> >>   static const char * const POWER_SUPPLY_CHARGE_BEHAVIOUR_TEXT[] = {
> >>          [POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO]            = "auto",
> >>          [POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE]  = "inhibit-charge",
> >> +       [POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_S0]       = "inhibit-charge-s0",
> >>          [POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE] = "force-discharge",
> >>   };
> >>
> >> diff --git a/drivers/power/supply/test_power.c b/drivers/power/supply/test_power.c
> >> index 2a975a110f48..4bc5ab84a9d6 100644
> >> --- a/drivers/power/supply/test_power.c
> >> +++ b/drivers/power/supply/test_power.c
> >> @@ -214,6 +214,7 @@ static const struct power_supply_desc test_power_desc[] = {
> >>                  .property_is_writeable = test_power_battery_property_is_writeable,
> >>                  .charge_behaviours = BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO)
> >>                                     | BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE)
> >> +                                  | BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_S0)
> >>                                     | BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE),
> >>          },
> >>          [TEST_USB] = {
> >> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> >> index 6ed53b292162..b1ca5e148759 100644
> >> --- a/include/linux/power_supply.h
> >> +++ b/include/linux/power_supply.h
> >> @@ -212,6 +212,7 @@ enum power_supply_usb_type {
> >>   enum power_supply_charge_behaviour {
> >>          POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO = 0,
> >>          POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE,
> >> +       POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_S0,
> >>          POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE,
> >>   };
> >>
> >> --
> >> 2.48.1
> >>
> >
> > Hi Guenter,
> > I think I need an ack here, and then someone from platform-x86 to
> > triage the series.
> >
> > Do I need to cc anyone extra?
> >
>
> You need to cc the maintainers of affected subsystems. Copying the mailing
> list is insufficient.
>
> Guenter
>

Can you tell me who to cc from platform-x86 and linux-pm?

Is it Armin and Rafael?

Best,
Antheas

