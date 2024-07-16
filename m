Return-Path: <linux-pm+bounces-11144-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86014932505
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 13:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1115A1F2398F
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 11:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5348F1991C5;
	Tue, 16 Jul 2024 11:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=s.l-h@gmx.de header.b="Urmee5YS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77361990B5;
	Tue, 16 Jul 2024 11:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721128524; cv=none; b=bAaI5oxXnia9+zUS2BdKp9+2iNmSvV6RP7pp+3WWu3AfxKHRCdXN4JWplS/nl8mypwrIlQ9J5evS++E8JaGL4Akfhst3hWYAWryzUFRbFHciO53laQIityPJlkbd5rbFMDOwXQ14zP5nNxnHuve4cuUO0v4feIh0NYxnyGBkz6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721128524; c=relaxed/simple;
	bh=q87OMeqhKoywrdqBGlQGxvhVn26VKmN/yUOljQMb3C8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IOC7vbEMbmYGU1uR16seqNx7MVLOArXlsVIRHYtC43qgh5IktUXq7m9kvLHSedzOKlrKp0wfbzlaxYkTuv3Aq6gtFhucAYuKNzICDMe8ieJ2ZtOWt8Wf1+b08x5fLCvkHlSIU0Xhvu0A1qSTJK19CycF2qRt716Hiey1IO3tRLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=s.l-h@gmx.de header.b=Urmee5YS; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1721128503; x=1721733303; i=s.l-h@gmx.de;
	bh=WNaiqNv/FTn5/1ryjRTkkauPQZ3hWlDOqclhqapZiXA=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Urmee5YSeRDTPOyDKKJK/pWCKmr6/Eia+XUc47y4frFDMQrZ90SAie+9lH7AytUY
	 Rlw/Ay2YUGcTaOyRzg1FW4Mi5LbDG6nG+fjker7VR/072zpXZSwDOFdu5QUR9aKar
	 zQCwwK7P1AyS7pdIsRe7/gDxsQWmKNPTPcqhGXX1AMjU694rZHGcCGD+E+ZQ4xBF/
	 Udmy40VQMn2xlXDnjisjPTNUCxo5IIPm9U78iXy/eOsMKItkZ7HBl7c2kmPs6QI94
	 vxeK6uiQpgfEnRmedpHMbtf5+FPphnrmOBrXs3jI4u78VnRQCoG9qVS/+g5kY2ZWv
	 Vy53le2hcxbf4LnokA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mir ([94.31.83.155]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVvPJ-1stDN43ZSf-00IQuN; Tue, 16
 Jul 2024 13:15:03 +0200
Date: Tue, 16 Jul 2024 13:15:00 +0200
From: Stefan Lippers-Hollmann <s.l-h@gmx.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Eric Biggers
 <ebiggers@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM
 <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Lukasz
 Luba <lukasz.luba@arm.com>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3] thermal: core: Call monitor_thermal_zone() if zone
 temperature is invalid
Message-ID: <20240716131500.35cf4f00@mir>
In-Reply-To: <20240716125538.09f716d1@mir>
References: <6064157.lOV4Wx5bFT@rjwysocki.net>
	<20240715044527.GA1544@sol.localdomain>
	<4d7e11a7-b352-4ced-acee-b5f64e3cd0b6@linaro.org>
	<CAJZ5v0gx6GyKBYt7YMFwmUQ4OCG49d9k2H=P-4Awr-mJ=eFHKw@mail.gmail.com>
	<20240715145426.199c31d0@mir>
	<CAJZ5v0gPiwkNczZhCf_rkxVoUX33tS9c6irMf_7=Rg48Nw9C4w@mail.gmail.com>
	<20240716014830.243bb0cf@mir>
	<CAJZ5v0jkA72=avuthGkrS5iu_UGEQeaEp7LjedXCpzamcnRKsA@mail.gmail.com>
	<20240716125538.09f716d1@mir>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6HzjJ869OkZ8B+MwGZWD3wekIqnDpJzXepqMGOotu+URtHu2dNh
 h9gXtXXQJZOTB9p4PMQDTdqb8l5D7Sq+Un7EQLi6x/09lgt9Se02IB0+nkfRlDTaInlbDHR
 YfMhLVGizuW+JHssRw5vX0DAcCa26ask7fLdWLHSTLa0RVdgQ4DmkwHquKdzVIjIii4TN1T
 JlvHmBCjJDXJqDnY+bQXw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+a67VKHY5xA=;0eQc34UpyK+1rQxR1MaHnBGay6K
 dbl+Ee8bRd2A/xLMaf4cWTgFMedWxacTFSUQYI2ks8c4UkKpLmRFsLdLJypA6jDou3PiMuZhI
 dCrCNDzw4mibkfE19kUlDJRor3Jxnw3tifnm2M8gy4nOjhciZ/nLz/BY+PbTXBuBzrShJKTr2
 Zsm0H70MSnw2M2ruOj6jrz2OPqbsdVhsc13k3fS3yhnAvqrTyKVMC0KF/pfp1XibCNA2Qymun
 nuxuqEZLf5h9FJfMKctMZFz5yELP/TK5n69htgHeazc28MyJEIZtzuWvv4Jtk/9VMXFBF7VlI
 hADQXcorjz6XxT2RmG55K+1jID0X5phH1lKm/nwUeJydYoVpm0IzVBcgbuxKnUiF1sbuVTGQ4
 CKgtbe0iZElke1Nk912HvGis3Vp7How4Rdbpg+/TaSO/3Hi6klnpuddPUqcSJAF9vOGG4x25C
 9PCkDV0b2/goc8yDEkBa4pC123n9FAblCHm4VhgLjx99w2NUvQWKPwrWTix+Eq6JX+DxLprYi
 IoQXi4ItxQhZSLINEBJ/i2IkFrvLoqAkfQv8wTidHexzQ8vGxNW/be915b592IfNinm1A2FEI
 tAvgBs//CX3Qoy2BliL9HATkbrvh4YFoE5DBPNOryIEGu8JHE16uCpWKAPxXmqEx0aDZP+IhS
 WhDxlCeS7stZaBtDA8vVdDQ1RBUFoxupVHik6nHBMfTj9Z1lWvFgLG++C4SfiBpukXypiOTPl
 vqVsQe8Zr1rNnG1xx5t8He0y2Mq3yBGAtUi5xOrTzuV10EtvY2hprdTlr4/8GShAqXp5SmBVC
 nm8g3I7so+yU/+2pZnhDVt+Q==

Hi

On 2024-07-16, Stefan Lippers-Hollmann wrote:
> On 2024-07-16, Rafael J. Wysocki wrote:
> > On Tue, Jul 16, 2024 at 1:48=E2=80=AFAM Stefan Lippers-Hollmann <s.l-h=
@gmx.de> wrote:
> > > On 2024-07-15, Rafael J. Wysocki wrote:
> > > > On Mon, Jul 15, 2024 at 2:54=E2=80=AFPM Stefan Lippers-Hollmann <s=
.l-h@gmx.de> wrote:
> > > > > On 2024-07-15, Rafael J. Wysocki wrote:
> > > > > > On Mon, Jul 15, 2024 at 11:09=E2=80=AFAM Daniel Lezcano
> > > > > > <daniel.lezcano@linaro.org> wrote:
> > > > > > > On 15/07/2024 06:45, Eric Biggers wrote:
> > > > > > > > On Thu, Jul 04, 2024 at 01:46:26PM +0200, Rafael J. Wysock=
i wrote:
> > > > > > > >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > [...]
> > > > > Silencing the warnings is already a big improvement - and that p=
atch
> > > > > works to this extent for me with an ax200, thanks.
> > > >
> > > > So attached is a patch that should avoid enabling the thermal zone
> > > > when it is not ready for use in the first place, so it should addr=
ess
> > > > both the message and the useless polling.
> > > >
> > > > I would appreciate giving it a go (please note that it hasn't rece=
ived
> > > > much testing so far, though).
> > >
> > > Sadly this patch doesn't seem to help:
> >
> > This is likely because it is missing checks for firmware image type.
> > I've added them to the attached new version.  Please try it.
> >
> > I've also added two pr_info() messages to get a better idea of what's
> > going on, so please grep dmesg for "Thermal zone not ready" and
> > "Enabling thermal zone".
>
> This is the output with the patch applied:

The ax200 wlan interface is currently not up/ configured (system
using its wired ethernet cards instead), the thermal_zone1 stops
if I manually enable the interface (ip link set dev wlp4s0 up)
after booting up:

$ dmesg | grep -i -e iwlwifi -e thermal
[    0.080899] CPU0: Thermal monitoring enabled (TM1)
[    0.113768] thermal_sys: Registered thermal governor 'fair_share'
[    0.113770] thermal_sys: Registered thermal governor 'bang_bang'
[    0.113771] thermal_sys: Registered thermal governor 'step_wise'
[    0.113772] thermal_sys: Registered thermal governor 'user_space'
[    0.113773] thermal_sys: Registered thermal governor 'power_allocator'
[    3.759673] iwlwifi 0000:04:00.0: enabling device (0140 -> 0142)
[    3.764918] iwlwifi 0000:04:00.0: Detected crf-id 0x3617, cnv-id 0x1005=
30 wfpm id 0x80000000
[    3.764974] iwlwifi 0000:04:00.0: PCI dev 2723/0084, rev=3D0x340, rfid=
=3D0x10a100
[    3.769432] iwlwifi 0000:04:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version: 89=
.3.35.37
[    3.873466] iwlwifi 0000:04:00.0: loaded firmware version 77.a20fb07d.0=
 cc-a0-77.ucode op_mode iwlmvm
[    3.907122] iwlwifi 0000:04:00.0: Detected Intel(R) Wi-Fi 6 AX200 160MH=
z, REV=3D0x340
[    3.907886] iwl_mvm_thermal_zone_register: Thermal zone not ready
[    4.032380] iwlwifi 0000:04:00.0: Detected RF HR B3, rfid=3D0x10a100
[    4.032392] thermal thermal_zone1: Enabling thermal zone
[    4.098308] iwlwifi 0000:04:00.0: base HW address: 94:e6:f7:XX:XX:XX
[    4.112535] thermal thermal_zone1: failed to read out thermal zone (-61=
)
[    4.128306] iwlwifi 0000:04:00.0 wlp4s0: renamed from wlan0
[    4.369396] thermal thermal_zone1: failed to read out thermal zone (-61=
)
[    4.625385] thermal thermal_zone1: failed to read out thermal zone (-61=
)
[    4.881416] thermal thermal_zone1: failed to read out thermal zone (-61=
)
[    5.137377] thermal thermal_zone1: failed to read out thermal zone (-61=
)
[    5.394377] thermal thermal_zone1: failed to read out thermal zone (-61=
)
[    5.649412] thermal thermal_zone1: failed to read out thermal zone (-61=
)
[    5.905379] thermal thermal_zone1: failed to read out thermal zone (-61=
)
[    6.161380] thermal thermal_zone1: failed to read out thermal zone (-61=
)
[    6.418381] thermal thermal_zone1: failed to read out thermal zone (-61=
)
[    6.673381] thermal thermal_zone1: failed to read out thermal zone (-61=
)
[    6.929377] thermal thermal_zone1: failed to read out thermal zone (-61=
)
               [...]
[   21.009413] thermal thermal_zone1: failed to read out thermal zone (-61=
)
[   21.265496] thermal thermal_zone1: failed to read out thermal zone (-61=
)
[   21.521462] thermal thermal_zone1: failed to read out thermal zone (-61=
)
[   21.777481] thermal thermal_zone1: failed to read out thermal zone (-61=
)
[   22.033468] thermal thermal_zone1: failed to read out thermal zone (-61=
)
[   22.213120] thermal thermal_zone1: Enabling thermal zone
[   22.283954] iwlwifi 0000:04:00.0: Registered PHC clock: iwlwifi-PTP, wi=
th index: 0

Regards
	Stefan Lippers-Hollmann


