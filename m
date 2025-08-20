Return-Path: <linux-pm+bounces-32671-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09706B2D2E1
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 06:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E93D22A7D43
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 04:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A332824503B;
	Wed, 20 Aug 2025 04:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qJ/cKPFg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862D9235BEE
	for <linux-pm@vger.kernel.org>; Wed, 20 Aug 2025 04:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755662936; cv=none; b=hmUTQERd7faGlu3yyPRaUf0/US7PQ9MeVysxKAIjpH8UXOB7lya/AlLVjft/NdypQn5MCT3B+09jC5R0eo1n4Aka05aUF8auBx/DZIMUG40TfVLCS+yewm2aett3OA3kpKSNwLd7v/utgv0hkrtK+HOjN/wbbCyMmj0pzTpuYkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755662936; c=relaxed/simple;
	bh=cZveZFpGt+kr4tv2eYJJ27WLY1j1jY8DTi+7Kle+qvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFTZH4Hp8jGpMfDPrZs4nRcl0xsNSnE09lr7/wQbh0shHLkc2OP4lQkWztkGLTYkG21xxCg1B340EPZm+Dlw6brSB2FRIrhtJV6Z4E2VebtINouaBdkO8CeV3uM5pOQzAj4h52nJqfWs5Qs8jzxTCSqgbGfLKoQ48jX0qXqB5n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qJ/cKPFg; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e39ec6f52so6022977b3a.1
        for <linux-pm@vger.kernel.org>; Tue, 19 Aug 2025 21:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755662934; x=1756267734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cPsQnvqMxASRCLEED9v2AlwRctOJ3ys4veuU6QCCD08=;
        b=qJ/cKPFgpAXS9ZiWLtrN8INgphQIH1VdvCzxui+0j0qRopuKCQf0gD4ZLRUNjm5CK3
         vfnOKvdn1YA90LV6pvFOmlukMkTxL30aFW1AR1nlS7NQ6+MQp6TC0kiJdKjO8NL3PfTd
         wDFCuqhLZTHeMQsJ0DUMjte9QC0CbCR7id0nmy7xNxQGYmUCdbcfE/N+fcptAswBy1qO
         NDK6BlyTS7BQdSoUA2eEXgAd4ruL18R4eQX8/DPHxopJWjJbIlq/40z5BcWuiWYyC3UA
         wZBInK8ovPjghbp2rrlBgWmtULMjD2uTBVgRffjd/5erKnLcLobXQftI5mtcrknICdPZ
         sypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755662934; x=1756267734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPsQnvqMxASRCLEED9v2AlwRctOJ3ys4veuU6QCCD08=;
        b=eR7eTyO/sVxeK0XtJwet+wG2T9mkatPqYq3estmFrlKTXLQzQ6aY7fdXAYRfB6JCGK
         jor+Wc1X8K/oo49p6m/z3DMqCXHE9+665B4o21k3WQ24SJzLTPlnyiFJnU75xzqKY/ZW
         RtLY9/oole96A8ADZQ0+RmR1YFMQeJkY3yqg1Viv8l3nf1skng9dsm0R7V73IMnbwvL3
         SV+IB0IkGh6BqYUmYJHm30RITqcheGPIAb663xo8vvJjzlDONRVO8oCxKnlu3cK/iccu
         LKHR8FTydD+RdG0iwhThGK7iL1fL4Taym2vt4xNvRGNdlrWb0mGPUVOxQ66l7gs4vyeu
         NY/w==
X-Forwarded-Encrypted: i=1; AJvYcCUrBrEUuxuQyUMEcUEEcB8NHHFh2HOQ0xQDgcTKZtcXu5DVCT5DG1TAmSMPzN2PeLskZ/xd/8jU0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPV9uYVMDUO+lbEguuS6BsBjzyMhb48wJOdsQhNliuJLwSdsVo
	LuUbd5b2elpEQEEioB0G0aGlt371hQgk+yyINGjgX6itrr0l84hZ9Y1MBAVZALUawy8=
X-Gm-Gg: ASbGncvTVNgN7q8RM1lrq4FLw7p1c/5jm47/4ziWJxnOQNjiym8UPGFSH71h5SiuoX2
	vwjvUXhMISPImh4c6PgW9AFyHAJtDQQ85JwyjMlm1wNclybzSfbWDupjnYBefeUC4Jeo6X0Kot3
	34dDeEbfbzwPtRwDMFuS0tg2gebM0DC6J2FHwNS8l6KTUakG8SSvoDq2FOVQYJF00EKyyiM622x
	6YtPVRjJIn7H8syDXKUeOLBSaQyN2nOPJ36h4lmYrWuDVzj9uEsQs+v8SjaBu1fCBVbD3uWJRCt
	cddRjjFRMmOthP7X2cFs9jYC17H7eHaCchfJOTFZZ3r6ATndHyd0qAQ4HXU1CWE+CQiMxsfV5wW
	+KypsB9lUOMVuQ7seoz+J8o0u
X-Google-Smtp-Source: AGHT+IFu5A5bISXV8FB/K461gR7zbA9roHVXBQ8EWpE6xiSbYT5Vb03ik3iZvJ80WNqy9YA5A69QJg==
X-Received: by 2002:a05:6a00:3e0f:b0:76b:ef0e:4912 with SMTP id d2e1a72fcca58-76e8dd0a9b6mr1753204b3a.20.1755662933893;
        Tue, 19 Aug 2025 21:08:53 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e82d18cecsm3264977b3a.95.2025.08.19.21.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 21:08:53 -0700 (PDT)
Date: Wed, 20 Aug 2025 09:38:51 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shankari Anand <shankari.ak0208@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: opp: update ARef and AlwaysRefCounted imports
 from sync::aref
Message-ID: <20250820040851.nn3ysfyurc4ukqg3@vireshk-i7>
References: <20250815174521.1413560-1-shankari.ak0208@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815174521.1413560-1-shankari.ak0208@gmail.com>

On 15-08-25, 23:15, Shankari Anand wrote:
> Update call sites in `opp.rs` to import ARef and
> AlwaysRefCounted from sync::aref instead of types.
> 
> This aligns with the ongoing effort to move ARef and
> AlwaysRefCounted to sync.
> 
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1173
> Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>

Applied. Thanks.

-- 
viresh

