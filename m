Return-Path: <linux-pm+bounces-36180-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA06BDE540
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 13:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9562D427942
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 11:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BAA3233E7;
	Wed, 15 Oct 2025 11:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPJ41aZj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FCD322DC1
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 11:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760529005; cv=none; b=L47XiinOF4CGRg35vdVIdz6IUvhQrsHComYwvJvgyIPbpyTRtFGtIkp/8tj/sqQ/86DKnS2anjVCpj4UNgrysHApdmsaAOvpm24momfEF6i4L6diHkQyN9mcsSyFGdYChsXbzYSWyxrOL1oB6/Pempsrr+AWxcw7lDcCi4pRkn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760529005; c=relaxed/simple;
	bh=ooKuFwes3Vhtb88vFNU8Ivf+LQKJ5Zbjhym0lsVJnFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rOaAbi7Nz7c0yY2Npgkrww+PHrxWHzOeRTgjORC4Y1S9bU3dzFiQfsZnm8wqmLK/AwbdxbNsKw+k2NZsfkc+PJ5e0DnkpZ+qkX5gzo/h4MldAWNUApcOLIrL5j2dyDD/uhDMP+NnqYbKbNEIPweUvpSgoGiZ6vj0KiCqKKQTTSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pPJ41aZj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F7BC4CEFE
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 11:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760529005;
	bh=ooKuFwes3Vhtb88vFNU8Ivf+LQKJ5Zbjhym0lsVJnFc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pPJ41aZj0fSfWNlsmRArlY/pKEQBLwAbYCJ3Kf/Yt3x6+GMI/bwJGEEbarPL5snAW
	 QDvQJp56XVMi1HtOewG1p7T/wKe1rzfBT5o/gON0NXNUk6bFSwIILYGquGVzLCM/ar
	 OZFDNvlYW6WrgOExxd/bSi+1NboatmB481cuUL6ZMIDSVWtJxjK9bamkl57A28kB3L
	 KDJsCfzeYnRSvbYdQ1E4wfmjR4dVcYfdraE+B3qhfmts00p2Y6tgfofaR6D7cZcK08
	 OJpVg/24jR3zidWNa3BwcpmP6qOmfXzwYo80KTFlWGq9YbKUIPVn1FH9p9zQ2ilvXZ
	 IJmLilEizadJQ==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7b00927607eso4535072a34.0
        for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 04:50:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2W0cYdJTOkzS3SrfzGU2QZzNPSB0jnuM6WjuzPiZKf0A/85LE3ERG+uEyuFB8cFasOMSdrPbY7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCNxG+deOTetmbkYKLFEXzsSFzuFwQX6bKSmcbn9DUbiphf3qT
	ymhtrzKuPtuBkP7RSuM7rK8I1BFviRa7NSLS0hNWmzXJa6SXDQg/QjJiYF/SxznynTcAaasZ7pe
	P8u1OVGrU082sM5Mbr8Aohsma6LCt7d4=
X-Google-Smtp-Source: AGHT+IEcOvtS91b8xBc9x8mFoNEL4oiSYrMPmBf02hvPxuJLVNB/9E+H2gs8poT1029kYj76kZmT5rKMedZ4Ubm3dj0=
X-Received: by 2002:a05:6808:bd2:b0:441:8f74:fcb with SMTP id
 5614622812f47-4418f741f0bmr10872569b6e.56.1760529005083; Wed, 15 Oct 2025
 04:50:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7>
 <08529809-5ca1-4495-8160-15d8e85ad640@arm.com> <2zreguw4djctgcmvgticnm4dctcuja7yfnp3r6bxaqon3i2pxf@thee3p3qduoq>
 <8da42386-282e-4f97-af93-4715ae206361@arm.com> <nd64xabhbb53bbqoxsjkfvkmlpn5tkdlu3nb5ofwdhyauko35b@qv6in7biupgi>
 <49cf14a1-b96f-4413-a17e-599bc1c104cd@arm.com> <CAJZ5v0hGu-JdwR57cwKfB+a98Pv7e3y36X6xCo=PyGdD2hwkhQ@mail.gmail.com>
 <7ctfmyzpcogc5qug6u3jm2o32vy2ldo3ml5gsoxdm3gyr6l3fc@jo7inkr3otua> <001601dc3d85$933dd540$b9b97fc0$@telus.net>
In-Reply-To: <001601dc3d85$933dd540$b9b97fc0$@telus.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 15 Oct 2025 13:49:52 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g7g7-WWTu=ZQwVAA345fodXer1ts422N0N+ZKx+6jXRw@mail.gmail.com>
X-Gm-Features: AS18NWATo-6k6LvzkPgyIf_Bc1oxboWU9Wp6VAZkaltVlveNh-c1lVAl4_h_8co
Message-ID: <CAJZ5v0g7g7-WWTu=ZQwVAA345fodXer1ts422N0N+ZKx+6jXRw@mail.gmail.com>
Subject: Re: stable: commit "cpuidle: menu: Avoid discarding useful
 information" causes regressions
To: Doug Smythies <dsmythies@telus.net>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Christian Loehle <christian.loehle@arm.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Sasha Levin <sashal@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 5:41=E2=80=AFAM Doug Smythies <dsmythies@telus.net>=
 wrote:
>
> On 2025.10.14 18:30 Sergey Senozhatsky wrote:
> > On (25/10/14 17:54), Rafael J. Wysocki wrote:
> >> Sergey, can you please run the workload under turbostat on the base
> >> 6.1.y and on 6.1.y with the problematic commit reverted and send the
> >> turbostat output from both runs (note: turbostat needs to be run as
> >> root)?
> >
> > Please find attached the turbostat logs for both cases.
>
> The turbostat data suggests that power limit throttling is involved.

Why do you think so?

