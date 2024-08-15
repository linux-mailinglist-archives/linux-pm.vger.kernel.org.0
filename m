Return-Path: <linux-pm+bounces-12270-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CFA9530C9
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2024 15:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E979E1C23C03
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2024 13:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CFB18D630;
	Thu, 15 Aug 2024 13:46:30 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C5F7DA9E;
	Thu, 15 Aug 2024 13:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723729590; cv=none; b=gkwCtm1qDnIgYFi1LAeDESUeZUyt5tZdoPfALZa1Z/k6qS5h0Q5zjfWVx2JQkxfTPZvRRcExbG2jkzOxIwqq7U4TK5u5YrbRKXvDuSZdMvhCmxZ3Gmji+sBrVlreNChDeLUUA46D82cFT1FI6f7lKX53IC6aGkpPXBocIDnbbx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723729590; c=relaxed/simple;
	bh=xpa67Wr74Im2iD+qPPKLdhggzJuep5WPCdoIlQ89s5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6GJSHPtnjZ3jHvpbu0RL/gBE3ODpsm2d1ceGbSSF3aJvxyj2D46Yxa+IYyAV/QyrG4NcBCsBBFEq42e9B9zVhnK7GOJ/Z8CiWDqS9QqmNPQ2Y4oz7UP8GBUMZpFPGwISGv83EvkF3MyMrPg8XpeLu298Uk8xyQz6odjWndZmns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34EF914BF;
	Thu, 15 Aug 2024 06:46:54 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A72063F6A8;
	Thu, 15 Aug 2024 06:46:26 -0700 (PDT)
Date: Thu, 15 Aug 2024 14:46:24 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Sibi Sankar <quic_sibis@quicinc.com>, cristian.marussi@arm.com,
	linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org, quic_rgottimu@quicinc.com,
	quic_kshivnan@quicinc.com, johan@kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] pmdomain: arm: Fix debugfs node creation failure
Message-ID: <Zr4GsOndEEMI-6ap@bogus>
References: <20240703110741.2668800-1-quic_sibis@quicinc.com>
 <ZoZ6Pk7NSUNDB74i@bogus>
 <064274c4-3783-c59e-e293-dd53a8595d8e@quicinc.com>
 <Zofvc31pPU23mjnp@bogus>
 <CAPDyKFrESupeNS4BO8TPHPGpXFLsNqLPrUEw3xzr8oh8FsLHeA@mail.gmail.com>
 <Zryxrdodn2Y2xsej@bogus>
 <CAPDyKFqmV7yvMdLjGhDHJN4CFiUun3FXprEk7uGFV_qmn9vA8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPDyKFqmV7yvMdLjGhDHJN4CFiUun3FXprEk7uGFV_qmn9vA8Q@mail.gmail.com>

On Thu, Aug 15, 2024 at 12:46:15PM +0200, Ulf Hansson wrote:
> On Wed, 14 Aug 2024 at 15:31, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Wed, Aug 14, 2024 at 02:38:24PM +0200, Ulf Hansson wrote:
> > >
> > > Sudeep, while I understand your point and I agree with it, it's really
> > > a simple fix that $subject patch is proposing. As the unique name
> > > isn't mandated by the SCMI spec, it looks to me that we should make a
> > > fix for it on the Linux side.
> > >
> >
> > Yes, I did come to the conclusion that this is inevitable but hadn't
> > thought much on the exact solution. This email and you merging the original
> > patch made me think a bit quickly now 😉
> 
> Alright, great!
> 
> >
> > > I have therefore decided to queue up $subject patch for fixes. Please
> > > let me know if you have any other proposals/objections moving forward.
> >
> > The original patch may not work well with the use case Peng presented.
> > As the name and id may also match in their case, I was wondering if we
> > need to add some prefix like perf- or something to avoid the potential
> > clash across power and perf genpds ? I may be missing something still as
> > it is hard to visualise all possible case that can happen with variety
> > of platform and their firmware.
> >
> > In short, happy to have some fix for the issue in some form whichever
> > works for wider set of platforms.
> 
> Okay, so I have dropped the $subject patch from my fixes branch for
> now, to allow us and Sibi to come up with an improved approach.
> 
> That said, it looks to me that the proper fix needs to involve
> pm_genpd_init() in some way, as this problem with unique device naming
> isn't really limited to SCMI. Normally we use an "ida" to get a unique
> index that we tag on to the device's name, but maybe there is a better
> strategy here!?

Yes using "ida" for unique index might work here as well AFAIU. It can be
one of the possible solution for sure.

-- 
Regards,
Sudeep

