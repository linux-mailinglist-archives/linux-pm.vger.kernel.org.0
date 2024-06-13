Return-Path: <linux-pm+bounces-9080-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5F2906EB6
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 14:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9228A1C230E7
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 12:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFBD143C59;
	Thu, 13 Jun 2024 12:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMyxiSkQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE9B13A411;
	Thu, 13 Jun 2024 12:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718280569; cv=none; b=FkiRLHPCo8fBmNlGocvd2o0naeKnTQoScjvjleiB6ml2ejKUKdUh3Mo6l2goUzGeIx2T/Jzx3oPaLwJN5x6RC9qfDdrzc4kma02R8W6mUfPZe/E7V4cDUDbrG/DYRCjnWyoC20lg9BPdN3W9ooum1RvSpJ8J/f762iaXnrfrn4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718280569; c=relaxed/simple;
	bh=NDOVaq1xrf8JHJ9vBIDlYAqKNy3l+y2ouEKbAPh8grg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+A0Hbm7nNAEIvJkXbEXBuKZxSo6erONHbUx4GZzSWZJ2pz1rt2h2Esw2b2NANXWC3EfY5R1T6qD90JdzQxYE/BjUPSVr118m7zk2mynHdXxOn0yJoaZR49gppoxM75u2s37o8gHOtl1mNsOiQU3QUhhn6vme0NZ+wxz7WcD1mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMyxiSkQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 750B7C2BBFC;
	Thu, 13 Jun 2024 12:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718280569;
	bh=NDOVaq1xrf8JHJ9vBIDlYAqKNy3l+y2ouEKbAPh8grg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dMyxiSkQTkLauDE6GbrGTAr/Ea/GChXfhBpB1+gOWjV8MWW9QdUT0VlR9pBxHefNF
	 kRfNcM3lKw9+2jJ1w9AtP+FbvfpHzr4X8T0WhCHqSXKbQTkrU2t0UAjPNiHyy1jFZq
	 OBkM/Ag4BhM7CM7Ex3QRelR1dEgzdUpfloBXAIYeb/pZ0x2o4XymH1iftuxcx0HebG
	 szoNgn16mAkhkr7xV8ny3/CmVGdpd5+V6iFoJQfLaKtWTni37G47tf3gW6JxnnOMlR
	 BKbroGQkw2s2inrLNIZWB/suC20Rze5zxiGuYuaD6jaNC+gtyLASZ+MD8hHUxjfZYB
	 I093jFS/6acLg==
Date: Thu, 13 Jun 2024 13:09:23 +0100
From: Lee Jones <lee@kernel.org>
To: Bryan Brattlof <bb@ti.com>
Cc: Conor Dooley <conor@kernel.org>,
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
Message-ID: <20240613120923.GP1504919@google.com>
References: <20240612-ti-opp-updates-v1-0-3551c31d9872@ti.com>
 <20240612-ti-opp-updates-v1-3-3551c31d9872@ti.com>
 <20240612-unranked-unsalted-b32674a98d4a@spud>
 <20240612175457.b6q37nm6x4vsdnks@bryanbrattlof.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240612175457.b6q37nm6x4vsdnks@bryanbrattlof.com>

On Wed, 12 Jun 2024, Bryan Brattlof wrote:

> On June 12, 2024 thus sayeth Conor Dooley:
> > On Wed, Jun 12, 2024 at 11:41:52AM -0500, Bryan Brattlof wrote:
> > > The JTAG_USER_ID_USERCODE efuse address, which is located inside the
> > > WKUP_CTRL_MMR0 range holds information to identify the speed grades of
> > > various components on TI's K3 SoCs. Add a compatible to allow the
> > > cpufreq driver to obtain the data to limit the maximum frequency for the
> > > CPUs under Linux control.
> > > 
> > > Signed-off-by: Bryan Brattlof <bb@ti.com>
> > 
> > $subject: DONOTMERGE: dt-bindings: mfd: syscon: add TI's opp table compatible
> > 
> > Okay, if this isn't for merging then I won't Ack it.
> 
> Ha! Nice. If I don't hear anything from anyone else I'll send a v2 in a 
> few hours.

What's the point of all the DONOTMERGE nonsense?

-- 
Lee Jones [李琼斯]

