Return-Path: <linux-pm+bounces-7687-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE378C11F1
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2024 17:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 341AD1C20A34
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2024 15:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2BD16EC01;
	Thu,  9 May 2024 15:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OBIBBJ+J"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505D812FF9B;
	Thu,  9 May 2024 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715268357; cv=none; b=PVbM3fkkaHLW2QCl1CByfdaqkBOYm3qOk70onJy7jc6ZfBrwwRT5L/JvRjhBBMFK3F3wKxPdnwyV1mQmZH1PGQtvJQpF1ZpgoyrNC1+jHrBIcIB8A5NegMBqkKo3FfTNxsqElkWN/4Ai5MZU02O9MOym2xFvq1f0zToonTW8wSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715268357; c=relaxed/simple;
	bh=m9q/155UPuyFUCXsfJg5d7YeQ2HOuMbxl6tPt4+hW84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9YVel+xBsvyEQicupa9ALPHxInbA54n52VOAVnqwjQR9aqws78xnfVDennLucUpPNgWYas3Ol0tNt3U2kf2lweghKUEt6dG8K9ZDWalHe9g3t7J3jaOcmuD0QIwcdWXXVCDSurYTZ6CfRCYMI0nL4eaySpFTPpMWpTiA02x8LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OBIBBJ+J; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715268353;
	bh=m9q/155UPuyFUCXsfJg5d7YeQ2HOuMbxl6tPt4+hW84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OBIBBJ+J0gyA4LT+ZaNAaNX8P5+/XHxZ1j8/7lVCgol0Hl6u5xPY2teZUl9rqBiQK
	 VU6uPYfRq1wIoeuFlVVuJUVaHqVhUaurIzgwslN9k2U7oF09gzD6T+eXE1xDNnZq7P
	 6ZcznwwUTEo4Kjc+fFfoDs6IBSIgPC4EI+6hCz9ELwNvdOkqEdO2KD1MN0mqFWftNr
	 y0m9l2vCf4JQLwZlQG0R0T0SJZEbjafdSg7BXlwCmWSTHmq7veL+Yun6wA4O8pTba1
	 U3Cem1VhfS/6uzd6Pvy5rTf5lIChJwFGY1bWjATTXI7Oeboa6lW1MvoD4C04iIAYsq
	 V/E1YJiSyjyTQ==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4070537820FA;
	Thu,  9 May 2024 15:25:52 +0000 (UTC)
Date: Thu, 9 May 2024 11:25:50 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Hsin-Te Yuan <yuanhsinte@chromium.org>
Cc: Sebastian Reichel <sre@kernel.org>, kernel@collabora.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Pin-yen Lin <treapking@chromium.org>
Subject: Re: [PATCH v3] power: supply: sbs-battery: Handle unsupported
 PROP_TIME_TO_EMPTY_NOW
Message-ID: <924db470-8163-4454-8f59-f7372a132186@notapiano>
References: <20240418-sbs-time-empty-now-error-v3-1-f286e29e3fca@collabora.com>
 <cf4d8131-4b63-4c7a-9f27-5a0847c656c4@notapiano>
 <CAHc4DNJ0prAQOw89Hvw8n9KhY+8xB3D77pJvoPfU-X7ZFDYu7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHc4DNJ0prAQOw89Hvw8n9KhY+8xB3D77pJvoPfU-X7ZFDYu7Q@mail.gmail.com>

On Mon, Apr 22, 2024 at 04:10:23PM +0800, Hsin-Te Yuan wrote:
> On Sat, Apr 20, 2024 at 12:03 AM Nícolas F. R. A. Prado
> <nfraprado@collabora.com> wrote:
> >
> > On Thu, Apr 18, 2024 at 01:34:23PM -0400, Nícolas F. R. A. Prado wrote:
> > > Despite the RunTimeToEmpty() (0x11) function being defined in the SBS
> > > specification as required, it seems that not all batteries implement it.
> > > On platforms with such batteries, reading the property will cause an
> > > error to be printed:
> > >
> > > power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > >
> > > This not only pollutes the log, distracting from real problems on the
> > > device, but also prevents the uevent file from being read since it
> > > contains all properties, including the faulty one.
> > >
> > > The following table summarizes the findings for a handful of platforms:
> > >
> > > Platform                                Status  Manufacturer    Model
> > > ------------------------------------------------------------------------
> > > mt8186-corsola-steelix-sku131072        OK      BYD             L22B3PG0
> > > mt8195-cherry-tomato-r2                 NOT OK  PANASON         AP16L5J
> > > mt8192-asurada-spherion-r0              NOT OK  PANASON         AP15O5L
> > > mt8183-kukui-jacuzzi-juniper-sku16      NOT OK  LGC KT0         AP16L8J
> > > mt8173-elm-hana                         OK      Sunwoda         L18D3PG1
> > > sc7180-trogdor-lazor-limozeen-nots-r5   NOT OK  Murata          AP18C4K
> > > sc7180-trogdor-kingoftown               NOT OK  333-AC-0D-A     GG02047XL
> > > rk3399-gru-kevin                        OK      SDI             4352D51
> > >
> > > Detect if this is one of the quirky batteries during presence update, so
> > > that hot-plugging works as expected, and if so report -ENODATA for
> > > POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW, which removes it from uevent and
> > > prevents throwing errors.
> > >
> > > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > > ---
> >
> > Hi,
> >
> > I'm coming back with more information after some more testing has been done.
> >
> > Most importantly, in the meantime, a parallel investigation uncovered that the
> > time_to_empty_now issue was actually in the EC firmware:
> > https://chromium-review.googlesource.com/c/chromiumos/platform/ec/+/5465747
> >
> > So the other faulty properties (which I'll mention below) could also be due to
> > the EC firmware. These are the EC firmware version for the platforms with
> > additional issues:
> > * RW version:    juniper_v2.0.2509-9101a0730
> > * RW version:    lazor_v2.0.6519-9923041f79
> >
> > Hsin-Te, do you have information on whether it's an EC issue in this case as
> > well?
> >
> > The following table shows all the faulty properties per platform:
> >
> > Platform                               Manufacturer  Model      Faulty properties
> > ---------------------------------------------------------------------------------
> > mt8186-corsola-steelix-sku131072       BYD           L22B3PG0   -
> > mt8195-cherry-tomato-r2                PANASON       AP16L5J    time_to_empty_now
> > mt8192-asurada-spherion-r0             PANASON       AP15O5L    time_to_empty_now
> > mt8183-kukui-jacuzzi-juniper-sku16     LGC KT0       AP16L8J    time_to_empty_now
> >                                                                 capacity_error_margin
> >                                                                 constant_charge_current_max
> >                                                                 constant_charge_voltage_max
> >                                                                 current_avg
> >                                                                 technology
> >                                                                 manufacture_year
> >                                                                 manufacture_month
> >                                                                 manufacture_day
> >                                                                 SPEC_INFO
> > mt8173-elm-hana                        Sunwoda       L18D3PG1   -
> > sc7180-trogdor-lazor-limozeen-nots-r5  Murata        AP18C4K    time_to_empty_now
> >                                                                 capacity_error_margin
> >                                                                 constant_charge_current_max
> >                                                                 constant_charge_voltage_max
> >                                                                 current_avg
> > sc7180-trogdor-kingoftown              333-AC-0D-A   GG02047XL  time_to_empty_now
> > rk3399-gru-kevin                       SDI           4352D51    -
> >
[..]
> 
> It looks like the firmware version of juniper is too old. Could you
> update the firmware and test it again?
> Also, Could you provide the error you get from lazor?

Getting back on this, we were finally able to update the EC firmware for both
juniper and limozeen and all the issues were fixed. I have added the logs below
just for reference. So I guess the only change we could have upstream would be a
message suggesting the user to update the EC firmware in case the SBS is behind
the CrosEC and it starts throwing errors. I'll prepare a patch for that.

Thanks,
Nícolas

limozeen:
+ cat /sys/class/power_supply/sbs-12-000b/time_to_empty_now
3932100
+ cat /sys/class/power_supply/sbs-12-000b/capacity_error_margin
3
+ cat /sys/class/power_supply/sbs-12-000b/constant_charge_current_max
0
+ cat /sys/class/power_supply/sbs-12-000b/constant_charge_voltage_max
0
+ cat /sys/class/power_supply/sbs-12-000b/current_avg
0
+ cat /sys/class/power_supply/sbs-12-000b/uevent
DEVTYPE=power_supply
OF_NAME=sbs-battery
OF_FULLNAME=/soc@0/geniqup@ac0000/spi@a80000/ec@0/i2c-tunnel/sbs-battery@b
OF_COMPATIBLE_0=sbs,sbs-battery
OF_COMPATIBLE_N=1
POWER_SUPPLY_NAME=sbs-12-000b
POWER_SUPPLY_TYPE=Battery
POWER_SUPPLY_STATUS=Full
POWER_SUPPLY_CAPACITY_LEVEL=Full
POWER_SUPPLY_HEALTH=Unknown
POWER_SUPPLY_PRESENT=1
POWER_SUPPLY_TECHNOLOGY=Li-poly
POWER_SUPPLY_CYCLE_COUNT=2
POWER_SUPPLY_VOLTAGE_NOW=12293000
POWER_SUPPLY_CURRENT_NOW=0
POWER_SUPPLY_CURRENT_AVG=0
POWER_SUPPLY_CAPACITY=97
POWER_SUPPLY_CAPACITY_ERROR_MARGIN=3
POWER_SUPPLY_TEMP=194
POWER_SUPPLY_TIME_TO_EMPTY_NOW=3932100
POWER_SUPPLY_TIME_TO_EMPTY_AVG=3932100
POWER_SUPPLY_TIME_TO_FULL_AVG=3932100
POWER_SUPPLY_SERIAL_NUMBER=023e
POWER_SUPPLY_VOLTAGE_MIN_DESIGN=11400000
POWER_SUPPLY_VOLTAGE_MAX_DESIGN=11400000
POWER_SUPPLY_ENERGY_NOW=42420000
POWER_SUPPLY_ENERGY_FULL=43700000
POWER_SUPPLY_ENERGY_FULL_DESIGN=51630000
POWER_SUPPLY_CHARGE_NOW=3451000
POWER_SUPPLY_CHARGE_FULL=3555000
POWER_SUPPLY_CHARGE_FULL_DESIGN=4200000
POWER_SUPPLY_CONSTANT_CHARGE_CURRENT_MAX=0
POWER_SUPPLY_CONSTANT_CHARGE_VOLTAGE_MAX=0
POWER_SUPPLY_MANUFACTURE_YEAR=2021
POWER_SUPPLY_MANUFACTURE_MONTH=3
POWER_SUPPLY_MANUFACTURE_DAY=14
POWER_SUPPLY_MANUFACTURER=Murata KT00304012
POWER_SUPPLY_MODEL_NAME=AP18C4K
+ cat /sys/class/chromeos/cros_ec/version
RO version:    lazor_v2.0.23149-099cd3e539
RW version:    lazor_v2.0.23149-099cd3e539

juniper:
+ cat /sys/class/power_supply/sbs-12-000b/time_to_empty_now
3932100
+ cat /sys/class/power_supply/sbs-12-000b/capacity_error_margin
3
+ cat /sys/class/power_supply/sbs-12-000b/constant_charge_current_max
0
+ cat /sys/class/power_supply/sbs-12-000b/constant_charge_voltage_max
0
+ cat /sys/class/power_supply/sbs-12-000b/current_avg
0
+ cat /sys/class/power_supply/sbs-12-000b/technology
Li-ion
+ cat /sys/class/power_supply/sbs-12-000b/manufacture_year
2020
+ cat /sys/class/power_supply/sbs-12-000b/manufacture_month
10
+ cat /sys/class/power_supply/sbs-12-000b/manufacture_day
7
+ cat /sys/class/power_supply/sbs-12-000b/uevent
DEVTYPE=power_supply
OF_NAME=sbs-battery
OF_FULLNAME=/soc/spi@11012000/cros-ec@0/i2c-tunnel/sbs-battery@b
OF_COMPATIBLE_0=sbs,sbs-battery
OF_COMPATIBLE_N=1
POWER_SUPPLY_NAME=sbs-12-000b
POWER_SUPPLY_TYPE=Battery
POWER_SUPPLY_STATUS=Full
POWER_SUPPLY_CAPACITY_LEVEL=Full
POWER_SUPPLY_HEALTH=Unknown
POWER_SUPPLY_PRESENT=1
POWER_SUPPLY_TECHNOLOGY=Li-ion
POWER_SUPPLY_CYCLE_COUNT=8
POWER_SUPPLY_VOLTAGE_NOW=8210000
POWER_SUPPLY_CURRENT_NOW=0
POWER_SUPPLY_CURRENT_AVG=0
POWER_SUPPLY_CAPACITY=99
POWER_SUPPLY_CAPACITY_ERROR_MARGIN=3
POWER_SUPPLY_TEMP=215
POWER_SUPPLY_TIME_TO_EMPTY_NOW=3932100
POWER_SUPPLY_TIME_TO_EMPTY_AVG=3932100
POWER_SUPPLY_TIME_TO_FULL_AVG=3932100
POWER_SUPPLY_SERIAL_NUMBER=26c9
POWER_SUPPLY_VOLTAGE_MIN_DESIGN=7500000
POWER_SUPPLY_VOLTAGE_MAX_DESIGN=7500000
POWER_SUPPLY_ENERGY_NOW=34990000
POWER_SUPPLY_ENERGY_FULL=35170000
POWER_SUPPLY_ENERGY_FULL_DESIGN=39940000
POWER_SUPPLY_CHARGE_NOW=4262000
POWER_SUPPLY_CHARGE_FULL=4284000
POWER_SUPPLY_CHARGE_FULL_DESIGN=4865000
POWER_SUPPLY_CONSTANT_CHARGE_CURRENT_MAX=0
POWER_SUPPLY_CONSTANT_CHARGE_VOLTAGE_MAX=0
POWER_SUPPLY_MANUFACTURE_YEAR=2020
POWER_SUPPLY_MANUFACTURE_MONTH=10
POWER_SUPPLY_MANUFACTURE_DAY=7
POWER_SUPPLY_MANUFACTURER=LGC KT0
POWER_SUPPLY_MODEL_NAME=AP16L8J
+ cat /sys/class/chromeos/cros_ec/version
RO version:    juniper_v2.0.2796-7246101293
RW version:    juniper_v2.0.2796-7246101293

