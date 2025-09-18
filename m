Return-Path: <linux-pm+bounces-34974-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04346B85B88
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 17:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C6A01C22B28
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 15:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A25F3128D0;
	Thu, 18 Sep 2025 15:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AIT4b7dj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA9F3126CD
	for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 15:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209868; cv=none; b=nixNahrxmPeX5iWBLiONMN2fLCFI36dQKRrWeGKPBCu9JIywvTEGWdejb+Gd1AnK8OX4DCvFlZsXCeLZs9kDlfsN5K7nTitUu5kbQHa0wP1H8IaTa4T2hnlaJeBNL+Ml6EO/kOqWaNqLnagQ+wzEYShTN7LTehHnCZs5GYfwYI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209868; c=relaxed/simple;
	bh=7xlUHVUZs+o/rLsFgTFSWQv5sonPIDCOjuBaYxKvxdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GGnPPYHQWghRydJMRR80/3Un7QZV0FdiFpacglfQzJpQudhEBN+mW2oya/0h2rnPz/YCclumBbuXcptGIec0Bvk3BdqsIX6BawseZoogP8l+KuJIe3nw+7i9zvlzSPYfEVLYr/KGyuBH1OnxH/MeMPG3hOit2TFGBt/WX0v18II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AIT4b7dj; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-63470a6f339so255851d50.0
        for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 08:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758209866; x=1758814666; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7xlUHVUZs+o/rLsFgTFSWQv5sonPIDCOjuBaYxKvxdQ=;
        b=AIT4b7djpj5oKY36lDBlURHuW4Pwz6DEj9Xvr/xUzyIdPtAo2gTF6tW9zJ7R/ltaKJ
         XpQpNQaL4OULHzFOO7vBX3rCFqHECASl5eg+9Sog6OeNUHwYy6jeon7RYrA834YQeCTL
         LU03cyCuRx16wjDIASvxZuV7oksUAZA9LhH2q7uk2cXqpcORLDwm7XODvvTIfYCLidGp
         NKwrp83ZxQlTIIYElC0/Kbf7msPmOAquuo3sZxAPB0DaXuathkkWfYwgDvP9viNzg9Sw
         vmNLov0A8oYVxQDhbVVWRiCREfmmaoKTT0LIbtAQEHBxmaE6vMqUVjwvXJtaWb0CFerI
         hhRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758209866; x=1758814666;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7xlUHVUZs+o/rLsFgTFSWQv5sonPIDCOjuBaYxKvxdQ=;
        b=WjtcY7yc8yYoobgvt456iMvLfgtaZ6rIlZAhm1MXXroXuY78iup/yBXspF7qAD7a4f
         LgtLQE7sEMcq0neET0c0E8wUVPf1tQlahT1N7IWZuD8YVpsLzlUDvRpInVH8fJeYMuVN
         zvCkCZt/yZuxYiFkg/uTujNc4Lt5aI38uC4UqFDKC0iVm3GaOGiem4L2t0S7200z6zVd
         9pqvP81RJyrvsrnx6wJGnd3nWG6eTo5nF4e/v8pEjXdz+CqH74aPgnhBVh/JPyTxwdZJ
         7tiXYDt4Xgr1oGN0xjWKGSveJNq1uQbdQyLugY0xbvULJTs+KHV+60g3ShdMZt8jimfG
         /FYA==
X-Forwarded-Encrypted: i=1; AJvYcCV8qe1ZGPjzZzdRdzSUlgFzuok7g0nAW5sCY+/s++/vynOkjjie+AQy5FlpN8xNSE6eMtnjHUCVig==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQDMa98ZPgb5HBCZPaWH2jhVzaLq2vdYAcE24oApL28lBTgEIA
	mWOjBsET9InD+i5NjKVcqvUi3+uTSoviIPdcV6v6EvETvEFeuRGJvOFzBMuPf23g4Be7UTGIO5S
	fTpc2E9kDJlHWjjAJpQn0I39s42gh1F/wGS5JTepFCA==
X-Gm-Gg: ASbGncvHrB09pc+tyl3q9FMNgKXqhyiODAJh4l0YoLDsOqXDV1Ohxkqq//bbQatYili
	vWmiOVy3+xTr2erMpb2ICnBMprfXkfdAnL53r9/BQcP464liZLdOjQjJ3UpsH7x5mSY9LBvMWH7
	QgolUrpzIj3xSOJtv7aY1UrCnIcZPmKx5o2/XiT3yuk+pwUJa6sKQtYlhNvH3/qec+/bP3LOp9i
	QmX0voEQOegMy6+Et4RTNoVMok=
X-Google-Smtp-Source: AGHT+IGtqJvo4MVxS472kzqGxtAHHh0rdIn7sRNAQ4ViXkzVaniJnHWJAGXpjD7HDhokIclkvH7bXIC8ZMqw3sAEmsY=
X-Received: by 2002:a05:690e:15da:b0:62c:bb1d:5694 with SMTP id
 956f58d0204a3-633b074bd1cmr3510380d50.35.1758209866010; Thu, 18 Sep 2025
 08:37:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818074906.2907277-1-uwu@icenowy.me> <20250818074906.2907277-2-uwu@icenowy.me>
 <i6slr5csro54ys5g7diqyacq4deidwm6f2nhpm2uwmgjlu6tyn@otrbpij4vdya>
 <aMm6UIMTFOH0Z3Ug@x1> <7ru5tunm3vlmtuulkbc7kpunyim3ks3he4ielc77ivm7vxieqk@iw6xmwmsn3lk>
In-Reply-To: <7ru5tunm3vlmtuulkbc7kpunyim3ks3he4ielc77ivm7vxieqk@iw6xmwmsn3lk>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 18 Sep 2025 17:37:10 +0200
X-Gm-Features: AS18NWCLe6oh-uLn8GnYoZwHpnz9EAYCU-8ecy6whZL-NO0kp3ol_7PTuu2q400
Message-ID: <CAPDyKFp221d_RQmqoLDVxKOuphqASKK57UB4FzndKJFT5VBnHg@mail.gmail.com>
Subject: Re: [PATCH 1/2] driver: reset: th1520-aon: add driver for
 poweroff/reboot via AON FW
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Drew Fustini <fustini@kernel.org>, Icenowy Zheng <uwu@icenowy.me>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Han Gao <rabenda.cn@gmail.com>, Yao Zi <ziyao@disroot.org>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Sept 2025 at 00:18, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hi,
>
> On Tue, Sep 16, 2025 at 12:28:16PM -0700, Drew Fustini wrote:
> > On Tue, Sep 16, 2025 at 08:22:02PM +0200, Sebastian Reichel wrote:
> > > On Mon, Aug 18, 2025 at 03:49:05PM +0800, Icenowy Zheng wrote:
> > > > This driver implements poweroff/reboot support for T-Head TH1520 SoCs
> > > > running the AON firmware by sending a message to the AON firmware's WDG
> > > > part.
> > > >
> > > > This is a auxiliary device driver, and expects the AON channel to be
> > > > passed via the platform_data of the auxiliary device.
> > > >
> > > > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> > > > ---
> > >
> > > Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > >
> > > Greetings,
> > >
> > > -- Sebastian
> >
> > Thanks for looking at this patch.
> >
> > What tree do you think it should go through?
>
> I'm fine with Uffe taking this together with the second patch or I
> can take it and provide an immutable branch once the second patch is
> ready.

Okay, when patch2 is good to go, I will pick up both patches (no need
for an immutable branch then), np!

Kind regards
Uffe

