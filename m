Return-Path: <linux-pm+bounces-32724-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D22FB2E1FE
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 18:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C1D1166A10
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 16:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16DA3218A7;
	Wed, 20 Aug 2025 16:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="jMFG5Oi6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E3131CA72;
	Wed, 20 Aug 2025 16:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755705936; cv=none; b=M2NItP/LYEm4iBN0Dr6jgvb4EKyw4u8dETd2Hvg5y7UrURQky748VqEHN01YAnopQ8f557VSjX/7M7ohuiKfI5Mf12HuxxySSVgpJoSY0m6ACK4TB7BoXJ1dyrG9Q6CZbWSG2O/Qs2TT3P3Ft78gKvlurLAIErjnqz6l9m1I4hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755705936; c=relaxed/simple;
	bh=tLi1i2Hjn+am75MxC+oHiTFw9L0EkYKb5NA6pnQNh4E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KjMeIkIDMBGlKKH2Xo3vqxVqDO4bh2I5XukOtUK+qL4LE3KxXFrxy9SPpPXHriv3SjDFc3+VgZKtDW8hMGVtG/cyFF9oStUdAALFsLfWNnTujYqx5Rkt/HYRQw0UxScOXLGybhO6ahAfC9QXCGGHVm8AZ6weMph6CBlbCgOeKDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=jMFG5Oi6; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ezW/o6uS99jQL59DxylqAUipNClEc/3fBUjfP8/UYok=; b=jMFG5Oi65R3PcGiNzODTjK/+m5
	jCrJpjrPged7+aBed1Ow5StpOTMIUpOziYu3580mteDR1cQV+VuCjennFJz7T4YLVw1XFtIdyH9IV
	6t3nYKPf4uAwr22LUnQdBTnKAaQ38Ve3aMBBLp/5mx6piGSW89fZGo8v7kx8E4C1EA3gR2L9rHKJV
	kYjiT/fbQ2H+WkwiiQiDkUa8yllkiYdwmBH+sBW6+Kua3fPX1SJuT+Y25+5ekc0OoZxgYuAqMAW49
	tdbA8qLRsPH/FYKkvtVrrLAN8f/rIKxutYc6eokl2aLn/EpiGHR6SFnm4LhU7iAKjlgo+A/mtgHsP
	Xvu4kyvQ==;
Date: Wed, 20 Aug 2025 18:05:23 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>,
 Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] power: supply: Add bd718(15/28/78) charger driver
Message-ID: <20250820180523.170acbea@akair>
In-Reply-To: <3dd9aa2d-a318-4a94-b53f-11dac139ccb2@gmail.com>
References: <20250816-bd71828-charger-v1-0-71b11bde5c73@kemnade.info>
	<20250816-bd71828-charger-v1-2-71b11bde5c73@kemnade.info>
	<bf82cd81-bcc7-4929-aa84-b749533d5b95@kernel.org>
	<20250817101121.19a86716@akair>
	<bbd17f22-8834-42d8-a109-971bdd2e0fa1@kernel.org>
	<e8955365-73c0-4c7a-a579-0ee6940340b2@gmail.com>
	<20250818103600.0c3a015d@akair>
	<3dd9aa2d-a318-4a94-b53f-11dac139ccb2@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Am Mon, 18 Aug 2025 12:32:43 +0300
schrieb Matti Vaittinen <mazziesaccount@gmail.com>:

> > Kobo kernels have these tables as part of the driver, the right one is
> > selected via an index in the NTX_HWCONFIG blob provided by the
> > bootloader to the kernel. So that is not necessarily a problem. It
> > could be translated into dt.
> > 
> > static int ocv_table_28_PR284983N[23] = {
> >          //4200000, 4162288, 4110762, 4066502, 4025265, 3988454, 3955695, 3926323, 3900244, 3876035, 3834038, 3809386, 3794093, 3782718, 3774483, 3768044, 3748158, 3728750, 3704388, 3675577, 3650676, 3463852, 2768530
> >          4200000, 4166349, 4114949, 4072016, 4031575, 3995353, 3963956, 3935650, 3910161, 3883395, 3845310, 3817535, 3801354, 3789708, 3781393, 3774994, 3765230, 3749035, 3726707, 3699147, 3671953, 3607301, 3148394
> > };
> > 
> > static int vdr_table_h_28_PR284983N[23] = {
> >          //100, 100, 101, 101, 102, 102, 103, 103, 104, 104, 105, 106, 106, 107, 107, 108, 108, 109, 110, 112, 124, 157, 786
> >          100, 100, 101, 102, 102, 105, 106, 107, 112, 108, 108, 105, 105, 108, 110, 110, 110, 111, 112, 114, 120, 131, 620
> > };
> > 
> > static int vdr_table_m_28_PR284983N[23] = {
> >          //100, 100, 101, 101, 102, 102, 103, 103, 104, 104, 105, 102, 100, 100, 102, 103, 103, 105, 108, 112, 124, 157, 586
> >          100, 100, 103, 106, 110, 114, 115, 119, 122, 122, 115, 113, 112, 114, 117, 124, 126, 123, 122, 126, 140, 156, 558
> > };
> > 
> > static int vdr_table_l_28_PR284983N[23] = {
> >          //100, 100, 103, 105, 110, 110, 113, 112, 112, 112, 105, 110, 110, 111, 122, 131, 138, 143, 150, 166, 242, 354, 357
> >          100, 100, 105, 110, 114, 117, 121, 125, 126, 122, 116, 114, 115, 118, 124, 132, 140, 148, 156, 170, 210, 355, 579
> > };
> > 
> > static int vdr_table_vl_28_PR284983N[23] = {
> >          //100, 100, 103, 106, 108, 111, 114, 117, 118, 115, 108, 106, 108, 113, 115, 114, 118, 125, 144, 159, 204, 361, 874
> >          100, 100, 109, 115, 118, 123, 127, 130, 140, 139, 134, 130, 128, 138, 140, 150, 154, 164, 178, 204, 271, 362, 352
> > };  
> 
> Oh, good. If we can get the right battery parameters from the vendor 
> driver, then the main problem gets solved. Although, multiple sets of 
> different VDR tables probably means, that there are variants with 
> different types of battery out there. I assume the bootloader can 
> somehow detect the battery type to provide the correct blob?

Historically the Kobo devices ship said HWCONFIG blob apparently to use
the same kernel on multiple devices, then devicetree was invented and
used what was available. There is then a 
                switch(gptHWCFG->m_val.bBattery) {
...
                                ocv_table_default =
                                ocv_table_28_PR284983N;



So that all only means there
are several different batteries amoung the devices supported by that
kernel. From my guts feeling I wonder if the is_relaxed stuff is
properly working and I wonder whether a Kalman filter would give better
results, but that is all something for the future.

Regards,
Andreas

