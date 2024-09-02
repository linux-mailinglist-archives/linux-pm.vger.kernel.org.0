Return-Path: <linux-pm+bounces-13340-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A069685D8
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 13:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6AFB287024
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 11:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB2D185924;
	Mon,  2 Sep 2024 11:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZeG2JcEb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A461849E7
	for <linux-pm@vger.kernel.org>; Mon,  2 Sep 2024 11:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725275531; cv=none; b=GsNQ+hwcN3zpm50+9phjGucD/RGIQu1lqsphFs+l3KOCDGbSBmftIwNpXtwu3/mmufv/vUQCjBzvoyBKHiCydZQJie1Fe5KTW6ge4Vmug6bBqWtdeyviYKVNpU1yMaQB1S2ieRTvpiCjjsr2n83qrij7nxvby7UW7pc8yXfCsaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725275531; c=relaxed/simple;
	bh=qotzvads3UMKNf3rmI6v7Ue8iELhKCP+hJPrBwGMTFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T3EKhAPAXo46LdtHL/9VdbhPdlwAobYMFETL8rTeoyr4iA+BCDyCCatm9EUkJktxDa/qdwJcS26RLRbvzFcYXrsFeVUMmM4Qev/r692Y3IbK63PrQNNyQ0uN9xUAWiSxpBJiDxBGKEpG62/bItMzfTZomJ8YJKg6w2W/V3QBXFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZeG2JcEb; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a86a37208b2so472688566b.0
        for <linux-pm@vger.kernel.org>; Mon, 02 Sep 2024 04:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725275528; x=1725880328; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p4jSpaPfow6+ml545k0HY9HHXw7c8Do/h5EdHSfFnZ4=;
        b=ZeG2JcEbV3rxwsIhpqewcOjn1jHa8dQf0SbgdyJ7HLKt69//WavOqaSyOjUEprlqfr
         1CoOkW4+it3F8kI5X/Iv5wmHBNKyUmSIY24Ro67h5IQ4VklYEUXjf5DWYjbouTdYfVl3
         FZCXKOeu5+QtHMG+17nk9DXqN5pOO5/NWE3OPywgUv9eEO4KUfDU7q+lYEY+N1brUNv1
         h37R712H9fYq3twSTz0wUyzMYNkowuWAkD36mi9qcW4vJ6omd+dDBYx+wXFvpQYgx+wH
         K0nRgNpMRV7WqIggn9Sz6Nd2aME6457lpk7uIUqFcQfY1WfDIHUhQsTHc3zMKlzmzzR0
         1Ffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725275528; x=1725880328;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4jSpaPfow6+ml545k0HY9HHXw7c8Do/h5EdHSfFnZ4=;
        b=RDLI4rUyakrUuu/F6VoBR7y6aijoE8a23x7bx2lf3yExFKLXP96/eTKK3u4ObNxpxC
         O177+HPuGzXkmy+nHy9wIlHAKBJaCxNquvz1KTGJEsZ/V0/o8x7o2FPjb9U+Jt4WO0uZ
         5rH6SJl8DFXtxQ+twOjsjN0K5zqF2AOCUGVRAIOMCy6iyBfBTV4uXiZuMO1Qkrd6mCQB
         DVw/g5d5MGjMjKdJXQ+1x9CbtD99cx18Uvln88ykoSbYmKtCQGSq8Xl2H6+hdlLaNR2I
         vpuqFc9H3hTri5bSFAqWDimO/nSkYUia4fNW5QivjHpLsLtzEEnHNJSHR3NaJNWB6f6R
         CqWA==
X-Gm-Message-State: AOJu0YwzQ8NU9zEVRYNwX9Ct5RKiiLeRHDxj4pEJ0w6XNJEkwEE7Wi0w
	WlbA3aVhm062r7NvJBikDuXX4Moaxl5iT3zuKynxpDQImQh1Hhmx
X-Google-Smtp-Source: AGHT+IG/XGCurZXihIULw+QDIlJ4QeBYMB+6WOuN7ftHaAbSTzW4It94lvV85w7JbUwnay8SFX5l1g==
X-Received: by 2002:a17:907:608a:b0:a86:7a59:55e9 with SMTP id a640c23a62f3a-a897fa7360emr960421866b.55.1725275527528;
        Mon, 02 Sep 2024 04:12:07 -0700 (PDT)
Received: from [192.168.0.20] ([148.56.230.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d6f9esm546820366b.154.2024.09.02.04.12.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 04:12:06 -0700 (PDT)
Message-ID: <0d8c7614-809a-4bf1-b91d-4517e888e15d@gmail.com>
Date: Mon, 2 Sep 2024 13:12:04 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] pmdomain: mediatek: make use of
 dev_err_cast_probe()
To: Hongbo Li <lihongbo22@huawei.com>,
 angelogioacchino.delregno@collabora.com, ulf.hansson@linaro.org
Cc: linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20240828121230.3696315-1-lihongbo22@huawei.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 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
In-Reply-To: <20240828121230.3696315-1-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28/08/2024 14:12, Hongbo Li wrote:
> Using dev_err_cast_probe() to simplify the code.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/pmdomain/mediatek/mtk-pm-domains.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> index e274e3315fe7..88406e9ac63c 100644
> --- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
> +++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> @@ -398,12 +398,10 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
>   		scpsys->dev->of_node = node;
>   		pd->supply = devm_regulator_get(scpsys->dev, "domain");
>   		scpsys->dev->of_node = root_node;
> -		if (IS_ERR(pd->supply)) {
> -			dev_err_probe(scpsys->dev, PTR_ERR(pd->supply),
> +		if (IS_ERR(pd->supply))
> +			return dev_err_cast_probe(scpsys->dev, pd->supply,
>   				      "%pOF: failed to get power supply.\n",
>   				      node);
> -			return ERR_CAST(pd->supply);
> -		}
>   	}
>   
>   	pd->infracfg = syscon_regmap_lookup_by_phandle_optional(node, "mediatek,infracfg");

