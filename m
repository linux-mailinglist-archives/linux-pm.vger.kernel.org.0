Return-Path: <linux-pm+bounces-43041-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DQXLwZsnGmcGAQAu9opvQ
	(envelope-from <linux-pm+bounces-43041-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 16:02:30 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B6E17863D
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 16:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A801301301B
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 15:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3AF276038;
	Mon, 23 Feb 2026 15:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubEKdO1F"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D8C2376FD;
	Mon, 23 Feb 2026 15:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771858856; cv=none; b=B028ajxOkXYQqrYMajrVe3MMo8b+eYTTR8SCkIHOFxz7/iiI86gkokNhtloowQd0Wn8JYgc153r/NYVFaTsvXxmFJDMFMYoaG0TtVppYiYZSuDppnU1toK5xSZ3VIAEY/o5RsstUpN5D/kTfKR+RyJx81ypjNUR1GAYAjeHTq9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771858856; c=relaxed/simple;
	bh=LZJWPyqc7zRDNeLJ/kaMnDCbQKW6iC+a3VJo41M3xIE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ofvs7gsyLXnkSr8BiOhqnIBjPuDBAMsRC93LmBHWm6FMkBMWvlGEYl0F55fzlKmn5X6X0ka02qpanxclmFkJeRHTb+gdIB7o59bfS4vcyGTCW3sAMNge4z6qyCEJAOQ8zuc+LaW4y/+0pcIRuC1CvvOiuO8llYnbEUHheVmh4bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ubEKdO1F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B72C116C6;
	Mon, 23 Feb 2026 15:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771858856;
	bh=LZJWPyqc7zRDNeLJ/kaMnDCbQKW6iC+a3VJo41M3xIE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ubEKdO1FeQU4KehKkk4Ha+sWn8rhfohWnTzrm5CQTdxfLOh0UTSboTY5F7p1nHvdb
	 c9CXLVWjqNOPyM3IFuKtP5z1azU7USMNNrUpB7SeVFwk3RoAJYzLxs1vztVb8aZ0Dg
	 +JUgamzo3UrhAJN82wQ+cEgtBc6YV+GtEuO3fPoqKYljQW/zE+0q9rjOMZyhojRUaX
	 oaVPUfn3nyPnD1VlIIcPzhKN1gu3nthfg40z8QQBwjBa2qQIklIls4ZYFZ4SJgFW3H
	 mMimssaZEdP8xcE7negFA4+KTvkjEOlgRnMa7kVg1pSO+AhJHvtIApe4ftxUg+oYUJ
	 HNgCcU376zbaw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman
 <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, Leon
 Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge
 Hallyn <sergeh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Alexander
 Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Igor Korotin <igor.korotin.linux@gmail.com>,
 Daniel Almeida <daniel.almeida@collabora.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen
 Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Boqun Feng
 <boqun@kernel.org>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
 Oliver Mangold <oliver.mangold@pm.me>
Subject: Re: [PATCH v15 3/9] rust: Add missing SAFETY documentation for
 `ARef` example
In-Reply-To: <CAH5fLggNjCZ3AvHnhO8O0cmd33B3zMbfq+hhNvonznTsLLtgYw@mail.gmail.com>
References: <20260220-unique-ref-v15-0-893ed86b06cc@kernel.org>
 <20260220-unique-ref-v15-3-893ed86b06cc@kernel.org>
 <CAH5fLggNjCZ3AvHnhO8O0cmd33B3zMbfq+hhNvonznTsLLtgYw@mail.gmail.com>
Date: Mon, 23 Feb 2026 15:59:52 +0100
Message-ID: <87v7fn33pz.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43041-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,umich.edu,linuxfoundation.org,intel.com,paul-moore.com,gmail.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,collabora.com,oracle.com,ti.com,google.com,vger.kernel.org,lists.freedesktop.org,kvack.org,pm.me];
	RCPT_COUNT_TWELVE(0.00)[39];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a.hindborg@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,pm.me:email]
X-Rspamd-Queue-Id: 33B6E17863D
X-Rspamd-Action: no action

Alice Ryhl <aliceryhl@google.com> writes:

> On Fri, Feb 20, 2026 at 10:52=E2=80=AFAM Andreas Hindborg <a.hindborg@ker=
nel.org> wrote:
>>
>> From: Oliver Mangold <oliver.mangold@pm.me>
>>
>> SAFETY comment in rustdoc example was just 'TODO'. Fixed.
>>
>> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
>> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
>> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> ---
>>  rust/kernel/sync/aref.rs | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
>> index 61caddfd89619..efe16a7fdfa5d 100644
>> --- a/rust/kernel/sync/aref.rs
>> +++ b/rust/kernel/sync/aref.rs
>> @@ -129,12 +129,14 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
>>      /// # Examples
>>      ///
>>      /// ```
>> -    /// use core::ptr::NonNull;
>> -    /// use kernel::sync::aref::{ARef, RefCounted};
>> +    /// # use core::ptr::NonNull;
>> +    /// # use kernel::sync::aref::{ARef, RefCounted};
>>      ///
>
> Either keep the imports visible or delete this empty line. And either
> way, it doesn't really fit in this commit.

I'll drop this for this commit.


Best regards,
Andreas Hindborg



