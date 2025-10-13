Return-Path: <linux-pm+bounces-35962-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DADB4BD2F47
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 14:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17259189E36C
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 12:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D9826E718;
	Mon, 13 Oct 2025 12:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vi+kvkAZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928C0253951;
	Mon, 13 Oct 2025 12:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760358297; cv=none; b=g9LEUEVTGAebVP6O90juMz5ruvDSick8ksgp77xSiRKucraaDKZjTWRMrFHgprgNf2k4DL58P4bOtyjFpGSa9Vl44ryoAO+EBdZrRHglEPUYNKXJkQY8ar5uBIU9sY+zI1IFr/XF2+fnepJe55wKiCGBDIf+mDem169fUSw/uvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760358297; c=relaxed/simple;
	bh=BQtuvlp3qDa0kOOKHkXJjR36iCBMqpE3O78moZ1Ifto=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=D4THOAPoVv86rQvkd5LCD+jP/2c9o437Sp44QbvDBfMsso3sEZvVg/gM8ReDw2aZLgtIHBLyI1v9Gi3D1wf8QoPNexVQTuXEhwLv/pBb2UBQtn3zRQct/4QUKTWFH10fUumc7ocggbCC12S5kW6eyJR5/wz2PDyxb3HKmfa/qn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vi+kvkAZ; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59DCOHts819446;
	Mon, 13 Oct 2025 07:24:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1760358257;
	bh=ri1nfMxiQBO4KBesq7BXBzulmGX4m0aO13eZuQEBwas=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=vi+kvkAZ5nS/O7iiVbdUigRSBJAt7vLc69XxGWip5mV4v0pNaF9I0iqrJKm8GsLvG
	 Gkd8uHellZFBbNj3Tf6vvnzeAcKa5hzYbLxKlWzMebIuGI553X+Z2DS826U0q/2Ot1
	 rAQILyHV6Ls+QPuHlAHa8uLOuwtEVicV+Z+Gaq20=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59DCOGMD2951310
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 13 Oct 2025 07:24:16 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 13
 Oct 2025 07:24:16 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 13 Oct 2025 07:24:16 -0500
Received: from [172.24.233.14] (shark.dhcp.ti.com [172.24.233.14])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59DCOCkV2045134;
	Mon, 13 Oct 2025 07:24:12 -0500
Message-ID: <88b11fb5-91c0-4ab2-9e63-a4d2b745468b@ti.com>
Date: Mon, 13 Oct 2025 17:54:11 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] driver core: fw_devlink: Don't warn about sync_state()
 pending
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Saravana Kannan
	<saravanak@google.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pm@vger.kernel.org>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
        Nicolas Frattaroli
	<nicolas.frattaroli@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Diederik de Haas
	<didi.debian@cknow.org>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20251007094312.590819-1-ulf.hansson@linaro.org>
Content-Language: en-US
From: Sebin Francis <sebin.francis@ti.com>
In-Reply-To: <20251007094312.590819-1-ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi,

On 07/10/25 15:13, Ulf Hansson wrote:
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

Reviewed-by: Sebin Francis <sebin.francis@ti.com>
Tested-by: Sebin Francis <sebin.francis@ti.com>

-- Sebin

> 
> Changes in v2:
> 	- Due to discussions on v1 and because the default Kconfig is to use the
> 	FW_DEVLINK_SYNC_STATE_STRICT, I suggest that for now it may be best to
> 	keep the warning level for the "Timed out.." print and only change the
> 	"sync_state pending..." message.
> 
> ---
>   drivers/base/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index d22d6b23e758..c62e428b95b0 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1784,7 +1784,7 @@ static int fw_devlink_dev_sync_state(struct device *dev, void *data)
>   		return 0;
>   
>   	if (fw_devlink_sync_state == FW_DEVLINK_SYNC_STATE_STRICT) {
> -		dev_warn(sup, "sync_state() pending due to %s\n",
> +		dev_info(sup, "sync_state() pending due to %s\n",
>   			 dev_name(link->consumer));
>   		return 0;
>   	}

