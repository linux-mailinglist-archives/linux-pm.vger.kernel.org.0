Return-Path: <linux-pm+bounces-24686-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FD4A776AE
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 10:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11C97169565
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 08:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE831EB1A1;
	Tue,  1 Apr 2025 08:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VctNXUWk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179F31E9B3E
	for <linux-pm@vger.kernel.org>; Tue,  1 Apr 2025 08:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743497039; cv=none; b=Ll2K1sfHuFHoPpQ3/FARV7ioaPlvzHIojju6tKtGLwf/2CD00DQJeFzGmx72B0PdTuk+o9ODWhQ8ajXNa1cJ3ER8h61hGVLTneDSJnvsEx8UWukRlIbK9zQUXwwclsVdB5FpSD/LpUKt+oBGOClarx33FlRMiFIRJnm+KDOVPTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743497039; c=relaxed/simple;
	bh=a5eD4Nf4CllbdMKSZMxCDgkBvoaX6RuxU3bFJroBS3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TD4NxyQIpWs/x2OexoyAlEOxI1WhKS3uPnTOeZBIsCZInDqcFU3sAUhNBZhqBXJYgKuO029Dr5uZXeLkYi1WfQda7clV3XYIj03Dbirc7OxpriO9GnnU3NGmIHzzbGfYs+XtBMDSOGdk75baloxv3G4b6k+3Tg2Lq+HoY9z7Anw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VctNXUWk; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22438c356c8so103165105ad.1
        for <linux-pm@vger.kernel.org>; Tue, 01 Apr 2025 01:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743497037; x=1744101837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WLWy2alZnNkADP/5Gco9r2HTcFvjh1fujX/fWbhR3WU=;
        b=VctNXUWkwJuE/3DHbPPUHlpl/+hkMu/qIMDWBHQOeNqQ6SGl/p/41vary6FsAvQVAY
         DGHuyjAmN54GLs17luXp+KCBSFHcnL2unEPeku5Y9L79oqbJPvzmMEG2Bu5+JhrgR7fn
         5/xt6qAMeG2GdGZiB3jmF+ktfSk8XilhNRpjbs8cX2syJdWNRb3yG7KUaQlUY+GM72P8
         74jemol4aIokHE7iVq9eLEGv2fEYAQA0vCr7nsqgNnXN1DMW8APneHh55df3XcLJ/DYS
         OO7ecbSgTJxTmmBhaXiQYHLO75SXHVjk23mDg3iiciPpw2jS6qtjTbkgllPwKjjs+18D
         4mEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743497037; x=1744101837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLWy2alZnNkADP/5Gco9r2HTcFvjh1fujX/fWbhR3WU=;
        b=nb+pjnZKpFHaOdnQ3rF2lHxYXHOmksCBYLq7ik3bW4brxbdtn7SsNEkTwUkwEn01XX
         MWn0R79eO/gGqNjmC1ybCGxR/gMpIgHmhbLuR58Wr5DjQT3fpjdT/4R/f6OUqsKt6SCJ
         111JBQhCWwZo+LhZIIpi1dkxa0c96/dQw3lcl6iXJb6fXW6mmSK+W9mEGvYgfZnHzPpe
         vDhYVcqu6liKBCG8lO9HLSIhbCCbrRm9XkLLxPF5h0Y2wpQsnSLgjSluHIV2xoix0Tec
         LrIa+1/ESKj5MFa19rdzSjWltNMXeUelnJclw3DerChpn5CFvJUNk5kBv38HPoygwOh7
         izEA==
X-Gm-Message-State: AOJu0YyagsKCNeFqXqEVaJ8wIJYTEzE/cB0VY8ZmSPkf7pYrM1LIoiYc
	99+amZq/lOgMtyq0ST4k0nS+rIGKrhGnVXfO3Oc7SAOc+sUVL/2BWVmvFzFD5lw=
X-Gm-Gg: ASbGncs3lnjn6XYemSwjZxaKCaHdFv4+tziM03NfUqgWhBK550+36u4ERbuhz7iVCvp
	cy0MCC4RMUWAnI4T2Gx+WwOtAm4VPFaHlGmtZlsBc4C7ezXXUDWTV+zjxmraFIH/y7Ba9cw5FV9
	pY3dIFMnojEtqccuyWSo9TWO5vC6I317/YEhwweHQnjg5b/oEWxFiPxQiQXBBi4o+htSDxj67e6
	LwGqhhoZ9ckvT4FccU3gnmxkC8JEdW39cFNMiBECrKmfT2g279GXGP+wnuy6E/w701cCE7wkZdQ
	R2QDuz68YqbsDpJh9rYegwfBUEGr4eOrp2bBOVFWo1Lz1w==
X-Google-Smtp-Source: AGHT+IE2qpcVDIpD7Ppklhpye/oMKOfFQhQ5TB+Xfh/36L4quAqnm4GiNbm07T9lZU/wlQO1yn6SDw==
X-Received: by 2002:a17:903:1106:b0:215:b75f:a1cb with SMTP id d9443c01a7336-2292f9448a5mr182770685ad.9.1743497037338;
        Tue, 01 Apr 2025 01:43:57 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1dee5dsm82687835ad.189.2025.04.01.01.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 01:43:56 -0700 (PDT)
Date: Tue, 1 Apr 2025 14:13:54 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v1 03/10] cpufreq: Split cpufreq_online()
Message-ID: <20250401084354.r36er6wfqflbs2jw@vireshk-i7>
References: <4651448.LvFx2qVVIh@rjwysocki.net>
 <3354747.aeNJFYEL58@rjwysocki.net>
 <20250401083854.6cp2efo7wxvxjcdd@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401083854.6cp2efo7wxvxjcdd@vireshk-i7>

On 01-04-25, 14:08, Viresh Kumar wrote:
> Instead of jumping back to the function, won't declaring the label here and
> jumping from the earlier code to the end of function more readable ?
> 
>                 goto out_unlock;
>         
>         out_destroy_policy:
>         	for_each_cpu(j, policy->real_cpus)
>         		remove_cpu_dev_symlink(policy, j, get_cpu_device(j));
>         
>         out_offline_policy:
>         	if (cpufreq_driver->offline)
>         		cpufreq_driver->offline(policy);
>         
>         out_exit_policy:
>         	if (cpufreq_driver->exit)
>         		cpufreq_driver->exit(policy);
>         
>         out_clear_policy:
>         	cpumask_clear(policy->cpus);
>         
>         out_unlock:
>               up_write(&policy->rwsem);
>               return ret;

And now I see that after 4/10, it doesn't matter anymore.

-- 
viresh

