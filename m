Return-Path: <linux-pm+bounces-18902-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B817D9EAEC0
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 11:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BC18188A3F0
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 10:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81152210F7E;
	Tue, 10 Dec 2024 10:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wgRd4+mY"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBBC2153F3;
	Tue, 10 Dec 2024 10:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733828090; cv=none; b=NdTfVcrkL7FC9+aXtAyPy2M21sXqiOzzxgz9VBWqktk/56+AHP/pKfzLhwAif4sTj8hyNdn63BuXGzvVodsVrMeSTWEWxHcmkIkvwvecrPelcM73f/rAeOnw6oMCxEEhoh4mzU21NhkaGmo9GVHkcNZOE/qfIFHtBa2HtOoGEsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733828090; c=relaxed/simple;
	bh=raYuAu/28/SThPjxUtxHsACfQxuWaT55aY0kp935O4I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQWDxQcIRXG6j2Ncj2SL+SDceFV2rR/194ZQ9FVnhwWa6H35LVKEuLbVBUcwQ5CI1+fkNLFKYYRH4DnpcF7Og7kSdQD4gQL9G5PSi7ErmgVGtAqpZGvrOQUPhN83uhfCgA/pprBYkyAmJQxYthDFzdpxLFyyaaliFSJg7SomcGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wgRd4+mY; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BAAsgTp2613926
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 04:54:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733828083;
	bh=0YdXd9Y8093lIHs06QPRUq21ELAyJDWqdOwIJqj/UQo=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=wgRd4+mY0vhSs+f1t54OA/Rid7qxD0UOZIs0njFyF6QxrSYDM51fDD3jni0g/aGyK
	 kUTmAC5E6+paPqxO0VOqiMUkcT9kc2Tmgls+lqqfTKl8ioeAy6/sINAmF6J9KgGXBx
	 gR04NL8bbYV6c0ckiw+q1UHyYBSLBKikp5cbx8Xo=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BAAsgP1013775
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 10 Dec 2024 04:54:42 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 10
 Dec 2024 04:54:42 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 10 Dec 2024 04:54:42 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BAAsf53129407;
	Tue, 10 Dec 2024 04:54:42 -0600
Date: Tue, 10 Dec 2024 16:24:41 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Kevin Hilman <khilman@baylibre.com>
CC: Ulf Hansson <ulf.hansson@linaro.org>, <linux-pm@vger.kernel.org>,
        Nishanth
 Menon <nm@ti.com>, Akashdeep Kaur <a-kaur@ti.com>,
        Sebin Francis
	<sebin.francis@ti.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 2/3] pmdomain: ti_sci: add wakeup constraint management
Message-ID: <20241210105441.wav23zfv25es2jld@lcpd911>
References: <20241206-lpm-v6-10-constraints-pmdomain-v6-0-833980158c68@baylibre.com>
 <20241206-lpm-v6-10-constraints-pmdomain-v6-2-833980158c68@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241206-lpm-v6-10-constraints-pmdomain-v6-2-833980158c68@baylibre.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Dec 06, 2024 at 14:12:51 -0800, Kevin Hilman wrote:
> During system-wide suspend, check all devices connected to PM domain
> to see if they are wakeup-enabled.  If so, set a TI SCI device
> constraint.
> 
> Note: DM firmware clears all constraints on resume.
> 
> Co-developed-by: Vibhore Vardhan <vibhore@ti.com>
> Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Tested-by: Dhruva Gole <d-gole@ti.com>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> ---

Reviewed-by: Dhruva Gole <d-gole@ti.com>


-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

