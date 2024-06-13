Return-Path: <linux-pm+bounces-9078-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F361906AFB
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 13:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B035282A83
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 11:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FBF1411E0;
	Thu, 13 Jun 2024 11:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="J4AoQb9f"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28705BACF;
	Thu, 13 Jun 2024 11:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718278122; cv=none; b=o9YbOR/hPHX4HFtR++1cPD4EdhYP1+S0RuhjU7COGZplgszar0DNceYLjINPd+7BpZFVzHTv7egAJa5brH04M0jOWBF/are4E8tPkQCLxO2zaGJ1R5N9zBsegcztrxjHU697T3Dsn94A1TX3tZJmRjLensaSxReEsEg3d2Bbduw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718278122; c=relaxed/simple;
	bh=xtfQ6y8wG2K3hE651yqjj3k1yUdR3rP5R3gJFB+I5/k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tm2kGAmcuvHmwiQ3B64Gni2UKltQQLBOG9VD5fVed9jB1C0Z1iBqxa6aJOutkszD1/QKWmx0fiPOozGpoY/FXCNAZZjUxXlt75LU8I1H8TiwM9fSg4UGpivYaITdU7svwD/xGXE3+3s1Nw/fmGkRvm4kJjPaMlLegddOmUiw5EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=J4AoQb9f; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45DBSKub049447;
	Thu, 13 Jun 2024 06:28:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718278100;
	bh=jcJB/iXxPJhCEdilWF+GOiSdAG2hiiILKqyaO9GOBj4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=J4AoQb9fDkD2HuaDThwIjDi2K7RQy0v3tUWa7T8vkkfYT34pvzRNal1dgBUO75GRW
	 04lzFZVtUGwLeIy4nQrsa+u5ryEBLNkzn1/r4OwqYtn4mRj8WYhvc+Fhc+WGhRF6Q7
	 4ZHUIc0idZE/4iGB2OlrOHHgU31Nk3ee3Q36oTLM=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45DBSKba031963
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Jun 2024 06:28:20 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jun 2024 06:28:19 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jun 2024 06:28:19 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45DBSJvj072007;
	Thu, 13 Jun 2024 06:28:19 -0500
Date: Thu, 13 Jun 2024 16:58:18 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Bryan Brattlof <bb@ti.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar
	<viresh.kumar@linaro.org>, Lee Jones <lee@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Vibhore Vardhan
	<vibhore@ti.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/5] cpufreq: ti: update OPP table for AM62Ax SoCs
Message-ID: <20240613112818.dqygyb2tbqdi5vsa@dhruva>
References: <20240612-ti-opp-updates-v2-0-422b6747a254@ti.com>
 <20240612-ti-opp-updates-v2-1-422b6747a254@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240612-ti-opp-updates-v2-1-422b6747a254@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Jun 12, 2024 at 18:17:34 -0500, Bryan Brattlof wrote:
> As the AM62Ax SoC family matures more speed grades are being defined.
> These new grades unfortunately no longer align with the AM62x SoC
> family. Define a new table with new OPP speed grade limits for the
> AM62Ax
> 
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>  drivers/cpufreq/ti-cpufreq.c | 59 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c

LGTM,
Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva

