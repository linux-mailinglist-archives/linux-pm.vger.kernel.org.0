Return-Path: <linux-pm+bounces-11534-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE90093F4AD
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 13:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 524F31F22830
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 11:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C6714601E;
	Mon, 29 Jul 2024 11:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KshWaNPw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38150145324;
	Mon, 29 Jul 2024 11:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722254202; cv=none; b=WOzDnMLsupuImNNyglMNN1GqtQFJSc1tUhAc8DXR23SbOVCLigmfDnKuOuls46Z9Z9bZCZt5atLbuowe2247nfjnfIGS5eHvpS6uYKp2vIxDjGlKTD8QJFKhrBluQ0QPYYWbQIfpoJE/Hi8YJQrNatp9R8lTtpPJNDOC+YKZq80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722254202; c=relaxed/simple;
	bh=qrvKMtOz6tw5r0QsJJlCGs68EFG0IVCf4AJqTnpCzfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J3i88uoDdM+igb1Rk7L2DGq5zQ7wsMTjefwZmhVSuGI3k0GfC23Nz5gjOjz2zSTAdkwoURDwKd5hj/jJZStBZ+1/NPmaqHebSH3HVye0HwBRgaC5xcPG7g07ImfI8EQMi0ONl0tJKeQn6934HDemSxuhz/BLh/pN/wkwdu6vEOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KshWaNPw; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eeb1ba0481so53754451fa.2;
        Mon, 29 Jul 2024 04:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722254199; x=1722858999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IoaDZPE7aY3eyjAwEZm9aiUjU/Z3vM7/coDBxAHRjew=;
        b=KshWaNPwbCFUQ1Nfmcl+fu6AhuueHiDfGcEPfPCsn7u/dkT1LOB8yBg/6RqqgV0bz+
         yjphSCH6vIvGpT00r2orqBqSztB2JKjKKWEqXtnNAcXkwWKxZbWYG8qsKxrojG6BkHt3
         tkiOChIxlaANEovwbNP1WujU7+oNNxA7D/m7teq8BAmKacO6cDMLrLaXT7usIAGWtiuH
         AWqhD9F3Zk/DB+LGFHjc4kRfrIKiDkI1qklV7G/xqwGxadEjyvmF/IHDlYaBruvG5RO6
         4IR1hzuRQz8cWqu3RJvRSsSQHZcNA0Z5LQfql9WncgQnwY8+xCZNziFiB738oTjFsgsN
         ysqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722254199; x=1722858999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IoaDZPE7aY3eyjAwEZm9aiUjU/Z3vM7/coDBxAHRjew=;
        b=KYFkBEg5/ZgHttXraqJSi00S9GyPefA0ArjO3zzXajFZ11EVD7BQhKbcjmHV7r2V63
         mZo3XTDCqt/iZQLg+yGVkMMFdun/zr3dPonUKU1DNQA/319nzyrjhrbMOuvIIz5fiN27
         bsXu+j8DGnyrnFC6K2etvcS2GKaLltWHH4FlTtm2cU7k7vs+3KIgsruZkJ/bhqZkUW3X
         fEf06Bq4jCuDaOWwP7STxJKEc4av3vQ9cM337WVbF3IXBg3TPMv26KeOOEPzefGv9YUS
         1HoxyYt0xOvg20Ggp4NLmixkcP2jYBa/3w2NIPH94tS7qcj5kmfm5Ffm434i+KkWW6cX
         wsQg==
X-Forwarded-Encrypted: i=1; AJvYcCUZv/VTEJDgyQwkcK8kLBiG7IihRrX69lmivQ1Kj2YyiYDAEAdWSP2LnwAW11tQhgcJ2aNVouvpeUCsWmhCiIkE8RFJKZgdxSykWJ29GPvLUaqXty7jUMjh50nZVBswHYDG0QrS5Hlp0pK+1iNSWyPuCJ7vwgBRm8SkD++ZxKA2GkMNa3+CEntU
X-Gm-Message-State: AOJu0YxZr3pYEYQl8gRY7ITA5MznI9fe8Mocr7ZXoY0n71RvOEDZyRcf
	zNUqU/W9/JWLZ+bDk0nfSL3RDywehiELqdtOhdgq+joI2gr3m3JqEY0oslqf6sDK4kdX4uT0mW2
	3p5gnf7qFwMwnliAgBjhJr3pNp9I=
X-Google-Smtp-Source: AGHT+IEIJCBEybW5ODviiZY9OXaiGOJYxUayf5oCFzfysm4zRoy1l7gK17ozt9Nn/Y6qqxZtSrunGPcUIKba83QU2lU=
X-Received: by 2002:a2e:a495:0:b0:2ef:232c:6938 with SMTP id
 38308e7fff4ca-2f12ebcae5amr48522491fa.6.1722254198904; Mon, 29 Jul 2024
 04:56:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <su3wp6s44hrxf4ijvsdfzbvv4unu4ycb7kkvwbx6ltdafkldir@4g7ydqm2ap5j>
 <aa9d6aec-ef94-4137-b2ff-0c86d9a92d42@molgen.mpg.de> <CAA8EJpqGXe0A0yDpEP==60k-bPEbDORpLUtsiPvGSi+b_XphAg@mail.gmail.com>
In-Reply-To: <CAA8EJpqGXe0A0yDpEP==60k-bPEbDORpLUtsiPvGSi+b_XphAg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 29 Jul 2024 12:56:25 +0100
Message-ID: <CABBYNZJP2c4L-nFHtug0isqnKPR+Q0CE09o_ACsPLobjLpHtcg@mail.gmail.com>
Subject: Re: btqca: crash with linux-next on bt power down
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Marcel Holtmann <marcel@holtmann.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-bluetooth@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	regressions@lists.linux.dev, Zijun Hu <quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Mon, Jul 29, 2024 at 12:01=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> #regzbot: introduced:
> 973dd9c4db4746200f88fe46e30eada7054fdbea..84f9288208dfcd955446060a53add15=
b9e01af4e
>
> On Mon, 29 Jul 2024 at 13:21, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
> > Am 29.07.24 um 04:11 schrieb Dmitry Baryshkov:
> >
> > > On Qualcomm Dragonboard 820c (APQ8096, QCA6174) soon after the boot I
> > > observe the following crash:
> > >
> > > Unable to handle kernel NULL pointer dereference at virtual address 0=
000000000000018
> > > Mem abort info:
> > >    ESR =3D 0x0000000096000006
> > >    EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > >    SET =3D 0, FnV =3D 0
> > >    EA =3D 0, S1PTW =3D 0
> > >    FSC =3D 0x06: level 2 translation fault
> > > Data abort info:
> > >    ISV =3D 0, ISS =3D 0x00000006, ISS2 =3D 0x00000000
> > >    CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> > >    GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> > > user pgtable: 4k pages, 48-bit VAs, pgdp=3D000000010da63000
> > > [0000000000000018] pgd=3D080000010da62003, p4d=3D080000010da62003, pu=
d=3D080000010da61003, pmd=3D0000000000000000
> > > Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
> > > Modules linked in: hci_uart btqca
> > > CPU: 2 UID: 0 PID: 66 Comm: kworker/u19:0 Not tainted 6.10.0-next-202=
40726-13923-gd3ce7ebd61f9-dirty #2722
> >
> > I am unable to find the commit. Your tree also seems dirty. What is the
> > last working commit?
>
> Checked the commit range on the linux-bluetooth branch, hope this helps.

Im currently traveling so it would take some time for me to
investigate this but I suspect it could be some of the changes
introduced by Bartosz with power sequence, @Bartosz Golaszewski
perhaps you can help?

> >
> > > Hardware name: Qualcomm Technologies, Inc. DB820c (DT)
> > > Workqueue: hci0 hci_power_off
> > > pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> > > pc : qca_power_shutdown+0x8c/0x210 [hci_uart]
> > > lr : qca_power_shutdown+0x7c/0x210 [hci_uart]
> > > sp : ffff8000836f3c50
> > > x29: ffff8000836f3c50 x28: ffff00008337b900 x27: ffff000084085000
> > > x26: 0000000000000000 x25: 0000000000000000 x24: ffff00009276f800
> > > x23: ffff00009276f918 x22: ffff000081e1fc80 x21: 0000000000000001
> > > x20: ffff000081e1fc80 x19: ffff00009276f800 x18: ffff0000de422170
> > > x17: 0000000000061d88 x16: 0000000000000000 x15: 0000000000000001
> > > x14: ffff0000813b3580 x13: 0000000000000000 x12: 00000000000001a0
> > > x11: 0000000000000001 x10: 00000000000013f0 x9 : 0000000000000000
> > > x8 : ffff8000836f3b40 x7 : 0000000000000000 x6 : ffff800080d52e88
> > > x5 : 0000000000000000 x4 : ffff8000836f0000 x3 : 0000000000000000
> > > x2 : 0000000000000000 x1 : ffff00008f56d000 x0 : 0000000000000000
> > > Call trace:
> > >   qca_power_shutdown+0x8c/0x210 [hci_uart]
> > >   qca_power_off+0x70/0xfb8 [hci_uart]
> > >   hci_dev_close_sync+0x4b0/0x6d8
> > >   hci_power_off+0x2c/0x44
> > >   process_one_work+0x20c/0x62c
> > >   worker_thread+0x1bc/0x36c
> > >   kthread+0x120/0x124
> > >   ret_from_fork+0x10/0x20
> > > Code: f9400681 b4000441 f9403c36 f94102c0 (f9400c00)
> > > ---[ end trace 0000000000000000 ]---
> > If you can reproduce this, bisecting this would be great.
> >
> >
> > Kind regards,
> >
> > Paul
>
>
>
> --
> With best wishes
> Dmitry



--=20
Luiz Augusto von Dentz

