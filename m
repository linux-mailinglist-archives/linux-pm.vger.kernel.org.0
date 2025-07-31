Return-Path: <linux-pm+bounces-31687-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B81B17036
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 13:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 692F11C210B6
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 11:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42D52BEC22;
	Thu, 31 Jul 2025 11:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B9DJpayy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424DA2BE7B5
	for <linux-pm@vger.kernel.org>; Thu, 31 Jul 2025 11:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753960409; cv=none; b=N6ub7eHE2oEr6F+fZhA7IKExwERnABjN0nkc+aYP5bKPZdJ1fLBfADuSDuc+cF+BgC5j2kLDE5TGFdlkoqkAuBFvWtWK1iMkm2tLCXp5NNrG5hG4sR40/qSG/QEwIhU9Kg668jH4GiGsUQpZFEJHvNTRD/xJSk1h7vOyrxWB3f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753960409; c=relaxed/simple;
	bh=FQNz8BbRyNj9k7+vEvxIOIEQmZNi7wQP+y5ML6xjJaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hq747E8nrHoAKgfHYB4r6q13xJSbuJoK8lFXpBqc2wyWW+FupyJ6FQfEVzKvY3lJyfxteH422/528RCQ2AzUuuv3uZDOEZU5Xx00R+off2WVf5lZ+Ux4WoYTt6Zj7f9aD4AuIsd3GXHfhds3P7qZAqAQkAtUtNEpZ8eFA3xXF5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B9DJpayy; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-768bd0c7b10so1107489b3a.0
        for <linux-pm@vger.kernel.org>; Thu, 31 Jul 2025 04:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753960407; x=1754565207; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xcgVBfzRHIi2KK9PJug9FDKd4UOHnTMFQ2IwpTBL6/A=;
        b=B9DJpayyy+Wxaxn0nYSfqaLywaAPAUJFXYN9gqbfVSKtlBhn1XP/RDTiSJmDoZ8xXD
         kJyhTX4yOZfO6HezEXelQkWFHbYDkuxfdVWJV4ukM92hbFwg4Ky5JpMFmmXUAb/LNpFN
         6tak17vCQ5ePOoNxmpcNedHllMViA5aPt4aVcdZRGyvDyp7x5Gk0CCcbnImPEhnLzNQ9
         ekpWgVOMwLRnIU3DH8NpY22TYbPA/oXHydkXPVVnckKgtgAlCyvMGIM1BOdS0TSmvD52
         ETH4Ng46WUKYE6dlZuN0t/OaUBo7JtVB3tKrWPwRfUE/gCuiMafW6JMLniQjDe6ZhgtR
         Zm+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753960407; x=1754565207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcgVBfzRHIi2KK9PJug9FDKd4UOHnTMFQ2IwpTBL6/A=;
        b=ctNGm6JHG2Ee2+ew/BRvTMm2YVCzwE73WPm6FoO5NrzYb5bow4aqHRS0mi2snz/qDi
         0MnI0JvRpM8loxTr87Mlw9sqUtbV89XyCGzeGNvYw9ne/v0Yps9QoEB81w59Cnf7wLbk
         AjawA5HHAvc50GOkosEyIILyH1qr99Qd1Xj8PggdGJh/QzeZJ4eo2Q3zE2eDypTCGpkz
         nwQGO+BQF2TCu47+SiGa+orkOGblBmHBxL0J7hHVUC4SJ3whaYLkGkkvJII9jMMN+amR
         hghYkU9UVYZlUtbofGUA1HiDbKA1eFgrFBuYc4gd0VxwYH4XD0Izvy5qSCHeqXewUQqP
         32ag==
X-Forwarded-Encrypted: i=1; AJvYcCUrWHlCODsQ1OMGtU4ZlYZghQTvJSHLpinPAD3wVBHdW3pgKxzN+IIWxwsPAFLTYRmkl5m4EAw+ng==@vger.kernel.org
X-Gm-Message-State: AOJu0YyA3qtF+aafB+OSmT2QHNdcO9Xl26ZHfFc6Jsc480lPjShNHd7z
	40Er7ru3QyhD0tMG1ssxrhg4c3150x1zqUZaW+qKRq84gYbe55xDmktr9ZTvjiSaxbI=
X-Gm-Gg: ASbGncv5v/ttt0Z9VKTpmoTmY8Ge+bhfdJScMXRt/VtaGPspgdjRQKLQn3zIrFJj0rG
	m9AM9dOGBeDNw/VP+AEVZJ+ha66p8VheGvxZn370M9cEb/G0xzI/IKh187AATb4xPTGxlJRKgkj
	CpfSWR4+LoLNm5vkrh51FHjWHXzU3vpa+Dx9mVScrnR0nyEyLVNHjEugVM9O7Dx2DSiab9sTH2S
	El4svm26GatFfPeHRO44b8CgEw3/N4VUPHmxhiCZXcL/9wWFFx3M8wXcIDz3l4o3T+P8LAOmE3y
	x4u96tYCVwQmxezHTuVTyVxhNqbNUKu/vCwek7iT1GHOFt+0zB0Df5zg/MB2Rj6OBtarN8v2BrW
	KPCYFfYzGChE2kDqsTz5WSu0=
X-Google-Smtp-Source: AGHT+IFpB+Tct+sMn29BFyf/nBuNb0BDj/u4aJoMRoHvhpjU6QtQv2A9e6t89MMC3L09AatFyXUoJQ==
X-Received: by 2002:a17:903:41cd:b0:240:8381:45b9 with SMTP id d9443c01a7336-24200a7e767mr26387805ad.8.1753960407543;
        Thu, 31 Jul 2025 04:13:27 -0700 (PDT)
Received: from localhost ([122.172.85.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e89769absm15521205ad.80.2025.07.31.04.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 04:13:26 -0700 (PDT)
Date: Thu, 31 Jul 2025 16:43:24 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Beata Michalska <beata.michalska@arm.com>
Cc: Prashant Malani <pmalani@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Jie Zhan <zhanjie9@hisilicon.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	z00813676 <zhenglifeng1@huawei.com>, sudeep.holla@arm.com
Subject: Re: [PATCH v2 2/2] cpufreq: CPPC: Dont read counters for idle CPUs
Message-ID: <20250731111324.vv6vsh35enk3gg4h@vireshk-i7>
References: <CAFivqmJL90xsELhz4tPtkYA9vMzS9C=V__nwo=kWJKjKS=mE_Q@mail.gmail.com>
 <CAFivqmKBgYVa6JUh82TS2pO915PUDYZMH+k-5=-0u1-K9-gMMw@mail.gmail.com>
 <aHTOSyhwIAaW_1m1@arm.com>
 <CAFivqmJ912sEdSih_DFkiWRm478XUJhNDe=s2M_UO2gVTu4e3w@mail.gmail.com>
 <CAJZ5v0irG16e2cM_tX_UeEJVmB_EdUvk-4Nv36dXoUS=Ud3U5A@mail.gmail.com>
 <CAFivqmLoDv_pWdmBG8ws-CMUBXcb9bS1TgMaxW9YZMqqHpRSyA@mail.gmail.com>
 <20250722032727.zmdwj6ztitkmr4pf@vireshk-i7>
 <CAFivqmLG0LriipbmM8qXZMKRRpH3_D02dNipnzj2aWRf9mSdCA@mail.gmail.com>
 <CAFivqmJ4nf_WnCZTNGke+9taaiJ9tZLvLL4Mx_B7uR-1DR_ajA@mail.gmail.com>
 <aIso4kLtChiQkBjH@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIso4kLtChiQkBjH@arm.com>

On 31-07-25, 10:27, Beata Michalska wrote:
> I am still wondering whether cpufreq core is not a better suited place for
> checking whether the CPU is idle. We could potentially try on anther CPU within
> the policy and if there is none, just provide the last known freq ?
> 
> @Viresh: What are your thoughts on that ?

For other platforms (that' don't have counters to read), I think a call to
->get() to get the currently configured frequency is perfectly fine. Isn't it ?

-- 
viresh

