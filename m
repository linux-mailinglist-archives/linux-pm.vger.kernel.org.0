Return-Path: <linux-pm+bounces-15109-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B22A98F4EB
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 19:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD0E51C215A4
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 17:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CEA1A7274;
	Thu,  3 Oct 2024 17:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LIxbWcJq"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23004437A;
	Thu,  3 Oct 2024 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727975636; cv=none; b=eK7QymiiWc3czydhVEyaXoOdEnP6ndUxvf7McY+OeLPS0DN/wsBOFhYIILq86t8z0VAHScvAotZEIGiDgMdETFfhCZSqYKyP41gYf3SRzG8bLA2DjN3fuDJogXkK56hAmyW2X8IHFVorvuhNlh0Ura4g9ljCqsPmYPxiBumDqvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727975636; c=relaxed/simple;
	bh=rbWD1+LFustzIuZaQ6YDhcX394IMWgj7jiSYvQ6q30s=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSZ68br1EX5uqhjQN93p3Dm0cTjZIQ0/uwHMm8P6D7wxHqs3BZCU5V8rQoaY832FBcELBLq4WpRipPc+BBX57nOUkJ7EyCBn5YtsZB8fBchrh1BxJh3np8jhI0gYAYf2MMGv3sqoVD+z9+XbUPPxoj+bp46Yj0xboHAXyXVjnzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LIxbWcJq; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 493HDpnF024904;
	Thu, 3 Oct 2024 12:13:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727975631;
	bh=/8xoHmjc+oS5dM4baNPWgEOjissMpkCPZbU7tl+aXdU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=LIxbWcJqAVo4MuhlORhiZ5sCM7FDm3MuY0dbFsaP/6bj429DJuRjObQTPMlV/ohz+
	 utWdqru0Bxpk1fru7ZGbibY8dLBADZs9lc0uixMA5CAkjZwdVtcFJ8aYWZas/tA7Ds
	 48UgXu/y4neHp/dE1mAOR42vB7OnSZSsYmS25WBc=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 493HDp1o057900
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 3 Oct 2024 12:13:51 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Oct 2024 12:13:49 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Oct 2024 12:13:49 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 493HDnFY049115;
	Thu, 3 Oct 2024 12:13:49 -0500
Date: Thu, 3 Oct 2024 12:13:49 -0500
From: Nishanth Menon <nm@ti.com>
To: Dhruva Gole <d-gole@ti.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar
	<viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bryan Brattlof <bb@ti.com>,
        Andrew Davis
	<afd@ti.com>
Subject: Re: [PATCH 0/2] ti-cpufreq: AM62: Backward compatibility for syscon
 and update offsets
Message-ID: <20241003171349.lphhvxy7lgwwdhay@marital>
References: <20240930-b4-ti-cpufreq-am62-quirk-v1-0-b5e04f0f899b@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240930-b4-ti-cpufreq-am62-quirk-v1-0-b5e04f0f899b@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 15:02-20240930, Dhruva Gole wrote:
> With the Silicon revision being taken directly from socinfo, there's no
> longer any need for reading any SOC register for revision from this driver.
> Hence, we do not require any rev_offset for AM62 family of devices.
> 
> Also, maintain the backward compatibility with old devicetree, and hence
> add condition to handle the case where we have the zero offset such that we
> don't end up reading the wrong register offset in new AM625 DTs whenever we fix
> them up.
> 
> These patches have been in discussion as part of another series, which is now
> being split up as per discussions with Nishanth. Ref. the following link for
> more context on the same:
> https://lore.kernel.org/all/20240926-ti-cpufreq-fixes-v5-v7-0-3c94c398fe8f@ti.com/
> 
> **DEPENDS ON:**
> "mfd: syscon: Use regmap max_register_is_0 as needed"
> https://lore.kernel.org/linux-arm-kernel/20240903184710.1552067-1-nm@ti.com/
> 
> This series has been tested on AM625 on top of above patch:
> https://gist.github.com/DhruvaG2000/40b80cc04a9ac90c86445d6e67ece4cb
> 
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
> Dhruva Gole (2):
>       cpufreq: ti-cpufreq: Allow backward compatibility for efuse syscon
>       cpufreq: ti-cpufreq: Remove revision offsets in AM62 family
> 
>  drivers/cpufreq/ti-cpufreq.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> ---
> base-commit: cea5425829f77e476b03702426f6b3701299b925
> change-id: 20240930-b4-ti-cpufreq-am62-quirk-46242e3daa2b
> 
> Best regards,
> -- 
> Dhruva Gole <d-gole@ti.com>
> 

Reviewed-by: Nishanth Menon <nm@ti.com>

Viresh,

The existing device tree works with this changes even without the
dependency being merged. DT update can happen in the next window once
the pieces are merged together.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

