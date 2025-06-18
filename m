Return-Path: <linux-pm+bounces-28979-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BB5ADEF94
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 16:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE5D016C129
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 14:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0910D2EBBAC;
	Wed, 18 Jun 2025 14:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJMs5EV0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28CF2EBB8A;
	Wed, 18 Jun 2025 14:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750257173; cv=none; b=S4i6VxHmMr2Z8w5A3BdyCZN2A2JRHsPVqR4qLIukIc9QAmanEVWYw3WNgJGd1b8VikOyaOF60FBBJ5s53vZ/Vq2DJT+FYkYWNKUwKxOnM9PdSyerC4gvmLgBPmVX/QiBGogaWUMgWlvDeJ2Z2eHC+k7Jt9fW9R9bHA/fT3Q963w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750257173; c=relaxed/simple;
	bh=LpXTwtZphTnfZzbT6c1z9QEcf3439GwWQBhu6MPqfrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MPTEXgeyv1Vg5c8S/2p3MGdWrGwnafcyvl4VxVWPX61M1Mtf6nApf1knrCpZdNQt4Yc32RYR9Np0fmVpYmikKZLR5hXLRcSE14DJFHp98zC8NbFFCE00Zyrb2RdtzireA6E3sFnIzwpsSFOE03J4NvLYcO7V1/aML0VkqHRlB+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJMs5EV0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55751C4CEEE;
	Wed, 18 Jun 2025 14:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750257173;
	bh=LpXTwtZphTnfZzbT6c1z9QEcf3439GwWQBhu6MPqfrI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gJMs5EV0ITzxF3jPbzEUQw+gG/KlJ7YWFKwg8210Vx4RwZizZiM0XGHwm85PefSbG
	 Izb3zFkOtyXb4Z35BH676BTRXZVZlrqXZApPI0SaNSp1j0Zp0jInyAseJp8vJuCtUV
	 nnf1KEoBL0NPikedmr7V6kknYxQYXlAs++fGE59KbvWsRxSaP5ofALuR+4FroFlgBq
	 zf5DSU+fd/3UIjQxowVGaxR3iOwnexT+DEIbOOc7eBCTkUT/0fU6oFvPffk9X16GCd
	 ZgqIKti0TrvkWZkCnS5dBLlsFbJYfh6m8ZYlNbo+RJEafoHWYIrtyAh33MRYvXIjCS
	 yl8RLwKX1diyg==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2eb5cbe41e4so1350288fac.2;
        Wed, 18 Jun 2025 07:32:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVWa2xj0oxFfnLjDI77d6u/6vSLa4J8pAs+6Ziysobyq8YPpeoir9Jb/jLHfeFP3OcK+jGWw2/R+Bc=@vger.kernel.org, AJvYcCXil0S+XcJvH8MmufwAeZqI+kLqygGIhAEM18dT0jlCOAyFuChPqGp8moRJiIzrGQDnE59bAUhcTymXIjo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr+ZsjdCOyMDEM6y+ijm+2QU5Fp+DoH9X2IHOCnL2lsnwwCPU4
	2Af/9CvZgTF4ULRDYzjRGIqs/9N7O1sodIhPbxvs1173Lt2xMBc2p4VB2XdrU60eTEgR378FYlJ
	zNakUvws+0uRte+2vpdi+YDjovjeG5+0=
X-Google-Smtp-Source: AGHT+IF7yypwVvbrTXlBb0mog1YhImldd0ihK3Amted8NiiIeRb/u62YPdxQlybXugRk1Ehklbu7KthxUHxvIVlBquM=
X-Received: by 2002:a05:6870:414b:b0:2e9:3c7:1a1a with SMTP id
 586e51a60fabf-2eaf02105c0mr8999591fac.0.1750257172761; Wed, 18 Jun 2025
 07:32:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <81f4c402d1fda7c2419aac1148061a0789112e76.1749849645.git.calvin@wbinvd.org>
 <99f09d35e30fa335508823e9848a3365936ac9b3.camel@intel.com>
 <aE-f35kOO0TywX5K@mozart.vkv.me> <a813fd9a41dcfc0afc8b68f9ac8d3e07d0b96530.camel@intel.com>
In-Reply-To: <a813fd9a41dcfc0afc8b68f9ac8d3e07d0b96530.camel@intel.com>
From: Len Brown <lenb@kernel.org>
Date: Wed, 18 Jun 2025 10:32:41 -0400
X-Gmail-Original-Message-ID: <CAJvTdKkVETa5MC4Y245UamB214U=HK5deadufpHaPnYmm7ywhg@mail.gmail.com>
X-Gm-Features: AX0GCFsriP21MQ34BXEhg2vZK7DRhww0K6nz6o6ei06zsqOW3ja2sJTcAbvxQDU
Message-ID: <CAJvTdKkVETa5MC4Y245UamB214U=HK5deadufpHaPnYmm7ywhg@mail.gmail.com>
Subject: Re: [PATCH] tools/power turbostat: Fix MSRs with CONFIG_MULTIUSER=n
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: "calvin@wbinvd.org" <calvin@wbinvd.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the patch, Calvin, I think it is correct.

Rui,
I'll tweak the comment to explain that the system call doesn't always exist=
.

I think it is correct to continue on -- the rawio check is basically a
graceful way
to prevent an error in accessing MSRs later.  If we don't have that
graceful mechanism,
then we will or will not hit the access error later, and that's okay.

Interesting configuration you have there Calvin.

thanks,
-Len


On Tue, Jun 17, 2025 at 11:28=E2=80=AFPM Zhang, Rui <rui.zhang@intel.com> w=
rote:
>
> On Sun, 2025-06-15 at 21:38 -0700, Calvin Owens wrote:
> > On Monday 06/16 at 01:30 +0000, Zhang, Rui wrote:
> > > On Fri, 2025-06-13 at 19:20 -0700, Calvin Owens wrote:
> > > > Handle ENOSYS from cap_get_proc() in check_for_cap_sys_rawio(), so
> > > > turbostat can display temperatures when running on kernels compiled
> > > > without multiuser support.
> > > >
> > > > Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> > > > ---
> > > >  tools/power/x86/turbostat/turbostat.c | 7 ++++++-
> > > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/tools/power/x86/turbostat/turbostat.c
> > > > b/tools/power/x86/turbostat/turbostat.c
> > > > index 925556b90770..f7d665913a52 100644
> > > > --- a/tools/power/x86/turbostat/turbostat.c
> > > > +++ b/tools/power/x86/turbostat/turbostat.c
> > > > @@ -6496,8 +6496,13 @@ int check_for_cap_sys_rawio(void)
> > > >   int ret =3D 0;
> > > >
> > > >   caps =3D cap_get_proc();
> > > > - if (caps =3D=3D NULL)
> > > > + if (caps =3D=3D NULL) {
> > > > +         /* Support CONFIG_MULTIUSER=3Dn */
> > > > +         if (errno =3D=3D ENOSYS)
> > >
> > > Can you point me where this knowledge comes from?
> > >
> > > I downloaded the libcap source and didn't see how ENOSYS is set.
> >
> > Hi Rui,
> >
> > When the kernel is built without multiuser support, the capget() et al.
> > syscalls are #ifdef'd out:
> >
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/kernel/capability.c#n32
> >
> > ...so userspace will get -ENOSYS when it tries to call them, and that
> > ends up being propagated to errno in userspace.
> >
> > Admittedly it is sort of implicit. Maybe a better way to "fix" this
> > would be to warn the user if the capability check fails, but still
> > attempt to access the MSR devices? I can do that if you prefer.
>
> if cap_get_proc returns -ENOSYS only when CONFIG_MULTIUSER=3Dn, then I
> think the patch is good, maybe we just need some more detailed comment.
>
> and I don't think we should continue when the capability check fails in
> general.
>
> >
> > That is my only problem here: when check_for_cap_sys_rawio() fails, the
> > current code doesn't attempt to access the MSR devices at all, even
> > though in my case it would actually work.
>
> Or maybe we can cover this with the "--force" parameter?
> say, does it make sense to address the problem by running "turbostat --
> force"?
> I'll leave this question to Len.
>
> thanks,
> rui
> >
> > I realize this is very weird: it came up when I was recently including
> > turbostat as part of an extremely tiny bootable utility image.
> >
> > Thanks,
> > Calvin
> >
> > > thanks,
> > > rui
> > > > +                 return 0;
> > > > +
> > > >           return 1;
> > > > + }
> > > >
> > > >   if (cap_get_flag(caps, CAP_SYS_RAWIO, CAP_EFFECTIVE,
> > > > &cap_flag_value)) {
> > > >           ret =3D 1;
> > >
>


--=20
Len Brown, Intel Open Source Technology Center

