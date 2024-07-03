Return-Path: <linux-pm+bounces-10485-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2E792549F
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 09:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D2401F244DE
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 07:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4C513213B;
	Wed,  3 Jul 2024 07:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MBUtLZ/x"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E334502F
	for <linux-pm@vger.kernel.org>; Wed,  3 Jul 2024 07:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719991846; cv=none; b=gyKO8QdPRhzpzga6TXPaMI9PHpRkoXOyPOpmmqbc3rqKhRITVFo2vLercA5Eu2tpbdSwOBMLZYSkgxX5nuFS7E59Xir+rQlt67riNdNCnFFSTFFCGWEzwxbBHn05xL0gjz6KuJbiFJu6ICTJQfq/kssK5mVSbk6jU+F0Ix9yqpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719991846; c=relaxed/simple;
	bh=oZYcvFZ7As80ohieZdjCQTQp3MfgLDla5R2j6Hq+kf4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hUj3wLZCeWNqSR+Xxdij3Dea68zCXs2gb0cMWvYHqHtwYquDEHu4JWHqehhfxSZBxOZY/KMV9HVXCPbu3b/tXTBIJ2A466YuRe7Dut5mNI5xQKhAqbzIa/50z4h89oQAWyJhd0K90BD8YrD/s/MLDaD/MkmxIGILhf8KeVwpOVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MBUtLZ/x; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3d5666a4860so2886423b6e.2
        for <linux-pm@vger.kernel.org>; Wed, 03 Jul 2024 00:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719991843; x=1720596643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MZIEVlk+UkNAqnX2wpUNniG3hQvOJEhSruLUcJglBqY=;
        b=MBUtLZ/xn9HYmMKgFT4tes9cJbuhMugaG5r2uH+0DrxbiG9jgIo9B4cjn2yvwtSyVO
         2XnVH+flNX1LVYzIknmUsHos6ejdq5zE3M1IpBzit1NxgSxkLF173tkkWXJD7EVwpGhC
         Bg0z9sXbZf/yQew8nQwEpN4+8dPMFZ+3A94E6RPp8EpAEl42y5Xt97BysGj+aw5DiMHE
         P3sT5Q3WunV/y1/tr/UAwR0/OUk9Mc0QNSCh/oIf9iHzPGErZEFWhyXyB4fxai436wbE
         fS5ufh3xRsJnT6CTMkZZ4YnaHbmojtyMMBZphZvV7sK5XiwRO32xjJYlR7f6aKknYkyB
         ss1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719991843; x=1720596643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MZIEVlk+UkNAqnX2wpUNniG3hQvOJEhSruLUcJglBqY=;
        b=MXzChXdQJ1ADEWewucqbAv6bOgJ2ITY5KsdE80c69afqK+q6NIOCnoU1XsGw406KzQ
         CUR5YD5tZK1qer4agY1/IaHXo1EmDclNHshjX+NqrrW3zVIfnvr9TCgxc4N043QvAtiu
         9yx9bkNbVHGghs7zozkDCObNzwEFHiGVeIQvTJUkYJfw/H31+2IgTk6anImqBZbwJTLN
         KsU09Lq9pe733x++li7alIqXn8/r7D9aNwjj4WRtIt9XUpEyIxa+yL96PT6HjkqZrhLO
         8ulIyFMZX/1l+Ojm4S3cQ+PUJRhqz5udSnNZex1f6lSEWihKODd5Aux6O0yhT1UWgmIE
         jJmA==
X-Gm-Message-State: AOJu0YzWUhm4ydYAJh8SbALrmO0OB7TdB9vF/+ApYMHoUFlArrWVkcGT
	LRGrYPfJ/FP5H1N/5ez/1UAVf+1JFVIlJ7hdzB6LFZa3z/jJsds6LbXYR1WRpew=
X-Google-Smtp-Source: AGHT+IEJLAIWsUinHPjVKyb8d+XMIc7IndPbH5xlUDWwh8Z4IkshorjmgwkDUcVsSqsOAzPzpTQ9sg==
X-Received: by 2002:a05:6808:1823:b0:3d6:2f50:5517 with SMTP id 5614622812f47-3d6b2b24e68mr14703941b6e.1.1719991842923;
        Wed, 03 Jul 2024 00:30:42 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708044b0b61sm10057686b3a.176.2024.07.03.00.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 00:30:42 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Benno Lossin <benno.lossin@proton.me>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	Miguel Ojeda <ojeda@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH V3 0/8] Rust bindings for cpufreq and OPP core + sample driver
Date: Wed,  3 Jul 2024 12:44:25 +0530
Message-Id: <cover.1719990273.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This RFC adds initial rust bindings for two subsystems, cpufreq and operating
performance points (OPP). The bindings are provided for most of the interface
these subsystems expose.

This series also provides a sample cpufreq driver rcpufreq-dt, which is a
duplicate of the merged cpufreq-dt driver (A generic platform agnostic device
tree based cpufreq driver) used on most of the ARM platforms.

This is tested with the help of QEMU for now and frequency transitions, various
configurations, driver binding/unbinding work as expected. No performance
measurement is done with this.

These patches (along with few other dependencies) are pushed here for anyone to
give them a try:

git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/linux.git rust/cpufreq-dt


This depends on basic bindings for few other modules: device/driver, platform
driver, OF, clk, and cpumask. I am not looking to upstream a full fledged
support for them yet.

Based on staging/rust-device from the Rust tree (which is based over v6.10-rc1).

V2->V3:
- Rebased on latest rust-device changes, which removed `Data` and so few changes
  were required to make it work.
- use srctree links (Alice Ryhl).
- Various changes the OPP creation APIs, new APIs: from_raw_opp() and
  from_raw_opp_owned() (Alice Ryhl).
- Inline as_raw() helpers (Alice Ryhl).
- Add new interface (`OPP::Token`) for dynamically created OPPs.
- Add Reviewed-by tag from Manos.
- Modified/simplified cpufreq registration structure / method a bit.

V1->V2:
- Create and use separate bindings for OF, clk, cpumask, etc (not included in
  this patchset but pushed to the above branch). This helped removing direct
  calls from the driver.
- Fix wrong usage of Pinning + Vec.
- Use Token for OPP Config.
- Use Opaque, transparent and Aref for few structures.
- Broken down into smaller patches to make it easy for reviewers.
- Based over staging/rust-device.

Thanks.


*** BLURB HERE ***

Viresh Kumar (8):
  rust: Add initial bindings for OPP framework
  rust: Extend OPP bindings for the OPP table
  rust: Extend OPP bindings for the configuration options
  rust: Add initial bindings for cpufreq framework
  rust: Extend cpufreq bindings for policy and driver ops
  rust: Extend cpufreq bindings for driver registration
  rust: Extend OPP bindings with CPU frequency table
  cpufreq: Add Rust based cpufreq-dt driver

 drivers/cpufreq/Kconfig         |   12 +
 drivers/cpufreq/Makefile        |    1 +
 drivers/cpufreq/rcpufreq_dt.rs  |  225 +++++++
 rust/bindings/bindings_helper.h |    2 +
 rust/helpers.c                  |   15 +
 rust/kernel/cpufreq.rs          | 1041 +++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |    4 +
 rust/kernel/opp.rs              |  918 +++++++++++++++++++++++++++
 8 files changed, 2218 insertions(+)
 create mode 100644 drivers/cpufreq/rcpufreq_dt.rs
 create mode 100644 rust/kernel/cpufreq.rs
 create mode 100644 rust/kernel/opp.rs

-- 
2.31.1.272.g89b43f80a514


