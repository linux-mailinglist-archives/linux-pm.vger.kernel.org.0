Return-Path: <linux-pm+bounces-9796-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B022E913061
	for <lists+linux-pm@lfdr.de>; Sat, 22 Jun 2024 00:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 636B128856B
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 22:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C89316D4D8;
	Fri, 21 Jun 2024 22:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmvzLRj/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47A8208C4;
	Fri, 21 Jun 2024 22:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719009534; cv=none; b=cOiuszUrZXGV9nJvLiHsFqKJhZxK3MpzZNd5FKM6e/BH5moiD2jEmulLUYr4N8ivqlSVpsivKFTquLG8M7tkttWntlrG0Hhum/hVECYE7sQAgNtuaoCHGFSHEJiqe9U3nvV/rWPdegGCRSU3ubY+NOuKsFtgDWvcG+3P+Q5GOp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719009534; c=relaxed/simple;
	bh=iuxCD6SXr+LIzZGYfpPXvUJ7nV8ibWRlt4gRpZUawzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHfjgB8Z/Zg40Sw4WhyDuRrxu7e0UD9PICjFtOTlru5rgklE8v8D9ZosNHNU2PeX0xP9NBD8f2g4YI/c5rUdrfSIrw9oatqLFo2IbsuksKRcL9lIoVXsMPyQEozyIFQ5miNU38EnvoEsOb80XJjYCdkf9LthikfsziEIQX6wqqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gmvzLRj/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f480624d10so20811365ad.1;
        Fri, 21 Jun 2024 15:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719009532; x=1719614332; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=abeU2GGQMEFPwQcngO4m8ohAO9d8OVamW3SQd0gTR/I=;
        b=gmvzLRj/qyZ3wsu6eoWkxRC1bulv/8w4Xrb6cV0k10hxaw5qgRwlFU1nUdrkKcK117
         fNJSCWfWoFeQlRuv6D7xdxtb82V7545MMzQmkiQPpxsadywlajkYL6dOkYQqyVDikyrm
         6TlGe3hEr7CLIrTRWv0fnMMqxhyQYZma90KGr1005nQPsaJdLBzLlA0TkW2m/U4ftgdE
         ahWYUvS1jhQa7Ujnbt5XUkwBnZImMEwMbxdNCEKX1hfiEfwVm4W//itkp6AQvepLzuZT
         IKCDkzY3ORkHKOI8dI+wQYxtBJLMUPjqZAv8coExrN2/xDzQ2oE47ZCwsB512PoWCdK2
         ukGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719009532; x=1719614332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abeU2GGQMEFPwQcngO4m8ohAO9d8OVamW3SQd0gTR/I=;
        b=jnPAhEEDvfmOTq3Oj44IgwcoivF7hups3xMjZxSb5H2+tiRzehQsrq8ZldHykD1+F4
         Tv4C/K0wnTHrY3gHD/kf5FvIzSRB7ai2gaiTWwS6mxAQF2SSoDF5NeWot5jyHUOGB7GH
         thiTym9Zw3IpPqaTXZ02ekMLnBsnrXJmmP/lEXKK8X+G9RV2s0OuoiicIyVg5U6Qz5oF
         ePr3ln6bJM0j06eE3FMLMRqdlQso77T5YlHOSA+UFEzR7yDoCefDwlScpKe+YC57iYMq
         DBEX3ryzutSoXDATfc0mFHCD/O6VbMGnlJk7wOnpkWZZaBk2UhryeILm2Y2JsRA8O9/Z
         UP7A==
X-Forwarded-Encrypted: i=1; AJvYcCWUr2xbh2m89S4T15rL2VGefQxLMBLkXWLOylOWLN5Vr8UWs40xIllMzQ7aTRj7tbs9ZnLQ46YDkiXTa8BNxaAHzgfYVzb2tkupcdNJ
X-Gm-Message-State: AOJu0YwCoVZiDL6yQyzdyx9/RmbkR8xMLAcZYX4ewoa4kcWZhkfE9Q1f
	R+hWhVaLqos9G8WX+mLXwVu9o2ZH534QSD43XBiwHtRRT9ehEjjx
X-Google-Smtp-Source: AGHT+IHpSEg3XHl2cj+523T94EXl++q2aLaanr1Vrm1C8htxO3NPr4o3CPXRYbhssuHnegqyRjXmhg==
X-Received: by 2002:a17:903:22ce:b0:1f9:fca9:7433 with SMTP id d9443c01a7336-1f9fca976efmr18690715ad.34.1719009531795;
        Fri, 21 Jun 2024 15:38:51 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb2f2a4bsm19255645ad.57.2024.06.21.15.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 15:38:51 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 21 Jun 2024 12:38:50 -1000
From: Tejun Heo <tj@kernel.org>
To: rafael@kernel.org, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, void@manifault.com,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	mingo@redhat.com, peterz@infradead.org,
	David Vernet <dvernet@meta.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 1/2] cpufreq_schedutil: Refactor sugov_cpu_is_busy()
Message-ID: <ZnYA-hrec6cVADtJ@slm.duckdns.org>
References: <20240619031250.2936087-1-tj@kernel.org>
 <20240619031250.2936087-2-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619031250.2936087-2-tj@kernel.org>

On Tue, Jun 18, 2024 at 05:12:02PM -1000, Tejun Heo wrote:
> sugov_cpu_is_busy() is used to avoid decreasing performance level while the
> CPU is busy and called by sugov_update_single_freq() and
> sugov_update_single_perf(). Both callers repeat the same pattern to first
> test for uclamp and then the business. Let's refactor so that the tests
> aren't repeated.
> 
> The new helper is named sugov_hold_freq() and tests both the uclamp
> exception and CPU business. No functional changes. This will make adding
> more exception conditions easier.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reviewed-by: David Vernet <dvernet@meta.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>

Applied to sched_ext/for-6.11.

Thanks.

-- 
tejun

