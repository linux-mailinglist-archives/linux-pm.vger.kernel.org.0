Return-Path: <linux-pm+bounces-26968-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA2AAB1ABC
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 18:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CBC13AE218
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 16:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B2023643F;
	Fri,  9 May 2025 16:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wu6v7//0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0AC13C3CD;
	Fri,  9 May 2025 16:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746808882; cv=none; b=Sq/CTMpe3JoXuVVi18qWqKRCY51perJcbhmQ2V4xnL23kPNXfYzbkL0lbAFeXryEAGkaFN235cJ8Xw9955O/qmMV1DOAlarP7GOq+VfPhotQu5de8n05FBRLgM6qc+kaeum7AoNwJK0xgHC3bPlHbuyyIgvu48z8Lvd6Fh16p4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746808882; c=relaxed/simple;
	bh=y0IAr64O+aYheRZ0wUGqwC1rzhN+VdRSDxf68VbESD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OzznVyj6USl4rITllkUiWaEx9I5FfU1LIVqQRK8y60MwWPPPCpU/kKV/6lakPLG3hSvIqqKBa6/MCX3zI081n8iZrWozVhZ2ahSuzajy+LoC23DbbA/yut/DvHXb/sv0Ml4AcuFuFB/lEOA7mCyqirLpnGvcy7OJTaohPI8X0UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wu6v7//0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65DBC4CEED;
	Fri,  9 May 2025 16:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746808881;
	bh=y0IAr64O+aYheRZ0wUGqwC1rzhN+VdRSDxf68VbESD8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Wu6v7//0wo+4nft/qVjSdeZDbGipVhncxiMduFAq58PvUV9CkE03zxTiDKEfjQuai
	 7kVWr4W5yEqIx9es2m8d0sewPlFcGhf5KGfbQ+s1vabZF67Dki3y8Ik77aymXoI++a
	 W5jTMwgW231enFsIbIXaTXntGUKaFjUbcz0f1YEs2fArDSeooWHMs/rMnglkngC1cZ
	 TYur2oJWrKgHRuKJoWROHZ7KTW+veRBl6k4lxLetWStVPyF2vrLHlclOw9DZ/+CdFD
	 ZporQPZTGea7i92ysYV37dCQcwd7iik4ds4Weik61CN20OB/Y98dQoOnB67nXNJaUX
	 etGnW7Aiemf6Q==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2c873231e7bso1877096fac.3;
        Fri, 09 May 2025 09:41:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUKGG41KnDBn2uTa5wcKXrvzpDCsDssLjqBYhN98OHM1OKbzY/YIjPUGrMTfYuDNba9vBZZEio8S/oM2yA=@vger.kernel.org, AJvYcCUlUWSp5CfDPNbC1X17fT5MxUxHJH+vOTp4DsCYQVGpRPQ8YdPTRnRk0zVRjXSI2Z42ntw9U1neg4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA8Qdvrli2EGXYvIzNvB3//AmTw9BOE+pzbdnQDj6HvJbpBBxR
	Ij2jau5buOmbFvp+HIjgQPW606KZiN17eOSMLBwDLHou0q5KyyXoruAjqErIDm8Tx+Hk4SgTrmQ
	qyeLp03c3KPxDeTDPX9nAJgxraEY=
X-Google-Smtp-Source: AGHT+IFpEyejOAgEPyjkdGwaTitBM/mMEi03IHz5RFan2KnBgN9t31wT0HOuCTPZzGWKSJZuETYd9A4NMQMsmtjo+UM=
X-Received: by 2002:a05:6871:782:b0:2d6:6639:52d9 with SMTP id
 586e51a60fabf-2dba45282c1mr2688171fac.32.1746808881126; Fri, 09 May 2025
 09:41:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507014728.6094-1-changwoo@igalia.com> <a82423bc-8c38-4d57-93da-c4f20011cc92@arm.com>
In-Reply-To: <a82423bc-8c38-4d57-93da-c4f20011cc92@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 9 May 2025 18:41:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ixh=ra-TDbC59rpZoGn0pRWmAMchHqoOb_XwB2XUzA7Q@mail.gmail.com>
X-Gm-Features: ATxdqUEhekjKxOiCqJACIRj4Yucv3oDY0_mHhqtzyWszh96966OwdYTQVrriguk
Message-ID: <CAJZ5v0ixh=ra-TDbC59rpZoGn0pRWmAMchHqoOb_XwB2XUzA7Q@mail.gmail.com>
Subject: Re: [PATCH v2] PM: EM: Add inotify support when the energy model is updated.
To: Changwoo Min <changwoo@igalia.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: christian.loehle@arm.com, tj@kernel.org, rafael@kernel.org, 
	pavel@kernel.org, kernel-dev@igalia.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, len.brown@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 12:55=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
> Hi Changwoo,
>
> On 5/7/25 02:47, Changwoo Min wrote:
> > The sched_ext schedulers [1] currently access the energy model through =
the
> > debugfs to make energy-aware scheduling decisions [2]. The userspace pa=
rt
> > of a sched_ext scheduler feeds the necessary (post-processed) energy-mo=
del
> > information to the BPF part of the scheduler.
> >
> > However, there is a limitation in the current debugfs support of the en=
ergy
> > model. When the energy model is updated (em_dev_update_perf_domain), th=
ere
> > is no way for the userspace part to know such changes (besides polling =
the
> > debugfs files).
> >
> > Therefore, add inotify support (IN_MODIFY) when the energy model is upd=
ated.
> > With this inotify support, the directory of an updated performance doma=
in
> > (e.g., /sys/kernel/debug/energy_model/cpu0) and its parent directory (e=
.g.,
> > /sys/kernel/debug/energy_model) are inotified. Therefore, a sched_ext
> > scheduler (or any userspace application) monitors the energy model chan=
ge
> > in userspace using the regular inotify interface.
> >
> > Note that accessing the energy model information from userspace has man=
y
> > advantages over other alternatives, especially adding new BPF kfuncs. T=
he
> > userspace has much more freedom than the BPF code (e.g., using external
> > libraries and floating point arithmetics), which may be infeasible (if =
not
> > impossible) in the BPF/kernel code.
> >
> > [1] https://lwn.net/Articles/922405/
> > [2] https://github.com/sched-ext/scx/pull/1624
> >
> > Signed-off-by: Changwoo Min <changwoo@igalia.com>
> > ---
> >
> > ChangeLog v1 -> v2:
> >    - Change em_debug_update() to only inotify the directory of an updat=
ed
> >      performance domain (and its parent directory).
> >    - Move the em_debug_update() call outside of the mutex lock.
> >    - Update the commit message to clarify its motivation and what will =
be
> >      inotified when updated.
> >
> >   kernel/power/energy_model.c | 12 ++++++++++++
> >   1 file changed, 12 insertions(+)
> >
>
> I have discussed that with Rafael and we have similar view.
> The EM debugfs is not the right interface for this purpose.
>
> A better design and mechanism for your purpose would be the netlink
> notification. It is present in the kernel in thermal framework
> and e.g. is used by Intel HFI
> - drivers/thermal/intel/intel_hfi.c
> - drivers/thermal/thermal_netlink.c
> It's able to send to the user space the information from FW about
> the CPUs' efficiency changes, which is similar to this EM modification.

In addition, after this patch

https://lore.kernel.org/linux-pm/3637203.iIbC2pHGDl@rjwysocki.net/

which is about to get into linux-next, em_dev_update_perf_domain()
will not be the only place where the Energy Model can be updated.

Thanks!

