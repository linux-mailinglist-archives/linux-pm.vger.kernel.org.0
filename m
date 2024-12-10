Return-Path: <linux-pm+bounces-18903-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD6F9EAECC
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 11:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC2DC188A22C
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 10:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28003212D9B;
	Tue, 10 Dec 2024 10:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PtkbDjAI"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADA8210F5E;
	Tue, 10 Dec 2024 10:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733828132; cv=none; b=K/yLDAw2Fij9Gva9GqJ1RJJVS1ug9weJFCz19XPVR2AvT8Z/wzCpfFFkSZ+7DDi38p56I2JhG7EJhkrsntUVAdA6KXH/WtKAwQ74RnDU+Ja9+9vskEI5hmfDsSVas98TO4JaNcE9XuZOjdcDwf3oipSirF7dhYfC7Ff8z+JEjLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733828132; c=relaxed/simple;
	bh=Gi2bIkguqNwNyVcCfNzKV8xd3YLKz/BqvuFezhIMlt0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBKhwzXtUUsS+egiTwboIU6IYOkyeiVhDimAW4v0MZrKrKVgZgkJOeH05nWBBoCPnwnDTtXBt/jh/21JHFAnApIQN1Fo4xScoGP697aNEk2cqZ3tO5BmH4u/ni6Za5lAp/qDaGQYWi3QCeG3vgdawzYhtB0dp005vfyPcvGB4lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PtkbDjAI; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BAAtJTT2917336
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 04:55:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733828119;
	bh=vGD6VvVesz9TaXvUHr+lSG6yCgGJWZjixEBsCx87FF8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=PtkbDjAIFQTn/KknoTTMTajSadc+BjNpBnn50RyFBICj6naI3yd2dR3JXLqVai3yI
	 H+SmziJtbpX1Ir0fHJ9GW0m02BqFrL0xlde6G8j/8WURHvLHQHJgrhK7In5NCAHCGt
	 mlQaLq9q9IaBTE/0dY0NPCTpoKOSfT57hLAj5EBA=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BAAtJRm114297
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 10 Dec 2024 04:55:19 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 10
 Dec 2024 04:55:18 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 10 Dec 2024 04:55:18 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BAAtHMZ130180;
	Tue, 10 Dec 2024 04:55:18 -0600
Date: Tue, 10 Dec 2024 16:25:17 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Kevin Hilman <khilman@baylibre.com>
CC: Ulf Hansson <ulf.hansson@linaro.org>, <linux-pm@vger.kernel.org>,
        Nishanth
 Menon <nm@ti.com>, Akashdeep Kaur <a-kaur@ti.com>,
        Sebin Francis
	<sebin.francis@ti.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 3/3] pmdomain: ti_sci: handle wake IRQs for IO daisy
 chain wakeups
Message-ID: <20241210105517.ms7twggosr2rs72m@lcpd911>
References: <20241206-lpm-v6-10-constraints-pmdomain-v6-0-833980158c68@baylibre.com>
 <20241206-lpm-v6-10-constraints-pmdomain-v6-3-833980158c68@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241206-lpm-v6-10-constraints-pmdomain-v6-3-833980158c68@baylibre.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Dec 06, 2024 at 14:12:52 -0800, Kevin Hilman wrote:
> When a device supports IO daisy-chain wakeups, it uses a dedicated
> wake IRQ.  Devices with IO daisy-chain wakeups enabled should not set
> wakeup constraints since these can happen even from deep power states,
> so should not prevent the DM from picking deep power states.
> 
> Wake IRQs are set with dev_pm_set_wake_irq() or
> dev_pm_set_dedicated_wake_irq().  The latter is used by the serial
> driver used on K3 platforms (drivers/tty/serial/8250/8250_omap.c)
> when the interrupts-extended property is used to describe the
> dedicated wakeup interrupt.
> 
> Detect these wake IRQs in the suspend path, and if set, skip sending
> constraint.
> 
> Tested-by: Dhruva Gole <d-gole@ti.com>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> ---

Reviewed-by: Dhruva Gole <d-gole@ti.com>


-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

