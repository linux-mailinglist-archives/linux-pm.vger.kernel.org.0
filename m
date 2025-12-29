Return-Path: <linux-pm+bounces-40000-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9362CCE5BE5
	for <lists+linux-pm@lfdr.de>; Mon, 29 Dec 2025 03:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0DDD13011937
	for <lists+linux-pm@lfdr.de>; Mon, 29 Dec 2025 02:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0ADF25A34F;
	Mon, 29 Dec 2025 02:31:49 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315631DE3B7;
	Mon, 29 Dec 2025 02:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766975509; cv=none; b=Qv6lBO/VSsegCGjDzmG8P6kksIAXXdOadocvWhheEYcnc7/EIm5tlW/znv9MFDtRDi/M2G0g9mKIV1DA6bRgeYuOQnALFM97sTApV45p14WCvKS1/m019sSPx20292ER0/zyvmdyhX8ij3bLDtGQ4zq2Ki0z7b9mJgKpiwLF41w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766975509; c=relaxed/simple;
	bh=6qc1F62qczXo3VMWm5+u4o+ZtIYDsje/E8N3I3EUc3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mw3nxZSRJ+6w//xmFVqkJN93mG6seKi2A+4Fi5cxTBZk/vOElpMiR+h++1DzcUWQg5qzITc9SlMU3a9zU7HV2Z543BG0oGwWyPb6EqRqfQglTvzkm06nvFvVaxGqW+LimC2a6j+5y9obmDad4aFMassB6Nr61K8Ltp99MuCHaaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7cd0b086e45e11f0a38c85956e01ac42-20251229
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:18f978c5-3327-44e9-b2ae-3f89edcec8dc,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:0cc5a8830ba3b9066296c750d6ed696f,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	52,EDM:-3,IP:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7cd0b086e45e11f0a38c85956e01ac42-20251229
X-User: luriwen@kylinos.cn
Received: from [10.42.13.61] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luriwen@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1949531141; Mon, 29 Dec 2025 10:31:32 +0800
Message-ID: <ead94047-f1de-4349-99f4-f836382b91d9@kylinos.cn>
Date: Mon, 29 Dec 2025 10:31:29 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PM: sleep: Fix suspend_test() at the TEST_CORE level
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
References: <6251576.lOV4Wx5bFT@rafael.j.wysocki>
Content-Language: en-US
From: luriwen <luriwen@kylinos.cn>
In-Reply-To: <6251576.lOV4Wx5bFT@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2025/12/26 21:50, Rafael J. Wysocki 写道:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Commit a10ad1b10402 ("PM: suspend: Make pm_test delay interruptible by
> wakeup events") replaced mdelay() in suspend_test() with msleep() which
> does not work at the TEST_CORE test level that calls suspend_test()
> while running on one CPU with interrupts off.
>
> Address this by making suspend_test() check if the test level is
> suitable for using msleep() and use mdelay() otherwise.
>
> Fixes: a10ad1b10402 ("PM: suspend: Make pm_test delay interruptible by wakeup events")
> Reported-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Closes: https://lore.kernel.org/linux-pm/aUsAk0k1N9hw8IkY@venus/
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   kernel/power/suspend.c |    9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -349,9 +349,12 @@ static int suspend_test(int level)
>   	if (pm_test_level == level) {
>   		pr_info("suspend debug: Waiting for %d second(s).\n",
>   				pm_test_delay);
> -		for (i = 0; i < pm_test_delay && !pm_wakeup_pending(); i++)
> -			msleep(1000);
> -
> +		for (i = 0; i < pm_test_delay && !pm_wakeup_pending(); i++) {
> +			if (level > TEST_CORE)
> +				msleep(1000);
> +			else
> +				mdelay(1000);
> +		}

Maybe this can be rewritten as follows

		for (i = 0; i < pm_test_delay && !pm_wakeup_pending(); i++)
			level == TEST_CORE ? mdelay(1000) : msleep(1000);

>   		return 1;
>   	}
>   #endif /* !CONFIG_PM_DEBUG */



