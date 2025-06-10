Return-Path: <linux-pm+bounces-28354-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03334AD3354
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 12:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72D10161364
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 10:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B799728641D;
	Tue, 10 Jun 2025 10:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNxX638I"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F8025D8F5;
	Tue, 10 Jun 2025 10:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749550363; cv=none; b=Iz5UJ7pxhBcXJvBkdRwV8N3SAj2v1JDOllcnVUBKYtUydI6U7HCTHITUHPYEopDB9rrqJnMQIBbVmjXJCeYFiBZEsfZzmOYN3uyPJfwxX8N/c8qHZSbrBEXGlmGVnmpfi6qBpTKvodVvtbmodr9aaGNNO70jsefxrXdjYF3+5wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749550363; c=relaxed/simple;
	bh=ST5N4y7efa3WI81pyAb9EfnKKmnc6+2XM1s9J2ylets=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=NQz82sCuU6z8QgM5//XGLTdvPkpLhlGElZFctt6nUiCLxVNfYwREZfsAIrAOaBa/fYiS6JrQVRcicdfVnM8LFD8mb1nTnnym1nW+hjAfY8roEbhzlafna7g1T6elCBDnN0yGV4YNMFki+p51o5wU88Nd/OIGE58EDGDB8bU6TWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNxX638I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B36C4CEED;
	Tue, 10 Jun 2025 10:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749550363;
	bh=ST5N4y7efa3WI81pyAb9EfnKKmnc6+2XM1s9J2ylets=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=GNxX638ICb6jA3ELDYkyk1s7ytMLGeQ8sQ1q+WnmBdHE0FHZeqPPV30patlKk4h3W
	 Q7La763WOAZo37Ae1wurznNwOd521J9iYShUqkx7boJ960f/U7Vcsr8x1UF4TsHtGX
	 DpeV/5AH3Z8eQFuiv2AnZU6sdDqBEME3Q3Djt0SLtCvCWKCk6b8IABBhUxYStwdJCB
	 5KZaf85Gd2aYMnXlrgxBaoPkQETCfw5Q2GDIkQEDp0OT01bDvQROABLvAvnfWpRipA
	 I/Lh2T81rYpxt92Xq5FGmG0FPcWrqaTneDOpcKrpQOGxf15rVIH3Spk2ND9Hhp4rsh
	 2aPg25kRyu4yQ==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Jun 2025 12:12:35 +0200
Message-Id: <DAIRU9INPO8A.1PLCLKFJJGODH@kernel.org>
Cc: "Guilherme Giacomo Simoes" <trintaeoitogc@gmail.com>,
 <rafael@kernel.org>, <viresh.kumar@linaro.org>, <dakr@kernel.org>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <mcgrof@kernel.org>, <russ.weight@linux.dev>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <leitao@debian.org>,
 <gregkh@linuxfoundation.org>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <fujita.tomonori@gmail.com>,
 <tamird@gmail.com>, <igor.korotin.linux@gmail.com>,
 <walmeida@microsoft.com>, <anisse@astier.eu>, <linux-pm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH] rust: module: remove deprecated author key
From: "Benno Lossin" <lossin@kernel.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250609122200.179307-1-trintaeoitogc@gmail.com>
 <DAIQ9342ZFYD.3VQVI80A18HKX@kernel.org>
 <CANiq72kC1j-kprAQ5WU0QVV_zhyKfDPJ_M5E9xZ+8+fxt4R6qQ@mail.gmail.com>
In-Reply-To: <CANiq72kC1j-kprAQ5WU0QVV_zhyKfDPJ_M5E9xZ+8+fxt4R6qQ@mail.gmail.com>

On Tue Jun 10, 2025 at 12:03 PM CEST, Miguel Ojeda wrote:
> On Tue, Jun 10, 2025 at 10:58=E2=80=AFAM Benno Lossin <lossin@kernel.org>=
 wrote:
>>
>> Unrelated to this change, I think we should add email addresses to
>> people in authors. Possibly enforce it by scanning each author element
>> and checking if there is an email address.
>
> Sounds good to me, but I am not sure if it is possible in all cases.
>
> At least looking at C, there are company names too.
>
> I even saw a URL...

Hmm, I guess a checkpatch lint fits better then?

---
Cheers,
Benno

