Return-Path: <linux-pm+bounces-20295-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CECA0B0C1
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 09:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA418163995
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 08:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1488923312F;
	Mon, 13 Jan 2025 08:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="iaQ/6oR7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B193B233127
	for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 08:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736756065; cv=none; b=oOiqouw78up+G7LdrZC0Ei94ofQj6fUGJ+pQbYmccM4iX6mFKtnHt8Wp/MPyDzrWKoiSOUPrEDVhclYxbYXccRCPiV0V0e5NJh3KBeTsa8LHSmGCiJDbIghXMBkQpub4OPebhkqtFo4Yis5L3AOAZVALJAbYGGd1iqtVHqATitM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736756065; c=relaxed/simple;
	bh=f8QHHGrrqWcN4uP06DPr8DutPMgJclVuN0rJZGNwAzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u/jjFqgf260Ygo0WjfB1VX+DdVXiyuY+eBRuG9N1GaxfHg/2iKz6jt0g4WHHpPy28O63dmuEpWXh9vE81nENyXOOS9xSgzEqfd3J2+qQRo5nB8oXhaSn5v7/a/DC+aaaDxQic4nmb6kOc73kzAhUTW7xoxhL+Xy9Dtr/3HM3eyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=iaQ/6oR7; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 31B5E3F5AB
	for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 08:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1736756060;
	bh=NJkM3CSB0Pgz/We9Iy8m1WmoRuOM6PbsthVCHJC9pB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=iaQ/6oR7UEPXVo1pB8MNO1nsXjB748U/UR+rO7Kg49pgsfhVIHLd4IBBFJwzTW2Y5
	 lfrkPiPS79dBdsGoSA+7aVIgFoqU67ss5N6IWVBCd+Dv3Newr/ZlcLu1iFZ2/ZPdH9
	 Hdxed77OiubrfxCbqmvainKBODyDwW+0JNIepxxZUyupVDvWCS/Ld4ZwHVfvtYhfmu
	 dJFWoSPRxnyxX/OX6Cpq7GavrQ1eQ3jv2Y4I+1Di+L2F1v3h14vSdld3ImoYJ5bUzu
	 wIwfsNAbTv7VDah5w9agaYvV8ykYaRwwfsoG+pJJIM6tGVYPPTjBxdzUPNGBEFtpyd
	 IocQImeP/Qksg==
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-4b2be0369bfso505785137.3
        for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 00:14:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736756058; x=1737360858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJkM3CSB0Pgz/We9Iy8m1WmoRuOM6PbsthVCHJC9pB8=;
        b=aEmSkapNv4+nxr38ZsUTXEgeONrMEKtZWyCejLk59qpS6RaVkzTz7kprcqSdWxHvCi
         e+PmELXF+zyyY/zrsXFrZLOfW8iSTVHcYuUW7P0C4zu5r7R88Vr7hbsCeTA/8YYojpaP
         2ZUEKuPsmvF7Q6NmBSvvrvg0G55fyvEhIkGE3d+mJQz3VpYaMe6JMFoarX7d+XBu9nK4
         qp0IPhjj/GifgVSjuIVqm2PkEg5au54Tj8Q5SicfhqLY4YtsxR/e2a0XmgZFlVVw1mmn
         wHQ7c5Et4OJLGpm7Bnfdh9sMnlJYjCOCJarsSaMXvoMNPAzoWB7lR5HUUN3Rs6Tss0TY
         AY7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVTmxm8GXZ7K3XEjKrc449vqvfPgsflr0mQIHbwRyiwsxhAjc34oa4FN1kXF4dQiyuJyFFfqbc+gw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr1UBNETANJrWSBYi9fWkeOtHKZendk2Nbx4VU2jcBuqvgegM3
	NADVX7VYG1K7RV2dyxDf17CSTcV3pqtSqhTdhCfAT/ng8RCiOh4t8M2G586kPfCFHPgfFVf2iNj
	67Pg+Z8GqccQyfRblCt/vObyzI3n6JAyV4OLy3wC7jfrlZ9dc1zsQTj9OQklto1UEN+89O+ZNuv
	9x5aPjESYhLn4wpf8x6I2ff9fEqYbUhyB0oNVhDzvNfRcMl4c=
X-Gm-Gg: ASbGnctAURDwPSd0EtoyakiCnvSbPIQ5s7+3Oe++p1xqftiRTLatv3dFX4w7Z5VVT2Q
	8u9xxSDQVWOiVFl9xH1k/8c9LxhvYZ79yecGpLnw=
X-Received: by 2002:a05:6102:3a0f:b0:4af:fca2:1b7 with SMTP id ada2fe7eead31-4b3d0fc7ad0mr16244218137.14.1736756058228;
        Mon, 13 Jan 2025 00:14:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYCvwisC3l8FBYF2gdmAMcld8qH4qVUB+MvAbH6eZfZowGTRecWBCVwdrDJtvYcA3dlbvb4oEYjvtsRISObW0=
X-Received: by 2002:a05:6102:3a0f:b0:4af:fca2:1b7 with SMTP id
 ada2fe7eead31-4b3d0fc7ad0mr16244215137.14.1736756057932; Mon, 13 Jan 2025
 00:14:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110084413.80981-1-leo.lin@canonical.com> <b16e2b38-e9f8-43af-9df0-0510895c02ee@rowland.harvard.edu>
In-Reply-To: <b16e2b38-e9f8-43af-9df0-0510895c02ee@rowland.harvard.edu>
From: "Yo-Jung (Leo) Lin" <leo.lin@canonical.com>
Date: Mon, 13 Jan 2025 16:14:07 +0800
X-Gm-Features: AbW1kvYHv1rlGa0_EloDnK9Kx-ziOPd6kTh9v1VO-JWEZv4ZAe9n9iMxMqEKvSc
Message-ID: <CABscksPKS1prbikpF4FwoTLMvxN13_xrQfdXoXDnbo-4byUB6A@mail.gmail.com>
Subject: Re: [PATCH] USB: Prevent xhci from resuming root hub during suspend entrance
To: Alan Stern <stern@rowland.harvard.edu>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, pavel@ucw.cz, 
	len.brown@intel.com, bhelgaas@google.com, duanchenghao@kylinos.cn, 
	dlemoal@kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, hdegoede@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alan

On Fri, Jan 10, 2025 at 11:44=E2=80=AFPM Alan Stern <stern@rowland.harvard.=
edu> wrote:
>
> On Fri, Jan 10, 2025 at 04:44:10PM +0800, Yo-Jung (Leo) Lin wrote:
> > The commit d9b4067aef50 ("USB: Fix the issue of task recovery failure
> > caused by USB status when S4 wakes up") fixed an issue where if an USB
> > port change happens during the entering steps of hibernation, xhci driv=
er
> > would attempt to resume the root hub, making the hibernation fail.
> >
> > System-wide suspend may fail due to the same reason, but this hasn't be=
en
> > addressed yet. This has been found on HP ProOne 440[1], as well as on
> > some newer Dell all-in-one models. When suspend fails due to this reaso=
n,
> > the kernel would show the following messages:
>
> I believe this problem was discussed on the mailing list before, and it
> turned out that the issue was caused by a bug in the xhci-hcd driver,
> not a bug in the USB core.

Could you be more specific on which bug/thread it is?
If you were mentioning thread about d9b4067aef50 ("USB: Fix the
issue of task recovery failure caused by USB status when S4 wakes up"),
the log in that commit message suggests that it happened on ehci, while
here it happened on xhci. So this may be more general than just the xhci.

>
> Basically, suspend is _supposed_ to fail if a wakeup event occurs while
> the suspend is in progress.  As I recall, the bug in xhci-hcd was that
> it treats some non-wakeup events as if they were wakeup events.
>
> In particular, a port change on the root hub should be treated as a
> wakeup event if and only if the root hub is enabled for wakeup.  Does
> xhci-hcd check for this before failing the suspend?
>
> This reasoning shows that your proposed fix is incorrect.
>
Thanks for the feedback, This indeed isn't a correct way to address this.
Will try to figure out some other ways.

> Alan Stern

Best,
Leo

