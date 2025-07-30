Return-Path: <linux-pm+bounces-31619-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EFCB161BC
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 15:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1822618C2161
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 13:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296492C324E;
	Wed, 30 Jul 2025 13:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="LD3uIyuJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5657D19FA93;
	Wed, 30 Jul 2025 13:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753883184; cv=pass; b=M0FSOdYJQZlHQrME5HIoyWhqR0IgiRkDwk09FfrONk65Q2P7jDVdzM8AQk+eOZhGOqmjTK+Ps53w6qBKQHTZJ1gcGjmskUexwy6v9yVyiHFI1wCWK+VekSPu0j922lgPfbAzJljUI5EPVT5hsmlRhnwmb1cXsxVyRyH3+V+rsfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753883184; c=relaxed/simple;
	bh=bjaYcvz3v5WfyEQxm4uFwostHIKvCC25+5SRLNwNrs8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=R0Tyxfd6FPDO4FO0M6/yns392HptQ3tgdGVx5Ibh4weaSYWT8KLO6P2MAwPB7IybZqsK3emojNjznLfUy+4XanrkWCalJBwIbYT2L31t7NZv8xQ70YMyevBydacqpouZVbdAQImudWX0MmKvhnyxM6CXzbBEqQheGcYentfowcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=LD3uIyuJ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753883163; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FJknu8xzr9PfmL2ZWVbr5ZsEGbA8PLtBMN/4dY2WqaKyHm+lUwff5k6dwPYbxD5JT2+TtnZhYSE97p6ew8XsIHwiHPqGN4A6zD3CS1JsDCUiy/M/dd9lQPfPBl5d2uCDxzNEe2fGE0HhwFXnMLCHIM+XBC1SgSUh9eknLxmh3LY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753883163; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bjaYcvz3v5WfyEQxm4uFwostHIKvCC25+5SRLNwNrs8=; 
	b=TIDw9k1Brmbkl9jQqBQxMM11Vsj9Ze1o0kdvv/3/bNgpACbAgd2wTCbkHe1m2S4pcE/sB3DIeLVvJOZ8d79Z2WbI6WcGZf7D/0g8VxvFTavAETqt4WqCL+ctABcrAf8WHWO6IJnJdxseaNxSEFhInX51g59NvU8LjYgqks/nQWI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753883163;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=bjaYcvz3v5WfyEQxm4uFwostHIKvCC25+5SRLNwNrs8=;
	b=LD3uIyuJi9ntvAWrT3TnWNCE+pSsn80skqbi4WRyZmr8EqpOPZq9uYx8Okv4wYuE
	e5uw9vWhGII+fCkInRXpViDQC/3MXkUrSxaH6KJvcXuy6pyMRqin6oPvyFUlpboGdOT
	brOpyg0l7SbfDC3Tl9LiIVn20pNXmd6sUb2oFskA=
Received: by mx.zohomail.com with SMTPS id 1753883157044881.6279461529779;
	Wed, 30 Jul 2025 06:45:57 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH] rust: clk: use the type-state pattern
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <CAH5fLgjBQF+AGWQ-rKowViiL1kK47FZ80QfEa58Cx9bk11cjAw@mail.gmail.com>
Date: Wed, 30 Jul 2025 10:45:39 -0300
Cc: Daniel Sedlak <daniel@sedlak.dev>,
 Benno Lossin <lossin@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 linux-clk@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <41B46C07-5408-41ED-91F9-CB3979944DCB@collabora.com>
References: <20250729-clk-type-state-v1-1-896b53816f7b@collabora.com>
 <fc26c393-5c4b-48a8-a7ac-12558f79b140@sedlak.dev>
 <DBP8RFDV59PF.1OV46P0UYKOGM@kernel.org>
 <07575756-58EA-4245-B837-AEC4DDCD0DB5@collabora.com>
 <20cc8581-0af2-47b3-9fdd-584ff0ef36ab@sedlak.dev>
 <CAH5fLgjBQF+AGWQ-rKowViiL1kK47FZ80QfEa58Cx9bk11cjAw@mail.gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi Alice,


> It seems a bit much to have macros for everything.

I understand your point of view, but at this point the =E2=80=9Cmod =
private=E2=80=9D
boilerplate is growing by the day.

It would at least make reviews slightly easier, because reviewers don't =
have to
ask themselves whether the submitter implemented the pattern correctly.

IMHO, of course.

=E2=80=94 Daniel=

