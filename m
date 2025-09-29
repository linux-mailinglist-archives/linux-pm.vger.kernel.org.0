Return-Path: <linux-pm+bounces-35550-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B392ABA8F5C
	for <lists+linux-pm@lfdr.de>; Mon, 29 Sep 2025 13:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 162571C0B0B
	for <lists+linux-pm@lfdr.de>; Mon, 29 Sep 2025 11:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935362FFDE2;
	Mon, 29 Sep 2025 11:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hTA98byZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CC92FF652
	for <linux-pm@vger.kernel.org>; Mon, 29 Sep 2025 11:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759143759; cv=none; b=K5HXWPGim0XEy+DKO9SJVLQpjJKkedvjdPtIpNxRPYYXRM4rSWf7nPJbuQtls+CHS/0RxTqI8WegwYYFXSKHZwemY8DdKIax8RVvGTwxKfz3YijC9PuEGIxdP5mn0YOy5eGNA04qoR2ur8LHZA8MD54lj5SxaCdyhWz0mcaZsQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759143759; c=relaxed/simple;
	bh=GCP8LuYtl1jmZq2NZKQmVEw9gQOGAcyHtezJJOCLTAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smdODoCCcv1DM92v/s3VS8eHR7PaSxTcl6ECM5IRESDEMn3xbcCThGR2DKTpFyYbeKcA+0demczCNGKwGrFLf+73d23bCQ3YF50y9s0bvx4Z1MxsemNjGyr2b/FeBbcGNzw5oFgW7bAoVxRFlI3jVhSMwVEIZedModXCBllmXhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hTA98byZ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-267facf9b58so32953805ad.2
        for <linux-pm@vger.kernel.org>; Mon, 29 Sep 2025 04:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759143757; x=1759748557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ArXlIKa0bCAPRpe0CickijlhXS7XHZf7jcmbVv++sWo=;
        b=hTA98byZ22UWb35+btzTO/cP7WX2yWJUQJdqVXOaWI4yfwh3itcySFQZORmWu5BZEE
         mIxzN4NcF2TJHkFs+aXwMBacELqodzwOXFW0UnPLbwl8PFOgZ5RZL9AgUXYh5hEHNPK4
         wY59vZxyerFGgBN9zDbFitnnK0t4Z55jo+9Ou0nIOpr5JeFMa0mvlNFsewyqC8gN6Aht
         xPKlL+u/pkGOtNm4v56I5dYtJkgBxFemFBrR22bJzFF1m0aJ0MqPGZV+g/DKCpdVQGZB
         p7oNzAfJEFMXYzNEy5uoipsB8cjB+0rJIUBtDASZLEHeByK1kGoD3ct6HqwpfH0GQhDa
         gaAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759143757; x=1759748557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ArXlIKa0bCAPRpe0CickijlhXS7XHZf7jcmbVv++sWo=;
        b=cYgcs4itAkDBpxS5Hh46H3mXljTq8jcBgrv7KHoAofjlQV9M8BhrEcx2aTUYozZXQ0
         21S9TLQztKf2DFv47btsOMYs7IKyX4rlnQgpb3skgk7umUVzGMgwJfoJbKKoonluLBG6
         Q8E2is4dqHescuLyPOn89s1Dwqox5g44ve16e0gHYp4j0IcHYG0eH4ALx4GV6Yr6wyyj
         o2t68v1WolEXyOwM98zrZZ5rCS6hV9VhYeFot/RKrsEfHXfZXaK22vwYTh4/C/IaL6fB
         BVJhDB8vC8InulE95/pp53VZTiReUyMDoHxhkkeBoOvH+/nP7upWGpO7dUUR41ex+fMz
         eScA==
X-Forwarded-Encrypted: i=1; AJvYcCXXkUeq8HQV8Ab84oB1GMDEDidPUS95QI8xfmM2PczsQjPmTuXSJnsGyrx0lFOmyZCSJKL6qPdxvw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb0O+iD03Qp7zS8oTFlOQC7lj/UuTCXaY61XHmwqHvQRtvihrd
	TmlXKC+GQlpkJziAeWaQcekraLQWUBdWWrUaq86zYCJmYjGPgKWS2NVJRnHjVUscNuA=
X-Gm-Gg: ASbGncv9cCAgYFbcqIOYKlyh2H2KZrgPWX+m4JuPXmW193hllYMNNVwBMb27BTDw1oN
	cnaF4ZiUjSOVu02YZJKsdbD7iLMpbfcgUz1oCmw4wS7hu6O63AI+ImHx+ZMHs4/v0DA++Wq5IFR
	RBcTsq/Gxi1Jno4x7TzKxllEmPQfafFkSamCx5dbt0YueimJbDO8e69OZAlX3xdeywy0AL0WFOJ
	p4sUFxXUalR5CuUSclG5avM+e7ocMEDfU8VK5q3IuKsE124yFxjqKCIrK3bmj8mANuh2pnzmhF3
	oTcAtwqB6sYJbBt/2y4/9N14FhVEVAeVNFpXgaRB6Y8oufrZQKnqBw4qZdH/gITvmmkeBR79r+4
	qRToW9S2Vo8n5/FcarBLsRLTz
X-Google-Smtp-Source: AGHT+IFJ8tBd5DbfKm01y+6YhQUicmi46JD7jPOYKxXSxgRsT1oHLX0ubEnEv3SeXFYfJc1oZPUmzA==
X-Received: by 2002:a17:902:c409:b0:269:96db:939 with SMTP id d9443c01a7336-27ed4af3882mr193698795ad.58.1759143757073;
        Mon, 29 Sep 2025 04:02:37 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6ac274csm124914185ad.134.2025.09.29.04.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 04:02:36 -0700 (PDT)
Date: Mon, 29 Sep 2025 16:32:34 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust: cpufreq: streamline find_supply_names
Message-ID: <20250929110234.ukgwsnxyrvsimhst@vireshk-i7>
References: <20250915135954.2329723-2-thorsten.blum@linux.dev>
 <CAH5fLgg0_NBtfVMNBwXOe4BpyUKz_S=v0CiDxyKNYZcS9j7WHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH5fLgg0_NBtfVMNBwXOe4BpyUKz_S=v0CiDxyKNYZcS9j7WHw@mail.gmail.com>

On 29-09-25, 11:38, Alice Ryhl wrote:
> This is a pre-existing issue, but ... this treats allocation failure
> and non-existence the same way. That sounds wrong.

What about this over the current patch:

diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt.rs
index 224d063c7cec..e509b46b64c7 100644
--- a/drivers/cpufreq/rcpufreq_dt.rs
+++ b/drivers/cpufreq/rcpufreq_dt.rs
@@ -26,13 +26,17 @@ fn find_supply_name_exact(dev: &Device, name: &str) -> Option<CString> {
 }

 /// Finds supply name for the CPU from DT.
-fn find_supply_names(dev: &Device, cpu: cpu::CpuId) -> Option<KVec<CString>> {
+fn find_supply_names(dev: &Device, cpu: cpu::CpuId) -> Result<Option<KVec<CString>>> {
     // Try "cpu0" for older DTs, fallback to "cpu".
-    (cpu.as_u32() == 0)
+    let name = (cpu.as_u32() == 0)
         .then(|| find_supply_name_exact(dev, "cpu0"))
         .flatten()
-        .or_else(|| find_supply_name_exact(dev, "cpu"))
-        .and_then(|name| kernel::kvec![name].ok())
+        .or_else(|| find_supply_name_exact(dev, "cpu"));
+
+    Ok(match name {
+        None => None,
+        Some(n) => Some(kernel::kvec![n]?),
+    })
 }

 /// Represents the cpufreq dt device.
@@ -68,7 +72,7 @@ fn init(policy: &mut cpufreq::Policy) -> Result<Self::PData> {

         mask.set(cpu);

-        let token = find_supply_names(dev, cpu)
+        let token = find_supply_names(dev, cpu)?
             .map(|names| {
                 opp::Config::<Self>::new()
                     .set_regulator_names(names)?

-- 
viresh

