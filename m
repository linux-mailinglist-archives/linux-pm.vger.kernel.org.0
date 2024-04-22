Return-Path: <linux-pm+bounces-6749-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C788AC308
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 05:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 429BE2815AF
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 03:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3F1DF53;
	Mon, 22 Apr 2024 03:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XJUIAlh9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86B62579
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 03:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713756731; cv=none; b=TKaRWb1/6C0jVNDVjUbLNO2QMZt/wVU369VTgpbMRTsLba0PeXZCVxViNCI6yCr+X15wcBdnXX2g2gX4PWQBZtkYyQ5eaQKIDDAY+GFbR1B27qwUgHi/Nmyt28UU02W0sPMwkbMsXVAZ4dqRSnZccWHXe83FwEb79jLcA/BZId8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713756731; c=relaxed/simple;
	bh=RusiIAulFcEtDtxzFZ+lmKKT6v1DO/M06FRDfurWsSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxVwtMiGfkWYk/xmxhGTueLHaYkG2JLs42qqD6OUf/JqseqmhCVDVyw7OHLjBMZSFPNUsMn5tf04HjhT93y56XrbbFAbM2ES6VFmNUMRH9jNmm/aQlUfWpbBSEayF0fofypglEYce53F3ZsenYGZqwUzgdzbrf47ieKfjKXKB/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XJUIAlh9; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ed04c91c46so3852828b3a.0
        for <linux-pm@vger.kernel.org>; Sun, 21 Apr 2024 20:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713756729; x=1714361529; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ayQSqFKLgMTG3/4LHwIFhlRf2H80k4xhFX/GtydfIr8=;
        b=XJUIAlh9jhXQgtbLnbzgXS+QhCUDw1lAyrL+K8L5346CgFi8bb3bdr62QpU9VP/gMj
         JX+gc/bAo3Khc5BV7CtZqEF0OL5qbbLQtO9rHF0VOPfdwOxR5etQPS6vuGjemJhjRlHw
         olSqLrDEa8X8ShvHYFKVABiNKZRqmWdaZlHfGMnnAhbJFfAh/20hfxlVGSChp/u/y5c2
         SslSVMSFhmoulDXMYIisLDvpjDasv4HURTUd3QzZBoD8jzDabMKu7LSX3LViS6eZsCqo
         uMtEZ5GNJV8yebZfEVAnVOMPt/5CrBm51zB3bNflAV3EIJnRNAcah/Fwc87oyUpPkzvC
         j2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713756729; x=1714361529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayQSqFKLgMTG3/4LHwIFhlRf2H80k4xhFX/GtydfIr8=;
        b=F2ItC1Y5egDKhR1INpHJwSlG2RgqIzoMNd/CtZZhmPCkrWjAI6KfVIKp+R7xd0y5/L
         Tl6f5KWJAT9m3XC94dj4TyiF8h533U+dwHfCSA3oK4NSVGyW8hG6XCz8f6myWCXFjMxb
         E998lxJkx3xv512Zxu6AY4cyZkdZqeMkJEKQ8JZckO0GCnhg8CuknhyOV+/98CeHk9yD
         +qqnBztkEXHXjiu2FQQv7nfsmYqqj9QkoPeJjkTeJjFvO6GYP+l+VqwRN7GoldnV6Bju
         7RQFzI/+aIA8fcMllwioflGV406mBQUKHHs2SfYmcUBOh0NYzAdoFRShQtYaYaC6ga+t
         z/iQ==
X-Forwarded-Encrypted: i=1; AJvYcCVX72Zlfuntu5TtYuz5NOsVKh6yn/rTOULtZkEB8o3lz0mNCta+aXwLt1U6BQ9yaaVirvbXucJ+EpOSVDZUUlOCCB/roA7Dyak=
X-Gm-Message-State: AOJu0YxmtFoyfTIchQFCxKs/JP+LQQm7kJe1DOd4Tl5PCKSMnnb46mT7
	n2AAtjGFyFl4eSvJiB7MF9qDClz0FQTuopTZDCDLW+iruk/TvngoiP3DtzOG3Ho=
X-Google-Smtp-Source: AGHT+IEsPl/aJM3asyJHoY/vAmluEaqy5/to36FYHyzgaZF7710nQQ8lhCmFTSytnV3Mxigh5Nq7Bg==
X-Received: by 2002:a05:6a00:21cb:b0:6f0:28a4:a6ac with SMTP id t11-20020a056a0021cb00b006f028a4a6acmr11796453pfj.8.1713756728764;
        Sun, 21 Apr 2024 20:32:08 -0700 (PDT)
Received: from localhost ([122.172.87.52])
        by smtp.gmail.com with ESMTPSA id m191-20020a633fc8000000b005f751c18d0esm6624198pga.86.2024.04.21.20.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 20:32:08 -0700 (PDT)
Date: Mon, 22 Apr 2024 09:02:06 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: kernel test robot <lkp@intel.com>,
	Brandon Cheo Fusi <fusibrandon13@gmail.com>,
	oe-kbuild-all@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>, linux-pm@vger.kernel.org
Subject: Re: [vireshk-pm:cpufreq/arm/linux-next 6/10]
 drivers/cpufreq/sun50i-cpufreq-nvmem.c:128:44: warning: '%d' directive
 output may be truncated writing between 1 and 10 bytes into a region of size
 2
Message-ID: <20240422033206.3bsqlx3pt5xuc4uy@vireshk-i7>
References: <202404191715.LDwMm2gP-lkp@intel.com>
 <20240419111345.028ad7ec@donnerap.manchester.arm.com>
 <20240419105628.faaqz2p4qdlfxyre@vireshk-i7>
 <20240419125630.7951b45c@donnerap.manchester.arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419125630.7951b45c@donnerap.manchester.arm.com>

On 19-04-24, 12:56, Andre Przywara wrote:
> Ah, yes, thanks, that looks good to me, and indeed fixes the warning.
> 
> How are we going to handle this? Do you gonna squash this into the
> respective patch?

This was an existing issue I think and wasn't introduced with your
patches. And so I have applied a separate patch now.

-- 
viresh

