Return-Path: <linux-pm+bounces-11989-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0175694BB8E
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 12:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 334061C21457
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 10:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E6718A6BA;
	Thu,  8 Aug 2024 10:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wutMQ/7p"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54341119A;
	Thu,  8 Aug 2024 10:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723113992; cv=none; b=u6mGkAMgm/i7JTX72U7gx2UiZqBV8k3uzedRciMrKJnvqFBuKumPJkfnvzdlRjVPpGniES+1hN41XbeXxnTDUvo/ZJPV+ZA1VIk8sb9i9fmn8FfGpb4sop27g2jkGdE3dIWjM10lsw08yn0S2vNz0nvrO4U+iVKImCWPf5kWqIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723113992; c=relaxed/simple;
	bh=x+tZuspA2t+CMCIn/2V9J5WD4Zy3Mhv0AW798+aKarw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Umo3Chnh+S8Vtbc5ai5NI+GEc1Ll9F30URmMGaRcYZL9DjzNkQnIbsBPS3WowpFpFiS2DKHTiGlGF5sICDUG0eudGTMji5Nal9u5tJ3OtsOc7UfwqHEuhAqm+MdfZVMR6huGPlGpW9wKLdsX0vhSkALlAsNkOoe+t0BIcfoHFwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wutMQ/7p; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 478AkFR8123830;
	Thu, 8 Aug 2024 05:46:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723113975;
	bh=WxP0cieu8jSFxPs7H85p6qun5NZTEmwTciJNLXZ3tnc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=wutMQ/7peDtqs6x5XpG3m2RP3oeRyW90es5tC/KyRoCF6Z6nvxS/KM0VIH9wupDxi
	 /dwdNkk2qqRABKfNn3pvA71jeEHnOhGst2aAfxKS5LWxAqBEwJt87S0KIU7BCW75G8
	 tfKFLfhkX8A1Ay8yA7OSl5rGvhqUQz7qbSVmaLE0=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 478AkF3t005718
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Aug 2024 05:46:15 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Aug 2024 05:46:15 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Aug 2024 05:46:15 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 478AkEDe054743;
	Thu, 8 Aug 2024 05:46:15 -0500
Date: Thu, 8 Aug 2024 16:16:14 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Kevin Hilman <khilman@kernel.org>
CC: "Rob Herring (Arm)" <robh@kernel.org>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Andrew Lunn
	<andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian
 Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/6] cpufreq: omap: Drop asm includes
Message-ID: <20240808104614.v5smqbtyretivfkf@lcpd911>
References: <20240806-dt-api-cleanups-v1-0-459e2c840e7d@kernel.org>
 <20240806-dt-api-cleanups-v1-2-459e2c840e7d@kernel.org>
 <7h1q313alv.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7h1q313alv.fsf@baylibre.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Aug 06, 2024 at 09:00:12 -0700, Kevin Hilman wrote:
> "Rob Herring (Arm)" <robh@kernel.org> writes:
> 
> > The omap driver doesn't actually need asm/smp_plat.h, so drop it.
> > asm/cpu.h is not needed either as linux/cpu.h is already included.
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> 
> Acked-by: Kevin Hilman <khilman@baylibre.com>

Reviewed-by: Dhruva Gole <d-gole@ti.com>

> 
> > ---
> >  drivers/cpufreq/omap-cpufreq.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
> > index 3458d5cc9b7f..de8be0a8932d 100644
> > --- a/drivers/cpufreq/omap-cpufreq.c
> > +++ b/drivers/cpufreq/omap-cpufreq.c
> > @@ -28,9 +28,6 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/regulator/consumer.h>
> >  
> > -#include <asm/smp_plat.h>
> > -#include <asm/cpu.h>
> > -
> >  /* OPP tolerance in percentage */
> >  #define	OPP_TOLERANCE	4
> >  
> >
> > -- 
> > 2.43.0
> 

-- 
Best regards,
Dhruva

