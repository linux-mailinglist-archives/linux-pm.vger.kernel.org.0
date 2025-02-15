Return-Path: <linux-pm+bounces-22149-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2169FA36D44
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 11:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D64FC1701D5
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 10:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C583B19E7F8;
	Sat, 15 Feb 2025 10:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/gPTpAT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7E419006B;
	Sat, 15 Feb 2025 10:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739614620; cv=none; b=ZQkNW4+Ze8VappL8SJhrvLGV7PofEDYZQdfdrtHwIHZk9R0xlhgP6ELpShOnnH+px30JdkInMu76OMv+0B9SBlFFILerZbWqyzbWHGK7KoqsFeiWkvTlkUB75Cy0EsOL4HlRHTRxLv3fr6G7fIxwj4GypO+fDgWa+hBHUTaRBgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739614620; c=relaxed/simple;
	bh=GsKgYX1xa7NXi1RaZVsCH5NQ2ie1ilqAg7v3x+0SYJM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zau7InvXP5qiuv5OeJYr3y7aswtHz62MNGmtNGEEpJEEmPsId4ahvgNc4Img+1uVfrAkbkH2w/6g2oN1PXmLkGDUfACv5h/spEFhN5WGlR7dR3AtJPW/xYinaey52OvZDUB3Oy6tWy8XN1/7LQ3VqdeWQLwEmpYzKPpr8HeGLW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/gPTpAT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231CAC4CEDF;
	Sat, 15 Feb 2025 10:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739614620;
	bh=GsKgYX1xa7NXi1RaZVsCH5NQ2ie1ilqAg7v3x+0SYJM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=O/gPTpATCL3UGOlSCXIy8k7i9GBFtB5l207l+qlgBpTKzZ5CfrRWdSIa9N1Vz/sw7
	 pVKLO9lZPmdsdWyWFMWCazTuL3jw7I/x87vYvIUlGORfx7HKXKlwWSuJJwkYZC+eg/
	 7TUsUOiaMtb7PJdZIxKeXehArXPlnAIfduwO0zOkRvTPo2wLKyawkwBB/0URqLbeQ5
	 Ps1woyHGZ+ussFfDcJSG1ovFwLY/f+lWhw0kcBgBfnMLVvjiclRmgsPXhHRz5vaWtx
	 5GvH7g5KjEDR27I8Jv/2u8Wdl0V63JlDGgAfUuGAzrSnJUvYur9CwyTklZqtq510Tr
	 u7Ui55pwKq3FA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Viresh Kumar" <viresh.kumar@linaro.org>
Cc: "Yury Norov" <yury.norov@gmail.com>,  "Rafael J. Wysocki"
 <rafael@kernel.org>,  "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>,
  "Danilo Krummrich" <dakr@redhat.com>,  "Miguel Ojeda" <ojeda@kernel.org>,
  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
  <linux-pm@vger.kernel.org>,  "Vincent Guittot"
 <vincent.guittot@linaro.org>,  "Stephen Boyd" <sboyd@kernel.org>,
  "Nishanth Menon" <nm@ti.com>,  <rust-for-linux@vger.kernel.org>,  "Manos
 Pitsidianakis" <manos.pitsidianakis@linaro.org>,  "Erik Schilling"
 <erik.schilling@linaro.org>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
  "Joakim Bech" <joakim.bech@linaro.org>,  "Rob Herring" <robh@kernel.org>,
  "Christoph Hellwig" <hch@lst.de>,  "Jason Gunthorpe" <jgg@nvidia.com>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V8 04/14] rust: Add cpumask helpers
In-Reply-To: <20250212073438.bjhfgefz7t4dxobi@vireshk-i7> (Viresh Kumar's
	message of "Wed, 12 Feb 2025 13:04:38 +0530")
References: <cover.1738832118.git.viresh.kumar@linaro.org>
	<db0166341ce824c157d0c58c240b3efc6aec6f6e.1738832118.git.viresh.kumar@linaro.org>
	<Z6qTelPSqpFk439l@thinkpad> <20250211042908.nyftiw7gtxosfjwc@vireshk-i7>
	<Z6t51xodSV21ER4M@thinkpad>
	<RBGMiUDbB5Qtipc3vDNTyX1TxKwQb2WxeNCLgURDEYf6bKOo1eT9he0RlH4B7VYK1tCvqppOBGPdDhwCd2aZPA==@protonmail.internalid>
	<20250212073438.bjhfgefz7t4dxobi@vireshk-i7>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Sat, 15 Feb 2025 11:16:38 +0100
Message-ID: <87a5anv7g9.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Viresh Kumar" <viresh.kumar@linaro.org> writes:

> On 11-02-25, 11:24, Yury Norov wrote:
>> To begin with, this is the 8th version of the same patch, but you
>> only now bothered to CC someone who is listed in MAINTAINERS. This is
>> not how the community works.
>
> Yes, this was my mistake. I assumed get_maintainers would Cc all
> relevant people, but I overlooked the fact that these are new files,
> so it didn=E2=80=99t include the maintainers. Unfortunately, the same iss=
ue
> occurred with the clk bindings. Miguel pointed it out at V7, and I
> corrected it immediately. There was no intention to bypass anyone.

I have to admit, I have done this as well, for the module_params series.
It feels horrible to commit this action, because it looks either
disrespectful or like an attempt to bypass people to sneak in stuff. But
as clarified this is _never_ the intention. It's simply people working
with a contribution model that they are still learning how to use. The
kernel tooling and process is not exactly intuitive to most people.

Just know that absolutely the largest fraction of contributors (I would
guess all) want to do things the right way. For all contributions, rust
or c, the patches benefit tremendously from reviews from domain experts.
The contributors appreciate this and hope for this to happen.


Best regards,
Andreas Hindborg



