Return-Path: <linux-pm+bounces-31341-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6558B0F3E8
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jul 2025 15:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B24607B6CFD
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jul 2025 13:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FA62E541F;
	Wed, 23 Jul 2025 13:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQGBF7Kt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D964F2D29C7;
	Wed, 23 Jul 2025 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753276976; cv=none; b=OiXzib55Y22m6q0f7bj4zHdnwilMRIOsOwGyOiKbsx0NMnXZRvWvE3amJ7B2fASSgNDYb2IIpO3t5i5X1fL+S45B9itcKBpsRjrl84Sf8lMnnwmFwUI9SjRQlVWsH+dE6YarmVa6rW55O6CsvCYZbFAiqdWLGfabZwQCx8wlZ5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753276976; c=relaxed/simple;
	bh=CDbI+Nsj3caOgtI2pJwYkNmOJA/uaxHrC9DvitFk4Q0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=tTRN8Ei9tzmWA/XNmdbOegkOhIUY2IGxiPIOTW7gXSec0hympNQc+37kWaq97CAHucN3fEFONVFIyJgkqrmd/H+iBauY4GRPyJgzXvAk7Ey624DYDb0LuZ3z7+ly3uJthx4ZgJCKpvwaRS86Sy0I7MzSR6VptesAw3HVMxdOPAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQGBF7Kt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC3EC4CEE7;
	Wed, 23 Jul 2025 13:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753276975;
	bh=CDbI+Nsj3caOgtI2pJwYkNmOJA/uaxHrC9DvitFk4Q0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=RQGBF7Kt1lvI3yc5fqBSzO1JPUgFwXu/W8GiL0k9as6EvKM0p/febse+ul/5oF+tI
	 dwYiX9iSKcV+NRTUrF0xJPhSbst3VyULdtSVmoIIZNDc/xqwF0DZkBO/eULLCA2x59
	 dbzM8pciS1JYsfWOE/GkPiONaHfQVFtMqio0Zv/X3EM6KiNYkH0QIWY94FZEs7UuSQ
	 TEalT6ENGYQigsc766rdzE90veMpRLXpgZsm5/N7dF4sBM0Ik04W8kO4cyVstIb7dt
	 q+E+ydRtxxTsLQgBhPsvK/iVPld0s5gOxJMTXIELiNIvH/SaE4UcyjwGrK3YZITLJR
	 d/WTb3PiNGz1g==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Jul 2025 15:22:49 +0200
Message-Id: <DBJGTCPDUU4J.16S98YARG0S7O@kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Georgi Djakov" <djakov@kernel.org>,
 "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Bjorn Andersson"
 <bjorn.andersson@oss.qualcomm.com>, "Marijn Suijten"
 <marijn.suijten@somainline.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Konrad
 Dybcio" <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH DNM 2/2] interconnect: Add a test Rust consumer driver
From: "Benno Lossin" <lossin@kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>, "Konrad Dybcio"
 <konradybcio@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250722-topic-icc_rs-v1-0-9da731c14603@oss.qualcomm.com>
 <20250722-topic-icc_rs-v1-2-9da731c14603@oss.qualcomm.com>
 <D4552EF5-21DB-44AF-8E45-F57B0B8CB853@collabora.com>
In-Reply-To: <D4552EF5-21DB-44AF-8E45-F57B0B8CB853@collabora.com>

On Wed Jul 23, 2025 at 3:10 PM CEST, Daniel Almeida wrote:
> On 22 Jul 2025, at 18:14, Konrad Dybcio <konradybcio@kernel.org> wrote:
>> +#[pin_data]
>> +struct IccTestConsumerDriver {
>> +    #[pin]
>> +    path: IccPath,
>> +}
>
> I don=E2=80=99t think this does anything useful without PhantomPinned, bu=
t Benno is
> the right person to chime in here.

It does do something useful, there just has to be one type marked with
`#[pin]` that is `!Unpin` (so for example `PhantomPinned`, `Opaque<T>`
etc.).

In this case however, `IccPath` is a newtype of `*mut bindings::icc_path`
which isn't `PhantomPinned`, so this doesn't ensure that the
`IccTestConsumerDriver` will stay pinned after initializing.

> More importantly though, why do you have #[pin] on IccPath?

Another question is: why is `IccPath` not a newtype of
`Opaque<bindings::icc_path>`? And then one can use `&IccPath`.

---
Cheers,
Benno

