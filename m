Return-Path: <linux-pm+bounces-35782-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADDBBC10D8
	for <lists+linux-pm@lfdr.de>; Tue, 07 Oct 2025 12:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32F853C0E88
	for <lists+linux-pm@lfdr.de>; Tue,  7 Oct 2025 10:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71F02D7DF8;
	Tue,  7 Oct 2025 10:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JDPukr/S"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABA02D6E6E;
	Tue,  7 Oct 2025 10:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759834482; cv=none; b=UzDWT5Dt9z0Fxzxv1nEE03kkjPE66Tn90a2DCaECPeQCNsmWBgs1j682WNeymZFqXKOPaG6n7V+X54L+ga3YxzDsRU6L1Hd7lk4Tb9OTuzu4xiYyLad3F2dpwN2E/Ebnvm2qiqMTMcxsnpuXsO+20ROWyxFVW47R6vb26KhP0Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759834482; c=relaxed/simple;
	bh=u++xuxmfY7yUa0CDs/pPu9JMySam+ko+Di/CayzFiOc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMjrOeABlZWUiRCiGe6Ld6o+wIl5IeY/QUe1TW4va9duvTfEzbhsmncKvV77k9a1kCmgK6nr4Z5KIquyKGhX2pwqdlS3/tGl99x2qt5A7qx6E4TsXOtGGK8B6xHJnusnkRWjlaJrpoPEGjkKL1BMshu/ZV6OjEZbinbFuyY9ODw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JDPukr/S; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 597As0eU064331;
	Tue, 7 Oct 2025 05:54:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1759834440;
	bh=qRXHLbRBDsuSDZ3JRGY2OvYgbs7ujLbpdTE0+o8E2EQ=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=JDPukr/S3NeMkpra/lCjbMz4mDcIOWzuywKysPN7YsCQ6JU30an5ju1YxNeEH45mC
	 Fn8taa/iuxbGpNEqXUSmEQ4f57QTZspHNQcuENHNttHulSwir2Fym2WI0w0DpvbfLy
	 7d/akc9AOvjLTpa784veuIY4izGJUiPzqaC++MiY=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 597As0XT2923797
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 7 Oct 2025 05:54:00 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 7
 Oct 2025 05:54:00 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 7 Oct 2025 05:54:00 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 597ArwX71007621;
	Tue, 7 Oct 2025 05:53:59 -0500
Date: Tue, 7 Oct 2025 16:23:58 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Saravana Kannan <saravanak@google.com>,
        "Rafael J . Wysocki"
	<rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
        Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
        Heiko Stuebner
	<heiko@sntech.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sebin
 Francis <sebin.francis@ti.com>,
        Diederik de Haas <didi.debian@cknow.org>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Jon Hunter
	<jonathanh@nvidia.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] driver core: fw_devlink: Don't warn about
 sync_state() pending
Message-ID: <20251007105358.6jgn25jnwjxafz6r@lcpd911>
References: <20251007094312.590819-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251007094312.590819-1-ulf.hansson@linaro.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Oct 07, 2025 at 11:43:12 +0200, Ulf Hansson wrote:
> Due to the wider deployment of the ->sync_state() support, for PM domains
> for example, we are receiving reports about the sync_state() pending
> message that is being logged in fw_devlink_dev_sync_state(). In particular
> as it's printed at the warning level, which is questionable.
> 
> Even if it certainly is useful to know that the ->sync_state() condition
> could not be met, there may be nothing wrong with it. For example, a driver
> may be built as module and are still waiting to be initialized/probed. For
> this reason let's move to the info level for now.
> 
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reported-by: Sebin Francis <sebin.francis@ti.com>
> Reported-by: Diederik de Haas <didi.debian@cknow.org>
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v2:
> 	- Due to discussions on v1 and because the default Kconfig is to use the
> 	FW_DEVLINK_SYNC_STATE_STRICT, I suggest that for now it may be best to
> 	keep the warning level for the "Timed out.." print and only change the
> 	"sync_state pending..." message.
> 
> ---
>  drivers/base/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index d22d6b23e758..c62e428b95b0 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1784,7 +1784,7 @@ static int fw_devlink_dev_sync_state(struct device *dev, void *data)
>  		return 0;
>  
>  	if (fw_devlink_sync_state == FW_DEVLINK_SYNC_STATE_STRICT) {
> -		dev_warn(sup, "sync_state() pending due to %s\n",
> +		dev_info(sup, "sync_state() pending due to %s\n",

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

