Return-Path: <linux-pm+bounces-20904-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F8EA1AF14
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 04:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2785E3ABDD6
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 03:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2127A1D5AA5;
	Fri, 24 Jan 2025 03:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OB8IxTSx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A872AD0C
	for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2025 03:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737689618; cv=none; b=iEbNAcKR49cDMcI1lS4Cb6lOwD8oNFmsFeRXKpUmwgF5iTk6piilkyV7YQ1wsrrkwkwH1bC3MZ9vxR34jhE5eoLzHn4gH/JiT39Fafa9vydAmVKb0bqUmgzF9WinU3GeQ4WWD+VzFoamW3EoIIvhzqKNrnlIRvmRcWotrWoCY70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737689618; c=relaxed/simple;
	bh=+51lltEf2AxmxrjiF00PFuVvKvg9zwKNSVTVieNHGDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VIUP/f8yKw42Gk0UmCyCmi2dsLCzYcrSqEYy2uhYkZPqpC36D0DnlbI58uW7ri5WE89VtpQJm//R6HygR8N9jN9opplLQvTkLqF6W0dFDA0JqHKccOyrUGWAXQvWF/vZvS93aPv4wgsdY5mFbRp9RE9ZN83mEVh9lBofPG7Cc6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OB8IxTSx; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ef714374c0so2721721a91.0
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 19:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737689616; x=1738294416; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k7vWCF2quBGdrEvOfcwrCJ1ka96RD0NxHHiEml1rsAo=;
        b=OB8IxTSxhSvX7z5OoXleO2lxT2MEAND+mJBBqzV6acWPSBu3MKTVvfMuwgTyEU46JM
         lUliPoX/955oHhvXexd2Kud9+uzsZSHx8yxBzAfu3Ylr1x6qjXMN+yEGaa72qzdZNcHm
         uS4VjydH3xjZjr2M+GbnlIugnYreiW53zh+Dn60mWGb7NGkwkx9dtlBfeXElXJaEbwfr
         pQosxw6RSyef5X6YNoakuqGD4JyACFhIjMtY8urOAa0de6yJSpZrGbPx4AMOWxahMN6O
         wV9PpFmJnv2oTCKU7TUj+OUqrckVD7zME8zV7dBdeiDmkyYv0BcbNkgG0+7eFFt2xGTH
         P3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737689616; x=1738294416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7vWCF2quBGdrEvOfcwrCJ1ka96RD0NxHHiEml1rsAo=;
        b=qRezzG/WGPNDO5XgR38KGOGoPIzIlSGA4IdkKoheAYUcYvmAIarliR3Uzne5YZPb5l
         74HJKw99vkkQoB3/T9vPNBzfO5erCX9lI4WSAjZeJ+OisA2si6E3hldGrMmV/aCFHObN
         cQeH6/lIApkHa050votyEB+3YorL0JXcFWbhkN/tjd4rFoHC3y+TiCLFj1b+4oSXtVck
         YWYak8SIbogfOF9OeRdsAC2UIFIQbt4hgZ5pjAJYXHe4JZMhACBC3DAxw88NIGZg8OqB
         cU1Iu5PfT9293suD7xUN/0txXljG7ZymroAmbpJ8d+WEaPc8P/O1OatZJobLprCUNl2g
         bvfA==
X-Forwarded-Encrypted: i=1; AJvYcCVfADuxy0CRw569BywzOvKYm0h/KdafyJhiC9xLxMr4tvC1Xj/nWggMh6LN2Bn0lOKbErjrV5WBeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHkZOC2u+9bLLjJsQfcPqefs1Fb3JHk97gQ/0kbzy6RshvE3t8
	Ncwi2afcFyxXmb85Kc3fcIbrz37JH/yvbyZewghV2KIZNN+N3LFHbngUch6tEWw=
X-Gm-Gg: ASbGncuPkaebxigMhrndnUZBUpjxqS5jswGL48wIP3QdSvLBXim/dkw23uo3pLBgYF8
	8azuttdOCw71cOHFrzBxiWhRNyDZiMvo//pNRnKaxHww5qKAOCOg18tRmuugEpeMAhsMlperd+c
	CNF1qFaybD0fU57k2AVnR3AUjcENmKAMX2oEHtmtAfFqizInWvDITQViKNJWHWykcCjquA2m+iV
	pHPEe6GDJAIjWZziFtSJJQnXW3X/1G4Gsnyc+zxYm/QrjhlrPXk9VKqDXR2tiCwcvCw1voUIBaG
	J6xyQmhJqRguiValvA==
X-Google-Smtp-Source: AGHT+IEu471jFc6XUwYmJu7IFl72PwG7UAxtkv+mCyC3gGiPN1kcxEs1Hi626diqb40sAHktXiT8Kw==
X-Received: by 2002:a17:90b:2542:b0:2ee:5a82:433a with SMTP id 98e67ed59e1d1-2f7f1799756mr9182783a91.17.1737689615710;
        Thu, 23 Jan 2025 19:33:35 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ff959309sm542317a91.0.2025.01.23.19.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 19:33:35 -0800 (PST)
Date: Fri, 24 Jan 2025 09:03:33 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Beata Michalska <beata.michalska@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
	sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com,
	rafael@kernel.org, sumitg@nvidia.com, yang@os.amperecomputing.com,
	vanshikonda@os.amperecomputing.com, lihuisong@huawei.com,
	zhanjie9@hisilicon.com
Subject: Re: [PATCH v9 1/5] cpufreq: Allow arch_freq_get_on_cpu to return an
 error
Message-ID: <20250124033333.jrqbhuyd6qtogn2c@vireshk-i7>
References: <20250121084435.2839280-1-beata.michalska@arm.com>
 <20250121084435.2839280-2-beata.michalska@arm.com>
 <20250121104706.2gcegucb6hcuksrd@vireshk-i7>
 <Z4-52JUmR7A-7NJP@arm.com>
 <20250122061250.kxdpkkvce4g5nar2@vireshk-i7>
 <Z5K4aDaZIbhRCbOP@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5K4aDaZIbhRCbOP@arm.com>

On 23-01-25, 22:45, Beata Michalska wrote:
> That would mean we are opting for presenting '0' value (whatever that means)
> instead of trying alternative ways of getting 'current' frequency ?
> This is still the scaling_cur_freq.

A return value of 0 should typically mean something went wrong
somewhere and didn't return the right value to us.

- For the print message, I think we should just print the value
  instead of UNKNOWN. Let the user / developer decide what to do with
  it.

- As for trying other mechanism to find the frequency now, maybe you
  are right and looking for an alternate way is the right way to go.
  And that would be consistent with existing behavior too.

-- 
viresh

