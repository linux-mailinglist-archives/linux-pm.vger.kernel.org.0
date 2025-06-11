Return-Path: <linux-pm+bounces-28439-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7871FAD4AB3
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 08:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16C85177348
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 06:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E7722540B;
	Wed, 11 Jun 2025 06:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="q3N6BKUN"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16581A28D;
	Wed, 11 Jun 2025 06:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749622092; cv=none; b=orUeY9NbfIDV9w8R20Mf3vFHKomiVANcsVI+2+yD3EVNun1jj1MFDOHi0gIBwq5tkwA5Jy1l8GrGxnCbGez1E5ZpHaSDnW/tzRhP6K6mTxOU9hoZCMKKEZWhf+i8LxankgpOyrwmF5AIxyqIy2nGxG3TLeN3EjKeynbWK4PgGI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749622092; c=relaxed/simple;
	bh=/Nnf6p0l2Q5txW+WlPBCYXoxn/c4NqL3AFRCGX7Iikg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQp7QC6H1jq6gTSJE69bNYfHRC0bVspIDTWW4pLFLLqAGVlipJTFKNwoXxcz2ZwZ9rTfgRgvhsQ66cMsLB4lkEQk1qshfQvUl6Hhurq6R0d0CgrK+S/4czBEdDyZ1dvj7gGFQqG1MCP7yqvrAKfg+b15UMp0MBqZRrGxWc+zacE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=q3N6BKUN; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55B67bjl1291549;
	Wed, 11 Jun 2025 01:07:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1749622057;
	bh=4L68Nrxo7rMbC2eLrKnEUhSw4TmNUcJF/4PaM7VQteg=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=q3N6BKUN6I7Y8RnobdrHtJihLZI9OCD5OAGJTR/kAerxyk9uXA30yrExTomjcLeqX
	 MtJi2iI65BiPX4H1FuIBL/O/VMVCAyGyei+4xu5bL4VwgorHr6dg7ulltm4U3Tn1Nx
	 Qh0LFRAXoaCU06ZI70XF201PX6F6JbnYICotsGDM=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55B67bZ71502361
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 11 Jun 2025 01:07:37 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 11
 Jun 2025 01:07:36 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 11 Jun 2025 01:07:36 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55B67ZBg4072016;
	Wed, 11 Jun 2025 01:07:36 -0500
Date: Wed, 11 Jun 2025 11:37:35 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Saravana Kannan <saravanak@google.com>, Stephen Boyd <sboyd@kernel.org>,
        <linux-pm@vger.kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Grzeschik
	<m.grzeschik@pengutronix.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Abel
 Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@oss.nxp.com>,
        Tomi Valkeinen
	<tomi.valkeinen@ideasonboard.com>,
        Johan Hovold <johan@kernel.org>,
        Maulik
 Shah <maulik.shah@oss.qualcomm.com>,
        Michal Simek <michal.simek@amd.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Thierry Reding
	<thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 01/21] pmdomain: core: Use of_fwnode_handle()
Message-ID: <20250611060735.gdnnckw7ysrny526@lcpd911>
References: <20250523134025.75130-1-ulf.hansson@linaro.org>
 <20250523134025.75130-2-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250523134025.75130-2-ulf.hansson@linaro.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On May 23, 2025 at 15:39:58 +0200, Ulf Hansson wrote:
> Let's avoid accessing the np->fwnode directly and use the common helper
> of_fwnode_handle() instead.
> 
> Suggested-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

