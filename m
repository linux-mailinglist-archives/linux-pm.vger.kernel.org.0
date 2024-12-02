Return-Path: <linux-pm+bounces-18317-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7BA9DFAC0
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 07:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 761B81626BD
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 06:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4C71F8AE5;
	Mon,  2 Dec 2024 06:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N4LdHVlH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F30F33F6
	for <linux-pm@vger.kernel.org>; Mon,  2 Dec 2024 06:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733121196; cv=none; b=qvuGPxpWx6YDsntqwgQ/7QAQ9IkW7oZ9dq+UCInknvcf8Q6O8NeGeEjIC5XxgEneq11BFqZAd7Exuhk3Ig6PP/ns1dYLukTZhR/AG2FoHEyn9Fre63UhzHlzL/aQ+w5yKua/ZNUDoDbjeH7X5R3U4rSLTaJLxepAD5id23qKWnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733121196; c=relaxed/simple;
	bh=5a0S2upxKeJHX5ca/O2fBI/NQyJIHNd673SOJDKYZtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QD1TNwr7TNbT8NYkhxOZKg1j6aDDzgnMMH1Ny5hdB1ZUat8JpLacKgqkoRTDAVgq8qkhsWetku3uyJtfxSrbx1nnLh+bXfZrZiMUQ+mXt9PT1J/kHZR6zavQY0OdO3obV/bWhUwcupTitAzp9DeV9KekEYemiqydG8M1WhR3naI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N4LdHVlH; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-724f1ce1732so2920925b3a.1
        for <linux-pm@vger.kernel.org>; Sun, 01 Dec 2024 22:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733121194; x=1733725994; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CISoFXqsKABybYb3NAOx5HlkcJ7x+PNKD4DJwNr0UAg=;
        b=N4LdHVlHQieEf+hMcAAU5rjxAWpU4dJR5qD7RQJMAqvOEBimAfs6t7rKTj64zqtvfi
         FPy0q7cZW8BdM61m+lYtj20mbnirMxYOEHXZ5ZtOff1AN6+ppQgYEmBM7SzI2MbIwWDK
         qi8K2rwTkqjVLYVksiwcXqIYOlkNgbRSWYxH68f65YSP1mH1I/HsQ9XbgldctAx7G5Vf
         zNrGS50d+G5CQx53QF3c892i3abmeMiHEx3ReGqNjmCAdGMR1uScLx/ZSIHqJp7OHm82
         UVg2rXO0aKWmhy4WPlT7YSgESlWM2oHHWrS4z0XM8HaabSw2Wtz134UugQAcLYjvL6kc
         fpug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733121194; x=1733725994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CISoFXqsKABybYb3NAOx5HlkcJ7x+PNKD4DJwNr0UAg=;
        b=CF+wUSLptMbaavNfB7PKp8e9//oVwztE0OU2XwTnYCcpLFzix3f7JYTSj5KDirT94/
         Oly5WNueGqIqiv2sSUzwQJqHS7z3GKdtQ9mCY1RCFUpKWGI5Yqj5Z/MJdc3zDNCJ3NRX
         392YZs0Syd3uOtWzlSQkoE/Rzr01txOCaDBYoRDDyU6B68wrU7HI8Gz+OW/dcg9S/Ys+
         3L3ndBsZPSn8z3UIC/zH57WMCPL/Prs/+clAeetmE904xXdnBzZ0GgFmrgV2HjS6Cgfc
         gtVCXhOOkYky0At7OSZCngtVdozIh8gmiP5CRiQplJvWa+5zq0cBtg2EZSt57ZcYCL3h
         x1NA==
X-Forwarded-Encrypted: i=1; AJvYcCWSmtp/rhZkZjwf7po2I6KBF41IiRHAPpd23q2NIDPDvhMeqvV6j8qF3T0YFALcZPx//ULu890VVw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3nXMyeI0cEIeRnZIYmluweqXierenbsDvsYU1tX5l3emVRFk3
	bhB7tClZLlNEaXNtk0jQNmgdeUa5QqalfCQjGDvT0U2uaIj40jo2HBSBtAMVcRI=
X-Gm-Gg: ASbGncuD5va4Idr5h6aFc8poqzstLWrfQmGTHuR2Miq1hYgYTGsUI3p6poQNDB0ng6X
	VAtHddbLLY5RWN1DjGj7sTphAnkPwmKnSiAM6aM4lEiGTqYljOCDcZDjNdFNIOJoIqEl7/fQB/4
	dbmcWFuAwkV1Ra4I88cX5yI16ObfOToRd8ZuUvXwqW9YIrHJavtYrhbyE3VPJ7phG+QMjGN/Ien
	Qo22xip5W7YuMEiY7i2R6Gmmiq5hCti606Pi3M64drGUvEiiDpv
X-Google-Smtp-Source: AGHT+IFBrdbTTxdw4pY2MNjQE6aYwaMoUjfwBbdWHnsYcntsEY5IUKvNqcvwdTm9QrHO2jax6Cxsgw==
X-Received: by 2002:a05:6a20:3944:b0:1e0:d632:b9e0 with SMTP id adf61e73a8af0-1e0e0b0f127mr33630997637.13.1733121194026;
        Sun, 01 Dec 2024 22:33:14 -0800 (PST)
Received: from localhost ([122.172.86.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254e7685desm5806896b3a.90.2024.12.01.22.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 22:33:13 -0800 (PST)
Date: Mon, 2 Dec 2024 12:03:11 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] OPP: add index check to assert to avoid buffer
 overflow in _read_freq()
Message-ID: <20241202063311.g3333gi7ztblx2hr@vireshk-i7>
References: <20241129-topic-opp-fix-assert-index-check-v2-0-386b2dcbb9a6@linaro.org>
 <20241129-topic-opp-fix-assert-index-check-v2-1-386b2dcbb9a6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129-topic-opp-fix-assert-index-check-v2-1-386b2dcbb9a6@linaro.org>

On 29-11-24, 16:06, Neil Armstrong wrote:
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> +static bool assert_single_clk(struct opp_table *opp_table, int __always_unused index)

Shouldn't the index be unsigned int here ?

-- 
viresh

