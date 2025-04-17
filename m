Return-Path: <linux-pm+bounces-25594-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DD0A9127F
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 07:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7885189FF06
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 05:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4921B3934;
	Thu, 17 Apr 2025 05:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ywX7QEex"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739DA79C4
	for <linux-pm@vger.kernel.org>; Thu, 17 Apr 2025 05:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744866151; cv=none; b=kgtN13FVwN+TpXtr4k4MGlEp3P0j4Acjt1WeacpBm4Ig9uMTcwk2Quhh7jzAuJ1OjUpVgbzGCrYmR39pKpAwAx2OGHu0rI4UsXjpqyj6pPjaiNNUIcONj55baNq+W6gd/mwuod8cM5Phw86tCPpPwsAFpkf8WnIpf/pkFDIT/XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744866151; c=relaxed/simple;
	bh=9M2r/BN+wgJnJLiMtl0Q6+EJzSQ1DU6UiVV2RyTO9jM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5rh6/gpkGd5fYWjDyoYaT5bDuXI4I2uFVXlSsqT8Siq27U/hIQrb4Sy5m83K5NiCHCMEP/rZ9n9f6jtBpOjA3tNeg5IOJzoBDlYk9OKPAPrj6nr+db6Kaz/2wXhaFTEa3TD21cruTGcKC7UHsW7QHJDVDG3/dnXZ7syUGewU8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ywX7QEex; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-736b350a22cso272216b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 16 Apr 2025 22:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744866149; x=1745470949; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GZHfsagG6Q2hcjMTlAC7HlQ6ESQi8KB+OYVG8WQKoGk=;
        b=ywX7QEexMkd2HJwBKaSAvKsao0bDedd1u5pEheaIrK8YQzwzSEqZG8E+fRjUdXyNVJ
         7vy/g6OCSvrbnxo2Zw/Wwpn9WMSzk95QPalIEJs0XFypLk+/PN9HHjeR7vkGq3kAB/RW
         v2vjFCRXmikSwFksnfntmtV5PY6fOD7gnWfqCzdtAg51pUtpQX3JOG7tCw+qsV32rrk2
         zh/aeJ7OE/2mnvSObu3rKYk/rucu7MpSnoMqtPotRnxZ3DSjck11WMEvp1zC+pKpvdrF
         rrxWtwnzsND8ZNs73jSgQQdIrXueBVqG00hWXKiKPUE+o99tfW8Dmz8sjOYuNfr2XVAN
         eIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744866149; x=1745470949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZHfsagG6Q2hcjMTlAC7HlQ6ESQi8KB+OYVG8WQKoGk=;
        b=wnt4MOMui0jqawdztp4RYJLTtdzxZMvINp1bjAttYlZsr5el9/LuUlVCT9kwzvCYOR
         Vy9OrNXdYTHNf5NhWRfzf0wopDoDfklc9Du9h4OIC7Pmjs0ngMrwp/hN0u4F6hjdGDbr
         MNt1Vuy8H4wkyKF4XYy9rgpjTdu9xs1m21sbzGN4/dksci37UBFoOKDtkDFscuJv7kpA
         heN3Z+yK9RZeFmhBN9PFoF3inllRtfzwdDvdhuhgL1Nz+13RjBl7XXdO/ViUbIuc7xVW
         8DVtuD/n8EuuclLxIvdgfwSgK0kDCaHkB0n8jI/7KRICVJCWt9YZMsVGxXEkEedFCZVh
         +jyw==
X-Forwarded-Encrypted: i=1; AJvYcCVCjJn5QoxnnET2MiAehl86goWGycgBMX+q/rhDmGh3hkozEZ+Do81ADjdJpBfj4+fZ8aVV0ZcK9w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5yISX0RDF+VR7Te8X3bxKDkwEch/xLpgOWusloOyidf0albev
	vpo7fxswHhYobYH1EUuSmL+RSQQgfq2TUPwXPv4fuYA5kYpic9umVbbNV74euY0=
X-Gm-Gg: ASbGnctyo0aHWwexDrQZDKl6mK+EkVJdmPtFyKSGInJK/M25JOjsqMZoNo2qF6xt2Zi
	lT2joqc9QNV72B4OeYX0HpTE117oo0Syg4mvXqA1Nphav5yhi6w3bkopuW7b/I+utOk3QBgswF2
	/do0SdefuxbScztnYC+NGxSIuGRgH+sfQexiO5RSPhhsBnTrfkPdkYoFN+ODOAvBxKYYKU+ghCA
	tErcMaSTIOdVu9DMJ1u5rawQDjW0FRZZZwjoAiqtBmK5Tty/5sv6lMfRB0k2NgH8FDHGMiaiTcn
	+Bi60qjgIRWmeNnk9lQPz10t4WobO9S+iRSKxRGU5g==
X-Google-Smtp-Source: AGHT+IFSqgtpQYxJWwym9yAwruethfN7kMgJzdygmpSqtMeWwFsSzwF9wIfwPtkLQ/Exq5QZsCWNiA==
X-Received: by 2002:a05:6a00:451c:b0:736:6ecd:8e32 with SMTP id d2e1a72fcca58-73c267f8a15mr6255222b3a.21.1744866148664;
        Wed, 16 Apr 2025 22:02:28 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd21c338fsm11376269b3a.43.2025.04.16.22.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 22:02:28 -0700 (PDT)
Date: Thu, 17 Apr 2025 10:32:26 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Nicholas Chin <nic.c3.14@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com, rafael@kernel.org,
	vincent.guittot@linaro.org, zhenglifeng1@huawei.com
Subject: Re: [PATCH] cpufreq: acpi: Don't enable boost on policy exit
Message-ID: <20250417050226.c6kdp2s5du3y3a3j@vireshk-i7>
References: <2c788c2ca0cab09a8ef4e384f272af928a880b0e.1744781329.git.viresh.kumar@linaro.org>
 <20250417015424.36487-1-nic.c3.14@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417015424.36487-1-nic.c3.14@gmail.com>

On 16-04-25, 19:54, Nicholas Chin wrote:
> Unfortunately the issue I reported still seems to be present after
> applying this patch. Upon resuming from suspend, the system is still
> entering boost states descpite the boost flag being set to 0.

Okay, so this is what we know so far:

- Force synchronizing (disabling here) boost state at resume was
  making this work earlier.

- Setting the boost flag to "enabled" state during resume works as
  well, as that makes the cpufreq core disable the boost frequencies
  again.

- This patch (though doing the correct thing) doesn't work. This is
  one of the known places where boost was getting enabled before going
  to suspend though.

- This means that some other part of kernel (or hardware ?) is
  enabling the boost frequencies at suspend (or early resume), which
  the kernel was disabling earlier and not anymore.

Rafael, any suggestions ?

-- 
viresh

