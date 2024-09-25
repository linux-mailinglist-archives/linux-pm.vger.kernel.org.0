Return-Path: <linux-pm+bounces-14681-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F249861E4
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 17:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAD6928CC19
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 15:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E97D146A83;
	Wed, 25 Sep 2024 14:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ir+0SOGy"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC0726AF5;
	Wed, 25 Sep 2024 14:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727275659; cv=none; b=AgDOXI0KUF3UWUyPf0+DVj6EXGzimfKD+P0HKhsDK54DlQOSd7eh9dorBU8epSZFpCbAWTg25qDQmEkwYNtdxReXmt4KS3/7qZvo+Va+jf4sDAC0T8WicFUBAN/4+EwrwKeIK4nY8xDfEvpjcQdNA4i0CU/GB8yYFo5uQqmDRkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727275659; c=relaxed/simple;
	bh=Tmu0tD47yBRk9W3679wQZJv8rygcWbq781fqyCw3aqE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phM5urM6DpdVf1fr4/IX+Lu8uFr3Xu6VfKJkeOvEbCKhX8a1VXQO3NZRsL5Qs5RnUfHggBqtCxi8yQaOvdPshmySvBRUxwZ3Pxtnw0BVtjJfrDge1gd8r56VeoytG6s1/ucoOXF6ZHEDFlCDcap2BLGsplOB6frQRL12FATVEck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ir+0SOGy; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48PElHVv060017;
	Wed, 25 Sep 2024 09:47:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727275637;
	bh=4VwajSJSGs7NeJ2tu0pr2EwVcVfrBmnx5SxI3sSsQTU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=ir+0SOGyRM9ZdRIyRfdtvz3mtIcvy6k/EJAjDwbktyeb4f7nZFrhreiSKBHa0Znak
	 xiggrvCoHxbk/0m/k8OyDPlxpz8pX+BNWF1ywQGXppnggRNiU1qS/msbY7PrkKgipL
	 JM6JgN/UUJ5lOAYG8OGgTn67TvNoAIDDHeerHhyQ=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48PElHjl096567;
	Wed, 25 Sep 2024 09:47:17 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 25
 Sep 2024 09:47:16 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 25 Sep 2024 09:47:16 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48PElG2I103324;
	Wed, 25 Sep 2024 09:47:16 -0500
Date: Wed, 25 Sep 2024 20:17:15 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>, Bryan Brattlof <bb@ti.com>
Subject: Re: [PATCH v5 0/6] ti: k3-am62{a,p}x-sk: add opp frequencies
Message-ID: <20240925144715.7zu3jodx7byslmdk@lcpd911>
References: <20240924-ti-cpufreq-fixes-v5-v5-0-cbe16b9ddb1b@ti.com>
 <20240924121544.62my7eqnudc76orl@subscribe>
 <20240925074738.a43uwqen4dvbd5mc@lcpd911>
 <20240925125115.hkdhczffhauy6met@lushly>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240925125115.hkdhczffhauy6met@lushly>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Sep 25, 2024 at 07:51:15 -0500, Nishanth Menon wrote:
> On 13:17-20240925, Dhruva Gole wrote:
> > On Sep 24, 2024 at 07:15:44 -0500, Nishanth Menon wrote:
> > > On 15:20-20240924, Dhruva Gole wrote:
> > > [...]
> > > > 
> > > > I am sorry that this breaks compatibility with older AM625 devicetree.
> > > > However, the old devicetree was marking the entire wkup_conf as "syscon",
> > > > "simple-mfd" which was wrong and needed to be fixed.
> > > > 
> > > > This series finally tries to bring order to DT and the driver.
> > > > 
> > > > However, if there is still any way to maintain the backward
> > > > compatibility, then I am open to suggestions. Please try
> > > > and understand here that the ask for backward compatibility here
> > > > is to ask the driver to support a case where the register offset itself
> > > > was to be picked from a different node. I am not sure if there's any
> > > > cleaner way to do this.
> > > 
> > > 
> > > Have you tried to handle this with quirks? I am not in favor of breaking
> > > backward compatibility.
> > 
> > I was thinking of something on those lines, but quirks makes sense for
> > the case that there's a quirky behaviour in the SoC itself. Here it
> > seems to me that we are adding a quirk to handle quirk in some old devicetree.
> > 
> > There's no way to detect the devicetree version or somehow distinguish
> > within the driver if it's an old or a new DT. One way I could think of
> > is on these lines:
> 
> I suggest going and experimenting a bit. Sorry, changes that break
> backward compatibility: NAK!

OK, let me try using some information from old DT to distinguish and add
the offset based on that. Sending those patches soon.

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

