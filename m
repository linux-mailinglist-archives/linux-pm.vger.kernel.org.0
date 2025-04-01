Return-Path: <linux-pm+bounces-24689-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4945A776DB
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 10:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C93043A8B6A
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 08:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069DF1EB1AF;
	Tue,  1 Apr 2025 08:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LOap55V3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6824E1E378C
	for <linux-pm@vger.kernel.org>; Tue,  1 Apr 2025 08:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743497323; cv=none; b=ovAuKng4ZWjPK2ZkcBo5WG2l9TxBw4ZDSFiDSu205oEk5XKvf8cxxNLVPYcLxs73YhRp05oKiMGEinkiR973RolnhlBuCibyJ/BJahUqOvTInzqkp5S4RvOSRWrEhnzyTnsuxVcB8hCWDjz9V7N6nndB5kOdUoKSmuWRC3raN04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743497323; c=relaxed/simple;
	bh=08FBqjkfx80Xs7oU45TJaQnC32mDcslSUZJgPJvQo2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YL1YZbvJNk8YNQErJOtnXe6pCIZua3LYJFrDUm1mV1/vDxqzUKZCnfDtdEYuUYMseHuqH0S3wqf6vPHGAIKPloSmrdfRG5NQLxR8VQUmM7ehgj3G7RIyB9WLo41VEvX7I5biDNgfSRc3hcjvszjNAgFaZRg9h2IuJIvtl/6HdMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LOap55V3; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22409077c06so143340445ad.1
        for <linux-pm@vger.kernel.org>; Tue, 01 Apr 2025 01:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743497322; x=1744102122; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yt1Nb3A/KQmEAHpUtsnXqXFTpyRKk6b4Ck8YXLkwgWk=;
        b=LOap55V3kEs+GbFB7qD30+dCHi9mG9xZaOW4BJsTVABlxGP+pdEl3q50JAWTlf/tl4
         4ypViX+5NZG9538s5mk7UmXNixaLOMQXLcJHwEHz3jf9jmK2z/1yfIWVAiP2vPLKStRc
         oEXWwSHdCDriLzc8UIpFrTUIE/8UkUlftFSebh7rppMX1tM04YL93ElW0Wufi6RrWjSg
         UYRpHDR5PUB9tCGK/lrsSCRjVw/ArnkB7kskbPRNMeSwmss8J51nh3hfe3jFJgiPJGoH
         oUtcFsYnaEUWOIBavQ3LuEzGYdn7iujcPGOqlC5Izns49jgYlHfefUH+p39m/wv9KckE
         cURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743497322; x=1744102122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yt1Nb3A/KQmEAHpUtsnXqXFTpyRKk6b4Ck8YXLkwgWk=;
        b=UCz1qrTXBTVk6fIaNFiATcPx250oZLXRsdGdovWlZkz2WrwmAUcSC0RzDBF2FfjnjP
         9W/EzYJD59fWbD3J32MQfSGQf2oBqjdM3yc/mVLKvxd5vE0D8rrsdVpO1FAldfRQcda9
         O9krBREZPUXS9gLtr5S/2veZ2YzlxG4sAOeSvt/8kkzRL2dzl3HguF2AWiUWcxMRmGXl
         mZq300Nan5irCQ6CgWx4zJnOgNdKkjwI/wSK7T+3v2h9NXYPnSdDd2q30C+wSurGn0rV
         qQbBJjUyVeFv1bSDg07P0UCExpLimwqOcNH/xbGQnNnRq2+So2tVPFDYPmXk/0qMFbGY
         092A==
X-Gm-Message-State: AOJu0YyRhV71Sufz2iFeI9bvG5Yf1CZ4N1QjsVa2TMLvmJ+6hS+H0cj6
	Z0p/Lp//gVfF5HICIe7uCls182tN9lYVmX4KrLmftUqU2ImOr0JbZYLVHuZGGdE=
X-Gm-Gg: ASbGncuX3x7XC1hHh9/wVRTNRyrU7D2Q/mr8aqD6f5QkO+o1gYt/3K9vlgF7vrdwXNO
	dHeSm2Ployt/Rq4omgFru+0wnAc07L7dzW0/KR8XCWbAU3ygAX5w90rWhR5i2BjfhU/MEcM4Dpb
	GmbdgE7cnPd2a+9TqLvNdhG/f0EYbcICGQ42wkkk1EL0fxwNl1PSVALn72Fqc1AxfP0tZTfBjrI
	/511F2EmBDcHvC/YQs+CtVk6y4VqkcuY0rlNv8i32E4/MB9A1IooFc+Kb4Bmgluik6nQQI6/WAk
	pYCA4htu8MEqbRj31bGVWzy0LetC6aDxPs2ZfuvnJtYmbA==
X-Google-Smtp-Source: AGHT+IFL1sDm5En/LlSUmAMxBf5diaA51dnuNOwJd7pAb4DGV1ifvlM2YmefBPSpaQm0iOm9Y4TBaA==
X-Received: by 2002:a17:902:e883:b0:224:fa0:36da with SMTP id d9443c01a7336-2292f96200bmr123211785ad.18.1743497321681;
        Tue, 01 Apr 2025 01:48:41 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1cf688sm82999155ad.121.2025.04.01.01.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 01:48:41 -0700 (PDT)
Date: Tue, 1 Apr 2025 14:18:39 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v1 08/10] cpufreq: Use __free() for policy reference
 counting cleanup
Message-ID: <20250401084839.24udjvxxvvg3mim5@vireshk-i7>
References: <4651448.LvFx2qVVIh@rjwysocki.net>
 <9437968.CDJkKcVGEf@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9437968.CDJkKcVGEf@rjwysocki.net>

On 28-03-25, 21:46, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Use __free() for policy reference counting cleanup where applicable in
> the cpufreq core.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |   57 ++++++++++++++++++++--------------------------
>  1 file changed, 25 insertions(+), 32 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

