Return-Path: <linux-pm+bounces-16467-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E06D9B07DB
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 17:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 543DC281E11
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 15:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D779165F04;
	Fri, 25 Oct 2024 15:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JKJPUD7e"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08D91411E0;
	Fri, 25 Oct 2024 15:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729869385; cv=none; b=eI0axFai9+61lBiKUaq/OC4NfsUSsOTo2t1Hlt4SsHb3LXphaPNbILbuRewdXEnenI7VuMfklGXtCArcp8KBv4L0wkhFWR6BrCTj3zrRshz3o49QePRkkfCjOwsiEBEQXGjEmhU0CFV/OV2vJtPPNiO4p8ydVycycLwl9eJUTYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729869385; c=relaxed/simple;
	bh=4F9JvxtJSXma1Ue10kKYiRZi2lA87EIxw99Tvtynbdo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWgWfIkyOUgbIj1g5+tepLXUh4X+umJyoh64PQIUMEP/VaTB9WJ+lgW1iPJRInKf52ZHQVHIr1hzbdIxCr0amcje2aKXsaBvwQzSnK6UMXUIKKcdHuJ8RdbB5ec/ubH0QsBKaUGT6A9ueFnJhZrsgvwqCQWUGVAxtLqtvEWzLDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JKJPUD7e; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49PFG4Fn014238;
	Fri, 25 Oct 2024 10:16:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729869364;
	bh=OTbIFNQZr6AJS9EmB/xrgLvFipbYzDMHdfK5nPkKMWw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=JKJPUD7eSt2280fKeiTwenVzYCqCjv8H5Rj4uhyJ7hsWyrtiO5oWvbdAr5coWbYQH
	 iZINoo1MP9Hxf/h5zXCuZI/zbRwgfNJNM4PQSTnVWOmJW0Y8znnpuCQ8mWTUb0s/8l
	 6u8gIbuoj5e6RzJ32cwnHJBr31TUQAsz+sKi0CGM=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49PFG4Dq013779
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 25 Oct 2024 10:16:04 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Oct 2024 10:16:04 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Oct 2024 10:16:03 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49PFG4BF061550;
	Fri, 25 Oct 2024 10:16:04 -0500
Date: Fri, 25 Oct 2024 10:16:04 -0500
From: Nishanth Menon <nm@ti.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Markus Schneider-Pargmann
	<msp@baylibre.com>,
        Pavel Machek <pavel@ucw.cz>, Len Brown
	<len.brown@intel.com>,
        Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman
	<khilman@baylibre.com>,
        Dhruva Gole <d-gole@ti.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] PM: QoS: Export dev_pm_qos_read_value
Message-ID: <20241025151604.wyjyvie2e2ymxfhr@verbose>
References: <20241002194446.269775-1-msp@baylibre.com>
 <2024100333-maternity-equity-c7fa@gregkh>
 <tqsrnsvciupbovlalqsnrp5whst2mrpqntjblvymcunpesvake@o3gxa7vik7he>
 <2024100336-left-shadily-3321@gregkh>
 <20241025131542.5bfvqtepcefup3hv@mushy>
 <CAJZ5v0g1Ri_wKYppomE6RXqcZXRnX7bLOPMtsQaao0uchSfE9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g1Ri_wKYppomE6RXqcZXRnX7bLOPMtsQaao0uchSfE9A@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 16:50-20241025, Rafael J. Wysocki wrote:
[...]

> > Greg, Rafael, How do you wish to route this patch in?
> >
> > This patch is a dependency of [1] which goes through my tree.
> > If  you can provide an ack, I can pick up the patch through my tree,
> > else we will end up with dependency issue here.
> >
> > [1] https://lore.kernel.org/all/20241007-tisci-syssuspendresume-v13-0-ed54cd659a49@baylibre.com/
> 
> Sure, please feel free to add
> 
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> 
> to it.
> 
> Thanks!

Thanks for the ack, will queue things up.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

