Return-Path: <linux-pm+bounces-11101-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E469314F5
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 14:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 404F61F20D38
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 12:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D554918C19F;
	Mon, 15 Jul 2024 12:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=s.l-h@gmx.de header.b="AxPkirED"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A31018732C;
	Mon, 15 Jul 2024 12:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721048088; cv=none; b=aIDNNx5a1DpX+3K7twPez3ANDlNx1vPsd5lN5AAQGPgFr5nfPQvfpUSkDtZ3c+L/ftGLaQpjWMrV3MZroEnSteNAtWYi2Fp6EyktmdtBfenAqmTCvsWplswIH1U4UAN0ORy/Mrt9LPOg5+XlHLqCoVaA/D2wu2sab8UVPBldcSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721048088; c=relaxed/simple;
	bh=X35c0J75N6VMsyWa7OmyBbJkqHT7XYO5W8q1PqTyygk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ARPLgViwOMfLIbmr8BKnRiM/hKxhHdwfDEYv1FlBxhmz2RdW9U0Lmz4DLVC/36gn8b7M82H+ucoz4l/CeJZ8AYOE3r3SJ4tmDr6XXH44NCr3n0r/agztBcIyHqs9e3SQayMvBR33bWRlE38zt6yxrZE2Sk4RL8xZmtVyh1GfCbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=s.l-h@gmx.de header.b=AxPkirED; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1721048070; x=1721652870; i=s.l-h@gmx.de;
	bh=EOVWSVyeKd4gJsRQExx0kzHP/0gq1uu28A/ey4WtF3w=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AxPkirEDMWoD/K5EJX1OPdpCss2dEjb0VcicW8SdnosZQgF5hAG83J6YbW9lXVGj
	 BYN+8bGM34+dUEMGRfPN6UO2L5MMGwOi7RgQeNwVF8R1JbNezFIh5TPL88sDE1g8C
	 BYjve2hJf5HuwqAVhhAwW74HfJ/OEiT/UTYOm6cWVXVbtxYK0/3MG4A11pCfnN6lh
	 KCjOmAnnNDp2ppfoVc/jRmIqinI5yh1Qear5g2lTf5zwW9fqblCCxzF+qzUIhzhGK
	 M4D/0vGeRM8JXCo2F5UyWh+5eCLzcw18PjCYZpxO7P8edcvFjbPs7rgPd1lc/1tBH
	 ov7vgps5ObAZmTC3JA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mir ([94.31.83.155]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4QwW-1sKEOu3Ki6-016f5q; Mon, 15
 Jul 2024 14:54:30 +0200
Date: Mon, 15 Jul 2024 14:54:26 +0200
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
Message-ID: <20240715145426.199c31d0@mir>
In-Reply-To: <CAJZ5v0gx6GyKBYt7YMFwmUQ4OCG49d9k2H=P-4Awr-mJ=eFHKw@mail.gmail.com>
References: <6064157.lOV4Wx5bFT@rjwysocki.net>
	<20240715044527.GA1544@sol.localdomain>
	<4d7e11a7-b352-4ced-acee-b5f64e3cd0b6@linaro.org>
	<CAJZ5v0gx6GyKBYt7YMFwmUQ4OCG49d9k2H=P-4Awr-mJ=eFHKw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CPoKV8zwtWwHtmBQX4uQnsR/WhOigdwjt40qTzm6fWJBZugB1x3
 MXMpg71iN2u6Vz4rzKu2GF6TvoEC5WNDvS+0iMdBoZ+o7D63jNP+YIEqoGaU1JX4kNFeSvV
 6mjv31HsGG04cysp1Pk6sAtSOHuq2OQKf+Lj60DEmhanuxhBORuHRJ/oSYrIIGZYHC73a2S
 dG1U8j62gxk1f+V9TL91Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wbI78QXFeSo=;2RXZrQffbAexL/lg+k/6/7G0z2m
 nbILtXZJm79wy5pgfN4rYDPGuFDkPWWWua7wkzJWPhNBdj2ijZ7jzoCXpPb5OL2mKjtb/Z1yP
 FpaSjxnnStvWt0/kG5AzTXM2MhVdF5y9AQM5g0s8KfzTbbXwj+LDH+DotqtOtqk6cJ8uzQBT8
 ey6aslfhQzCeNaE7ouoXS1bk586GlfdZLqG3k4MZN2PPm6VOctjMmq9zVKIiuiJHn8dDYGDhE
 sWBrFqsN04E2IsXJgB7SgkVggHrc6BDwhtlcNl7BZWPycxpYFDSZq/FSJs+WZpYazye8fSrYV
 /ask4kQYQ7HJV9bGwZ7kFwqiEpjYmrCY+zxTI49MURvlDCB+2rfI8OLKzEZn0e9aHxnAizll7
 EqxE1asme1fCitx2cSsJ0N91V3JPfWfsVPGVpyrrFbfn4Nhzz8uSBTJZHAsDHu4gWCiUybpIQ
 UqoQIJvTLO7Q3Iv6LB1RFRwtdFQjJR5ysnUs+NX8plwV+2GVkoSEb9cosUjLMf2CbRxisJa8X
 dzrDiANB9nXUlIdLobwEfbd5ZM627jbtIpqStVFezTk4LNE5o3e3oODY0pNc9+8hgsj9O15Gu
 YBDq6qZCpDst9JQTZ8nCJEC5nT+ylbG3VUKdRBtlkhUhNp7iilVvArH+UilrkdpPj5yH4DXLv
 xaSNLvM0WRkNX3pZCUQI7a2ELtS88zNjXuZAN0Qwto5LkZ2trEY3DwsxKfSvLA6Tnl8CVZMd3
 iRLmir3Irt1qITKzq8I6rfjEDPtYmyPrYkNhn0AKFiQ99BpMyQwMbPDZYwJ6SrOnDeB5DNarP
 /DbqJPIKURAXPv9kjq8D80gw==

Hi

On 2024-07-15, Rafael J. Wysocki wrote:
> On Mon, Jul 15, 2024 at 11:09=E2=80=AFAM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> > On 15/07/2024 06:45, Eric Biggers wrote:
> > > On Thu, Jul 04, 2024 at 01:46:26PM +0200, Rafael J. Wysocki wrote:
> > >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >>
> > >> Commit 202aa0d4bb53 ("thermal: core: Do not call handle_thermal_tri=
p()
[...]
> > Does the following change fixes the messages  ?
> >
> > diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> > b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> > index 61a4638d1be2..b519db76d402 100644
> > --- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> > +++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> > @@ -622,7 +622,7 @@ static int iwl_mvm_tzone_get_temp(struct
> > thermal_zone_device *device,
> >
> >         if (!iwl_mvm_firmware_running(mvm) ||
> >             mvm->fwrt.cur_fw_img !=3D IWL_UCODE_REGULAR) {
> > -               ret =3D -ENODATA;
> > +               ret =3D -EAGAIN;
> >                 goto out;
> >         }
> >
> >
> > --
>
> It would make the message go away, but it wouldn't stop the useless
> polling of the dead thermal zone.

Silencing the warnings is already a big improvement - and that patch
works to this extent for me with an ax200, thanks.

> I think that two things need to be done:
>
> (1) Add backoff to the thermal core as proposed previously.
> (2) Make iwlwifi enable the thermal zone only if the firmware is running=
.

Regards
	Stefan Lippers-Hollmann

