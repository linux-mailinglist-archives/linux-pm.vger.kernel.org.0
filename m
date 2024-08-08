Return-Path: <linux-pm+bounces-11990-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7813A94BB9B
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 12:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BD82B21A9A
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 10:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBBF18A6BE;
	Thu,  8 Aug 2024 10:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WlGivwmz"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBB718A6AB;
	Thu,  8 Aug 2024 10:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723114132; cv=none; b=OWfbfbM/+j0gAVSPZG9Q0r+rGeU1+TYk4ViTRDFDitzJNS+hjvWUrBoqVWumna8ic6yeqN1ynlKjD2sEJ6uYxjLcYjnA4aCOItpdkDu83FkMsz61rhBROvJFiawnnUiHW/r8ko4tVSkQAMnLc8RqnT8GCgwNH0Wt9XRrGYc2qv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723114132; c=relaxed/simple;
	bh=nRIXl63nDPqLV3SMDso/XqhtFgjEMVwiJ9bRi8WqJno=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHMEQpTkpxNIdP6oStiw/byYUC46Hdaonbz/tE1k6GnetpVV/Nm+r2ksRupqhqif6mbmaQk86h1bMqie9P+K2Cxt9TZfBqEusVS+djSrqjH9uG8DB/3a/u1X/igoTaoN6BDFwADQ9GNJrwFnLFCOb6FYMV8iJzP4MMDgihgMoSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WlGivwmz; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 478AmfRk124117;
	Thu, 8 Aug 2024 05:48:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723114121;
	bh=UcjNUEpc1q6NesdAYa5nxwxudIHZA2RHgOSEWhpgaw8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=WlGivwmz8iOH692SlUYQe+odmWqDu3WKqwKG7kEY/aBMAwr+tT7DXRlTLjn3IKvMO
	 WF8afhlijzidncQ1ZivcQMbAZizPEDPrxiSPZxIg6Dj3L0nQskA3zRM+Jb+FRIuPHp
	 Hjt05RZKjL7I5kfqUUeiNllet7ISk12TVCQzfajg=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 478AmfRt006815
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Aug 2024 05:48:41 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Aug 2024 05:48:41 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Aug 2024 05:48:41 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 478Ame1q041183;
	Thu, 8 Aug 2024 05:48:40 -0500
Date: Thu, 8 Aug 2024 16:18:39 +0530
From: Dhruva Gole <d-gole@ti.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar
	<viresh.kumar@linaro.org>,
        Kevin Hilman <khilman@kernel.org>, Andrew Lunn
	<andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian
 Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 4/6] opp: ti: Drop unnecessary of_match_ptr()
Message-ID: <20240808104839.honxenpw6zxpbdae@lcpd911>
References: <20240806-dt-api-cleanups-v1-0-459e2c840e7d@kernel.org>
 <20240806-dt-api-cleanups-v1-4-459e2c840e7d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240806-dt-api-cleanups-v1-4-459e2c840e7d@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Aug 06, 2024 at 07:58:25 -0600, Rob Herring (Arm) wrote:
> of_match_ptr() is not necessary as the driver is always enabled for DT.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  drivers/opp/ti-opp-supply.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/opp/ti-opp-supply.c b/drivers/opp/ti-opp-supply.c
> index ec0056a4bb13..5f0fb3ea385b 100644
> --- a/drivers/opp/ti-opp-supply.c
> +++ b/drivers/opp/ti-opp-supply.c
> @@ -405,7 +405,7 @@ static struct platform_driver ti_opp_supply_driver = {
>  	.probe = ti_opp_supply_probe,
>  	.driver = {
>  		   .name = "ti_opp_supply",
> -		   .of_match_table = of_match_ptr(ti_opp_supply_of_match),
> +		   .of_match_table = ti_opp_supply_of_match,

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva

