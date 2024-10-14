Return-Path: <linux-pm+bounces-15627-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A44299D4BF
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 18:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBE3B1F236A8
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 16:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701DA1586CF;
	Mon, 14 Oct 2024 16:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oFKtHA7z"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351944B5AE;
	Mon, 14 Oct 2024 16:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728923648; cv=none; b=jmYiYFznNH1U4Rxai12wMblJ0ahIj3bCswO2aCVV3LMJwwdyIaLY/QtIRiGm31ujEiv4/LJM1Fdta2/LuuXv+AAcffAhuyGOLp7AJjFN8Zjry9LNtsf0byL3xH0S7d4lISF9nNYE1G2v91EKLTVjuarhOox3FghcsBDSxSE29bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728923648; c=relaxed/simple;
	bh=Re5ZNIjxd2wz32xEqIt5Mq5PCNxAtDitjb5BYY1ye4g=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgCQQ61hueS166rRijQ07lCSGmHjFG5yAHqNHErkU+yLismSW0GbiobEoTMZe08KBbibY7UDzBPdGDMM2qTEflQKVLolYslYubKlI/L8mmaniCPgn7fam1fsfdBBh12lQl0LMHguoYFpYD/qb7F7JFfzA+FtijkHyi3EoOmU1o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oFKtHA7z; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49EGXpl9094829;
	Mon, 14 Oct 2024 11:33:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728923631;
	bh=+kmYsnRSxgBQfl5oIRzC21ET9kJt498XpPwSEuIKuIw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=oFKtHA7za/V4aS1nUfpFsFQLigi4doV0pDtsg4LvJIMMn/kLeXb17gJiAf1dYIXbG
	 ZMrXJQTjBIg99510kwPqwrbTYcOkKGF/xCE90+6NH0LwczZG5sXsxj/tZ5M6y0pQ3t
	 fWcMX/5UfeKS56OvqX77yHu0iUO/yNcBAwgEuDAw=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49EGXpBM082054;
	Mon, 14 Oct 2024 11:33:51 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Oct 2024 11:33:51 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Oct 2024 11:33:51 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49EGXoXS127959;
	Mon, 14 Oct 2024 11:33:50 -0500
Date: Mon, 14 Oct 2024 22:03:49 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh
 Shilimkar <ssantosh@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Vishal Mahaveer <vishalm@ti.com>, <msp@baylibre.com>, <srk@ti.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-usb@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH v3] usb: dwc3: core: Fix system suspend on TI AM62
 platforms
Message-ID: <20241014163349.oiqocvg6pjmqulus@lcpd911>
References: <20241011-am62-lpm-usb-v3-1-562d445625b5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241011-am62-lpm-usb-v3-1-562d445625b5@kernel.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Oct 11, 2024 at 13:53:24 +0300, Roger Quadros wrote:
> Since commit 6d735722063a ("usb: dwc3: core: Prevent phy suspend during init"),
> system suspend is broken on AM62 TI platforms.
> 
> Before that commit, both DWC3_GUSB3PIPECTL_SUSPHY and DWC3_GUSB2PHYCFG_SUSPHY
> bits (hence forth called 2 SUSPHY bits) were being set during core
> initialization and even during core re-initialization after a system
> suspend/resume.
> 
> These bits are required to be set for system suspend/resume to work correctly
> on AM62 platforms.
> 
> Since that commit, the 2 SUSPHY bits are not set for DEVICE/OTG mode if gadget
> driver is not loaded and started.
> For Host mode, the 2 SUSPHY bits are set before the first system suspend but
> get cleared at system resume during core re-init and are never set again.
> 
> This patch resovles these two issues by ensuring the 2 SUSPHY bits are set
> before system suspend and restored to the original state during system resume.

Thanks for the fix Roger,
Reviewed-by: Dhruva Gole <d-gole@ti.com>

> 
> Cc: stable@vger.kernel.org # v6.9+
> Fixes: 6d735722063a ("usb: dwc3: core: Prevent phy suspend during init")
> Link: https://lore.kernel.org/all/1519dbe7-73b6-4afc-bfe3-23f4f75d772f@kernel.org/
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> ---
> Changes in v3:
[...]

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

