Return-Path: <linux-pm+bounces-34804-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 532CBB7DD41
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 14:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A0044809BC
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 22:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8432F9DB8;
	Tue, 16 Sep 2025 22:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fr2M5uBR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4785131BC8C
	for <linux-pm@vger.kernel.org>; Tue, 16 Sep 2025 22:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061625; cv=none; b=InkGV1Kx+KXMUebyak2gVvy1Q0PYhcXoPyHEhpMAePGDE71Jz+aWEqNpPb0kd1fvBrRnVUhMMuYUR5pjEv06y4VmRHvgc2vRD/AOlLjrXDMwD3Ou3xhC4+uzgK+OuhSdVfLqLdhxWVqTDkqRP9fm6idEP1OwPIfl3WXNEBme1VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061625; c=relaxed/simple;
	bh=WlaeWQkVe2LAkLTFg0HhhUwZq/eeWI5aMBXjarmFyNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DYWR5jEO52qlEdorGkO9NEwDObhU2IQuH56oRw070HdZPCeiwjL33zgPVRxJS0tlg9QgG0gmC/hmbwgqtZLowule4xvOTaZCgNyV+G1xvkdgYu7yNAYQUEe6pYOHQPkqwVYMeisyIGlJKQ5OVOIVJZgLeFx6jP7jRdz3bJCwPIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fr2M5uBR; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-81076e81aabso498538785a.3
        for <linux-pm@vger.kernel.org>; Tue, 16 Sep 2025 15:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758061622; x=1758666422; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u+C7+Zt8EwqQNYjKFusHO5J9TEKhU19Ov+C897qHSB8=;
        b=fr2M5uBRr6Y3huoYNuH7MLpeTMkAVyUHL2zcYpioCgRl/Ar/zoJgHOhdEuFMTWM6Ad
         /tckOfipGFAHEwqs/EHwELXTK20aYChHKSMItHvnO4OzcE9pEPU3T32gsBQn5M8L9T3e
         dP3+Ets4kl4jePyv6jndHH3Ltw409xm7M00iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758061622; x=1758666422;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u+C7+Zt8EwqQNYjKFusHO5J9TEKhU19Ov+C897qHSB8=;
        b=CqItYKFZ1/aQwn/OnUwUF4DnFaEARxpTMhbWXLQCi0a5BikQevbuOWKZsm7uBDtCtM
         OCb+MWawUnf4uMyGAiRBnZPiCmFdARAqQrCYYcNlnM/0GrzfqT7Dk3pZtMGORIJoylLm
         WmrsC/5HPxbjI0JILvEZj1xfYBMml0VHHvnv6RdE2LuLBa8z29c0iIs7LU1vtIewe0K6
         B9JVBDfFAd8NzdraYcFh608asxXCihHoErHTiDqIBxcTOv8iUouW9gRuQPjTl3D9+I1v
         4jhpjgELuE9XS6jTTptwOVWNN/07Z72LS00zz8G1ATQodpfZrEUtyqluexRrlkCRqwe8
         xN1g==
X-Gm-Message-State: AOJu0YzxVX4vpCUgyw0F9wLfzX/RGBHR5OrlN5SW20UPxGFbRNz1g48b
	rD1ejnRG4Fye7kyAcgptWJX+K37IhXYVKLmb287y1XglkSiKT+WkjPHF/8/tiK3JQgo=
X-Gm-Gg: ASbGncsfkb1SsypFcSitxTK53sCs9wcmaHTTCJG2PjscgBFwVDlHWrrVHn5PoNCPq7w
	O615QZJEBiRrsYuxUkE2YB+ETX67m+g3P3cCs6xXscP3ZOV6Wn0h5UGnHPtOLZaD1ltDcBlZsNz
	kmKGUR0sq8Usk0wApnOJY9eTW9FsxLLH7htY2P4ykBiBMi5Y4NWkOrhQJQmkjokCTEdRpe9wEWG
	0dR8CdxGkDaGjkeX5RemyjPKPQZO7yK+atnkciN8crWC76zw7ku/TvwC4WgNGRpG6MPHzuiqa6o
	ACkNxnN+P2ZiTex0lmo3cfG3x1R9sljvoq2YF4gYvHxt9vUdsi2ymKPjoyFFefw4cQYGao4AAjG
	8W1CI8Lv+jc6a6Q5VV2lC6N14PRxqwMA4gDDkb4Ey2xbu6SjMKFE0rp1HYdrRAJRHGaOB6W9qCM
	rMCKtXciR0TPHMZ2HgNML+VpB/lZL+5HWcwa/rFpVBHgM=
X-Google-Smtp-Source: AGHT+IF8A//xxU9vWTH1NoQ844ar3JLd4TAf1UCHnEk5uY15aQNnLfP/3PdhKcb9dUMPQUzrxddg7A==
X-Received: by 2002:a05:620a:4629:b0:828:ee0c:64df with SMTP id af79cd13be357-828ee0c7269mr1213078385a.57.1758061622245;
        Tue, 16 Sep 2025 15:27:02 -0700 (PDT)
Received: from [192.168.226.35] (207-181-222-53.s5939.c3-0.hnc-cbr1.chi-hnc.il.cable.rcncustomer.com. [207.181.222.53])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-827e59af36asm645591885a.46.2025.09.16.15.27.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 15:27:01 -0700 (PDT)
Message-ID: <5a9e1ecb-2905-4318-8669-c515568e1d42@linuxfoundation.org>
Date: Tue, 16 Sep 2025 16:27:00 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: fix memory leak in print_{on,off}line_cpus()
To: cryolitia@uniontech.com, Thomas Renninger <trenn@suse.com>,
 Shuah Khan <shuah@kernel.org>, "John B. Wyatt IV" <jwyatt@redhat.com>,
 John Kacur <jkacur@redhat.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 niecheng1@uniontech.com, zhanjun@uniontech.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250827-power-memoryleak-v1-1-e4baf7b59a41@uniontech.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250827-power-memoryleak-v1-1-e4baf7b59a41@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/27/25 03:46, Cryolitia PukNgae via B4 Relay wrote:
> From: Cryolitia PukNgae <cryolitia@uniontech.com>
> 
> {on,off}online_cpus_str not free after use

How did you find this problem? The memory is released when cpupower
exits - do you need this free?

> 
> Suggested-by: Jun Zhan <zhanjun@uniontech.com>
> Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
> ---
>   tools/power/cpupower/utils/helpers/misc.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
> index 166dc1e470ea6d70079fea6570750885d549603a..f3b4fe95520ff96a1be8b1ba8e7be1ec116b1bc0 100644
> --- a/tools/power/cpupower/utils/helpers/misc.c
> +++ b/tools/power/cpupower/utils/helpers/misc.c
> @@ -213,6 +213,8 @@ void print_online_cpus(void)
>   		bitmask_displaylist(online_cpus_str, str_len, online_cpus);
>   		printf(_("Following CPUs are online:\n%s\n"), online_cpus_str);
>   	}
> +
> +	free(online_cpus_str);
>   }
>   
>   /* print_offline_cpus
> @@ -232,6 +234,8 @@ void print_offline_cpus(void)
>   		printf(_("Following CPUs are offline:\n%s\n"), offline_cpus_str);
>   		printf(_("cpupower set operation was not performed on them\n"));
>   	}
> +
> +	free(offline_cpus_str);
>   }
>   
>   /*
> 

thanks,
-- Shuah

