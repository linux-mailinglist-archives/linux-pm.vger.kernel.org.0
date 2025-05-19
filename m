Return-Path: <linux-pm+bounces-27342-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F595ABBCEC
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 13:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA366167E6F
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 11:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1371C2750FA;
	Mon, 19 May 2025 11:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRjTBKcd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1F31DE4FB;
	Mon, 19 May 2025 11:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747655406; cv=none; b=aHnrO05lyQEFt4N1llC1Kmo++V+ZpNn5oEe+VY+hmYNO5ppDunGXfxbS7C2nJWzZdZdzH1Ebv8q2QFyhSZncvSUfi+K+GiLh7Emnrz8fm1BT45eULrODoseFj/6BHkd+1VkFG5J/2UiuTk/TJdL2NpuF/MVbNhbWTELE4alEXl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747655406; c=relaxed/simple;
	bh=oUDLf+2BPOAigeSNYCbqQvwj6Ovxax3PYeOrgWAqPBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V6RQoWsUAfMVCJu4+FUBJWvkxNVe8vDIs46HD+56pHmM+n7Ynu7eA9WZdQxIgRdVynp7WEd8bcAR4Bo1I9P/8exhfOC6jIGK+1NmrbjrQZq8kn5UKMn0+B3AsmDyS4MQxlIYdBvErl+wCAm9/TtcG/r60PKQ4FojVtLJRIeZaG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRjTBKcd; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b1f2a3bf3c8so481472a12.1;
        Mon, 19 May 2025 04:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747655404; x=1748260204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUDLf+2BPOAigeSNYCbqQvwj6Ovxax3PYeOrgWAqPBA=;
        b=jRjTBKcdi5OAGxae+u3sucCJ2Dq1R0Eo/d7nn/ii1/NlMGcS1S0tQuY5CJK1iqK0/5
         y0DrzMx4CkvBhyVVG5VAGHiksDtdsP++cXGqwBqh982DcaOqUUg01hqTInFwUNgwVL1Y
         ka1SWBCNAATv9wVAAIIa9Nye2FFbx3jZNciKxdgArW9EmfBkdd1wEI2mNyOn4XGIg3hG
         igBEQVFWamUwboHoi1VF9V+zMJ28D+CM9Ptm1QkuIxfjxX6l6miKi2g6ZEQE8f5Eyb1S
         j+LoglAjo5lJvQp8VnRrc7skw9zxXr0iO7g6j6Eu/F08Kd87T7tIDWvmRvmb54m05Nzy
         8ZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747655404; x=1748260204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUDLf+2BPOAigeSNYCbqQvwj6Ovxax3PYeOrgWAqPBA=;
        b=MAYP6+ancML5D5qI1oJyELox8tcMImBQrCkUFZ9Bm+j6bEyQtZGHL8/5021zycjXLf
         H0RT2G6un+0OXlckzSndn7K6JIzdFOvSUgQoXxm9EuNmhCBF3QTA8wFDzycpVhQz5G/q
         xQIIyXnVDLIbfUzOd4y6qlR0TSQnJe1C/EM0+S/Wdm5RWErzIRqIMXEu1Gza/ybCSr0u
         Xd6ogxycyvfPMhg0/hs9SHoVDJSEw5PNP95HTa4W9w4EAClqfo6UjgS+14iaQ1wb+ZEx
         0m6vAJAK1MCdVKRDpAhMKmSgOfSO4GQDhX3w5vWhfC6CAmK24tpVltNYRazjIWjKnHwX
         Fzww==
X-Forwarded-Encrypted: i=1; AJvYcCUn81CDO5XHQNLomccWxlE8BukmlgKRIQUviLZPLFuKvs5u2xFHi1t/OQtn/UTAUi/W+kOU7LA+/xYe4dNC@vger.kernel.org, AJvYcCVZkwe2exb2rqQJJaEK7C4Zrj19xtWGXJ4q21V8E4PcnmpFcR+Auw0HiNZoZ7gK8ldf9u8aYlolBRQ=@vger.kernel.org, AJvYcCW6dPiSf2kpN6VPG232EN9zofJUZvWKPtAEmhO7arkc1sFyB2ysM/AoL3ulJIHgUsJiZbyWM7wSxnjZDrPVmXg=@vger.kernel.org, AJvYcCXZgqz8crYUgKqGBoGxzNNUgOiEQmSsIXiZEc9VRKmdXd1bTcaWMwHvT7h7QWrxucTsTctRQP+/obs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX5wOZYI/y8S1vEI9VMIzPO2ereTgsr8kmlFriKWqmIGZaDnNQ
	11zrlHj67/0C7/yxFQgV7OlZHS7eMqFBy6px9BtiFSQ+d9fwaiEDXYqrh7ZosFJBmssmC3yOrnn
	gfX7it5iFxje8xWYK+6IpLK1DDIvcILU=
X-Gm-Gg: ASbGnctygxuI7VBOPb+NnYhoeUa1iptAihb388+oagSi0AqqV+PLfeSx8a5IHLnFB6m
	2KktXRMg0dFSAi/YztbkL0h5A27OjgweYJ7Dyj2Thq2hjcuCRLGN6CZt46FLfx3O5CoOzwfMVs6
	75qI3OJ85O89X3aEc+WtWpktF8a6FwMWOY
X-Google-Smtp-Source: AGHT+IE1Ts3sIukVdzxxpsexTNf3HAtq3Dwiv478kNTWPjzbcBoadvYcONjdB7Hlj450RyE34iWTbGW6YQggun7qMtE=
X-Received: by 2002:a17:902:fc48:b0:22e:7633:1755 with SMTP id
 d9443c01a7336-231d453dd3dmr69905575ad.12.1747655403819; Mon, 19 May 2025
 04:50:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747634382.git.viresh.kumar@linaro.org> <68906d67109c3b323b54469fb1ee44e10c1c5b1e.1747634382.git.viresh.kumar@linaro.org>
 <aCsQylyW7R5rC15m@pollux> <DA03Y4OQIZ50.157T5EEVHQVMI@kernel.org>
In-Reply-To: <DA03Y4OQIZ50.157T5EEVHQVMI@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 19 May 2025 13:49:51 +0200
X-Gm-Features: AX0GCFv2CorIZuOygV417OfPDUe4RrbuOHrnm503Kv8uaSCtXaPRF6KDnmmX3UQ
Message-ID: <CANiq72kRxCttbyxJjCBPCuDyX-29XCkhECY3k6GvRrCJ5W5H7g@mail.gmail.com>
Subject: Re: [PATCH V12 13/15] rust: cpufreq: Extend abstractions for driver registration
To: Benno Lossin <lossin@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, 
	Nishanth Menon <nm@ti.com>, rust-for-linux@vger.kernel.org, 
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>, 
	Yury Norov <yury.norov@gmail.com>, Burak Emir <bqe@google.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Russell King <linux@armlinux.org.uk>, 
	linux-clk@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, 
	Andrew Ballance <andrewjballance@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 1:41=E2=80=AFPM Benno Lossin <lossin@kernel.org> wr=
ote:
>
> Since I saw you mention this multiple times and I agree, I created a
> clippy issue: https://github.com/rust-lang/rust-clippy/issues/14848

This is https://github.com/Rust-for-Linux/linux/issues/1128 -- I agree
having it done in Clippy in a general way would be ideal.

Thanks!

Cheers,
Miguel

