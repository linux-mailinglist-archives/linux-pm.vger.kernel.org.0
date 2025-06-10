Return-Path: <linux-pm+bounces-28377-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22996AD3834
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 15:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56B99167EB9
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 13:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A9F29A9FE;
	Tue, 10 Jun 2025 12:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGzKdesq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC35F29A9E1;
	Tue, 10 Jun 2025 12:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560163; cv=none; b=c/nBUtBmob7Zs/xyYEM8nt8LNHPzF2welh6qMRbavR1fXbDAr9UjjijSB8wNnwr0aFVHlbPTAIEeXIH7RtEMdDrl/bcD3AMqvFwQSG3OC+295Y8Qauvd7SNlel3Bgp44Fhc3rWPapoKh9RurTgheqgVUobLJUhZbCizAyuaBTIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560163; c=relaxed/simple;
	bh=ymdmRNA1an7znV7VwE8aKDdd9upCMjadrk7wwCN+JS0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=XIW2jolqGctnmyLh2WQc3+AO90rwPXRU5jap0AVVfr6fUR5sTWcj5Qkiz7kUR+yWi0GjT5ZqQsL6HLH/R4jCkYkXlMwgqYsqcncz+wBqt+wUbRyFaNH7eApX9jH3PswsMVpUrZxtz9xCAkfC4YT1ovRTd4hIPX684+JmcgCcGHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGzKdesq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB62C4CEEF;
	Tue, 10 Jun 2025 12:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749560162;
	bh=ymdmRNA1an7znV7VwE8aKDdd9upCMjadrk7wwCN+JS0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=iGzKdesqdm1MrpyWKVIbnnnTO2O5kjtU0RWXuPsX72qmoBIf1+QGRaRjgZ2tudgyJ
	 r066JMd+OFmUd03hH7AREG3eFtPRIYeT5fffPBhRHTDNsYzZrn6GSXuoczYlB+tFEM
	 Xv83cl923uHkQY0nVAc6FsJLFl6Xy4uunqWmjZpzls9Pcz/9aoH+/TifQuZ8u0DNrI
	 nrPNp24G+J/OqKYjScTqVdrdyOBtof8CkpfQeM/WEzZpnj9R7LbpZfTUgnHFRF9Fse
	 9ejaWmya7EgYDDrJ7BRajiE9GTVPe8gd8UDUzd+NxnZW5xx5LIyQvYxetZHzMia4dg
	 ACzOo9EY8FAwQ==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Jun 2025 14:55:55 +0200
Message-Id: <DAIVBBJADWNR.1LLZJ6YWV8IN2@kernel.org>
Cc: <a.hindborg@kernel.org>, <airlied@gmail.com>, <alex.gaynor@gmail.com>,
 <aliceryhl@google.com>, <anisse@astier.eu>, <bjorn3_gh@protonmail.com>,
 <boqun.feng@gmail.com>, <dakr@kernel.org>, <david.m.ertman@intel.com>,
 <dri-devel@lists.freedesktop.org>, <fujita.tomonori@gmail.com>,
 <gary@garyguo.net>, <gregkh@linuxfoundation.org>,
 <igor.korotin.linux@gmail.com>, <ira.weiny@intel.com>, <leitao@debian.org>,
 <leon@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <maarten.lankhorst@linux.intel.com>,
 <mcgrof@kernel.org>, <mripard@kernel.org>, <nouveau@lists.freedesktop.org>,
 <ojeda@kernel.org>, <rafael@kernel.org>, <russ.weight@linux.dev>,
 <rust-for-linux@vger.kernel.org>, <simona@ffwll.ch>, <tamird@gmail.com>,
 <tmgross@umich.edu>, <tzimmermann@suse.de>, <viresh.kumar@linaro.org>,
 <walmeida@microsoft.com>
Subject: Re: [PATCH] rust: module: remove deprecated author key
From: "Benno Lossin" <lossin@kernel.org>
To: "Guilherme Giacomo Simoes" <trintaeoitogc@gmail.com>,
 <miguel.ojeda.sandonis@gmail.com>
X-Mailer: aerc 0.20.1
References: <CANiq72kORZjTe3tPEBueDi57TGF7KfxgTSw4Tn0DQeK_X5hi5A@mail.gmail.com> <20250610123731.194853-1-trintaeoitogc@gmail.com>
In-Reply-To: <20250610123731.194853-1-trintaeoitogc@gmail.com>

On Tue Jun 10, 2025 at 2:37 PM CEST, Guilherme Giacomo Simoes wrote:
> Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrotes:
>> On Tue, Jun 10, 2025 at 12:12=E2=80=AFPM Benno Lossin <lossin@kernel.org=
> wrote:
>> >
>> > Hmm, I guess a checkpatch lint fits better then?
>>=20
>> Yeah, that would work.
>>=20
>> Probably for the C side too -- from a quick grep I don't see it.
> Maybe, after this patch we can make a checkpatch change for check the `au=
thors`
> key (and MODULE_AUTHOR for C side), and throw a WARN if the author is a n=
ame
> (not a url, or "rust for linux") and don't have a email address.=20

Most other authors fields that don't list explicit names use "Rust for
Linux Contributors", so we should probably scan for that instead.

But I think that we should no longer add any author fields using that.
Things with that are from way back in the day (when RfL was still out of
tree) where many people contributed to a single file, hence the use of
that phrase.

> Unless you guys tell me otherwise, I guess this is not so priority.

Yeah this isn't high priority. We can just make this into a
good-first-issue, then someone can eventually pick it up.

---
Cheers,
Benno

