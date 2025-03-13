Return-Path: <linux-pm+bounces-24001-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27123A602F7
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 21:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46D54420831
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 20:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31381F4631;
	Thu, 13 Mar 2025 20:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSXM1u0K"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782AF1F4627;
	Thu, 13 Mar 2025 20:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741898900; cv=none; b=XdreskWik4CV/GQXEhrolnhz2AVqDQ3eUgqK6RZopxHSibWRDhqb8r1k2uTgrwaVx6H5MSpeJzIeYoSo7PxbrduHiK1grmL7zWgDhZdOhXzTiRHs5vpMsqpQzcedTYmHqcaab1aSb1gvVxYbzoKsER2Cb3N37ZUCNGCLxsWk5wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741898900; c=relaxed/simple;
	bh=14wY1siKGZ3820aBaKNXQVIAz+KjbbyY897XAg4KGjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mzHJwt7iWs5IeXfONUEU0HDpUiS0dG9DmNHw1r79l//7Pwyowec0I7/4j7iNdr5z6Yv8pR4IXiQ2Nbj5UWmpg5WTY1El+xBXflEwajO+wXl0Euhu/uBFlSQA8xYukO3M6rJTFWiMGqhWjXDndVrUTXuxepdS3tf0bjNkIE45/2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSXM1u0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B4BC4CEF0;
	Thu, 13 Mar 2025 20:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741898899;
	bh=14wY1siKGZ3820aBaKNXQVIAz+KjbbyY897XAg4KGjI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SSXM1u0KQfURC0D2gVK2tBDBA4MOQUTMv4fZGDxheNu1d7BhRNX37jWKaitB4cwXT
	 ucO7byoMmh70Yno0Pfj3uv+p52IEwXTGvbm7hj+Dd4KkIb7Bev3JapSTlHX58xcBeS
	 M7bx2svpoeSdjB4NJsjM3VBAgT47r9Xi9kvsU1GmQJs8DS5lHaNPEwtfC0RsO9lsD4
	 cXyyd4Ss/r2npoDnsVkCOwA0EvdCy3rCQUAMNyTwD/fLwqNJXYH33UAj21vtuATq18
	 uulIDvEfoiQ7/ts+9tR1nsaN37VG8pMFXQW8q9DSstMuhRJ2sSTcEr/avRg7A55IS1
	 UGY4ONIRSReeg==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2c68fd223bcso17484fac.1;
        Thu, 13 Mar 2025 13:48:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUC+wRp/hz59Y/q2NQFKF19TW0QoyHf7k9IRkR6ujO9vXexHhTQtItOQ75UDEp4i3y4aU/kJg3/FtSLfcQ=@vger.kernel.org, AJvYcCXvuFNWc2SkZP5tpK02rgsas4uYcVj30L9753Lc4+FA/PNKSgiO8aeB2kMIeNHV2l3fK0cSpp4WXe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwRmsTDx0AvG4IcAKBhJ9Yj7cYbWkp9qXLCaY1ZFLe3FRaBqEs
	cTpxDWOWqV4ZWalgWMuVEvsyzc6UM91m1UA8Os1sFXFInxFbK291XUVDuDu0y+aa5upQOv3J2fO
	vDfbHU3TuysAOJEYLoksNROhKFhs=
X-Google-Smtp-Source: AGHT+IE4t6npoBFzHNSjity518d09fPiG5ev38y3yQv/EjExH31/wKbxPjuEeKqHNnHUVzTS7UFHOTwKh4qDxs1DL9A=
X-Received: by 2002:a05:6870:46a2:b0:2a7:d345:c0bb with SMTP id
 586e51a60fabf-2c6911416a2mr8350fac.27.1741898899165; Thu, 13 Mar 2025
 13:48:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313043611.1212116-1-chenyuan0y@gmail.com> <uudh23zxngyi534idmutg6v3aowjnokedomv76iyanuda4nocy@m5xqjtdc47kh>
In-Reply-To: <uudh23zxngyi534idmutg6v3aowjnokedomv76iyanuda4nocy@m5xqjtdc47kh>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 13 Mar 2025 21:48:07 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iMs7tsu+XXQbO=NoEY=zf1YRbJ8SFP+FAWyVVxFs=xxg@mail.gmail.com>
X-Gm-Features: AQ5f1JrQ5TjWinvVL6c8_rqj_TtBDp3oYbJQ99w2FM47tghI9ARPqp3QcjtJWOc
Message-ID: <CAJZ5v0iMs7tsu+XXQbO=NoEY=zf1YRbJ8SFP+FAWyVVxFs=xxg@mail.gmail.com>
Subject: Re: [PATCH] thermal: int340x: Add Null check for adev
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Chenyuan Yang <chenyuan0y@gmail.com>
Cc: daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 9:37=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Hello,
>
> On Wed, Mar 12, 2025 at 11:36:11PM -0500, Chenyuan Yang wrote:
> > Not all devices have an ACPI companion fwnode, so adev might be NULL.
> > This is similar to the commit cd2fd6eab480
> > ("platform/x86: int3472: Check for adev =3D=3D NULL").
> >
> > Add a check for adev not being set and return -ENODEV in that case to
> > avoid a possible NULL pointer deref in int3402_thermal_probe().
> >
> > Note, under the same directory, int3400_thermal_probe() has such a
> > check.
> >
> > Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
>
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> Fixes: 77e337c6e23e ("Thermal: introduce INT3402 thermal driver")

Applied as 6.15 material, thanks!

