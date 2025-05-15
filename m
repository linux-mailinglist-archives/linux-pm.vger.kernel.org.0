Return-Path: <linux-pm+bounces-27196-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F55AB8718
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 14:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAB7D3A4188
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 12:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDC029A32D;
	Thu, 15 May 2025 12:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RR8++vlc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD9F298253
	for <linux-pm@vger.kernel.org>; Thu, 15 May 2025 12:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313545; cv=none; b=Q/3j+zOadpFOp/TI3IZVkx25pvvG5NO+VeKJeYcv73LzsAHLjvEBN9vxPl1MF6MAyRUwAtM2ZmIylbVFJCHw3ME/nylHvH7WAkYylrOJV5MAnazfLwaiFvXYB2PpJUFvrTTD6aweH+hCiQiadjOUBS1Fx6KcCcEGiHS3oT5tTJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313545; c=relaxed/simple;
	bh=CPkuAWMDXEB5UuZ6HlFfiQZ87mvHOAlAeOGYVCqenus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxRjGpGmLuQU3JPLOE6zNGbcwlCKSoft4MxXS6y6/UT2wktfV9cc8gTiJMh4hir9cyJTZK277MmfTJTuC3/47exjj1ypu8QBuA1YGa2DXBZ3P/KjH9bxjpBFDLOuTenL1vwFFz71ZVSHXN1W2jA4Mwdw+/pKQuS2WBBO5n/BJaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RR8++vlc; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a1f9791a4dso581612f8f.0
        for <linux-pm@vger.kernel.org>; Thu, 15 May 2025 05:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747313540; x=1747918340; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fK3aTKI5/68JTESvc/oXGZyIBHmOFX8dt6G+gKVeWWw=;
        b=RR8++vlclrR7mSnYYWcClj7379hRTHpvCAatuSGIK+PKgt1QaQeYIsRM9A9IVH+8NR
         gzJbRVdAwYEptf40X5KvRYyS4KNTzVWHnFtI4+2/bkszInITcI5M1xlUsJnX5r15UX95
         mzvu/WtaR5mjaJD5KmI0NvQo+b3EJy2O6NcdwUXExaT0nvbLcEj3ppkOrce+asojVmHE
         28M4jxXWP7RgbQPTZtOc7raTyVlo9gk5jBMO+CgjoREyNLxrdafWi3CljnHf+Ky3QAB3
         EZmjaHLOvEHRp6LGWyi8LJqzU9ivfnjPo2tG7NrXaoXHKNOzVGAI73ISEo3o92qVjq67
         s38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747313540; x=1747918340;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fK3aTKI5/68JTESvc/oXGZyIBHmOFX8dt6G+gKVeWWw=;
        b=A7YkBNaNqnFMqBT8TrCXVbOTHM0zSou3tcidS6f9phTIcw2DWQBp1t1MgCJfjBgqmr
         iDHUD+Pivzt55qE+0g55ZMvpoxYYQSF0YFudIGXaMGicsuM8BheOssRTef7vp1axAckA
         RxLcyeGf6SuD5d4tYAtGxiAAy7xZI0DkgJKwYGZ81jMhZcHOEQoJf40mSqrXM8d57W8l
         3nz5yq41Mwc1PB4srDA67uQVyYF8D3rkJ1aLDXiFxQ3iOKOw49iksFOwhfRD88E05CYB
         zmwotpn3DySh4hZX2C0PrskzReIS3TIw+uKmZgvqa/2iKkJ+wiiiu8M23aR8ZS1fTybn
         T6gg==
X-Forwarded-Encrypted: i=1; AJvYcCWuMiZyfIndrsmfRajMLE+BL6DidrqOF9tRjMqP2CEH46lR374eLzCQwhGAG7Buiqts4FT9TpyInw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJz7DB/mW/oqF+gQ4ra7EeLEvf08VCxsRJwWmhE+5FIUD2QsFk
	IslYK7cId2QmHElvz4Fmnk6wEfJpCEA+ddw7CnfRCdEvfn+rW83dBKADOkrp0Zk=
X-Gm-Gg: ASbGnctPz24vlvZoRNedWsOx08SWc2n5YhLDflEijyWaY7sr1BZgCUwG5PzK3PqWE1B
	y8FxZ4Cjbz0z/F45HBSKSftb6BGRa3RBLtROI8UzndrsRm8oTTdt++oOJ58WxGIRBMDseVcFssB
	T1GnqY6/HMv578aQPVh6vr2qBgloBlqY0TFWVD6qofgTgofMTzVeXhrmOQK2dYm7tkgCChKzf7i
	cKEnyuJHaMlPqpnY1xTo7QGxPzzaTl5FQVqPGHnqZwNf8Kdk9bmYoeZqIY+XwNSW7jfiFebAIje
	IeObBAUzhOX+kYh/pKTbARj6PVtsOeSQi7D0tfk3YxkchNfcqm8Aaw/AyT7DjyLb8Q8rkpELFcP
	Gwv+JZOpVP/ccoA==
X-Google-Smtp-Source: AGHT+IHS2/j9+N7xSaRjAkIWps6mxeAYqws1hdNZCTv0XgJraew6abe5Y67oztqEy7hekjalJ6mCwg==
X-Received: by 2002:a05:6000:2501:b0:3a3:55e6:eac6 with SMTP id ffacd0b85a97d-3a355e6f03fmr1782764f8f.17.1747313540359;
        Thu, 15 May 2025 05:52:20 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57ddd2dsm22638932f8f.9.2025.05.15.05.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 05:52:19 -0700 (PDT)
Date: Thu, 15 May 2025 14:52:18 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	ALOK TIWARI <alok.a.tiwari@oracle.com>
Subject: Re: [PATCH] thermal: airoha: Fix spelling mistake
Message-ID: <aCXjgj-3kmcCqLpT@mai.linaro.org>
References: <20250514213919.2321490-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250514213919.2321490-1-ansuelsmth@gmail.com>

On Wed, May 14, 2025 at 11:39:12PM +0200, Christian Marangi wrote:
> Fix various spelling mistake in airoha_thermal_setup_monitor() and
> define.
> 
> Reported-by: ALOK TIWARI <alok.a.tiwari@oracle.com>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---

Applied, thanks

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

