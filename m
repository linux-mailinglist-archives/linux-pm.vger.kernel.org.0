Return-Path: <linux-pm+bounces-38309-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B73C74BF6
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 16:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED3424E8185
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 15:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BD120C00C;
	Thu, 20 Nov 2025 15:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KwcJ34sb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F372D8773
	for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763650816; cv=none; b=tXMZ1KBjmfa9TOsb/aP6yAdzKZc1bR1KKkizjliPiLTgCo2A6bTuriq7TM3kWK8oit1DZAgSQI12L5YT+2VV6Yeaf99ozSFlR+AuT4BkV+COLsKjiTEODYXV+uNdatzzANSoyfFjEOOu9PnMSE4SOTaRovMwPtmU2OnazOUxDek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763650816; c=relaxed/simple;
	bh=xgjesNCRh05U41XtZs4CNpAsHg3mkNPSmnZ/h+qOQrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGavkJPabTs/mdQeTB1B761O+I+pvQ91zLJPik0CoWuKDlMzYQouO7U3OxKugZYiZ2i2SOVUelb8XkdkBfjbvR1wbN5dr2LpnO7I3Y8QyjQ4BtAgPjVEwqrZplkGWXjjawmbuCs/Wo+CD0nXAOOcYl81Phhuy+d4VIByFXR8L50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KwcJ34sb; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso817232b3a.3
        for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 07:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763650814; x=1764255614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=guN3/A9RDKesdWeSExyBOWXz8WsrEM+zBWVUbp5CDDo=;
        b=KwcJ34sbx0BuqevuLuo1gEH5WoPRecJEJYIs7WbBIGcflf6Nojs7CgFsUBr63UhZEm
         3APA3jhUDr+klFkLV7+hEeh8upVvFblLgbuRYZmzffUIsgVbdG3f9wZM0gvemOh2A/es
         MSBeIeeN8W+qN1sHsEOiH87uo+nneP3ZJ30Dm/TOxhmpFcXg71vS02TdmccDuvmcbgd6
         ehGKYJnIZbsltAKwgI9bondFnP7gd665ZEcifTjq1RVwygOcACY33h7YV5V9eFvx8xZZ
         78+5HcHaJt+8X+7rGlTcu9gBbx0ZQq2vqwKNiVSV3g+HBQSZGKAr1yqv+Kh1i1zdm0Gg
         cioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763650814; x=1764255614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=guN3/A9RDKesdWeSExyBOWXz8WsrEM+zBWVUbp5CDDo=;
        b=RbjhV3WCLrDKewVw6FZqpOfQscpJ2c+yn4c2yY6F/z4X6Bd0JphVXQBw34JCwy6MYT
         uyhvr/TuoRKl9LeeZmQemZBNQESTzMlWhzv2G5UWT4BacT/TOUjbpIsoyG098fwno2yE
         95U7Hum0wOKiF2qjm7Mpil9tBv20Arr1hptGBa/Hjbc+c1+BODuiUQAeQjGL/jID4wy3
         CsN8AW6m38ABtcQoszwo4qJWUvXbo+6UfTda/xj1U8wjSQFpFX5Ri3JrGBCBtoNZd3p8
         KNRvxOrrF1EdkWHDfewDq9IoarCWVbf+nah9HP2DiLsLFmRJUxd6S3tp3U9haJyL2ZlR
         IJvA==
X-Forwarded-Encrypted: i=1; AJvYcCUjbT04UfwSDzmr8GkIj2ETWqiKs2EfbMaDsTplu93mf1f0n8bAfNucZS7oWKF/2iN+1ACGRUzgwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZhe69OOANIgX1kCjfOK5I5qzDYTmuxRxL2uj8bCBCeXIBc4At
	DsuobkKIjc3gxgD/SyanPWgA+MyBdgQc7Be1ypkr4Mzo0HrZzcXVfWbwxKkQCs/dCiA=
X-Gm-Gg: ASbGncu3Z699OiOO+VvKecLXckFlUHgkjBdjJ7HXYICEBCSj+dlCcK0BjkLz6vlfFxK
	ck4o7sV3E07LIyq9tdfEP2Sv0caj+i9lw92l3F/AUaAZHYe0cEDUnmZEerp5tscewhKN9ru7L/N
	CHEAlIJM+77YGySoBaRBSXDkhkiOBXLhARi2mWEwmpljEq4SO3XyjsUXWjp/l/tT4hfNjPG1uyv
	mGZrs16F6UTlRPXsrhcuwuETWcPPzIj9+3uOXaCEOhTmhksy7ekViLSSKy5jHAx8tgMCBCMqXyR
	AVCBP6m1dJ6KrAk/JJPi0ZD1rcL0SGu8+lo4+rvAsMufC3xMB4QZQ6WE/00Ijq9ASh9aq+wAFRH
	7cgf6YzCCVmVaBdGVt5fLpNr+BN7X9VOP//gxf9yO1a++QWLIw3BAotCmn6rKWP9TRNy/73+F5B
	5eSfn5qip2/4fAkeRkajW1T9kZu7aKi3mK
X-Google-Smtp-Source: AGHT+IFQUlIetO8So3GJH/GYIL89TsemkOodGy6g+HZcCYNwqLeei6RZkHpwINCTUqkre5rA/o3bJA==
X-Received: by 2002:a05:6a00:1a86:b0:781:261b:7524 with SMTP id d2e1a72fcca58-7c3eef7de45mr4122134b3a.14.1763650812076;
        Thu, 20 Nov 2025 07:00:12 -0800 (PST)
Received: from localhost ([122.172.86.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3ed37b0c7sm3093109b3a.20.2025.11.20.07.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 07:00:11 -0800 (PST)
Date: Thu, 20 Nov 2025 20:30:08 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Ilia Lin <ilia.lin@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] cpufreq: qcom-nvmem: fix compilation warning for
 qcom_cpufreq_ipq806x_match_list
Message-ID: <632sxqm4vxqg2e5aetuoakl5kkjb5x4zsyrdzqes7ylutiokxy@6tejdqp5x6ko>
References: <20251120133508.4237-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120133508.4237-1-ansuelsmth@gmail.com>

On 20-11-25, 14:35, Christian Marangi wrote:
> If CONFIG_OF is not enabled, of_match_node() is set as NULL and
> qcom_cpufreq_ipq806x_match_list won't be used causing a compilation
> warning.
> 
> Flag qcom_cpufreq_ipq806x_match_list as __maybe_unused to fix the
> compilation warning.
> 
> While at it also flag as __initconst as it's used only in probe contest
> and can be freed after probe.
> 
> This follows the pattern of the usual of_device_id variables.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202511202119.6zvvFMup-lkp@intel.com/
> Fixes: 58f5d39d5ed8 ("cpufreq: qcom-nvmem: add compatible fallback for ipq806x for no SMEM")
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

-- 
viresh

