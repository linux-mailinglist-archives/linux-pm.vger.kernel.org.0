Return-Path: <linux-pm+bounces-1610-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2482D81EF57
	for <lists+linux-pm@lfdr.de>; Wed, 27 Dec 2023 15:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B85CD1F21974
	for <lists+linux-pm@lfdr.de>; Wed, 27 Dec 2023 14:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618C34501E;
	Wed, 27 Dec 2023 14:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WC6LkhZ/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6834500F
	for <linux-pm@vger.kernel.org>; Wed, 27 Dec 2023 14:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3368ae75082so2663921f8f.1
        for <linux-pm@vger.kernel.org>; Wed, 27 Dec 2023 06:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703686266; x=1704291066; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kbfXQvj1Xsq5VyRfwtqsLCuthnRMjLvQaw2Eu7/Ztxs=;
        b=WC6LkhZ/qyKe4znU4dOHmZB6y2bW94x2PKE5ouoklrcPWMiGUcIYMb1mzVUEkV3V/b
         8JTNsAHEGLrVUQKgamf+ytOrIuA2++PNYAYa3MqNM7SKTBuX9IVICyec1Q8jPbnyAn68
         ZdhSubwwIctiZjMXn70r+VfidJleECir/RMBeuGjLrftka5IV6fp28zu9pBVbF3BB932
         Z6MmqXCHNFJTXDSPqjjSMjdYiPhApgdFyur1WyVsBaDQpb2In0USnEE2KCHCk7cwL2Zu
         FtByZDcHApi2jZhNEOcVvZyREwesjf/gbReUr0ljqEkVGkHvKMfGcAq/rdGFV50c3kFF
         Hl5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703686266; x=1704291066;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kbfXQvj1Xsq5VyRfwtqsLCuthnRMjLvQaw2Eu7/Ztxs=;
        b=e3tepU1ilP2QPzfYrXsbHloAX1T9woGOmTDS8mZyQ2iz7fbilW6MlT1gZZNxrdhpm8
         TssP01gvdSu0rFaRr881EBhL/41IfCEZUliZdwupqRoMNrN/RDY2loRSLSbKExipJoLb
         edh7vLJX6TtGYPReN+BRd1ueQJu+MYL47FsTupiHOS+EWmU6XpvSb5UW0hF7CsZyGYVM
         Mcp5fODlCDOlIXESRr9brv/ef02/tv9fnDT0I1xdxQmfaRj12jx7/0ZoBC8h83G0Ialo
         tECiib2ACu33a855ARWd1SqzcAUp7N2hN18v6/RnhVgb3POMFIA2IEnFPhUNT4Uqr4E1
         EqNA==
X-Gm-Message-State: AOJu0YzD4/DO24cCwkx5I4FjAlIa8ZiEKS1HPkPOY4WTNLmw/pQIW8nL
	bVdhHfc2R7JtJYpdwgJ0GkglJOxDocrlvA==
X-Google-Smtp-Source: AGHT+IHQRD1bXTN3QuoSGQVkMEuY+wter+DyBtLVMUhOcsY+dYvCV9JehvkbXtNpL+2NcBS2KeobvA==
X-Received: by 2002:a05:600c:19ce:b0:40d:5f60:505e with SMTP id u14-20020a05600c19ce00b0040d5f60505emr456154wmq.122.1703686265839;
        Wed, 27 Dec 2023 06:11:05 -0800 (PST)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id q17-20020adfcd91000000b003362d0eefd3sm14854930wrj.20.2023.12.27.06.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 06:11:05 -0800 (PST)
Date: Wed, 27 Dec 2023 15:11:03 +0100
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] thermal: netlink: Add thermal_group_has_listeners()
 helper
Message-ID: <ZYwwdz2XabAuCv4y@mai.linaro.org>
References: <20231227140057.174314-1-stanislaw.gruszka@linux.intel.com>
 <20231227140057.174314-2-stanislaw.gruszka@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231227140057.174314-2-stanislaw.gruszka@linux.intel.com>

Hi Stanislaw,

thanks for this optimization. One question below.

On Wed, Dec 27, 2023 at 03:00:57PM +0100, Stanislaw Gruszka wrote:
> Add a helper function to check if there are listeners for
> thermal_gnl_family multicast groups.
> 
> For now use it to avoid unnecessary allocations and sending
> thermal genl messages when there are no recipients.
> 
> In the future, in conjunction with (not yet implemented) notification
> of change in the netlink socket group membership, this helper can be
> used to open/close hardware interfaces based on the presence of
> user space subscribers.
> 
> Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
> ---
>  drivers/thermal/thermal_netlink.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/thermal/thermal_netlink.c b/drivers/thermal/thermal_netlink.c
> index aca36c4ddbf3..b4e758d22077 100644
> --- a/drivers/thermal/thermal_netlink.c
> +++ b/drivers/thermal/thermal_netlink.c
> @@ -76,6 +76,11 @@ typedef int (*cb_t)(struct param *);
>  
>  static struct genl_family thermal_gnl_family;
>  
> +static int thermal_group_has_listeners(enum thermal_genl_multicast_groups group)
> +{
> +	return genl_has_listeners(&thermal_gnl_family, &init_net, group);
> +}
> +
>  /************************** Sampling encoding *******************************/
>  
>  int thermal_genl_sampling_temp(int id, int temp)
> @@ -83,6 +88,9 @@ int thermal_genl_sampling_temp(int id, int temp)
>  	struct sk_buff *skb;
>  	void *hdr;
>  
> +	if (!thermal_group_has_listeners(THERMAL_GENL_SAMPLING_GROUP))
> +		return -ESRCH;
> +

Do really want to return an error ? Shall we just bail out instead ?

[ ... ]

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

