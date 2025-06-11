Return-Path: <linux-pm+bounces-28470-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A51AD520A
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 12:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CACC91886268
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 10:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E755F271467;
	Wed, 11 Jun 2025 10:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="J1vAcMuQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538F226B08F;
	Wed, 11 Jun 2025 10:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749638020; cv=none; b=Sh6AoJISKxGZnDY3Qz2qLe54X2gbvWQzN4jP1jtAEmP0k3MGvyDxCwTxK+gbw9Tf4J90RbYdN4cQAXfXTq7uBHHbr9BYtOu68Q3WYs5kxWXzYjZ5wcKVPraUjwrIs17D6p6CFVDxlN0x61cuITT0MFPEiUdsZT2ays5t/rrkcq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749638020; c=relaxed/simple;
	bh=cWNBnU32Hax8vzNhlyGLQMM8Dzn78jiOs3g+Xja4Foo=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=ZvLmMVCuu0Mn45FRlYUMH5Fd6oEtGMLUgx8lZyDl4jOYqVn+PN5PcMtLIQaboQMG8cOiIVKRLHLQjmMH0FwuCEdRHNUn0sxBv5bnrK2yMk0O1MKFlMYCAessqwwhTQOZhqUxmV8AOfJMV7WZ9P197O8/PY36FoYdnOjgVKdB2VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=J1vAcMuQ; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1749638014; x=1750242814; i=frank-w@public-files.de;
	bh=cWNBnU32Hax8vzNhlyGLQMM8Dzn78jiOs3g+Xja4Foo=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:In-Reply-To:References:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=J1vAcMuQ/X+Huc7X9kuDkee8C60p0s8C+iNRJSTWJigcexmhxeZR8JNQpAXK8j74
	 6eEtC5aNsCYvetLfwSxLk8iEq0RuoNQfyWUD61XTaEidEOltUYnaJx4No9oiobvk3
	 LGPHbgCr/sQcuuNV/8lmr35E+hIv2buDJ7UcuLoSWXiRhAzgCVvbM+Di053aqCmFU
	 Dm/LJhfOwIPEu8N9W4WlUiJd/idW8+kRPrlq5A1qkh4g1qO2+NLqmGTCOfQQEs0iB
	 8GqeOfZgcWFWXqgMGl4qOXL9bG9pfjgjsgkH2sT3NX9oXkxVl2ZL7bjbRvPRGfhcZ
	 I6uJ/0SfRGkecdYVmw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [100.67.37.148] ([100.67.37.148]) by
 trinity-msg-rest-gmx-gmx-live-b647dc579-v9bgf (via HTTP); Wed, 11 Jun 2025
 10:33:34 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-4ce9e572-1086-4923-86e0-abaa27188e9b-1749638014100@trinity-msg-rest-gmx-gmx-live-b647dc579-v9bgf>
From: Frank Wunderlich <frank-w@public-files.de>
To: angelogioacchino.delregno@collabora.com, linux@fw-web.de,
 myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com,
 djakov@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, matthias.bgg@gmail.com
Cc: jia-wei.chang@mediatek.com, johnson.wang@mediatek.com,
 arinc.unal@arinc9.com, Landen.Chao@mediatek.com, dqfext@gmail.com,
 sean.wang@mediatek.com, daniel@makrotopia.org, lorenzo@kernel.org,
 nbd@nbd.name, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Aw: Re: [PATCH v3 10/13] arm64: dts: mediatek: mt7988a-bpi-r4: add
 gpio leds
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Jun 2025 10:33:34 +0000
In-Reply-To: <12816e74-9708-4e83-939a-347e1f6f6f5c@collabora.com>
References: <20250608211452.72920-1-linux@fw-web.de>
 <20250608211452.72920-11-linux@fw-web.de>
 <12816e74-9708-4e83-939a-347e1f6f6f5c@collabora.com>
X-UI-CLIENT-META-MAIL-DROP: W10=
X-Provags-ID: V03:K1:sQJ+G3vx4lQLO/1us4HSSqYa4aIOgh/X4VmH81XkjnSBmWG+StQM2/7wuK/sJavC1Vemp
 cy3QwTSMVgb+5tR8PdzmeWk/mOS4CsVEZJO14TReMlKTUIYcErvBLsnhTC4yJ/EtynNmFkFhWKoQ
 ggSyQirOUOporTs8TszXZgNW33oR024YqW3FPEVcFw83/nNZ9lOolguJRMslHJa/32CsFeiyc0Av
 bqxRCB0ZIiAA39AN8WV4zwR/g2f2w3vEsVK93bSdrXmDHzdQRuowT8UXtwYbl9VC9BOPA6OxVxPj
 9iGRMJQz9Dwsy3/XuEZiJPK+PZUnlVxS2H9R5H91yUmjJS2cFDkdqG5fXFqYML/ymo=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:H9i8Vf2yInE=;hIoT85gqjXtsSgDflPDbs8/4Swp
 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
Content-Transfer-Encoding: quoted-printable

Hi
> Gesendet: Mittwoch, 11. Juni 2025 um 11:33
> Von: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.c=
om>
> Betreff: Re: [PATCH v3 10/13] arm64: dts: mediatek: mt7988a-bpi-r4: add =
gpio leds
>
> Il 08/06/25 23:14, Frank Wunderlich ha scritto:
> > From: Frank Wunderlich <frank-w@public-files.de>
> >=20
> > Bananapi R4 has a green and a blue led which can be switched by gpio.
> > Green led is for running state so default on.
> >=20
> > Green led also shares pin with eeprom writeprotect where led off allow=
s
> > writing to eeprom.
>=20
> This is extremely ugly from a hardware perspective and I'm sad to see su=
ch
> a thing here.

i know, but cannot change this...found this out while testing the eeprom..=
.

where uboot allows the writing of eeprom currently without having this pin=
 configured, linux does not and require green-led switch off.

> Though, I don't see any other solution, so I can only give you an advice=
:
> don't ever write to the eeprom from the kernel. Things will eventually g=
o
> south otherwise.
>=20
> I would also advise to add a read-only property to the eeprom node.

the eeprom is empty from factory, but can be used to store e.g. mac-adress=
 which are random by default.

i tested a bit with tlv_eeprom command in uboot and some additional patche=
s to archive this.

imho green-led as running indicator on (=3Dwrite-protect of eeprom) is a g=
ood solution
=3D> readonly by default, but allowing to write it if user is really sure =
:)

> Regardless (and sadly),
>=20
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@colla=
bora.com>

Thanks for your opinion and RB

regards Frank

