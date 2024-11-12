Return-Path: <linux-pm+bounces-17444-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDDD9C6104
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 20:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E8A6B2F21E
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 16:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAB4205140;
	Tue, 12 Nov 2024 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1F3bxuX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D628A205138;
	Tue, 12 Nov 2024 16:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731428659; cv=none; b=bkl0Pe/YW7HNbGiI3cIXYigL3pCsqMRIBQWgvPSFJI3EpnmuJO7x8jmVNTh5uYM60J+ONQZvp7gN4T6KgaLEaY49HdjwdnBZKUf5bPLYL8GY5u6HjnPDnH3U/hICUI15unf64uA3+9Ccle7ePN4hM/VAOW0Tv7TiFp45INd2ZKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731428659; c=relaxed/simple;
	bh=s95mfkrvbz5oPWBac8QWmV2twOt3oYg3Jze+97EpbQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HnkfpzeCq0MKkgXJGHe4BjKnB63qxdk+kZ26CKJjNWVPaTd6fNdAAt2zk1NY15xeZ9GcbNCG/ZIXQbWZraiyT629Wqssul2TPuFxk0RLhmRdJiND78wnItye5b6cJnDao5bUYlFT1GrQSpy1UInB2i4NUk8MleR5PVJgIzgSy2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1F3bxuX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DCEC4CED5;
	Tue, 12 Nov 2024 16:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731428658;
	bh=s95mfkrvbz5oPWBac8QWmV2twOt3oYg3Jze+97EpbQk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=q1F3bxuXwt9aUKuGmjhS7Mp3u7p+O1iHz466ZKZnlho8YT/A4+m21yPpl3yA4CKj5
	 980okCRNMdeQOUgJWzWsI57X729uBj9mqlkvNcWCcKyPOueCvXLwDtdfYmmyiICceq
	 rBDUu6K1zW2SG7K9zO53B9jeeQYPN2MrYbHiV0t4RngIM3+U9F8Y8iR9ddcLLngEjJ
	 87BkKbptnSkq8EbLxCfq4jwUy9mq5J2Zrj1JOzpF3ztPdgsI4i4jCSMtZatohwQIWN
	 ee8K6JCfoBfm9z5Nsu/PpAZ1QDb3T1XnzOkyI5LayKxQZUFD1Rc+JUiQN9Z9jpFYSR
	 AOHGhn4LldeYA==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-295cee3a962so545732fac.3;
        Tue, 12 Nov 2024 08:24:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUVCM8chJXiSftVGgi+KmvTbuyAmB3eUBTNCT5ZoyIuuu4hI1a7cgDIsijTgAuvztrzSDxx9B5PlvvqInI=@vger.kernel.org, AJvYcCXTU2IJdJEWSDAST56VsSqq9l3CM6BqV8jSMCuPiTq2Nsk0YjO978448+yRD/f8AYeOyOAE0ZSvzx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIWz4huROTwdw4HLfs9dIlY/+rRlbfZMX4oGUmWxDr5TrdX9Za
	bxYcXCquJK569AaU8RaGehi732FwMCXNcpeJu977s5efMsve9lvXDG0pJU61IhZgUI307tuyCHY
	cqk4BZlb8rIw8U180tnQpnTi4w3w=
X-Google-Smtp-Source: AGHT+IG5ncNWe9E9kh3G8QBT2LnCSvsPqWHFHNXZX3LOhEgK776cpzGzZcqW3BUCEI09DsW/i/kR2tEl9XpBF3yaH4I=
X-Received: by 2002:a05:6871:292:b0:277:c216:5273 with SMTP id
 586e51a60fabf-2956008f7a9mr13343199fac.18.1731428657717; Tue, 12 Nov 2024
 08:24:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108122909.763663-1-patryk.wlazlyn@linux.intel.com>
 <20241108122909.763663-3-patryk.wlazlyn@linux.intel.com> <20241112114743.GQ22801@noisy.programming.kicks-ass.net>
 <CAJZ5v0ivAk1xrcJgiJnDWnL3GdijSdsuV4K_4ORjnsjPUVAEnA@mail.gmail.com>
 <20241112121843.GF6497@noisy.programming.kicks-ass.net> <CAJZ5v0iSP4Gh2FwKdkOw20N4hzwQ94+WmnT+3EY94QG3gORWzA@mail.gmail.com>
 <20241112134959.GG6497@noisy.programming.kicks-ass.net> <CAJZ5v0iYYYpg7MDf8_UmoUuzyiPMoPdjgSJmdBXGYCxVc4icWw@mail.gmail.com>
 <20241112150809.GK6497@noisy.programming.kicks-ass.net>
In-Reply-To: <20241112150809.GK6497@noisy.programming.kicks-ass.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 Nov 2024 17:24:06 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gvTgR8Y5Rv+Vi2ORbeAGe9h-NxZNUCcn4JeUUsjg0Xyw@mail.gmail.com>
Message-ID: <CAJZ5v0gvTgR8Y5Rv+Vi2ORbeAGe9h-NxZNUCcn4JeUUsjg0Xyw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] x86/smp native_play_dead: Prefer
 cpuidle_play_dead() over mwait_play_dead()
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, artem.bityutskiy@linux.intel.com, 
	Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	rafael.j.wysocki@intel.com, len.brown@intel.com, dave.hansen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 4:08=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Tue, Nov 12, 2024 at 03:56:22PM +0100, Rafael J. Wysocki wrote:
>
> > > So given we don't have any such code, why can't we simply fix the cst=
ate
> > > parsing we have in mwait_play_dead() and call it a day?
> >
> > I'll leave this one to Artem, but there is at least one reason to
> > avoid doing that I know about: There is no guarantee that whatever has
> > been found was actually validated.
>
> It's a bit daft to explicitly advertise a state in CPUID that's not
> validated. I realize that MSFT will likely only ever use the ACPI table,

Right.

> but at the same time, the CPUID bits and ACPI tables both come from the
> same BIOS image, no?

Yes, but the list of C-states advertised as supported in CPUID is
usually longer than the _CST list size (at most 3) ...

