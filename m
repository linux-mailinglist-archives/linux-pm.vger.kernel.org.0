Return-Path: <linux-pm+bounces-20526-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2363A13387
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 08:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D8E71881B7B
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 07:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3463319644B;
	Thu, 16 Jan 2025 07:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="koimY0D/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0DC18C01E
	for <linux-pm@vger.kernel.org>; Thu, 16 Jan 2025 07:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737010941; cv=none; b=HFaRcYP1+VYD/sV2om94wuCfxQUDT2eg0vhyy0vfhfmXiTumP8IEbgcBNk3CiHA1AJG4DwPKx4WPzsC273MDN+/v+WfMEf6+tBWgElo5RYYlnADs/eNWuLzIzHNHGFSXGv3NzpZaaoDWvVyru9oHNWg5Y6tm+LPOFwtwl4wXr7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737010941; c=relaxed/simple;
	bh=LYf4Heml1LtDO/L+mq0vB1SnlOrRybgUhc3drbjDADs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQB2QgB+6fbICCmC1vKrFcyNfTjM53+R5ygKaDub/ccxTp9JSEBDMNbe44ZJJFx8UVE5Kgh0grXUWS/uKqv3JsgPsM/Da0hJ+H8hRm6sw0HATOBp8X5srpUlXdseQtx9x5wpsSQoCl2nDECwMqyZHfMCOoNTJDYxvaxFCK4f9/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=koimY0D/; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21a7ed0155cso7791505ad.3
        for <linux-pm@vger.kernel.org>; Wed, 15 Jan 2025 23:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737010937; x=1737615737; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZS/zLNoMtbOmAlXztUQxM70zl6Vh6C5NkcTxONG7DqM=;
        b=koimY0D/sMYJqVcg273fLE7vmvAsVprtsWH9WseflLG0KfM/OmloBI5GW3mLGDvjkE
         yagNImuMBh0tCl0Qqa0fuaorJzscE13od77OiEtGT5DMPd5xfn6ibYI+AaSZhcVoYnlp
         h/Pz2kPlFbuAirsNxP+US0rI2YRK5u4TBdKUX83xGCS40MkwNi9+MWcfAyKOjWBeEA50
         lf98BsZmqBjhsmoAmab/SG7om8J5JtKsCV1BXzHet5ts2+QZjIbKjDEZlVaFBlzOphGH
         Pi4/cLDJ+Ypuu5wAgry//KTr9247jhrsyDosIWH5twM5W4lrDbODRlMtl/snqrhf56Jt
         4FRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737010937; x=1737615737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZS/zLNoMtbOmAlXztUQxM70zl6Vh6C5NkcTxONG7DqM=;
        b=fYvLpOlH7Xbp7bE+BkaeA/B3RF+M3YX8xMlslgj83WiQT1Ga3c8PeoYWpjJta2vETY
         5aYBvLVvUOVTQiBMfY7zzQ+Ib9dlFnCHtZWW7S4MvWPLm1IK8S1HpQFcOg8AbqyAQAqD
         DjIt9j7nzzBLhP2MElnmf2k0PQf2ztJFLIVW+pYlg3/Yv1H0BTUBWdw1fxQqLWJZi5cx
         KKwrO0VANC94T1y1nC7RYhN1sGVjvGi+58Ze2pg8FWa0hq8deJpTTubdWFdbbUu1DM6h
         3iue+ooQfjI9yZ21oGZv5OPzc9D+MQVtqYNEd3zJpECBYnzo6C4jxyuYOoQRQIgSIZWM
         bSlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbpGn86X5Kn8ZTM8br0HonevpOJLs4kfgyciT67qwb8Qko4ljyRJUs1rO/JbjxWfsc4VBmAAdxxg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLlwkfBe1GaEh+hkHdeXMKsDjSB8wU07fU11m8aDkC2uH2rXCM
	Yyj4nXMqCtcB0KRvcwmAcWD3wade7WgCNAhMb6eI990pRZo1E31k9ndld+/E77vJf92nstxPHbp
	/
X-Gm-Gg: ASbGnctetdSQ5YjNfkRT6nSIUXczvTG2Y9CpsPBEvA+umBYfWnvh9ur8hRmYFMxWUKK
	zlXnBo6Dnavn6/ykl3d0i4ajlWRCP5XnDQs5mmz3QdxaNOwMbN+u20UioDrV5puMeYlgAkdTpL3
	DnkyAau/6+wj+SerCzT5ZC9tYGkLkVU56eJvC9NRY4PqI0sg5vQdnUQqWq20eRYk7G9Fi9qGzBq
	bVPCwjkhvy4Q9UHUJoNlt2A7N1p2a4feMkrUsBIW3NInHxHLCm+cAQFrAE=
X-Google-Smtp-Source: AGHT+IFlzrBcdUY0bs4/8Sj7xVrCBP3SbPdaZMKXeURQBEhXHLuZJom44Aw7mHBQtMkoxQPSA6dA9w==
X-Received: by 2002:aa7:88cc:0:b0:71e:4930:162c with SMTP id d2e1a72fcca58-72d21f4ac63mr45499683b3a.6.1737010936743;
        Wed, 15 Jan 2025 23:02:16 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40549322sm10135399b3a.8.2025.01.15.23.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 23:02:16 -0800 (PST)
Date: Thu, 16 Jan 2025 12:32:14 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, upstream@airoha.com
Subject: Re: [PATCH v10 1/2] pmdomain: airoha: Add Airoha CPU PM Domain
 support
Message-ID: <20250116070214.vdnbyyqnciifngha@vireshk-i7>
References: <20250109131313.32317-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109131313.32317-1-ansuelsmth@gmail.com>

Ulf,

On 09-01-25, 14:12, Christian Marangi wrote:
> Add Airoha CPU PM Domain support to control frequency and power of CPU
> present on Airoha EN7581 SoC.
> 
> Frequency and power can be controlled with the use of the SMC command by
> passing the performance state. The driver also expose a read-only clock
> that expose the current CPU frequency with SMC command.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> Changes v10:
> - Depends on HAVE_ARM_SMCCC
> Changes v9:
> - Fix compile error targetting wrong branch (remove_new change)
> Changes v8:
> - Add this patch
> - Use SMC invoke instead of 1.2

Any inputs on this ?

-- 
viresh

