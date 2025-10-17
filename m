Return-Path: <linux-pm+bounces-36349-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E82BE81A9
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 12:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 907666E1426
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 10:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89863176EF;
	Fri, 17 Oct 2025 10:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJ/FQqW3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643AB31691C
	for <linux-pm@vger.kernel.org>; Fri, 17 Oct 2025 10:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760698028; cv=none; b=RiF34By6K5vgb1X7xjg9tET5hkgKRnSy3MGRSlfq2LOzwyD9YzX0KWszBrLF0ZpnO+NmxsWa1ENWrRbCuA4msfe17qHF5+uK7wF8YNGDqVjoIHCQi7OplCK6cLBoJenmHqpM6mzTHsHGX+AqjAMcnkHVHdsybD7xvHWJAzkhIkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760698028; c=relaxed/simple;
	bh=qQdBXifothhDj3AZBdraQdix2GJ9g/CASsBOkm8pgKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ifgQcMfxkMevkmva65PY/v6gDzu0FrHlQeAoCC2Bm+Bv1KyfdvqpBXHajiGCfS+oKfsLjeWY5BJTHZUSYdp8AGhwduIdMNMIJtk4BnJj7ecV99L36GcLE0wrlMCPDF1c5SBGMcpi3MncgtXhFl98RKigRds0YELCTxOcQFUywDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJ/FQqW3; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-33bafd5d2adso1487529a91.3
        for <linux-pm@vger.kernel.org>; Fri, 17 Oct 2025 03:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760698027; x=1761302827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQdBXifothhDj3AZBdraQdix2GJ9g/CASsBOkm8pgKU=;
        b=LJ/FQqW33oj93oq8RVNzMsAbirzsAgrNeoDq4/Bw28678gZF4GfMMa8zubfw6JnE8k
         HWPLOUqC6xC769dAqT/oeb0Gmcp6DvRUFHR6JKDH6eLmxukMwOG501pD1x7zvPCZtJf8
         jkXhp/oaKcn5f4OOFczdUBjzZLUE7hMT9pas+S29jZhxSykevkBQWShtj9eS4rZCAdsx
         aYOlQ5PXYnh22hopebyUTkRwdihD3xAVtjnAQbvH9GyIJYUS4f3iLScj5QOik9NqHIXT
         Ncz7fcHO1lFxk6LdMQBLsu5r/uwi2KWTlPnPgU7eTaiRoGbOTQwB9QY+uIYHVdZLpDQM
         x3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760698027; x=1761302827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQdBXifothhDj3AZBdraQdix2GJ9g/CASsBOkm8pgKU=;
        b=Kj1n17CWrkQpuDTE9RsZ4X9vC3BEQO6A4R6b9u/56WvJ2itIAKSTZESthrl3C33wio
         D2ojVQt1Ag+wqUvUZFNz31XGuM9Kn/Dm8ff03a45hfcb3WA4Xk9AhBsTb3TRoct0Gqno
         Ze0LPkJIDJd/irD+frT48J22KdUjyEYrLKEzYFFGxKT44C5cEK/D/DalHZ/lj3tslwYF
         f/qy2GjUVDsyE7EjczLGFzafi2bA4DNdoRSxUJq14T1qSwyi7z9BrVgvhsfwB6cCC6Fy
         NY4BRHOMRrKHoXjmX7J0w8Cusl1fs2APHf8395k32RE6gr5wSDza5AhtF8odFod0qbDH
         HIXA==
X-Forwarded-Encrypted: i=1; AJvYcCUakAjCqKEI57DWfKrRCB/HN4ZOZY4B8b561diRGiFoNrNm+5FP0T0QGn5D6kSY8/MaVRrlXRstrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIjB1/nPBUmQyZZxHj904A+Fn5v7zODca+KLQQU3S2sZwPiZpY
	/i31hevy2ykLdAIPWjB12D6RsKpGd2fBtJeWVhDXsBYgQxReZIkwBB99aG7b9Lfv3GN/Qdibksx
	e4lGjMOwPV0As8ZL/hQIYA3T12Vw9oGJv/Q==
X-Gm-Gg: ASbGncuMV3NFJmyg6rU2nlGXlVrlM6yMNUVNYKed5NmJeywoyQglZO79xF9p1vLv0Ua
	mRZgkAS/dzBr3lbEJlR9PXCOklyBDolZnOI7SEAN4EiNc4JykwqwXWPn8elfj9eiQR3+l4dsd+6
	nxDpM3xwyi4c6GComl4bToGlcVQSGmxcQN/bG1qpCsGCFnRJTs9hMBeUf18c+RF/9Ecbkq69y5q
	2pgEZMQ/LRL5ZTgxG2/qfGDpHXZC17eIqKbWxfa/KmphtlFa0nKEw6lRtBxuSH+b4e8cu0=
X-Google-Smtp-Source: AGHT+IEEaE+tui0U0I0TXcNlTG5xIeJC0VF+DfPTztKKUffqSeF/bX7woXzKAAvsXsqypwGxql2E1Dy8XFNfh8zeo8I=
X-Received: by 2002:a17:90b:1dc4:b0:33b:ade7:51d3 with SMTP id
 98e67ed59e1d1-33bcf8f78c4mr4046515a91.20.1760698026680; Fri, 17 Oct 2025
 03:47:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3a77483d-d8c3-4e1b-8189-70a2a741517e@gmx.com> <20251017103932.1176085-1-safinaskar@gmail.com>
 <0d2eb0c9-9885-417f-bb0a-d78e5e0d1c23@gmx.com>
In-Reply-To: <0d2eb0c9-9885-417f-bb0a-d78e5e0d1c23@gmx.com>
From: Andrei Borzenkov <arvidjaar@gmail.com>
Date: Fri, 17 Oct 2025 13:46:55 +0300
X-Gm-Features: AS18NWBEgDk56WydgN45udggPPH9iWh3lIq14nwoPRXvon1_-ri3PlcNoWOSlMY
Message-ID: <CAA91j0XHt30mqDhgzWnvjbE-iGi3nS1BB1rgZy0Z6mSOT64Abg@mail.gmail.com>
Subject: Re: Long running ioctl and pm, which should have higher priority?
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Askar Safin <safinaskar@gmail.com>, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 1:43=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2025/10/17 21:09, Askar Safin =E5=86=99=E9=81=93:
> > Qu Wenruo <quwenruo.btrfs@gmx.com>:
> >> But there is a question concerning me, which should have the higher
> >> priority? The long running ioctl or pm?
> >
> > Of course, pm.
> >
> > I have a huge btrfs fs on a laptop.
> >
> > I don't want scrub to prevent suspend, even if that suspend is happenin=
g
> > automatically.
> >
> >> Furthermore the interruption may be indistinguishable between pm and
> >> real user signals (SIGINT etc).
> >
> > If we interrupted because of signal, ioctl should return EINTR. This is
> > what all other syscalls do.
> >
> > If we were cancelled, we should return ECANCELED.
> >
> > If we interrupted because of process freeze or fs freeze, then... I
> > don't know what we should do in this case, but definitely not ECANCELED
> > (because we are not cancelled). EINTR will go, or maybe something else
> > (EAGAIN?).
> >
> > Then, userspace program "btrfs scrub" can resume process if it
> > got EINTR. (But this is totally unimportant for me.)
>
> The problem is, dev-replace can not be resumed, but start again from the
> very beginning.

What happens if there is a power failure? We are left with two devices
that are part of btrfs. How does btrfs decide which one is good and
which one is not?

> As the interrupted dev-replace will remove the to-be-added device.
>

In case of power failure it has no chance to remove anything.

> Scrub it self is more or less fine, just need some extra parameters to
> tell scrub to start from certain bytenr.
>
> Thanks,
> Qu
>
> >
> > Also, please CC me when sending any emails about this scrub/trim bug.
> >
>
>

