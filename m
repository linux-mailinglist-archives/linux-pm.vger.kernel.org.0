Return-Path: <linux-pm+bounces-36233-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5157FBE27EF
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 11:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76F47481B8D
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 09:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39172D0608;
	Thu, 16 Oct 2025 09:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2snAYbx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5792C032E
	for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 09:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608138; cv=none; b=mhjT44PAH9+KJ9ziNCWFl3IRlD9rSdilm8SeoRDlsGc1T1PW+T24WdVAoggqBfhKvQ10CDNYFqJnLndZlhHKTLMQyfzr8tSPNE1GKo/AdZDtHQ1ROYTzFnjC1IpIKlFgSQx5VZRYcxXzQ55eLn1aCSmRZgi+ppq/gCGYgj0XZKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608138; c=relaxed/simple;
	bh=yEmVNdpCYqBdTyOzV0CRjW0B7BZ66MI7mbXUepluFeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tl0pc2GZ9XOVw7CjrtGoqwRSeatX/oowN092lemiKAquZprleCCaKPWeDvfrqoHim/CEuLhn80ae66VqimLzne+hbbzS1mT6d0kFwxLoZ+IiQ/8HOg5R83pT5iNbC6tptitBpRYycfPAkQ/oOs6r90lW7AZEYI1LF13/x/UO5N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2snAYbx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4ABC4CEF9
	for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 09:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760608138;
	bh=yEmVNdpCYqBdTyOzV0CRjW0B7BZ66MI7mbXUepluFeU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=l2snAYbxeRsZC5edVYmhyg8WIOuxo4arxPT/mwORHxOLnqrVsq4vKAxH2mCTOkcV+
	 VXXdvCFYGWAypRYxZMcu92f1TQYY1HfIjEpanNxpIOBeaFHxSfyq1qnptuH9+h1yPd
	 d3P+x/RjNrcxFCp0iyjyKLp6g0Ht8fg+IiikGjVrTLHlXHZfUPTKqVIIRHgJfPg9jz
	 rqi37XNgqt53JP9b9k1rdejxmUjLoyNlBxcypj+oUlpyzCF5lNzzM3e4PUDZDHfbW4
	 XxjWTHDU4A23EfrWpm9HbGyFJPwgcju6V5GUxD1hWsErqK9OuTTrmhv9xsdJ8LKnzF
	 0+xElD19vcfrw==
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-44357051b30so34504b6e.1
        for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 02:48:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV8TtvBTUNvyEwdYROlwlxXl/UrRCU9n6RdNOq0VsyapUV4viYsW9TE+pHiDgfLLmYrdFKzyOPcbw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdW8TEzqpvjOgCC8Zv7Dwe0gfgTaYec2Xjemose1DlkJhltfvF
	p7ZTQwuwoiKoSdFEXd+6GQBlt8Up1pBYa71OIFr6mCcp5UWfpBOOqm8zCqGAW8g5AyRQFDAk46D
	XTN9tezEYdiCJxM82k0U4VgHUPmdfIAs=
X-Google-Smtp-Source: AGHT+IEd7KWLS22yof5FlD3f54qtHLyLFRW24AY/5dMwIHTHtn26YjtfskDsv28MT+lC5cgwQ1k85oQWSTsGOUaCqNc=
X-Received: by 2002:a05:6808:5281:b0:43f:3eff:1ef3 with SMTP id
 5614622812f47-4417b3dccdemr13728369b6e.43.1760608137733; Thu, 16 Oct 2025
 02:48:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <08529809-5ca1-4495-8160-15d8e85ad640@arm.com> <2zreguw4djctgcmvgticnm4dctcuja7yfnp3r6bxaqon3i2pxf@thee3p3qduoq>
 <8da42386-282e-4f97-af93-4715ae206361@arm.com> <nd64xabhbb53bbqoxsjkfvkmlpn5tkdlu3nb5ofwdhyauko35b@qv6in7biupgi>
 <49cf14a1-b96f-4413-a17e-599bc1c104cd@arm.com> <CAJZ5v0hGu-JdwR57cwKfB+a98Pv7e3y36X6xCo=PyGdD2hwkhQ@mail.gmail.com>
 <7ctfmyzpcogc5qug6u3jm2o32vy2ldo3ml5gsoxdm3gyr6l3fc@jo7inkr3otua>
 <001601dc3d85$933dd540$b9b97fc0$@telus.net> <sw4p2hk4ofyyz3ncnwi3qs36yc2leailqmal5kksozodkak2ju@wfpqlwep7aid>
 <001601dc3ddd$a19f9850$e4dec8f0$@telus.net> <ewahdjfgiog4onnrd2i4vg4ucbrchesrkksrqqpr7apyy6b76p@uznmxhbcwctw>
In-Reply-To: <ewahdjfgiog4onnrd2i4vg4ucbrchesrkksrqqpr7apyy6b76p@uznmxhbcwctw>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 16 Oct 2025 11:48:46 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0inu-Ty-hh0owS0z0Q+d1Ck7KUR_kHQvUCVOc1SZFqyjw@mail.gmail.com>
X-Gm-Features: AS18NWBFXbEtbYyCPXjBrLP23i-liWOk3RjE3QV8V8ITQQxzauhfCw17pQxaXzg
Message-ID: <CAJZ5v0inu-Ty-hh0owS0z0Q+d1Ck7KUR_kHQvUCVOc1SZFqyjw@mail.gmail.com>
Subject: Re: stable: commit "cpuidle: menu: Avoid discarding useful
 information" causes regressions
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Doug Smythies <dsmythies@telus.net>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Christian Loehle <christian.loehle@arm.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Sasha Levin <sashal@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 6:59=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (25/10/15 07:11), Doug Smythies wrote:
> > >> What thermal limiting methods are being used? Is idle injection bein=
g used? Or CPU frequency limiting or both.
> > >
> > > How do I find out?
> >
> > From the turbostat data you do not appear to be using the TCC offset me=
thod. This line:
> >
> > cpu0: MSR_IA32_TEMPERATURE_TARGET: 0x0f690080 (105 C)
> >
> > whereas on my test computer, using the TCC offset method, shows:
> >
> >  cpu0: MSR_IA32_TEMPERATURE_TARGET: 0x14641422 (80 C) (100 default - 20=
 offset)
> >
> > To check if thermal is being used do:
> >
> > systemctl status thermal
>
> chromeos doesn't use systemd.
> A quick ps grep doesn't show any thermal-related processes.

All right, let's see what RAPL on that system has to say.

Please send the output of "grep .
/sys/class/powercap/intel-rapl/intel-rapl:0/constraint_*"

