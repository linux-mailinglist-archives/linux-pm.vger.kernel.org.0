Return-Path: <linux-pm+bounces-34475-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2557BB53420
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 15:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 608515A1D6A
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 13:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AF83148D5;
	Thu, 11 Sep 2025 13:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ai8tWGpS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E0C33470A;
	Thu, 11 Sep 2025 13:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757598064; cv=none; b=C7lbHeCPPr7ClhUWsAIVW0U70iapTPs3JdinLFdgvZjcx7XPdsRPD8VHJfz8xRkDbRS8iJbNGQWSQxEfAXG9wO1w8lEuwJ8107pkBvtgmbXqPzTYgLllqDOrft9G/o26zfqMKZF9vT3G+aWohwYnhh0yGFATfVpOjNMpv0NT7Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757598064; c=relaxed/simple;
	bh=4GOimZuCjMjnQDw/vO7zqnA0XrzTPhX1XwC3bOoutuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fdHmrLRHb9wxqUd3uRjUrgDxu7HQcM0Pgwfv6S0nN8wEPbAmdKYAak214eq1uszG8f5Hy1RZ+XRjhvsLZGl5doBEIz9jH7CSEsi13Om+/sr7sX6jSBGUwmZs3gbKTzjg8oyy4BICrEP/vb+5uHTSwd+b+AGkgd3vUtgCGnu48vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ai8tWGpS; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-544bac3caf2so1376406e0c.0;
        Thu, 11 Sep 2025 06:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757598061; x=1758202861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFoqqg9HB/F9uRN/q/qwY87bYq3FGS0iKiVdBCe8Ns4=;
        b=Ai8tWGpSIV4cVAmfRgWN72jhVjo6OkPFn0z5gjRATZekRAzzsa5r5Fj8iMAppofW5a
         Rx6bGfOCyLt1sBWQnRIpAsMTSEVOY/0wxru+Z2Rh1nGzpKOoLNfqHT59GX/yB5MbNEkA
         rj+W4QcgcYZCzeg/+Zmffb7VpNr/uXVcJsEWUOzKdcP20Pu6Y030Hkpv1ep+elJaUWit
         u3MWPact9IkKY1fYpEHC5OJQnvS2abdEC5ekVd/I20ZSUSla1zYLmFy9rYvP0tifOuvx
         bwOQYqxmcOD/WzgziHlqRDY2b0KD/D4SnH5h4MvFWepDmFSNwO5j1ki0YWGw9iepy2yN
         qhcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757598061; x=1758202861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QFoqqg9HB/F9uRN/q/qwY87bYq3FGS0iKiVdBCe8Ns4=;
        b=rFs3/8K/FsmmwOEhQqpn66+U4JfMNO8564sBa6XTyGtsfZhWrAKKm3OV9uEoseqgxT
         MOXZzr/dxZnqk/SpMolfTXTRQFanVQbQIlQSJpK5EukhOMFQR1ogbAnCqVcqkvcCHE45
         mhn0ZIQx2Hl1CaPu8fydQcypeCZEkNZDsvkpONl0KjsfoCouQpOwgq3eYWUhRbol/8JJ
         iYom0foWg+/oYUb+5cRJ2LDH6GWhUUlPzJOWfJ3ORmckhaBBGMRDel7NfMuf0CMr2cpM
         /1EISTseR0oZbwJzonKVq1kirN/YJTHChq9UOiVjEF19ePyochxM8XKfjp03CHTwQWQR
         UfRA==
X-Forwarded-Encrypted: i=1; AJvYcCVLFYV3L5DY4nnj4QuaSJdDr9S9ztMSn5OS7r6sqG8/wuxMpgdRVjGsuGGajb/QpHr55JZie4zNM1M=@vger.kernel.org, AJvYcCW3g2vTkL31kEUizBSiqrbwnoHL0GsEJxpORsdpX7tRbnK1iSF23azfNzXMgJ9Ss76/thvYxd0sqfv7@vger.kernel.org, AJvYcCWvmGsVUVo+/zLIBBefUiWX0J9WLa2dhg6S8vZyJPZtWEZ0ogCmN2Db2ZA4zFtTif+/PykULUUsDB46aJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZtzFUwlxMV1jfLhEX/5nntyhl5s5r7VsOvVDdHiQhjbetOpZI
	FeoJ4+4lJlDWQm7HPF/hCCygmcb96qb/FYgZga3vq/OQnRD1q3WI3UzG09cBEzqlDCMHt58irfd
	mMznONdIrC4kAxUeRnpkPsN3PfxfDbwQ=
X-Gm-Gg: ASbGncvVYvCLm12IuCwJ1A+9DMOFPHxNQbTHl5m5Wr0M+GZTw20tJ5NW73JTpV2PpEX
	QeIJiygrHqpKKSO3qr22BI2KpoibjDMx2yNsxYHIHD8N+agKagmWK86BtSpQM4/5oNlSJ1Y3jxV
	k4t6SAqkyKL9VYNGtjIqhujMzslhMDl0BwB2X7m+NW0KeLfMP62kwCvThSIT036LuRLG/lEZIQy
	TIBUb9p5gQ8VbU3E/ZMMReNyi+dd7snNZIIrSoSyPUrpYxIJS9Mj2iP
X-Google-Smtp-Source: AGHT+IGrWc6XTmA/v3/IdSr1elQps78uszCOTQk4mSLJ3DEhbUGYLXFk2shr6X2ypJW7j1eC7QInQ9A102NMrOsd8Qc=
X-Received: by 2002:a05:6122:2053:b0:544:9147:52 with SMTP id
 71dfb90a1353d-54a098ba0cdmr934429e0c.5.1757598061035; Thu, 11 Sep 2025
 06:41:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <385dccf3-234a-4f83-9610-81ac30bf1466@rowland.harvard.edu>
 <20250909161901.10733-1-ryanzhou54@gmail.com> <20250911013242.oxm2kwfaqvmybbhk@synopsys.com>
In-Reply-To: <20250911013242.oxm2kwfaqvmybbhk@synopsys.com>
From: ryan zhou <ryanzhou54@gmail.com>
Date: Thu, 11 Sep 2025 21:40:48 +0800
X-Gm-Features: AS18NWCKtePHYMAduUSHTwN9PCNXyjxTh0Zg1L3vfISxH0xuTEalPCDfAK8rEgY
Message-ID: <CAPwe5RNddK2=bvrd6h_xyxH+SDDx7kx2tyDKRhyuDGvHYewGvg@mail.gmail.com>
Subject: Re: [PATCH v2] drvier: usb: dwc3: Fix runtime PM trying to activate
 child device xxx.dwc3 but parent is not active
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "rafael@kernel.org" <rafael@kernel.org>, 
	"royluo@google.com" <royluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thinh Nguyen <Thinh.Nguyen@synopsys.com> =E4=BA=8E2025=E5=B9=B49=E6=9C=8811=
=E6=97=A5=E5=91=A8=E5=9B=9B 09:32=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Sep 10, 2025, Ryan Zhou wrote:
> > Issue description:During the wake-up sequence, if the system invokes
> >  dwc3->resume and detects that the parent device of dwc3 is in a
> > runtime suspend state, the system will generate an error: runtime PM
> > trying to activate child device xxx.dwc3 but parent is not active.
> >
> > Solution:At the dwc3->resume entry point, if the dwc3 controller
> > is detected in a suspended state, the function shall return
> > immediately without executing any further operations.
> >
> > Signed-off-by: Ryan Zhou <ryanzhou54@gmail.com>
> > ---
> >  drivers/usb/dwc3/core.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index 370fc524a468..06a6f8a67129 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -2687,6 +2687,9 @@ int dwc3_pm_resume(struct dwc3 *dwc)
> >       struct device *dev =3D dwc->dev;
> >       int             ret =3D 0;
> >
> > +     if (pm_runtime_suspended(dev))
> > +             return ret;
> > +
>
> Is this a documented behavior where the device should remain runtime
> suspend on system resume? I feel that that this should be configurable
> by the user or defined the PM core. I don't think we should change
> default behavior here just to workaround the issue that we're facing.

No documentation was found, but modifying the runtime suspend state
after wakeup from sleep seems unnecessary if the device was already
in runtime suspend before sleep.

> What if the user wants to keep the old behavior and resume up the device
> on system resume?
For USB devices, RPM resume should be initiated by plug/unplug events,
not PM resume when the device is physically disconnected.


Thanks,

Ryan

