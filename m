Return-Path: <linux-pm+bounces-35267-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAB1B98495
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 07:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AA9E19C37B8
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 05:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF59922D7A9;
	Wed, 24 Sep 2025 05:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FzbHvJVR"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243D233E7;
	Wed, 24 Sep 2025 05:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758691735; cv=none; b=okmLnA/EOGCwfPfSg9J2bcbMX7hcYlRlRZCROaTUts00ni9/dTrafdk3cf5obfI0eHF63U+GHgxwUF0De9V4DwGWMr7wu7ZN0FsQTWs+13euFyTnq5N0Me4j7v0VWMRDoVG4LR3LJsitAPZIi9/idZPvaUQ/QLlDR0llMCwvZCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758691735; c=relaxed/simple;
	bh=8kaaqW3VKKo1EW1pzg++44NLR13dB9DzMrOJw3K1ddU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZ6wxs/tFlWgN8brNJc8q8oFzK9IuVnJOisgXPnGSZ08O/KYkoK/kNTyK4EbRms0SqzGmngY5eOzDvHT+pqvXJ+JWDN6Ot7MfKPzrcXOzlbIRBRDr/b4mpllkKJPnFoZQQtfNuNTLqgPoTQOkUge7DJekrlo2mg2vZ/V669NOQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FzbHvJVR; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58O5Snu01157246;
	Wed, 24 Sep 2025 00:28:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758691729;
	bh=P0TrzKMrnZ5NnnDzQSC50pR7WxXo1MX/Ccq3pXZPSnc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=FzbHvJVRQmIfFinrWYguS9Gq+UuBs3kuGfzpOdyRDenVcGoFwsQ+gnplTW9RQXRvi
	 OsP/oRh2bQj/RNZEePaPnpzNO4VHuK8KxPFVNT1u7Df/IV9MGSJSvDy/UB3QAuLmGK
	 1whMzXrx/PWkKQ3m31Efmq7aJvmnUuuoVgrYzC9Q=
Received: from DFLE20.ent.ti.com (dfle20.ent.ti.com [10.64.6.57])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58O5Smtf3330078
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Sep 2025 00:28:49 -0500
Received: from flwvowa02.ent.ti.com (10.64.41.53) by DFLE20.ent.ti.com
 (10.64.6.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.20; Wed, 24 Sep
 2025 00:28:48 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvowa02.ent.ti.com
 (10.64.41.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.55; Wed, 24 Sep
 2025 00:28:48 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 24 Sep 2025 00:28:48 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58O5SlUU1467804;
	Wed, 24 Sep 2025 00:28:48 -0500
Date: Wed, 24 Sep 2025 10:58:46 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Brian Norris <briannorris@chromium.org>
CC: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] ABI: sysfs-devices-power: Document time units for *_time
Message-ID: <20250924052846.vaoehgsrj5ejanhg@lcpd911>
References: <20250923150625.1.If11a14e33d578369db48d678395d0323bdb01915@changeid>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250923150625.1.If11a14e33d578369db48d678395d0323bdb01915@changeid>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Sep 23, 2025 at 15:06:26 -0700, Brian Norris wrote:
> Many .../power/... time-related attributes have an "_ms" suffix and also
> include language in their ABI description to make clear that their time
> is measured in milliseconds. 'runtime_suspended_time' and
> 'runtime_active_time' have neither, and it takes me a nontrivial amount
> of time to poke through the source to confirm that they are also
> measured in milliseconds.
> 
> Update the doc with "millisecond" units.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

