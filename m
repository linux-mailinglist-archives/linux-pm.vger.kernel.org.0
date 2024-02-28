Return-Path: <linux-pm+bounces-4486-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F81486A7BE
	for <lists+linux-pm@lfdr.de>; Wed, 28 Feb 2024 06:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 655551C2365F
	for <lists+linux-pm@lfdr.de>; Wed, 28 Feb 2024 05:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70AD20B24;
	Wed, 28 Feb 2024 05:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZM93a2D/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C111D685
	for <linux-pm@vger.kernel.org>; Wed, 28 Feb 2024 05:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709096828; cv=none; b=lM6tzAUHrxSyCazfwAuBuNEKPwRR2rD08tWe0uThRbPEM1nFSOGDSnrNZ1U096pQdcrsW5jDww0aPy2ZcMrgdmSTNKYQQipH4TbUzjAKrgxgtrNru6PY4dk78SVM2VqYgGUSmfIzjujs1AmEg0tlHsfH77HGDkujpCQgABwrx0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709096828; c=relaxed/simple;
	bh=NDYMj29qtQkbokr4QHvEZT1PzlIAohTJuF1hqdMFy6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/uReyP8FVvFW8niACpvGtpTHTB7nI5vHDla89H0Zg/AJVw6h56YZMji7G7Jj5hyYyrju1zD1/5nlV/MDAkqc0Wa7wOH90uDtyVylv8JDLOItJt4FB1CyJbnQedmmjLZVjFMkxiZpbxKKiIjhctKdUj7wo6KQAqgSaAOD+ALrCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZM93a2D/; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so2829440a12.0
        for <linux-pm@vger.kernel.org>; Tue, 27 Feb 2024 21:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709096826; x=1709701626; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R0hZi4IwldcafUQOYCQfscMvfB7SqlvXbZvfr+ma3bQ=;
        b=ZM93a2D/sBtqxcYD0tx2QmDp2LJOCQr3/zVp0/jrdPmRvGzo/2XDUGvUmt9SAL5tqq
         BPQreJ2/zRs2G6R2sBhAthyTt9JHCN4O0GAHTWQXtdNNueMUf0QfckiEhnrY5w1tWG72
         0rnFWt2HKHDCLGdEn++VVaq7Vgl2whjy2vEmKASi+hW/BW0/4xvYtmCL9ix4jhlJImq1
         4jVx6pIgMhiqMdAYG03zVMoPwvP7l56frQ7NnXeZgLQWrCkCI3zbSUq+B4EEF+hVfrYW
         H0Ge7pOpW6Nog0aNV5xa1C8qmbI223fGCoR5RAa2r57kRZR0lSH9OrVnXke8VSBMbDQ3
         cihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709096826; x=1709701626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0hZi4IwldcafUQOYCQfscMvfB7SqlvXbZvfr+ma3bQ=;
        b=hEdXCEW904d4RFOGz5IEEcRf+NnNleilxxHfa3wyNHJR3MtywcjutXZJ17/H5hG5TI
         zgte3wAEGR81+ph5ntKNVVwIw7Un4M2URuA78hhXMnvCopprSEg4aClKR9NIpzFQsVNx
         /chc3m3L9wt/CmQyA50KRIFUVwjJO2ASa9hs8MKeaJp2oHDJePhmowSQF9M92/OKlcN7
         kVPWG2cEfvZo8uD6B8gY9XPZskGZ4quXOl9ClGF4ip06kZgwfvZ8tpWQEYuHsLGW5ZkH
         aBf1k3P3zXPIPtAOruwm7zloTjbWvZdpu2wSQy6g2T+YNhBcgDg5BlxQPWnVumoyLuBP
         CLfw==
X-Forwarded-Encrypted: i=1; AJvYcCVwlbuyFP5rxYjKFzjhsplDv9Onqq7eKqpljP+iBRQ4F0NeaZUBfAOYleC7n5lL5dHnOVJ3/9fUgMcXPwL5xb1ye7Sgd2Kmqa8=
X-Gm-Message-State: AOJu0YyE3MVGDLXLhLqTK55eLndx93Ip+Z/5PxHc4JJPeh7scQSwOxV9
	GW15iY7nw/5+b2kyolVm9ygbJjag1FCPBHGG/cPVHxmSBjVr7idLxki2/eAMIaU=
X-Google-Smtp-Source: AGHT+IEXutCfwWDafJj/H7lNFlXr51oQWF+rHXoJlF9WsTiohURTpGuvZH0dIKe1xDg4l5M6JS8/0Q==
X-Received: by 2002:a17:90a:bd16:b0:299:275d:c346 with SMTP id y22-20020a17090abd1600b00299275dc346mr9882375pjr.5.1709096826514;
        Tue, 27 Feb 2024 21:07:06 -0800 (PST)
Received: from localhost ([122.172.83.95])
        by smtp.gmail.com with ESMTPSA id sk6-20020a17090b2dc600b0029abe1c3f26sm511598pjb.1.2024.02.27.21.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 21:07:06 -0800 (PST)
Date: Wed, 28 Feb 2024 10:37:03 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: dietmar.eggemann@arm.com, marcan@marcan.st, sven@svenpeter.dev,
	alyssa@rosenzweig.io, rafael@kernel.org, xuwei5@hisilicon.com,
	zhanjie9@hisilicon.com, sudeep.holla@arm.com,
	cristian.marussi@arm.com, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, quic_rgottimu@quicinc.com,
	linux-arm-kernel@lists.infradead.org, asahi@lists.linux.dev,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix per-policy boost behavior
Message-ID: <20240228050703.lixqywrtxravegc6@vireshk-i7>
References: <20240227165309.620422-1-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227165309.620422-1-quic_sibis@quicinc.com>

On 27-02-24, 22:23, Sibi Sankar wrote:
> Fix per-policy boost behavior by incorporating per-policy boost flag
> in the policy->max calculation and setting the correct per-policy
> boost_enabled value on devices that use cpufreq_enable_boost_support().

I don't see the problem explained anywhere and the patches look
incorrect too. The drivers aren't supposed to update the
policy->boose_enabled value.

-- 
viresh

