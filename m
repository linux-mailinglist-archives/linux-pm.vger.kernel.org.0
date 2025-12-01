Return-Path: <linux-pm+bounces-38948-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AB930C95AA4
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 04:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 615BB4E0243
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 03:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AF21EB19B;
	Mon,  1 Dec 2025 03:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIgEajcJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980631E7660
	for <linux-pm@vger.kernel.org>; Mon,  1 Dec 2025 03:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764560670; cv=none; b=o8el4E9o4SHiG4fXoRzQsNcYc3kLne0CxR/mSCVtoYxEnPOLe8eJpnuZtUvfsVT2b1i2RU1IKTLUZMrj7uzj7r5CDPhaYvANwHMSAc9xLOO1uKFC67g1ROOgy6CPI6DBIefn1rDOnKfpoZUUzwqxsVRTtTIWoAHk75Ink3fRDX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764560670; c=relaxed/simple;
	bh=Ou0gmbzMJ7WK94Bry/1yz4qCJlQddnWcuASNS8scssc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IX4km7bDidlOy4kRRk8R68fuDz8DzPVftkWHdA1W/TkinhVkL149iPWkgyunPCLHuvAIY/vtebsxuKcicajuJ7UrmQ5C+vxauiKeE86o4AKrecr8nrL9tyfgW2FrA8eiNEFgQaGRVDAWd7fttdT8FZ3wZ2LpQDdqGLXWN444u8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIgEajcJ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7b90db89b09so325241b3a.0
        for <linux-pm@vger.kernel.org>; Sun, 30 Nov 2025 19:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764560669; x=1765165469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ou0gmbzMJ7WK94Bry/1yz4qCJlQddnWcuASNS8scssc=;
        b=lIgEajcJ7iqMF7e+IesLpacF5hYzXZLNsdSzLaWqA7PUkIg6rJRgtO3bdnb9jrS/qh
         0X48alvfXzq891I50CKviinww4d4/CH7OS2TpAE4zO0TcyEEGn0ZFuogb8+pZGRU+pQh
         WHTKGD01Wz8sgD6uwDDF/d38NJ//svYN05m9qDBF5AqPZWWtyyVHPV6tiX1d8gHlJfp5
         YUwUXkdBYXbdlWcl7/Av6CbO3X8Qgepu/yY1GPbKPc49p/AbYw/La4dJZhdQ6tvI00oG
         aG4362CYy9pGQ1IT9nVSTCYsrCGE3KT+tGVeCItg1uMs496fay3p76THSB+1nxZu+7ID
         4lYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764560669; x=1765165469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ou0gmbzMJ7WK94Bry/1yz4qCJlQddnWcuASNS8scssc=;
        b=TEu6IiB/lAtdAVEW3kn22yyC6pbPmYTUCuNRa7z1Wwqh/ugQ8yF8BzDZ5X58TMWShM
         g4fH3HVrFYrik/s5EYnWxBSbD2aWA9LnEkTXLHp3/+ycPXyp91hWq/lomXEmMa7HfKPh
         SOFaIFJg1kFAHxalcmzGaQSDpzbwE8OvON4j90YbcdVd91bTyLWb9BRxqM9hH9ahSlVd
         9e8Wx0iT+JsrkbP0jC7SnOgAXPApjjhssfiXiP99FTK85DpzadL0K1ix/XBwn2GXZK1G
         fyjGWDAKxvj+IaBU0/D+21v0e+G0FbY5+0mkpqy9xihYP4LI+Kf4M2CJyiZvq6Z/G4NS
         aZjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVup93mDpJQTEDkD1lnueXhKUfdD0+KZcDiIXuDXbcfdxdffT2Gat9bH5nflrGXaEp/72OeVoo5uw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGxDlAwEAo1px6TNMDr8CAYs7EomrfefkWkqnvZRHitfQzM2yt
	5FaUqs/Qe3Lss2aidpgdDBlzR4RIo/ka6WN9Zd18QoOk2/Uz3vRC3ADH/U3x50L3SeZdZpghz94
	blDZOte61FyfTUdXFKXf3FkLMNe0ziQY=
X-Gm-Gg: ASbGncs13khxmisYIF6uwubpWSCOplvSBiqH2ux/WmJ3OBK0OoOC3zpNstov3ixLsQp
	2CQk7jxLi49YDo5n743ppGLgp9wnaBnG1xKOJZ+oGuZKrKOTAgQtQcfmX/Aa1AfHpZX9RkNsCBJ
	Oqk4nTTHAHAyFadxf7zZ0jWrwDvHIKHnL+B/VvoYWNZq1aFJ/qCYi6aEuD3aeH9Z7l+j2kyyAXj
	nij4/HzzBUp5evqzC//FaXrjZPs1FnIf1McMrzyNZEldn4BweFtFS1ZUF4h+pvbynGog4TRx+GK
	6yl5nnTeT9pXc9uD8H6+hAVTZUm9bya//ItjVRZ97C2UFYemz9kIocMaXEe8IKgmRoaK+fKK3il
	NQMEXd2zgP+Uy/w==
X-Google-Smtp-Source: AGHT+IHhNcWqRjdE6WDbqGV5LBjVOXOtiJupgTDpMN/BHD5bvg+7mk/G9awEzawvfPY7kxZnoDvZNeO1VjEWibhGEyw=
X-Received: by 2002:a05:7301:e24:b0:2a4:3593:2c07 with SMTP id
 5a478bee46e88-2a7243ec7b9mr20563195eec.0.1764560668750; Sun, 30 Nov 2025
 19:44:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128-io-build-assert-v2-0-a9ea9ce7d45d@nvidia.com>
 <20251128-io-build-assert-v2-1-a9ea9ce7d45d@nvidia.com> <db6a6b28-c0be-4bd8-a0b4-70431df7737a@nvidia.com>
 <CANiq72nGUuK9VTYJGob7pnXU5zuuCzqfw6fezAFpbqvte1sDFg@mail.gmail.com>
 <46b5eef7-2e8d-4801-93d0-6cea10f62dc9@nvidia.com> <CANiq72mhXajwj7HjiW_HQq9nO4o-HwBFUya3wjT8pRkWx3xjZw@mail.gmail.com>
 <7d157605-4c59-4e04-8c41-1f7a4c86b34c@nvidia.com>
In-Reply-To: <7d157605-4c59-4e04-8c41-1f7a4c86b34c@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 1 Dec 2025 04:44:16 +0100
X-Gm-Features: AWmQ_bl180v7rn5R3N8zrZku1MYd5WEe32glG3ozOy5Ktj495-Rh0sd4fp9o8pg
Message-ID: <CANiq72n0UkuAtW=2JZK9Y7TK4VO8rKsMSvpv52BsW5+C2z9Dew@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] rust: build_assert: add instructions for use with
 function arguments
To: John Hubbard <jhubbard@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Danilo Krummrich <dakr@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 1:52=E2=80=AFAM John Hubbard <jhubbard@nvidia.com> w=
rote:
>
> More precisely, it was already *hinted* to be inline.

By inline I mean it is marked `#[inline]`, which may or may not get
inlined, but it also has other implications, e.g. codegen can get
delayed even if there are no callers and is concrete.

> Then that is conceptually wrong, because it must be a runtime check.

No, it is not true it must be a runtime check -- it depends: you can
use such a function in some cases just fine.

That is the point of `build_assert!`, after all.

> Sorry for the fussy detailed questioning here. I'm trying to bottom
> out here because CLIPPY=3D1 is a very solid requirement before posting
> patches.

No worries, but I don't follow what you mean here. `CLIPPY=3D1` is still
required to be clean etc.

Cheers,
Miguel

