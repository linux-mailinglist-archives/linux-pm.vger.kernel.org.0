Return-Path: <linux-pm+bounces-22852-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD02EA4310E
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 00:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A1E63B3DEC
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 23:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A817420D510;
	Mon, 24 Feb 2025 23:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qu/bhYcm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DB220D4EE;
	Mon, 24 Feb 2025 23:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740440390; cv=none; b=uzj1bsnS1Etl5wX9Lns/MNFEaUZIqEjnLf1AkZmm5yovDt8VpTd8NuB4PVpNSlsr1PZoKzL6f3iBroU7xUf3jeXhd/BpbEnyjeMBCE46wERV072CAZT3jjNTUEhAjUhuH8ndTJa//+n9+e00uCv6TLkB1YJka94QnT1OuTzcJpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740440390; c=relaxed/simple;
	bh=dy5wIyg9Jg4HwUFyZnwCx25rcLIim2cRM3MvxcOAjmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y8wI45wmQd6mYeUyJphwQiHtvjm6diAGwjJj7yEL0u8WU2rASelRSmpcgw2MkMAedQIuR48ZTbWGtKcwFTKgvlG6Yj4CWSovHFBVPH0GSzjrCkM+83DXRu3iktaavLzHiZ25/He72xPIl7NJuxxaqkIY1a2gPmIkT03VeWnJSPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qu/bhYcm; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e5dab3f37b1so3890441276.0;
        Mon, 24 Feb 2025 15:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740440388; x=1741045188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PO+qEcGHwi3KcJ9iKhqChU9yJ5PCUSHuyHoxT5OZyY=;
        b=Qu/bhYcm4njpPxxNW2o8Z+TayUaUum24mJ1GKpDqSvRCcjPaUoTHG8xsoMyjhS1396
         GTqi96DrH/cJ8n37h85xaGsVH3WmQmDKVlSG/tgPOXL7wuhQ4ycqSWtKPJi/Mf6CgPxn
         Mrw98F8b7ovQUf/NQ3uj7NXaJPXMbowi2eEK3gUOvogJGcmaAEy2n0M0fHAzlk2LdyGl
         ZOTd9GtgPm5Rn3955m8YiXz1PjKwmutvx64233XTjXequXnX52koJ13Ae2+fJsR6PRLy
         RhWDYtJvzDeG8gaaemuPuHJUkejRQ0HoDuAYcbLE2ptUtRyop7wW/gaFI4SPm79+J5LZ
         LMng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740440388; x=1741045188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8PO+qEcGHwi3KcJ9iKhqChU9yJ5PCUSHuyHoxT5OZyY=;
        b=YC0YEqguo6bHKAOe8+W+M2vP8VCZwcYrXgNG3lqVml5oKdj8XE+QfrXddJzrt3cXFe
         5wuLKj1dyD33a+ZB4VEx+JuXmuqmNuOI2K8OEIDzaZI44DBjjKWF2/iQgmQbfQY6TTK0
         Suq8klyoPTJA5LHlwgh2IUj+ijZHXwmZugExNgkzUOwiIHsqnD4lZMExc4mVjsGOSf92
         t1Gr66YxvvtI86cJGrSGwwBWZQ5BnXIL8X1DkcVTHYwzQrqQ7ri8vYRcd+STffXJKB8v
         kEi2DmqFzdp9lJSqjnoXpuzTp/D3zjr2k1y/Wx5m9QH304l4vEYDpQY/2qpt6FrDG7dw
         tsng==
X-Forwarded-Encrypted: i=1; AJvYcCWV86iEZcCPQrREKCZr0K+/KlxptGuJfj6X8Qn6/q8JJQp0RhOwzFP2+2cQyKZ/fCjv/4d6WzBO1e0=@vger.kernel.org, AJvYcCXSj9u/f98VTImkjye/RyMWoapGQFAgMIvDlf5vCKX2NZXHohJtYcOBxVv6ll6UvnKlndnKI3w6mA0Jlkw=@vger.kernel.org, AJvYcCXo2A2JZlcZhmehQByvgsAgho+OZRUaDQEcAMf4Jt7RpDIvjIgGHUQfUNkF0lQHatFePDpAOH4Mw2N+qebKkQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDbJ1FdBVhCcU1Gr3KxURjPmBExE2xRur2//LJM2hZX0DxnLtl
	8y27X1EjLAGOEbiKUHKWjWN4/7d0zrsUTypCXCXcC40k0JYWzOi0
X-Gm-Gg: ASbGncvng4CwxY1tXI6RJWGsyI1ukOBkEnZjR55fEnm8TON47Jg8lKllRCV/2ADxnMS
	UYMSHGnmazAbUuW3WdYpP9Is2gqbjoHpxViszyOWABu2lK4O6JXRRk1XzaGmkUiZJvBDlnCqCZ8
	3Oc/tQxuxyxpN6bdODovnmrytmmgthL83atU/7C0dfNRXhPzFl+6j2RxYUNpZ3y9kahUKr5lN9L
	vmNqPrZixKfNJGNwH/K3GZ2uVzmNlSBTBoQqUI7bNv2iclnH8DRwtmgBDOTaSEvUW/+n6vCjp2Y
	2n/6fm/EWId16trRSxidxN9MQI3FcROoUCIV2kOGaqKP5cUmhkZkFQsxGAGcfA==
X-Google-Smtp-Source: AGHT+IGdnsBNm1olQUZPMRubPcaWUuScl0K5z19KV1IaUBrkhIZ/rirQh4hpadn88E0q+FylHGCRKQ==
X-Received: by 2002:a05:6902:cc4:b0:e5d:dc7e:9d3b with SMTP id 3f1490d57ef6-e5e8afe4595mr10874487276.27.1740440387720;
        Mon, 24 Feb 2025 15:39:47 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e607b4c6e81sm88291276.53.2025.02.24.15.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 15:39:46 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Danilo Krummrich <dakr@redhat.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	linux-pm@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] MAINTAINERS: add rust bindings entry for bitmap API
Date: Mon, 24 Feb 2025 18:39:36 -0500
Message-ID: <20250224233938.3158-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224233938.3158-1-yury.norov@gmail.com>
References: <20250224233938.3158-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Yury Norov [NVIDIA]" <yury.norov@gmail.com>

This entry enumerates bitmap and related APIs listed in BITMAP API entry
that rust requires but cannot use directly (i.e. inlined functions and
macros).

The "Rust kernel policy" (https://rust-for-linux.com/rust-kernel-policy)
document describes the special status of rust support:

  "Exceptionally, for Rust, a subsystem may allow to temporarily
   break Rust code."

Accordingly, the following policy applies to all interfaces under the
BITMAP API entry that are used in rust codebase, including those not
listed explicitly here.

Bitmap developers do their best to keep the API stable. When API or
user-visible behavior needs to be changed such that it breaks rust,
bitmap and rust developers collaborate as follows:
 - bitmap developers don't consider rust bindings as a blocker for the
   API change;
 - bindings maintainer (me) makes sure that kernel build doesn't break
   with CONFIG_RUST=y. This implies fixes in the binding layer, but not
   in rust codebase;
 - rust developers adopt new version of API in their codebase and remove
   unused bindings timely.

CC: Danilo Krummrich <dakr@redhat.com>
CC: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
CC: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index efee40ea589f..315cff76df29 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4021,6 +4021,11 @@ F:	tools/include/vdso/bits.h
 F:	tools/lib/bitmap.c
 F:	tools/lib/find_bit.c
 
+BITMAP API BINDINGS [RUST]
+M:	Yury Norov <yury.norov@gmail.com>
+S:	Maintained
+F:	rust/helpers/cpumask.c
+
 BITOPS API
 M:	Yury Norov <yury.norov@gmail.com>
 R:	Rasmus Villemoes <linux@rasmusvillemoes.dk>
-- 
2.43.0


