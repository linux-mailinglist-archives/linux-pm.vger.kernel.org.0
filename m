Return-Path: <linux-pm+bounces-9097-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 206379079DF
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 19:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF842B21516
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 17:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661A514A091;
	Thu, 13 Jun 2024 17:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fK4JEbLr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A40A12CD8F;
	Thu, 13 Jun 2024 17:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718299822; cv=none; b=Xz7xx6ybGy8tWgsVa8HCH/0LTCBzlQc2Wq8qaN4HyBxZ5xHaO1LYK7T6fhBGJsL2y2bjN0TScg1zyJVDya1HP8bARFrY93YAZ5ZMazDHjx7R57w2IUCl3M/rCdGBpBxS8yF1JW5sfRK0Ro468ZMGtQX4YH/eZMsyvSFrGr6l184=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718299822; c=relaxed/simple;
	bh=iXGiyVzJlfGeMho5dKxLGMlk3iobepuYEEz+GbKvgAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aytqwjeAEEUZKfxOR3vba/0XO6/tPOwEhfJotsAL41Mnjbmia82z5d+bujpCxHuQG0/e52LBEbDhe/AjOjvmhUP7Vhnpea8ctLBG+GFrMkeJtaXDOpceJv9QfcqV7DBkNPd0QWxnDlThs8CM8AEWAjoE/Kxvhr7fCOEB5JFNx1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fK4JEbLr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319FEC2BBFC;
	Thu, 13 Jun 2024 17:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718299821;
	bh=iXGiyVzJlfGeMho5dKxLGMlk3iobepuYEEz+GbKvgAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fK4JEbLrhAoUmrErk5MsY+F9kwVDpQzUeeqNeppzFPkc80o50tLgRe1OBE3rgrQRW
	 A3uRg9Ci3qmYMh/CN4MIhFpVgJHMj2ZBAbJRnhEd04Kz7tQnMseKzNMddMnz4bFcxf
	 7Ph+/iGmeqnuoCcQ9VT7DsRVHU2NyOljVF5MyuXy9NdxABUZtMh+zVuDwBGq660lNL
	 3Fkh11ySCKv7JgtUd+xiYcOmNZsKXN3eP0A15FH3cbf/jgLs5B+ldWjGgY1ZZx8Wfm
	 1ZNUoeMxK+63FA4OZu3nQ8xkUopA8uC8qbyv2cz+aVIT0gHVLWCQGo//jncI2KpUiE
	 hVnAzruEmOTCg==
Date: Thu, 13 Jun 2024 18:30:15 +0100
From: Lee Jones <lee@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, Bryan Brattlof <bb@ti.com>,
	Conor Dooley <conor@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Vibhore Vardhan <vibhore@ti.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/5] DONOTMERGE: dt-bindings: mfd: syscon: add TI's opp
 table compatible
Message-ID: <20240613173015.GT2561462@google.com>
References: <20240612-ti-opp-updates-v1-0-3551c31d9872@ti.com>
 <20240612-ti-opp-updates-v1-3-3551c31d9872@ti.com>
 <20240612-unranked-unsalted-b32674a98d4a@spud>
 <20240612175457.b6q37nm6x4vsdnks@bryanbrattlof.com>
 <20240613120923.GP1504919@google.com>
 <20240613-suspend-synapse-4c7596888198@wendy>
 <56030532-fe5d-414c-b254-f6b39f58cde1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <56030532-fe5d-414c-b254-f6b39f58cde1@kernel.org>

On Thu, 13 Jun 2024, Krzysztof Kozlowski wrote:

> On 13/06/2024 14:20, Conor Dooley wrote:
> > On Thu, Jun 13, 2024 at 01:09:23PM +0100, Lee Jones wrote:
> >> On Wed, 12 Jun 2024, Bryan Brattlof wrote:
> >>
> >>> On June 12, 2024 thus sayeth Conor Dooley:
> >>>> On Wed, Jun 12, 2024 at 11:41:52AM -0500, Bryan Brattlof wrote:
> >>>>> The JTAG_USER_ID_USERCODE efuse address, which is located inside the
> >>>>> WKUP_CTRL_MMR0 range holds information to identify the speed grades of
> >>>>> various components on TI's K3 SoCs. Add a compatible to allow the
> >>>>> cpufreq driver to obtain the data to limit the maximum frequency for the
> >>>>> CPUs under Linux control.
> >>>>>
> >>>>> Signed-off-by: Bryan Brattlof <bb@ti.com>
> >>>>
> >>>> $subject: DONOTMERGE: dt-bindings: mfd: syscon: add TI's opp table compatible
> >>>>
> >>>> Okay, if this isn't for merging then I won't Ack it.
> >>>
> >>> Ha! Nice. If I don't hear anything from anyone else I'll send a v2 in a 
> >>> few hours.
> >>
> >> What's the point of all the DONOTMERGE nonsense?
> > 
> > AFAICT, TI live in fear of subsystem maintainers merging the dts patches,
> > so they do this.
> 
> And want some strict timeframe of merging bindings (via subsystem) and
> DTS (via SoC tree), which causes all weird submissions like this above
> or sending bindings without users.
> 
> So far I can live with it but if more such peculiarities come up, then
> sorry, fix your process/tools instead of putting burden on maintainers
> and community.

FWIW, if I see DONOTMERGE in the subject line, I tend to skip over them.

-- 
Lee Jones [李琼斯]

