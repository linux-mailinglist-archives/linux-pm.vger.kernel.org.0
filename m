Return-Path: <linux-pm+bounces-12789-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BCA95C462
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 06:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D68FE281F15
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 04:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD61A446AB;
	Fri, 23 Aug 2024 04:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ELP7+sYj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B3921345
	for <linux-pm@vger.kernel.org>; Fri, 23 Aug 2024 04:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724388701; cv=none; b=rezwnvx/OZtR+R6H2cltCX0iQM9mOuLC0TFmzEBvxKR23HhmtzlzBftR8tCAvn2clQWkTZINTlpmLFfQ4ojl+eDGPJsff6jfO8509QVN790x7iX6p3IVJ77ygKNsgvBKsvmXBxSWoLsRDdc7Thyi/r6sdwX5/gHGII+PYEVxOsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724388701; c=relaxed/simple;
	bh=av52YwTepcH6w/o67nFB6yHuFTLUA2dnDh7MCHEeOCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/UEv6Ey6ji9KmDcnSfolZirZ/KEG+vc4BTNplcqLUnIizBsCLVE+WsJwUd65uzQDltxmTeS92EBIOtfyquOt00kM7NXQ0uMJ76ATShTj08Q04JWYCv0Xvzze5cv+Q49BXw5SbG2x8YPVKK15v/D1+rVDgIHC/1kyRS9rkJuqhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ELP7+sYj; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e0875f1e9edso1542008276.1
        for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 21:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724388698; x=1724993498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oESpv3vgGdcQLt0Ql+k5B2VyzNSZkxEYUIwO5fuPsiw=;
        b=ELP7+sYjijPCRt4HDxVned5Ydjobi3/+P3EHmGZz+YwKCriO+C9kkT8qdaEMgVjb1I
         t2ghiU6Jw7eGzz8Cta64ytFM5BhmVdMtK+yFz8OFgCJuQEcLajbBfhYX4SYTiV95c71u
         dfhAvYTk49tqhC+1f4TIsJI7m047DrqdTarTlWe0HeGz2+WtN0ucuqWzcBYHdywE5GwG
         ImwxXsBZr0z+hdhfo+WUEiIM+O2JQ9Zf+xpy5i0+uIsxk4K4hzog5W3AlPJDvfGBPykz
         7nq/o/XBPDZVCHx63/6wkN7Q4QCwzWqqpJ/vDMJe5hi6rjITZ3OmYjguQjLneNIY1wpE
         taOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724388698; x=1724993498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oESpv3vgGdcQLt0Ql+k5B2VyzNSZkxEYUIwO5fuPsiw=;
        b=GJ0M4gb4s2CTG5jsRKcLyb8aq08ge5ThmOULhVEKhV3vL1LqEhZN5IEAkm6djLfXe3
         GX9YT57Yn9dSwcAlysa55arfgTgg8V8BCYpwMIeedLl1/naIxIWgRXghmHXwIyeYbv2b
         RqhYYKvnsE3Tc1ekkyJOJIA6p+tLnbAjToeqHdsdU2uHi2QanSRXPWn7A8FhDfWMH/2G
         WJWY+B7d4fQqdXSmav1zHQqm/S3Jt87V3HGc+O2AiDEpXhfU/uak4Ss1nbQwF4FHbgUE
         kkIjHsEM0zhjOzjSC7I6JMfCLsOEQyrM7orkeccqg9AW6Vinxb+2/UCLDYGdwVlYuVMM
         TfVw==
X-Forwarded-Encrypted: i=1; AJvYcCXTMVpXaBhYTx0HkZB3hqpCDs2A46BuHq2HPAMnBWM9mDucZ/tAnWBSiDJLr+KvoXhDoIbhDWtOLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLaGFJBLzIUhBuWmIlbPgMwv7JraUGJOrp+tD+0eB9SeVakS7w
	K5wTC15AFctw8SbJWQxgtyo2CTaihxFP1bUOZZZ77C2XrLaDd9JaiOuOXgyojP0=
X-Google-Smtp-Source: AGHT+IG+UUr9I9Kx1MlKaSJloMw5/2s4SAd5IoTJFMRYf/mmnYNzNHQPyKBfwKFBt3C3MSKzrS4zpQ==
X-Received: by 2002:a05:6902:1b09:b0:e0b:43a0:3ce with SMTP id 3f1490d57ef6-e17a868b00dmr1160643276.57.1724388698425;
        Thu, 22 Aug 2024 21:51:38 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143432f089sm2174710b3a.185.2024.08.22.21.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 21:51:37 -0700 (PDT)
Date: Fri, 23 Aug 2024 10:21:35 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <quic_kdybcio@quicinc.com>,
	Nikunj Kela <nkela@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Stephan Gerhold <stephan@gerhold.net>,
	Ilia Lin <ilia.lin@kernel.org>,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/10] OPP/pmdomain: Assign required_devs for required
 OPPs through genpd
Message-ID: <20240823045135.fifawemuwaxafeb7@vireshk-i7>
References: <20240822224547.385095-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822224547.385095-1-ulf.hansson@linaro.org>

On 23-08-24, 00:45, Ulf Hansson wrote:
> Changes in v3:
> 	- Combine the two series [1] and [2] into one.
> 	- A few minor changes to consumer drivers.
> 	- Clarification in commit messages.
> 
> Through dev_pm_opp_set_config() the _opp_attach_genpd() allows consumer
> drivers to attach a device to its PM domains. Their corresponding virtual
> devices that are created by genpd during attach, are later being assigned
> as the required_devs for the corresponding required OPPs. In principle,
> using dev_pm_opp_set_config() for this works fine.
> 
> However, attaching a device to its PM domains is in general better done
> with dev_pm_domain_attach|detach_list(). To avoid having two different ways
> to manage this, this series prepare for the removal of _opp_attach_genpd().
> 
> Moreover, it converts the few existing users of the _opp_attach_genpd() into
> dev|devm__pm_domain_attach(), allowing the final patch to drop the redundant
> code that becomes redundant.
> 
> To test this, I have used a QEMU setup, with local PM test-drivers to try to
> test all various combinations of single/multi power/performance PM domains for
> a device. Hopefully I have covered it all, but I would certainly appreciate if
> someone could help to run a slew of tests on some HWs.
> 
> Note, due to dependencies I think this whole series is best funneled together
> through my pmdomain tree. If you think there may be issues with this approach,
> please let me know so we can figure out the best merging strategy.
> 
> Kind regards
> Ulf Hansson
> 
> [1]
> https://lore.kernel.org/all/20240718234319.356451-1-ulf.hansson@linaro.org/
> [2]
> https://lore.kernel.org/all/20240723144610.564273-1-ulf.hansson@linaro.org/
> 
> 
> Ulf Hansson (10):
>   OPP: Fix support for required OPPs for multiple PM domains
>   OPP: Rework _set_required_devs() to manage a single device per call
>   pmdomain: core: Manage the default required OPP from a separate
>     function
>   OPP/pmdomain: Set the required_dev for a required OPP during genpd
>     attach
>   pmdomain: core: Drop the redundant dev_to_genpd_dev()
>   OPP: Drop redundant code in _link_required_opps()
>   drm/tegra: gr3d: Convert into devm_pm_domain_attach_list()
>   media: venus: Convert into devm_pm_domain_attach_list() for OPP PM
>     domain
>   cpufreq: qcom-nvmem: Convert to dev_pm_domain_attach|detach_list()
>   OPP: Drop redundant _opp_attach|detach_genpd()

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

