Return-Path: <linux-pm+bounces-12631-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 989AA959A62
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 13:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B0BA1F21715
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 11:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC721CC149;
	Wed, 21 Aug 2024 11:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s87CmyuL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BC81CBEB8;
	Wed, 21 Aug 2024 11:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724238734; cv=none; b=FuocEfxA5s9McCGgPUjNe9pyFy1h1huVnH/biO/0K2eiRpBy8SBIsKP31rWU8j7L68rUYR82ph3p3qcEuKHYAtMdlfmAxLnTUolfdacEdklqDMH1fUS/XOqg+xTH5OgwepQajbXMi/IqyTcB4lYj/z8YESKaKZ0CCC1XDm9s3/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724238734; c=relaxed/simple;
	bh=bLlqmmcKTvxSCNFyT7zEcxQpRYILiepU5/eNGMgehlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IAQ7yQh2NrGhmm/hW6cFYYaYH6Gh2I6PUrqprcDcG0Zg/pGU76X/6l+j7gUDatSBwaTEwJbd7pCr0/OWbXDobKDL9P5ld6gd2NOmhVfr82ATyiLDj/bRrAXRdi467Ny4zZw2YjKXdLxvFBwn4PQZOn5tQBy2pzeVmLZ+U24Ubjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s87CmyuL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F05C4AF13;
	Wed, 21 Aug 2024 11:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724238733;
	bh=bLlqmmcKTvxSCNFyT7zEcxQpRYILiepU5/eNGMgehlQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=s87CmyuLwVAR28Z9lfq5sMCL/jIxX5drk2H199T4qmgqG9Nucjw1j5YEEGdScRA1H
	 bxv1FGMW9gYhTFoAjSx2SkXnTxfJgZyFyuKD53ccYRMMBSwMZBLd+SrJIAVlRCs4/5
	 aUGvHoQ9VQ5NitT/b1MMp7TizUuKGXuP+I6+9FdsID8ALutF5jeEyRHyxdS/jIXiAF
	 Z551VMhz9ps470eKqAdiJQ1185jVOLYTYRE+qEl7ohmDVtvzWbplSnogA9Dwi95/FA
	 xWP+nvpOm9k0Yb8zL4Tep6sxXdWomK5nZzLiBGl38TMyNBvba8y7ATX1T1ckE9WTs2
	 ARHKZCCOJ0WiA==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3db18c4927bso3653762b6e.1;
        Wed, 21 Aug 2024 04:12:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWBxzU+R6JJIoXpG3lYkcbknIZm0WdcGuDUlYs47JFRBqL1RSoX4oPu67rOZ7DLyh7Zo7oO4Uypzf+HiVY=@vger.kernel.org, AJvYcCWh6O7WP8qiZ5FmRxla35tRcm8UhgRDYxzjGb45JKD2a3/Ecu+S6qlSmJLdKJBRsGvEStixyiDYOvc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+MlfSFzauczFmIe9iUzkrGezqJEk/HlXnQw7n36abTEIAdAPY
	5Zi9dMvhzo4SmF88UEplJC4+o/zMJV7p74lsacyep7LEexYj4GR0yP+/Ma5Fsxax6KJtE3NKkM/
	UrWdDYvF5ba2bxDsDIZhIXStczck=
X-Google-Smtp-Source: AGHT+IFOKFfphfq5UCfyFfrZ6n6DO942WHJH7BQ93zflusJ6VS2K2D+jGDWG45QN8CFqh0WUKzkS8uU2XQ9tPTYjvIw=
X-Received: by 2002:a05:6870:d69c:b0:260:f6c3:7d1f with SMTP id
 586e51a60fabf-2737ef47facmr2066548fac.21.1724238732975; Wed, 21 Aug 2024
 04:12:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2205737.irdbgypaU6@rjwysocki.net> <3324214.44csPzL39Z@rjwysocki.net>
 <68ed6185-a602-c0fc-721e-b5d68fea83f8@huawei.com> <66bb19a0-00ba-40a5-91ef-73368659b30a@linaro.org>
 <8744a789-0424-0cc6-7cb1-b7c9b17f56cc@huawei.com>
In-Reply-To: <8744a789-0424-0cc6-7cb1-b7c9b17f56cc@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 21 Aug 2024 13:12:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jHs41Xswdk+g_=mT6NGWL47tzUnHECFgo5TCp7i7ZZUw@mail.gmail.com>
Message-ID: <CAJZ5v0jHs41Xswdk+g_=mT6NGWL47tzUnHECFgo5TCp7i7ZZUw@mail.gmail.com>
Subject: Re: [PATCH v3 02/14] thermal: core: Rearrange checks in thermal_bind_cdev_to_trip()
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Zhang Rui <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 1:11=E2=80=AFPM lihuisong (C) <lihuisong@huawei.com=
> wrote:
>
>
> =E5=9C=A8 2024/8/21 17:28, Daniel Lezcano =E5=86=99=E9=81=93:
> > On 21/08/2024 10:49, lihuisong (C) wrote:
> >
> > [ ... ]
> >
> >>> -    list_for_each_entry(pos2, &thermal_cdev_list, node) {
> >>> -        if (pos2 =3D=3D cdev)
> >>> -            break;
> >>> -    }
> >>> +    lockdep_assert_held(&thermal_list_lock);
> >>> -    if (tz !=3D pos1 || cdev !=3D pos2)
> >>> +    if (list_empty(&tz->node) || list_empty(&cdev->node))
> >> The old verification is ensure that tz and cdev already add to
> >> thermal_tz_list and thermal_cdev_list=EF=BC=8Crespectively.
> >> Namely, tz and cdev are definitely registered and intialized.
> >> The check is ok for all untizalized thermal_zone_device and cooling
> >> device.
> >> But the new verification doesn't seem to do that.
> >
> > If the tz or the cdev are registered then their "->node" is not empty
> > because they are linked with the thermal_list and cdev_list
> >
> > So either way is browsing the lists to find the tz/cdev or just check
> > "->node" is not empty. The latter the faster.
> Assume that tz/cdev isn't intiazlized and registered to thermal_tz_list
> or thermal_cdev_list. And then directly call this interface.

Who does this?

