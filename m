Return-Path: <linux-pm+bounces-18081-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C07389D898B
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 16:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B143CB336EA
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 14:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE37A1B0F29;
	Mon, 25 Nov 2024 14:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAJLJDW6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A5E1B0F06;
	Mon, 25 Nov 2024 14:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732546118; cv=none; b=QyRg9+k74t5BfzfeLBiD7C/D9LEcJwzdWMNB3WU6ZXwazSAGS1Hb1VK3HV8Uugqny6fAknAN1JDoaYxv/2l9tpzgDEXVK+3BVbIALdP6ZnRTp0b1Vhe5pqTCKb0RQTedfTtkEdNBMR5Pa5AndWjQ7Z9lM6EdFGPrliyroUwfFIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732546118; c=relaxed/simple;
	bh=Ss7/4jVC79DesEs7aFakL1oiX65j/1Y68pSYOct0INA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b807uEBIW/KxGsttulOSGZCrW6Xk27qb8pHP3dN4kbmbj63kkWa7EUj287NlAXwyK0bkjhY7QBNUgZRIWSEYlXQSCa25wpKMmGpP2KFXEUxqe9xwKpWmldijJs3dfRCDd7MKpKa712H2ITUtej06zAmn8uawdinXqzrpkmz5UGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAJLJDW6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69636C4AF0B;
	Mon, 25 Nov 2024 14:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732546118;
	bh=Ss7/4jVC79DesEs7aFakL1oiX65j/1Y68pSYOct0INA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KAJLJDW66lyvl2x/GCfiVy04WoK4azLlZfma++BMdYTt7a6fEx+xn+Mb1VMQGxr+c
	 kE4pNoHIjyW7Jerqq5WuSj7mlXFydHPZtuK13qaY+9wonaSt1p/+28ObAP3BDqYgAy
	 /nUwsYCLGvbvY1Uj8BZ5dXxqqjorayDTvo/7bnA6HFlH3fOp4gRycpsRsNDr913aB4
	 5Dwm5vN74YsdVOYFu3t6kD86z7aGvNjksjx3obZKdjC4cl7yxfNf239d38s8nV9XbA
	 +ln+wc770wVaT+Tha39Vbsv392mxbM44VwHN4rigfb7oWgDaU6GdEPHIniun8NHMUL
	 ycVstVTIfLmPA==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-296b567bc30so1380987fac.2;
        Mon, 25 Nov 2024 06:48:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVaLe2pomq8kiq02A2Qk510RCx0Ohb7Nnrng/H4KP2CzFYc49fXTLLSDoWMu31KJHzQM7GNP1afDBpv0Fw=@vger.kernel.org, AJvYcCXDVw4gM3Ma0BbCgHGFbpqlOSVF1FaoBTU0scM+1/qV88hMTBt0SFPv/0H69bUE6UI+Uqzs6W/OwpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDkK1E/poKp44ijTMI1wNrHrWJiKvxflUfU3kdMFj0X/odm0Py
	M0cmGoYMxsgdhLeZTiowG0CZBXRLZB2WbZEX2NgRB6iLj5alLUZ9lSLRAWN3wrW5EHPmFTUH6PZ
	WZhqsOmyAbJ/G1DdFBQK32pmMI5s=
X-Google-Smtp-Source: AGHT+IFmO1nHhtL3orXGXHyVPhJaTVVe0wF+oHD6JVQrufGmD5J1HD9TRRWlEeGmxbiiOsYlByEV+k5jfag3KNTKeyk=
X-Received: by 2002:a05:6870:9129:b0:297:686:8ddd with SMTP id
 586e51a60fabf-29720e3ab8bmr10164892fac.39.1732546117717; Mon, 25 Nov 2024
 06:48:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125132029.7241-1-patryk.wlazlyn@linux.intel.com>
 <20241125132029.7241-6-patryk.wlazlyn@linux.intel.com> <CAJZ5v0iJ7hca68Pk1g1m=FNX6Psr3Ow-K7fvXZCcRM8PFM7EjQ@mail.gmail.com>
 <883447da-aeca-41ba-99ef-038dd8ddc6b3@linux.intel.com>
In-Reply-To: <883447da-aeca-41ba-99ef-038dd8ddc6b3@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 25 Nov 2024 15:48:26 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hZ8ajccb=B7P5g1+KJ+tsw5vP-e9ix7j_65WgT34H1XQ@mail.gmail.com>
Message-ID: <CAJZ5v0hZ8ajccb=B7P5g1+KJ+tsw5vP-e9ix7j_65WgT34H1XQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 5/8] x86/smp native_play_dead: Prefer
 cpuidle_play_dead() over mwait_play_dead()
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, len.brown@intel.com, 
	artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com, 
	peterz@infradead.org, tglx@linutronix.de, gautham.shenoy@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 3:43=E2=80=AFPM Patryk Wlazlyn
<patryk.wlazlyn@linux.intel.com> wrote:
>
> > If you first make intel_idle provide :enter_dead() for all CPUs on all
> > platforms and implement it by calling mwait_play_dead_with_hint(), you
> > won't need mwait_play_dead() any more.
> Crossed my mind, but because mwait_play_dead doesn't filter on Intel
> vendor specifically,

In practice, it does.

The vendor check in it is equivalent to "if Intel".

> I thought that I might break some edge case.
>
>
> I am all for simplifying.

