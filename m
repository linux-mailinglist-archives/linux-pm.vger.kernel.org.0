Return-Path: <linux-pm+bounces-32869-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C040B30DE2
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 07:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2533FAC4CB8
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 05:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E23B28505F;
	Fri, 22 Aug 2025 05:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTU6cmJa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD09D1DD543;
	Fri, 22 Aug 2025 05:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755839853; cv=none; b=Bv2INPyWli4/hRWJ85KW6hYGhAMEJuOiqy5z4eb3CeBcl61+nCw+fF7LD4IpPwt0oUhw7qUvIJP0s7rE4r22S9BWl0iMlYtLvBHfeof7tiZzArvgJ3N2M+UKDOUrhSIYGIMZj72wnV1FQTbpSEF5hJH0tQ5HyXu7ciIyr3Cktys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755839853; c=relaxed/simple;
	bh=AB60qIhIhcIch7DTjDb61PjbSqMJsqIbyQYnTPNHunI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CP0GJTdLTlx3LJh20BGELH2sktiMM2JOnF6cigKDPQh3aZXpvWqtiBvToVWjqy/utL4DQwDzbjKOg7s5VDg5rnzwq1+MYHBZw60CTIPyCbXPF1Gm/1m3PYVNGEpTCwbst8bfaz9em4Eg5sx606VaAP87zgbl6p8rL2zVhk93w04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTU6cmJa; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55cf526f6b5so1229340e87.0;
        Thu, 21 Aug 2025 22:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755839850; x=1756444650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iSaBW0x71qieK9bpCWJ9scXNoxXVJRabKHQeklCtRJ4=;
        b=YTU6cmJagxGswv9p4TKc9CeMa0ul37frabWTwShJH0q0s4x2FL2byj3jFEVHsheYTd
         VLBPecc7rnKvb5U4m+M2ze4/HgfyClRFNPGBcHvG3KK0ILOEPlFoMgRmydrfU0bP/anf
         tqfHzY6LFhXtvnAR7RnuPUczlKECTYN5VdWmXD+RIGlqBcqnYDKtKx7Y4WpHOmtCIFzZ
         /550gUB6JRip+ETbMzRXIOCq3zj+R3Ks53nCIu+65SYp+UIqm6cYFN478LzWAYlkoZbu
         w/YTCs6SfR6pTCV0qIYq1TK3JpHxljYi3YU8aDEahLnpxwL4Hl+7CQbi/DCfsSJv7l7+
         6Nvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755839850; x=1756444650;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iSaBW0x71qieK9bpCWJ9scXNoxXVJRabKHQeklCtRJ4=;
        b=qp1yCbj3qPtvkavssd9FVbUYO8uAY1SIYrUT/4Dpm75eygQJMJG8XvjsZjZvMzVvKe
         D+ThCxLe2RRu33B1cztoZoQPskWbvC8yGoNErmYqB+/vzPsynRi/Di0+ESI9htcfd5ei
         PqHPa2e9Qw+YCa+eYBGzsc2jKtsGLo/7KXC1MsiZHOs9SJlil6hJ80uN0748WohekPpy
         FYX38PqOCWuRzkjcInA4zv12OtR8MAsSR3p2RvMlxuznw11VAzc5rNxIPRBMznORIvNG
         B5mxYtQaXR72iYl4CpcVINRwC/F8+/ienJzsZwcrI7XxGxZX8OMXqGe7dMLtrkIGi2OS
         iupw==
X-Forwarded-Encrypted: i=1; AJvYcCXX04E+ncW6jdKpB8mqKZnf3pvCdM1wQ3LyGS/a+fYGa9PuQ31dXSZK9jdfBuLyANffcVj6CMq/ZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFeAP/kyQfjs17fg2iWAVvdZhLZanWx3vMeVdk0D8BetnNC+3k
	IP5lDeshfdym6QK8ZerH1n3cuwlg7z8VkY3kVEkQlFoB3ofwCxa2QeWZ
X-Gm-Gg: ASbGnctiXbcYSuqbDBRgnzpijDGNfMH6iPKDHlvMEKEdMhvL9Kz+YM3BZEzpTX9TD2Q
	7WOXvtgpPiCX2bOohMoYKyRvDlqHEX84qg7Ns8iRjHcp0UVVRwUFb0BNleBhWDXAHtHgNYGrA+z
	X6M7AuXrEFMbXbsUOMjBejB7B4Ps6taioyf8PqyYz/zZCmiHdnWfbalJcPDovTczI5JJmY4lUMj
	aoVh+dIeKlsGpg3UviUw8yvpwd+68xVffFnj+2L2MFP6Zekot6reTFYJsnH6MBIxLhNVB7M/ifa
	1uPtJni3P51hfyrQJZfLjFeFixPhwgWaZqYRkWnpfgUOL91nh+ChenIbnKGl1/ub3CVXsizcDpL
	FWQEgzl5ZKXRQ5zce6vY13nS4eaSo5sEijAP2sC4uXbdNAfPhatYGepDGymIwgCJMYu/27XEUdl
	pC/gY=
X-Google-Smtp-Source: AGHT+IEgC3QDqyWZ/g7N7KivBDZnvlGSpXMNT8HlYJVYX4p87nz6Bq4yBixjHM+mi71E0ZkzGSjUlQ==
X-Received: by 2002:a05:6512:1328:b0:55b:95a1:9734 with SMTP id 2adb3069b0e04-55f0ccce828mr505533e87.26.1755839849623;
        Thu, 21 Aug 2025 22:17:29 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3f3932sm3328917e87.109.2025.08.21.22.17.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 22:17:28 -0700 (PDT)
Message-ID: <a119512a-5d8a-4031-8e66-33c31db0dcc3@gmail.com>
Date: Fri, 22 Aug 2025 08:15:33 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] MAINTAINERS: Add entry for BD71828 charger
To: Andreas Kemnade <andreas@kemnade.info>, Lee Jones <lee@kernel.org>,
 Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>
References: <20250821-bd71828-charger-v3-0-cc74ac4e0fb9@kemnade.info>
 <20250821-bd71828-charger-v3-3-cc74ac4e0fb9@kemnade.info>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250821-bd71828-charger-v3-3-cc74ac4e0fb9@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/08/2025 21:23, Andreas Kemnade wrote:
> Add an entry for BD71828 charger driver.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> Suggested-by: Matti Vaittinen <mazziesaccount@gmail.com>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

> ---
>   MAINTAINERS | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fe168477caa45..044eb41ba4797 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21848,6 +21848,12 @@ L:	linux-serial@vger.kernel.org
>   S:	Odd Fixes
>   F:	drivers/tty/serial/rp2.*
>   
> +ROHM BD71828 CHARGER
> +M:	Andreas Kemnade <andreas@kemnade.info>
> +M:	Matti Vaittinen <mazziesaccount@gmail.com>
> +S:	Maintained
> +F:	drivers/power/supply/bd71828-charger.c
> +
>   ROHM BD79703 DAC
>   M:	Matti Vaittinen <mazziesaccount@gmail.com>
>   S:	Supported
> 


