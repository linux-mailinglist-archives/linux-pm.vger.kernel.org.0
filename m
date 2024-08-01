Return-Path: <linux-pm+bounces-11790-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E42119442E5
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 07:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B9C7B20EA4
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 05:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F98157470;
	Thu,  1 Aug 2024 05:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SUUSZV0Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677D713D62F
	for <linux-pm@vger.kernel.org>; Thu,  1 Aug 2024 05:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722491516; cv=none; b=hH9fFtpR27Qps6L1BhwG3bO0BQF6mXrYM48oP9F4xvsbeC15MJL1lC0FOi3SDwZhAD/n1r2NON4QJ0IHKky+RBlbwHV4M2KnA5LXGfbS5mGCazIKWyv/2lxAurgLtVu7sKv7v1m05wBapQOFoMLtvHupD1TcU6uai+41j9V7Hy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722491516; c=relaxed/simple;
	bh=mHdBEdoA646mRvFAlQiOSeu1k6r5IpBY8UYszqgYIDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YR2OE1BWVQ0fgrHxZ/NWwzQnSrCBmSJDOxMwLbs0BBnt/b+AtSHe+DtdPLmDfXa1caOgFqssAUPfA9UD/WBUKUNn0yTgjj25lK+734kZBExb+5CPxkzZuMJ/W8wA7ap85xDl/d7yGPdSSLSHBQlpqQZiupCpyZVbSrGSk9ncp4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SUUSZV0Y; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70d333d5890so6190297b3a.0
        for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2024 22:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722491514; x=1723096314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7gBLGL+mmGX6AVb3elsBnCFrc79BJCRR+zjbmuB2kqk=;
        b=SUUSZV0YI9lDg7q28pCzDSRb5R+5DhANp73imtBFTyeaDuj5oCbfOjG5TIfld4lOJJ
         TteZLaMn1SRNPBrBR6IfNjGaxiMebAWEFWvahvNnUHRFgIGqjKtO/VvJJP5/G2TWceE4
         Ew61HVXysIQIrqfNSGNxvQ3UMkhOswAvZpKHubDjSNHUaJR8Pg9sJnE9CjKg9/W+oy5U
         404aBPh7TP9j+3MoSuW/3sAFgTf9o/MdZRiT6En5uBv6OX7UXtkRASHRiJJEwbsTm9nq
         SZJNhZ+WFTKjuU6hzOsmcFK2smjnxbkqrFwhHUfK36pwv65bTI/Bd82ARtbdcCXU6qwT
         E7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722491514; x=1723096314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gBLGL+mmGX6AVb3elsBnCFrc79BJCRR+zjbmuB2kqk=;
        b=S0QAq59QK2J1ySQGMIhDOS0ltPKP2CFu2UCyajYiOKKIFLKD2bChlB/Oej0vEw9lrm
         8gnURjewB9EPGy381pmYSPUPZkzfhhj2V/bQozZbfdTjkjHSKiIs4xzdDjv4MgiKDdWs
         V0hyD9DfjgxyyCqUmS66LEaSmoy/yTHf2VOS9xuZRViN3Uoj2Tnfm4oAr8gFKLus0Qb8
         FuNgYi1dD9hup6DZHyvkGcHpeP4SLKSNBaxoguXUe3xXkxLDhxpk5GREFibiuwphEf03
         cBhuZSDEdhZceQYZL0kOKEhGsTbf8GUzbW/M/A2vbCpK5wSfBF2k6OljU+iYvm+jEi/O
         GHVA==
X-Forwarded-Encrypted: i=1; AJvYcCWcnpo/AIvXSAhLzUsC285qNYuf2YOHKPKzJHdl72FFgichXjSWpZTRrdzZfcmKnc7XGJKXD0pyR6na3CfxpInMwew1M1RaFEM=
X-Gm-Message-State: AOJu0Yz20FAvKgbhrEiVp5nHy4mxkJeKxHC7d7RbAaHWJkpXrp93c/Vd
	tsYCi8MCv0feW+MxBycWNJ8e5lsfaJoV7bo+jhUfaqtcpNUPi5W6yr5YpbuDBvM=
X-Google-Smtp-Source: AGHT+IHi3LdaOVqsILRzUG5RajCZhFYqsgwTEJCbU7Q/0owEgSj/B+R4O+r/bPYrYZw7jZacX4sQzQ==
X-Received: by 2002:a05:6a20:ac44:b0:1bd:feed:c031 with SMTP id adf61e73a8af0-1c68cf30d2dmr1821935637.28.1722491513712;
        Wed, 31 Jul 2024 22:51:53 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc4add69sm2325862a91.47.2024.07.31.22.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 22:51:52 -0700 (PDT)
Date: Thu, 1 Aug 2024 11:21:50 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Yangtao Li <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] cpufreq: Use of_property_present()
Message-ID: <20240801055150.ojas7q5w5jzhmeut@vireshk-i7>
References: <20240731191312.1710417-2-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731191312.1710417-2-robh@kernel.org>

On 31-07-24, 13:12, Rob Herring (Arm) wrote:
> Use of_property_present() to test for property presence rather than
> of_(find|get)_property(). This is part of a larger effort to remove
> callers of of_find_property() and similar functions. of_find_property()
> leaks the DT struct property and data pointers which is a problem for
> dynamically allocated nodes which may be freed.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  drivers/cpufreq/cpufreq-dt.c           | 11 +++--------
>  drivers/cpufreq/pmac64-cpufreq.c       |  2 +-
>  drivers/cpufreq/sti-cpufreq.c          |  2 +-
>  drivers/cpufreq/sun50i-cpufreq-nvmem.c |  2 +-
>  4 files changed, 6 insertions(+), 11 deletions(-)

Applied. Thanks.

-- 
viresh

