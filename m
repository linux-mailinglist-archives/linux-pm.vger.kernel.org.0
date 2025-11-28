Return-Path: <linux-pm+bounces-38862-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC71C90EB0
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 07:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF9983A4C65
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 06:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F40274650;
	Fri, 28 Nov 2025 06:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uqaVL79N"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E3D1FF7D7
	for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2025 06:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764310023; cv=none; b=CnzcdmbLTm96NUqsvCww5K/Gsek3D0tuWHjb1kxnxolpfWfcwqqd7BEV81dtKxBAyM5Z+8ZfI1yu7E/wyAodGoS+kSfKcgNGdo+a7gSk0ejl2/kIu23Nnz0SEXyA/4JgvA644H0oZ33Ane2kozwJkTSTioGqpqXLcwK8bf8YBic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764310023; c=relaxed/simple;
	bh=aGkSH+e6ADiGGvBZOvRLVIwD6RyruNU0N2UEzGaAvb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWaLj9hr/nWzUhUftvOf5bQn8Z8A2oJ3zt5qF0xSRsKyR0MkufEJNoDNVfbiAMomrX3KOiX9Rim2CUOSR78tPI9y8LsdAMJ3y7gN+puy9WeZXJKUBNHRIDP0BxEFf1B02Iqewra8CpwiM7/pVYL8I28tO3qMwF8NX9Wdda8FIFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uqaVL79N; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso1278647b3a.2
        for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2025 22:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764310021; x=1764914821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UINlyN9XJZFH6hoTfD7z/RlPJNtvXAnlmumNrk60bNM=;
        b=uqaVL79NXm80PBg6r+NLkPUUUNpq/i1Q9jvEEbU0hJmSg3GJtEuuh8WBZsgCBifmoU
         P1ydhQ9/3PP/0wNYRGLFrxo1ZzVHJs4OUNw8CSasfEkaLBLEmndJB7ehTfKtlSCi/DU4
         I2wIP9wvnqVvx8hGEUQhkea8zcUIEuNZEam3phrW1IMyTVpm4GE9VX6du9ygFFHq/iYC
         yEHnomnGrCkGZo1sf5Aj5ZmpdydROCmCQ1EJIgVjlYnmHpFj27w6Jppqz0FVgVdwWyGV
         7WSYZya7mryPtjrgGB7IFee2BelXQ6cPxVI670O9Sh17fh84JCk96buwf2+yGcCCnYV8
         F/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764310021; x=1764914821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UINlyN9XJZFH6hoTfD7z/RlPJNtvXAnlmumNrk60bNM=;
        b=mOIp+9l//qOCu+NvJdsupzIoX7u7RjjotUHtSVZNDC3sJtA+9wPMjVOBWFj9FI3RXz
         2T42B+V0UyYQtWbqVrGf1vPP/tCC2Uf78OzXtj6KWrWXIgXL96CkuZyZlLxg1ZVanbmk
         v+Y9ljkU6XD7pUkyK276q/oo60KkKOZYP3YMqgLJYB7rTJ0dDsBk98zY9Ce0z01d5N0+
         wX9WuF5H/4cGpKRWc+iNF2bdLBDN2FwONHRk+FhMzHx9LHNZ0q0m/0MLkeSpp6KTnIN5
         OGSO1e03BdbXrcvUR96NP7L+dIZ9J837ETaAAQb8CauMW6EmQUScp9y5BXSqNfPvpDEj
         THlA==
X-Forwarded-Encrypted: i=1; AJvYcCX2jfLAOXH9GQIg5WiVTvnkMEy9CG9mkRrq7WNcYndOBTRZAH9gTInD6mlQMsmZDUIN3ZeO1ecX/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWlHtAVMJ+9yzKHD2O8Fc7rWElKni5zotxrmlzDDM+9TvnX/+O
	3daB8hMKD8lXVsI4X+9jPEWZ+FzRWKsXBnogCGaEKO7TKxEL/SF4ViqH3o8fsOFroR8=
X-Gm-Gg: ASbGncu9lmOB259YHm3htNepD0URuQmsLPhb/ijaszN6qh2I2JKhkVNB1QhknBHTt2f
	a/ajDdQfOFEVmkyZapzvsOSWUAsckNoM+c/f8sajSJwcDPRiOBRcnndX3yWVSWyNNKNgjdhNdaf
	io7+ap0dY/XlDtH1NKtDLnp2h+kJJyg5eh7pwKd8rYG9awpR41T1LaSyLLWwQwK4XWZGsK59KnC
	c/lfc+9VRfRYjCfxVfA7cz/EqK30jve//lgyWzNVSHlf/yNBujnzn86uixcBfeJ/zLmAb0Y6zoH
	B4hznM56z/8B+lHoz0YtH+TeKHIRzny2Sv+8j0ng6dDgjPQbbKICe7myas54V55/gVyDHRMVCWZ
	DRWdVqOZbsqCZWEywAlpe8DBz8pJ5uKlzInQzbSbxim8vHSprMxnhyvUfTprKV9iYKpbtvTnrf4
	ssXNlDPJu/178=
X-Google-Smtp-Source: AGHT+IF9FEo0fohI4FBQwYoTmU3P1/DeVty4yLKx9PZN8PwW0h54L6AeAuYWcMLWJ+PBHyHGE9uR4A==
X-Received: by 2002:a05:6a20:914d:b0:35d:3b70:7629 with SMTP id adf61e73a8af0-36150e5fe3bmr27657843637.18.1764310020704;
        Thu, 27 Nov 2025 22:07:00 -0800 (PST)
Received: from localhost ([122.172.86.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15f17602csm3687312b3a.56.2025.11.27.22.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 22:07:00 -0800 (PST)
Date: Fri, 28 Nov 2025 11:36:57 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, jonathan.cameron@huawei.com, 
	zhanjie9@hisilicon.com, lihuisong@huawei.com, yubowen8@huawei.com, 
	zhangpengjie2@huawei.com, wangzhi12@huawei.com, linhongye@h-partners.com
Subject: Re: [PATCH] cpufreq: Return -EINVAL if no policy is boost supported
Message-ID: <vzxdjhhkukb62kifaliwld3hhfrq2auhxt23bbz5r4vzebs3c7@2gjhlykrxfdd>
References: <20251126031916.3641176-1-zhenglifeng1@huawei.com>
 <wnnfdvp3r3bg5wztazoijei2uji5xypl4b4wlvlxuwxaizu6g7@2xxyrk7kdxhf>
 <2dbbb205-5a04-457a-b643-e965aaa2a14e@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dbbb205-5a04-457a-b643-e965aaa2a14e@huawei.com>

On 28-11-25, 12:02, zhenglifeng (A) wrote:
> On 2025/11/26 14:29, Viresh Kumar wrote:
> > On 26-11-25, 11:19, Lifeng Zheng wrote:
> >> In cpufreq_boost_trigger_state(), if all the policies are boost
> >> unsupported, policy_set_boost() will not be called and this function will
> >> return 0. But it is better to return an error to indicate that the platform
> >> doesn't support boost.
> > 
> > I am not sure if it is a good idea. If boost isn't supported by any policy then
> > the driver shouldn't enable it at all.

Drivers like cpufreq-dt actually set the boost callback unconditionally, which
can lead to the case you mentioned. None of the policies support boost, but it
is configurable.

> Yes. So I think return an error is more reasonable when try to 'echo 1 >
> boost' in this situation.

I am inclining towards this now.

> > Also, cpufreq_table_validate_and_sort()
> > sets boost supported only if at least one policy supports it.
> 
> Sorry, I don't see any connection to cpufreq_table_validate_and_sort().

Yeah, I misread, we are only configuring policy's boost flag there, not
driver's.

-- 
viresh

