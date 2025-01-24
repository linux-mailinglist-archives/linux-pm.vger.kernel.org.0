Return-Path: <linux-pm+bounces-20902-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C5EA1AF02
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 04:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FC6C3A851A
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 03:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33911D63DE;
	Fri, 24 Jan 2025 03:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KBXt9lEE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0FC1EA65
	for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2025 03:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737689110; cv=none; b=deWeZzukoa9FSwKRbvTLmYpgzTgfzDR3G2h23zp79qm6+JzRRCXFUwyrhi+u5dMqDu7nIb7F6YOYeJU6oXVFfYnvacrZtKDkyP/qQwsCPT9CDpzku6jFXm6LiIZeDee57o40Mbo7h41ttobqVMLT6sY5V3tUwfWi9ZcQZSakbUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737689110; c=relaxed/simple;
	bh=7/SOS7HoIFwX/6lhvUTSOww4LUw/RnVOhKBKWv0uOzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQuVNco102vOayReGlFHiXA9Ha/hDF0cPXRd76iQe49ayS0CCAj5LoGsiYm5IDB0YazN21en4MJCHNvY0Z8Oixhekg3kc8SdZ9byVxTPMX+kt0dLDG4szxJYvwkPu0bIBghzzdVdcj97rvvQFxgtB80QmGQ5pLuNwm9ve5vbxI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KBXt9lEE; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2f43da61ba9so2395155a91.2
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 19:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737689108; x=1738293908; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NZVGarXm8F3wmNaZlX6Uo9ZJAp39A7Hk9H8iGkJJROc=;
        b=KBXt9lEEDX1qM8TX+VH7jnl1qiF5d5ftEFbBOO2MoM7T592VsTequ9zGqnq0xQTLGJ
         xvg/8JFa/J7E06fA1V8+e6nSp2EhHjKM5cp6LCTOPr/SjjVHP15KhiELb8ECkbDw1dPo
         l12Kp4PDK1N1RzUBgvqA2MGAb7isBUmmIfcVx2IVwdtxuE35KgcFyADSIZ3wqKGpAS3a
         zbx2asG8NMgTQAbYa68mkfytpSJN9wrKUEn1h+qO0NGUM9zKXUjCOmAN/VywPVAmmyxp
         RTJDLuDos9gRmKnnlJI24lldPsjZodLHLbl2GegO12z9qzUI2AGCvJD7inX1bUK5tJ7D
         /zMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737689108; x=1738293908;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NZVGarXm8F3wmNaZlX6Uo9ZJAp39A7Hk9H8iGkJJROc=;
        b=lk4h5/OSAq/7yUR4pkqZ1yhjJC4Vbl12r4qiMhjrz4nchhtyUGLMhVA/qHFxR4foXR
         ouc1tK8YT97AVVJCJnh9uzNXxxCmYIvrZAd6RQXtFQ6CSqdEFrCeaVN34xRfb/kdZdI8
         GdMXqk+W/cPYIinc0WtfX1OhxsOMPUvnzWYTGYv+JDm03H3jbIPObmokOVDII7ySgO2V
         G0wSeRsbhhHB4Eq7y8xBj89BJ7IlebEKZc3e2IF4zBL9LuS83rkUm22wuLfsWlkkvgJ9
         zXrIBY2n0x8gzWfm8HGf/yi4x70zgmUO1piYyEPR5qcgGBMiOB0bruyYHpKhr/El0cNl
         1edA==
X-Forwarded-Encrypted: i=1; AJvYcCWsKXlmTpO/FHB9JQfYzLOym49dLvnKlYLADZgyzzWDEGKdOspi44FdFx+oW3+kMsKFoZWqv9sWbg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwROmobyj0Tcliqt2Ne4KnxuM2jFLWdLJyW/TrjhRHsvMwm8R+e
	IwywFUPFlV1miQyzJZNQDK2t+p4PRMlvpXaQBsqbzoLTv9Z3Gy23h6EhtErK3/U=
X-Gm-Gg: ASbGncvJe7/MVi3se0hz9cddbyW5OZ7kXOObUu5NNYXT1ASD2qRsd52SXSSkletiLfW
	1WsoHeKvRKBeKjd+errp1a1+9xjRKgd5nEdCSk+mHDpTpXhqkC3EDwpLfjDjNfC8axxVkynW3Xs
	PAmVKuqzwe/fmOx1866XDalMjl/9Jyjxo27dZyISksmTCCkFrXIbbl5cATFEVe6gt7iiIaCzEM6
	LuwHyWWqN3T6Eryrl2b+/lOA1eZyz/T19OajEww4pLZRDMuMlgDe9oT8z/3iSKtyfWy/5Yjyonr
	R/imGuU=
X-Google-Smtp-Source: AGHT+IH3EOFfjRy2pHQZCow+ihTX4jvDoolzW8UTSKno/rqcqAGRzh/TvGK8xVaNUiDNlVEdvHjT3Q==
X-Received: by 2002:a17:90b:258b:b0:2ee:f80c:688d with SMTP id 98e67ed59e1d1-2f782d4f168mr39207230a91.25.1737689107809;
        Thu, 23 Jan 2025 19:25:07 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa6acd0sm596795a91.28.2025.01.23.19.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 19:25:07 -0800 (PST)
Date: Fri, 24 Jan 2025 08:55:02 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	kernel test robot <lkp@intel.com>, stable@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] cpufreq: s3c64xx: Fix compilation warning
Message-ID: <20250124032502.nj25mu5mko36qjaq@vireshk-i7>
References: <236b227e929e5adc04d1e9e7af6845a46c8e9432.1737525916.git.viresh.kumar@linaro.org>
 <CAJZ5v0gz2WLtwJca5oAgZ23C+UmX18k9fvCbzRAEV6zZL4jiiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gz2WLtwJca5oAgZ23C+UmX18k9fvCbzRAEV6zZL4jiiQ@mail.gmail.com>

On 23-01-25, 20:48, Rafael J. Wysocki wrote:
> On Wed, Jan 22, 2025 at 7:06 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > The driver generates following warning when regulator support isn't
> > enabled in the kernel. Fix it.
> >
> >    drivers/cpufreq/s3c64xx-cpufreq.c: In function 's3c64xx_cpufreq_set_target':
> > >> drivers/cpufreq/s3c64xx-cpufreq.c:55:22: warning: variable 'old_freq' set but not used [-Wunused-but-set-variable]
> >       55 |         unsigned int old_freq, new_freq;
> >          |                      ^~~~~~~~
> > >> drivers/cpufreq/s3c64xx-cpufreq.c:54:30: warning: variable 'dvfs' set but not used [-Wunused-but-set-variable]
> >       54 |         struct s3c64xx_dvfs *dvfs;
> >          |                              ^~~~
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202501191803.CtfT7b2o-lkp@intel.com/
> > Cc: <stable@vger.kernel.org> # v5.4+
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> > V2: Move s3c64xx_dvfs_table too inside ifdef.
> 
> Applied as 6.14-rc material.

Thanks.

-- 
viresh

