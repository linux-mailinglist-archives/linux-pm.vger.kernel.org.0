Return-Path: <linux-pm+bounces-26732-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAF4AAC11A
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 12:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40B5050311B
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 10:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1BD27816A;
	Tue,  6 May 2025 10:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CY6oH42E"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EA5277036;
	Tue,  6 May 2025 10:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746526512; cv=none; b=qDvxu9CCcoHXg5kpTnWeZRBr24W4YLavDeWKTqklc+2IVs1RQM9m85khE4+I08xFRUwmsguXQcCZSLENUJtkSpWycByr6pNJD+LA7TGe0D78M+Ujmh2UMmZ3wuxWtWNWlE9KlOn1VoxPF5X7mlvxRkFJKicHDljiHANl6DzpnUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746526512; c=relaxed/simple;
	bh=H3fLQxygZC6XKdNmeZEZ2FzeMvkZHRYPXqX08psAQ6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N4l5A2vPQU2mVg6LWyQxH/3HOvfnvhu3bc1bzBAkNKREZuUQEJQsqgNZ8HDVG5W7GUtZL8teCWnbRIA8F2oeTll1Z30RFP5j/ZrIoFmd4K+CPVQHTAt6LQCgFHQ8Y8Su9SzTpsBnQh7MF9bW49irGpqw4fLRkZTtrY8LJzZB0JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CY6oH42E; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-40337dd3847so2996774b6e.0;
        Tue, 06 May 2025 03:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746526508; x=1747131308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xKR53B3qPFijXew46vboZyZL5TEINx3Tkrkttdk5rDA=;
        b=CY6oH42E+cITuANaDNBxhcIp6x0aB9LX9HvhOf2zCx/nIKrLwMQIMGUWew89Cmn2T3
         hYK/OpK/fZgadoX0d4m+fGGb71oFv4q/SNOT/cqCTrOGYmvIAkIa+Qrsi3CKV5CBz8rR
         1mwCP9iqcyTMKvz9h0KaPuohQ3K5qurTvJR35/e750VHpC2x55vEMFFOkhLl8hTTymUt
         rGjBdk242WCwkc5HS7EdEJmWOU18MNlZKMSAAajV4Pgw77NXp7D0I2F15/IJNQfPJQ7E
         IHSpof3Ot+LkErh8Y10v1IxmzOAxGEqMwLDuEo44FrH0dEewEPjMTSG3MxNL5ze0JD6a
         jRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746526508; x=1747131308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xKR53B3qPFijXew46vboZyZL5TEINx3Tkrkttdk5rDA=;
        b=kOUS2XQCT0helJ5Omwl9xbu4xgQCOtVvsEzSYsFvDZUwESd9vKj1Quqh6Hpxv8DQoa
         4AefvFjCor10dYmke9SdJQ2K41XfZLMuW1UrqjofVZzJ0KYBxIjwnUagu5CZAv1WjpXy
         Kf+azi1Ayzdu3mCIek51eJyZFaZXKYQLI0H4JrATl5e+LJsUHu09yinJ0YpRvX8m9uD1
         h2r7vVA7xnJIKf+2RPthNnPLpb2ROa2RKhediaZdPhmr9QCdKLaVlqoZiUJhdlVYmb7U
         S8DrRZoOl4PIJ3tz7EVUjJ9XPMAVJZRTqmXGFTmsPNR9t+42NAtCH4dJDHOhEwEFHGAb
         nzeg==
X-Forwarded-Encrypted: i=1; AJvYcCU88Ic4rrMDiesPPdufJgMEA5tKsDgFQ1LxPMa4AQmw9qHzqc7PfLg7f9SavObtWYRY4ZvMA+aeX8Y=@vger.kernel.org, AJvYcCVfI5aFptHrDF/EX6VCoOo1pObYRsWLCwqUDCWGwkBt65IqtV1ln1rDCpS8qSfJTER1xuNPUrh7knXZKZGn@vger.kernel.org, AJvYcCVrXxvlf7WrLlnIg0yklX1TZQY2dceNDbFxaf3Qr9kgo5rpCVHJIbvimyKjt5rowiOsNGjNXCV5kOA=@vger.kernel.org, AJvYcCXIszgkY4l/dUX01NSnUDeUMDgFsotMMtJDzXc1jLh7GDupoWPmCOwUjdFSjYXztJ8KqpkB1n6Woy5liv7zcCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrbh+Jn73X5hiZ8WiWdMQl1PcaqcLZiFI+2CMzgN+02wpr8OKp
	9o0cFZp+w1uo1AECeHW1j+Apz1DRzGdkGSHETsqPEnUwoMM3D8nW
X-Gm-Gg: ASbGnctUJVUzmm+F225uwsO3dRUBsINAyOdDxw6m41PrDrvaT5BNi4JmolQDsnUDsYX
	Xxz3Bo5cHHtrpSDEeAcvmzaWl13H/1b9cAbT7DQRGDtOIi7PixUg+7EMHW0MRFR5Uyc6xZsYCY/
	YKs3gjYGCXXbX9sZvDo0s6wUar9Y9e0avfM5mAZo0fwDMqLFdBY+eNaeDMesYNX2iZMMgNLYbE/
	TnG0/tiL+jC+5VdvtQyl70VPJb79KSewbEd758/MvfQQeXZvbNo1b1SEpjh+DyNFzzTCX4GKcSX
	noy862e42bu15QSkQ8LfLrCUeThCvzn9ywWXqYOfRW+PAwB9pT7VWjy12FNom14ZCKgESceJIOv
	er9lTPmpCZGKtKQd7Xc2KM10=
X-Google-Smtp-Source: AGHT+IHE8caFW7rhcABhjbpxTvjrWJ3oASf6F/4xoBjVlsPODe2HL2MtdDc5iad7lX+dv3sdRNkD1g==
X-Received: by 2002:a05:6808:3008:b0:3f9:36ec:dab3 with SMTP id 5614622812f47-40368ca72d7mr1345277b6e.14.1746526508421;
        Tue, 06 May 2025 03:15:08 -0700 (PDT)
Received: from my-computer.lan (c-73-76-29-249.hsd1.tx.comcast.net. [73.76.29.249])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-4033dae726dsm2390904b6e.30.2025.05.06.03.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 03:15:07 -0700 (PDT)
From: Andrew Ballance <andrewjballance@gmail.com>
To: viresh.kumar@linaro.org
Cc: a.hindborg@kernel.org,
	alex.bennee@linaro.org,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	anisse@astier.eu,
	benno.lossin@proton.me,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	bqe@google.com,
	dakr@kernel.org,
	dakr@redhat.com,
	daniel.almeida@collabora.com,
	gary@garyguo.net,
	joakim.bech@linaro.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux@armlinux.org.uk,
	linux@rasmusvillemoes.dk,
	manos.pitsidianakis@linaro.org,
	miguel.ojeda.sandonis@gmail.com,
	mturquette@baylibre.com,
	nm@ti.com,
	ojeda@kernel.org,
	peterz@infradead.org,
	rafael@kernel.org,
	robh@kernel.org,
	rust-for-linux@vger.kernel.org,
	sboyd@kernel.org,
	tglx@linutronix.de,
	tmgross@umich.edu,
	vincent.guittot@linaro.org,
	vireshk@kernel.org,
	yury.norov@gmail.com
Subject: Re: [PATCH V11 00/15] Rust abstractions for clk, cpumask, cpufreq, OPP
Date: Tue,  6 May 2025 05:13:11 -0500
Message-ID: <20250506101311.142475-1-andrewjballance@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502070109.inpes2ou3rxx2fxp@vireshk-i7>
References: <20250502070109.inpes2ou3rxx2fxp@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, May 02, 2025 at 12:31:09PM +0530, Viresh Kumar wrote:
> Applied to the cpufreq tree few days back and is now included in
> linux-next:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/log/?h=cpufreq/arm/linux-next
> 
> Will send it for v6.16-rc1 (unless there are any objections).
> 
> -- 
> viresh

Hi,

I have tried building the latest linux-next and I think that this
patch series causes a build error with the defconfig for x86_64.

commit: 407f60a151df3c44397e5afc0111eb9b026c38d3

steps to reproduce:
    make LLVM=1 defconfig
    make LLVM=1 rust.config
    make LLVM=1

build error message:
    error[E0432]: unresolved import `crate::clk`
      --> rust/kernel/cpufreq.rs:12:5
       |
    12 |     clk::{Clk, Hertz},
       |     ^^^ could not find `clk` in the crate root
       |
    note: found an item that was configured out
      --> rust/kernel/lib.rs:48:9
       |
    48 | pub mod clk;
       |         ^^^
    note: the item is gated here
      --> rust/kernel/lib.rs:47:1
       |
    47 | #[cfg(CONFIG_COMMON_CLK)]
       | ^^^^^^^^^^^^^^^^^^^^^^^^^

    error: aborting due to 1 previous error

it looks like this occurs when CONFIG_COMMON_CLK=n and CONFIG_CPU_FREQ=y.

Best regards,
Andrew Ballance

