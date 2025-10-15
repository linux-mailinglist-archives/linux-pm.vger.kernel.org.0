Return-Path: <linux-pm+bounces-36126-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFB3BDCA1C
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 07:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3082E188DB7F
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 05:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF64145B3F;
	Wed, 15 Oct 2025 05:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HJEvdX9a"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9202CE555
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 05:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760507209; cv=none; b=dqTOjwIvM7mT1Hs6CGlZNszr9hnk9CCcsswmCuGjuV8PROo4HTBtr1oDSTPKDG8LWgZ5uWIVFybVkmxM2Y4fI/yXUgqe2Y72lDL0rouZ2VgZgGRISYnmmB2F5JyDX6YrJipGPObvphuPlCLTKb91dLWRxLwu7m7DiwIhVdTlgIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760507209; c=relaxed/simple;
	bh=4o/AIluxL5bylaEM2NTY4++CTKRGyt5DbbyMBpi5FW0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHm8A35++5UlhOdm2SgfR4ZkshdQJ3wjFSuWo8fFp37L1WXRqRga6ewtHlwyh8EYqm2ObgJ/RrttdDpj0lqpdvotOsKmKGxbhQx68bLmiwt+B3uYFpjYqfO7wkMAo6pLV7W+7nr1llEi2yiXvfTAUv8xFVvuAy4BFgvIJ5sLsuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HJEvdX9a; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59F5kgaW1327149;
	Wed, 15 Oct 2025 00:46:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1760507202;
	bh=cd4fot0vc2ArBNVBL+srbZEPrL+OVTa8Pinp08MojuI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=HJEvdX9aXfFPkCrVfNRHUPRcX8B4QVqmetghS6jfFbD0zvqTxBZ44zd0eHO+upN6N
	 R19g2BGhAUBAi+AX/2V24O7CegPkwZ0Pr5x549br1VeADnyuFw9gbeQoTZuyHXxC8X
	 4INuqzIav9YFTUt/eVZsP71ck6Efy3QweojVrpJo=
Received: from DLEE213.ent.ti.com (dlee213.ent.ti.com [157.170.170.116])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59F5kgSG997651
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 15 Oct 2025 00:46:42 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Oct
 2025 00:46:42 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Oct 2025 00:46:42 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59F5kevD1410268;
	Wed, 15 Oct 2025 00:46:41 -0500
Date: Wed, 15 Oct 2025 11:16:40 +0530
From: Dhruva Gole <d-gole@ti.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Kaushlendra Kumar <kaushlendra.kumar@intel.com>, <pavel@kernel.org>,
        <gregkh@linuxfoundation.org>, <dakr@kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] PM: Introduce CALL_PM_OP macro to reduce code duplication
Message-ID: <20251015054640.g2mjf4dccbn2tcma@lcpd911>
References: <20250919124437.3075016-1-kaushlendra.kumar@intel.com>
 <CAJZ5v0iXAO6Z1t-LeGgutsJRbfL7+Xtszq0h_pG+QFfPbfET7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iXAO6Z1t-LeGgutsJRbfL7+Xtszq0h_pG+QFfPbfET7Q@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Oct 13, 2025 at 20:56:40 +0200, Rafael J. Wysocki wrote:
> On Fri, Sep 19, 2025 at 2:46 PM Kaushlendra Kumar
> <kaushlendra.kumar@intel.com> wrote:
> >
> > Add CALL_PM_OP macro to eliminate repetitive code patterns in power
> > management generic operations. Replace identical driver PM callback
> > invocation logic across all pm_generic_* functions with a single
> > macro that handles the NULL pointer checks and function calls.
> >
> > This reduces code duplication significantly while maintaining the
> > same functionality and improving code maintainability.
> >
> > Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> > ---
> >  drivers/base/power/generic_ops.c | 85 ++++++++++----------------------
> >  1 file changed, 25 insertions(+), 60 deletions(-)
> >
> > diff --git a/drivers/base/power/generic_ops.c b/drivers/base/power/generic_ops.c
> > index 6502720bb564..c4fc802b8c65 100644
> > --- a/drivers/base/power/generic_ops.c
> > +++ b/drivers/base/power/generic_ops.c
> > @@ -8,6 +8,13 @@
> >  #include <linux/pm_runtime.h>
> >  #include <linux/export.h>
> >
> > +#define CALL_PM_OP(dev, op) \
> > +({ \
> > +struct device *_dev = (dev); \
> > +const struct dev_pm_ops *pm = _dev->driver ? _dev->driver->pm : NULL; \
> > +pm && pm->op ? pm->op(_dev) : 0; \
> > +})
> 
> Why don't you include the function signature and symbol export into the macro?
> 

As discussed in the [v2] I am more inclined toward this v1
implementation.

So for v1:
Reviewed-by: Dhruva Gole <d-gole@ti.com>

[v2] https://lore.kernel.org/linux-pm/CAJZ5v0iHcvXHdMfdakd5TUgcAiOGFW8hbvb2k-xb92dz81cGhA@mail.gmail.com

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

