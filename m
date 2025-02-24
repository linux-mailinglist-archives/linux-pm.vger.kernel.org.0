Return-Path: <linux-pm+bounces-22850-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FB3A4310A
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 00:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83074168C7D
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 23:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECE120B814;
	Mon, 24 Feb 2025 23:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCNxnZCt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F8C20764E;
	Mon, 24 Feb 2025 23:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740440386; cv=none; b=PqDDckqCsiPsor72UaMw3vIzsdfSl+wOFD7GlvuOUW1hdTS+VfhBzYAiqE/44BZGBsFqk11qC4UvXJLcb3J2hiivGtKm1UW3L3MfAgv8rVsFA9BdX47wnEdLW0+4WhZBpKxl8Na0VCeZIeTmQkoPnbeNNGcAOyzaCF3gnk9KJZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740440386; c=relaxed/simple;
	bh=Mx3M84WwtY3NU5OR0FXjmYAPb68dziDd5bWY/P4BbEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P3J9tBQWNRJJavdkVJHe/7kkTD9b970EaEYDMmHEE7u9xVkyuS4pNq4Nmvw5hcQj8L4waffrfKrIm7UfzKEOQy32KCoKq2XE981uepZpkPnzp878wouO6FKzX2JWK/dhgVs/j0vln+aesXic9I/qhZwoDutM1OcP+9bH7lq+TYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCNxnZCt; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e5dd7b439e3so4230765276.1;
        Mon, 24 Feb 2025 15:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740440383; x=1741045183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Em6wyZNwKj45p/oNoxuXgA87kPyVGeauMHk780ar+kU=;
        b=fCNxnZCtovtjDme0XXFa+yfJJY4l/Akj1tHyikhyIxNS4HRRWIzY8exvMS9YBwwe8J
         xW3iB2eXvuwUBfO9IU+BgXznmHLuiz8xlT/GP8Hq5AvPq8OD5X4ygKPc4Iuipoi0roww
         rw/Yqa/e0iVAfvLmk2F1jj3PBKkXKXRoIPwV13B7x02GJc6p2l7S0ry2P5CGBbV8+gL6
         vMP+AlI5tbbRQwq3Jys2d0n8viqwuPk4w0G1TeFq217Dif7Qr1eqSJrO5wtI4atnFyfe
         IPrJGAiqBxPxjO7ufHrMfTIEaq+rvCYLYJF3MPvoAx+3slkfA0xUcthXlgBdrUvi4l4o
         +DTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740440383; x=1741045183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Em6wyZNwKj45p/oNoxuXgA87kPyVGeauMHk780ar+kU=;
        b=lawplL/zrq4g7rejcnKcuiUAKEQ5tgRffpmdyl/+xNX20lJi/uLRwpjZb4SEQTpSZ/
         8FgT+9NZHGmCI9+VUbCzRG1ulxZ2es/03ZIaQSZ2Xhw23uSDJiM7hSxCNnIHtEAtSpfc
         4PXgBO66Uy5sAZfg21m34vFdXzF6dlKiDsFBFEfWs6r49yg7FQvBMu9UCVdzF14oThkX
         Zko9zhlvOKwVhMRnzHDrX0hk6MGQjm6pJMPX76i7jxYeRh1wAaGlTRx8P/r0l/gA0X7Q
         2jDTmNpShuqluepG3fpdsRCN2u4Ow8KfaJtYx1aH+z5ez26aqD5keAwmzfv4Q0+sRbiZ
         zZfg==
X-Forwarded-Encrypted: i=1; AJvYcCUa9wmnI8RWuQawNh9bdlU7Im7Dt4S/ODx0YyGn/rAwtcrtLo1bWX4JaIQNEQMjJxmSnYirYu4jui+pMH15Jvk=@vger.kernel.org, AJvYcCUfKkPknD//GVe3WA+S/l9VSfdSo2f/kqc0sUQYUNkZSCQx+cEF2Mo2ljtqW92MZD/7jQNNSbTTj5ntYZ4=@vger.kernel.org, AJvYcCVWjZUlPHNW9VCIOuk9ytGy6O8l/aiKN7ZDGY29yXpC6NJydswKX+xF3ejJgTKU9l2LULp4ZRvZgEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjAQgZaow1RUZgQ+nbPwy5M1KeyXert/zJ5OirN7york+mpoZ/
	YScFWVtPuxU6/6WLupVozh1h7pfNxStnLMJbJEJTAiM+5kL2eZBM
X-Gm-Gg: ASbGncvpadk5ZDSyUvkxHStY95zV3I9TpQWBSQsBDvDTb4WkXKGy1ep3UJwaVqpmtBs
	N3qgnFrE+eQi4UyZ/3YUl4XQHL1pWzS4Z731JN/NxQFBcgIbrrOCutMay+Ul1kDSCsdRUNvCxR5
	2QjGc2cj6GLAP5YNXQoOynIz5aLJdnGW8jrPpfdzMhhKxkSdyp1osrf5gxM7tS7D/Vn+qieAETN
	Hd7S7sDD7YRYYBmIrHIviSoSRwVna15ihYwYX+ZNso9BCwD1ehJBOHaHKQ3C92ai1P/dRKoI0DV
	WbSA0/IX0tJNgM+YvZP3Nhgm+6GtDRExh+DXzDJOpRv0nQ+P+/VB2+KDszEcfQ==
X-Google-Smtp-Source: AGHT+IGJ4kYO+7vEeod1p53CFmuKDYnA9HznKe1Ojaxw+/QIMgxp46DfqTGP8DgzDp0dw2ylUJqDyA==
X-Received: by 2002:a05:6902:3301:b0:e5d:ba97:b1af with SMTP id 3f1490d57ef6-e5e8b04674cmr10799379276.39.1740440382744;
        Mon, 24 Feb 2025 15:39:42 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e607b3eb08bsm89564276.23.2025.02.24.15.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 15:39:41 -0800 (PST)
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
Subject: [PATCH v2 0/2] Bitmap bindings for rust
Date: Mon, 24 Feb 2025 18:39:34 -0500
Message-ID: <20250224233938.3158-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bindings and a new maintenance entry together with the API changes
policy.

v1: https://lore.kernel.org/all/20250221205649.141305-1-yury.norov@gmail.com/T/
v2:
 - export alloc_cpumask_var() @ Viresh;
 - clarify that the maintenance rules apply to all bitmap interfaces,
   including those not mentioned explicitly in the helpers @ Miguel.

Viresh Kumar (1):
  rust: Add cpumask helpers

Yury Norov [NVIDIA] (1):
  MAINTAINERS: add rust bindings entry for bitmap API

 MAINTAINERS                     |  5 ++++
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers/cpumask.c          | 45 +++++++++++++++++++++++++++++++++
 rust/helpers/helpers.c          |  1 +
 4 files changed, 52 insertions(+)
 create mode 100644 rust/helpers/cpumask.c

-- 
2.43.0


