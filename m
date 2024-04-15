Return-Path: <linux-pm+bounces-6372-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F383F8A464C
	for <lists+linux-pm@lfdr.de>; Mon, 15 Apr 2024 02:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FF681F2185E
	for <lists+linux-pm@lfdr.de>; Mon, 15 Apr 2024 00:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D33817;
	Mon, 15 Apr 2024 00:14:46 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF8136B;
	Mon, 15 Apr 2024 00:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713140086; cv=none; b=G66XPFYlcp8PC3Sj1oHx+ZMstSf2RotBS9Ciaov2WjxmXQEG7b4TaL/Vj/G89gYYXNPP8RRgK/JHLOsE+8dZIbhRpF28vrEARhsCahjwPGpfCuLso2qD8xsaVlLLwQlE3lSA5vFRfv4/7miA6gxueTuxUmBpbo5AfeMDjcKmUyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713140086; c=relaxed/simple;
	bh=YoR9uOxSje0476YJAFfp+KDhnzxNJHjo9PEGKaVNrrU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H+NUOfSDrrodxdIIOCXdoKIgQAoRDNj5xECA/XxmJwdVWkXkXnapJPHYJIDjLzNEKYCkAlHa+R1D6/e+4sJZuI6aXnFqIGEjIjCG/TThv6ZW8zChFjaZz43rJh4BumzzH/1ebE/mOInlxu9zK+wX8sw2lrDHtp2WKP9OTbqvg9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03649339;
	Sun, 14 Apr 2024 17:15:13 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A0C83F64C;
	Sun, 14 Apr 2024 17:14:41 -0700 (PDT)
Date: Mon, 15 Apr 2024 01:14:35 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: "Ryan Walklin" <ryan@testtoast.com>
Cc: "Viresh Kumar" <viresh.kumar@linaro.org>, "Yangtao Li"
 <tiny.windzz@gmail.com>, "Viresh Kumar" <vireshk@kernel.org>, "Nishanth
 Menon" <nm@ti.com>, "Stephen Boyd" <sboyd@kernel.org>, "Rob Herring"
 <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Chen-Yu Tsai" <wens@csie.org>, "Jernej Skrabec"
 <jernej.skrabec@gmail.com>, "Samuel Holland" <samuel@sholland.org>, "Rafael
 J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, "Brandon Cheo Fusi"
 <fusibrandon13@gmail.com>, "Martin Botka" <martin.botka@somainline.org>,
 "Martin Botka" <martin.botka1@gmail.com>, "Chris Morgan"
 <macroalpha82@gmail.com>, "Mark Rutland" <mark.rutland@arm.com>, "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>, "Sudeep Holla" <sudeep.holla@arm.com>
Subject: Re: [PATCH v4 0/8] cpufreq: sun50i: Add Allwinner H616 support
Message-ID: <20240415011435.2aeae1f1@minigeek.lan>
In-Reply-To: <0e021133-f8c1-457d-9079-d9c972e0e69b@app.fastmail.com>
References: <20240329141311.27158-1-andre.przywara@arm.com>
 <20240404064027.shjqvqih7s5rnv2i@vireshk-i7>
 <0e021133-f8c1-457d-9079-d9c972e0e69b@app.fastmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 04 Apr 2024 20:44:02 +1300
"Ryan Walklin" <ryan@testtoast.com> wrote:

Hi Ryan,

> On Thu, 4 Apr 2024, at 7:40 PM, Viresh Kumar wrote:
> > Is it okay to merge all the changes via the cpufreq tree ?  
> 
> I have tested this series with an H700-based board, and have at least one speed-bin (1.032GHz) is not supported although the governor attempts to enable it based on the opp-supported-hw bitmask, and I am unable to reach the 1.5GHz bin at 1.16v (or higher) despite it working on the vendor BSP (kernel panic at boot if enabled), so this may need some slight rework.

Thanks for the report!
So can you try to merge the 1.032 GHz OPP into the 1.008 GHz one? That
would be beneficial anyways since this is the default frequency that
U-Boot sets up.
Should be:
opp-1008000000 {
....
	opp-microvolt-speed5 = <900000>;
	opp-supported-hw = <0x3f>;
....

As for the 1.5 GHz speed bin: We could leave that out for now if it
causes trouble. But can you first state how you got the OPPs? I copied
them from some table you dumped once on IRC, but it would be good to
double check what the actual values are that the BSP kernel runs with.
The values in the vendor DT are highly inconsistent, besides we don't
know for sure which speed bin index the BSP is using and how this maps
to our method.

Cheers,
Andre


> I have reached out to Andre on IRC to debug.
> 
> Ryan


