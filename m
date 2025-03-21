Return-Path: <linux-pm+bounces-24362-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7A1A6B3E0
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 05:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA812463B9F
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 04:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1710F1E98ED;
	Fri, 21 Mar 2025 04:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QBQ0o1D3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE8D1E1A18
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2025 04:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742533185; cv=none; b=LqxkttvhKYCP50woLXLWagGBlcQhr0qLXYz/9CJwvDVRv8OaL6N/G2ab+rdXWdCimYakIy8pMmjYUIPja6h//RtVcKFT2XLFfkqvBQimvdGw4xmdtEvJkw8hXbJjFOlI0YC91Yor8J+xyLaR0MfhzQtwrexqcp6RsyeELGCKMck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742533185; c=relaxed/simple;
	bh=gxd1hr2GTxufsrMwYQjmiavkuOVdqhc1FwR0v5o/cW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxmSievRWlUkhcg3n7v7nHunSd70mxFm8/L86YlM1Gyvx2DVlQ0e48uLblfooOi/vv2QC9hzNUeBBp7fsu8W9hlBnwPByV7I/zIUQpLctVotoepFHZia3SgicBAF9iuS5cIFi6UNopEachT6EzS9G968mGwpTdcR6EAOqOQvIqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QBQ0o1D3; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3012a0c8496so2025154a91.2
        for <linux-pm@vger.kernel.org>; Thu, 20 Mar 2025 21:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742533181; x=1743137981; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jU1uq3ftdFeUBHBrd4FxFBQmvi/x+JX/MfO5OssoYEQ=;
        b=QBQ0o1D36ECMAUnXX79OTh85pU8sq8Fg9gCM3DikMI61K9Nt+oO7Tk5+t0aFGjAWeB
         rhvPs5nVzTcwloxAWps7qyHLUyQ8SJ2V1cah6pnZr+CBviR4lmDLLwAweX4fAiSapmN4
         Pd48S56iYYTMHZjOxcK8k69n+BieAwqJBfq/6s6TMUO9TfVnW0hJyDSRIAHjRygSe5Py
         v8/Z1HH/Hrb5ghtU/nbiYm1OcKDL6oF7wtYlnf4f+SkUOaNuDN7YxX577aREPotgjBHh
         MHg0Gr40Dc7BJSqMcXeuktcX51aUh7N4TolXX54v+g2BK4z1bWe86GIrBDM0IQdHkRGV
         EmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742533181; x=1743137981;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jU1uq3ftdFeUBHBrd4FxFBQmvi/x+JX/MfO5OssoYEQ=;
        b=DmnICLZuK8IYyZ6lrnWp+asuDOPjz8RkQoDj57FUdZZGLbNeDHo4Wd07uqySbfnoc0
         /7o6mJPevtUC2CeXjmn1f2gQT5fFXFZz6dA3Q7CH0Xt95b5cjSX3D2+gvinHJi93uUDc
         budlZ/7m6RNYkJNh4yUk5vu8a1z3JbTjPi7U5KjJTAEM+5deD0uMMs0oLaiybN/NLIcU
         QXAQ+eUdrbh+WheDvAWwsfwUk2N6OG6xvn6d2e8y7YixrrxC5nf+vpeCVlggd1gyABjF
         8cu/aMAZxVGrzLaJs+SY+cFnfClWJ80+9+6oCRqcFb4roQZVTaS5xHJ+uJtZwAeJLTpr
         htew==
X-Forwarded-Encrypted: i=1; AJvYcCWr7tFkipcTEnS6nc1kCXskwZkuJ9q/636GKmzzN1Ujw8xtQzYBokGrXHsEVieBJ/rBFt/giHSsbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtFxIzH+p+f4xp0QenQIbxpUpyyCDaKCtaKrPf0ivtJDx51ppO
	PGfaNQcb3a8XWIT6Np7xzPDup9Dxrs/iSTTBqn2SVEJpwxJ+WOEdKXfr02sovOw=
X-Gm-Gg: ASbGncs9KKlYHKPsiXloXZntDKjjIufNVFJ4+6Ou+B/ZzYuGMUIkdmaHzVK9fcKN5E+
	sofQnNXdUGrbR5ZPQC0hsilK8Kq92OGRX9D0zclBnfV29dxhJwK+QKGD3Agkbu9qAmSNBQHw/JX
	RqpSJst92z6ypTwfblhk6LViZeThnJbdx4aivLAk22j2ndS9uqfuwCeb+XbAS77YQYBQpJA/q8a
	uTBzidSE/j+RUikuMU5fL8ftIfFnUlyVbtEyIj3t9vdzJbCtbe+fwM0rVxX06PAloVyeuJ91533
	5XoZ8C8ERgO4gupKOlciVGLahYRJtBVeFyEF5suTWGV0Cw==
X-Google-Smtp-Source: AGHT+IE1MkhF+eIlYdPjXH6Mh2gvQg0KSwaX+hGGWKTe/5F0qYgaHVHgqtmttCIIq/1Wqtv32WWi0A==
X-Received: by 2002:a17:90b:3912:b0:2fa:e9b:33b3 with SMTP id 98e67ed59e1d1-3030fe56ae6mr2439451a91.6.1742533180745;
        Thu, 20 Mar 2025 21:59:40 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf59e2desm4949374a91.23.2025.03.20.21.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 21:59:40 -0700 (PDT)
Date: Fri, 21 Mar 2025 10:29:38 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Chun-Jen Tseng =?utf-8?B?KOabvuS/iuS7gSk=?= <Chun-Jen.Tseng@mediatek.com>
Cc: "cw00.choi@samsung.com" <cw00.choi@samsung.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kyungmin.park@samsung.com" <kyungmin.park@samsung.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v3 2/3] cpufreq: mediatek: Add CPUFREQ_ASYNC_NOTIFICATION
 flag
Message-ID: <20250321045938.6gnmtlbdcx2i6gmw@vireshk-i7>
References: <20250214074353.1169864-1-chun-jen.tseng@mediatek.com>
 <20250214074353.1169864-3-chun-jen.tseng@mediatek.com>
 <20250219054543.4xt4tixsauwoqpst@vireshk-i7>
 <21e1b622c2968a5549b2ff37e4ba329a557968b6.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21e1b622c2968a5549b2ff37e4ba329a557968b6.camel@mediatek.com>

On 20-03-25, 08:34, Chun-Jen Tseng (曾俊仁) wrote:
> For CCI and ARMPLL in different driver, I need to change ARMPLL first
> then use cpufreq notify CCI driver. it can avoid CCI driver get wrong
> ARMPLL frequency and choose WRONG frequency.

That flag is only required if mtk_cpufreq_set_target() isn't able to complete
the freq transition. Which isn't the case here. I don't think your patch is
correct.

-- 
viresh

