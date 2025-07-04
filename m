Return-Path: <linux-pm+bounces-30179-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B19EEAF9B8A
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 22:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EB9B5A83B6
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 20:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0931F429C;
	Fri,  4 Jul 2025 20:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwIgK5SE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FD71E4AE;
	Fri,  4 Jul 2025 20:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751660165; cv=none; b=Ruy2vxb2zF8poiykYFWdPsyRtUlANErP64YnT3dhj/I1jzkg9ghBxOPPM1etCTTO8AM+3kZLF7HooQnASYV1tu1lRkJ7mpFiUOmEtEh9k61p9NEk2Rvx39SOrcKKyVJpxNJAtZUyRkGB2KJuhJNsNL3HtRpB8I3VvBpW1d4dqBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751660165; c=relaxed/simple;
	bh=QbKwusMAkM9a/9/xceMyEYhSLLCaD1ZRtRJUSrrJv5Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=a1EV+jrBnb56J2V1JbGU3wjUDW8mIqoROflrtr02pp312ejZTiaChtWCwQes46+pBlAc1KmEzQhtEeD6s2RDGEgFdKWqoRSuOtHU+qJTebHangdonZeS8ECbkDcubvzW4QEj1QEJgfjtpqTcowGmCV1k8GDbGrF9tlE1fbgLXqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwIgK5SE; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4a77ea7ed49so31708091cf.0;
        Fri, 04 Jul 2025 13:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751660162; x=1752264962; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JvF1PhT6A+YsimfPIbVV0DwQMx5ntblUzy1Cm9DCNFs=;
        b=GwIgK5SED+NuoQv0vct1vMp0BPYeZbWIYlCfS0FyHzDVzR/42SsKgPQPxwm3aSBcmZ
         F6OuQrm5YgQNAkTP68bn6So30z2VfJU6Jxw+/W/VvCQu4iQdIkrMW8FWXDaaKx7pV+6F
         0b5zAZPJ7EQDOj36jhrA5+39jDw1Gf2MJQMRCZGh9aXucJe5zkgf8fMWdT74tsoFycic
         wRIjxlr/nGEMt3SxeCCKyt4SC3Fj6VVwX2MOhyjJ9VDIVYcMoX2kToflzzJKuZcS8Ja8
         w7VxtBeF/+BC+zAxNl0MS6Y6eoeKAUYDy+R2RZIKfX2tsmFWEgb+R8O2Xv8wBF50RfpA
         tTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751660162; x=1752264962;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JvF1PhT6A+YsimfPIbVV0DwQMx5ntblUzy1Cm9DCNFs=;
        b=TNzJCG/NiwDBr+PVbgbtn45Oz1DJYqapyGGw5kvrvPubxy9S67siF+1Q4kP7WkU7gh
         Zyqsmt/WOr0Tx0zwcRHrjDlKDFDj3gE9TtDMo/qm2SGgQ7eRu5mR8ATZUhYLVAY2A9Ty
         GTo9V1+kd2YmuLfKC2FeOPmPgheVPlkj09SMn1pH9PFjg8Mpp6Fsx3J3/I0Zje/zMiEt
         yBfgjBXkXCiQcFRleetHNLOmVzsFa3rYDokaJSupVQ//Dt7FJHYj8jXFGlc8rDDVWksR
         XwES2yfQRMgNaQ1Qtbg5gAcjRJiT3kIZeLgMlHyZ3rwBiM3wPEv2TJ5WdWXQuIc9cJRt
         M4zw==
X-Forwarded-Encrypted: i=1; AJvYcCWjPLmMDF4gzqFKy4BrBp7D1y0xsTZSwwezYfBZ/FKFJeOvJerX64Zrk2vtSMB0u0RQUWemgmD6CP+bbr0NpRM=@vger.kernel.org, AJvYcCX+ztdWyKYzzLShbbgfivkUb013D+7oDhXLGnGp4+cfBIwdA2cxhrDy+9Nh2rUbfW/5ldu97scFpBuMTwU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygy7pcZ+UIVtYJZSdOeKkfsYVdw/uax0yKxU66HLQ0sK7FLHxU
	v32MWDcGSn1YHrGbRLdCXSIurZ5a+3HoHAB69YNT+8gAnPCuD+JGag4m
X-Gm-Gg: ASbGncuuwzehtRx6TzpSsOOtCza6ejk4rX8vWE+Yz/BcbL2QsXeZYPVnmfq27nqvT6h
	5BbpDpzwVXm/+JGizmK416DvAobTyxNojQOMszuui+UNpvBqDgYrfj8xT8QJUR7JfksgfxuDInS
	+SKqwFuqcRfaVVPJbuYhX6fM+dWKh3g6/wC6oidhAWbyY1PryYAZ/PmbyDeya9AG+DagZ8oCZhc
	0wIPNg3BovEtMdFZhH+UadKfTcqsWBCye7Orn7fDqhOAZVC714G1A1vrWeq4zIOpH2otNYiE+Ha
	frYJzMIDtwzae2+WMMclJ30Y9Bq/oY9TW/8F35Kw/yhdJEpNeUUjkryJd4h937BoKDixpJC4q8U
	s/DNj6Lg=
X-Google-Smtp-Source: AGHT+IGNtDccghiwMyeSOhBtUWcR8MfX183nsH4JyaXEa12ociciUBdXmH+eYmkAki5LcBiOJOoL5w==
X-Received: by 2002:a05:622a:4c16:b0:4a7:8439:796e with SMTP id d75a77b69052e-4a994f46b02mr72174231cf.13.1751660162501;
        Fri, 04 Jul 2025 13:16:02 -0700 (PDT)
Received: from 156.1.168.192.in-addr.arpa ([2600:4041:5c29:e400:94f3:d2bb:5ace:77a1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9949e5221sm19772941cf.2.2025.07.04.13.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 13:16:02 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH 0/6] Replace `kernel::str::CStr` with `core::ffi::CStr`
 (cycle 1)
Date: Fri, 04 Jul 2025 16:14:51 -0400
Message-Id: <20250704-core-cstr-prepare-v1-0-a91524037783@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADs2aGgC/x3MSwqAMAxF0a2UjC1UsRbdijjoJ2omKqmIULp3g
 8Nz4b0CGZkww6QKMD6U6TwEbaMg7v7YUFMSQ2c6a5zpdTwZdcw364vx8oIxjDh4F5J1CLKTvtL
 7f85LrR8k4c5TYwAAAA==
X-Change-ID: 20250704-core-cstr-prepare-9b9e6a7bd57e
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1751660160; l=1945;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=QbKwusMAkM9a/9/xceMyEYhSLLCaD1ZRtRJUSrrJv5Q=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCCsSGmWQGuchXx15wPXzQ8bwXKfo878bqFcp4CZeit5Laltm+GPuYb7EicsWu7PjvXZK+2GLfQ
 9DAOrwfdjJwc=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

This series makes preparations for the replacement of our custom `CStr`
type with the analogous type available in `core`.

As this is a large migration that touches many subsystems, it will take
place in several cycles, each of which may see multiple series:
1. introduces facades in the kernel crate that downstream
   code can reference. [this series]
2. migrate downstream code to kernel crate facades. (N series, divided
   by subsystem).
3. replace kernel crate facades to allow `Display`ing foreign types
   (such as `core::ffi::CStr`). Replace `CStr` with `core::ffi::CStr`.
4. migrate uses of `c_str!` to C-String literals. Replace references to
   `kernel::str::CStr` with `kernel::ffi::CStr`. (N series, divided by
   subsystem).
5. rename `c_str!` to discourage use. Remove `CStr` reexport from
   `kernel/str.rs`.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Tamir Duberstein (6):
      rust: kernel: remove `fmt!`, fix clippy::uninlined-format-args
      rust: kernel: add `fmt` module
      rust: use `kernel::{fmt,prelude::fmt!}`
      rust: str: remove unnecessary qualification
      rust: add `CStr` methods matching `core::ffi::CStr`
      rust: use `core::ffi::CStr` method names

 drivers/cpufreq/rcpufreq_dt.rs    |  3 +-
 drivers/gpu/nova-core/firmware.rs |  5 +-
 rust/kernel/error.rs              |  8 ++--
 rust/kernel/fmt.rs                |  7 +++
 rust/kernel/lib.rs                |  1 +
 rust/kernel/opp.rs                |  2 +-
 rust/kernel/prelude.rs            |  2 +-
 rust/kernel/print.rs              |  6 +--
 rust/kernel/str.rs                | 97 ++++++++++++++++++++++++---------------
 samples/rust/rust_print_main.rs   |  2 +-
 10 files changed, 83 insertions(+), 50 deletions(-)
---
base-commit: 769e324b66b0d92d04f315d0c45a0f72737c7494
change-id: 20250704-core-cstr-prepare-9b9e6a7bd57e

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>


