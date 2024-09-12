Return-Path: <linux-pm+bounces-14059-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76190975FA1
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 05:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 930D81C20945
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 03:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA4E126BF6;
	Thu, 12 Sep 2024 03:21:48 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4EF7581A;
	Thu, 12 Sep 2024 03:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726111308; cv=none; b=qS1Ao74mMZLynUTBV6h4TCIDKoL8c98/jgODlP0Ltm1f5wxSSmaHGjkl4qUSh4e4qHCxXZ8hIgCfKZX6TGB1I8aWpb8q0lWOxlRLwA0373LfAuCrdYpDayUVA3I+mOw8ZXassHO7NLfonW06INHMLuN4iXp7t7Gy9xx+U67YFmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726111308; c=relaxed/simple;
	bh=ph0wr14BP3HBKS0NCJK84D/bKgdyPh+ABfrWRJkXg3c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eqXLnsZnkxDi6H3qmlFDlQOLk7T1Fvai7eQmgrh+sSASypRFziqAWKU3N/lUj8Tx5Wm+sIRBlCQDQdgld/rTtZ48GKovwjR3kYSbX8VArZZYgPJSWoQN57Yv8a/j4FNgbIFdlbpBUpswaruQ5OQOpej3xaTF8h8LtbKSQucGPwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1a3d4df270b611efa216b1d71e6e1362-20240912
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:761ef5a2-2666-48e2-a4c3-7bd4fc1a22b1,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-INFO: VERSION:1.1.38,REQID:761ef5a2-2666-48e2-a4c3-7bd4fc1a22b1,IP:0,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:-5
X-CID-META: VersionHash:82c5f88,CLOUDID:efb5a396d9a204eefb3f6d6105fe1332,BulkI
	D:2409062205428B690IWE,BulkQuantity:8,Recheck:0,SF:64|66|17|19|102,TC:nil,
	Content:1|-5,EDM:-3,IP:nil,URL:1,File:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS
X-UUID: 1a3d4df270b611efa216b1d71e6e1362-20240912
X-User: duanchenghao@kylinos.cn
Received: from [172.30.80.21] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 206081397; Thu, 12 Sep 2024 11:21:29 +0800
Message-ID: <8068130ce4ece6078b2893c4c6333c06c792b6c0.camel@kylinos.cn>
Subject: Re: [PATCH] USB: Fix the issue of task recovery failure caused by
 USB status when S4 wakes up
From: duanchenghao <duanchenghao@kylinos.cn>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: gregkh@linuxfoundation.org, pavel@ucw.cz, linux-pm@vger.kernel.org, 
	niko.mauno@vaisala.com, stanley_chang@realtek.com, tj@kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Date: Thu, 12 Sep 2024 11:21:26 +0800
In-Reply-To: <8b07752d-63c4-41e3-bd20-ce3da43dfffc@rowland.harvard.edu>
References: <20240906030548.845115-1-duanchenghao@kylinos.cn>
	 <1725931490447646.3.seg@mailgw.kylinos.cn>
	 <a618ada1582c82b58d2503ecf777ea2d726f9399.camel@kylinos.cn>
	 <8b07752d-63c4-41e3-bd20-ce3da43dfffc@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

=E5=9C=A8 2024-09-11=E6=98=9F=E6=9C=9F=E4=B8=89=E7=9A=84 10:40 -0400=EF=BC=
=8CAlan Stern=E5=86=99=E9=81=93=EF=BC=9A
> On Tue, Sep 10, 2024 at 05:36:56PM +0800, duanchenghao wrote:
> > S4 wakeup restores the image that was saved before the system
> > entered
> > the S4 sleep state.
> >=20
> > =C2=A0=C2=A0=C2=A0 S4 waking up from hibernation
> > =C2=A0=C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =C2=A0=C2=A0=C2=A0 kernel initialization
> > =C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=20
> > =C2=A0=C2=A0=C2=A0 v=C2=A0=C2=A0=20
> > =C2=A0=C2=A0=C2=A0 freeze user task and kernel thread
> > =C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=20
> > =C2=A0=C2=A0=C2=A0 v=C2=A0=C2=A0=20
> > =C2=A0=C2=A0=C2=A0 load saved image
> > =C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=20
> > =C2=A0=C2=A0=C2=A0 v=C2=A0=C2=A0=20
> > =C2=A0=C2=A0=C2=A0 freeze the peripheral device and controller
> > =C2=A0=C2=A0=C2=A0 (Check the HCD_FLAG_WAKEUP_ PENDING flag of the USB.=
 If it is
> > set,
> > =C2=A0=C2=A0=C2=A0=C2=A0 return to EBUSY and do not perform the followi=
ng restore
> > image.)
>=20
> Why is the flag set at this point?=C2=A0 It should not be; the device and=
=20
> controller should have been frozen with wakeup disabled.
>=20
This is check point, not set point. When the USB goes into a suspend
state, the HCD_FLAG_WAKEUP_PENDING flag is checked, and if it is found
that the USB is in the process of resuming, then an EBUSY error is
returned.

> > =C2=A0=C2=A0=C2=A0 |
> > =C2=A0=C2=A0=C2=A0 v
> > =C2=A0=C2=A0=C2=A0 restore image(task recovery)
>=20
> > > > However, upon detecting that the hcd is in the
> > > > HCD_FLAG_WAKEUP_PENDING state,
> > > > it will return an EBUSY status, causing the S4 suspend to fail
> > > > and
> > > > subsequent task recovery to not proceed.
> > >=20
> > > What will return an EBUSY status?
> >=20
> > if HCD_FLAG_WAKEUP_PENDING flag is set_bit, will return EBUSY.
>=20
> I meant: Which function will return EBUSY status?=C2=A0 The answer is in
> the=20
> log below; hcd_pci_suspend() does this.
>=20
> > > Why do you say that S4 suspend will fail?=C2=A0 Aren't you talking
> > > about
> > > S4=20
> > > wakeup?
> >=20
> > After returning EBUSY, the subsequent restore image operation will
> > not
> > be executed.
> >=20
> > >=20
> > > Can you provide a kernel log that explains these points and shows
> > > what=20
> > > problem you are trying to solve?
> >=20
> > [=C2=A0=C2=A0=C2=A0 9.009166][ 2] [=C2=A0 T403] PM: Image signature fou=
nd, resuming
> > [=C2=A0=C2=A0=C2=A0 9.009167][ 2] [=C2=A0 T403] PM: resume from hiberna=
tion
> > [=C2=A0=C2=A0=C2=A0 9.009243][ 2] [=C2=A0 T403] inno-codec inno-codec.1=
6.auto:
> > [inno_vpu][vpu_notifier:1540]vpu_notifier: untested action 5...
> > [=C2=A0=C2=A0=C2=A0 9.009244][ 2] [=C2=A0 T403] Freezing user space pro=
cesses ...
> > (elapsed
> > 0.001 seconds) done.
> > [=C2=A0=C2=A0=C2=A0 9.010355][ 2] [=C2=A0 T403] OOM killer disabled.
> > [=C2=A0=C2=A0=C2=A0 9.010355][ 2] [=C2=A0 T403] Freezing remaining free=
zable tasks ...
> > (elapsed 0.000 seconds) done.
> > [=C2=A0=C2=A0=C2=A0 9.012152][ 2] [=C2=A0 T403] PM: Basic memory bitmap=
s created
> > [=C2=A0=C2=A0=C2=A0 9.073333][ 2] [=C2=A0 T403] PM: Using 3 thread(s) f=
or decompression
> > [=C2=A0=C2=A0=C2=A0 9.073334][ 2] [=C2=A0 T403] PM: Loading and decompr=
essing image
> > data
> > (486874 pages)...
> > [=C2=A0=C2=A0=C2=A0 9.073335][ 2] [=C2=A0 T403] hibernate: Hibernated o=
n CPU 0
> > [mpidr:0x0]
> > [=C2=A0=C2=A0=C2=A0 9.095928][ 2] [=C2=A0 T403] PM: Image loading progr=
ess:=C2=A0=C2=A0 0%
> > [=C2=A0=C2=A0=C2=A0 9.664803][ 2] [=C2=A0 T403] PM: Image loading progr=
ess:=C2=A0 10%
> > [=C2=A0=C2=A0=C2=A0 9.794156][ 2] [=C2=A0 T403] PM: Image loading progr=
ess:=C2=A0 20%
> > [=C2=A0=C2=A0=C2=A0 9.913001][ 2] [=C2=A0 T403] PM: Image loading progr=
ess:=C2=A0 30%
> > [=C2=A0=C2=A0 10.034331][ 2] [=C2=A0 T403] PM: Image loading progress:=
=C2=A0 40%
> > [=C2=A0=C2=A0 10.154070][ 2] [=C2=A0 T403] PM: Image loading progress:=
=C2=A0 50%
> > [=C2=A0=C2=A0 10.277096][ 2] [=C2=A0 T403] PM: Image loading progress:=
=C2=A0 60%
> > [=C2=A0=C2=A0 10.398860][ 2] [=C2=A0 T403] PM: Image loading progress:=
=C2=A0 70%
> > [=C2=A0=C2=A0 10.533760][ 2] [=C2=A0 T403] PM: Image loading progress:=
=C2=A0 80%
> > [=C2=A0=C2=A0 10.659874][ 2] [=C2=A0 T403] PM: Image loading progress:=
=C2=A0 90%
> > [=C2=A0=C2=A0 10.760681][ 2] [=C2=A0 T403] PM: Image loading progress: =
100%
> > [=C2=A0=C2=A0 10.760693][ 2] [=C2=A0 T403] PM: Image loading done
> > [=C2=A0=C2=A0 10.760718][ 2] [=C2=A0 T403] PM: Read 1947496 kbytes in 1=
.68 seconds
> > (1159.22 MB/s)
> > [=C2=A0=C2=A0 10.761982][ 2] [=C2=A0 T403] PM: Image successfully loade=
d
> > [=C2=A0=C2=A0 10.761988][ 2] [=C2=A0 T403] printk: Suspending console(s=
) (use
> > no_console_suspend to debug)
> > [=C2=A0=C2=A0 10.864973][ 2] [=C2=A0 T403] innovpu_freeze:1782
> > [=C2=A0=C2=A0 10.864974][ 2] [=C2=A0 T403] innovpu_suspend:1759
> > [=C2=A0=C2=A0 11.168871][ 2] [=C2=A0 T189] PM: pci_pm_freeze():
> > hcd_pci_suspend+0x0/0x38 returns -16
>=20
> This should not be allowed to happen.=C2=A0 Freezing is mandatory and not=
=20
> subject to wakeup requests.
>=20
> Is your problem related to the one discussed in this email thread?
>=20
> https://lore.kernel.org/linux-usb/d8600868-6e4b-45ab-b328-852b6ac8ecb5@ro=
wland.harvard.edu/
>=20
> Would the suggestion I made there -- i.e., have the xhci-hcd=20
> interrupt handler skip calling usb_hcd_resume_root_hub() if the root
> hub=20
> was suspended with wakeup =3D 0 -- fix your problem?

Skipping usb_hcd_resume_root_hub() should generally be possible, but
it's important to ensure that normal remote wakeup functionality is not
compromised. Is it HUB_SUSPEND that the hub you are referring to is in
a suspended state?

v2 patch:
https://lore.kernel.org/all/20240910105714.148976-1-duanchenghao@kylinos.cn=
/
>=20
> Alan Stern


