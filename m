Return-Path: <linux-pm+bounces-32506-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3B1B29C62
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 10:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC4647AA846
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 08:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692992C15A3;
	Mon, 18 Aug 2025 08:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="xWVscVB+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B212E8882;
	Mon, 18 Aug 2025 08:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755506174; cv=none; b=B1METy1tLPNRHp5ZQ7cwMuJQz1xVsYfxIfG1MT900ix5cF1SRljDcPRNvqmpTv4RZLAqMNATBwNwfWbfMrtmZXVVWQh6tRW+PRcFQjPJQ0LHkE8kSmavABG0pbCYVG+WzP3WW4Nllwj8est3CIrTnzdyEg7ntIVRGljxqhgDzIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755506174; c=relaxed/simple;
	bh=QeVAQag6ztkKUKJJ0C2/50dQ0rrA9knXp8myGX40y+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r2QVzL+MwVvR9HqVNXM9FwBA1OpCejhAOUkZP0DunGEpi55PgJyKHE+uwz1xN6apPZuPCblK5Pzc+rHnZ30mcTYL42CH3C+Xxak++ui5vU5v6MLTedFoG+u2AUkT9R9h8lhZygKt/vQvoiewazgzba5+1zQw92nbAlmIjVZ4+LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=xWVscVB+; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=1KZckO++ELDKqo+XKW18f12FZQAdjW9bBCW3YHfnxN0=; b=xWVscVB+lVOc+nHH8k6JPrX1Xo
	nizgyxDbmOfACo77EBnFsvnwzDJL9ERxK5382O3ax1Uwf5h8+h23qpgCVFJ5iSasFy6JpwB7wLbIA
	86J123TDg+kM+HMlp91MzopZvN3AY+ZDFhEdiKvMKS+q32rhsOCngn9Gra/VIoHEh3cdQbHqaXI5D
	N/T4m/zz71gc1Fg251NBEYfQWNHy0JHFJsFIKtraNhm29MbK/ZnSzpnrM499FOzdxtdpx5C/BkdN8
	1LNTNSOEbXiQXt/K3P5GSVs8H/38xigjBHhu6caoN8egFuMNTHrzcEI5qXC3edGpAYxAfcQjz0INU
	xdfYMNdw==;
Date: Mon, 18 Aug 2025 10:36:00 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>,
 Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] power: supply: Add bd718(15/28/78) charger driver
Message-ID: <20250818103600.0c3a015d@akair>
In-Reply-To: <e8955365-73c0-4c7a-a579-0ee6940340b2@gmail.com>
References: <20250816-bd71828-charger-v1-0-71b11bde5c73@kemnade.info>
	<20250816-bd71828-charger-v1-2-71b11bde5c73@kemnade.info>
	<bf82cd81-bcc7-4929-aa84-b749533d5b95@kernel.org>
	<20250817101121.19a86716@akair>
	<bbd17f22-8834-42d8-a109-971bdd2e0fa1@kernel.org>
	<e8955365-73c0-4c7a-a579-0ee6940340b2@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Matti,

Am Mon, 18 Aug 2025 09:34:02 +0300
schrieb Matti Vaittinen <mazziesaccount@gmail.com>:

> On 17/08/2025 11:13, Krzysztof Kozlowski wrote:
> > On 17/08/2025 10:11, Andreas Kemnade wrote:  
> >> Am Sun, 17 Aug 2025 07:58:35 +0200
> >> schrieb Krzysztof Kozlowski <krzk@kernel.org>:
> >>  
> >>> On 16/08/2025 21:19, Andreas Kemnade wrote:  
> >>>> Add charger driver for ROHM BD718(15/28/78) PMIC charger block.
> >>>> It is a stripped down version of the driver here:
> >>>> https://lore.kernel.org/lkml/dbd97c1b0d715aa35a8b4d79741e433d97c562aa.1637061794.git.matti.vaittinen@fi.rohmeurope.com/  
> >>>
> >>> Why are you duplicating the driver? Why original cannot be used?
> >>>
> >>>  
> >> I am not duplicating the driver. That patch series never went in. I am
> >> stripping it down to let things go in step by step. I have also talked
> >> with Sebastian about this. And he also prefers a step by step approach
> >> to have it more easily reviewed.
> >> I also do not have the infrastructure to test things like capacity
> >> degradation over time. There is non-trivial rebasing work involved, so
> >> I even do not feel confident submitting such at all.  
> > 
> > 
> > OK, but if you refer to other work, then also please explain why this is
> > stripped down.  
> 
> First of all, thanks a ton Andreas for continuing this work which I 
> never managed to finish!
> 
> Battery fuel-gauging with coulomb-counter is hard. I believe we can get 
> some results with the original RFC code - but it requires quite a bit of 
> effort. AFAIR, there are (at least) 4 "pain-points".
> 
Newest rebase I have is for 6.15. Yes, capacity calculation is hard.
Even the ugly-patched Kobo vendor driver has some surprises. It once
says battery is empty, then I put in charger, rebooted into debian,
Vbat = 4.1V even with charger detached.
I think the fuel-gauging stuff itself should go in a step by step
approach. I am wondering how sophisticated other drivers and hardware
are.
The rn5t618/rc5t619 mainline driver just uses raw coloumb counter
values and there is no compensation for anything. Some hardware does
more sophisticated things itself.

> 1. Lack of persistent storage for charging cycles. For proper 
> fuel-gauging, we would need information about battery aging. The PMIC 
> has nothing to store the charging cycle counter when power is cut. 
> That'd require some user-space solution which could store the cycle 
> information in a persistent storage && tell it to the driver at 
> start-up. I don't know if there is open-source userspace solution for this.
> 
I do not think so, and you will have trouble if you have dual-boot or
from some alternative boot media involved. The BQ27000 stuff has afaik
hw calculation of battery capacity to deal with this.

> 2. Battery parameters. This is the real problem. In order to make the 
> fuel-gauging work, the driver needs proper battery information. I wrote 
> the original driver to be able to retrieve the data from a 
> static-battery DT node - but I have a feeling the device-vendor using 
> this PMIC provided battery-info via module parameters. I am not sure if 
> those parameters can be recovered - and as Andreas said, defining them 
> is not easy task. By minimum we would need the OCV-tables and some aging 
> + temperature degradation effects (or VDR-tables which ROHM uses for 
> it's zero-correction algorithm - but AFAIR, defining those VDR tables is 
> not widely known information).
>
Kobo kernels have these tables as part of the driver, the right one is
selected via an index in the NTX_HWCONFIG blob provided by the
bootloader to the kernel. So that is not necessarily a problem. It
could be translated into dt.

static int ocv_table_28_PR284983N[23] = {
        //4200000, 4162288, 4110762, 4066502, 4025265, 3988454, 3955695, 3926323, 3900244, 3876035, 3834038, 3809386, 3794093, 3782718, 3774483, 3768044, 3748158, 3728750, 3704388, 3675577, 3650676, 3463852, 2768530
        4200000, 4166349, 4114949, 4072016, 4031575, 3995353, 3963956, 3935650, 3910161, 3883395, 3845310, 3817535, 3801354, 3789708, 3781393, 3774994, 3765230, 3749035, 3726707, 3699147, 3671953, 3607301, 3148394
};

static int vdr_table_h_28_PR284983N[23] = {
        //100, 100, 101, 101, 102, 102, 103, 103, 104, 104, 105, 106, 106, 107, 107, 108, 108, 109, 110, 112, 124, 157, 786
        100, 100, 101, 102, 102, 105, 106, 107, 112, 108, 108, 105, 105, 108, 110, 110, 110, 111, 112, 114, 120, 131, 620
};

static int vdr_table_m_28_PR284983N[23] = {
        //100, 100, 101, 101, 102, 102, 103, 103, 104, 104, 105, 102, 100, 100, 102, 103, 103, 105, 108, 112, 124, 157, 586
        100, 100, 103, 106, 110, 114, 115, 119, 122, 122, 115, 113, 112, 114, 117, 124, 126, 123, 122, 126, 140, 156, 558
};

static int vdr_table_l_28_PR284983N[23] = {
        //100, 100, 103, 105, 110, 110, 113, 112, 112, 112, 105, 110, 110, 111, 122, 131, 138, 143, 150, 166, 242, 354, 357
        100, 100, 105, 110, 114, 117, 121, 125, 126, 122, 116, 114, 115, 118, 124, 132, 140, 148, 156, 170, 210, 355, 579
};

static int vdr_table_vl_28_PR284983N[23] = {
        //100, 100, 103, 106, 108, 111, 114, 117, 118, 115, 108, 106, 108, 113, 115, 114, 118, 125, 144, 159, 204, 361, 874
        100, 100, 109, 115, 118, 123, 127, 130, 140, 139, 134, 130, 128, 138, 140, 150, 154, 164, 178, 204, 271, 362, 352
};


> 3. ADC offset. The coulomb-counter operates by measuring and integrating 
> voltage-drop over known Rsense resistor. If (when) the ADC has some 
> measurement offset, it will produce a systematic error which accumulates 
> over time. Hence a calibration is required. The BD718[15/28] have an ADC 
> calibration routine, but AFAIR, there was some limitations. I don't 
> remember all the dirty details, but it probably didn't work too well if 
> current consumption was varying during the calibration(?). I think 
> running the calibration is not supported by the driver.
> 
Yes, that is a pain.

[...]
> TLDR; It'd be hard to do accurate fuel-gauging without proper
battery 
> information and some extra work. We could probably get some rough 
> estimates about the capacity - but implementing it only makes sense if 
> there is someone really using it. Charger control on the other hand 
> makes some sense. [It at least allows Andreas to charge his eReader 
> using solar-power when on a biking hiking! How cool is that? ;)]
> 
And using a hub dynamo.
For now I have a user space script to help me, probably moving that into
input_current_limit.

But it is really nice to see if things are charging or are discharging
unusually fast.
It is a pity that such power sources are not taken into consideration
in standards or charges much. Around 20 year ago or something, I could
just attach a Thinkpad to a solar panel, there was a smooth transition
between discharging a litte (displaying battery discharging time in
weeks) and more ore less charging. Today often the recommendation is to
put somehow another battery in between. But that is technically
somehow nonsense. You need a buffer for power and another one in the
row.

Regards,
Andreas

