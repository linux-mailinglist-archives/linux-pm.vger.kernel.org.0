Return-Path: <linux-pm+bounces-15051-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BD398D2D9
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 14:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AC5D1C21C12
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 12:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238CC1CF5F7;
	Wed,  2 Oct 2024 12:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVRSAECv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6DB1CF2BA;
	Wed,  2 Oct 2024 12:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727871155; cv=none; b=AoomzjqFRpzwNEmRHpWXHaH5EUMNVJZmljguE830WAjG5WlM6OSa1RPDeJ4Wkg0CTBAN+NjPaA1OgmQZT9iyxMTGWrwLYgUBwNC4cNPLB1fTg6QXRxQBhic5MxLcWpPl/tsoiOMmvNRFijdaU+d7Gm2LPky2B8ei5ORISzbFw6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727871155; c=relaxed/simple;
	bh=rhrIpTNZ2VtYreXMVjhuJ3JQzILZNQWimt3AV3sYgIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=idVkpJoTgTVDUqwD1UZDo8F/6gaDlO4s2f3vT6PGZP+FMayPy1F2b4WOcKHB/z5iLWS3aQOaPrVIguWHQC1LDjd7y/Hp0Z1hF0PhlJSRSZVkdmQKLh2McgkOTQGsTnuHK1aoaHtkTKA81xouwwYVjDHyGV3tcxUrw+8NsX05EHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVRSAECv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D3D2C4CECF;
	Wed,  2 Oct 2024 12:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727871154;
	bh=rhrIpTNZ2VtYreXMVjhuJ3JQzILZNQWimt3AV3sYgIs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IVRSAECvIV3NI/dOiGNpVSx91e5XmlDRfecznuO7K+v848sJKLoq5C5T7e0CloUNz
	 ZEaTcQgful9EqVzr2wc4aQe+YVcxkR+mLDxnwJuxHI2RJuAaWc/qyArKxox5Z2gtTX
	 kpXuwKVoCm95l2Cwwam1pZKXARNQxbHzG/K8GvfSPt8tC4+f+QmdIM025VQvc+4man
	 OwqnRStlykCYFLMbqZm5BjP8lgy2Mp+oYchSpWU2htBqHSK4ifDC7c7seuLm0HSlCi
	 SQhf3n7aAVZ4uUnNyPAmZaAKuZhfdcK9bwWl0ZdbDVMJAsHB7UFmbdXOyLZFdRY/fj
	 /BxL7gr3LCtIA==
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e0b9bca173so4071541a91.0;
        Wed, 02 Oct 2024 05:12:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+pcp8HQCb8broIGzctzZTDgqixZn0OiuanGNNFtzZAIlGl1P0PpTUvj2o7WISS/Qq2gEiVGbqKg==@vger.kernel.org, AJvYcCVZWsqWXuh9VisbmtYjbvm6ognD8XEEaPiMSG4vMNj5RMjlXxBL5+V4jkmr7Uv5+Dfq4WvS/lD0iSnXmRYbqTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiwH1+K1zXjAajBA/Jn67afagD6qjjq81HAgkG5cc4XJP2FSek
	yprjumThN9SN8MUYepD1RwDZe+Ktlec/OVtjrcfE9ozgm+f5pVfHYqL4ldKOP4TSk9vZTSusMq1
	bW9vVfWZoEL6RqugCYFgtp0K0Vvk=
X-Google-Smtp-Source: AGHT+IGZFxFogIvTpiKI0z3HN8+AhPPdccH9ntorQd36OQYI0HaPzrK7SGFdiaf2z7pK6SJMA+cVdsSheE0E60o0T4U=
X-Received: by 2002:a17:90b:368c:b0:2d8:e7db:9996 with SMTP id
 98e67ed59e1d1-2e18466e1aemr3482997a91.13.1727871153945; Wed, 02 Oct 2024
 05:12:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919081121.10784-2-ukleinek@debian.org> <CAJZ5v0hz+w3eFYQpHqwe0Fv3axe8LBDEf+oMd01dEQMuN=Dy5g@mail.gmail.com>
 <5cf6b249-d2d3-470e-874a-ba6b914f4b0b@debian.org>
In-Reply-To: <5cf6b249-d2d3-470e-874a-ba6b914f4b0b@debian.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 2 Oct 2024 14:12:20 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jdUB753KJ5Du+59yCWJMhf-R9gaW6=cfKg4=VWnkUMNQ@mail.gmail.com>
Message-ID: <CAJZ5v0jdUB753KJ5Du+59yCWJMhf-R9gaW6=cfKg4=VWnkUMNQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Make hwp_notify_lock a raw spinlock
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@debian.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, linux-pm@vger.kernel.org, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-rt-users@vger.kernel.org, 
	xiao sheng wen <atzlinux@sina.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uwe,

On Wed, Oct 2, 2024 at 10:24=E2=80=AFAM Uwe Kleine-K=C3=B6nig <ukleinek@deb=
ian.org> wrote:
>
> Hello Rafael,
>
> On 10/1/24 20:39, Rafael J. Wysocki wrote:
> > Applied as 6.12-rc material, thanks!
>
> Thanks. Triggered by this patch not being in today's next I looked at
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git and
> didn't find it there. What am I missing?

It's in my bleeding-edge branch where things go before hitting
linux-next so they can receive some build testing coverage upfront.

It'll show up in linux-next tomorrow.

