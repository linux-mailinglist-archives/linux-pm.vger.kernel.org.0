Return-Path: <linux-pm+bounces-30565-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 926C9B001AA
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 14:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79D011C88366
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 12:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FCC25229C;
	Thu, 10 Jul 2025 12:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kuJjdzKF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0DB24C068
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 12:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752150419; cv=none; b=TyyU30Jv+e1SOwlcmXt3YOmGv+brv2R8Uv2jVhSe3OfsjVWU0869ND7Lr8/ZCUqi2BOYUFvqoeHtST1uylfsh7W4vCtPe8kl+YUVMU5ciEPaS/4qOM+jjfM3WDDO06duV3OC8tFCgd/CH5LqfmI1qeJ+Iqc/hHCYgBGbNq9jio0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752150419; c=relaxed/simple;
	bh=Zjt6Z7VIw7JQUZVnhJKSv50IULygtlhHmMKIpQV5MnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=D+ka0TdXu7bLTGLKDRGL9FEEg2COddH5E4OO6Uve5cGJP1zmXuVRuMuLH3RsGR7akqSj7j27NNFZDrorIVtRnk18uTcO+ZQtcIDSUTU2pe/xXuCP7vqX3alA3gsBhE79H+Yt5HEPH9zP91YsRBYxtoLV/BHfzywJn/SWrM04NIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=kuJjdzKF; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250710122654euoutp013664ee10730698650cccd25494b0c17a~Q44TF-xXz1236512365euoutp01g
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 12:26:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250710122654euoutp013664ee10730698650cccd25494b0c17a~Q44TF-xXz1236512365euoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1752150414;
	bh=D/oWQEudpESa3h5p25FZ2E/peR9srzu3zLywQospGPM=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=kuJjdzKFrQrPl6guBdNHnmzta9I3S5ng7rIMZbSj6LmBH1ogtj39zUKoZvvREbeaN
	 NmbHpEDc5PurEoaRLa3Iau9o2Fc+JVY/L+Ntad4xAfN7AtmK3UhYCEfOLjbJP2rykf
	 BfkD5LetV4o3GLXom+6g/gBvnr4CIu/8exE01jCU=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250710122654eucas1p20f1179a9ff22d562d89252f924d34dae~Q44Stx9J21669716697eucas1p26;
	Thu, 10 Jul 2025 12:26:54 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250710122652eusmtip1205fb97fbbf5070e4fbdb96b09b6fb55~Q44RtpbyU1085010850eusmtip1Z;
	Thu, 10 Jul 2025 12:26:52 +0000 (GMT)
Message-ID: <212a1a56-08a5-48a5-9e98-23de632168d0@samsung.com>
Date: Thu, 10 Jul 2025 14:26:52 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 21/24] pmdomain: core: Leave powered-on genpds on
 until late_initcall_sync
To: Ulf Hansson <ulf.hansson@linaro.org>, Saravana Kannan
	<saravanak@google.com>, Stephen Boyd <sboyd@kernel.org>,
	linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Michael Grzeschik
	<m.grzeschik@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, Abel
	Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@oss.nxp.com>, Tomi Valkeinen
	<tomi.valkeinen@ideasonboard.com>, Johan Hovold <johan@kernel.org>, Maulik
	Shah <maulik.shah@oss.qualcomm.com>, Michal Simek <michal.simek@amd.com>,
	Konrad Dybcio <konradybcio@kernel.org>, Thierry Reding
	<thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Hiago De
	Franco <hiago.franco@toradex.com>, Geert Uytterhoeven
	<geert@linux-m68k.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250701114733.636510-22-ulf.hansson@linaro.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250710122654eucas1p20f1179a9ff22d562d89252f924d34dae
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250710122654eucas1p20f1179a9ff22d562d89252f924d34dae
X-EPHeader: CA
X-CMS-RootMailID: 20250710122654eucas1p20f1179a9ff22d562d89252f924d34dae
References: <20250701114733.636510-1-ulf.hansson@linaro.org>
	<20250701114733.636510-22-ulf.hansson@linaro.org>
	<CGME20250710122654eucas1p20f1179a9ff22d562d89252f924d34dae@eucas1p2.samsung.com>

On 01.07.2025 13:47, Ulf Hansson wrote:
> Powering-off a genpd that was on during boot, before all of its consumer
> devices have been probed, is certainly prone to problems.
>
> As a step to improve this situation, let's prevent these genpds from being
> powered-off until genpd_power_off_unused() gets called, which is a
> late_initcall_sync().
>
> Note that, this still doesn't guarantee that all the consumer devices has
> been probed before we allow to power-off the genpds. Yet, this should be a
> step in the right direction.
>
> Suggested-by: Saravana Kannan <saravanak@google.com>
> Tested-by: Hiago De Franco <hiago.franco@toradex.com> # Colibri iMX8X
> Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> # TI AM62A,Xilinx ZynqMP ZCU106
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

This change has a side effect on some Exynos based boards, which have 
display and bootloader is configured to setup a splash screen on it. 
Since today's linux-next, those boards fails to boot, because of the 
IOMMU page fault.

This happens because the display controller is enabled and configured to 
perform the scanout from the spash-screen buffer until the respective 
driver will reset it in driver probe() function. This however doesn't 
work with IOMMU, which is being probed earlier than the display 
controller driver, what in turn causes IOMMU page fault once the IOMMU 
driver gets attached. This worked before applying this patch, because 
the power domain of display controller was simply turned off early 
effectively reseting the display controller.

This has been discussed a bit recently: 
https://lore.kernel.org/all/544ad69cba52a9b87447e3ac1c7fa8c3@disroot.org/ 
and I can add a workaround for this issue in the bootloaders of those 
boards, but this is something that has to be somehow addressed in a 
generic way.

> ---
>   drivers/pmdomain/core.c   | 10 ++++++++--
>   include/linux/pm_domain.h |  1 +
>   2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 5cef6de60c72..18951ed6295d 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -931,11 +931,12 @@ static void genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
>   	 * The domain is already in the "power off" state.
>   	 * System suspend is in progress.
>   	 * The domain is configured as always on.
> +	 * The domain was on at boot and still need to stay on.
>   	 * The domain has a subdomain being powered on.
>   	 */
>   	if (!genpd_status_on(genpd) || genpd->prepared_count > 0 ||
>   	    genpd_is_always_on(genpd) || genpd_is_rpm_always_on(genpd) ||
> -	    atomic_read(&genpd->sd_count) > 0)
> +	    genpd->stay_on || atomic_read(&genpd->sd_count) > 0)
>   		return;
>   
>   	/*
> @@ -1346,8 +1347,12 @@ static int __init genpd_power_off_unused(void)
>   	pr_info("genpd: Disabling unused power domains\n");
>   	mutex_lock(&gpd_list_lock);
>   
> -	list_for_each_entry(genpd, &gpd_list, gpd_list_node)
> +	list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
> +		genpd_lock(genpd);
> +		genpd->stay_on = false;
> +		genpd_unlock(genpd);
>   		genpd_queue_power_off_work(genpd);
> +	}
>   
>   	mutex_unlock(&gpd_list_lock);
>   
> @@ -2352,6 +2357,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>   	INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn);
>   	atomic_set(&genpd->sd_count, 0);
>   	genpd->status = is_off ? GENPD_STATE_OFF : GENPD_STATE_ON;
> +	genpd->stay_on = !is_off;
>   	genpd->sync_state = GENPD_SYNC_STATE_OFF;
>   	genpd->device_count = 0;
>   	genpd->provider = NULL;
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index d68e07dadc99..99556589f45e 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -199,6 +199,7 @@ struct generic_pm_domain {
>   	unsigned int performance_state;	/* Aggregated max performance state */
>   	cpumask_var_t cpus;		/* A cpumask of the attached CPUs */
>   	bool synced_poweroff;		/* A consumer needs a synced poweroff */
> +	bool stay_on;			/* Stay powered-on during boot. */
>   	enum genpd_sync_state sync_state; /* How sync_state is managed. */
>   	int (*power_off)(struct generic_pm_domain *domain);
>   	int (*power_on)(struct generic_pm_domain *domain);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


