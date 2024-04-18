Return-Path: <linux-pm+bounces-6657-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C67968A985E
	for <lists+linux-pm@lfdr.de>; Thu, 18 Apr 2024 13:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81F1F281AD5
	for <lists+linux-pm@lfdr.de>; Thu, 18 Apr 2024 11:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CB715E5B2;
	Thu, 18 Apr 2024 11:16:51 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEF715E5AD;
	Thu, 18 Apr 2024 11:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713439011; cv=none; b=h23pFigJ4yk19Z8s9+UVL1OGZSQ5QH9fcNr3D9q4jLls8UsMprJ7BYolaf+6TFRvLdU6cI+MbuqVKtCEOkENFU20PQ7/1vmFdd/vMHurwHLOIwjnKlziF90LsTx2x2iAC7I5B5WkI0UIxvdzUC9HrWW2fabCYOsRa4ppmw/mUXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713439011; c=relaxed/simple;
	bh=OyCllvAsE01qdFgOdvtS6usRklZOgOwrr5mtH7cN8Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NhzmYlBfWI7NgxwOIDGzX4io6KfWG5wZOoGJqAJMdvsehZYCM1tMKNXemAgBpQPcwRSlP7qJA3aop7h9zrWj3OFnCgm+sx1uXI0+gPHb+mlwylAYgIiEgj0nNdoSdfCBxRvPDA3EJdRUv8jIV3GJQbNt/OFBzSLbtgXtBF9jErg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E13D2339;
	Thu, 18 Apr 2024 04:17:16 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A2CB3F792;
	Thu, 18 Apr 2024 04:16:46 -0700 (PDT)
Date: Thu, 18 Apr 2024 12:16:42 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: "Ryan Walklin" <ryan@testtoast.com>, "Viresh Kumar"
 <viresh.kumar@linaro.org>
Cc: "Yangtao Li" <tiny.windzz@gmail.com>, "Viresh Kumar"
 <vireshk@kernel.org>, "Nishanth Menon" <nm@ti.com>, "Stephen Boyd"
 <sboyd@kernel.org>, "Rob Herring" <robh+dt@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Chen-Yu Tsai" <wens@csie.org>, "Jernej Skrabec"
 <jernej.skrabec@gmail.com>, "Samuel Holland" <samuel@sholland.org>, "Rafael
 J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, "Brandon Cheo Fusi"
 <fusibrandon13@gmail.com>, "Martin Botka" <martin.botka@somainline.org>,
 "Martin Botka" <martin.botka1@gmail.com>, "Chris Morgan"
 <macroalpha82@gmail.com>, "Mark Rutland" <mark.rutland@arm.com>, "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>, "Sudeep Holla" <sudeep.holla@arm.com>
Subject: Re: [PATCH v4 0/8] cpufreq: sun50i: Add Allwinner H616 support
Message-ID: <20240418121642.53208fab@donnerap.manchester.arm.com>
In-Reply-To: <0e021133-f8c1-457d-9079-d9c972e0e69b@app.fastmail.com>
References: <20240329141311.27158-1-andre.przywara@arm.com>
	<20240404064027.shjqvqih7s5rnv2i@vireshk-i7>
	<0e021133-f8c1-457d-9079-d9c972e0e69b@app.fastmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
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

Hi Viresh, Ryan,

> On Thu, 4 Apr 2024, at 7:40 PM, Viresh Kumar wrote:
> > Is it okay to merge all the changes via the cpufreq tree ?  
> 
> I have tested this series with an H700-based board, and have at least one speed-bin (1.032GHz) is not supported although the governor attempts to enable it based on the opp-supported-hw bitmask, and I am unable to reach the 1.5GHz bin at 1.16v (or higher) despite it working on the vendor BSP (kernel panic at boot if enabled), so this may need some slight rework.
> 
> I have reached out to Andre on IRC to debug.

So those test results look odd, especially since it seems to work on the
BSP. I don't want to jeopardise this series over the oddity on this
variant, so I am dropping the H700 specific speed bin for now. Not
directly matching any known SoC variant now, it will fall back to bin 0,
which gives us some safe values. We lose the highest OPP (1.5 GHz),
but this was exactly the problematic one in the testing, so it's not a
great loss.
Once we have worked out what's really going on there, we can easily add a
well tested OPP set later, to get the 1.5 GHz back.

Will send a v5 shortly.

Cheers,
Andre



