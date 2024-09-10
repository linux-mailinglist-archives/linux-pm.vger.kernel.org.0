Return-Path: <linux-pm+bounces-13932-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A91E972E6E
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 11:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48A18288081
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 09:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2351C190485;
	Tue, 10 Sep 2024 09:42:13 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8636A18FDC5;
	Tue, 10 Sep 2024 09:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961333; cv=none; b=HFvp0a9tgw9aXZvbKAYzxoqF6I9O/9MO2ULgQffMHFHPllnIZDE+lcC3xDJJWj8VENZ8J1JHu/nNvpKZHuwaxYfTFfQD3ycW8Jbr0oR7cJxm0aNsPlUqVG5gBW8Ma7XDUTPovzXIQ25izNUcQ8m7QlKfnM7/jXR6gC97GKO4o/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961333; c=relaxed/simple;
	bh=5LFaB4QeRF7sCvthexbWNV7eT6PsLxn6wE3VOrnStQ0=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 MIME-Version:Date; b=QgeClY+pWrcbfs5WiGp+LNUU2duxJfOomCfZGQPPhQXJW7ApF34ofo/SYhN3dMWQEfFMmbJ1qo4A+H0EkBJQrsYD62c7W9OZchjqBl5P1ZWB6433zrsVvruAEpiRGJq7bUjdPj9XcwHNVySTSQH/e/akMqG9bAMwd8Ui6xCRX8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ef80a98c6f5811efa216b1d71e6e1362-20240910
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:7af2211c-764b-4bbd-ba05-e0dfd58e57ee,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-3,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:17
X-CID-INFO: VERSION:1.1.38,REQID:7af2211c-764b-4bbd-ba05-e0dfd58e57ee,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-3,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:17
X-CID-META: VersionHash:82c5f88,CLOUDID:1d3bfc4f5e06006388cbca7b60dda97c,BulkI
	D:2409062205428B690IWE,BulkQuantity:3,Recheck:0,SF:24|72|19|45|64|66|102,T
	C:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,
	COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: ef80a98c6f5811efa216b1d71e6e1362-20240910
X-User: duanchenghao@kylinos.cn
Received: from [192.168.27.151] [(223.70.160.255)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 891067160; Tue, 10 Sep 2024 17:42:03 +0800
Message-ID: <a618ada1582c82b58d2503ecf777ea2d726f9399.camel@kylinos.cn>
Subject: Re: [PATCH] USB: Fix the issue of task recovery failure caused by
 USB status when S4 wakes up
From: duanchenghao <duanchenghao@kylinos.cn>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: gregkh@linuxfoundation.org, pavel@ucw.cz, linux-pm@vger.kernel.org, 
	niko.mauno@vaisala.com, stanley_chang@realtek.com, tj@kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
In-Reply-To: <1725931490447646.3.seg@mailgw.kylinos.cn>
References: <20240906030548.845115-1-duanchenghao@kylinos.cn>
	 <1725931490447646.3.seg@mailgw.kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 10 Sep 2024 17:36:56 +0800
User-Agent: Evolution 3.44.4-0ubuntu2 


> [Please make sure that the lines in your email message don't extend=20
> beyond 76 columns or so.]
>=20

OK. Later, I will modify the patch format. V2 patch will be released
later

> Lots of things here seem to be wrong.
>=20
> On Fri, Sep 06, 2024 at 11:05:48AM +0800, Duan Chenghao wrote:
> > When a device is inserted into the USB port and an S4 wakeup is
> > initiated,
>=20
> There is no such thing as an S4 wakeup.=C2=A0 Do you mean wakeup from an
> S4=20
> suspend state?

Yes, waking up from the S4 suspend state.

>=20
> > after the USB-hub initialization is completed, it will
> > automatically enter suspend mode.
>=20
> What will enter suspend mode?=C2=A0 The hub that the device was plugged
> into?
> That should not happen.=C2=A0 The hub initialization code should detect
> that=20
> a new device was plugged in and prevent the hub from suspending.
>=20

Yes, the current issue is that the hub detects a new device during the
resuming process. However, the S4 wakeup is attempting to put the hub
into suspend mode, and during the suspend process, it detects that the
HCD_FLAG_WAKEUP_PENDING flag has already been set, resulting in the
return of an EBUSY status.

> > Upon detecting a device on the USB port, it will proceed with
> > resume and set the hcd to the HCD_FLAG_WAKEUP_PENDING state.
>=20
> HCD_FLAG_WAKEUP_PENDING is not a state.=C2=A0 It is a flag.
>=20
> > During the S4 wakeup process, peripherals are put into suspend
> > mode, followed by task recovery.
>=20
> What do you mean by "task recovery"?=C2=A0 We don't need to recover any=
=20
> tasks.
>=20

S4 wakeup restores the image that was saved before the system entered
the S4 sleep state.

=C2=A0=C2=A0=C2=A0 S4 waking up from hibernation
=C2=A0=C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=C2=A0=C2=A0=C2=A0 kernel initialization
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=20
=C2=A0=C2=A0=C2=A0 v=C2=A0=C2=A0=20
=C2=A0=C2=A0=C2=A0 freeze user task and kernel thread
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=20
=C2=A0=C2=A0=C2=A0 v=C2=A0=C2=A0=20
=C2=A0=C2=A0=C2=A0 load saved image
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=20
=C2=A0=C2=A0=C2=A0 v=C2=A0=C2=A0=20
=C2=A0=C2=A0=C2=A0 freeze the peripheral device and controller
=C2=A0=C2=A0=C2=A0 (Check the HCD_FLAG_WAKEUP_ PENDING flag of the USB. If =
it is set,
=C2=A0=C2=A0=C2=A0=C2=A0 return to EBUSY and do not perform the following r=
estore image.)
=C2=A0=C2=A0=C2=A0 |
=C2=A0=C2=A0=C2=A0 v
=C2=A0=C2=A0=C2=A0 restore image(task recovery)


> What do you mean by "peripherals are put into suspend mode"?=C2=A0 That's
> not=20
> what happens.=C2=A0 Peripherals are set back to full power.
>=20
> > However, upon detecting that the hcd is in the
> > HCD_FLAG_WAKEUP_PENDING state,
> > it will return an EBUSY status, causing the S4 suspend to fail and
> > subsequent task recovery to not proceed.
>=20
> What will return an EBUSY status?

if HCD_FLAG_WAKEUP_PENDING flag is set_bit, will return EBUSY.

>=20
> Why do you say that S4 suspend will fail?=C2=A0 Aren't you talking about
> S4=20
> wakeup?

After returning EBUSY, the subsequent restore image operation will not
be executed.

>=20
> Can you provide a kernel log that explains these points and shows
> what=20
> problem you are trying to solve?

[=C2=A0=C2=A0=C2=A0 9.009166][ 2] [=C2=A0 T403] PM: Image signature found, =
resuming
[=C2=A0=C2=A0=C2=A0 9.009167][ 2] [=C2=A0 T403] PM: resume from hibernation
[=C2=A0=C2=A0=C2=A0 9.009243][ 2] [=C2=A0 T403] inno-codec inno-codec.16.au=
to:
[inno_vpu][vpu_notifier:1540]vpu_notifier: untested action 5...
[=C2=A0=C2=A0=C2=A0 9.009244][ 2] [=C2=A0 T403] Freezing user space process=
es ... (elapsed
0.001 seconds) done.
[=C2=A0=C2=A0=C2=A0 9.010355][ 2] [=C2=A0 T403] OOM killer disabled.
[=C2=A0=C2=A0=C2=A0 9.010355][ 2] [=C2=A0 T403] Freezing remaining freezabl=
e tasks ...
(elapsed 0.000 seconds) done.
[=C2=A0=C2=A0=C2=A0 9.012152][ 2] [=C2=A0 T403] PM: Basic memory bitmaps cr=
eated
[=C2=A0=C2=A0=C2=A0 9.073333][ 2] [=C2=A0 T403] PM: Using 3 thread(s) for d=
ecompression
[=C2=A0=C2=A0=C2=A0 9.073334][ 2] [=C2=A0 T403] PM: Loading and decompressi=
ng image data
(486874 pages)...
[=C2=A0=C2=A0=C2=A0 9.073335][ 2] [=C2=A0 T403] hibernate: Hibernated on CP=
U 0 [mpidr:0x0]
[=C2=A0=C2=A0=C2=A0 9.095928][ 2] [=C2=A0 T403] PM: Image loading progress:=
=C2=A0=C2=A0 0%
[=C2=A0=C2=A0=C2=A0 9.664803][ 2] [=C2=A0 T403] PM: Image loading progress:=
=C2=A0 10%
[=C2=A0=C2=A0=C2=A0 9.794156][ 2] [=C2=A0 T403] PM: Image loading progress:=
=C2=A0 20%
[=C2=A0=C2=A0=C2=A0 9.913001][ 2] [=C2=A0 T403] PM: Image loading progress:=
=C2=A0 30%
[=C2=A0=C2=A0 10.034331][ 2] [=C2=A0 T403] PM: Image loading progress:=C2=
=A0 40%
[=C2=A0=C2=A0 10.154070][ 2] [=C2=A0 T403] PM: Image loading progress:=C2=
=A0 50%
[=C2=A0=C2=A0 10.277096][ 2] [=C2=A0 T403] PM: Image loading progress:=C2=
=A0 60%
[=C2=A0=C2=A0 10.398860][ 2] [=C2=A0 T403] PM: Image loading progress:=C2=
=A0 70%
[=C2=A0=C2=A0 10.533760][ 2] [=C2=A0 T403] PM: Image loading progress:=C2=
=A0 80%
[=C2=A0=C2=A0 10.659874][ 2] [=C2=A0 T403] PM: Image loading progress:=C2=
=A0 90%
[=C2=A0=C2=A0 10.760681][ 2] [=C2=A0 T403] PM: Image loading progress: 100%
[=C2=A0=C2=A0 10.760693][ 2] [=C2=A0 T403] PM: Image loading done
[=C2=A0=C2=A0 10.760718][ 2] [=C2=A0 T403] PM: Read 1947496 kbytes in 1.68 =
seconds
(1159.22 MB/s)
[=C2=A0=C2=A0 10.761982][ 2] [=C2=A0 T403] PM: Image successfully loaded
[=C2=A0=C2=A0 10.761988][ 2] [=C2=A0 T403] printk: Suspending console(s) (u=
se
no_console_suspend to debug)
[=C2=A0=C2=A0 10.864973][ 2] [=C2=A0 T403] innovpu_freeze:1782
[=C2=A0=C2=A0 10.864974][ 2] [=C2=A0 T403] innovpu_suspend:1759
[=C2=A0=C2=A0 11.168871][ 2] [=C2=A0 T189] PM: pci_pm_freeze():
hcd_pci_suspend+0x0/0x38 returns -16
[=C2=A0=C2=A0 11.168875][ 2] [=C2=A0 T189] PM: dpm_run_callback():
pci_pm_freeze+0x0/0x108 returns -16
[=C2=A0=C2=A0 11.168876][ 2] [=C2=A0 T189] PM: Device 0000:05:00.0 failed t=
o quiesce
async: error -16
[=C2=A0=C2=A0 12.270452][ 2] [=C2=A0 T403] innovpu_thaw:1792
[=C2=A0=C2=A0 12.405296][ 2] [=C2=A0 T403] PM: Failed to load hibernation i=
mage,
recovering.
[=C2=A0=C2=A0 12.486859][ 2] [=C2=A0 T403] PM: Basic memory bitmaps freed
[=C2=A0=C2=A0 12.486860][ 2] [=C2=A0 T403] OOM killer enabled.
[=C2=A0=C2=A0 12.486861][ 2] [=C2=A0 T403] Restarting tasks ...=20

>=20
> > This patch makes two modifications in total:
> > 1. The set_bit and clean_bit operations for the
> > HCD_FLAG_WAKEUP_PENDING flag of Hcd,
> > which were previously split between the top half and bottom half of
> > the interrupt,
> > are now unified and executed solely in the bottom half of the
> > interrupt.
> > This prevents the bottom half tasks from being frozen during the S4
> > process,
> > ensuring that the clean_bit process can proceed without
> > interruption.
>=20
> The name is "clear_bit" (with an 'r'), not "clean_bit".
>=20
> > 2. Add a condition to the set_bit operation for the hcd status
> > HCD_FLAG_WAKEUP_PENDING.
> > When the hcd status is HC_STATE_SUSPENDED, perform the setting of
> > the aforementioned status bit.
> > This prevents a subsequent set_bit from occurring after the
> > clean_bit if the hcd is in the resuming process.
>=20
> hcd_bus_resume() clears that HCD_FLAG_WAKEUP_PENDING bit after
> calling=20
> hcd->driver->bus_resume().=C2=A0 After that point,
> usb_hcd_resume_root_hub()=20
> won't be called, so how can HCD_FLAG_WAKEUP_PENDING get set again?
>=20
> Alan Stern
>=20
> > Signed-off-by: Duan Chenghao <duanchenghao@kylinos.cn>
> > ---
> > =C2=A0drivers/usb/core/hcd.c | 1 -
> > =C2=A0drivers/usb/core/hub.c | 3 +++
> > =C2=A02 files changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> > index 1ff7d901fede..a6bd0fbd82f4 100644
> > --- a/drivers/usb/core/hcd.c
> > +++ b/drivers/usb/core/hcd.c
> > @@ -2389,7 +2389,6 @@ void usb_hcd_resume_root_hub (struct usb_hcd
> > *hcd)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_lock_irqsave (&hcd=
_root_hub_lock, flags);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (hcd->rh_registered)=
 {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0pm_wakeup_event(&hcd->self.root_hub->dev, 0);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0set_bit(HCD_FLAG_WAKEUP_PENDING, &hcd->flags);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0queue_work(pm_wq, &hcd->wakeup_work);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_unlock_irqrestore =
(&hcd_root_hub_lock, flags);
> > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > index 4b93c0bd1d4b..7f847c4afc0d 100644
> > --- a/drivers/usb/core/hub.c
> > +++ b/drivers/usb/core/hub.c
> > @@ -3835,11 +3835,14 @@ int usb_port_resume(struct usb_device
> > *udev, pm_message_t msg)
> > =C2=A0
> > =C2=A0int usb_remote_wakeup(struct usb_device *udev)
> > =C2=A0{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct usb_hcd=C2=A0 *hcd =
=3D bus_to_hcd(udev->bus);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0status =3D 0;
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0usb_lock_device(udev);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (udev->state =3D=3D =
USB_STATE_SUSPENDED) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_dbg(&udev->dev, "usb %sresume\n", "wakeup-")=
;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (hcd->state =3D=3D HC_STATE_SUSPENDED)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0set_bi=
t(HCD_FLAG_WAKEUP_PENDING, &hcd-
> > > flags);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0status =3D usb_autoresume_device(udev);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0if (status =3D=3D 0) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
/* Let the drivers do their thing, then...
> > */
> > --=20
> > 2.34.1
> >=20
> >=20






