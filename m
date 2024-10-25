Return-Path: <linux-pm+bounces-16451-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A200E9B03C1
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 15:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66E48285694
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 13:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2000D70809;
	Fri, 25 Oct 2024 13:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="N4ZLijwI"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910961632CC;
	Fri, 25 Oct 2024 13:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729862156; cv=none; b=ui+4QwVrfLyPwRha23QsKiwTPZsNInbddocHvF4lEMgrQcz0JgjFWS5/YgKjPOB8UnG6fsSH69eIwUJ5IpPVf9gkKvMAw0qtY+ZhtovjJ3SgAAGUigRo4b8trNtrzZNG6WgOYANwG4jaWFKborO1jLjrZCXN5TXcyQ3NK43PxSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729862156; c=relaxed/simple;
	bh=6KnO8SkraYLMCSlaCBtsUjTt914Z8XYXCnsVppVQHV4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmMC4HVHAGhB1NAENhrgXfhth2j8T8uuI7t3xKeHjcOGuvx7N6BYNKToOEji3QULXWfkXtsuY2MmpCE7D+OGMW/tnV8usTnxpQBrNuxy4eBncJpAmrq1/YWjVgwWEgmh0LCnMXT1fEgVsllvRlnY8PhGKNczzriGRsoMX0harp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=N4ZLijwI; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49PDFglB065805;
	Fri, 25 Oct 2024 08:15:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729862142;
	bh=GNXUgcPLdWuAhNSBUuafLXqx+aw5pMkPb4I+zFvGsHA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=N4ZLijwITEl208Z6C5EMBfKFg34hvCHNzFieO85XUrwnDnH0Da6+kTrR3XkE1MkY6
	 a7dMcg/60yK9mVqhYC9jqaMuxoy82wH7+Mv8MOBQCkN555lWl1HbPA9MpU1AW2U3Gw
	 mZbtJsuhiw9ngLagSgtwk6h/3KFLZ+Q5rpj2X53U=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49PDFg7Q033633
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 25 Oct 2024 08:15:42 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Oct 2024 08:15:42 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Oct 2024 08:15:42 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49PDFg5w049555;
	Fri, 25 Oct 2024 08:15:42 -0500
Date: Fri, 25 Oct 2024 08:15:42 -0500
From: Nishanth Menon <nm@ti.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Markus Schneider-Pargmann <msp@baylibre.com>,
        "Rafael J . Wysocki"
	<rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown
	<len.brown@intel.com>, Vishal Mahaveer <vishalm@ti.com>,
        Kevin Hilman
	<khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] PM: QoS: Export dev_pm_qos_read_value
Message-ID: <20241025131542.5bfvqtepcefup3hv@mushy>
References: <20241002194446.269775-1-msp@baylibre.com>
 <2024100333-maternity-equity-c7fa@gregkh>
 <tqsrnsvciupbovlalqsnrp5whst2mrpqntjblvymcunpesvake@o3gxa7vik7he>
 <2024100336-left-shadily-3321@gregkh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2024100336-left-shadily-3321@gregkh>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 08:49-20241003, Greg Kroah-Hartman wrote:
> On Thu, Oct 03, 2024 at 08:28:12AM +0200, Markus Schneider-Pargmann wrote:
> > On Thu, Oct 03, 2024 at 08:02:04AM GMT, Greg Kroah-Hartman wrote:
> > > On Wed, Oct 02, 2024 at 09:44:46PM +0200, Markus Schneider-Pargmann wrote:
> > > > Export the function dev_pm_qos_read_value(). Most other functions
> > > > mentioned in Documentation/power/pm_qos_interface.rst are already
> > > > exported, so export this one as well.
> > > > 
> > > > This function will be used to read the resume latency in a driver that
> > > > can also be compiled as a module.
> > > 
> > > We don't add exports for no in-kernel users, sorry.  Send this as part
> > > of a series that requires it.
> > 
> > Sorry if this was unclear, it is for an in-kernel driver (ti_sci.c) that
> > can be built as a module. When built as a module it can't use this
> > function if it is not exported.
> 
> So the current kernel build is broken?  If so, please add a "Fixes:" tag
> and say this in the changelog.
> 
> If not, again, just make it part of the series where it is needed.
> 

Greg, Rafael, How do you wish to route this patch in?

This patch is a dependency of [1] which goes through my tree.
If  you can provide an ack, I can pick up the patch through my tree,
else we will end up with dependency issue here.

[1] https://lore.kernel.org/all/20241007-tisci-syssuspendresume-v13-0-ed54cd659a49@baylibre.com/

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

