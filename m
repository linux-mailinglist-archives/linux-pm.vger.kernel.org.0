Return-Path: <linux-pm+bounces-16466-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B249B062B
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 16:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0BE1B22145
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 14:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEAE82D98;
	Fri, 25 Oct 2024 14:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILh45Nv8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60341212198;
	Fri, 25 Oct 2024 14:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729867852; cv=none; b=jSpIigcWyIGg0HVlxi4p9fNKSl8wTLnAY20ZuTRIhBezstk+Fudyfbmgrlni1lFqAtA3s1ScEnqfKW1u1IoW+2g7oFENT0xgo0Am8kVLTveUMx+NpBozsuHvTfhie4/vBlaSyKqAOw2pynMgerOKAyg/j7i3w03xyZL7wrt+lyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729867852; c=relaxed/simple;
	bh=lbkzqx6Hz1byC5i/7Qlzh5KnqixguSz6h55MbNBoJtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XehYisO8AZ3Ei/j/EMMs/OANX1wRvAWvrHIfFYo9P0pyuULxUUS8tSD+xQu4c4wMX4PL6IRGlTmynwVRbtjELYDjd1uqqjt1YVkAhNv1sFBN6mUKKzBaKncP77aZ1FOocqYoOmqblRxfs5YfNIV6RDTPDH52YHUeUUow9Dn2o1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILh45Nv8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB58BC4CEE6;
	Fri, 25 Oct 2024 14:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729867851;
	bh=lbkzqx6Hz1byC5i/7Qlzh5KnqixguSz6h55MbNBoJtQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ILh45Nv8Y9w6fPBQrRnXcEX4EWix3adXWDmoH+hIUGXln3yp3y+culde0nk5Iwf7D
	 r1SjJrfJdONTiQE8qYNNEOZpou8xJq7YmIzq1G2aIWjfAxsDM9AEd0vwX4Wgwa9/S3
	 eiIs7msQ11AG9GXotvWZiQXmUd3utAYnfZyGgAWaTtSyBJb+YchNMwSm1pV5dC53AG
	 U/cDSnWvIFIeMT1ZIjjzf2GIQYY2nMjNwpbZmPx0wp9XqVZdOtcC2LBinCUUNRmzFN
	 VthZ2Jn/7OPgH8RCVdJKDphaLM7Bjlgt7qZhkQBdepKMN/4RzuddoUN2dUgV8K2jlr
	 bxu19Ohfly73A==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-288dfdaf833so1172156fac.3;
        Fri, 25 Oct 2024 07:50:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU/QRygb+qyvTXBMajj6K4BpWXN/u/037IUxmzX/dvjm3bpcblEsoV3dTDNT8aZVEe/Jj0XXTHobyqDayo=@vger.kernel.org, AJvYcCWxA/QLjmj1MIcp6X5kcWvFt0BPOWyWMEigiGfT5QAt3Za/wtmjmfSl/IexoLirvtj7ZBb/7vn9JYo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8RVASUoYv+d91US6vEZ25EUuZXcHtsPi9AOE8pRIFKkvpl2jf
	aiqKNTMfgd7NoAwlW/MbjxPcnWQQuXCu9JMByiIitZwdcVBETgbFwGf0+afRynOTRu2B+bdcvPP
	PVC5qjTk8/mdmDXxfmNSCEWvzhX8=
X-Google-Smtp-Source: AGHT+IEJFoCrlWySn0tRGfKeE0Y98aM5eiWa2bqEtA+5+MnrUJZ24l9Mr1eTCNHBlm2O6sx8eBQE/i28P+DSa3riORw=
X-Received: by 2002:a05:6871:691:b0:25e:13b7:e361 with SMTP id
 586e51a60fabf-28ced2fb28bmr5826234fac.25.1729867851176; Fri, 25 Oct 2024
 07:50:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002194446.269775-1-msp@baylibre.com> <2024100333-maternity-equity-c7fa@gregkh>
 <tqsrnsvciupbovlalqsnrp5whst2mrpqntjblvymcunpesvake@o3gxa7vik7he>
 <2024100336-left-shadily-3321@gregkh> <20241025131542.5bfvqtepcefup3hv@mushy>
In-Reply-To: <20241025131542.5bfvqtepcefup3hv@mushy>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 25 Oct 2024 16:50:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g1Ri_wKYppomE6RXqcZXRnX7bLOPMtsQaao0uchSfE9A@mail.gmail.com>
Message-ID: <CAJZ5v0g1Ri_wKYppomE6RXqcZXRnX7bLOPMtsQaao0uchSfE9A@mail.gmail.com>
Subject: Re: [PATCH v2] PM: QoS: Export dev_pm_qos_read_value
To: Nishanth Menon <nm@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Markus Schneider-Pargmann <msp@baylibre.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	Len Brown <len.brown@intel.com>, Vishal Mahaveer <vishalm@ti.com>, 
	Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 3:15=E2=80=AFPM Nishanth Menon <nm@ti.com> wrote:
>
> On 08:49-20241003, Greg Kroah-Hartman wrote:
> > On Thu, Oct 03, 2024 at 08:28:12AM +0200, Markus Schneider-Pargmann wro=
te:
> > > On Thu, Oct 03, 2024 at 08:02:04AM GMT, Greg Kroah-Hartman wrote:
> > > > On Wed, Oct 02, 2024 at 09:44:46PM +0200, Markus Schneider-Pargmann=
 wrote:
> > > > > Export the function dev_pm_qos_read_value(). Most other functions
> > > > > mentioned in Documentation/power/pm_qos_interface.rst are already
> > > > > exported, so export this one as well.
> > > > >
> > > > > This function will be used to read the resume latency in a driver=
 that
> > > > > can also be compiled as a module.
> > > >
> > > > We don't add exports for no in-kernel users, sorry.  Send this as p=
art
> > > > of a series that requires it.
> > >
> > > Sorry if this was unclear, it is for an in-kernel driver (ti_sci.c) t=
hat
> > > can be built as a module. When built as a module it can't use this
> > > function if it is not exported.
> >
> > So the current kernel build is broken?  If so, please add a "Fixes:" ta=
g
> > and say this in the changelog.
> >
> > If not, again, just make it part of the series where it is needed.
> >
>
> Greg, Rafael, How do you wish to route this patch in?
>
> This patch is a dependency of [1] which goes through my tree.
> If  you can provide an ack, I can pick up the patch through my tree,
> else we will end up with dependency issue here.
>
> [1] https://lore.kernel.org/all/20241007-tisci-syssuspendresume-v13-0-ed5=
4cd659a49@baylibre.com/

Sure, please feel free to add

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

to it.

Thanks!

