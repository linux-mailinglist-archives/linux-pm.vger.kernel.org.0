Return-Path: <linux-pm+bounces-21679-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EE5A2EBD1
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 12:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51C85164DAA
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 11:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6511F3D59;
	Mon, 10 Feb 2025 11:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yk4Lqtfy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF261F3D58;
	Mon, 10 Feb 2025 11:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739188086; cv=none; b=PeQXaK2ZwydCA6CizackZVGaBDKWeGp5DipH7V12LWCKC2danGvRUscp0xZA0TfGT31JVUfh4C5yfh77OL49ukDEAoDaJpEgEpVdIaDqx2c9lfGKrb3NnNmAufz3mZkXHcgfa52NZWEsWaBYgV63rnQXgJmEUIxZ0aWe32Ki53Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739188086; c=relaxed/simple;
	bh=7xr6eif59D5Z0cBZLVAON47L6iycbPs+daElwJ+WYIY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RdkZUfYL1cVXaNclI7B3A7uvKzWjdeLXrwUSngi0QSD8GgignXXyaZ9YRIRlt7Y2ywKJNUFITi026Y21ZYnobNDSomGvATFjZWPI97C1U0H6jRSVt8Zal1J4ZvOvSBOtel41ZXyvGqXpJwFL6nDNWRgMgVq9v1qoYiMlnY4XlnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yk4Lqtfy; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaec61d0f65so948691966b.1;
        Mon, 10 Feb 2025 03:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739188083; x=1739792883; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HVl3EUiEdR+2nH8WWZkP4Nhw+7rNyWyQ5wQqq3ShzRs=;
        b=Yk4LqtfyidftPUhLJ92QON69Wwn6fmuvd4WZgTlXh0hl1f4NAPQlfbYgJmE/gkmtno
         ZmeL47ybPstNGW2wHeoJd76YaToCWN+tI5dH4VRrSRqlt4K5RNn6ciUNhk5ChDt6SI4g
         znMcbcGu26EellmrRpTJtqmqApn+7oorr+VUY3pWQNbKnGQ/YvvoNjpJnpZPehFkuB+g
         +6BaVIvWdwonfuRdi1XlmjcQGTKXaV019tLfqg1/sKzs5vCIYSgufU6UR5VmQDz4cYL3
         Np5dbth0Y6LbUFawC7uqx2tighQUV+8j6hXgdU+Cbgpalc+z9WxVLha/Z8bIHRR4nlWW
         /IVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739188083; x=1739792883;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HVl3EUiEdR+2nH8WWZkP4Nhw+7rNyWyQ5wQqq3ShzRs=;
        b=X3i/E3/ZlSlL58ts6jM6BpaVWxLfxl4k/wqq7UiYv8csRKeSbc9d+OCBa+HVralXgK
         u4HIXv1gRt7PANMKUbkT/Z3cqPxZqfLVL01jUBEGVgHGdPn2IxVPImTzTyUrFRid49HR
         fIB2aVLokAx58y28A3oYW4QlE/ZLGuvb1op+tX8esV8szR/08XcCTx+HwRCAQrBUnluW
         4eAGiMYxo6Obs+Y/TMa0Jea9DAcZKd+9ZxwEheRaUJEW1BWFNL+0IB0JUGjah9lfWtwT
         ypH7t+eoeMbaG+mGJAhUf2afNsKc3CveHf9rEqvwV1AIeusMJYVvDTWMqht3AUni6Yfn
         9dEA==
X-Forwarded-Encrypted: i=1; AJvYcCW+OCmqMeJA7Pq+6HCTDlvM0fulst7/MYBRIXAkRJUIdx9i8xid/ML84tu+669DWU9V6d0E+y+o5vM=@vger.kernel.org, AJvYcCXBDHI+IODG4E9z1Ji0O6bVo7lgHzXoUwqVvgH8et+ImUfxyQdqd1M1U5o4G2Gxw6PwYp+NSAh2l74n@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh2VuLDmVbQedhvnoDN0ZQQJPalWhQ7ug4cB3bQQsCDVgfBPCM
	G3Rug/m/i70SyIYqX7XiF6a4ZFXbMaxzG02VvUIORWv3mMIMSfEGjcQSgF87
X-Gm-Gg: ASbGncvVigyKivj1mS6JL1IXpLRppW/EKGWX/6tb7srAEg6NN5E1rhH6E+vQn3RfV5H
	tashmJU7uk8BggNTGsVJ1O/AxWsU4U8yCALkLQTJ6FpppILEEmhHf8hdOTfaF3tsdho/WyQUjiI
	12xpMCwzLwzWhYvSGftV123MGmn4I9Imi1mbk4j7P3mumknRjCr5aL+Uc8+e6iDBmjfQr9E+OIp
	QeQSCcu0tX1EnWhvzV/sqXa6BPjwn5pKK5BfRhJ5LnBr1EjiDXLbH5AGc5pYSPZF2ju21sT6ppR
	BeXiiR5Vxwg8YEaKun0FA/6SACpaF2bf
X-Google-Smtp-Source: AGHT+IGY3dILn6ts/Eq3QIZU6ECVgNuSbLxMNRT8V0H+TQxvFHnWdoPp+ST/buUvAjzzmdL3OQMGTA==
X-Received: by 2002:a17:907:9719:b0:aae:8841:2bba with SMTP id a640c23a62f3a-ab789b84353mr1350942666b.22.1739188082366;
        Mon, 10 Feb 2025 03:48:02 -0800 (PST)
Received: from giga-mm.home ([2a02:1210:861b:6f00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7bc28c58csm252975066b.135.2025.02.10.03.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 03:48:01 -0800 (PST)
Message-ID: <e17ef70f7536bd1bf0b4d0f7258f91cffac76a20.camel@gmail.com>
Subject: Re: [PATCH 08/10] riscv/arm64: dts: cv18xx: Add sysctl and reset
 nodes
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Inochi Amaoto <inochiama@gmail.com>, soc@lists.linux.dev
Cc: Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto
 <inochiama@outlook.com>, 	linux-pm@vger.kernel.org,
 linux-riscv@lists.infradead.org, 	devicetree@vger.kernel.org, Haylen Chu
 <heylenay@outlook.com>, 	linux-arm-kernel@lists.infradead.org, Sebastian
 Reichel <sre@kernel.org>,  Arnd Bergmann	 <arnd@arndb.de>, Philipp Zabel
 <p.zabel@pengutronix.de>, Rob Herring	 <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley	 <conor+dt@kernel.org>, Lee
 Jones <lee@kernel.org>
Date: Mon, 10 Feb 2025 12:47:59 +0100
In-Reply-To: <h73zitljaig7nrccd3f23i655imswv54tf667dhq3dord7rxsr@unqncqlorvc6>
References: <20250209220646.1090868-1-alexander.sverdlin@gmail.com>
	 <20250209220646.1090868-9-alexander.sverdlin@gmail.com>
	 <h73zitljaig7nrccd3f23i655imswv54tf667dhq3dord7rxsr@unqncqlorvc6>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thanks for quick feedback Inochi!

On Mon, 2025-02-10 at 13:13 +0800, Inochi Amaoto wrote:
> On Sun, Feb 09, 2025 at 11:06:33PM +0100, Alexander Sverdlin wrote:
> > Add reset controller node and required sysctl nodes.
> >=20
> > Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> > ---
> > =C2=A0 arch/riscv/boot/dts/sophgo/cv18xx-periph.dtsi | 16 +++++++++++++=
+++
> > =C2=A0 1 file changed, 16 insertions(+)
> >=20
> > diff --git a/arch/riscv/boot/dts/sophgo/cv18xx-periph.dtsi b/arch/riscv=
/boot/dts/sophgo/cv18xx-periph.dtsi
> > index 53834b0658b2..d793b6db4ed1 100644
> > --- a/arch/riscv/boot/dts/sophgo/cv18xx-periph.dtsi
> > +++ b/arch/riscv/boot/dts/sophgo/cv18xx-periph.dtsi
> > @@ -309,5 +309,21 @@ dmac: dma-controller@4330000 {
> > =C2=A0=C2=A0			snps,data-width =3D <4>;
> > =C2=A0=C2=A0			status =3D "disabled";
> > =C2=A0=C2=A0		};
> > +
>=20
> > +		rtcsys_ctrl: syscon@5025000 {
> > +			compatible =3D "sophgo,cv1800-rtcsys-ctrl", "syscon";
> > +			reg =3D <0x05025000 0x1000>;
> > +		};
> > +
> > +		rtcsys_core: syscon@5026000 {
> > +			compatible =3D "sophgo,cv1800-rtcsys-core", "syscon";
> > +			reg =3D <0x05026000 0x1000>;
> > +		};
> > +
> > +		soc-reset {
> > +			compatible =3D "sophgo,cv1800-reset";
> > +			sophgo,rtcsys-ctrl =3D <&rtcsys_ctrl>;
> > +			sophgo,rtcsys-core =3D <&rtcsys_core>;
> > +		};
>=20
> I think these node is not suitable for riscv. It should use SBI SRST
> extension to restart.

Independent from the particular form, or its correctness, this is still HW
description, right? It would be a "policy" for the kernel configuration, if
the particular build would rely on the FW or a kernel driver to reboot.

In other words, the HW block remains in place, no matter if it's controlled
by a kernel module or a FW. What the point in hiding it from the RiscV part
of DT, keeping on ARM64 side only?

--=20
Alexander Sverdlin.


