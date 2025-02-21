Return-Path: <linux-pm+bounces-22598-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C47FA3EC76
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 07:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20C223A99DB
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 06:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A521EEA2D;
	Fri, 21 Feb 2025 06:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHMyib5G"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0952318C937;
	Fri, 21 Feb 2025 06:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740117811; cv=none; b=qSscIm0a9ffyT4YfLQ8+HwV6TCZT26ley++yk9v5HTYHxcdA8BugxYmQlLGkfoFeBef4sg6/0JcmgE4u5g0UR2s/zqysYZ7tIzi0R5I4cGV1CJ8VfzsLRdcJJja2SC7NUZnuMtn5FGJPY9GN6UL7RsMaA0+sNSR0EApyCA4DlDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740117811; c=relaxed/simple;
	bh=myYqEq3IjsQ42MkQNilp2nZirfWQcMxslTThPccR8uQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mvuQ1vf8V3BwgxYH9opnE+CZdIGzjaDjAsCob+gZ6+ZFDGd0EQjoGKYvyf5cmSIBjyorhYULHAvRCvqx/fWcbD/HWTsgjIsZWm2T5KClgOmwlO0keJG/RX8LhHrVXPp5RCde2RqU3WrkvAD1wrOYX1k3fxyxXZM/sZnXQOfK27o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHMyib5G; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2fbf77b2b64so3549278a91.2;
        Thu, 20 Feb 2025 22:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740117809; x=1740722609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4e9ra78En4uAJWM6ym6twIIgEm+EPG5nOX3Kb+N+Mg=;
        b=VHMyib5GPMMDQSZZHbmYoPwl8ISMwZfTR/8p4b3MvUiTwZFhGFRcI0Pz5BJ35u7F8E
         Mfyeh86W/WIwEIPWzRGZTmi8MGFgqpDSwAki0G/Qi0Z1azNusmFKF5NrmRv9JZD8vpPb
         QZ53db2vBNd6eGyO5s1ieQUZuE3iNr5UUmI4PvNoX1xVw1ksvbsDe6cmE0gXfyo8m0ox
         LHeuBIZdxN5wB+gCZziJ0KXrhJw5gNHjn4uMscqH//3nd+sMdc6O3cCZzEJHgfw1f6F7
         OFvs/qzvhuROdEN6hLcJRgmvI3pJ2lDMbKXWaGd91mZMQYIC8OOYUAepU1xQoeafwHqV
         w1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740117809; x=1740722609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h4e9ra78En4uAJWM6ym6twIIgEm+EPG5nOX3Kb+N+Mg=;
        b=G/nCOt/l+srypIEQAqYngGaHSR0hNuqp9/rm9nBWvmJk+Tr4mK+R2EkJZK80EvrcC+
         7k4cRvPfYquAqSzAhxGoDyqJUNdacfgi21OOa4esVFDblyWKu+caJKnRYjpWMf199qin
         4VzEWFopEBSa6kVCpYFljTIKjwtcukooEknA4gu3QSSk7tgXbFecJwK6cnyCYyThOuiy
         0f507fxGOTAaG7DFjYdewppOLQmBK71Xkut1o3kullSc/fy+mA7Nc48oHpNsGNRu7ZDA
         3YaZU7RbCjhNPnZ44bE1fpHL6VeIRtGlxGhcHRlCvL+G4dpvRRgvfFnet0Oa5aojZeYP
         hzzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjp8uv7DaHtId8L5IOgdb9HiYDfQ7ewddLLdCtIf6CiPX7snMuzXn30+xE4WklVFhH1AOHzLeKvg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy06WWQ+oNic4Te5Zf1IRMvFiwOJ+lBbVNSayT4+sjZHaRmTCYr
	uhv/8uNoUdckhZH3XJmEwMGGCS4UDCWGdUGEvggJU/a50BioVbGAjQ+2WjwrIug=
X-Gm-Gg: ASbGncslaNNErwmOR3vAUague6dfyjPfED8kMWnzezidK1vghTAnJMhMvRMVWM0diAY
	KkHyy6YFIx+O11vws1C2yC/YgwDlAZpetCqZ/tfR2BukoUfE83Q/Cw4qsARBCTX7wXPjH6ZUvu7
	lci1nKMK/iiBqzdWdNkmA3dwaA4LZcK9OWmON4EV4y4Mv2EobO1x9ehDzQ5lYVm1vRCAz1BbrwH
	+xVEQDcnfIyxcQxuVg8VLFmPLYe68oeuy1AGb6MujiBLo8jP3Uitsqi3iww7vKN0RGfxmW6iq99
	qR2fBPHJmxf3boh+t46EO/GJ
X-Google-Smtp-Source: AGHT+IFkf58Jvli/2fJFQmQt00LDpB1VtdyHwqcPGV8qa9JslZfV+vKkRVL8LGMdr15gl8o9Gb3dWA==
X-Received: by 2002:a05:6a00:2302:b0:730:91b8:af1 with SMTP id d2e1a72fcca58-73426d82998mr2966216b3a.18.1740117808976;
        Thu, 20 Feb 2025 22:03:28 -0800 (PST)
Received: from nuvole.. ([144.202.86.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734300da098sm299122b3a.129.2025.02.20.22.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 22:03:28 -0800 (PST)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: sebastian.reichel@collabora.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	mitltlatltl@gmail.com
Subject: Re: [PATCH v3 5/6] power: supply: add Huawei Matebook E Go psy driver
Date: Fri, 21 Feb 2025 14:01:04 +0800
Message-ID: <20250221060143.201963-1-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <7la3x6f733ju4szqlzmtr277ah7c7lb4d4gcmjgu2rjj5uzpyd@43dmenbpczjs>
References: <7la3x6f733ju4szqlzmtr277ah7c7lb4d4gcmjgu2rjj5uzpyd@43dmenbpczjs>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, Feb 21, 2025 at 9:33 AM Sebastian Reichel <sebastian.reichel@collabora.com> wrote:
> On Thu, Feb 20, 2025 at 02:43:20PM +0800, Pengyu Luo wrote:
> > On Thu, Feb 20, 2025 at 8:24 AM Sebastian Reichel <sebastian.reichel@collabora.com> wrote:
> > > On Tue, Jan 14, 2025 at 01:51:27AM +0800, Pengyu Luo wrote:
> > > > On the Huawei Matebook E Go tablet the EC provides access to the adapter
> > > > and battery status. Add the driver to read power supply status on the
> > > > tablet.
> > > >
> > > > Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> > > > ---
> > > >  .../ABI/testing/sysfs-class-power-gaokun      |  47 ++
> > > >  drivers/power/supply/Kconfig                  |  10 +
> > > >  drivers/power/supply/Makefile                 |   1 +
> > > >  drivers/power/supply/huawei-gaokun-battery.c  | 548 ++++++++++++++++++
> > > >  4 files changed, 606 insertions(+)
> > > >  create mode 100644 Documentation/ABI/testing/sysfs-class-power-gaokun
> > > >  create mode 100644 drivers/power/supply/huawei-gaokun-battery.c
> > > >
> > > > diff --git a/Documentation/ABI/testing/sysfs-class-power-gaokun b/Documentation/ABI/testing/sysfs-class-power-gaokun
> > > > new file mode 100644
> > > > index 000000000..b1eb9e8d7
> > > > --- /dev/null
> > > > +++ b/Documentation/ABI/testing/sysfs-class-power-gaokun
> > > > @@ -0,0 +1,47 @@
> > > > +What:                /sys/class/power_supply/gaokun-ec-battery/smart_charge
> > > > +Date:                January 2025
> > > > +KernelVersion:       6.12
> > > > +Contact:     Pengyu Luo <mitltlatltl@gmail.com>
> > > > +Description:
> > > > +             This entry allows configuration of smart charging behavior with
> > > > +             four parameters. The format is: <mode> <delay> <start> <stop>.
> > > > +
> > > > +             - mode: Defines the charging mode (1 or 4). Mode 4 enables delay,
> > > > +                     while mode 1 does not.
> > > > +             - delay: Specifies the delay in hours (non-negative). This is
> > > > +                     only used when 'mode' is set to 4.
> > > > +             - start: The battery percentage at which charging starts (0-100).
> > > > +             - stop: The battery percentage at which charging stops (1-100).
> > > > +
> > > > +              When the laptop is connected to a power adapter, it starts
> > > > +              charging if the battery level is below the 'start' value. It
> > > > +              continues charging until the battery reaches the 'stop' level.
> > > > +              If the battery is already above the 'stop' level, charging is
> > > > +              paused.
> > > > +
> > > > +              When the power adapter is always connected, charging will
> > > > +              begin if the battery level falls below 'start', and charging
> > > > +              will stop once the battery reaches 'stop'.
> > > > +
> > > > +              If mode is set to 4, the above charging mode will only occur
> > > > +              after the specified delay in hours. If mode is 1, there is
> > > > +              no delay.
> > > > +
> > > > +             Access: Read, Write
> > > > +
> > > > +             Valid values:
> > > > +                     - mode: integer value (1 or 4)
> > > > +                     - delay: integer value, delay in hours (non-negative)
> > > > +                     - start: integer value, battery percentage (0-100)
> > > > +                     - stop: integer value, battery percentage (1-100)
> > >
> > > There are common properties for start and stop charging percentage,
> > > which should be used:
> > >
> > > * POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD
> > > * POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD
> > >
> >
> > Agree, but at least, we should pass delay, start, end. EC only
> > providedone interface to set mode and delay, that requires 4
> > arguments, we can handle it with 3 arguments, as you suggested
> > below. but if we treat start and end separated, then if we want
> > to set smart charge, we set start, set end, set delay(read start
> > read end, then set them again). It is a bit redundant.
>
> Yes, if these are separate properties you won't get atomic updates.
> But is that really a problem? Using the standard properties means
> that you get UI support in the future. I know at least the GNOME
> people are working on this.
>

On my another x86_64 device with end threshold supported, KDE Plasma
supports showing this as

> Battery is configured to charge up to aproximately <value>%

it doesn't support setting things. So, can I keep passing delay, start,
end when setting, but also setting start and end as battery properties?

> > > For the charge mode it seems there is no need to expose anything.
> > > You can have a single property for the charge delay in hours. If
> > > '0' is written to it there is no delay, so you can use mode 1 and
> > > otherwise you can use mode 4. There is no need for this multi-value
> > > mess. The delay thing seems to be quite specific to this EC, so a
> > > custom property for that is fine.
> > >
> >
> > Agree, mentioned above
>
> [...]
>
> > > > +static void gaokun_psy_init(struct gaokun_psy *ecbat)
> > > > +{
> > > > +     gaokun_psy_get_bat_present(ecbat);
> > >
> > > why?
> > >
> >
> > EC provided a way to check if battery is presented, if there is no
> > battery, then we don't fetch battery info, but other info
> > (i.e. adapter) is still available.
>
> nevermind, I miss-read and wondered why gaokun_psy_bat_present is
> being called twice.
>
> > > > +     if (!gaokun_psy_bat_present(ecbat))
> > > > +             return;
> > >
> > > You only call it in your probe function, so the following will
> > > remain uninitialized if the battery was not present at boot time.
> >
> > mentioned above, keep them uninitialized is unharmful.
>
> Does the battery not support hot-plug?
>

I am not sure, this is a tablet shipped with a qualcomm chip, we can
take it as an embedded device. I just took normal usage and using
without battery into account.

Best wishes,
Pengyu

