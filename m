Return-Path: <linux-pm+bounces-27633-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F8DAC3948
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 07:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F9613AF6FD
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 05:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD421A9B3D;
	Mon, 26 May 2025 05:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dOlSzZq3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB9018859B
	for <linux-pm@vger.kernel.org>; Mon, 26 May 2025 05:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748237714; cv=none; b=Jnz2IxWDJHSrWVsrza6XWjxex/RO77lG6/1Lt2IYy75uPVJA6AybT9vb6k1KxkLN65MdRPXUOtwTjm8YxUZwNha1dGeoJIfUjVPERgE9WYrZgoI5y2syzJIxuOb0XR1i/aYDJPtTq60vPcTLq9L5vFwAbtLzL7dONYlUuJw4RWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748237714; c=relaxed/simple;
	bh=H0+WhDUcNKkbGapBRoI0Xxxi+jWr2MzxiA0ug1aiUiM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ASVFIpPo3fmhfbrCAcGK50k0B/cwFqrV8vNNVEuhV/dYCrBlZcFblkNcikZm25O+N2Lx3u+ha5e7rxQUgG/a3Pw3T/3QFKSgAbJHZKmo9Lwg7ZVdqEI4NerobPLG5UlnTxyh5Ef8iYPhBxpuT9TV2phv6NLVf5T68yQAWfxLMTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dOlSzZq3; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-23229fdaff4so19941405ad.1
        for <linux-pm@vger.kernel.org>; Sun, 25 May 2025 22:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748237712; x=1748842512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VH2/AcvAgBKUfR7WHrs8FnBZffSGIY59wg2ntym2dZI=;
        b=dOlSzZq3hwMwfxcS4vK7JCsoIEFtMaC5xlwjmCzP705P/Ps27K4TUvSjAQAZbFpFQd
         1kaSo/4yDCwp58JTe4SsPeJaKPYabWj1LPU/cv9Aal3u7zKWIEb2NfRrNEHzRPD46nrr
         4CJq4RDQUKgXgbb6uv0o59dSa8wMKQKJAd72E1Lpjk9yioAiteOkosKYeDa7ujuRmUYs
         mfeV9EAF1m3HCBixbI3ELpyxfzSKS9KXEOx9qEn1DU4pKdxaO7yybZihAy/TjOrEP2r8
         TgoVtCgM4hcDNTG1gGOWDmdaJEfZVJsOXUmxyF+Bdp/6RXQ5fDb8kuYXiqhfZjkqDlTP
         bjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748237712; x=1748842512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VH2/AcvAgBKUfR7WHrs8FnBZffSGIY59wg2ntym2dZI=;
        b=LXIH5Vk5xpsEF1WT4aULXO0piVmpbpPb4nSXs3L6EFskCUs3apDd/QEssDJWa9IguK
         LtHZhP6EcKKraCrBFV8t7UTtHVg7zUp3mREaKAaXTiIE7TZX6HV16cNmf7O0O6ugG/JS
         UMnjPsOw9CXe0/AJiEOL02xAQl+NAlgc1R6yPcFsTuAMsxOBw03kWj7tyb7kdQSHtPuK
         /OZPF30efKn2+rwlxvXD9n/oKmdSA77LKtgfXFi+lzoX8aW4PMMP12tZvi9TUjtmpTD/
         m7NKn4rGGuGN/ATnOQW1lhqf+UXVGSdybc7uRKop6ZxqQylqbFc4xmk4zEIbMRz3rrMy
         CPtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVECkj2hkIAGr50bJnndBciDjy6ji64R1KgFbECDP8kjQvr7bI6xP95cO0R5FL8SF06vI6ILRa29w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbmGjGwWRz9WUcLFiPm/myRIJxWdJXgGZEavADXaeamhn4Nyj4
	EChaanN3nX8k3/R/+mwIqV2u3VTbJS4q/bN3IGwt9u3OltrzF1hktTt4osOoNSPHxlY=
X-Gm-Gg: ASbGncv3f7GFSGL6cH8TNDaFwOfVYb+fkf0bCWk8h4Zl+1mFDmWrhjhHmGG1BChhXbv
	UrwuYUINMw7tw22Tfos/svzAribp0AbtPQNHLsF5/7L9CMC8UNtEbDBNElzPBVSU0O20Dew/yNI
	Jcuf1hLLyowgN6nsesk0AEllWQ2bnFSF9R1tjTuaWuDyIkZK3GrCMqlL+FzQDvlwuld7VDGfvhL
	Kgca5iloaWv1B8WeJN1+onCfshbVfmDTBrzIcyuuiOOq0MT2139D86vJTNsd0q5fcoXInILGn44
	/fMPXGbjkZ70cmsHnvd/Dnjf5oQMjq24l7hRD/BeEQeE7j5gcZQkKpo2dxjt+1g=
X-Google-Smtp-Source: AGHT+IHinl9wFGIz/jsNy+zLrUyY4TiHvUrwrDfwtmojE3cGhsYguIkcm+poR2ISccO1zd74L+WiNw==
X-Received: by 2002:a17:903:2b0e:b0:231:f9e3:188c with SMTP id d9443c01a7336-23414fe83cemr113628515ad.52.1748237712047;
        Sun, 25 May 2025 22:35:12 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-310f8faa31bsm4620782a91.19.2025.05.25.22.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 22:35:11 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	kernel test robot <lkp@intel.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rust: opp: Make the doctest example depend on CONFIG_OF
Date: Mon, 26 May 2025 11:05:03 +0530
Message-Id: <a80bfedcb4d94531dc27d3b48062db5042078e88.1748237646.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The doctest example uses a function only available for CONFIG_OF and so
the build with doc tests fails when it isn't enabled.

  error[E0599]: no function or associated item named `from_of_cpumask`
  found for struct `rust_doctest_kernel_alloc_kbox_rs_4::kernel::opp::Table`
  in the current scope

Fix this by making the doctest depend on CONFIG_OF.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202505260856.ZQWHW2xT-lkp@intel.com/
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Rafael,

Please apply this directly, if no one objects to it. Thanks.

 rust/kernel/opp.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
index 212555dacd45..c2bdc11f3999 100644
--- a/rust/kernel/opp.rs
+++ b/rust/kernel/opp.rs
@@ -582,6 +582,7 @@ extern "C" fn config_regulators(
 /// use kernel::opp::Table;
 /// use kernel::types::ARef;
 ///
+/// #[cfg(CONFIG_OF)]
 /// fn get_table(dev: &ARef<Device>, mask: &mut Cpumask, freq: Hertz) -> Result<Table> {
 ///     let mut opp_table = Table::from_of_cpumask(dev, mask)?;
 ///
-- 
2.31.1.272.g89b43f80a514


