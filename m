Return-Path: <linux-pm+bounces-17722-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B136D9D12BF
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 15:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E54AB25AC9
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 14:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4118F19C54B;
	Mon, 18 Nov 2024 14:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="soRGtwuz"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C673199EA3;
	Mon, 18 Nov 2024 14:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731939041; cv=none; b=pS2HRPavUjx3Cj9UzF9rqQsLLYPY17PhrPO/zUMabT7RD8d7UVyD8FyINndHxEhrj9FBJsMywxnXag0cfsme27H9YQVM0jzPVnY2GsIlSULN43BiyTMwaX3Eg7vxrhsZpCZxGE12M9I8N9HLNL37aBiKdssSNhV0Q4XQji0FsYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731939041; c=relaxed/simple;
	bh=0Q6u77/K9IG15gtclWAI+ZLC9LtGOWEKCbPazn2zJnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EDHHHdgrrgi6FJqSwt1KXGh5kJrdttmfSRmamDfKlFY8Ejk9pXByPfQhfb/nsU2hWFFGiYc+FlJ6M8UuQ0u4Hdjfs8zrAlIcdoW32dNwJO8wM03o76cDfzHIW6nSi36Plj543JaWwqTfRZexh7EROv+/rCvgPQmbr/ETmYLWU6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=soRGtwuz; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AIEAXHj089864;
	Mon, 18 Nov 2024 08:10:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1731939033;
	bh=QFK0OM/sCAFXaeImzaglxs60EU3ux0k1A9nAOnj1OQo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=soRGtwuzpwNy+CQXc1fCE34h0o+X8Gia5N8kAxxw2JNkhVTo/URKMXCy+MsRYC+71
	 1oMwLPDM6zAv9kL/xkcMhLewG/k0pMU3LDZdNQ9eWarlELV5+2PolPohhCsJFqoFMM
	 9naSOAhLlT2Fe8T2T2cCpjLOPZL+awXpbAmxULLo=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AIEAXst082700
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 18 Nov 2024 08:10:33 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Nov 2024 08:10:33 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Nov 2024 08:10:33 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AIEAWc9026878;
	Mon, 18 Nov 2024 08:10:32 -0600
Message-ID: <801c3154-07a8-40ff-af68-b5dac8c83e9a@ti.com>
Date: Mon, 18 Nov 2024 08:10:32 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] power: reset: as3722-poweroff: Remove unnecessary
 return in as3722_poweroff_probe
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
        Sebastian Reichel
	<sre@kernel.org>,
        Laxman Dewangan <ldewangan@nvidia.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241117053443.1148902-1-iwamatsu@nigauri.org>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20241117053443.1148902-1-iwamatsu@nigauri.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 11/16/24 11:34 PM, Nobuhiro Iwamatsu wrote:
> The return is executed on the devm_register_sys_off_handler() line in
> as3722_poweroff_probe, so the last return line is unnecessary. Remove it.
> 
> Fixes: 348fde771ce7 ("power: reset: as3722-poweroff: Use devm_register_sys_off_handler(POWER_OFF)")
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> ---

Acked-by: Andrew Davis <afd@ti.com>

>   v2: Set correct mail address for Sebastian Reichel.
> 
>   drivers/power/reset/as3722-poweroff.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/power/reset/as3722-poweroff.c b/drivers/power/reset/as3722-poweroff.c
> index bb26fa6fa67ca7..8075382cbc3625 100644
> --- a/drivers/power/reset/as3722-poweroff.c
> +++ b/drivers/power/reset/as3722-poweroff.c
> @@ -57,8 +57,6 @@ static int as3722_poweroff_probe(struct platform_device *pdev)
>   					     SYS_OFF_PRIO_DEFAULT,
>   					     as3722_pm_power_off,
>   					     as3722_poweroff);
> -
> -	return 0;
>   }
>   
>   static struct platform_driver as3722_poweroff_driver = {

