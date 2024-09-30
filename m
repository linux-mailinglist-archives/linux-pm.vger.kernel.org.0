Return-Path: <linux-pm+bounces-14912-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EF79899F2
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 07:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAC2B2820C9
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 05:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC89B3FBB3;
	Mon, 30 Sep 2024 05:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GO82FlTc"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9572F46;
	Mon, 30 Sep 2024 05:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727672739; cv=none; b=kRjRIVSqZhORilIzmd7wQlh79PKWyeoFryIuzg+UGBrWrxFCO/awgCbyeyWLWOfNrFnTQnHMwVhdZ1ZO5FqTzFBZ7kz9AYPTS4sAD+PxAsHHujgK6bEhb7tpjc43audqv2rKV2fm8TTeJ8q8rRFUMllHjowc6RPqfKg85eiIiw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727672739; c=relaxed/simple;
	bh=/f+6PC0GUbBeBDchNrSFPIr57wSvQZ9pDTBU5C9xZvk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nnSV9Oyo93EugGFZjeC725gkFEMjFTpd72w+a4k6qheaN9aN5f6po2RWgSfJMHki/aoACx6ZgBef0arCDY2Ty7rdpdPxuxr3F7K5e/XPqgl5uGGi2PXXNE4cefrrpaXGeHqjJbO76saqDPpPIOgLChh+r3fsXRlHJSWdVg4sgzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GO82FlTc; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48U55E4r107191;
	Mon, 30 Sep 2024 00:05:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727672714;
	bh=FRcF2IH9LR6MlafQJfDMBB5G104JUIYoqUMR5YQ2sFI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=GO82FlTcGofCXHyLDfMW6YoktWxdiNhWI/RGQ6q8FkTzj9c+RYUX316ca37SMj5b9
	 Gd4EvTYISuWJ8cj9E+SHQupY7fgFn387S7cjkHOLvNDOlnRwVq4jKF2JvAd+Z8aLqc
	 PyPTQNA4BRxFj2zcyXCTKexranGlu7Jeh2LYW1f8=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48U55E7h020627
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 30 Sep 2024 00:05:14 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 30
 Sep 2024 00:05:14 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 30 Sep 2024 00:05:14 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48U55DTR093660;
	Mon, 30 Sep 2024 00:05:14 -0500
Date: Mon, 30 Sep 2024 10:35:12 +0530
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
	<afd@ti.com>, Bryan Brattlof <bb@ti.com>,
        Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>,
        Markus Schneider-Pargmann
	<msp@baylibre.com>
Subject: Re: [PATCH v7 0/6] ti: k3-am62{a,p}x-sk: add opp frequencies
Message-ID: <20240930050512.mq3hmukyzzcobbaq@lcpd911>
References: <20240926-ti-cpufreq-fixes-v5-v7-0-3c94c398fe8f@ti.com>
 <20240927134003.j73m4cqo6q2orxvt@stream>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240927134003.j73m4cqo6q2orxvt@stream>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Sep 27, 2024 at 08:40:03 -0500, Nishanth Menon wrote:
> On 14:04-20240926, Dhruva Gole wrote:
> [...]
> 
> > Bryan Brattlof (4):
> >   arm64: dts: ti: k3-am62a: add opp frequencies
> >   arm64: dts: ti: k3-am62a7-sk: add 1.4ghz opp entry
> >   arm64: dts: ti: k3-am62p: add opp frequencies
> >   arm64: dts: ti: k3-am62p5-sk: add 1.4ghz opp entry
> > 
> > Dhruva Gole (2):
> >   arm64: dts: ti: k3-am62: use opp_efuse_table for opp-table syscon
> >   cpufreq: ti-cpufreq: Update efuse/rev offsets in AM62 family
> 
> Please drop the dt patches from the series - they are completely
> un-related. just fix the driver for compatibility and we can attack the
> am625 cpufreq support fixup separately. AM62a/62p etc are independent of
> this completely - those need to go to the DT maintainer separately

OK, will drop them out and post them later on to the TI maintainers.

> 
> am625: Just post the driver fixups for backward compatibility and get it
> merged prior to dt fixup.
> 

Got it, I'll incorporate your suggestion on the driver patch and post it
independently. Then post the DT fixups later.

Thanks for all the inputs!

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

