Return-Path: <linux-pm+bounces-8751-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C84BD8FFEF3
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 11:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FCAF2866CB
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 09:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9258C15B131;
	Fri,  7 Jun 2024 09:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aCl9vHVJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B15405F8
	for <linux-pm@vger.kernel.org>; Fri,  7 Jun 2024 09:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717751558; cv=none; b=V/c6761OymZn+9Xs0sDYNnpnPcyj0H26Xflc76aAVM3zZpaHLGw9OZ+Np9RoeIJfJ93cd4aDdjOLtlgM+MxnGno+sq9Sbv7HtFexi+BzSV1M5XxbiExzT2AGTHI4e+F9RhBcsuTn3PmAllS4VQcJ1mp3rVZHNimm9sfC+4QkpoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717751558; c=relaxed/simple;
	bh=Q2KyKee5qAk5yhcRdV4zkO1fcS4SwRxZde8YLboA1fM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sYPHdAP9ivkm7yqq80h7dl5oVpbNUQkJmB1PF/rTpGAMtZvxbiHD8j387MUOwiPu+t5taeix6nX8l5T/sdz5aVPoQBr+dCdiYnKORtw2hjboOBguq4RsaIhetkCAW6z92aL8zzkuM3aBy2h6TImqiobuacJ1QSElzu08Krrv4jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aCl9vHVJ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f6559668e1so16699825ad.3
        for <linux-pm@vger.kernel.org>; Fri, 07 Jun 2024 02:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717751556; x=1718356356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hPveJQ5m/OIT5FdwV6oYgK1mHcEkZsFVv5qp/eyftFQ=;
        b=aCl9vHVJECUN8oyvlZIZqfL11NXmIXugJjUpD00WAuL0qWZyjotVrVM9Xi5gHljFbp
         nN5yQZQif0FBMAbhPPGgde8G2+fQ7Z6wrO2usRhLrvtcc4RV7tH76SG13vL83JePM4DS
         37Gtg9NpDx9sH1T277jyi2B5VJyHOEy46Y/4M882B/7HSGkD/uMLEWU6HwgergO5+/2+
         IMxWiX5uEqRGAgiugWl9UmFZlBwUCrG/UIKd1b4W9H+HAndfAILQScbytqHWskuSR57M
         iQzcpLXEma/Jpkg6s7QL1yGTBRXF3C2h74hOU75XoUZOTLEbGOAIl2F0DjTAuffvOBUf
         cHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717751556; x=1718356356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hPveJQ5m/OIT5FdwV6oYgK1mHcEkZsFVv5qp/eyftFQ=;
        b=M+zbEOTEmPXGurwRK905wjYRYNzZxghyOeXNW64wIRqmbRZwKjcTMbjHfMsEHXRD5r
         cBPKNUT5zDAlnQKH1oleFP7H6frEDoF7CFdLNIF9th9nP82k9KsKuTUypGqz/x9RB6rv
         GcpkMba24flLL+Tfvp5qsctIU8PaU/xG+PW8pYbFkDBVfaJgZBt/+r07PPTBALLmCjFv
         knrgUyo26TjV8GJ9E1xuBiIECfMDC9xf8vj/Kc81ieHN51Mslqa14ZK2Ut7yHuYLg98P
         TF7VfgP6E0Xmd5augsPPHsGo3hhXjoWksoJDfwjTWiPEuHj9dMT97vK1YvynShUGBrSN
         stnQ==
X-Gm-Message-State: AOJu0Yxd7jUEML+1DL623JbYg807Xw6S4fN2QXpVxusyImqekMNs/fSJ
	ZYuAAdtQuie5mxCz4V+Gm8q66XxSdBGkNDIt0iR4M2Mjm2X/iftZpklqknzkNu4=
X-Google-Smtp-Source: AGHT+IETqK0zIIliNwoalKCFWPqaghIKyxJIFCSap/cz1CcyLlXt9SgcECRYv4nhSTpyDxxto+jOcQ==
X-Received: by 2002:a17:902:d2ca:b0:1f6:7f0c:6c3e with SMTP id d9443c01a7336-1f6d02d3acamr23916915ad.12.1717751555988;
        Fri, 07 Jun 2024 02:12:35 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7e3e66sm29238035ad.182.2024.06.07.02.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 02:12:35 -0700 (PDT)
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
Subject: [RFC PATCH V2 0/8] Rust bindings for cpufreq and OPP core + sample driver
Date: Fri,  7 Jun 2024 14:42:15 +0530
Message-Id: <cover.1717750631.git.viresh.kumar@linaro.org>
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

This is tested with the help of QEMU for now and frequency transitions and
configurations work as expected. No performance measurement is done as of now
with this.

These patches (along with few other dependencies) are pushed here for anyone to
give them a try:

git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/linux.git rust/cpufreq-dt


This depends on basic bindings for few other modules: device/driver, platform
driver, OF, clk, and cpumask. I am not looking to upstream a full fledged
support for them yet.

Based staging/rust-device from the Rust tree (which is based over v6.10-rc1).

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
 drivers/cpufreq/rcpufreq_dt.rs  |  229 +++++++
 rust/bindings/bindings_helper.h |    2 +
 rust/helpers.c                  |   15 +
 rust/kernel/cpufreq.rs          | 1070 +++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |    4 +
 rust/kernel/opp.rs              |  886 +++++++++++++++++++++++++
 8 files changed, 2219 insertions(+)
 create mode 100644 drivers/cpufreq/rcpufreq_dt.rs
 create mode 100644 rust/kernel/cpufreq.rs
 create mode 100644 rust/kernel/opp.rs

-- 
2.31.1.272.g89b43f80a514


