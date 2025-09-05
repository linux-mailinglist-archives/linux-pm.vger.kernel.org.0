Return-Path: <linux-pm+bounces-34009-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F83B461A9
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 20:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33AC95C47F9
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 18:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4819636CE1A;
	Fri,  5 Sep 2025 18:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5DIzv/G"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2379036CDF5
	for <linux-pm@vger.kernel.org>; Fri,  5 Sep 2025 18:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757095406; cv=none; b=dCClVNdXrrv5FTxhj6VYyF+KRFLH/vaAz8JZHmRzVdWs4cVN/dZkFzGsJnmH2JgqUasGHbdYWyvYY6w1ZxCtzXzbVHNWE/AnHl9CMaNxKlkwIwDM1AzbFjF3aK4N0Sgvbuis4CxiPa6GMiOKDypr9yC6Xcjbm+6uM1H6tKZarQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757095406; c=relaxed/simple;
	bh=aX6G1a/+0EOsKEFDFSF/08ysGp022PYE1EvRNGxAVVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XOlDBdSiR3FI3i6z4UD95we1vFOSOzEUSGv/96xNvOaInYnWg8aVdAA3PGC8MIEbSCG9emSUZiewl2IieVDyjgPeiHaybp7uC7k5Rsb8jl/upr98IgDoaZlWMAQYiZdBCDfBeB4W7zAfScooenUbxNusFbjGvpuAFPfWrxqTL1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5DIzv/G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8D9C4CEF1;
	Fri,  5 Sep 2025 18:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757095405;
	bh=aX6G1a/+0EOsKEFDFSF/08ysGp022PYE1EvRNGxAVVo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q5DIzv/G7hTbMQNXnE7yUNud5rvXsd6DpAbCVQp3AiYbjInVXQZyVFH7SxY6Xlb+o
	 a9jR1DC3c7VGUjLGAJt3aue19Lef7XNvr8udzqFqVxcNHbgSVPnw8no1bk5djxAKuT
	 60rhF8O+DSZu9vyt9Av5LK8xMG8YAdpqq/PW0ZasS/b4x2vyYTIl/Y2GHl/clUaoic
	 R/GjlOF9MlLdPqWCCtvzhVTYy28egtk8FMDvxltM7/L0DB5LFicqJ/n2HdpVNWebMd
	 01GypzGAkUYlbnLGkBRJfFbPnYCpLDlcf6tcwMsgX0qZC3DYQlfc/FznBRhayw75Xm
	 g63r5/NC88yhw==
Message-ID: <ee05a9de-07e6-44f2-a6e1-1aed8de989e5@kernel.org>
Date: Fri, 5 Sep 2025 13:03:24 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] MECHREVO Yilong15Pro GM5HG7A: lid switch causing unwanted
 s2idle wakeups
To: aprilgrimoire <aprilgrimoire@proton.me>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: <6ww4uu6Gl4F5n6VY5dl1ufASfKzs4DhMxAN8BuqUpCoqU3PQukVSVSBCl_lKIzkQ-S8kt1acPd58eyolhkWN32lMLFj4ViI0Tdu2jwhnYZ8=@proton.me>
 <06f0c531-2cb6-4a1a-a716-406b4f5f9676@kernel.org>
 <MawTZCnf5jVqp47YcxRrH21nl0rN8O78_my4TxiZ3tFoNxuP568eHxnEH5-VIMa6DtNbHdXytnpRgVyay-UydMK5tbYe4-TG8e2BYEky5hc=@proton.me>
 <7a3a3a35-27d3-4b46-b297-475deda04656@kernel.org>
 <lyy4riGTLOpvYTPUeUx6krjnYdeE8iYbWRrLOJLOChOKMcys00nhNWJ_JD8V8kkVQk87ktMK8w7BAEosOs3KGipyHlvkvQ0_j6cipUfxYtA=@proton.me>
 <0fb5a890-63f0-412b-8d88-79b40e2c564b@kernel.org>
 <El5fBf0AkhefzH0LWKyMF3vOCNsHYBCEwxtvXD-tJfLGAFCeJ5ZVbgZE6ibf-KfMxtlkTwr3g1-feqSgfcafGzVGjulc-8QggWHHoJlRDNY=@proton.me>
 <5369f2b5-dba1-4b25-a093-7aa79c578975@kernel.org>
 <wkUEC8nqZzIcVXalYzsLi_YheAs0Tw07ug-73PAqUwKmquJr89CPnQKwBImSQLcDABIk4tfWPLCPKa00vG1jH8NpiH5f4yXVATYakltJAQI=@proton.me>
 <5f958462-5fc1-4837-b5e1-65c0ad8badcd@kernel.org>
 <v02CD0KPkF5AAcf8UtMCnQtlQ6-UL3YfDuqg-nLJuD1aDIvmY3DiKi3Bgg_6Ay2wY1dQpRPwYdo6qMQir0urvYQ3ch3xFhEmKexz5cmeDg8=@proton.me>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <v02CD0KPkF5AAcf8UtMCnQtlQ6-UL3YfDuqg-nLJuD1aDIvmY3DiKi3Bgg_6Ay2wY1dQpRPwYdo6qMQir0urvYQ3ch3xFhEmKexz5cmeDg8=@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/2025 9:51 PM, aprilgrimoire wrote:
>> Can you double-confirm that with IRQ1 disabled that you still get GPIO0
>> for keyboard wakeup specifically?
> 
> Sure!
> 
> https://paste.gentoo.zip/CSE5LMA6

Thanks.  I saw you sent a patch.  Directionally I think that's the right 
move for what you've shared.  All the sources are marking GPIO 0 and IRQ 
1 as active (presumably because of how their EC works), and IRQ1 is 
definitely spurious.

I left you some comments on that patch that you can fix in a v2.

But as for your lid causing wakeups, there are three options.

1) Request the vendor to change the firmware so that it doesn't behave 
this way.
2) Come up with a filtering quirk mechanism in the kernel somewhere to 
put the system back to HW sleep instead of breaking the s2idle loop.
3) Come up with a filtering mechanism somewhere in userspace to put the 
system back into suspend.

I don't really think idea 2 is very scalable though, so I would say it's 
best to ask for a firmware fix, and if that isn't viable then come up 
with a workaround in userspace.

