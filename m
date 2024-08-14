Return-Path: <linux-pm+bounces-12207-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AD3951BE4
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 15:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34BCC1F24B11
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 13:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795721B1518;
	Wed, 14 Aug 2024 13:31:34 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4CE1B143C;
	Wed, 14 Aug 2024 13:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723642294; cv=none; b=DV8erJFMHyhAbVJ516bEN7XVCsQ5mJEB+UJzWdOZH3DhUVfxxtmXLrF2fuFsPCRz9TwB9BwuZCC3Zfb33uE/WMrT+YiGmpR4BBpSp7Dvyc9QNd9MMFDc9qHUFIpiRbraaYiatk5EfViW2ueCBpXCRV3yzJoImpeHrBuWCJPWpUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723642294; c=relaxed/simple;
	bh=3n3TsOeFrLkJU7atsRGpI4Lvu85dnoqAqBQEURmF/F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbbKz0SmmFOjZsJNE5eyqbcDib2ErpP1EB/SKYv3aQZ8FJjMfqpgvhw4BiaAYlexffJKEgOVwsx57nNQiyf2gzm2xkMdbyU1oQkvocdVMELJOiGKuID6swsXndqE1hIx/Xz/4XbX48KFsEtLB3bb/BcNvrOlGfdc8DAXnZ0QW+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6AE1DA7;
	Wed, 14 Aug 2024 06:31:56 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8248C3F73B;
	Wed, 14 Aug 2024 06:31:28 -0700 (PDT)
Date: Wed, 14 Aug 2024 14:31:25 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Sibi Sankar <quic_sibis@quicinc.com>, cristian.marussi@arm.com,
	linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org, quic_rgottimu@quicinc.com,
	quic_kshivnan@quicinc.com, johan@kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] pmdomain: arm: Fix debugfs node creation failure
Message-ID: <Zryxrdodn2Y2xsej@bogus>
References: <20240703110741.2668800-1-quic_sibis@quicinc.com>
 <ZoZ6Pk7NSUNDB74i@bogus>
 <064274c4-3783-c59e-e293-dd53a8595d8e@quicinc.com>
 <Zofvc31pPU23mjnp@bogus>
 <CAPDyKFrESupeNS4BO8TPHPGpXFLsNqLPrUEw3xzr8oh8FsLHeA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPDyKFrESupeNS4BO8TPHPGpXFLsNqLPrUEw3xzr8oh8FsLHeA@mail.gmail.com>

On Wed, Aug 14, 2024 at 02:38:24PM +0200, Ulf Hansson wrote:
>
> Sudeep, while I understand your point and I agree with it, it's really
> a simple fix that $subject patch is proposing. As the unique name
> isn't mandated by the SCMI spec, it looks to me that we should make a
> fix for it on the Linux side.
>

Yes, I did come to the conclusion that this is inevitable but hadn't
thought much on the exact solution. This email and you merging the original
patch made me think a bit quickly now 😉

> I have therefore decided to queue up $subject patch for fixes. Please
> let me know if you have any other proposals/objections moving forward.

The original patch may not work well with the use case Peng presented.
As the name and id may also match in their case, I was wondering if we
need to add some prefix like perf- or something to avoid the potential
clash across power and perf genpds ? I may be missing something still as
it is hard to visualise all possible case that can happen with variety
of platform and their firmware.

In short, happy to have some fix for the issue in some form whichever
works for wider set of platforms.

--
Regards,
Sudeep

