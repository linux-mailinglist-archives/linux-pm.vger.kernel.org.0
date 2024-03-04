Return-Path: <linux-pm+bounces-4642-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C2986FF9D
	for <lists+linux-pm@lfdr.de>; Mon,  4 Mar 2024 11:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A4081C220FB
	for <lists+linux-pm@lfdr.de>; Mon,  4 Mar 2024 10:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A142C376F7;
	Mon,  4 Mar 2024 10:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O2j2Mqz+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5441B814
	for <linux-pm@vger.kernel.org>; Mon,  4 Mar 2024 10:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709549905; cv=none; b=iyp74RWTgTl0BJ11Vj5+i77LrnXvNTy5l3kQPowyGJUVec0h7/BYm73E+ge+HasXJZGi1MnNdIBw8fMi14IGK5D4TUKCs577owS2Ck7k0kwJShmgsgusHNgP3JXkSclztAqF1W1CNizzK12wo8lqFP+YpvhSEvGMToOz1lKDHho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709549905; c=relaxed/simple;
	bh=SU0P+6mERyVFW+8OS0nJ5FDl/7jXIMmV2cJFkItJc+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKE2yOD8BIImoTcCo+j1hR3HY+pSIrRw99TwNM+eUWfskObVlholuj18kiB6bEoaruYu/dmR14xQWiyZ4TpyvCMB1l+I35sETpsvt81XT2c4FU7lc6PCfcGnfxGZ2OerqHfzMNdTJf79D8PA9aVMYZ19Fq3hKU9Xn6HBpjMaSbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O2j2Mqz+; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5d8b276979aso3170613a12.2
        for <linux-pm@vger.kernel.org>; Mon, 04 Mar 2024 02:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709549903; x=1710154703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dMoA5iWDNFyiJx9tRtvnvsvxhpL7jN9qbbKy50/eZLA=;
        b=O2j2Mqz+gWAFAN3ZWJRE1+ItIdtpJ9ZlC3TCt64xuav+2HVEpd/+5xZZ6ywTEsQtLQ
         N+kpynj/NgFIHtzmEAgHSYAV+gbbqyvVqQoudm8H6/6e9+ldX/GKLdflnKcC4hm7dKDm
         xHW/sBtoZOU+C9z62t0PvPAXtHb9M8ef+9YhxhkzmZTxB67kAY048kvyEjeu3MyRyL4d
         mZRoPvYkMA0pmBKbloEdRAAtj+nPJb+wmrf76pd2exPmOet7vU00bxQD3ciRlM8IVTfk
         CCYSYEaEyuto1rzUuDYhjDJvJdnsvvR4IRiiuZIvPu308uAgDL8XpYyiRdtpd4EChLnS
         MuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709549903; x=1710154703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMoA5iWDNFyiJx9tRtvnvsvxhpL7jN9qbbKy50/eZLA=;
        b=PQF1lcZCnA2Htt8jU+5GYTkZR9clIvCoyNbA4sTajUEHpjQn3aB5L9fT/GWya1jSER
         UXJKT/68YjN+cfdZCVLXOsObnzl3LoFBVPiBzZfU2VaCqQBOknKXsEUqYQImHTxiLq/O
         m2/U8ig9eyYWZLZn5KjDVG6oLQ2QW0++bokhoauYXRCKU16KUsgA0YC+y+3VqcLbc4fB
         CWj32zXAJGU5r2o02wpSgK3x4skdpSP8hfT90S6arnHibILX7+sVGLLWEi0OerxmaDjd
         TVkarRYHtk6QSdrlOh9M1uvI4ONQfixXWkekbmw7LUqbb7mMx6dGFpq00REeUBve4+5D
         ucyw==
X-Forwarded-Encrypted: i=1; AJvYcCVvT6AKEvADAcuLnNLKMItcch/T2ZwzIxKpJYpUHIIhhaY4yE+DJHIFh7pc2aKNgGWyTmLeU6v9K7ZIKoWKUzNUgHE5fTRY4ZM=
X-Gm-Message-State: AOJu0YyoABIgt9ntr4BtmAFChjX04WxFCK6OKwg7C40UnfcGcrN8oNBm
	xKA+n5nPQNcaKPYfUToekI+Zos7QkgqhNGfFgTwvl4dIFTUuxXMVryDtsXMHdMI=
X-Google-Smtp-Source: AGHT+IFclK9KSuIBkEGO5u4U5zTs0p5rv4do1pwK9OoxRSfIWqOpITeZZDuYlsvkxdVYPtU0c0rYiQ==
X-Received: by 2002:a05:6a20:4308:b0:1a1:4b74:1102 with SMTP id h8-20020a056a20430800b001a14b741102mr3009164pzk.16.1709549903528;
        Mon, 04 Mar 2024 02:58:23 -0800 (PST)
Received: from localhost ([122.172.85.206])
        by smtp.gmail.com with ESMTPSA id z18-20020a170903019200b001d8be6d1ec4sm8198202plg.39.2024.03.04.02.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 02:58:23 -0800 (PST)
Date: Mon, 4 Mar 2024 16:28:20 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dhruva Gole <d-gole@ti.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] OPP: debugfs: Fix warning with W=1 builds
Message-ID: <20240304105820.urasbqh7gtiwt2o3@vireshk-i7>
References: <50a1a0f23efdc261844a306f5e611051843b4e52.1709536847.git.viresh.kumar@linaro.org>
 <ae566a5d-b31c-4e69-8e79-92322ac7e104@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae566a5d-b31c-4e69-8e79-92322ac7e104@ti.com>

On 04-03-24, 13:12, Dhruva Gole wrote:
> I'd rather we use malloc

The problem is that we don't know the length of the string here and we
don't want to hardcode the number of clks, regulators, etc.

> or else change the limits of the
> "rate_hz_%d" to "rate_hz_%4d" or how many ever digits makes sense.

That will not work I am afraid. This works as you intend to for %s,
but not for %d. With %Nd, N only signifies the minimum space the value
will take.

Let me make it better anyway, will try something.

-- 
viresh

