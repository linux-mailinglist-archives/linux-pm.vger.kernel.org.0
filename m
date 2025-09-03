Return-Path: <linux-pm+bounces-33674-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0988B4136E
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 06:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 745B7165E3A
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 04:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5942D12EC;
	Wed,  3 Sep 2025 04:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B4+sWuI4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4852721771B
	for <linux-pm@vger.kernel.org>; Wed,  3 Sep 2025 04:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756872770; cv=none; b=PUHhYK/2YDmv+uwsmN3wbpM+jcH/KyVBBiDXThrFj/2gq5GhK26vSZs+KTZ59vJ87kl6pyOKBt2LE3andnrAOzUeTX6x3rt3RzCIPp4DfEq8mTju3EvnHCpMEczI3E9O7IR+k+fyzggghfcOoRoMntP/viKhcKPdbyY9rkdGs1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756872770; c=relaxed/simple;
	bh=/1HMn7TFnXWW0UY/05jkl5C6MPAXQFHbBWZ0g4cg5dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5sVKP1XCnBEm49kFb2dGVa+QL+c/NQ636hOsPKOmokG9TdPuj+BGAFeyHAmwZWK25OS15sgIqwZEnYUrK3/Vje7ZT+cgYwGz51vgOZWuPzMZSqvyQvO2EWo4rE8Yg1OmKpmrf1kQPn26yq9L8DWHiRvqKFVwddZrsUi1g2E+Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B4+sWuI4; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7704f3c46ceso5137736b3a.2
        for <linux-pm@vger.kernel.org>; Tue, 02 Sep 2025 21:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756872768; x=1757477568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W3tslRr0ekK73GDvQIZh7lN5yUKeNtEca8n0sO52evM=;
        b=B4+sWuI4o3x/S4rarOdP/3KNAp8QjLz9Ga0dqH5OAgrHdxBf7mSIM+XFltEdrfus2x
         Etoc2rT5cv3UnKsjuD9Osx0Sxp5/odX8VR99YFHzrcmgVkC/I6VpjWDawcpq0sfqItUF
         kpLrAikLtwDjdVyIB53CDCVDRHcSNQ5uzwGpEjE5H5OySDPxYr1mbCylKQfj8uqEViMd
         Ko4DUJCEOI/CteFglAOeOxTocxHBjnG+DRvpi2hiv9EJy9DWg4VQjVOpUI8t9JANb50r
         ujn7P+7AKc/vW9VCHk/uvGEWLOek48EHtWzUzWUufAWnWXSUurYuVhb0YsdGVVegRX1g
         ppWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756872768; x=1757477568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3tslRr0ekK73GDvQIZh7lN5yUKeNtEca8n0sO52evM=;
        b=w1h7p80lFRfR3ffzjVzePASU9YJmOl5m+A+MoZKMO3b6L93deMVjz2C6CfxzfgVzVA
         WyLSbzqv3jkDLzYHMS1BzNY5XkBo1vhZDpj1BFrKVTEqfHQkT1z/B5L5eIElk26gUdFR
         WLp38WfCgxgKZoQFYPDOkFnBiWtUcXD0p3/0COOfO8T5zw8WW2dr10gnRZGXepUv2Azt
         /z4ZRqpZOx1J+TrRNUASaobWQEQpP2wvGrg6Xsm4KrBlfOcXgJyc8yg9jG1ioXMFIBag
         g6io8jF1rai39cjkURz3CH7up+j6CWpjzw/TQdp1SzBVjcX9oTYpae6Q43tuL/Ve2HCM
         OUJw==
X-Forwarded-Encrypted: i=1; AJvYcCWDlLaaz4NDQlSCOzY5jkJb291GN9+1JntNGGhyzMHEDtt45juznUT5S20DecCfj1b1LNjVwA+OWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdHMvU3O/8paMlRYND/pINuVSHi2EwrB+3+X/9u0OJmmw/lxKj
	htoFcaQD05IyVnhooZOt9GAVVxYwrqh35CDcCaL4D2Osrfx+rHHXSZpX2ASbZa2smH4xo4utHVp
	pTwse
X-Gm-Gg: ASbGncuEOR7f2bHDUVmMOgimjkPIQ/RxKlRMJKdqanNbx7nw8OPGf1+qwyIHs3jRa2Z
	V+yzY/crykU9FnxJy5j6zgIBn4Z1s+XE2ejRHQ1CX5KPE0jseQFZH4ORaaiFFq/Hx9OuWt5Mk3X
	ENpfotcuNpSWZIyOJZE0gGNHwatiG/JVm6AvaA/gVu1rv3p7+LThzYtkrAtSsujba2kH8o6Qy4N
	uraS4GqZ19jths4rHwVfXFMvnvZ+tqVtt5V/Xi7pi8p5aDSKr94wckGfO146lti/9W6Gj3NwHvz
	G8f/5dLaEmM/rFOof+m1j4zLsDvj5b0FLMdXCfwaxmU6wWPk1YV+EYkCzO4dDUhKshTlngddK3Y
	t+g/t2IDd8o8EfVr+CNkW6Dkzosj/7iQG6Ik=
X-Google-Smtp-Source: AGHT+IEIDICXjPZJ+Es9fWHlaf/Hhb5fWtqthz8BHzTOB9rr+4nE8sud8VaqfbgZ+64bT+tan82DFw==
X-Received: by 2002:a05:6a20:7484:b0:243:ca56:a71c with SMTP id adf61e73a8af0-243d6dfc0c8mr17604683637.13.1756872768457;
        Tue, 02 Sep 2025 21:12:48 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7727bce1b58sm1650136b3a.9.2025.09.02.21.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 21:12:47 -0700 (PDT)
Date: Wed, 3 Sep 2025 09:42:45 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] cpufreq: Use int type to store negative error
 codes
Message-ID: <20250903041245.exmk2f5zdpxik76r@vireshk-i7>
References: <20250902114545.651661-1-rongqianfeng@vivo.com>
 <20250902114545.651661-2-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902114545.651661-2-rongqianfeng@vivo.com>

On 02-09-25, 19:45, Qianfeng Rong wrote:
> Change the 'ret' variable in store_scaling_setspeed() from unsigned int to
> int, as it needs to store either negative error codes or zero returned
> by kstrtouint().
> 
> No effect on runtime.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
>  drivers/cpufreq/cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

