Return-Path: <linux-pm+bounces-14881-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A99988661
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2024 15:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68700B21A02
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2024 13:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E95719ADBF;
	Fri, 27 Sep 2024 13:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qJ/5nr33"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD60E19ABC5;
	Fri, 27 Sep 2024 13:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727444425; cv=none; b=mPQCwKJQVP6S40LJoe80SUtRMsRapDjXrpeQVYfyGrDVmRLrpMEPufuSSGQQpHo8KAWz7pTfnz9QIN9G1+PGXG8ndIrcGMBlYhKNVxO32NmtuBdvD0tclKEV4vy9WpbXPO9q7nuh2Xvz+DqCF8PtNmVrKdF4wtsMC0m7U74RnLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727444425; c=relaxed/simple;
	bh=stXfb3OTAot2BTAkQDMwmhhn4fmA7QUDdFIpof1qE08=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1WzFBfPR/PDAYJoehvrBWASxfWiv6YgtPmbGt02DLupOLrbSKEMDo+EqQQSq0RybSxOIvBihlQ6Eslr4XSkquK+tTe3YkQLoi7wgDufy7l7++AmIv/TUNqDTsKi6P9omRa+iS9dFRWfNdRU2hxVyJXw2cbdcz/hNakb1JUP45U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qJ/5nr33; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48RDe3iU056106;
	Fri, 27 Sep 2024 08:40:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727444404;
	bh=NXYz7pwxk6DqQQ7Rq47XYo/Xx7T/j2Hx24FNBYQH6gM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=qJ/5nr332cKDxQLRD+cHXDFqcZW95v6lC8OYKeal45BeBbbLf4I8m4fEXhDyimIUz
	 9+dPDD9/fZDKpkUkxZK+5vnfSzSRXsUQplpT8gCNZJnXiSQ+LvqSiWeksC4XKds4hS
	 1169s15l1IT4MP7zBatxA7f2DbOeN0OaDVCxOS7k=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48RDe35I025636
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 27 Sep 2024 08:40:03 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 27
 Sep 2024 08:40:03 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 27 Sep 2024 08:40:03 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48RDe3Jb044124;
	Fri, 27 Sep 2024 08:40:03 -0500
Date: Fri, 27 Sep 2024 08:40:03 -0500
From: Nishanth Menon <nm@ti.com>
To: Dhruva Gole <d-gole@ti.com>
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
Message-ID: <20240927134003.j73m4cqo6q2orxvt@stream>
References: <20240926-ti-cpufreq-fixes-v5-v7-0-3c94c398fe8f@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240926-ti-cpufreq-fixes-v5-v7-0-3c94c398fe8f@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 14:04-20240926, Dhruva Gole wrote:
[...]

> Bryan Brattlof (4):
>   arm64: dts: ti: k3-am62a: add opp frequencies
>   arm64: dts: ti: k3-am62a7-sk: add 1.4ghz opp entry
>   arm64: dts: ti: k3-am62p: add opp frequencies
>   arm64: dts: ti: k3-am62p5-sk: add 1.4ghz opp entry
> 
> Dhruva Gole (2):
>   arm64: dts: ti: k3-am62: use opp_efuse_table for opp-table syscon
>   cpufreq: ti-cpufreq: Update efuse/rev offsets in AM62 family

Please drop the dt patches from the series - they are completely
un-related. just fix the driver for compatibility and we can attack the
am625 cpufreq support fixup separately. AM62a/62p etc are independent of
this completely - those need to go to the DT maintainer separately

am625: Just post the driver fixups for backward compatibility and get it
merged prior to dt fixup.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

