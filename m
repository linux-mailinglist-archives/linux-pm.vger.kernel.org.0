Return-Path: <linux-pm+bounces-8678-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D8E8FDEAB
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 08:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37F011F21DD1
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 06:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC4E73164;
	Thu,  6 Jun 2024 06:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ap+aB7M7"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690D12E3E5;
	Thu,  6 Jun 2024 06:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717655156; cv=none; b=uUl5Aoemt+xfkajQtvFKjMlrLc3/kyDBW9x1CU9IWTZLUxWx4UTYhHcptTcshLHa5djoHapv/rleQbPrriz5Pga71NC5Dd7woYdBsEwTm51gf6nAOG1qlBeb4LpMb79Jf7SmsVBC8by1HCz0PuIHxGgL8RtPET8Cv6krxEQ0Qag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717655156; c=relaxed/simple;
	bh=Wfeg8GAi9GwSyPrICtL0MY874pcQ+nuX+//SQF4Q63U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+aSEPRVkltBXQe7RYZWPI4074npWMZWrH+YrbR5eRcFnVIiaLEt4BCRsFkttawp4PcNfAcZ/sI3nVRYmNbB0WDKFQi9hCpTvLF4kIMUbE6/agC6nywhGY6iBQHt7sFKTdrIZL399M1NrQJae5ZdPGHKqJkF0xCbt+eZreHk9qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ap+aB7M7; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1717655145;
	bh=Wfeg8GAi9GwSyPrICtL0MY874pcQ+nuX+//SQF4Q63U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ap+aB7M7eNNAVWFNB2wesEkU4e+ielGbEoJAtWC2AXSaK71bYdLmrZz2sBOxDf+oy
	 gPIdX+GOTSLEqMs4oG9uMHcRo2QJP9Zy1aPaPP12FbdZFFgKY+JOUm7Td/j/o1t+lr
	 IoQOALg1kOo23Xw3657kI//xdH6vkp8ZqcrygMyA=
Date: Thu, 6 Jun 2024 08:25:45 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Mario Limonciello <mario.limonciello@amd.com>, 
	Matt Hartley <matt.hartley@gmail.com>
Cc: Dustin Howett <dustin@howett.net>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>, 
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Stephen Horvath <s.horvath@outlook.com.au>, Rajas Paranjpe <paranjperajas@gmail.com>
Subject: Re: [PATCH v2 0/3] ChromeOS Embedded Controller charge control driver
Message-ID: <ed6e5fd4-2be1-4a72-8041-5087ebc93203@t-8ch.de>
References: <20240528-cros_ec-charge-control-v2-0-81fb27e1cff4@weissschuh.net>
 <CA+BfgNJByawxkZukaCXYcmOo_K9aQ0W1x8B6Y+Hyg_fZaJ4axw@mail.gmail.com>
 <5baf3caf-dc09-4829-96db-2666fc902710@t-8ch.de>
 <CA+BfgN+LE3YyF3te4m8sWbtH85tU+ERUDW7YR_BFecusVTAWWw@mail.gmail.com>
 <a527a3fd-1458-43cc-aac0-0b360beeb349@t-8ch.de>
 <db20a640-5323-4866-9968-c57391fbb6bc@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db20a640-5323-4866-9968-c57391fbb6bc@amd.com>

+Matt, the Linux support lead for Framework.

Hi Matt,

below we are discussing on how to implement charge controls for ChromeOS
EC devices including Framework laptops in mainline Linux.
Some feedback would be great.

On 2024-06-05 15:32:33+0000, Mario Limonciello wrote:
> On 6/5/2024 04:33, Thomas Weißschuh wrote:
> > On 2024-06-04 20:27:57+0000, Dustin Howett wrote:
> > > On Mon, Jun 3, 2024 at 3:59 PM Thomas Weißschuh <linux@weissschuh.net> wrote:
> > > > 
> > > > Can you try disabling all of the Framework-specific charge control
> > > > settings and test again?
> > > > Probably the different, disparate logics in the Framework ECs are
> > > > conflicting with each other.
> > > 
> > > Fascinating! This board does indeed support charge limiting through
> > > both interfaces. It looks like the most recently set one wins for a
> > > time.
> > 
> > If it is the most recent one, shouldn't the driver have worked?
> > What does "for a time" mean?
> > I'm using only the upstream EC command and that seems to work fine.
> > 
> > > The UEFI setup utility only sets the framework-specific charge limit value.
> > > 
> > > We should probably find some way to converge them, for all of the
> > > supported Framework Laptop programs.
> > 
> > In the long term, Framework should align their implementation with
> > upstream CrOS EC and either drop their custom command or make it a thin
> > wrapper around the normal the upstream command.
> > 
> > (As you are familiar with EC programming maybe you want to tackle this?)
> > 
> > Until then I think we can detect at probe-time if the Framework APIs are
> > available and use them to disable the Framework-specific mechanism.
> > Then the CrOS EC commands should be usable.
> > 
> > The drawback is, that userspace using the Framework APIs will break
> > the driver. That userspace would need to migrate to the standard UAPI.
> 
> How does userspace access the Framework APIs?  Surely it needs to go through
> the kernel?  Could you "filter" the userspace calls to block them?
> 
> For example this is something that currently happens in the dell-pc driver
> to block userspace from doing thermal calls and instead guide people to the
> proper API that the driver exports.

This would work when userspace uses /dev/cros_ec.
But the EC can also used via raw port IO which wouldn't be covered.
Given that /dev/cros_ec wasn't usable on Framework AMD until v6.9 it's
not unlikely users are using that.

And technically both aproaches would break userspace.

Another aproach would be to not load the module on Framework devices
which implement their custom command (overwritable by module parameter).

Framework unifies the implementation of their command with the core
CrOS EC logic so both commands work on the same data.
The custom command is adapted to also implement a new command version.
This is completely transparent as the old version will continue to work.

We update the Linux driver to recognize that new command version, know
that they are now compatible and probe the driver.

Newer devices could also drop the custom command and the driver would
start working.

This scheme requires some cooperation from Framework, though.

> > 
> > Also the settings set in the firmware would be ignored at that point.
> > 
> > I don't want to use the functionality of the Framework command because
> > it's less featureful and I really hope it will go away at some point.
> 

