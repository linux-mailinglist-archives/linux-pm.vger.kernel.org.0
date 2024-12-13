Return-Path: <linux-pm+bounces-19183-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 463E69F09FF
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 11:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94973169F7C
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 10:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA851CDA02;
	Fri, 13 Dec 2024 10:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qQAx7WJI"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C1B1C4A17
	for <linux-pm@vger.kernel.org>; Fri, 13 Dec 2024 10:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734086776; cv=none; b=K6+lcx1TVtPbiI7BqC1wLIlcr59fJEl84250w/D6le6Avr/9EOVC2RrKzCWbTvQ88E+uYszFHA8HKmhCwNOmG0Ly/uEL0ek8eubrvO5PyVuwlrIzhV8ZjrGNOELZAVdn/QEiPsxYb28oIMQFBTb3fatTvWsKttXFkv/++KKw/xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734086776; c=relaxed/simple;
	bh=VcQkKTOvIb5LG47DeyZa/TMKe03QanAqg83xylLESVw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZIdm0GdAPbqJz7rOHTApaXAkyJu0d6+FbC+yAbcMmMf8fs9G7Y827juwEnpmKnjaZM22Wili8jzRVMcHSJ8Rz1UZ9Ug7UZR5G/FJ9y9689FY2P6XF0Mc7mRuuLHK1egWYnip4cph/1B54nshptmP/mG0g2FDRy4NCW+5MD2QUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qQAx7WJI; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BDAk0q13134297
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 04:46:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1734086760;
	bh=zZjutz0TCKW9/DTyHlUgHS8db5TF4yO6ee8RIWta+YI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=qQAx7WJIIMvFIWqNEt3oxAGAta0S8HudHAvWNfLDlwyxQ/SQQRCRB07mfRMJn/Z7/
	 3PlNdGDcpv5rDpktSnPU/VwW3jbcrEEFppOdmqdvk/G2TfCI8xNLm1bRrDW672rmWV
	 x4jakMKFva1I1dwGgkK5p2UBhb4lYmCtOiDhCohw=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BDAk0ah015053
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 13 Dec 2024 04:46:00 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 13
 Dec 2024 04:46:00 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 13 Dec 2024 04:46:00 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BDAjxb6081233;
	Fri, 13 Dec 2024 04:46:00 -0600
Date: Fri, 13 Dec 2024 16:15:59 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
CC: <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
        Alexandre Belloni
	<alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] PM: wakeup: implement devm_device_init_wakeup() helper
Message-ID: <20241213104559.x7c5zhrfxdjficaf@lcpd911>
References: <20241213035235.2479642-1-joe@pf.is.s.u-tokyo.ac.jp>
 <20241213092642.sq44raaty2ub6c7s@lcpd911>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241213092642.sq44raaty2ub6c7s@lcpd911>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Dec 13, 2024 at 14:56:42 +0530, Dhruva Gole wrote:
> On Dec 13, 2024 at 12:52:35 +0900, Joe Hattori wrote:
> > Some drivers that enable device wakeup fail to properly disable it
> > during their cleanup, which results in a memory leak.
> > 
> > To address this, introduce devm_device_init_wakeup(), a managed variant
> > of device_init_wakeup(dev, true). With this managed helper, wakeup
> > functionality will be automatically disabled when the device is
> > released, ensuring a more reliable cleanup process.
> > 
> > This need for this addition arose during a previous discussion [1].
> > 
> > [1]:
> > https://lore.kernel.org/linux-rtc/20241212100403.3799667-1-joe@pf.is.s.u-tokyo.ac.jp/
> 
> CC Alexandre who I see is an important part of this thread.

Also, please use Suggested-by: tag as mentioned in
https://www.kernel.org/doc/html/latest/process/submitting-patches.html

A Suggested-by: tag indicates that the patch idea is suggested by the
person named and ensures credit to the person for the idea.

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

