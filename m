Return-Path: <linux-pm+bounces-20194-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EBDA08EF7
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 12:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0348166307
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 11:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8D8205515;
	Fri, 10 Jan 2025 11:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDZutFjb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573E018787A
	for <linux-pm@vger.kernel.org>; Fri, 10 Jan 2025 11:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736507802; cv=none; b=IH8/BcyEm+VQujr5Ayzssdz/Kg9heEPk4WDnEfp2MuzRIgyScW5EVjPbGGK6g3PZfw5/r6eHBkjsVcq5xJLnZZsn81Qij4jRXjuVHjPNv5VvfomQkG2eOwRyRAHpAKUTUDEF7AhxWNLoeoP9Dw3LfRQrLsZUIlOc9A4CJZ+tMtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736507802; c=relaxed/simple;
	bh=EOeNxVnfbeZZXARhuAVlq1oZTxyMAQHwp1iLPrWqqCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jx9SAOxvBB6OajNsFDId2DxQDcNm715AnscY1yfkoR4NUxVLiInUDyyPyv/vVgJWr0cfYKzB/4lubkXoxAPGBvwfl+PoXM2/mMXlhJe7oFBoGqrXvtsbzkIWGF9J9ITtMMz4kPi8S73HwehlYjRTy6PYhPVswqobvOEqkggduZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vDZutFjb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1469C4CED6
	for <linux-pm@vger.kernel.org>; Fri, 10 Jan 2025 11:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736507799;
	bh=EOeNxVnfbeZZXARhuAVlq1oZTxyMAQHwp1iLPrWqqCg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vDZutFjbeKTkt4Bpwxf7z6/kaf2C0xK5pg2BlC9/OEkA+5VOWnm0CMSnvS8HQlsSQ
	 p/usUZXaZgp9xNMa4ngmLM3giU+cUJgvmoUmr24i9hk9Tkn/VVMfs9GYocY0Wmxt3Z
	 14DyXj7+ElCxk+I9SeyTakecPbH1wV2PdFSVZcB9mPm2pXhF1jH4Ud40o8W3sUhClv
	 fRu1Vj9CvIAhZg9AvstLCRTxtxVWh2YKO7zKBWdSf/NVxyPB7ulZ7uSs4Hsg27Aabp
	 vypF6YXmNG8KHeZOXRJupfqksbXb98Re+2mPMzZoKbARk//jmwWDQUYQh+RdGqO1l1
	 3qeX80zXo3/oA==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5f31841c6f6so1009456eaf.0
        for <linux-pm@vger.kernel.org>; Fri, 10 Jan 2025 03:16:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUWPJD9C8bh9QbeBd1+J9zXMSUksZLWyDWG0+/d+oAPi9FGDwqxqpbZI9D6vXoCyEzY/a20ZGzP5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjFQdM520OyVeenDv641MreOvx0EKX9iMmWQdsqp4EMJEJkiOb
	c1pT8YlZ/qHYfrC685xl6R8JUZ6vD/dIdq1qGjEQW8kxSlnddgYh60LzGvhKfstG009HcnPnc6E
	6saJeVtO6m9dNBlEJuD+tci3ZPxU=
X-Google-Smtp-Source: AGHT+IESefqsu2fKRINlLKliX1X39xuguU4JR5rltWjv9dzjUWEUxKU8+SE7LTlOVor9BGE9LHAFodes0ZLYwRJGcso=
X-Received: by 2002:a05:6870:6b0b:b0:29d:c709:a76c with SMTP id
 586e51a60fabf-2aa0654da09mr5165173fac.4.1736507799168; Fri, 10 Jan 2025
 03:16:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <97c5c93d-e31e-483b-83c3-28b797b69e9a@stanley.mountain>
 <68cdb73b-59cd-47be-9bc1-9affa606ba8f@pf.is.s.u-tokyo.ac.jp>
 <CAJZ5v0h4TUvGKKD51U+RUWv0sCbRjon6PF3ycVaTHMoA=1VEVQ@mail.gmail.com>
 <87e46b70-d100-4ced-9b77-0d30eaecbf2d@pf.is.s.u-tokyo.ac.jp> <a25400a9-ed04-4355-a9c5-e3439ac26d78@stanley.mountain>
In-Reply-To: <a25400a9-ed04-4355-a9c5-e3439ac26d78@stanley.mountain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 10 Jan 2025 12:16:26 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hMyJgsMQojbzCg7wdqX9Rt866gXzNSEwjZ1pge0x4i_Q@mail.gmail.com>
X-Gm-Features: AbW1kvbsMoNCkvqaJg7bJRnLb4SxrenVr-DiyS8am-DXIi6EPpa3t1br-PEd4w4
Message-ID: <CAJZ5v0hMyJgsMQojbzCg7wdqX9Rt866gXzNSEwjZ1pge0x4i_Q@mail.gmail.com>
Subject: Re: [bug report] powercap: balance device refcount in powercap_register_control_type()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 6:41=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> On Fri, Jan 10, 2025 at 10:13:38AM +0900, Joe Hattori wrote:
> > > > >
> > > > >       631                 if (control_type->allocated)
> > > > > --> 632                         kfree(control_type);
> > > > >
> > > > > Use after free and double free.
> > > >
> > > > Instead of reverting the patch, How about removing these two lines =
to
> > > > avoid the double free (so that mutex_destroy() is called in the cle=
anup
> > > > function as well. Not that it makes that big of a difference though=
). If
> > > > that is ok with you, I will work on a patch to fix it.
> > >
> > > I'd rather drop the commit in question and feel free to submit a
> > > correct patch for the device refcount balancing.
> >
> > I have just submitted a new patch addressing this issue. Please review =
it
> > and apply it if it seems valid after reverting the original patch. If y=
ou
> > prefer that I send a separate patch to revert the original one, please =
let
> > me know.
>
> No one sent a revert patch.  We were hoping that you would handle that.

I'll just drop the old one, no worries.

