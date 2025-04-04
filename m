Return-Path: <linux-pm+bounces-24795-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EA4A7B7A0
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 08:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E25C21735BC
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 06:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FF01862BB;
	Fri,  4 Apr 2025 06:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FLlcagOC"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6197101F2;
	Fri,  4 Apr 2025 06:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743747194; cv=none; b=RNHEeESzrATt1vT/baCeACuTr6kEfMniGIw/Qa2hQwwUpvV93265LbV/bgoSDlC4CA2K38zHTMglc3OfndW9ZhWc1hRwqncfCGxo8xlLqrPNcs95YGriny6dp6D+x9DW/HlPCSHRktK1bpipNHfyCopt3PvNy0579aDsn7Do8pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743747194; c=relaxed/simple;
	bh=D/d1gnPCumIccAY1D58aMP6d2nRRx7Cr8jlQwlsQyhI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L12oFGtEVUGGGy6tA/c4F7yMwf//Ttyo7d5LbryAaNoKjb+Ya2lxvqpq01IqDL38BDQco8eI8qgLH9UICK7kNgsZi47En1wZA11nNkaa6WvuWL6apNuktGi5Dqy3PCW2BopHsGOI3uYRtJvdBbxVfWqg1Eaf+PMphYYedYAu398=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FLlcagOC; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5346D073265204
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Apr 2025 01:13:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1743747180;
	bh=KVWOwvRPO7YvD8ife4s6y5HXtx59DE9Bhv5GKy5bWME=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=FLlcagOCAFXhKEBo2g69Vx91biEEicL67yNaykYglTguEFH+U1KZVfHYarNRCHBua
	 DCDOeF0+rF+wOQ3+Eu3Z+ZCuL79E3OANB4j/mA+l0/LlMJiywQg3u96TdpH0B7HFJS
	 CX8Efn0Le1+K6IWtV9jDlMjPBz1NxefQfyMgYXeY=
Received: from DFLE20.ent.ti.com ([10.64.6.57])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5346D0b3032094;
	Fri, 4 Apr 2025 01:13:00 -0500
Received: from flwvowa01.ent.ti.com (10.64.41.90) by DFLE20.ent.ti.com
 (10.64.6.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 4 Apr
 2025 01:13:00 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by flwvowa01.ent.ti.com
 (10.64.41.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2507.34; Fri, 4 Apr
 2025 01:13:00 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 4 Apr 2025 01:13:00 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5346CxRT123540;
	Fri, 4 Apr 2025 01:12:59 -0500
Date: Fri, 4 Apr 2025 11:42:58 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pmdomain: core: Reset genpd->states to avoid freeing
 invalid data
Message-ID: <20250404061258.alstrdgpz75gywna@lcpd911>
References: <20250402120613.1116711-1-ulf.hansson@linaro.org>
 <20250403080815.jsdoydcczkeuvmy6@lcpd911>
 <CAPDyKFrgYVMvaBf13ksdJ6Zr6bvLo1Jmz8yLiyg_43hs65STVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAPDyKFrgYVMvaBf13ksdJ6Zr6bvLo1Jmz8yLiyg_43hs65STVQ@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Apr 03, 2025 at 17:55:41 +0200, Ulf Hansson wrote:
> On Thu, 3 Apr 2025 at 10:08, Dhruva Gole <d-gole@ti.com> wrote:
> >
> > On Apr 02, 2025 at 14:06:13 +0200, Ulf Hansson wrote:
> > > If genpd_alloc_data() allocates data for the default power-states for the
> > > genpd, let's make sure to also reset the pointer in the error path. This
> > > makes sure a genpd provider driver doesn't end up trying to free the data
> > > again, but using an invalid pointer.
> >
> > I maybe missing something but if kfree works similar to [1]GNU free() won't
> > it make the genpd->states NULL anyway? Have you actually seen scenarios
> > where the genpd->states is remaining non-NULL even after kfree?
> 
> Yes. kfree() doesn't reset the pointer to the data.

Gotcha.

[...]
> > >       put_device(&genpd->dev);
> > > -     if (genpd->free_states == genpd_free_default_power_state)
> > > +     if (genpd->free_states == genpd_free_default_power_state) {
> > >               kfree(genpd->states);
> > > +             genpd->states = NULL;
> >
> > Also the coding convention for kfree in other places in pmdomains
> > doesn't seem to follow this practise either...
> 
> Right. I am not suggesting changing them all. Only this one, as it's a
> special case and an error path.
> 
> genpd->states may be allocated by both the genpd provider driver and
> internally by genpd via pm_genpd_init(), hence we need to be a bit
> more careful.
> 

I see.. okay then,
Reviewed-by: Dhruva Gole <d-gole@ti.com>


-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

