Return-Path: <linux-pm+bounces-28964-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 590DBADED27
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 14:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 914223BA7EA
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 12:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F0F2E3B14;
	Wed, 18 Jun 2025 12:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HeSEi6Bo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461E42E06EF
	for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 12:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750251498; cv=none; b=IAEW1SriHPhJ70tLvkeaYJN+/3Y9pCFacnc7rL6UpPCIprxefpfQC+TZjbthINPzo9pLjexdjXe3l93DpGAMWetgo9OKYdt1Vd+FRI9M3y4DOUEmo1D1XldN7v/8wlznBZ9TYqTuevrjyUhm3364YagIiCzSl/h2r0oTW85d6rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750251498; c=relaxed/simple;
	bh=oLYQh3tHQchsKx90QxqR/zEu2gUWNemVv3MveM+gyOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=QwJ1fACfMYfUCAP4E5gfCv5/0FuJ1Xt4z0OGxTQx9tJjN+qJNNpIDbrZnUeJpc2mG97uA7IVbgb+m+5gbHTT5r58DJ0gTSzIcP/XUZ2fwn2HimoZNu5rjoTIeaEVyo9VELpYVMpzxBy6ncDd+Au+pqE5ClmuKFMzgfGsfya/o5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=HeSEi6Bo; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250618125813euoutp02b1ff7b604e8fe44d00c3ccc0bd3b7cc8~KJHXFGPXa0883708837euoutp02W
	for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 12:58:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250618125813euoutp02b1ff7b604e8fe44d00c3ccc0bd3b7cc8~KJHXFGPXa0883708837euoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750251493;
	bh=fspd5e54mfMI6aa1OpsBB/dqGjkj7jaOpc4EH06UMKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HeSEi6BoetPrdRExaNto6pbVCX9/4dRHlYYaUeUVpUQt/IGMnW06+0U4IRL4NJEIA
	 DktiAHaJ1j+FrmFJL4mDT8NBE03hLVRdjVqs4OEwk1mLvwpt6zXMK97OteZKrGkt2E
	 exIk0AMNabBxk1H5UpwpzPsvxNWTuV5fjr2aDmU4=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250618125812eucas1p11a1ab5210d4efa95a51b3bc7c4f0924d~KJHWqi6Rd0340003400eucas1p1l;
	Wed, 18 Jun 2025 12:58:12 +0000 (GMT)
Received: from AMDC4515.digital.local (unknown [106.120.51.28]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250618125812eusmtip2b1f7a7d239a1b83dd4fe9a93315b1bca~KJHWEb5oH0417004170eusmtip2Y;
	Wed, 18 Jun 2025 12:58:12 +0000 (GMT)
From: Mateusz Majewski <m.majewski2@samsung.com>
To: linux.amoon@gmail.com
Cc: alim.akhtar@samsung.com, bzolnier@gmail.com, daniel.lezcano@linaro.org,
	krzk@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org,
	rui.zhang@intel.com, Mateusz Majewski <m.majewski2@samsung.com>
Subject: Re: [RRC v1 1/3] thermal/drivers/exynos: Remove unused base_second
 mapping and references
Date: Wed, 18 Jun 2025 14:58:06 +0200
Message-ID: <20250618125806.2260184-1-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250616163831.8138-2-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250618125812eucas1p11a1ab5210d4efa95a51b3bc7c4f0924d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250618125812eucas1p11a1ab5210d4efa95a51b3bc7c4f0924d
X-EPHeader: CA
X-CMS-RootMailID: 20250618125812eucas1p11a1ab5210d4efa95a51b3bc7c4f0924d
References: <20250616163831.8138-2-linux.amoon@gmail.com>
	<CGME20250618125812eucas1p11a1ab5210d4efa95a51b3bc7c4f0924d@eucas1p1.samsung.com>

>  	/* On exynos5420 the triminfo register is in the shared space */
> -	if (data->soc == SOC_ARCH_EXYNOS5420_TRIMINFO)
> -		trim_info = readl(data->base_second + EXYNOS_TMU_REG_TRIMINFO);
> -	else
> +	if (data->soc == SOC_ARCH_EXYNOS5420 ||
> +			data->soc == SOC_ARCH_EXYNOS5420_TRIMINFO) {
>  		trim_info = readl(data->base + EXYNOS_TMU_REG_TRIMINFO);
> -
> -	sanitize_temp_error(data, trim_info);
> +		sanitize_temp_error(data, trim_info);
> +	}

If I understand correctly, this means that the triminfo will no longer
be read on other SoCs calling this function (3250, 4412, 5250, 5260). Is
this intended?

By the way, are we sure that data->base_second really is unnecessary?
According to the bindings documentation (in
Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml),
the different address is necessary because the triminfo registers are
misplaced on 5420.

Thank you,
Mateusz Majewski

