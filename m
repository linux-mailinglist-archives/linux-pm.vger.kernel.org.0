Return-Path: <linux-pm+bounces-13657-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A7E96CF37
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 08:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 555561C22A4C
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 06:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE93189BA2;
	Thu,  5 Sep 2024 06:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cQCu1oEI"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43C02BB15;
	Thu,  5 Sep 2024 06:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725517610; cv=none; b=KkwPO7JN0LdJa4nB3guqH/K+KC2kvqCcUF1CQfCk+LzWg7mnNpVCZlRfgBruLzVM2kYAgLUOYuGo+0QQhABdBJSdrxzYwtEFYRGpV5CAn7WeugAEd2S9aM2UVSSTieOS8A/Rn9ZTsU5E2WsrMsotrw2Wkpxna+CTpqC+5/Q30k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725517610; c=relaxed/simple;
	bh=gpNI5UPu1tlSTXxDtT8DtkGlhoc/3t2KMxk23jnBah4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2+S6CQLOzCDL+lEebOSqMr4WZ086dXlQktx8YmmAdpV+56Q9zuumMetSHIcN6mT1K4O1gOOr5f9VI27kgNTAX6do3VN+ZFx0oQ0XlX9Fr0lgl8DEfw54oB1MAKlHlC9+AZgimBuHVdG/F6Ds9RjuMR5pKUqHCFXgEuTNx/2Uz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cQCu1oEI; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4856QbZb023651;
	Thu, 5 Sep 2024 01:26:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725517597;
	bh=1pz9ufV0B/f+SmsucPJYMbvTpYtd8rW0iAhjJGZoYJI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=cQCu1oEIX8hOH/Ffxhp9VhDPFhQ2IkYO9MpyG6d9Jj0C4KE5hp61CUL313MjaB6Qs
	 1YTG+bI2rAf7USqCmUdlFZLyDVsq0ZI4JE67F9gwh1NQaVCmE+gB2/x+VwRgRhB2nw
	 7CsqFh/sT5uvpNq18b8QvAihpzVdhtiahhizQ5Xc=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4856Qbsu128793
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 5 Sep 2024 01:26:37 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 5
 Sep 2024 01:26:36 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 5 Sep 2024 01:26:36 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.68] (may be forged))
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4856Qa1I119846;
	Thu, 5 Sep 2024 01:26:36 -0500
Date: Thu, 5 Sep 2024 11:56:35 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
CC: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh
 Shilimkar <ssantosh@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vibhore Vardhan <vibhore@ti.com>, Kevin Hilman <khilman@baylibre.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v12 1/5] PM: QoS: Export dev_pm_qos_read_value
Message-ID: <20240905062635.475bmulbuwfswiuz@lcpd911>
References: <20240904194229.109886-1-msp@baylibre.com>
 <20240904194229.109886-2-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240904194229.109886-2-msp@baylibre.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Sep 04, 2024 at 21:42:25 +0200, Markus Schneider-Pargmann wrote:
> In the ti_sci driver we would like to pass the resume latencies set on
> devices to the firmware so it can decide which power mode is the best to
> choose. To be able to build a driver using this function as a module,
> this function should be exported.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>  drivers/base/power/qos.c | 1 +
>  1 file changed, 1 insertion(+)

Thanks for this fix Markus,
Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

