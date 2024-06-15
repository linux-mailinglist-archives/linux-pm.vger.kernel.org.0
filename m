Return-Path: <linux-pm+bounces-9231-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB8D909913
	for <lists+linux-pm@lfdr.de>; Sat, 15 Jun 2024 18:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F06E71F21B05
	for <lists+linux-pm@lfdr.de>; Sat, 15 Jun 2024 16:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76180481B3;
	Sat, 15 Jun 2024 16:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JG7acFds"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B79CA6B;
	Sat, 15 Jun 2024 16:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718470552; cv=none; b=dv537J3kMUZ2nnGWARrlMAiLJUR+pD2+VmlzKNcY6qajzkop2+89SUYw4pohGJp1AHXaBM2SPlsY2+8zJvsj5CTe3rwabv0EEBNKWKC05G9ylfMm0pnHOYdFWI/vKd6p+6AMywb3Po26F5DswB192FAVtyLWnbo8tp4U2iwjKBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718470552; c=relaxed/simple;
	bh=nEKxVTWD9r/tTL2wHLGTS/cvLxvBOuAefm3Ne8+VBNQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LX+7iODyhmtGpZ0zMP8EU0BXkzIbUV1Puu3/5s6V/AYzG4AsYi2NiyqYYfislma7XE7iEhAQ1IxEqA6FWyTFHAXdyPqflGELZuBBQ/oflbADJCyno8eCK/DZuJVI7S4/WR7xyf5OeI3v1zSLAbB3LHQdD/6FolmCPcfWqC8Z3W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JG7acFds; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45FEh5DE001000;
	Sat, 15 Jun 2024 09:43:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718462585;
	bh=GaC3ezrZQf5WjYpYlhivSVVNS1CrpHZ3pwLl4Taa7C4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=JG7acFdsXBGm108rqV/Vl4QtxCFKAcXxSS5EiKhDKH91Cw0gp51ZjvZwpYQ5wdfpF
	 DO4n2Kpgn06hzJ5yliLqyOz3IkQCzwtf1NmWPEgXV0NYEi590ys4hpt6NR2FdEc7H7
	 6j2GrGMo7Ld6MTr+j/hPz+cigH82PLYd6q8LEhSw=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45FEh5Y0012919
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 15 Jun 2024 09:43:05 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 15
 Jun 2024 09:43:05 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 15 Jun 2024 09:43:04 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45FEh48q098971;
	Sat, 15 Jun 2024 09:43:04 -0500
Date: Sat, 15 Jun 2024 09:43:04 -0500
From: Bryan Brattlof <bb@ti.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Conor Dooley <conor.dooley@microchip.com>, Lee Jones <lee@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Vibhore Vardhan <vibhore@ti.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/5] DONOTMERGE: dt-bindings: mfd: syscon: add TI's opp
 table compatible
Message-ID: <20240615144304.ty7cpigqddpux55w@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
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
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <56030532-fe5d-414c-b254-f6b39f58cde1@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On June 13, 2024 thus sayeth Krzysztof Kozlowski:
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
> 

Yeah my worry was all the DTB additions filter in would require a lot of 
coordination between the maintainers of all the different trees.

Having a few DONOTMERGE patches gave the driver maintainer a full look 
at the outcome of the series without having to worry about DTB conflicts 
when another tree picked something up, however I guess if everyone 
participates in -next it shouldn't be that big of a problem. 

~Bryan

