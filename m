Return-Path: <linux-pm+bounces-32494-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 584A4B299CF
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 08:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CE403A3979
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 06:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A078275AF1;
	Mon, 18 Aug 2025 06:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mXfp/1cn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90BF1DD877
	for <linux-pm@vger.kernel.org>; Mon, 18 Aug 2025 06:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755499009; cv=none; b=BOl2nvVlwj0v8+QR0Cy47NKKl4JiIWpMEPYGoEysSvqVxfk/iFHx0P7sA8ShTWzIfFVetIcSEIPtlk0P/En7YZivg1Dg2QOzVnTDu/WHdBX1nXGLIu9iouhFn4jjFjSGgIGr0eLndg5G4IWl6D99ZXXRFAduzms/XDgn9U0bkmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755499009; c=relaxed/simple;
	bh=oSh2xMD6SdqqzF+XVFnBtlL5vvi05VvJwkUWiT94P4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3qGLAGGi57ZixyBImhgcg7d/D6WWo+cA1FNwACwtJx8nRdNf+ilqG1hOMUbleMUiPFu+wG7WLrLrv9lhKSn4a/6kgxp0udRITTJ8Hi4hpW6HfxQ4euuKM4yE8yXwAYZ6WwcQCICIjUfqwA6v0zhJ+2coQzFr8FXP3IYLqqaU4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mXfp/1cn; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76e2e8e2d2dso2227728b3a.1
        for <linux-pm@vger.kernel.org>; Sun, 17 Aug 2025 23:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755499007; x=1756103807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9rjhO/M0uTmlNPmuFaEm9QTozYRIwsNGmKagEyX9yMU=;
        b=mXfp/1cncNhAhS+pN3BLnKDRBw+Y8ZlYatsJJcPgeUpSWzwJy8aZWdXH02mmYMSGJJ
         SV90hQfxjLKxQ1bZMeFQ0Kn9xk49egsUqM/KyWUuduN+XT4vudPeH0RUvtMqNJAv/MLe
         KaQPJsBJyPHW6h4OCheA9bm1YAnB1YIj3prnWw6jnUkSDRqGPcmgErFjKsiZ6PHAi4FK
         WPEAcQuEv4Y7+GhhGFulyHu3nXiR94Oyw0MVhiKVjxNJGg//DNugSn6UV3mKavCsJ/jX
         uXB7XvEDXJc2L+NuLHMRQiNkCCgThg1y45LAwG/Bsji3WfxFHr13lKON9LGU8oxuDltf
         X+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755499007; x=1756103807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9rjhO/M0uTmlNPmuFaEm9QTozYRIwsNGmKagEyX9yMU=;
        b=lIrELoG5bCnq4xKnsYmYYgGOUCyEnbrIW94aTcCT2keSYa0qcXpO//cSZWg6gUzWde
         vD9WLuzC/tzlCMQIvIoNxW0aLGBlan0kbasnb0gMb+4xF1vjoQWXa4Czc40cnZ0xLHWJ
         Bd/VU+WB6SpxswIX2SA5YMWAYeCMfj5+EWFtxalJ/gbbyDyhbn6iCaFvPALq9foVWeNQ
         VxLuINfVsALdIhdd5POe0RM2F4uAu197c7nTmMCs5ip/PaWX5Pk6SUVhMh5lTxZ//2gs
         Xwoh6jpx5IWQDvzq9lYH94n0KD9P/fPnwzYNM7zs1HW/69PnGV73vf50/l5iaTJWUNGm
         cj8A==
X-Forwarded-Encrypted: i=1; AJvYcCV0NPJH7/kenJDu3au/J/Liaf+mjk3qX7F1+bQPxJxUNjydxUVfC/iwucLvSm1HvNG6fJUbsuUHEw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6z37wbTAfxiPOg9Bv8UcgLJEmknK4CUki812msccFYJ7W8Z/M
	uzdGs5Nb/1p2BHPIJ6KDGmT5wpqcjxHmD1BuOxy+lrh5T+BSSJJkt5SVxw8n6pSfvBE=
X-Gm-Gg: ASbGncuKIV56gMmW1EZ3dlDT+nY5oUf5hPil48312I1VLd1SkyvST5h+bVulelQmJdW
	MELbHMGz3Bh3vyqjvwW8kMudR9U/t2optifliVx1ayr/5zCGcV5NiDITC7zHOzjM93aXWTaYFGM
	GnRIrq1nir4GUmT6yRV7/yUOPkUTvnCA2Ue6kf9fj3dVWs83pQb/l7uImfETW+avZpcT7hUcMOv
	XdlL2WNPJDy+k/VupzeVXudKqiNGtAfwZa7jqDDORm0oHP/Z3zhucGkTQgU4ptPmUvKXbtQlckB
	8YL0CuWff4xpN3cubmxHlzBKvKqDx8jk8dPy4asT+6UH7ZpemW//HFndtJ2AsHyqB7zxjssUk2V
	CfnDOCp5wa71940QQzGd+A8xG
X-Google-Smtp-Source: AGHT+IH8gijQo2HWWMh8yIAt8KnRnmfELcFQEuxNNsjzrP85ncTsOlSt0lA4KoypNRAozLwoHQfe2g==
X-Received: by 2002:a05:6a20:4323:b0:240:50d:4285 with SMTP id adf61e73a8af0-240e63dd588mr12345211637.38.1755499006972;
        Sun, 17 Aug 2025 23:36:46 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d799c8csm7203728a12.55.2025.08.17.23.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 23:36:46 -0700 (PDT)
Date: Mon, 18 Aug 2025 12:06:44 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-kernel@vger.kernel.org, james.quinlan@broadcom.com,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mike Tipton <quic_mdtipton@quicinc.com>,
	Peng Fan <peng.fan@nxp.com>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: scmi: Account for malformed DT in
 scmi_dev_used_by_cpus()
Message-ID: <20250818063644.kbzbj7q7a2s4snur@vireshk-i7>
References: <20250815205714.1545571-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815205714.1545571-1-florian.fainelli@broadcom.com>

On 15-08-25, 13:57, Florian Fainelli wrote:
> Broadcom STB platforms were early adopters of the SCMI framework and as
> a result, not all deployed systems have a Device Tree entry where SCMI
> protocol 0x13 (PERFORMANCE) is declared as a clock provider, nor are the
> CPU Device Tree node(s) referencing protocol 0x13 as their clock
> provider.
> 
> For those platforms, we allow the checks done by scmi_dev_used_by_cpus()
> to continue, and in the event of not having done an early return, we key
> off the documented compatible string and give them a pass to continue to
> use scmi-cpufreq.
> 
> Fixes: 6c9bb8692272 ("cpufreq: scmi: Skip SCMI devices that aren't used by the CPUs")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
> Changes in v2:
> 
> - do not leverage the SCMI quirks framework which in spirit is for
>   dealing with SCMI firmware implementations, this right here,
>   specifically pertains to an older Device Tree. This also makes it
>   easier to backport that change into stable trees where the commit in
>   the Fixes tag is already present. There is no dependency upon the
>   presence of the SCMI quirks framework
> 
>  drivers/cpufreq/scmi-cpufreq.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index ef078426bfd5..9df4d968fdac 100644
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -15,6 +15,7 @@
>  #include <linux/energy_model.h>
>  #include <linux/export.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/pm_opp.h>
>  #include <linux/pm_qos.h>
>  #include <linux/slab.h>
> @@ -424,6 +425,14 @@ static bool scmi_dev_used_by_cpus(struct device *scmi_dev)
>  			return true;
>  	}
>  
> +	/* Older Broadcom STB chips had a "clocks" property for CPU node(s)

Incorrect multi-line comment format.

> +	 * that did not match the SCMI performance protocol node, if we got
> +	 * there, it means we had such an older Device Tree, therefore return
> +	 * true to preserve backwards compatibility.
> +	 */

-- 
viresh

