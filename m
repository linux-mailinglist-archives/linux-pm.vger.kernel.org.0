Return-Path: <linux-pm+bounces-12557-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 632DC95839F
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 12:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08D432887EE
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 10:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399C518CC1D;
	Tue, 20 Aug 2024 10:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pLQsqbCY"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CA118CC0E;
	Tue, 20 Aug 2024 10:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724148442; cv=none; b=s0vN0FGEeS1Qb2sAfSskFmdsIAVFjJJR8PkPnuTDGTBVkaoaN/hZZggQXyC55e/D3Q63AlQ8EeAxpOFyy92X3yDmiFLEXSWOj50iKz3n7rYhysD3g6m5glWJ8zAs18vRuA1RlTzj0knO72hWG10MMkOqAL7f1UF835MdeOA6gXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724148442; c=relaxed/simple;
	bh=dKlbevvebHQEcZGYVQfCE/AOvvg/xGoqpqQhEY0ng2c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQtRyh+yifIztw4wmbH1qDl4UQTDqFWFvFk8ql7Hop3Kpxsm7IHyvnrjMJZMW2fk6WWc5mTS4wNJn5yHFgEIwuruAVZAy4RCCq4UPexVHf7gCzNkbXWBuHHbb9TI5FbvNAEzguEdKhEj1LnhfWvAfKOl6p+jX+fArGfArepi0Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pLQsqbCY; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47KA7EG2017205;
	Tue, 20 Aug 2024 05:07:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724148435;
	bh=2bPALklH8qin/1uAmcLNSYEl5N8smNp6DkrdpWooo+4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=pLQsqbCYQ4svyRluhQwKlwyPvQ70LqEnZ0IFBpeJALpbSpWLUZmo6wv6pF8wCBO9D
	 POlcBKXyHOJObGOh1Xd4oGO0GaUCaciIY655fn76HO2hZMDWHLBpiND/OitJlnNllI
	 4YaKzsvKncnOvRTuMtZkpoGGtLT+rXFwTby9Nxq0=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47KA7Emm001209
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Aug 2024 05:07:14 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Aug 2024 05:07:14 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Aug 2024 05:07:14 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47KA7DTw076275;
	Tue, 20 Aug 2024 05:07:14 -0500
Date: Tue, 20 Aug 2024 15:37:13 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Kevin Hilman <khilman@baylibre.com>
CC: Ulf Hansson <ulf.hansson@linaro.org>, <linux-pm@vger.kernel.org>,
        Nishanth
 Menon <nm@ti.com>, Vibhore Vardhan <vibhore@ti.com>,
        Akashdeep Kaur
	<a-kaur@ti.com>, Sebin Francis <sebin.francis@ti.com>,
        Markus
 Schneider-Pargmann <msp@baylibre.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] pmdomain: ti_sci: collect and send low-power mode
 constraints
Message-ID: <20240820100713.2xbbyw726eymxr66@lcpd911>
References: <20240819-lpm-v6-10-constraints-pmdomain-v2-0-461325a6008f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240819-lpm-v6-10-constraints-pmdomain-v2-0-461325a6008f@baylibre.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Aug 19, 2024 at 17:00:10 -0700, Kevin Hilman wrote:
> The latest (10.x) version of the firmware for the PM co-processor (aka
> device manager, or DM) adds support for a "managed" mode, where the DM
> firmware will select the specific low power state which is entered
> when Linux requests a system-wide suspend.
> 
> In this mode, the DM will always attempt the deepest low-power state
> available for the SoC.
> 
> However, Linux (or OSes running on other cores) may want to constrain
> the DM for certain use cases.  For example, the deepest state may have
> a wakeup/resume latency that is too long for certain use cases.  Or,
> some wakeup-capable devices may potentially be powered off in deep
> low-power states, but if one of those devices is enabled as a wakeup
> source, it should not be powered off.
> 
> These kinds of constraints are are already known in Linux by the use
> of existing APIs such as per-device PM QoS and device wakeup APIs, but
> now we need to communicate these constraints to the DM.
> 
> For TI SoCs with TI SCI support, all DM-managed devices will be
> connected to a TI SCI PM domain.  So the goal of this series is to use
> the PM domain driver for TI SCI devices to collect constraints, and
> communicate them to the DM via the new TI SCI APIs.
> 
> This is all managed by TI SCI PM domain code.  No new APIs are needed
> by Linux drivers.  Any device that is managed by TI SCI will be
> checked for QoS constraints or wakeup capability and the constraints
> will be collected and sent to the DM.
> 
> This series depends on the support for the new TI SCI APIs (v10) and
> was also tested with this series to update 8250_omap serial support
> for AM62x[2].
> 
> [1] https://lore.kernel.org/all/20240801195422.2296347-1-msp@baylibre.com
> [2] https://lore.kernel.org/all/20240807141227.1093006-1-msp@baylibre.com/
> 
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> ---

Since I applied this series to the v10 TISCI series as well, and tested:

For the series,
Tested-by: Dhruva Gole <d-gole@ti.com>

Logs:
https://gist.github.com/DhruvaG2000/658d0d4683b13ab41025df19a8eafc2f

Tree with all the patches applied:
https://github.com/DhruvaG2000/v-linux/tree/lpm-k3-next

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

