Return-Path: <linux-pm+bounces-13393-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBA396982D
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 11:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DEDD2846E0
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 09:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E1119F10D;
	Tue,  3 Sep 2024 09:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RadgnbUx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409581C769D
	for <linux-pm@vger.kernel.org>; Tue,  3 Sep 2024 09:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725354147; cv=none; b=lIJ2MyqcDbrwMe1d8vSXwlEVvZnpiB8CPPxEblKjDTYYPPHCVQDXznsCbCkcPruBw83rDJi46eUOjuLHZ7t0Eb+hTYdaZfaTlzWjhCemAesiG0csu4lx50ke2virtrUE42gdc+5RbgQzheDF+wWA9b3G+44tvIgV5r0FBjoapS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725354147; c=relaxed/simple;
	bh=IQb53KgzsuBBGNZqztOohZUksn7yecYeum0vMBoGK3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LuRgYM2Pyp16L0peIQ18Rg5XeRC4ZNHkXNkNzQQAR8nUd01Q6/vBpWW6mYuOWc6T88iqttDQJ5hlLCbqPX7rC7rP/YTRMdGOR1GPivnFI4FMKuiJTtIyqrFQJQ6tZNlu/5VSBPM02qB/a3zk+TkQ9IA5qW+GtXWojNXPHkbNlBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RadgnbUx; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71434174201so4101918b3a.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Sep 2024 02:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725354144; x=1725958944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=28J7btq0UkSAA2HYJWvtZYvalFZ69/IJwEZuaIkLzn8=;
        b=RadgnbUxZg+w42X/5CP79U0mAlJ2wNshhU2Tp7MbCZJtytE7VsZG0WVBDapN8KRbp4
         +nEESZJvJXp9Jb0bLtkDS1g60jOfNT76KLF3SL4k76d10xP+ISLxVaZTxbTN3wVNjwSS
         Q/0GRctLZXwsbE0YyqK/CrJPD3VA/i/cfoSthO3PKyQn9nuufpK0ngQBYzei0lC7+iTx
         2cJA5i4kLE3VYAYl6UZzBELY8OmtTvBIMSYUYSmmJTZ+T5aJcmkOfTzrwOgVA0DIdPPw
         b/ogdC/i0N3PmtHP6DmR1s6jVkEGfoOLpoKkK5kVMRuQD/PVMaQmWfa5FmFNHMnIHvcF
         uwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725354144; x=1725958944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28J7btq0UkSAA2HYJWvtZYvalFZ69/IJwEZuaIkLzn8=;
        b=XPLtJ+U/hd/vl6oOcCy37hhr9QVz8BZib7wBw5Wi89VcvHofkBsMmyzoni0zY8Juk2
         6onrahqz6ZrAM0gj0eszI2PerPI4HK0hdyixy1BCduybU7NMwu+DnQWo68r3OpQSrZH0
         fxgkPsbi68q8QrnKQCckpJrMijyuyn+23i8CGkr3G2cuzqv0OOh2o9coWfN2cjURCJLC
         SBME91jkpl9BhZWTbRSaftsLBFdsHCVDmLrfmMvl2U5ARzfP6ypu6MAL/h/5+zVWsfBH
         Y6vz4RbFGx/bXuUdxlZCOTBF5/RacqZW15FiCjecNd9muMY/qmKRXHEkei+lmAesB51g
         Pjrw==
X-Forwarded-Encrypted: i=1; AJvYcCVLbV4hhZyJH8ZQJLYQAGj6FtK7fqlF/xbPZsYM1zS0ylUYjsJJnGfJrCEUtT0urhh0dL2JJCbEag==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe9krN+tZhytpny37QYBMVFNxA/0rz6YnsdzyLdT3vR0TnDTfu
	1wIQrKoH+DsGHVHR/9F3nF6GmViRi1It86hnzenzV2xbPQSdIew8M/BL5hZgyts=
X-Google-Smtp-Source: AGHT+IHEB6NjKvozQK25VQbnAiQGuXSrow5+OHBblwLeDF2SxTC7aWBa3T+1AoJ1phXALsBFx5kKIg==
X-Received: by 2002:a05:6a21:2d8d:b0:1c6:ac08:8ee0 with SMTP id adf61e73a8af0-1cecf4dd69cmr13350841637.19.1725354144618;
        Tue, 03 Sep 2024 02:02:24 -0700 (PDT)
Received: from localhost ([122.172.83.237])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e77554fsm8845343a12.33.2024.09.03.02.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 02:02:24 -0700 (PDT)
Date: Tue, 3 Sep 2024 14:32:22 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Nishanth Menon <nm@ti.com>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Kevin Hilman <khilman@kernel.org>, Tony Lindgren <tony@atomide.com>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	bb@ti.com, d-gole@ti.com
Subject: Re: [PATCH] cpufreq: ti-cpufreq: Introduce quirks to handle syscon
 fails appropriately
Message-ID: <20240903090222.y4cnnt2o6t5tr3n5@vireshk-i7>
References: <20240828131915.3198081-1-nm@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828131915.3198081-1-nm@ti.com>

On 28-08-24, 08:19, Nishanth Menon wrote:
> Commit b4bc9f9e27ed ("cpufreq: ti-cpufreq: add support for omap34xx
> and omap36xx") introduced special handling for OMAP3 class devices
> where syscon node may not be present. However, this also creates a bug
> where the syscon node is present, however the offset used to read
> is beyond the syscon defined range.
> 
> Fix this by providing a quirk option that is populated when such
> special handling is required. This allows proper failure for all other
> platforms when the syscon node and efuse offsets are mismatched.
> 
> Fixes: b4bc9f9e27ed ("cpufreq: ti-cpufreq: add support for omap34xx and omap36xx")
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> 

Applied. Thanks.

-- 
viresh

