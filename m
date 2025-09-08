Return-Path: <linux-pm+bounces-34136-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66871B48755
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 10:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 432451883C8A
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 08:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2611224891;
	Mon,  8 Sep 2025 08:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IKeeiHlh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ED31E51EB
	for <linux-pm@vger.kernel.org>; Mon,  8 Sep 2025 08:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757320622; cv=none; b=P4L+uKGfz0nWhPiaafd2vHtJ3Uv0Qv3U/C6h3V/fqU3TbNEbbdWbydPNI0hbgt9DjjLqjWyOLt8zMKMXVRZRpQ95BS+V2bS4028LUXwng3rk2MPM2rnLNAfhJfJHBo7g1Lno3gDPPrTshhlV7iCOI50WfvFW9q/T2+onR/ib7U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757320622; c=relaxed/simple;
	bh=91GWwOHQZd61H+uLxKecW0IvRjKvbgTQymm2ENYr7KE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ohu7A+zybQ1Nak3u8zgKVFg5GF+oZCBNploIpUyUxqoavc3JdrORrWSPKauK3KOWhmD5LocC7HOHMqVTgDSTCuIRmN52oCQZIdc1eMZzFCNWjBNZV15i7WBuSPhh/HusOMq6877HFZD/YqbKquMeLW1pVdcMHxitsub0x2JYuAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IKeeiHlh; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3e537dc30f7so974984f8f.2
        for <linux-pm@vger.kernel.org>; Mon, 08 Sep 2025 01:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757320619; x=1757925419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=113pYMhFwXQcs4jB+MaN0pErhdo6n7wFRYs1oPwsYGk=;
        b=IKeeiHlhAZ5Lsxs2+h4oAIdEyFpW8F4bvFDAymzv+Fs7NqO6Rnv3OTQfPDfEHbUtFI
         cXYCg/Urc6eHkAuognmuIXG51GHI2X7bQP9gvc4ToMaVVYk7A1VN7j7t/oluklvamm8+
         vlwjCNTOaIx9t64Fa+P4dlvTQhCFA0F3co3kx47QMTAzMwKzs5QuZ5KledDDN3ZqikGa
         4P+AX0B0NJjx4gkoIYrz8iZ+H4/74XhvBldklF4r6ysqIraf3Ph6njcWSCrHFjo5FVr8
         DOl1Fs8aYJFTi2HTLpXMyr8w3pnY7uKbjBcmDqqLO2gJGcEBYwl7jAf96f0UoUT/BjED
         faZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757320619; x=1757925419;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=113pYMhFwXQcs4jB+MaN0pErhdo6n7wFRYs1oPwsYGk=;
        b=w4kh6egAeRKG3v95MExGjd9pxwtvBUXjQkkaaKgsFzBe5tAUpxvpUHD7vl5OGaq9nv
         mfJaOEBGp4xZWsgXY2HVx6Zxx8t7zQM36D8nvjHKN+q7JYhOO2pLz3dD/ETxIy/FaiX/
         2s8NWpF6aclvl1EfpVFFSeevQ9o9ZCx5GGKG28jRUxlwxzS8fpVSHjO5uWz76iQ+TJzk
         zrf58b9M49u6hel6yJjyEkMNN70qkPK28Ir4JIA3omDszyO8To1wtVyUrWjt77pXRk91
         lG4fH3olFoZgf7JDcEUJA3j0Tn/f67b4MSysfBaNuSWCzynT9SxTIATqhpKratTxcm+W
         LZtw==
X-Gm-Message-State: AOJu0YxDGFapXDxUeK8Am4djJMB2Y7HyxUfNQjYmH2Jl/R6qKA0a9KtY
	DWrx1n+ofUTHUsOjIdKOILqI9y/cFUtUjK8BP3E/S6fg+ferwYx4R/3iXX4PYW9m7HM=
X-Gm-Gg: ASbGncu7x6Fx2kUZfDrT12eBkIqVB/i8WafZMWtAkbg1HAoGnWEsyoMrcGgLHlG6vZO
	yQ21q24QhGCKej2gvYdb3N8qacDw+oIwnW5qYJgOs+JXdxvXRLfAckW7xwijCGr7m78UmsgJp93
	vKmbFtTP38X8CwRBgaZO3CliUe4ncQx61jGoTk703WfRAflFaprNQrhViO82vLbhsFof4R+RhyY
	+fzKHcgK4oujYOjnTVlHyj9wyySt4GohzW3FIpKHil+l9P5btWGzYdSPZ+Pu4jr8LCQNCUcP9Bm
	R+hkXi1S4NgHFwt7Z/RQKA0Jjnay4g2o817bahcq5zoOtNedaRWlpP3qdwtxQ7pGt5JbAXUprm1
	gFanSqlc4Tc67A3Z0owbA5M8Z3NgJNwHpz+uHtLoacHRjz9PvdpLt8aZGLrsPQyUj4SVeiWUJAW
	qk
X-Google-Smtp-Source: AGHT+IGztzx+zOdXsvCBYQc1hUPpjPUc9RSWX4l1+IX73bzuxIVAUMTS0szFZ1gRHtCme35pL+Bv3w==
X-Received: by 2002:a05:6000:40d9:b0:3ce:ae6b:51d9 with SMTP id ffacd0b85a97d-3e6424000d0mr5418501f8f.26.1757320618658;
        Mon, 08 Sep 2025 01:36:58 -0700 (PDT)
Received: from ?IPV6:2001:a61:13ec:c301:8f4b:c388:33a0:9bc1? ([2001:a61:13ec:c301:8f4b:c388:33a0:9bc1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45c447244c4sm235689885e9.6.2025.09.08.01.36.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 01:36:58 -0700 (PDT)
Message-ID: <93d51f53-8530-46b4-a2f3-d01046d9d583@suse.com>
Date: Mon, 8 Sep 2025 10:36:57 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: conservative: Replace sscanf() with kstrtouint()
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>, rafael@kernel.org,
 viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org
References: <20250906115316.3010384-1-kaushlendra.kumar@intel.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20250906115316.3010384-1-kaushlendra.kumar@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 9/6/25 13:53, Kaushlendra Kumar wrote:
> Replace sscanf() with kstrtouint() in all sysfs store functions to improve
> input validation and security. The kstrtouint() function provides better
> error detection, overflow protection, and consistent error handling
> compared to sscanf().
> 
> The kstrtouint() function provides:
> - Robust error detection for invalid input strings
> - Built-in overflow protection and boundary checking
> - Consistent error reporting (0 for success, negative for failure)
> 
> This maintains existing functionality while improving input validation
> robustness and following kernel coding best practices for string parsing.

looking at the patch while it is a good thing, something struck me ...
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
>   drivers/cpufreq/cpufreq_conservative.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
> index 56500b25d77c..cce6a8d113e1 100644
> --- a/drivers/cpufreq/cpufreq_conservative.c
> +++ b/drivers/cpufreq/cpufreq_conservative.c
> @@ -152,9 +152,9 @@ static ssize_t sampling_down_factor_store(struct gov_attr_set *attr_set,
>   	struct dbs_data *dbs_data = to_dbs_data(attr_set);
>   	unsigned int input;
>   	int ret;
> -	ret = sscanf(buf, "%u", &input);
> +	ret = kstrtouint(buf, 0, &input);
>   
> -	if (ret != 1 || input > MAX_SAMPLING_DOWN_FACTOR || input < 1)
> +	if (ret || input > MAX_SAMPLING_DOWN_FACTOR || input < 1)
>   		return -EINVAL;

... the parsing itself, followed by a check for bounds ...   
>   	dbs_data->sampling_down_factor = input;
> @@ -168,9 +168,9 @@ static ssize_t up_threshold_store(struct gov_attr_set *attr_set,
>   	struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
>   	unsigned int input;
>   	int ret;
> -	ret = sscanf(buf, "%u", &input);
> +	ret = kstrtouint(buf, 0, &input);
>   
> -	if (ret != 1 || input > 100 || input <= cs_tuners->down_threshold)
> +	if (ret || input > 100 || input <= cs_tuners->down_threshold)
>   		return -EINVAL;

... and here again. It seems to me that if you always follow the parsing
with a check for bounds, then to reduce code duplication you really want
a function that takes an upper and a lower bound as parameters and checks
against them.
In that sense, I am afraid I have to say that your patch stops in the
middle of the journey.

	Regards
		Oliver


