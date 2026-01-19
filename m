Return-Path: <linux-pm+bounces-41069-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A41D3A167
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 09:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D34DC301957B
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 08:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731E133C1BC;
	Mon, 19 Jan 2026 08:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRiSVeWn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F4D33B97B
	for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 08:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768810814; cv=pass; b=cJ7m40m45io0UX6m5FAIv5ra+EXMX2nlxTx67T6jcQteXANR20j0o1p3oM7EdBAUl6yeispnBbDEoTKgZ3xzp1hgDBhVSdWeyBIwwiOY/mN1g+4YEY2V5+QM8hVdTgSK2uRlFycDgx3bb6s1JjN+94fp6M6M6c3NFrNblwV7GyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768810814; c=relaxed/simple;
	bh=1OYoSnQPQ6tygAvVT+bdbhRQI7JtOGMwYUUCyliHotM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rav9kl4kGu++mLZtyxbO1HDm8Ku7M/4I9rBAcymOL3K5IkeuExa7r1iirhDEjLL/Dqf6auh4A1mtt2Pdp/xi1hN3qgmRv295doEvaYAOegpt9wujWFcPOguyZFN/3/HbqpTrE6eZ/EwZoWtkXHgaj759g52Fgoj+TwJrfjzzqX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRiSVeWn; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2ae5283dae8so248342eec.2
        for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 00:20:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768810812; cv=none;
        d=google.com; s=arc-20240605;
        b=D6TPYYzBzfnelQknzQZGxsZUheTLTVOgm8BOpclIAJBRvJYTf/U94mEQbndRaOUkss
         fu+hO2odeEXGjxORFQ4i0foL/1YPKioRFLsbMBdVaaU5kMbq22i1wcY99RwY6l3WYZhY
         uTBQjrrvUQBKgYrn2XUtRQRpif/xQdNY+pqUFwNwSX1s/vi0+4RtfSBfkoDkwLelYaE5
         GfNn30of62dYNf4ldDviBCX/SfhkSQxTH08lmUd8rac54rQlazxpzVTDQNMGYPw9AGaG
         9r6XK5DGBZ0z6DhuwxsgAUH71PgzczYdKrLGITm4tlJGFnjHZM9sevGQNt49uFtRew0u
         KVRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W4qwFK8ioKelkojLIJh2X9LVVg4pbqzpYUCaeu6PnLY=;
        fh=griIdKXNXuw/UyG5sSBwnbfQLfzcxfWDz11ixDOOEg0=;
        b=Dbu9J+GiEn7R3qwQev8GXQ8QEqIEkzgLIIEoznWgRlCuarecoB7biVXu9vCul7PQvo
         hyVP9uYW4JWBiLFdc1wtxr5302Ltq4bCSPdv93sEhS2D1Yece87phV4iV2UORl/JzJDE
         UgR7oLKuc0Ii2oieWG89FPdagVVZ/cYaXpKVM45NX86n9ShS5sJkj5rowMpnMcGw6il2
         8j54zBord+5t2+6rQ4CKJw68lCHLoQIdwdHz1kCb+oEA2f38EcdRIjH1oYgaEQpdSrln
         iZxvFC7j/Ix1hJHVNXu9B2p5gVgS0/8EwVsGKyZX7YgwA2V7uyJeAC5fpnX+wsYxqDSb
         6UGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768810812; x=1769415612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4qwFK8ioKelkojLIJh2X9LVVg4pbqzpYUCaeu6PnLY=;
        b=CRiSVeWnI66NeHgEmY9JPjeyk9loebw0pCNF5Rpbov0OnMVS1yPnthleOm3g765guR
         Kuc7WPFpfA86plbxg9Fms5pKQbyyj4tF5KsjiJ8Z9jt0faVj+ux8JqZCCgUWc4he+nxq
         1/mPyRUsJY6s4U+RPsDfrrXrnqxj40hautBt+Ww1pWl3hmhf+Q/WjFL721EfK3rTcJi2
         XiOhCIb23jSiWnun2C692LsTScD5FFULEVnB8aG/sSv2p4Q2osUt/xu5k6hSysaF2CSk
         SlBXEZlOV2Vw0zxHv/jUrExKt1Tqi8+cdCRXnjIPFIcCXtUqqS1CDUSuXwggF2cch/Ox
         jhJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768810812; x=1769415612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W4qwFK8ioKelkojLIJh2X9LVVg4pbqzpYUCaeu6PnLY=;
        b=CaGu6p1YCL2IHcy09xZ2qu+9UU6ABqhIiiTD+DID1NG9G9RI7w15DUXGkstgxZhnlE
         IBMNslxoQWOXCimLGCmpyKHXbVSbuKX8txpD0//WKd4vLRLFr9skXqiElOaKFsGtpOHO
         8ew1QAJ+IObUndKyjfUAltgUsVN0XxtPYzyBlYyByL2lHvE6lDynwBn+LoVPnr8Da9cS
         MF5rdsc8qeRCPfIcaqRXzVIY9nS826+eMMb6ofGR70P/EO5M5NOogUP1dPmLXDvNDqMN
         mv5hz5bsPX35hCoqEGOg1VJ3cCsZ0m9k04mqydm0cwicjttL6i+4cjF8NmtCSbQGx0Oz
         8+nw==
X-Forwarded-Encrypted: i=1; AJvYcCW96qhG/oIx/ZA4HtzQFQ2sSTdoBtDjpkHBK1HIV6wrqUaRmTBlRh00IvGVfrYAV3BowBKGCQRG0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYhB4UyMso26JDdM/sjnHwT4m+eqaKzVY/sTTKE09epbqx1fQj
	ltwAvTQTI4qJoo9CyNSZaIhJdj7DrsSKObuoyC377FmtOviSRGU1C/SSD0k3YJ2o2VHSc3ICpW3
	bqPBqE9qxdZNeFXzYXHWIWyIK+MXthU4=
X-Gm-Gg: AY/fxX6Uh43u8kcV42SLudzWExFgReDmAcfhscD+P5lSDBO9te3gsykf3MJBihDTnRz
	UBQ2aVjIXA0EYImhOBodRzalrvvwotkKs5rkMcmr4XzA01Ys8W1QVnp6n/TMIM+RtrAI8dPmdQ4
	32/69kTDTa4cm433M3OVxeyHk+vF4as/nrSbwmppv1uJC97RjhxF7WfQVGXC2E7rtCYOfq+diRb
	rgNYvHy8YM9mD3C77d6dXiwdDyW/wh6zv7zH2YrjD3AERRIXq2hcEBEg5b69qsYfk/brYE7M0Ek
	THSkntGCLxsSSnij9NfR22EIMB9VU34JEdQzUsKt9ejOBa9IuB6z9j0lGf+214wW6LHqLNH+mCY
	nqIQEWDXx5HGk9YNnTNdaI0c=
X-Received: by 2002:a05:7300:f18f:b0:2b4:5d92:3e7f with SMTP id
 5a478bee46e88-2b6b3918011mr4284330eec.0.1768810811849; Mon, 19 Jan 2026
 00:20:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208-io-build-assert-v3-0-98aded02c1ea@nvidia.com>
In-Reply-To: <20251208-io-build-assert-v3-0-98aded02c1ea@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 19 Jan 2026 09:19:58 +0100
X-Gm-Features: AZwV_QhxAiFaIcvwX8h9uKf6H4azma3UhOyTlcnZ27Zijuat-yr3VdVO8Qat4vs
Message-ID: <CANiq72nDtcSQ=GPvGUObaxqA6WaOGM8oUCqV80k-Sxm3zT5G=A@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] rust: build_assert: document and fix use with
 function arguments
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 8, 2025 at 3:47=E2=80=AFAM Alexandre Courbot <acourbot@nvidia.c=
om> wrote:
>
>       rust: build_assert: add instructions for use with function argument=
s

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel

