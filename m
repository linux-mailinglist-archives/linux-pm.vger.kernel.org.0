Return-Path: <linux-pm+bounces-1655-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8863A81FA77
	for <lists+linux-pm@lfdr.de>; Thu, 28 Dec 2023 19:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 440C9283B85
	for <lists+linux-pm@lfdr.de>; Thu, 28 Dec 2023 18:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19ED3F9C7;
	Thu, 28 Dec 2023 18:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="274qxj/q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55088101C6
	for <linux-pm@vger.kernel.org>; Thu, 28 Dec 2023 18:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3369339f646so5178970f8f.0
        for <linux-pm@vger.kernel.org>; Thu, 28 Dec 2023 10:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1703786809; x=1704391609; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4TQXItvWuDmTePFkOjJNdDeKYpVVl6+9BdVfsLroUnU=;
        b=274qxj/qxTe1HD/7WhYwdz86wfaL0+VO5ehtBl7ddoS2jUofeaDHhBAabeJtRxyE6u
         lyFgwxWw4ErKjq0nlqdYKcCuXCF5KhCo6thlk4FSv2YV+UedaP/tFU1w6yggdo5mBB0h
         xbdF+ejF3CPuhlRIadVeIrfoqm0nmzD/olm3+4O5rJ75DUfKL6A1oJu73SvBIp+n34Jr
         W3SWJ5cNfcbC2X2BTIENCIe8NOAsMS7hOd/NHi1fEqLH75f3aOhUZ8+mSVSRNW64MzTk
         2AWTHXr4O0OYx7fIvM6wVvwGlwtfDnhKPAuJdCSvq7rWlwx2RsjHPDI8ZMc+wb+GOqj+
         7tjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703786809; x=1704391609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4TQXItvWuDmTePFkOjJNdDeKYpVVl6+9BdVfsLroUnU=;
        b=AnC8ZQZfeBDEcNmj6FB1EYW7A7LZGIrY7i1MZFE3ztYKsMRihmFgkVLcurzWXs013e
         M80pgKanMxjt1DZpZlcY2deQnsQHaQv2OAUniHn0275Fy9l28NaUAx0bqEhINiTE70Gb
         as+8pba8blGrSFEmQVFrPn7qaoaPFRBmsCDQAlhBzbAiBrtJHvOBdNDBcZFxzlFEpNX0
         C5WxRxqYlbmXUoEyIwlvjIIeDMQEUReeA2DJ44XQnanijP+BtmLUwC5G8pgwJlUxkYJ7
         jQbZxVUD0gFZsDNXznPQNN5N6SoDadSsH8wzPMImrmVcY1rd4mzPq9iWJ7V7ekyY+KEg
         i8CQ==
X-Gm-Message-State: AOJu0YwleKf4uloHlUOMyr4nb4vKM8px6weLKfGJOD2ljBLuJKvXvobM
	d3SOzkMF0YVmNNX2MFT8qBHU2Vl3GF3vxg==
X-Google-Smtp-Source: AGHT+IFlEvBYd7xm9G7YbqfcaOHTH6oG95pi+uSQx/fWj0M27l8eBpC8RqiIQP/gJfxXmUZzG0DRIQ==
X-Received: by 2002:a5d:46c1:0:b0:333:2fd2:5d21 with SMTP id g1-20020a5d46c1000000b003332fd25d21mr5340714wrs.83.1703786809484;
        Thu, 28 Dec 2023 10:06:49 -0800 (PST)
Received: from airbuntu (host109-154-238-212.range109-154.btcentralplus.com. [109.154.238.212])
        by smtp.gmail.com with ESMTPSA id z4-20020a5d4d04000000b00336a1f6ce7csm13052322wrt.19.2023.12.28.10.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 10:06:48 -0800 (PST)
Date: Thu, 28 Dec 2023 18:06:47 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael@kernel.org, dietmar.eggemann@arm.com, rui.zhang@intel.com,
	amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
	daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
	len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
	wvw@google.com
Subject: Re: [PATCH v5 15/23] PM: EM: Optimize em_cpu_energy() and remove
 division
Message-ID: <20231228180647.rwz4u7ebk5p2hjcr@airbuntu>
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-16-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231129110853.94344-16-lukasz.luba@arm.com>

On 11/29/23 11:08, Lukasz Luba wrote:

> @@ -220,8 +218,9 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
>  				return -EINVAL;
>  			}
>  		} else {
> -			power_res = table[i].power;
> -			cost = div64_u64(fmax * power_res, table[i].frequency);
> +			/* increase resolution of 'cost' precision */
> +			power_res = table[i].power * 10;

Power is in uW, right? You're just taking advantage here that everything will
use this new cost field so you can add as many 0s to improve resolution without
impact elsewhere that care to compare using the same units?

Did you see a problem or just being extra cautious here?

> +			cost = power_res / table[i].performance;
>  		}
>  
>  		table[i].cost = cost;
> -- 
> 2.25.1
> 

