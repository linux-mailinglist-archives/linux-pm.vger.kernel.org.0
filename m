Return-Path: <linux-pm+bounces-21368-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA72A284C1
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 08:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7E461886A10
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 07:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183C52288CA;
	Wed,  5 Feb 2025 07:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B0hrGShp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68072165F3
	for <linux-pm@vger.kernel.org>; Wed,  5 Feb 2025 07:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738738813; cv=none; b=fHVoKb6YGZfK88hktXox8B5OC2SKgOd79KdEs6pYoEjXCT0zxQlRhs4BhBdvAi00UHUQ3toP+BlGoQ0nOL+cvfT1Hay+iit6/M+p0NMn1fHssTjVgx/j2YERoaHEsAeFxE18m14ad0RYbcjcz5sRD64CvsN0EH34OM1Aq6Og7fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738738813; c=relaxed/simple;
	bh=im78vuXKud+rm5BqDu/3RU+3fVMHUBCmxgAjcZkyagc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAviimXPmSguaLeNs/JBKP2cKQLLyoyOc/+ar+8yF+W8Fi3BGIgg6TOPJs/q3KZDy2T2ynXjRAustbeH4s64rxS/aM1nMU7Xqqil4JLlPy7Bxt3rC9tW2Xe+OimZFxBm0hPYFia0LvG46G5rTJN+5h5Yi1AAD5QfTzbizE016nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B0hrGShp; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21f16af1f71so7749085ad.3
        for <linux-pm@vger.kernel.org>; Tue, 04 Feb 2025 23:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738738810; x=1739343610; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+8ws3eogQ75UF4XPAfpmrJb1OdBIIOKRn93Q6XsSWXQ=;
        b=B0hrGShp7cQGi+DnrA0R/c6eym9L9/W+xiniPfroqfJHeC0uwGNF03RGdETmWc7m31
         /fMePmsdr8iykw6MCVS03sG6EdKnimyYgEua+W2pau/sJT1FlD/vYOm/kk34ctPJfc1P
         B3i5rAivbazWVtAqIrVC4lY7MQvoFaZad0zyDpjRFNuOXBA2qCR1HooZffwH5atTa2ai
         WXEB2aVneNBXHUBR+m++8V4M+dV0WdyvZOJF+iywwaiBbizn3FFrAf1cGwQTk2rgNczK
         ABN9E1OFDu78xvwUKXEmtDgPlYrySGbSyMqlEpk5EGLxeBPFM4hPpWO1Wt5zwWkrwT7D
         A1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738738810; x=1739343610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8ws3eogQ75UF4XPAfpmrJb1OdBIIOKRn93Q6XsSWXQ=;
        b=H/i6dWYDermSrv4HJTYSObH9gZozFpuAzXC/4A+Jc5kAXRzYYQUGU4SL7Nxj23r/CE
         WyQHByxClDCkwGjX3t4fGj7l0H8U8NcCkP3606WcTao2JHK3Qt5MMvepq8o+2iYDcLH3
         SASE+yi6RRZmQG4UrE7UmSknnTEe6ScOmpSLyx1gF/63z8CiLvZ0Eq6m7UBkTu43hoQz
         QY3A5iADOXxoBb0QqPx82yw259o1t6LL5KvrpV2KtpNkXLM18gL9K2dnvX13jnMCDVS1
         TgeUKfdwwXE0sNe6ofzx8utvdwt27+SbJIJM75DYZFt9GIJlFNr8PGINcFaC+qSXr2V1
         dj3A==
X-Forwarded-Encrypted: i=1; AJvYcCUsxGnOXu2asUjJ3A8x1e4HuD9sC214MjediP3VExzHUnIRCF4Za/kLdVPVP7GP4bcSHDN9bbRPfg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPKceG2paW3r+9NXiJck+i35zM8UUC+/48rkqriLtklPaZaXMb
	UL7zSxcBLTuyNvUHg+tNAlul7fOkLP7A4RnDZF1Zzcxw0Ws++oDeX5PG+qBgJKE=
X-Gm-Gg: ASbGnctz02HgSJtphtLD7Q+4uYMXs4lZMYznWjlX2lfck3t1OO08CEcVD6blCrut6jm
	PwjtLM+G8d4Id3Dp/47msxwa6NGjO6wZUq1kdWrM942IoqLIk0o6rpGkBTT+ktfQNfA6nmXMf7H
	Ra3yw6+U/FlG6CgSu+s5L586hQPIwTxpdx9ilFYU4BZw4EetQyW/O5cA1JBs3JL8PeYJCK+tvFc
	sFoG8leMP2qpAOQuKIN+4A0U5Koic3FBLvl9pMHLRiFs9xjNbgWVvobmYDoa6EM1avLJ1p7OZua
	QhSKvNN60OzUwXhPcA==
X-Google-Smtp-Source: AGHT+IFcBfowwoWBH0FBPbI4cZlw9NudpkT74gZC6XMMWGu1ebXPwbrRqUXqsIP4PMl1f/5/sfi3NQ==
X-Received: by 2002:a05:6300:668a:b0:1e1:94ee:c37a with SMTP id adf61e73a8af0-1ede883b7b3mr3096336637.15.1738738810041;
        Tue, 04 Feb 2025 23:00:10 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69ba380sm11638732b3a.118.2025.02.04.23.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 23:00:09 -0800 (PST)
Date: Wed, 5 Feb 2025 12:30:06 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Beata Michalska <beata.michalska@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
	sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com,
	rafael@kernel.org, sumitg@nvidia.com, yang@os.amperecomputing.com,
	vanshikonda@os.amperecomputing.com, lihuisong@huawei.com,
	zhanjie9@hisilicon.com, ptsm@linux.microsoft.com
Subject: Re: [PATCH v10 1/4] cpufreq: Allow arch_freq_get_on_cpu to return an
 error
Message-ID: <20250205070006.zpslntq6nwo73o4u@vireshk-i7>
References: <20250131162439.3843071-1-beata.michalska@arm.com>
 <20250131162439.3843071-2-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250131162439.3843071-2-beata.michalska@arm.com>

On 31-01-25, 16:24, Beata Michalska wrote:
> Allow arch_freq_get_on_cpu to return an error for cases when retrieving
> current CPU frequency is not possible, whether that being due to lack of
> required arch support or due to other circumstances when the current
> frequency cannot be determined at given point of time.
> 
> Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> Reviewed-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

