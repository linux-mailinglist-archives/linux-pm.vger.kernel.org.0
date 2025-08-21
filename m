Return-Path: <linux-pm+bounces-32782-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A37B3B2F0AB
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 10:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBC4BA2012B
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 08:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A682EA168;
	Thu, 21 Aug 2025 08:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="wr5WYWMs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2F72EA147;
	Thu, 21 Aug 2025 08:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755763845; cv=none; b=KWWyvH96NQM1oFC0Rwj2TDqiYrw2mU0gdKvAQXzNcM4KkdCsZUsJ8Um1zTHx7oeK6fORAAnjZT7KtilMhjjbsWXYrq7IaHNhXH3lgq0y2/lvp7ewx3vQZdB3xs69Ex8qsfK4LUHNBnGLIrAYbGuGlPHjRIJi2+JTOYhKPSdAMEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755763845; c=relaxed/simple;
	bh=/V8isM0ZKMRHjabJH8c4dqaTU2r3gmc4a+aIFeO7cGY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mbcwe+wWj8qV5+rij7BZW6Vq6XRlibeyq0A0JcOm6M9xHCuz3EPY5aC5NqqbUnXvpNmqihbz0aZhuen9jGGMqyffTAB1anKEJT8kOfFJQAh6HjMAvnvZVyKmZQEP0VFeHK4Sqrl9iIO854f/CKjeOLHSfXnbsYB3QLqJD0AV7yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=wr5WYWMs; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=eA/tikPlv56QYDz+5XgTBzNjPIWxLn/j3F8xjQ0hJDE=; b=wr5WYWMsNLBL4YOW+UXeGmyrqe
	u0W03YpZn5qmTsc09xVZFjxoL59uleP8K3QQ3MK8sOLh/KialhyCcz+pRXoksH+SInGqAGUSlSM0T
	hD3hFAS3/EShj/W8RlG16LVc8AsrgAkV0UtmpZECR45R2nWIKZjrYi++HbdVpSp7wSdgWhDMYs7+z
	o8AmVmQPrI/8Pi4V9ARjgP/5aw5CUDBFU0JLmKjlTMORl8SrtLDEj9hSOsKSGegqHRjwaMmtl1OM1
	ZWHYJJy3+FDAdeA3mCjwnDnKud2tYhFQifSW9g8cSgPN0V36CUVGd6GN6biqZ/suTA+274CUOtvuW
	ff1kFHSA==;
Date: Thu, 21 Aug 2025 10:10:27 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>,
 Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] power: supply: Add bd718(15/28/78) charger driver
Message-ID: <20250821101027.16747c23@akair>
In-Reply-To: <dc2a9ea1-29fd-4ae8-b414-ca3acb0d8ad3@gmail.com>
References: <20250816-bd71828-charger-v1-0-71b11bde5c73@kemnade.info>
	<20250816-bd71828-charger-v1-2-71b11bde5c73@kemnade.info>
	<bf82cd81-bcc7-4929-aa84-b749533d5b95@kernel.org>
	<20250817101121.19a86716@akair>
	<bbd17f22-8834-42d8-a109-971bdd2e0fa1@kernel.org>
	<e8955365-73c0-4c7a-a579-0ee6940340b2@gmail.com>
	<20250818103600.0c3a015d@akair>
	<3dd9aa2d-a318-4a94-b53f-11dac139ccb2@gmail.com>
	<20250820180523.170acbea@akair>
	<dc2a9ea1-29fd-4ae8-b414-ca3acb0d8ad3@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Am Thu, 21 Aug 2025 08:31:06 +0300
schrieb Matti Vaittinen <mazziesaccount@gmail.com>:

> On 20/08/2025 19:05, Andreas Kemnade wrote:
> > Am Mon, 18 Aug 2025 12:32:43 +0300
> > schrieb Matti Vaittinen <mazziesaccount@gmail.com>:
> >   
> >>> Kobo kernels have these tables as part of the driver, the right one is
> >>> selected via an index in the NTX_HWCONFIG blob provided by the
> >>> bootloader to the kernel. So that is not necessarily a problem. It
> >>> could be translated into dt.
> >>>
> >>> static int ocv_table_28_PR284983N[23] = {
> >>>           //4200000, 4162288, 4110762, 4066502, 4025265, 3988454, 3955695, 3926323, 3900244, 3876035, 3834038, 3809386, 3794093, 3782718, 3774483, 3768044, 3748158, 3728750, 3704388, 3675577, 3650676, 3463852, 2768530
> >>>           4200000, 4166349, 4114949, 4072016, 4031575, 3995353, 3963956, 3935650, 3910161, 3883395, 3845310, 3817535, 3801354, 3789708, 3781393, 3774994, 3765230, 3749035, 3726707, 3699147, 3671953, 3607301, 3148394
> >>> };
> >>>
> >>> static int vdr_table_h_28_PR284983N[23] = {
> >>>           //100, 100, 101, 101, 102, 102, 103, 103, 104, 104, 105, 106, 106, 107, 107, 108, 108, 109, 110, 112, 124, 157, 786
> >>>           100, 100, 101, 102, 102, 105, 106, 107, 112, 108, 108, 105, 105, 108, 110, 110, 110, 111, 112, 114, 120, 131, 620
> >>> };
> >>>
> >>> static int vdr_table_m_28_PR284983N[23] = {
> >>>           //100, 100, 101, 101, 102, 102, 103, 103, 104, 104, 105, 102, 100, 100, 102, 103, 103, 105, 108, 112, 124, 157, 586
> >>>           100, 100, 103, 106, 110, 114, 115, 119, 122, 122, 115, 113, 112, 114, 117, 124, 126, 123, 122, 126, 140, 156, 558
> >>> };
> >>>
> >>> static int vdr_table_l_28_PR284983N[23] = {
> >>>           //100, 100, 103, 105, 110, 110, 113, 112, 112, 112, 105, 110, 110, 111, 122, 131, 138, 143, 150, 166, 242, 354, 357
> >>>           100, 100, 105, 110, 114, 117, 121, 125, 126, 122, 116, 114, 115, 118, 124, 132, 140, 148, 156, 170, 210, 355, 579
> >>> };
> >>>
> >>> static int vdr_table_vl_28_PR284983N[23] = {
> >>>           //100, 100, 103, 106, 108, 111, 114, 117, 118, 115, 108, 106, 108, 113, 115, 114, 118, 125, 144, 159, 204, 361, 874
> >>>           100, 100, 109, 115, 118, 123, 127, 130, 140, 139, 134, 130, 128, 138, 140, 150, 154, 164, 178, 204, 271, 362, 352
> >>> };  
> >>
> >> Oh, good. If we can get the right battery parameters from the vendor
> >> driver, then the main problem gets solved. Although, multiple sets of
> >> different VDR tables probably means, that there are variants with
> >> different types of battery out there. I assume the bootloader can
> >> somehow detect the battery type to provide the correct blob?  
> > 
> > Historically the Kobo devices ship said HWCONFIG blob apparently to use
> > the same kernel on multiple devices, then devicetree was invented and
> > used what was available. There is then a
> >                  switch(gptHWCFG->m_val.bBattery) {
> > ...
> >                                  ocv_table_default =
> >                                  ocv_table_28_PR284983N;
> > 
> > 
> > 
> > So that all only means there
> > are several different batteries amoung the devices supported by that
> > kernel.  
> 
> Ah. So you believe the other batteries are used on other devices which 
> run the same kernel. Makes sense.
> 
> > From my guts feeling I wonder if the is_relaxed stuff is
> > properly working and I wonder whether a Kalman filter would give better
> > results, but that is all something for the future.  
> 
> I believe your experience is stronger than mine (also) here :) I don't 
> really know the theory behind the 'relaxed battery' (or much of other 
> battery chemistry stuff). I was merely trusting the inventions of the HQ 
> engineers, who told me that the OCV tables can be used to adjust the 
> coulomb counter when the battery is 'relaxed'. 'Relaxed' here meaning 
> that it has not been charged (or a lot of current has not been drawn 
> from it) recently. AFAIR, most of the PMIC models had some hardware 
> support for detecting if the battery is in 'relaxed' state.
> 
I am also no battery chemistry expert. But I have looked a lot at
battery voltage behavior for various reasons e.g. for simple things
like: does my charger behave? I do not believe in
in the concept of a boolean is_relaxed. You can always know something
about battery state by doing something like a table_lookup(vbat -
some_factor * ibat)
Depending on situation you have different accuracy. Your battery will
probably not be empty if e.g. your voltage is at 3.9V and you are not
doing excessive charging. I have seen many surprises. My pinephone
sometimes suddenly went off with battery state like 40%. I personally
feel more confident, if I can additionally see the battery voltage.
I have not debugged such issues much yet.

> I admit it sounds like somewhat uncertain approach. I'd love to hear how 
> you think the filter would help. I suppose you think of applying some 
> filtering to the CC correction? Eg, 'smoothen' the CC resetting based on 
> relaxed OCV, by applying some filtering to the correction values? Sounds 
> cool! But... It does also sound the analysis about the impact of the 
> filtering will be hard.

The problems to solve look a bit like problems in inertial navigation
and there Kalman filters are used. There you have e.g. gyroscopes to
determine the rate of turn, producing drift like a coloumb counter.
Accelerometers can show your orientation if things are "relaxed" so not
much acceleration besides gravity. Magnetometers can be "unrelaxed" by
some magnetic disturbance.

The basic point is you can put the accuracy into the model. So you can
use the information like battery capacity can be estimated by
looking voltage/current by +/- 15%, so something produced by looking
at the gauge cannot be out of that range. On the other hand capacity can
not change faster than fuel gauge + estimated drift can produce.

You can spend a life time on optimizing such filters. The question is
how easily you can improve something by using them. The analysis of the
impact can be doing a bit more subjective by looking at how sane the
capacity display behaves, and whether there are less surprises.
More objectively, you can of course relax the battery as much as
possible and check if there are no illogical capacity changes or do
well defined charging/discharging and look what happens to see whether
capacity was correct.

Regards,
Andreas

