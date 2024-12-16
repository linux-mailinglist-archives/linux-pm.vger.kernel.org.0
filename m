Return-Path: <linux-pm+bounces-19301-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 071F19F2FE9
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 12:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A886F1884908
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 11:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD0A20457D;
	Mon, 16 Dec 2024 11:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRcbAeYx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46B1204564;
	Mon, 16 Dec 2024 11:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734350354; cv=none; b=G8bA7UruUoMnylT7OQ7XIzYgclEk/5lZ1G7UL/k0DhOKLPxp1ohyV3ul71+Td0+z9lbtHWJVzcuCWYMRopbYDGhDs219TBc+iJ3UecSnfcMkKoNi3oV0zzhAI4JrTusDf3Z5pdOdD96Eb2n3E22vVoXE92SzYHkSDPjx15zNhtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734350354; c=relaxed/simple;
	bh=49bBP0LsMyxtlWCuKKBIlMSYx/JcUqR7Q6/yg4H6FII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qlHDGfK/P8VlIcZb25ld5HQeNMpfscPHKZDr+irIrwGwtJUaHvLSOuNUhkyyY/NjeevhcdkmXSJSP8qFmhFziPeUt1B0NOcAeHgSYYPDz1ZiAI3okasCH2RwvXujaUZoFHAFhPQDQjzliqk825RB7Y45WhSC2YRn7xXId/0ZRpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRcbAeYx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42862C4CEDE;
	Mon, 16 Dec 2024 11:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734350353;
	bh=49bBP0LsMyxtlWCuKKBIlMSYx/JcUqR7Q6/yg4H6FII=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NRcbAeYxKUmqogjXCkFhUbHCCoClu4iY4cxzJVE5fuB4UBVkySamTmr4w6c62sS0e
	 ybzPntEy03/i+lCfJcIQYvSqelIeKoq90G6Lcf/FPfmDH7kBCTb54Wg4dOYi/bnzu1
	 PwRY3L3JoZ2bU8PpxnlAa3TDqHrVpLv4lNNqY7ynnVPCkBVK8h8cXMCOoFuRyupg83
	 ssQLKvxJFNVFlU6fnXfInv+4MutRZ/cLch3kSQ59GH0wWhWuC/YzAtskvYLCUQUhjR
	 4b+B+zmL8y43tSarIqT4hyOgVDvN6cN3GfCLioCMgZMPine1i1j/dh/hlRTJGJUMiA
	 xSmiGSUVVQMHQ==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3eb7ca55c3bso2165236b6e.3;
        Mon, 16 Dec 2024 03:59:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWe79dN1lel1S5oNXEI0wq1hgpD5h9022xa8GMc44nGUnGuTt+waposkeBlq26V9ZSDTDTnbJRwqUg=@vger.kernel.org, AJvYcCX09rNp3UjcNhs5dg9i0pytnAc9unpTmUNsk/si4MbGYcjgxkSwM+QfhNL6WMXoiDhIasJqKR9w11VQN3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhXB/dw02jbUpJBTmxY6HEZOuC8pfDzqJFS3c2yZ+9UPSL/7zb
	EKq/r61jH/Jvv4K25P2rWwP7OgR7K0FZpe+auD0b3VaoXkf5D3s2SoL5CIVIrrxSpnIpQ5p7HZK
	0DmWV4rD8X9ywo3eomFi29GEUVoU=
X-Google-Smtp-Source: AGHT+IGfXFgIVeFXescUdDva5biu2hL3Sx2+6RkNaAgSoRSLIWN4fzL/ROszPcP8d2SET4DptPZxu3h3OVpEoGGRcpE=
X-Received: by 2002:a05:6808:308d:b0:3eb:6bf8:800a with SMTP id
 5614622812f47-3eba6815be3mr5701407b6e.3.1734350352467; Mon, 16 Dec 2024
 03:59:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5861970.DvuYhMxLoT@rjwysocki.net> <3278518.5fSG56mABF@rjwysocki.net>
 <a345f7a1-52f0-476e-b2ca-7e229e957d46@arm.com>
In-Reply-To: <a345f7a1-52f0-476e-b2ca-7e229e957d46@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 16 Dec 2024 12:58:57 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iwiQVRCpm3Z4HY2S_LANrjWgRSGaQVXFfw12dVBzKdGQ@mail.gmail.com>
Message-ID: <CAJZ5v0iwiQVRCpm3Z4HY2S_LANrjWgRSGaQVXFfw12dVBzKdGQ@mail.gmail.com>
Subject: Re: [RFC][PATCH v021 7/9] PM: EM: Register perf domains with ho
 :active_power() callbacks
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Morten Rasmussen <morten.rasmussen@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
	Pierre Gondois <pierre.gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 11:59=E2=80=AFAM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 29/11/2024 17:15, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> In Subject:
>
> with ho :active_power() - without ?
> ^^^^^^^

Sure, thanks!

> [...]
>
> > @@ -594,7 +599,19 @@ int em_dev_register_perf_domain(struct d
> >                        * All CPUs of a domain must have the same
> >                        * micro-architecture since they all share the sa=
me
> >                        * table.
> > +                      *
> > +                      * If the :active_power() callback is present, th=
e
> > +                      * performance values for different states in the=
 table
> > +                      * computed by em_create_perf_table() depend on t=
he CPU
> > +                      * capacity which therefore must be the same for =
all
> > +                      * CPUs in the domain.  However, if the :active_p=
ower()
> > +                      * callback is not NULL, em_create_perf_table() d=
oesn't
>
> s/is not NULL/is NULL ?
>
> [...]

Yeah, one negation too many, thanks!

