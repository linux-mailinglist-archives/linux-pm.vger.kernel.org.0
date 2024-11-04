Return-Path: <linux-pm+bounces-16910-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC139BABE2
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 05:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FE0FB217B1
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 04:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF751185B72;
	Mon,  4 Nov 2024 04:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="n0Lq0biJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6F1290F;
	Mon,  4 Nov 2024 04:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730695962; cv=none; b=u+drKDb7TKIBmWjYI6l0gH7Ue17LqdCkS7GxIHuabW8VGhbWU2pRqLXUVs0svOoXz9QE6E1HJGllp6uzmR0upmCknblm5wMtH4oq5cUSMwJuS5/G18xEbFkuV40ypMh/wIJQEtM6oglYl6nNiYLh6o5pMhLy57bcmcZvjPDi27U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730695962; c=relaxed/simple;
	bh=hD5Ds+9z7GbWDKil7XA8fTLgvOAuEk8OiI3nOJgmWxY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+fGfXVgyDz3uKNRPYrIazstM0G/apppkX42z/mXtTS7oGrM2TH1SuVlBH9CphjJXwKKn7VegyMvQOyoXCF6CrCZXPJaVyeQMWLKDzfB6Mw7dmptXyVrcGwvQo9ALgn5n5C1PTlW4SUEZu0cR77mkyEGqsRDX5TKbe7TguHS6pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=n0Lq0biJ; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A44qStB092545;
	Sun, 3 Nov 2024 22:52:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730695949;
	bh=plZaN47/UeZAG1fxbybtFuEI5NnJRqWIxgjxXp4yRZg=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=n0Lq0biJsxO+8yz4XUCUtpbLeeuRsFwX4XQs8CjBwyZLlY//OqALPaqBvwc/aoKjO
	 1LppbZ5DTJIhVicdgkPytK64ZiHZJRnUKrGMvBJIk4yIXaQ6sGpEdRzesUHOjmxlEl
	 RBtWJRvFEwyA2O78NlAVdP6kEU9Q/au9fhOrH4cY=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4A44qSI8011227
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 3 Nov 2024 22:52:28 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 3
 Nov 2024 22:52:28 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 3 Nov 2024 22:52:28 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A44qR35090094;
	Sun, 3 Nov 2024 22:52:28 -0600
Date: Mon, 4 Nov 2024 10:22:27 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>
CC: Nishanth Menon <nm@ti.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>, Bryan Brattlof <bb@ti.com>,
        Wadim
 Egorov <w.egorov@phytec.de>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am62: use opp_efuse_table for
 opp-table syscon
Message-ID: <20241104045227.2tzm2lcwi7kqee5r@lcpd911>
References: <20241030044553.3225383-1-d-gole@ti.com>
 <e3c4f895-71a1-481f-86d4-dfab1b61715c@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e3c4f895-71a1-481f-86d4-dfab1b61715c@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Oct 30, 2024 at 11:17:16 +0530, Vignesh Raghavendra wrote:
> Hi
> 
> On 30/10/24 10:15, Dhruva Gole wrote:
> > Add another entry in the wkup_conf for the syscon node, and then use
> > that for the syscon in opp-table.
> > 
> > Marking entire wkup_conf as "syscon", "simple-mfd" is wrong and needs to
> > be addressed similar to how other child-nodes in wkup_conf are implemented
> > in the same file.
> > 
> > Signed-off-by: Dhruva Gole <d-gole@ti.com>
> > ---
> > 
> > Since the driver fixes for ti-cpufreq.c have made it in -next [1],
> > The DT fixes for SK-AM62x can be supported with support for legacy
> > style DT as well. This has been tested on SK-AM62x [2]
> > 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/cpufreq/ti-cpufreq.c?id=1724ae88efcbcd0daeb203ffeb4a2c0e59f2ddf7
> > [2] https://gist.github.com/DhruvaG2000/40b80cc04a9ac90c86445d6e67ece4cb
> > 
> > Changelog:
> > 
> > Changes in v2:
> > - Deleted PATCH to Make the AM625 efuse_offset 0, because with [1] we no
> >   longer break backward compatibility and hence need to preserve the old
> >   offset.
> > - Link to v1:
> >   https://lore.kernel.org/linux-arm-kernel/20240902093222.2828345-3-d-gole@ti.com/
> > 
> > ---
> >  arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi | 7 ++++++-
> >  arch/arm64/boot/dts/ti/k3-am625.dtsi       | 2 +-
> >  2 files changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
> > index e0afafd532a5..b2b65e31c7cf 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
> > @@ -10,7 +10,7 @@
> >  &cbass_wakeup {
> >  	wkup_conf: syscon@43000000 {
> 
> Now that the compatible is updated, this needs to be bus@addr
> dtbs_check should catch such errors.

Oh yes, I'll update this. Good catch.

> 
> >  		bootph-all;
> > -		compatible = "syscon", "simple-mfd";
> > +		compatible = "simple-bus";
> 
> Did you also check U-Boot and make sure no regression/update needed?
> 

No, I can do a quick sanity boot till kernel with this DTB in U-boot to
check for regressions.

Thanks for the review.

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

