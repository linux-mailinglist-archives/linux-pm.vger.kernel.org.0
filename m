Return-Path: <linux-pm+bounces-11124-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A15B931C77
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 23:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21E311F22C50
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 21:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E295313C67A;
	Mon, 15 Jul 2024 21:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4JSaAUm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CA0C15B;
	Mon, 15 Jul 2024 21:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721077941; cv=none; b=GZ61was1Xvq/bP7dG7S7wtQLnuaA0BqQ/5NGRvMiboL8u8ZmSL0wG8GzGzrmZ6ouYCxfzcAR5q6rAGDDmKLIbtIjQTj66wbAVljlZKpW25NbB42S3bkEXsiLFhi+fBQ2Dzk9Xbk0VzvGhiHzEIH17HKquOOe1LsQIQz5FpQNLUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721077941; c=relaxed/simple;
	bh=f9NzP9tjzwXIEUD7yTK7pOIZzQWrs2+SH6OLDjbCgd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J93J+BVVtyLlKF6KLwleGym+T6dtDaYLS4wIOrODew5crefDAAntK4svFM0Uw+HPSy9ReIolg39X5UICAKD+mrNTo9kIETG3STPG7YjQ3RJ03SCWYV1bM2+v9mdcMY/D+bon1cX+ynYfkc8yN2ihYeT3aW7Wy3vwbjdIkSwgjHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4JSaAUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 046E9C4AF0B;
	Mon, 15 Jul 2024 21:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721077941;
	bh=f9NzP9tjzwXIEUD7yTK7pOIZzQWrs2+SH6OLDjbCgd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P4JSaAUmTsLTf25ljtv8Ais+sInxqugqQFf7D8hpvJgIvWBtFTxonXTSTR6JPUWqc
	 Gkfvoc5nTWCZKFl9WCKUXmrZZlQJ3hCYs9W4OurMAGTTz66Xb7P0iV9tmMqA2H2etI
	 on6C+haJKncbdWpZEshsOvMKg39IGVdvgCkLf3Qw5jy+cpw94GKPh+9ObAAvoc/rEz
	 XF9qMoqwd6Kxx0FW8lhm6X+Fo7ASjEUeyUJIRzoM+Zwep+ZQAS7laP6Gn1wCg2M5Zv
	 X20VT8viojGoUqTcXR9WF7EyOwJdQay3K2STevnaKijkZS76zR1kcYZJyU+BgB3tF8
	 nQbrn3fnqW3Tg==
Date: Mon, 15 Jul 2024 14:12:19 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Stefan Lippers-Hollmann <s.l-h@gmx.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3] thermal: core: Call monitor_thermal_zone() if zone
 temperature is invalid
Message-ID: <20240715211219.GA1178@sol.localdomain>
References: <6064157.lOV4Wx5bFT@rjwysocki.net>
 <20240715044527.GA1544@sol.localdomain>
 <4d7e11a7-b352-4ced-acee-b5f64e3cd0b6@linaro.org>
 <CAJZ5v0gx6GyKBYt7YMFwmUQ4OCG49d9k2H=P-4Awr-mJ=eFHKw@mail.gmail.com>
 <20240715145426.199c31d0@mir>
 <CAJZ5v0gPiwkNczZhCf_rkxVoUX33tS9c6irMf_7=Rg48Nw9C4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gPiwkNczZhCf_rkxVoUX33tS9c6irMf_7=Rg48Nw9C4w@mail.gmail.com>

On Mon, Jul 15, 2024 at 04:48:20PM +0200, Rafael J. Wysocki wrote:
> On Mon, Jul 15, 2024 at 2:54 PM Stefan Lippers-Hollmann <s.l-h@gmx.de> wrote:
> >
> > Hi
> >
> > On 2024-07-15, Rafael J. Wysocki wrote:
> > > On Mon, Jul 15, 2024 at 11:09 AM Daniel Lezcano
> > > <daniel.lezcano@linaro.org> wrote:
> > > > On 15/07/2024 06:45, Eric Biggers wrote:
> > > > > On Thu, Jul 04, 2024 at 01:46:26PM +0200, Rafael J. Wysocki wrote:
> > > > >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > >>
> > > > >> Commit 202aa0d4bb53 ("thermal: core: Do not call handle_thermal_trip()
> > [...]
> > > > Does the following change fixes the messages  ?
> > > >
> > > > diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> > > > b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> > > > index 61a4638d1be2..b519db76d402 100644
> > > > --- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> > > > +++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> > > > @@ -622,7 +622,7 @@ static int iwl_mvm_tzone_get_temp(struct
> > > > thermal_zone_device *device,
> > > >
> > > >         if (!iwl_mvm_firmware_running(mvm) ||
> > > >             mvm->fwrt.cur_fw_img != IWL_UCODE_REGULAR) {
> > > > -               ret = -ENODATA;
> > > > +               ret = -EAGAIN;
> > > >                 goto out;
> > > >         }
> > > >
> > > >
> > > > --
> > >
> > > It would make the message go away, but it wouldn't stop the useless
> > > polling of the dead thermal zone.
> >
> > Silencing the warnings is already a big improvement - and that patch
> > works to this extent for me with an ax200, thanks.
> 
> So attached is a patch that should avoid enabling the thermal zone
> when it is not ready for use in the first place, so it should address
> both the message and the useless polling.
> 
> I would appreciate giving it a go (please note that it hasn't received
> much testing so far, though).

> ---
>  drivers/net/wireless/intel/iwlwifi/mvm/fw.c  |    1 
>  drivers/net/wireless/intel/iwlwifi/mvm/mvm.h |    1 
>  drivers/net/wireless/intel/iwlwifi/mvm/tt.c  |   55 ++++++++++++++++++++++-----
>  drivers/thermal/thermal_core.c               |   46 ++++++++++++++++++++++
>  include/linux/thermal.h                      |    1 
>  5 files changed, 95 insertions(+), 9 deletions(-)

I'm still getting the warning messages with this patch applied.

- Eric

