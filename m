Return-Path: <linux-pm+bounces-14679-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D4098620A
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 17:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D13B6B2FC1A
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 14:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB5A1A3BAB;
	Wed, 25 Sep 2024 12:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WjrkDDfz"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34CB1A3A86;
	Wed, 25 Sep 2024 12:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727268692; cv=none; b=fWiLLrtS8D8REsf0J2WvTpH+9Ndcr8Kmcg4kFYIs2AW/edk5bi9rNnoD8ABD9Ypkx+Csij0famn3BJWJ7Ntue50YVWNd55HZcKlGR0cLHFrwJX/6pS3Nq62eyV5x71v5UrqvE9lBZKCEvoP+lB20DCEXMsXnGEdP9RS70XMWp1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727268692; c=relaxed/simple;
	bh=XKDJRemG30MdQosPcxnzXCGtHjGACAtGk0mGfKXPlBw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XS8TqzOaRSSCxUa+PA4f38mjY+DrWRty3+kKTlRQ/EXNZ4pi0LL6fRsvQHfyEReiX1lXDXZFmH+K1a4tqzHpqa/fLxKRlSW4A4nqzLL2VL3DWWAKRtau8bvzCDNeWgvNeFOi+N9GfhGgQ79SXMBP8MKTxRl/1QYFtQu7Sx/N0pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WjrkDDfz; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48PCpGQ4053160;
	Wed, 25 Sep 2024 07:51:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727268676;
	bh=hmz4qaO/RbA9PPYEPGz7JVFerhgtzV5gt7TFDktNz2M=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=WjrkDDfzCt1XocZmOL8qayPOgEk0vAeW7kJ46uMUIYaYskzX4QqbpMd5GZpE1I4x8
	 urJ4q3+t7zx1eq4FQXO3gnuUd9dnSpGSFYGTb52j5z5ma5k+OWnriakR+u9iZSYOqQ
	 DIp8j7Wudu0oanrOfb/nGkUnWuHONPACitUYW4SI=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48PCpGBb014077
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 25 Sep 2024 07:51:16 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 25
 Sep 2024 07:51:15 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 25 Sep 2024 07:51:15 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48PCpFx6092503;
	Wed, 25 Sep 2024 07:51:15 -0500
Date: Wed, 25 Sep 2024 07:51:15 -0500
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
Message-ID: <20240925125115.hkdhczffhauy6met@lushly>
References: <20240924-ti-cpufreq-fixes-v5-v5-0-cbe16b9ddb1b@ti.com>
 <20240924121544.62my7eqnudc76orl@subscribe>
 <20240925074738.a43uwqen4dvbd5mc@lcpd911>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240925074738.a43uwqen4dvbd5mc@lcpd911>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 13:17-20240925, Dhruva Gole wrote:
> On Sep 24, 2024 at 07:15:44 -0500, Nishanth Menon wrote:
> > On 15:20-20240924, Dhruva Gole wrote:
> > [...]
> > > 
> > > I am sorry that this breaks compatibility with older AM625 devicetree.
> > > However, the old devicetree was marking the entire wkup_conf as "syscon",
> > > "simple-mfd" which was wrong and needed to be fixed.
> > > 
> > > This series finally tries to bring order to DT and the driver.
> > > 
> > > However, if there is still any way to maintain the backward
> > > compatibility, then I am open to suggestions. Please try
> > > and understand here that the ask for backward compatibility here
> > > is to ask the driver to support a case where the register offset itself
> > > was to be picked from a different node. I am not sure if there's any
> > > cleaner way to do this.
> > 
> > 
> > Have you tried to handle this with quirks? I am not in favor of breaking
> > backward compatibility.
> 
> I was thinking of something on those lines, but quirks makes sense for
> the case that there's a quirky behaviour in the SoC itself. Here it
> seems to me that we are adding a quirk to handle quirk in some old devicetree.
> 
> There's no way to detect the devicetree version or somehow distinguish
> within the driver if it's an old or a new DT. One way I could think of
> is on these lines:

I suggest going and experimenting a bit. Sorry, changes that break
backward compatibility: NAK!

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

