Return-Path: <linux-pm+bounces-32808-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA292B2F7E8
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 14:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8C0316BA62
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 12:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D9630BF7D;
	Thu, 21 Aug 2025 12:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vaJ0vgiP"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280318248B;
	Thu, 21 Aug 2025 12:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755779270; cv=none; b=aHmoP3JgL+kyCGIrjJjaApFk4nOb4nl45cqC+gYFn9BRM6ojA+KCR5ycJcNn3YdU+5UZujiPici5rRam7EAP5LfV8PcWIPNnJJKjJmAsMCehLKfl0DxGSzJKFATD0m2Rx/UEFWN9QdVPr0saQ01J+IsfscyI+G2vFNhKEwnNJiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755779270; c=relaxed/simple;
	bh=K1z/73vV5QRw5bhERGRbwvmp+e272T/fDcSoQxBnbbE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8PUihAOs3KnWI6N1eGVn+VyIHAPAGhnYngMgqOb4znlNwftoPtWifSjd7RCbxoELFdS8IJiqdrjVpFS2roGKxPRJF9xqdYjuixwtSdit5Tbh7MbybAfFfUeA6vfWtJtzZhY/BfDvfOwOZ0Pb6NqlKdt52O9mGCxtvLIJROU2Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vaJ0vgiP; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57LCRfix485110;
	Thu, 21 Aug 2025 07:27:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755779261;
	bh=fUfL5bKnDp2X/NiKP63dUX2P6xrzq3fLobwT70t10jM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=vaJ0vgiPuzv3cjC4kGWxErhToHZ6hY+OXaVVTMRK5UUzPWti5Lady/qEf239x9qv1
	 kgGLriP1vdAhQ/AxztGI511KUe+b84sVDxHpT64qqXXKTOJJfdezVJDtu+cTI9/K+M
	 bkfIOEZMC+vHzDrt5bi53wMLlfnms0IoeQv1tneU=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57LCRfvs2526117
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 21 Aug 2025 07:27:41 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 21
 Aug 2025 07:27:41 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 21 Aug 2025 07:27:41 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57LCRfU42146850;
	Thu, 21 Aug 2025 07:27:41 -0500
Date: Thu, 21 Aug 2025 07:27:41 -0500
From: Nishanth Menon <nm@ti.com>
To: Paresh Bhagat <p-bhagat@ti.com>
CC: <vigneshr@ti.com>, <praneeth@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <khasim@ti.com>, <v-singh1@ti.com>, <afd@ti.com>, <bb@ti.com>,
        <s-vadapalli@ti.com>
Subject: Re: [PATCH 0/4] Add cpufreq and USB support for AM62D2
Message-ID: <20250821122741.eqrwystfey7nwvym@outfit>
References: <20250820083331.3412378-1-p-bhagat@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250820083331.3412378-1-p-bhagat@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 14:03-20250820, Paresh Bhagat wrote:
> This patch series introduces following changes:
> 
> * Patch 1 fixes the register length in main_pmx/padconfig for AM62D
>  and AM62A.
> 
> * Patch 2 enables USB support for AM62D2-EVM by adding pinmux and device
>  tree nodes.
> 
> * Patch 3 adds AM62D2 SoC to cpufreq-dt-platdev blacklist so that
>  cpufreq is handled by the ti-cpufreq driver instead of the
>  generic cpufreq-dt driver.
> 
> * Patch 4 extends ti-cpufreq to register AM62D2 SoC support by
>  reusing the am62a7_soc_data.
> 
> Boot Logs-
> https://gist.github.com/paresh-bhagat12/e29d33c3fd92ff17580edf1441ece9f9
> 
> Tech Ref Manual-https://www.ti.com/lit/pdf/sprujd4
> Schematics Link-https://www.ti.com/lit/zip/sprcal5
> 
> Paresh Bhagat (3):
>   arm64: dts: ti: k3-am62d2-evm: Enable USB support
>   cpufreq: dt-platdev: Blacklist ti,am62d2 SoC
>   cpufreq: ti: Add support for AM62D2
> 
> Vibhore Vardhan (1):
>   arm64: dts: ti: k3-am62a-main: Fix pinctrl properties

Please do not mix things up to maintainers. Please post patches #1,2
separately to DT maintainers - these do not have any relationship with
the rest of the driver patches.

> 
>  arch/arm64/boot/dts/ti/k3-am62a-main.dtsi |  2 +-
>  arch/arm64/boot/dts/ti/k3-am62d2-evm.dts  | 21 +++++++++++++++++++++
>  drivers/cpufreq/cpufreq-dt-platdev.c      |  1 +
>  drivers/cpufreq/ti-cpufreq.c              |  2 ++
>  4 files changed, 25 insertions(+), 1 deletion(-)
> 
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource

