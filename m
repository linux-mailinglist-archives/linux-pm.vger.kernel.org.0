Return-Path: <linux-pm+bounces-15095-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD2298EC1E
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 11:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AD99B22156
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 09:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FEB14601C;
	Thu,  3 Oct 2024 09:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="F/0jDQt5"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51EF14431B;
	Thu,  3 Oct 2024 09:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727946835; cv=none; b=lbyFkubhFrbXdzB9jZZgolS/azz6ycqViAe3Y0zV3VNZdziTg7u3RgXVCiaobZ8Eu6UHXdC6I2mw8/YIrirZvxeAv8WDv5YvQ/yXE0RlVeAG1RxvIU1ki+j36/SfH+xV8fQnf/TSMOGjdxs1I59RXAOYtFi0mjDSzqRYAPvD6hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727946835; c=relaxed/simple;
	bh=toM0gEntkHjlBdR+blvrK5iEU20Q5GbOQW2p2SGFFxI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BV2kSAm7ykZpLgaVP4uMa7sNGPHXY/t9rcTS/tHR/Bc6OCO6ZpQP7EyUVGxT1KrRLGJ5UBF/DRX6OK3ydd4geN1DzkGK6vdeszJKCCRBcmc1MOkpgDIvyu+9Q1kPcJY1yAQl/kkL8/3PH1ANz1/nXT7UrPH2POvzXKBujAcdzCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=F/0jDQt5; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4939Dhdt122708;
	Thu, 3 Oct 2024 04:13:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727946823;
	bh=svebMRmilDSAYnzcIPP+zNnJjL2aKZ4U6KKBYyGGxn0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=F/0jDQt5N/KC2Q0rZ3EePbJSN6nKNaE/vv/Xpf9o+7dV1HZxbtYzQw6hUDVPDq6cI
	 pPSk6iESRYdQ4c28wZLl+areNFG1YeiIk688PJaq93pY2+eAFwtUdGUjWKig2pfKj1
	 3tPw0Xlo/0rz8jh67f32gkOn2qS31G0YoUbtJINw=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4939DhLu026511
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 3 Oct 2024 04:13:43 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Oct 2024 04:13:42 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Oct 2024 04:13:42 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4939Df77128905;
	Thu, 3 Oct 2024 04:13:42 -0500
Date: Thu, 3 Oct 2024 14:43:41 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bryan Brattlof <bb@ti.com>,
        Nishanth Menon
	<nm@ti.com>, Andrew Davis <afd@ti.com>,
        Lee Jones <lee@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Mark
 Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/2] ti-cpufreq: AM62: Backward compatibility for syscon
 and update offsets
Message-ID: <20241003091341.elvgzscchqngmgod@lcpd911>
References: <20240930-b4-ti-cpufreq-am62-quirk-v1-0-b5e04f0f899b@ti.com>
 <20241001075759.o2a6vhjia5sl6vhr@lcpd911>
 <20241001080400.diqfgbkje77pjby7@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241001080400.diqfgbkje77pjby7@vireshk-i7>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Viresh,

On Oct 01, 2024 at 13:34:00 +0530, Viresh Kumar wrote:
> On 01-10-24, 13:27, Dhruva Gole wrote:
> > On Sep 30, 2024 at 15:02:08 +0530, Dhruva Gole wrote:
> > > With the Silicon revision being taken directly from socinfo, there's no
> > > longer any need for reading any SOC register for revision from this driver.
> > > Hence, we do not require any rev_offset for AM62 family of devices.
> > > 
> > > Also, maintain the backward compatibility with old devicetree, and hence
> > > add condition to handle the case where we have the zero offset such that we
> > > don't end up reading the wrong register offset in new AM625 DTs whenever we fix
> > > them up.
> > > 
> > > These patches have been in discussion as part of another series, which is now
> > > being split up as per discussions with Nishanth. Ref. the following link for
> > > more context on the same:
> > > https://lore.kernel.org/all/20240926-ti-cpufreq-fixes-v5-v7-0-3c94c398fe8f@ti.com/
> > > 
> > > **DEPENDS ON:**
> > > "mfd: syscon: Use regmap max_register_is_0 as needed"
> > > https://lore.kernel.org/linux-arm-kernel/20240903184710.1552067-1-nm@ti.com/
> > 
> > Just an update, the above dependency patch is now taken in by Lee Jones [1].
> > Waiting for it to finally appear in -next.
> > 
> > + Lee just because we are users of that patch.
> > 
> > [1]
> > https://lore.kernel.org/linux-arm-kernel/172770742318.523866.16912261914335612487.b4-ty@kernel.org/
> 
> Ping me once this series is ready to be applied and all dependencies
> are merged somewhere I can rebase.

I can see the dependency is part of next-20241003, please feel free to pick the
series now if it looks ok to you.

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

