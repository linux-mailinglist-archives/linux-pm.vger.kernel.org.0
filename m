Return-Path: <linux-pm+bounces-14612-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FB39845C6
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2024 14:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF89283834
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2024 12:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA97E1A4F21;
	Tue, 24 Sep 2024 12:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XDJWlRvo"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8981F5FF;
	Tue, 24 Sep 2024 12:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727180156; cv=none; b=c4yPpnncGoPRPRWF95R+FsRK5AUDA/EN1iqKKhaRgVu4STEEWw6/zUUgp4exTxtTCajA7sPeQVvQIuK8iNhz8ZLX/z/X1C/Y+FWAbpzpV4AcwkpH3adV/sE+OUN8E/rgXPbik+9ZprgQ02b2Iyj0pvqL4w2OJcWQusFnqJqHf8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727180156; c=relaxed/simple;
	bh=AOps8cGhPiFtT/KNmA1Dft44lgDw5MO3ktyTCH3A2Bs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvhjkqiX4yBY7iPg1Ejr+XoXtFqwpgmNOZ0SyQV5MWvCbeAv0tbVumwaAW1v2bsXN4ZKoredolb2gIpS2mZlVANq3BOsrjDHxYM2EzzUNND8ICb43/++lEDjrT9v4U8w5g7igzUcDzJedu9BYGjrkM8tCofe6pp4cP3kDPObMk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XDJWlRvo; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48OCFiMu110715;
	Tue, 24 Sep 2024 07:15:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727180145;
	bh=LAOtKMRxpTwXeU3Hg8M5csb7fMwA7iWF4uLxR8Q9/X4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=XDJWlRvokze7kmtQHx3h7BAvsnMpv9JQhno9adr3uoj+2LyQebzKinoj1MzhlJwah
	 yZUkOeL0ijSao70htFg5Xv+rk0SVVQgNHkkTC7FablGGc07yiQCGPsurY2OyRu6Hyk
	 soBjU9ucflNUWDF3qWRuKIcMtS9z2Bii/vlVUCyE=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48OCFiXR085220
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 24 Sep 2024 07:15:44 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 24
 Sep 2024 07:15:44 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 24 Sep 2024 07:15:44 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48OCFinX064170;
	Tue, 24 Sep 2024 07:15:44 -0500
Date: Tue, 24 Sep 2024 07:15:44 -0500
From: Nishanth Menon <nm@ti.com>
To: Dhruva Gole <d-gole@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>, Bryan Brattlof <bb@ti.com>
Subject: Re: [PATCH v5 0/6] ti: k3-am62{a,p}x-sk: add opp frequencies
Message-ID: <20240924121544.62my7eqnudc76orl@subscribe>
References: <20240924-ti-cpufreq-fixes-v5-v5-0-cbe16b9ddb1b@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240924-ti-cpufreq-fixes-v5-v5-0-cbe16b9ddb1b@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 15:20-20240924, Dhruva Gole wrote:
[...]
> 
> I am sorry that this breaks compatibility with older AM625 devicetree.
> However, the old devicetree was marking the entire wkup_conf as "syscon",
> "simple-mfd" which was wrong and needed to be fixed.
> 
> This series finally tries to bring order to DT and the driver.
> 
> However, if there is still any way to maintain the backward
> compatibility, then I am open to suggestions. Please try
> and understand here that the ask for backward compatibility here
> is to ask the driver to support a case where the register offset itself
> was to be picked from a different node. I am not sure if there's any
> cleaner way to do this.


Have you tried to handle this with quirks? I am not in favor of breaking
backward compatibility.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

