Return-Path: <linux-pm+bounces-27318-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A3CABB6A8
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 09:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5D783B63D2
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 07:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FB42698BF;
	Mon, 19 May 2025 07:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pjqEAHZP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F43268FDB
	for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 07:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747641540; cv=none; b=gXdXpVT2EgTUeSwioRJSTY6a63njNY1iaAaR3viPH8cbVp07Y435m3edP8I4y3I2/xTDQHzPThF/OX2b4leZU7lsQ4A5C1v9AQxkNIxyEvjRJzCNk6jJRF5KmAZkIkY3UHObtDkVhQI1RaVK077yy3mKYb7F618HaotjDHuhVtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747641540; c=relaxed/simple;
	bh=EbuXgYNC3YkFJf7lalZRaDMyCovxN1m7vKdcLXMkKvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDT5oEWKO7A9QtBMsdQrR90emIR9Pxb9Wb5xu+wDv+JWeFJPyES5EuB08lfWNvPXoe0aw1hPj2nwziNEu6fLkdZ4gkjHU965BAlFzzWc2b3iupjXm8bbCQCEsvTu92Oz7ymbVplR5Rv+xhX3qgEXcpzzwXPsDn41b6PdZeoX+qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pjqEAHZP; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-30e8feb1886so2304113a91.0
        for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 00:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747641537; x=1748246337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RpvLkghwnQ67hxohbUA8tW0bPeYjdTkXfUPxTmszPjA=;
        b=pjqEAHZPFWVHNAdv6FMGmafDTy0xGenR1ALVWIGz3hfVOX4XNHdR5eyUahQXHvd5g4
         58S+U/8/OBBelhoagMieZkTN11U+0m50AVttxp6BIUkKmM2U+fuxsFYsLCr0cS9kP8yA
         R0TT7y1HobZvWqhGbA/nunq+uhD2FU9rt6VEP/KK5RI/Rewu37kykoY/mFU8FqT593z9
         PspSiXr7m7gyCjkjfu8dhVJH8GSKZ4TpBvu+zbDPzoTsgy/8QSwjehDszDik0qz6biYG
         k8JGdleMV5+nmS38Ya48/Y3Jug/S4vQFM7nDCToHleRQas3ejDgraHFwxKkH+t4dWGcn
         ZW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747641537; x=1748246337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpvLkghwnQ67hxohbUA8tW0bPeYjdTkXfUPxTmszPjA=;
        b=OlcqdhlOGvjuYxwSb9P6IMeiM8Ndj3W3DBEnY+waSZk1kd3X+V0qP41Mj3je86D8Jr
         ZqBGSEXHTXIQgQpwveNcuaZRUgx+Zw8X1G7CI7oboG6cim7z21KgcVqwDKsPB32uIhAb
         1XkiX9mIyonciM2CTuYEvFsl6Xl8WzmwBnaq0oFQc6DjF4jXyZ1xCTsJ/w3mskzIIZ+D
         YhiHVQOJPziKboQHutV0baEx0KaZCegt+6np26MSzERpMwGXAEnAva7uhDTIQerB7Jho
         lrOtQXgPWRqekmTThy7Zy+Uu/siSSkGMjgN+OKAr8/KTKkjk+sX7J/ihLhIl+KcBoYfx
         S/wA==
X-Forwarded-Encrypted: i=1; AJvYcCWwM5VmQHso6llKcPTlcYu/myTFHCVTsXZS9ritnrmhvvoQQDE+8yApGmRpsig4zIswinyXOuvY9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRu3j/obcYeNCJobsASD8wina5CisI8EPZZ7x8savytTTb8EEN
	1MM4i8DvewinWWE2TA1TNywTIzTqfSID+NHK+atquhxytZURZRYITsvd9JWLSloi/W8=
X-Gm-Gg: ASbGncthzw5g7ANuU5XlJeubdEc/H9ggugIQJqr7pLmWhu5TKPXdcBOKe6xbua6eNjc
	RGqp4WqTo6x1FasNzXIcQ+JvL5emU6vsgK4l595uiMlHXIdJMOmumL28nB7D1qIfGcoNAQdqgr0
	ZiuFCsy7cYZYdd424MD3dfmD7fZrlGhECnMGYwPGub6g943fWIw8m6tLXRpWuW4HZPxy6Jrhmy8
	RWiuK+4L3HmnnuxCZUlXamP7VDjYMhVGwvYqLqvZOEw50er3YSUyirTageC5FhFIRPTojfC1UYZ
	iS9m0YMUEyYs9PpsfvsITPLvpX2sbqVsnDGdPP9XkuYusj4yK8MD
X-Google-Smtp-Source: AGHT+IEZ6YoOJYJfcEn2EhDcAyO09w38EVkyVoz32suEBq8tkoBJ0tXmq87v02CJgG3P6opbs6/Fyw==
X-Received: by 2002:a17:90b:4c08:b0:30e:ee6:6745 with SMTP id 98e67ed59e1d1-30e7d51f9f0mr20343707a91.10.1747641537491;
        Mon, 19 May 2025 00:58:57 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e33451984sm9685833a91.23.2025.05.19.00.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 00:58:56 -0700 (PDT)
Date: Mon, 19 May 2025 13:28:54 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Swapnil Sapkal <swapnil.sapkal@amd.com>
Cc: rafael@kernel.org, shuah@kernel.org, gautham.shenoy@amd.com,
	narasimhan.v@amd.com, linux-pm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/cpufreq: Fix cpufreq basic read and update
 testcases
Message-ID: <20250519075854.opnlhjlbybrkvd2k@vireshk-i7>
References: <20250430171433.10866-1-swapnil.sapkal@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430171433.10866-1-swapnil.sapkal@amd.com>

On 30-04-25, 17:14, Swapnil Sapkal wrote:
> In cpufreq basic selftests, one of the testcases is to read all cpufreq
> sysfs files and print the values. This testcase assumes all the cpufreq
> sysfs files have read permissions. However certain cpufreq sysfs files
> (eg. stats/reset) are write only files and this testcase errors out
> when it is not able to read the file.
> Similarily, there is one more testcase which reads the cpufreq sysfs
> file data and write it back to same file. This testcase also errors out
> for sysfs files without read permission.
> Fix these testcases by adding proper read permission checks.
> 
> Reported-by: Narasimhan V <narasimhan.v@amd.com>
> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
> ---
>  tools/testing/selftests/cpufreq/cpufreq.sh | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/cpufreq/cpufreq.sh b/tools/testing/selftests/cpufreq/cpufreq.sh
> index e350c521b467..3484fa34e8d8 100755
> --- a/tools/testing/selftests/cpufreq/cpufreq.sh
> +++ b/tools/testing/selftests/cpufreq/cpufreq.sh
> @@ -52,7 +52,14 @@ read_cpufreq_files_in_dir()
>  	for file in $files; do
>  		if [ -f $1/$file ]; then
>  			printf "$file:"
> -			cat $1/$file
> +			#file is readable ?
> +			local rfile=$(ls -l $1/$file | awk '$1 ~ /^.*r.*/ { print $NF; }')
> +
> +			if [ ! -z $rfile ]; then
> +				cat $1/$file
> +			else
> +				printf "$file is not readable\n"
> +			fi

What about:

if [ -r $1/$file ]; then
    cat $1/$file
else
    printf "$file is not readable\n"
fi


-- 
viresh

