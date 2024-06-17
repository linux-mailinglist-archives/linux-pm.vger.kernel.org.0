Return-Path: <linux-pm+bounces-9308-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 842CD90AAC7
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 12:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB49FB27DA0
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 09:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AEC191481;
	Mon, 17 Jun 2024 09:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QMmixxYJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4ECF190691
	for <linux-pm@vger.kernel.org>; Mon, 17 Jun 2024 09:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718616187; cv=none; b=DJlFKrBFcw2K7YudMBdt+rph6RuJynPe+7ppNzxkmKPlnRMV3ceyYh23b0UoM23vo28p9u/7LYa8d8l5UfrKHna0RFXc0xxSunD/99qGpORLF7pOJZRpR9yEQklqDYlOVB2FeN+f6/RPiVWsDj+SBsKFzEgnPAMS/WkxNYDKqbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718616187; c=relaxed/simple;
	bh=PJorj6pZybZCRAmgMBh4ooMcrMxupHMGQPqA/q11VUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=qt12w4omfHM7kvqgTcm5Gl8qXB6mEXQiV6UxQtdRWbL/eVj0lbJb+1L5NdieBzzhRzGBLfSzE52TEnr0dHmIUYqifMbSXU0vB2PbO3d9t0Sw1apbxZ1KPtAQs1+zq/iJoC2fBP6lNJKbaaxBRRvjTFbZWr0vXm1VMaE76GHDj04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QMmixxYJ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-421cd1e5f93so29046545e9.0
        for <linux-pm@vger.kernel.org>; Mon, 17 Jun 2024 02:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718616184; x=1719220984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PJorj6pZybZCRAmgMBh4ooMcrMxupHMGQPqA/q11VUA=;
        b=QMmixxYJV02w5jGsjaYPK8uw8ATgnsghF9FuhA/pR5z6LSPx5Yp0VH+XA7Ectd+eWI
         MYKVqZSeQwyHb9Oi64Tzm/kpOOg4wtky1ErU0NQXazVuquhtDbjgh2H3JqTfrWci6yMM
         xCNYkvY4zV/kROI8cJ9fVSfB5Q08v0NaBPNH/ekl8hrHepZH8VxYw7qNhiOMRQ9MYIqP
         z2VmWnV8bR5t07hU0AGVC13eCgbSD+ZFWmgKzHOcecE1Waw1chVScOiZBsaHxfqE3L/y
         Nhib8sTqPx+K2SODDlpEtqjKO974pznUsspuKiixZLSZICSQWVBMKCG1SsUjt5mYXPVh
         skgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718616184; x=1719220984;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :references:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PJorj6pZybZCRAmgMBh4ooMcrMxupHMGQPqA/q11VUA=;
        b=DWhH9IN3GJElM7U5mPeiB8t7qT//QAdQh4TPfgRiQ+nH/dPR7rlf+o0h69BFRgGGHd
         k5I05beAV9a7P3wdJImZ1+MZIHSO8F8NdqI7Ti8D9Y/Uw4T03jp3JzlmzIBRC8E/bS3D
         kIDa+uoK1FI7sxDiTjQWmUb2ZnE0s7QXYoGFVff14wS/uNH3rr61hy02lTXUvLY3wbCG
         kaBU10Suy5FnnSTokT+Odp3u7H+OOm41ctF+OHa0oVr3ugBS6WrMbxKRaNuyszRvUkLH
         KeJkcPj7YQUCo9/0vKrsMMqXTL2A50XmaWGC/GW3pyz9m691zdQPENrQsjfytI3axZR6
         tayg==
X-Forwarded-Encrypted: i=1; AJvYcCX3KTyygcmzG116EQAZyvJ9sTAmu13h35zZTeW1WkAE/6FgR23GISveCtO3h0kd+qpaCKSQuuoLwL9LTAKeT/9mG/DoT86+ZQI=
X-Gm-Message-State: AOJu0Yzt5sfmH6vKaxTKvVIwUiN1Af63lZKHhprE9A4YjtD06ZhDnJVJ
	NC/cAGC2b4dRuA1r8AC7hXXXi6b0gxEp/MfmqJR6Ik/bKld7Yu6hS6nPt7RyLCs=
X-Google-Smtp-Source: AGHT+IFfL3Bs1KrLYPlq1k0cwv3eyK8lsf0inS3DFHb4TVzuMMGvXRsZ3JYsj7XJdNFeaX26ROtE2A==
X-Received: by 2002:a05:600c:1d1b:b0:421:65a4:2936 with SMTP id 5b1f17b1804b1-423048240b6mr85210755e9.12.1718616184294;
        Mon, 17 Jun 2024 02:23:04 -0700 (PDT)
Received: from meli-email.org (adsl-33.109.242.225.tellas.gr. [109.242.225.33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422869d4f2esm192148015e9.0.2024.06.17.02.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 02:23:04 -0700 (PDT)
Date: Mon, 17 Jun 2024 12:02:57 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>, rust-for-linux@vger.kernel.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Erik Schilling <erik.schilling@linaro.org>, Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>, Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, Bj=?UTF-8?B?w7Y=?= rn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>
Subject: Re: [RFC PATCH V2 3/8] rust: Extend OPP bindings for the configuration options
User-Agent: meli 0.8.6
References: <cover.1717750631.git.viresh.kumar@linaro.org> <37bdd7ee7b74292830dd9977154b08ebcf08a138.1717750631.git.viresh.kumar@linaro.org>
In-Reply-To: <37bdd7ee7b74292830dd9977154b08ebcf08a138.1717750631.git.viresh.kumar@linaro.org>
Message-ID: <f7wqe.d5i9jcj6qgw@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed

On Fri, 07 Jun 2024 12:12, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>This extends OPP bindings with the bindings for the OPP core
>configuration options.
>
>Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>---
> rust/kernel/opp.rs | 305 ++++++++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 303 insertions(+), 2 deletions(-)
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

