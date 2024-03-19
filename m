Return-Path: <linux-pm+bounces-5133-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1809888075C
	for <lists+linux-pm@lfdr.de>; Tue, 19 Mar 2024 23:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DD51B22164
	for <lists+linux-pm@lfdr.de>; Tue, 19 Mar 2024 22:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97123A1A8;
	Tue, 19 Mar 2024 22:48:53 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15986364D4;
	Tue, 19 Mar 2024 22:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710888533; cv=none; b=AitBrGMz/SI1EGbz0ypTIpQ1xKYxT7N/cOdje/dtN7GiiAJ/2uAsKebuhp7azMc+FlwKzxtzldTpF6sg/kd8PUIcIpQUE5SN5t9AcQf6u756Fm7sUgU/MB67995a370HILkYH5qmfqWgq7Gs3T1BVbuDdEq4Qaq7JtSKZuj7hEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710888533; c=relaxed/simple;
	bh=kxjEKzdOBmYjrpPcv7qKt9KYCnZ2M4/p1rQW9uyk5T4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Un0T0uQz+lkJolo42DMQeMRnzv992WwDvIR+UT/0yhOJxmO0kziCvH0bZCySKBLIubotE2WvCLRnHm4AnevekwJjjmhqWv5BZiL9aZXCZh1qkAkGJoHzOoZcRvJrLFZoAx+IsYHcTbLmu/zA3tBmcUrASNqfmNR4LwSv8iEr3QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 096D0DA7;
	Tue, 19 Mar 2024 15:49:24 -0700 (PDT)
Received: from minigeek.lan (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC16E3F64C;
	Tue, 19 Mar 2024 15:48:45 -0700 (PDT)
Date: Tue, 19 Mar 2024 22:48:23 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Amit Singh Tomar <amitsinght@marvell.com>
Cc: Yangtao Li <tiny.windzz@gmail.com>, Viresh Kumar <vireshk@kernel.org>,
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Brandon Cheo Fusi
 <fusibrandon13@gmail.com>, Martin Botka <martin.botka@somainline.org>,
 Martin Botka <martin.botka1@gmail.com>
Subject: Re: [PATCH v2 8/8] arm64: dts: allwinner: h616: enable DVFS for all
 boards
Message-ID: <20240319224823.69af2ee4@minigeek.lan>
In-Reply-To: <ee010f39-027c-d874-854d-7f11c5cda78e@marvell.com>
References: <MW4PR18MB5084E8C6D673B73FC208190BC62D2@MW4PR18MB5084.namprd18.prod.outlook.com>
	<20240318105153.2c666647@donnerap.manchester.arm.com>
	<8425a1a2-8453-b705-2c14-a846fa05ae21@marvell.com>
	<20240318230333.72c1b6ed@minigeek.lan>
	<ee010f39-027c-d874-854d-7f11c5cda78e@marvell.com>
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

On Wed, 20 Mar 2024 00:57:22 +0530
Amit Singh Tomar <amitsinght@marvell.com> wrote:

Hi,

> >> Okay, it would be interesting to see results of some benchmark here.  
> > 
> > But why? This is not a performance optimisation, it's adding a missing
> > feature, because the CPU was locked to 1 GHz before, for safety
> > reasons, due to missing thermal and DVFS capability. Now it's able to
> > run at up to 1.5 GHz, as specified.  
> I completely understand, it's not intended for performance optimization.
> 
> > If you are upset about the bold claim, I can just remove it from the
> > commit message, it was just a heads up that we were leaving a lot of
> > performance on the table at the moment.  
> I was merely curious about it, not upset. It could certainly enhance 
> aspects such as memory bandwidth,

Of all the things I would expect the memory bandwidth to stay the same,
as the clock rate of the memory controller did not change.

>  but perhaps not to the extent as 
> suggested. Therefore, rephrasing the commit message should suffice.

I can certainly do that, but you probably missed that small little
number at the end of my benchmark instructions. That tells you that I
indeed measured a 49.8 % performance uplift with the linpack benchmark.
And I would expect anything similarly CPU bound to react in the same
fashion. Please try it yourself, you don't even need this particular
piece of hardware, just some machine with working cpufreq.

Cheers,
Andre

