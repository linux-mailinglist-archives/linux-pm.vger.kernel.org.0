Return-Path: <linux-pm+bounces-24690-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C58A776E6
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 10:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 202F6188D434
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 08:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4092A1EBFE4;
	Tue,  1 Apr 2025 08:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mtjAcWFt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED371EB5C9
	for <linux-pm@vger.kernel.org>; Tue,  1 Apr 2025 08:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743497493; cv=none; b=l96j/oX57UxBF4nWmBu9Royrkm3Tcdxi0VOpLazixX+8A81rIReSF6nCfiTkGcnNbLRy4wtv4MTGQkUPJo6SEGq7PEYdsa8vegN2IGr5dGrgTywS8E+irfj2OBtc1c1auax9OkxG7WPpaRahhOEEZ7X0qrL9odI7nk5AC+mpJic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743497493; c=relaxed/simple;
	bh=G99hNLJKz2dRSajkAKgFMaa6+sm7X49mSBNVSpQtIfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQ3rTh06Z5hdKUKfRwlTuOvuy2SrEIoImCzEPN1ucaquok0gIPpvcQEBw0BiDl9vnbDyWrhi2fXtdkMfwyRZ89IJPWNFN9lOEl7jzm5refK1yq+zG3s9ruFlRwruktP/6u93Nvm1T77+vqtNoA+QjlX0JaApot4Iqsjml7kyDmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mtjAcWFt; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2240b4de12bso80040135ad.2
        for <linux-pm@vger.kernel.org>; Tue, 01 Apr 2025 01:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743497491; x=1744102291; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ncijtObpu3H+yOpWt/VEJ921wbH0VWxIH+2QTCuuyAI=;
        b=mtjAcWFtA12wcioitPFy8nIw76HPv9+SLFsNiCHnAPLa2Ggw/iQw71Luow9+orL2Fv
         mc1iTLI0iMqYp76mjn/dt9XL97tyJsoFspOC6kHXMY2leWV+MNem4R1Nnro+lqhcDJpL
         PQqDJu2s1YasBrlGB38ADKzQJypiXfaZ2My5SeTFk45u4pcoj40kKZ9N1py33CSEHAWc
         l51Pv+dg0ia60KysH6vDxqSXYmVkHgCm/dDD5erlildduqLJpOJahw0ZNr1kh6jn8hgj
         ADSFFGuoPtTqsyjcUa/85O9Q34ipdhDp87yqgddLcUlEBoMPMTPeqXcIDUqjs3UnzcPH
         bTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743497491; x=1744102291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncijtObpu3H+yOpWt/VEJ921wbH0VWxIH+2QTCuuyAI=;
        b=sptQYjjKHtdbD5jEYwqxOckmWUf48QJRW9DYWENGFglrlOg2mtV8fEeXpQ95OwbOlk
         +fBuzN0eGRV1AEz+dS701DKMMys4faRU7vicyGbr5zDrggg/lAoao5fV8o9HW1pHByZR
         fXs/AE2vH2vlQR8gDCcuPycg/i1EoyfCOlSiPKFc1Q0z14KJ9zc0TPzykiKYuzMd2LpW
         NFQsFHYdxnzCvW+nnE+3PUcUARPVt+ZMvW2XtIKcIpiA+q+LiLPqaNFlM94pin6vogf9
         iSn2FsIUy2NyCzfMe9MK8lvV5JSH3T1G0WrC+ggPnIIlskcaLifqAivm2VCGy49vYAOK
         BPuw==
X-Gm-Message-State: AOJu0YzHM3stHbd+x+qzfCtQ7mdE9c5aPAfZqsiyOx8Btl6Haq2X4d78
	SDLlSPLJXHThO36FbKC0lbAmVkiDp9SH8aicoAqBmZiTX2DCJ8W2IIUliVyA8sE=
X-Gm-Gg: ASbGnctfrXF3ONjrdASpuheHOHXLXwDYn8canVFdWM++EmyzgpVVNKxyMJCg/lPjg96
	fVE8RukZ78wNQhECFxqxM2yuMlfcPsYPdeP0l2pwFphSI0xM2+IANBi7D+qOKzsm3RUTisRApeO
	HVEkHZdeTOclIGuyPSu+nTxcDGIX2tn1bz01lGkNvhRaahc1CuwMc/hPl7ObnueL1UDNhSccJyR
	HVxFnZ7fF9iIQtGOhUOdL/gXYSTOBlGq+czRKhmVHzV3u58QnxPgLvBYWvbaLyBVw4hblnKfmYS
	l93OuutuSysf8sSR4ncGpse6HLD0yhUPmMWa+SVBm1Ulky0AFWpbRS5f
X-Google-Smtp-Source: AGHT+IHgchxjNjfgbmWfX0yWlNGPZh3KlahObrW01+mzCOlyj2vk0k8E3QdDKBm62ZGwBUaavsQHwg==
X-Received: by 2002:a05:6a21:3a8a:b0:1ee:ef0b:7bf7 with SMTP id adf61e73a8af0-2009f640527mr17276648637.19.1743497486103;
        Tue, 01 Apr 2025 01:51:26 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af93b6a02cdsm6393119a12.26.2025.04.01.01.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 01:51:25 -0700 (PDT)
Date: Tue, 1 Apr 2025 14:21:23 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v1 09/10] cpufreq: Introduce cpufreq_policy_refresh()
Message-ID: <20250401085123.e6cr7nkmzoqzuptj@vireshk-i7>
References: <4651448.LvFx2qVVIh@rjwysocki.net>
 <6047110.MhkbZ0Pkbq@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6047110.MhkbZ0Pkbq@rjwysocki.net>

On 28-03-25, 21:47, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since cpufreq_update_limits() obtains a cpufreq policy pointer for the
> given CPU and reference counts the object pointed to by it, calling
> cpufreq_update_policy() from cpufreq_update_limits() is somewhat
> wasteful because that function calls cpufreq_cpu_get() on the same
> CPU again.
> 
> To avoid that unnecessary overhead, move the part of the code running
> under the policy rwsem from cpufreq_update_policy() to a new function
> called cpufreq_policy_refresh() and invoke that new function from
> both cpufreq_update_policy() and cpufreq_update_limits().
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |   31 ++++++++++++++++++-------------
>  1 file changed, 18 insertions(+), 13 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

