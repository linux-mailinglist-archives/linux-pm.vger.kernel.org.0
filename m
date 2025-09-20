Return-Path: <linux-pm+bounces-35100-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E277B8CEFD
	for <lists+linux-pm@lfdr.de>; Sat, 20 Sep 2025 20:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 201AE7A3BC6
	for <lists+linux-pm@lfdr.de>; Sat, 20 Sep 2025 18:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74003313281;
	Sat, 20 Sep 2025 18:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="iC6oMZYR"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1C923AB9C;
	Sat, 20 Sep 2025 18:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758393822; cv=pass; b=oXi3TDThrjO03ORoP1ePn/ICm7nUlySEXi6wI0WLbDCHv3CmDd1+55od62V3Bnjd5EcIxflr3QnWgQH88aADP/20dqMj9TYOTN+LBf/E2oBoMAWvQSfrs7Fw/ycpWoE5UCVAxHSjqAJiSNhk5fLs55h827cyPYT6987k0zrA2lM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758393822; c=relaxed/simple;
	bh=R5HRn2PgReoUKMx1eBc0jNxUugrZtBDmynmUJ5SSmPw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=L1A+YFg2WqDNEwXRONETQI9Si59ec9OWe2btxMQ9Z8iz1EWDxJ5g7uLx/tj7bOOya6un3K+cu3ZZGGZOuypG0kscPvrrgTfcTG9hn7/MYkrA/+lTn6OPbGUkGgUlQtn+/JoeDol0NuUgn8I//FsozGEuehDDKlDRbZ2AR/Ys6L8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=iC6oMZYR; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1758393802; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cEgYZDLzfRP3m0D9gSl5NMlItx9GewrgEUTZAiHK3nGSyIXs4DaNdHMHzfnKYiIACio1d4WeTBfmRlAWFVRdcfpggn2YdGsPmz1NJY9Vw0PQFLfGOw5lQ3b+8OhhzOtMu5tMEgfrYAlC33/OyhuUlYY6DN4FhcDLXQxEgY5hKlU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758393802; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=R5HRn2PgReoUKMx1eBc0jNxUugrZtBDmynmUJ5SSmPw=; 
	b=DqxVBuq2QpZPyjeW57aAHrzuN/LZRdAqTtRxX2/7pWM9Jt872YpvI4tdTyUKnVMpmZOQcq8mM7oROAo/QcwJro9USQgCZH/3+ISIsouhddS8kGOTlnXkDxBtBZxoCuszdUsNqQlNR6aQ5DbWbF8FZEwThWEFNdCa6hR8Kxou4xs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758393802;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=R5HRn2PgReoUKMx1eBc0jNxUugrZtBDmynmUJ5SSmPw=;
	b=iC6oMZYRwJzyxocUOTGpkz0W+HXvdWA/p+MCy8s4jLrgF/+jujT7eZb5sndiChgw
	xzLdjOImTgm74cJIoy6Mip+/rXXKSL1nSEi+dWRHMfO+Ub3UwpbxXxtuMT4omCRgK3R
	VdatzvX+GUurkMZ4u6vXlFq6VXMKjGTBv+beyh9U=
Received: by mx.zohomail.com with SMTPS id 1758393800802877.2320752719693;
	Sat, 20 Sep 2025 11:43:20 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v2 1/2] rust: clk: implement Send and Sync
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <CAH5fLgib2a7UK0cYqy1cM6h_OZDMWf+JX+KpXXCJNTZchyfP5A@mail.gmail.com>
Date: Sat, 20 Sep 2025 20:43:05 +0200
Cc: Stephen Boyd <sboyd@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 linux-clk@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0EAFA337-2E62-489E-9C22-61A6E1813C8A@collabora.com>
References: <20250910-clk-type-state-v2-0-1b97c11bb631@collabora.com>
 <20250910-clk-type-state-v2-1-1b97c11bb631@collabora.com>
 <aMG6JVMcMxVuX7De@tardis-2.local>
 <3D936C1B-FBA9-4964-859C-84BB665BBE3B@collabora.com>
 <175834480479.4354.6269916774389395049@lazor>
 <CAH5fLgib2a7UK0cYqy1cM6h_OZDMWf+JX+KpXXCJNTZchyfP5A@mail.gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 20 Sep 2025, at 19:12, Alice Ryhl <aliceryhl@google.com> wrote:
>=20
> On Sat, Sep 20, 2025 at 7:06=E2=80=AFAM Stephen Boyd =
<sboyd@kernel.org> wrote:
>>=20
>> Quoting Daniel Almeida (2025-09-10 11:47:30)
>>> Hi Boqun,
>>>=20
>>>> On 10 Sep 2025, at 14:49, Boqun Feng <boqun.feng@gmail.com> wrote:
>>>>=20
>>>> On Wed, Sep 10, 2025 at 02:28:27PM -0300, Daniel Almeida wrote:
>>>>> From: Alice Ryhl <aliceryhl@google.com>
>>>>>=20
>>>>> These traits are required for drivers to embed the Clk type in =
their own
>>>>> data structures because driver data structures are usually =
required to
>>>>> be Send. See e.g. [1] for the kind of workaround that drivers =
currently
>>>>> need due to lacking this annotation.
>>>>>=20
>>>>> Link: =
https://lore.kernel.org/rust-for-linux/20250812-tyr-v2-1-9e0f3dc9da95@coll=
abora.com/ [1]
>>>>> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
>>>>> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>>>>> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
>>>>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>>>>> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
>>>>=20
>>>> This tag list looks a bit weird to me. Why is there a SoB from you
>>>> before Alice's SoB? At least for the usage I'm familiar with, =
outside
>>>> the case of Co-developed-bys, multiple SoBs is used for recording =
how
>>>> the patches are routed. For example, if I have a patch that has my =
SoB
>>>> and I send it to you, you queue in your tree and then send out to =
other
>>>> maintainers for merging, in general you would put your SoB after =
mine in
>>>> that case. But I don't think that's case here? Alice's patch has =
only
>>>> her SoB:
>>>>=20
>>>> =
https://lore.kernel.org/rust-for-linux/20250904-clk-send-sync-v1-1-48d0233=
20eb8@google.com/
>>>>=20
>>>> What's the intention of the SoB tag here?
>>>>=20
>>>> Otherwise the patch looks good to me. If we get the tag list =
resolved,
>>>> feel free to add:
>>>>=20
>>>> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
>>>>=20
>>>> Regards,
>>>> Boqun
>>>>=20
>>>=20
>>> You have to include your SOB when submitting patches from others.
>>>=20
>>> This is something I tend to forget often, so I made sure it was =
there. The
>>> order may be indeed off though.
>>=20
>> Yes the order is wrong. The first SoB should be the commit author.
>=20
> One optoin is to just land the original patch:
> =
https://lore.kernel.org/all/20250904-clk-send-sync-v1-1-48d023320eb8@googl=
e.com/
>=20
> Alice

I guess this makes even more sense. I was hoping to land these two =
together,
but clearly this will not be possible for the time being as the second =
patch
has no r-b tags.

=E2=80=94 Daniel=

