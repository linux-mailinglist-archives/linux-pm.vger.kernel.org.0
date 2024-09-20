Return-Path: <linux-pm+bounces-14513-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAD797D443
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2024 12:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50FE51C21D82
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2024 10:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6E613C9D9;
	Fri, 20 Sep 2024 10:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OUpivb/w"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9320013AD33;
	Fri, 20 Sep 2024 10:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726828697; cv=none; b=kw8nJv6t3Nm7fkjtWu+coTDh12yAFRDxw59CEjzxBgINHffxXPS575/eZYmt6GS0fT1wubVcKbXmYPSVbqIJDxcOy9SA4l+klseY+V2+8u3kU5ml8VrmYmkTEHbcAkFVB5FJZgfxRr0O+w/yTpOTiIO88TRj57Z3kZMHTq4xOBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726828697; c=relaxed/simple;
	bh=8i1Rxs9MnTmHKMKgDdgTC6ulzhSZH1r5exhnwHWEqUg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCxyC8DsU3m69hkA1cPtWRLCA7zBZnZ1Dh3y2Mj75WyELVVE8/dFgjbrjs+dcAGrfEBLY5oe2nmq/tF/WRTb2G4fI11fG9EsbaqdWbiOHQCoLN564XVBZKKOG+47F98ovcqf1M18ujMghGW9s27XdOqvy90IzBrLoZUOV/AZ414=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OUpivb/w; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48KAc1x5032225;
	Fri, 20 Sep 2024 05:38:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1726828681;
	bh=NqYwpS9NyJoR+caapWvLtulQ3v9DdbaKReZdZFv4B14=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=OUpivb/wr+ukIVRF5SEe8QdypaiKpPrJtWfgIcLNJfrFFBJldzP3YQr0F0ZJKBxzW
	 OA3/S54a6Yqk5o4pskBONIjhLwXzZO+GK+l0OIP1s9j2Ex0cz8GpYSzyGejKlX1AmS
	 1Cp7mSdQk737UAjvbUlUUCb0K26+qddJOV2TU2iE=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48KAc1UY049239
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 20 Sep 2024 05:38:01 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 20
 Sep 2024 05:38:00 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 20 Sep 2024 05:38:00 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48KAbxP2071575;
	Fri, 20 Sep 2024 05:38:00 -0500
Date: Fri, 20 Sep 2024 16:07:59 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J
 . Wysocki" <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH V4 5/6] arm64: dts: ti: k3-am62: use opp_efuse_table for
 opp-table syscon
Message-ID: <20240920103759.vypnmro6imsn52ge@lcpd911>
References: <20240919082809.174589-1-d-gole@ti.com>
 <20240919082809.174589-6-d-gole@ti.com>
 <5a54f481-efaa-4719-ac38-b328a6c67762@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5a54f481-efaa-4719-ac38-b328a6c67762@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Sep 19, 2024 at 11:40:31 -0500, Andrew Davis wrote:
> On 9/19/24 3:28 AM, Dhruva Gole wrote:
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
> > **DEPENDS ON:** PATCH 6/6: cpufreq: ti-cpufreq: Update the efuse/rev offsets
> > 
> > Link to v1: https://lore.kernel.org/all/20240902093222.2828345-2-d-gole@ti.com/
> > No changes, just combined it as part of Bryan's AM62A and AM62P series
> > and sending it all together.
> > 
> > ---
> >   arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi | 7 ++++++-
> >   arch/arm64/boot/dts/ti/k3-am625.dtsi       | 2 +-
> >   2 files changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
> > index e0afafd532a5..b2b65e31c7cf 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
> > @@ -10,7 +10,7 @@
> >   &cbass_wakeup {
> >   	wkup_conf: syscon@43000000 {
> >   		bootph-all;
> > -		compatible = "syscon", "simple-mfd";
> > +		compatible = "simple-bus";
> 
> This can be done in a separate patch after this one. You'll also
> want to change the syscon@43000000 to bus@43000000, and drop the
> "reg = <>;" line at the same time.
> 
> Andrew
> 

Sure Andrew, thanks for pointing this out. I will do this in a separate
patch.

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

