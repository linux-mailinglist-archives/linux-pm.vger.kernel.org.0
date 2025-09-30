Return-Path: <linux-pm+bounces-35605-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA205BAEB58
	for <lists+linux-pm@lfdr.de>; Wed, 01 Oct 2025 00:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66D4E1924D21
	for <lists+linux-pm@lfdr.de>; Tue, 30 Sep 2025 22:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE192D061F;
	Tue, 30 Sep 2025 22:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4aStPfKJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11073C1F
	for <linux-pm@vger.kernel.org>; Tue, 30 Sep 2025 22:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759271852; cv=none; b=EQRn6FNnP+B6jHg+jAOEwH7GrK3vqCR7kIGiGw0WRrzyXJFy9gwfjo3RkzCgeoIzSgybI2gtUA5L3QB+X5g0XnUfQns8aH4QmNBWj1eN7MGmRCiivrIdgr0u8SoQSsQYMeK0/vuZDviYx6znuA/mhMiKyctSEmNRgxFOCIm6+Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759271852; c=relaxed/simple;
	bh=HiSU258gEuvRwD03tvF/b7uusp9crc7Wt4cFeKzPiM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BYZupReMVhgCvXCQZDXL5Yi971FKIcoJK/IihNYW/SpRpr44MTigUvqWSb2t1ZVOrVvPT/DXeGkDH4qkKiPGmKk/EqbfMUfwKiKhXuujADuLcbRUbjk5/H6vyufOl6qKijEJ8zoMasG15eTUpCucBbv+uoVx7LuyFn0LH+yJtwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4aStPfKJ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so9436318a12.1
        for <linux-pm@vger.kernel.org>; Tue, 30 Sep 2025 15:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759271849; x=1759876649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HiSU258gEuvRwD03tvF/b7uusp9crc7Wt4cFeKzPiM8=;
        b=4aStPfKJyOwUk4c5vtS/dceSZZn19GXKITIP6stpkSxHc3RxQexxzI3hUuquntJnfi
         CJUC9YvnI1wMNgyDc45XrB26zywCpWCg0tbeegbQe0/Rg5LL7yHtgIFMbhQtDTzZwGRa
         CyzqJFcylRCqaIHH+5Wbo/QIc4uKkdGAsm274H0qtgXoE3OcTOlnZmXR1gQaqNZT3SS5
         7kJbwg0gK4VJy91RggIlmCLybtJvtKxAOJGHp/IoaogRjrr/dMjU+YeMgG+ppNFkKcdU
         /BqpZglHfQp1kgZYVO+axTbt/A2JCaEgfCrGVPrcvlNHtOh4oHfNQjOl0q8EOMdWHRY5
         ZFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759271849; x=1759876649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HiSU258gEuvRwD03tvF/b7uusp9crc7Wt4cFeKzPiM8=;
        b=BUgQpDL2wazYXEvYt0nTVBHwyiLyBd1LZJEQqjeXGZrAIaqZXyChehDXt4lq70vh5Z
         aCvtAGXupaGfn/ZVZrTCb6RyZWjB2LWgYo1zcOk0jZQ2QPdtlZeyPOhVn02EM2zK0VfY
         C0yJcpJlPcM0Xg43a25GkPBVYO2gaUHgq02jsqq/R0ZQ79kdjT7J9xY+IcPpS2woq+SM
         MqvLfV6OHdOog6gWoDP8sibJUqCOxicW9KXO8nZwmh9wIyO+D7jogiVyB/G5n9ZM6Y0c
         BC5w46lQiA1WM069qOlS31/s4mv5hW+Ap7WBl/Wlml0w9iXNYI/BNMM3ytScbGX4uL1e
         /7eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUG1yE66pkbk5hqvH/4AEHYMuQbjwduINycjGLmfsHiFICPB0d5e1n7nw3jYEhJFmyFtRY1pxAo/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3JIpk7mfNwJvseDGqWeH+aifXC4YAaJkaUivGi61SK0B9h8hI
	c9H0+xtJnCsTCy0Ht5W8TN6V2EkzunB14D2eXCmuSIFZjLWK53sxQpLz7FjWjpi8p1UorGeYJTD
	E+qczpKn6rt3J7C82d5raLozDNS7rP9V0x7JL5Wj6
X-Gm-Gg: ASbGnctu1R9IpGg45dDVpy3DYXgItcy/xKsU3lUIegfwy9gqohojlXVONAivvn355V3
	Y5ZGGGKVqqFmw0XsNOq2dzTq55zuFHNLOerm4aTWppAl+MyvWCWl47rjnY+UX68r2BoorooJmmz
	C4sakDOqgMbugwudohh2Id1aNHxtMH2NLJibRbgggQMDt3hsnZrt5kA88HzdgrddFo/Hfu0PCdt
	eoubD+BHgRPB27VlUXcf0v261A3aLW45hmp+Iz72ImkFIu7hEqWAPRYntlfWwfwwpi4n2jkDjHO
X-Google-Smtp-Source: AGHT+IFhTLsM9VWajQNAcvfDSRfiJKQsQdakG+/xw1ybWNiHCG3MR95bnTzqAS3/FEkb1vCHOW01TN0UPCnaVkJ8TL8=
X-Received: by 2002:a17:907:2684:b0:b3e:f028:2d57 with SMTP id
 a640c23a62f3a-b46e9e45915mr146021666b.57.1759271848783; Tue, 30 Sep 2025
 15:37:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911185314.2377124-1-wusamuel@google.com> <CAG2Kctqf=Q+nuuDqzkrOpjp+tOttf079DS_R8Q0pHU-k8DmFvA@mail.gmail.com>
 <CAJZ5v0gtKmtiLQwi-2qaw2G4O4PF_iqz6UbUZuaknepcJ1ToZQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gtKmtiLQwi-2qaw2G4O4PF_iqz6UbUZuaknepcJ1ToZQ@mail.gmail.com>
From: Samuel Wu <wusamuel@google.com>
Date: Tue, 30 Sep 2025 15:37:17 -0700
X-Gm-Features: AS18NWBHp6syKIsOWMv8Q0jCQTPbz8FkUeurXM-DWYEWDmRvZzl9bUqKzPeWAN4
Message-ID: <CAG2KctrK0JrP7JNUyzF72JeDgR4-GSRmJDe+yEnav=gQCAf64Q@mail.gmail.com>
Subject: Re: [PATCH v4] PM: Support aborting sleep during filesystem sync
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 11:51=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> Hi,
>
> On Tue, Sep 30, 2025 at 8:30=E2=80=AFPM Samuel Wu <wusamuel@google.com> w=
rote:
> >
> > Hi Rafael,
> >
> > Just a friendly ping on this patch. Please let me know if there's any
> > feedback or if you'd like me to make any changes.
>
> Have you seen https://lore.kernel.org/all/20250909065836.32534-1-tuhaowen=
@uniontech.com/
> ?
>
> If so, what do you think about it?

I was following this chain
(https://lore.kernel.org/all/20250908024655.14636-1-tuhaowen@uniontech.com/=
),
where there is some ongoing discussion on converging the solution.

Our changes aren't mutually exclusive, and tuhaowen can build changes
on top of ours, even indicating:
> I'm happy to work on this as a follow-up patch series after your changes =
land, or we could explore a unified solution that handles both scenarios.

These patchsets don't negate each other, so could we decouple these
two patchsets since they address different issues?

Thanks,
Sam
>
> If not, please see it.
>
> Thanks!

