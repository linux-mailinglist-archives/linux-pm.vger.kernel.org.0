Return-Path: <linux-pm+bounces-4198-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B34585E230
	for <lists+linux-pm@lfdr.de>; Wed, 21 Feb 2024 16:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAD3528456D
	for <lists+linux-pm@lfdr.de>; Wed, 21 Feb 2024 15:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79E28120C;
	Wed, 21 Feb 2024 15:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QFHqxrTd"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167A0811E0;
	Wed, 21 Feb 2024 15:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708530908; cv=none; b=DVlHfSXJQNPB9BWh4lRNBJhgR2H0cysqSj9CziH8Kv99BcFh9VIuam3mOcweJmL+MbhDTNxzDcE0I2NRK5NPnnvQlkiUjSTPSgbNzhnRlGPsYb85+TU6MlrbpaQZJkY2YqTjavZQZRYgjyMiQ0XEtiWol27brR005Y22GYY20c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708530908; c=relaxed/simple;
	bh=Yb4FjurKarxmmocetOmmmJ8Lea6l2LH23rQPh+Ck8do=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dtjJrrplllfryGP7qPDKLvkHoGubBinbyyeE1lO50ZczzWk/r+/0aykL/nGTlD2yss/MSHXwp6nP/P8u54Boyi+/VKxKX24qN6J6C+koCuakXeyEM+VAXjI9Kfrm5Z2mK542InCXkrZjkNmiv8oHME8hWAudPB4XH0/HcDrLI88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QFHqxrTd; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41LFt0WW121124;
	Wed, 21 Feb 2024 09:55:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708530900;
	bh=be2nZ6+JiAO2iLu6+IegoIUfkMfux/N+Sz7YELMI4mU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=QFHqxrTdPdHCsICW9X9/FLWydSRp+13lhWp1l1YQlo1s9U3Nof0ONukgIzxtUcs5c
	 +dBpDGAspyMKQ7VSE2WxVJSak1i7dsAe6pdaPJ6n266HfNvYcpcd+Kz8ft530Tj84/
	 MTtnWUWUCgmSnXo3n9nqe4GcjXt0McfZO9bUwc00=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41LFt0Ri110692
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 21 Feb 2024 09:55:00 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 21
 Feb 2024 09:55:00 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 21 Feb 2024 09:55:00 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41LFsxgl063382;
	Wed, 21 Feb 2024 09:54:59 -0600
Message-ID: <be4aaa1e-934d-48cd-b1c7-a054c506aa0d@ti.com>
Date: Wed, 21 Feb 2024 09:54:59 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: reset: rmobile-reset: Map correct MMIO resource
To: Geert Uytterhoeven <geert+renesas@glider.be>,
        Sebastian Reichel
	<sre@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>
References: <3b267fb1b303f63248934a1a77bee319e1c44879.1708458882.git.geert+renesas@glider.be>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <3b267fb1b303f63248934a1a77bee319e1c44879.1708458882.git.geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 2/20/24 1:55 PM, Geert Uytterhoeven wrote:
> The registers related to reset generation are located in the second
> register block.  However, the conversion to device life-cycle managed
> ioremap function accidentally changed the mapping to the first register
> block.
> 
> Fixes: 0867276eb12230a5 ("power: reset: rmobile-reset: Use devm_platform_ioremap_resource() helper")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Acked-by: Andrew Davis <afd@ti.com>

>   drivers/power/reset/rmobile-reset.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/reset/rmobile-reset.c b/drivers/power/reset/rmobile-reset.c
> index 80265608c18e0a20..14682cd59e618d5f 100644
> --- a/drivers/power/reset/rmobile-reset.c
> +++ b/drivers/power/reset/rmobile-reset.c
> @@ -33,7 +33,7 @@ static int rmobile_reset_probe(struct platform_device *pdev)
>   {
>   	int error;
>   
> -	sysc_base2 = devm_platform_ioremap_resource(pdev, 0);
> +	sysc_base2 = devm_platform_ioremap_resource(pdev, 1);
>   	if (IS_ERR(sysc_base2))
>   		return PTR_ERR(sysc_base2);
>   

