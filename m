Return-Path: <linux-pm+bounces-39219-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB8DCA527F
	for <lists+linux-pm@lfdr.de>; Thu, 04 Dec 2025 20:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FBAD312FD28
	for <lists+linux-pm@lfdr.de>; Thu,  4 Dec 2025 19:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0CC1E8826;
	Thu,  4 Dec 2025 19:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INXfXsjb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B112B9BA
	for <linux-pm@vger.kernel.org>; Thu,  4 Dec 2025 19:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764877309; cv=none; b=FWIoyzhpbCBl0eCI9ST6yLUYhfulpwL/kMtVwCIHddDrfqoNA6fn+idtzqvrvOl0CYCjoK21aqsPjiYndWmJMyXjvB6+i00gi/HjH4lRNTGTnl98+dH01cErYueFw3NkufyT9PN4fO8zV3CP8SFp069CmMPkmVLg1bQi0z1GJJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764877309; c=relaxed/simple;
	bh=rHT9xT6N4HwUpN3fLXWjzicPo/DomXsTboy9NbnRVjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nGH7MEcBSMVc7/EMXKj6nelEtJQr63HjIzSAGZcu/AoC86E0J67OZSAOaar2U4SKZ0KrA2aJDCarcyomDu3CiVAcwnEXvONViAFuOoLJ727BbExaHWY4mnESpw2cFSr/OZ8cqIHMAXS6E403+jH5fw7QGhydMAh/i77VDlvWE5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INXfXsjb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587CBC116D0
	for <linux-pm@vger.kernel.org>; Thu,  4 Dec 2025 19:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764877309;
	bh=rHT9xT6N4HwUpN3fLXWjzicPo/DomXsTboy9NbnRVjs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=INXfXsjb/N/0dD/b9PLdByET50RPyZ/boMtT07qGJwlh0Xu1tKPpABIbGrLkaHxHN
	 j9mqn062PyWkwv41udyh3TFRdSnfNbGmJY1TYzOiGTI3KbY27QW5/PT8EZoPx8iGe5
	 cCt7kJD483u06xecuZyLC5GEoLNQCq45Y7M7eSknpsvW1rKrg4gxbhC9QfBm8HMCUb
	 261T1HTodlJewh2aL8RRGqfVZjQSNugLtBvA3XB1BB9xSeCWNWBex9CfWJRaIQc9gH
	 IiPdmI9jCOuCl03SGbmTF8O56W/Ra4vvgMb1Kz2l6Tpe9N0nHC+p18DOJmRYXPbWo2
	 ZIlN0ZAKDVNZA==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7c75a5cb752so972491a34.2
        for <linux-pm@vger.kernel.org>; Thu, 04 Dec 2025 11:41:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWcXVZKFHEJT9GidNX8glLeRmKbzkDYJV1d4t52CTPxBNIe2NwfnfgvcX+NlYcvEMVfJydPSp19iw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCzRV9UqAL2YPsFn4rSLdQf5gBb5SvknLqmkQKkUBBGAIIIYFZ
	accDD5pHDw9I7f1Ie7UDE1emBt5/rQPl5m+pGq3VQKO1DehI45J44aqJVSQiDnWiL9tksaTGpVo
	mJZlNbUTnIvgK8UxY0ZXTP70m+Otj4FU=
X-Google-Smtp-Source: AGHT+IGwb86bPJj29XUE84xmLGbyUSD6aHdtW3/1oF7NbvBJ0We7CnpySRDDctXuzQ/AonqYFaXS/BcZ2k/FtC57djQ=
X-Received: by 2002:a05:6830:44a0:b0:7c7:6977:17cb with SMTP id
 46e09a7af769-7c94db1950fmr4377333a34.21.1764877308026; Thu, 04 Dec 2025
 11:41:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202193129.1411419-1-briannorris@chromium.org> <0f729108-6928-4644-b02a-fa7020cdffc4@roeck-us.net>
In-Reply-To: <0f729108-6928-4644-b02a-fa7020cdffc4@roeck-us.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Dec 2025 20:41:34 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iyR5x-FDoyoTp3ip7g7tdB_Qmii5Uy+EtCOpLyy2XBJg@mail.gmail.com>
X-Gm-Features: AWmQ_blFeKRlhzPeGyH7_dyis8rxlzDcx9cgPJbofmddeZOBxg4GSKXJcIy7Dt0
Message-ID: <CAJZ5v0iyR5x-FDoyoTp3ip7g7tdB_Qmii5Uy+EtCOpLyy2XBJg@mail.gmail.com>
Subject: Re: [PATCH 1/3] PM: runtime: Stop checking pm_runtime_barrier()
 return code
To: Guenter Roeck <linux@roeck-us.net>, Brian Norris <briannorris@chromium.org>
Cc: Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Nicolas Palix <nicolas.palix@imag.fr>, linux-pm@vger.kernel.org, 
	Julia Lawall <Julia.Lawall@inria.fr>, linux-kernel@vger.kernel.org, cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 4:34=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> w=
rote:
>
> On Tue, Dec 02, 2025 at 11:30:24AM -0800, Brian Norris wrote:
> > Apparently this test is the only code that checks the return code from
> > pm_runtime_barrier(), and it turns out that's for good reason -- it's
> > inherently racy, and a bad idea. We're going to make
> > pm_runtime_barrier() return void, so prepare for that by dropping any
> > return code checks.
> >
> > This resolves some test failures seen like the following:
> >
> > [   34.559694]     # pm_runtime_error_test: EXPECTATION FAILED at drive=
rs/base/power/runtime-test.c:177
> > [   34.559694]     Expected 1 =3D=3D pm_runtime_barrier(dev), but
> > [   34.559694]         pm_runtime_barrier(dev) =3D=3D 0 (0x0)
> > [   34.563604]     # pm_runtime_error_test: pass:0 fail:1 skip:0 total:=
1
> >
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Closes: https://lore.kernel.org/lkml/93259f2b-7017-4096-a31b-cabbf6152e=
9b@roeck-us.net/
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
>
> With this series on top of v6.18:
>
> Qemu test results:
>         total: 610 pass: 610 fail: 0
> Unit test results:
>         pass: 666898 fail: 0
>
> Tested-by: Guenter Roeck <linux@roeck-us.net>

Applied along with the [2-3/3] as 6.19-rc material, thanks!

