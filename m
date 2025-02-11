Return-Path: <linux-pm+bounces-21822-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C04EA30BF1
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 13:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2AA61886D85
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 12:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07496204873;
	Tue, 11 Feb 2025 12:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjMlWr4L"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2890F6FB9;
	Tue, 11 Feb 2025 12:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739277818; cv=none; b=WFTfNS6kYJnlFh39sAQD2xqokNrlf4e/naBMXlkSzG+q3fCMnsTsutNjFDSzghDSJhh0aQ1m++pavm3oeZa2T2Fr8wm8UHh28PzI6J1lRAPOO7XxsTmrtJYPVlUrQkF9SaU75LwugOcEKt0D/B0HcCLcvUypaIc//KEV1aIRZi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739277818; c=relaxed/simple;
	bh=uepduHjDPy55AkkCGXbAU8w+LO18qfkEQA77TDsyyXM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FivNtL793kuoXJNcWpQPtV7UDA33T1WCzYhysWrZIOIlQIp7ATHj+dDpY9kMXvzpO9Whc/88masEvdaMxA0vihunuXsapMWDGTJtU6kKpU78agg3cpKGWGANJpC7iD+tIq9n8baRn8zY06VsBzELAloRrp4A+L1mbr+JqLlxhbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjMlWr4L; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-439350f1a0bso17866595e9.0;
        Tue, 11 Feb 2025 04:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739277815; x=1739882615; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uepduHjDPy55AkkCGXbAU8w+LO18qfkEQA77TDsyyXM=;
        b=OjMlWr4L7vFaPgFwcMHjFximY+8gx242R2mtTXx7AXXoJfe8kS+PYWub2dyDAFbP+L
         jQ9MPdImhr5KRXbvlEGRRnunIhTJjWWyi7blEm05l146eeOE7ryiVRm/Hfg28t3SENCR
         6q4Z5TZe+gv65rSwWfX+UX3efXSxVdeC7yqIk+bWVDggVeaw8AwONlmArnZrjBO2uOFz
         FQd55sMc8TqWWNcGyTKG29iyOSxl6pDZL/nge7jxlerE+REScjJHqXApu7sXhPMKYb7Z
         Fc/gygzktHRvv4DGJjEFI/65p1kAf96KfUuVOdypC4hcL9mMwCPm0Yv2Kfnplu8/sZ4w
         d9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739277815; x=1739882615;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uepduHjDPy55AkkCGXbAU8w+LO18qfkEQA77TDsyyXM=;
        b=ETAM4mjifOT3pSVLrl74skUT753p15G5Rdj5qsIk5m+3LkJzFk5+O3sufuqSH/7Ywa
         qTW4T15NvrPGPjwR2tZ14DDgYG/fRzelPMQnx8Ylz6bjdb3Vs/qBdUcPEhm93tXGREOg
         UuwAuRMNf1ifqW0c455uf02MQmtJkxjVHOPBcV2UsrJbB0qHc1Z0FR7oZ67pEGMJJRk4
         a9pw2Z+pQzRGG2H+Tc1P/TOjl7uVarEOMKSwQdsTMbQLC9SRJL7xs0OXK+IDTgNxH9qx
         E5ngbbQw/MlXADlE5Z6vjzimWQLU/tO7rzPyhAqhKbnpCszOYyVQB471M90chFgSUlR2
         lHsw==
X-Forwarded-Encrypted: i=1; AJvYcCUIb01nZh9o7MC54aB4D7+uWjWCpF9rgLEH86G6AB23ETglmaCpWaIFujQ3XSMYh2nSUM8EW+Uiy5c=@vger.kernel.org, AJvYcCUdHV5uPEZckqLdsLGJh6qedr9K+uwCqEjIwGjstS7r/GtZbbK05OkmNWKsi4jQtp8TinsBvo8NrhfU@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1SoFNPazcgIndfK7zIkN2wLU4mjz/DyvqE4SnPsNsBelmfNvC
	UbLGr1D/gi0qrqxayE1GY+HUzqsnP25gSl2xC8L0j/bBIQB84kuj
X-Gm-Gg: ASbGnctOvyUEPvIbXPYYn68MrtCfVT8ZxjMU6x9bJz7lwTc3ZUs5iz7Vn3FSDjMbMej
	viIEyBuGCVsguTXuI70hOCRAs/qgi2gn5kBZmnL+6x3iuJwk83McrTKNw4G+HqKc8Euww9TMt7v
	izau2N2G68sn7+5mVrE8Dycu5XFVGLYoqF8t9KjWCQz+7BzZ5scFrbDdnWnzdGq2GJe+ulhWIm8
	znO3dmwLy9dP+DlaEvh5T4bUPsKM5wqWW9KvW9mCOQNH0NpubeZ4MvCE4tuqZYcoGzkroj3Icoq
	lSJO/5lWB2YpX53JasB0roepwqbbTwB4
X-Google-Smtp-Source: AGHT+IEBhVLUgJKyLV9yDCk2soLE+OEkOUesnwWNG1Lpa/Ktin9FkzYLpEqwqMjhtsNnoPajSZttXg==
X-Received: by 2002:a7b:ce8c:0:b0:439:31a6:276a with SMTP id 5b1f17b1804b1-4394ceaf874mr28491015e9.2.1739277815164;
        Tue, 11 Feb 2025 04:43:35 -0800 (PST)
Received: from giga-mm.home ([2a02:1210:861b:6f00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dcd8213f2sm11711856f8f.67.2025.02.11.04.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 04:43:34 -0800 (PST)
Message-ID: <b1f05bff1d6c3f0cb1b381c15dcf222ec4c7f1b1.camel@gmail.com>
Subject: Re: [PATCH v2 0/7] arm64 support for Milk-V Duo Module 01 EVB
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: soc@lists.linux.dev, Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto
	 <inochiama@outlook.com>, Lee Jones <lee@kernel.org>, Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel	 <p.zabel@pengutronix.de>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>, Paul Walmsley <paul.walmsley@sifive.com>,  Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Sebastian
 Reichel <sre@kernel.org>, 	devicetree@vger.kernel.org, Haylen Chu
 <heylenay@outlook.com>, 	linux-arm-kernel@lists.infradead.org,
 linux-riscv@lists.infradead.org, 	linux-pm@vger.kernel.org, Jisheng Zhang
 <jszhang@kernel.org>, Chao Wei	 <chao.wei@sophgo.com>
Date: Tue, 11 Feb 2025 13:43:31 +0100
In-Reply-To: <20250211-backwash-jester-2fdd6740000e@spud>
References: <20250210220951.1248533-1-alexander.sverdlin@gmail.com>
	 <20250211-backwash-jester-2fdd6740000e@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Conor!

On Tue, 2025-02-11 at 10:50 +0000, Conor Dooley wrote:
> On Mon, Feb 10, 2025 at 11:09:40PM +0100, Alexander Sverdlin wrote:
> > This series adds very basic support for Milk-V Duo Module 01 EVB [1] in
> > arm64 mode. The SoC (SG2000) is dual-arch, RiscV and ARM64, the latter =
has
> > been chosen because the upstream toolchain can be utilized.
>=20
> > =C2=A0 .../{riscv =3D> soc/sophgo}/sophgo.yaml=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 +-
> > =C2=A0 arch/arm64/Kconfig.platforms=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
6 ++
> > =C2=A0 arch/arm64/boot/dts/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
1 +
> > =C2=A0 arch/arm64/boot/dts/sophgo/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +
>=20
> I'd expect this to be maintained alongside the riscv support, how come
> there's no maintainers entry change here?

MAINTAINERS file has "K: sophgo" entry already, I suppose new files will
fall into this category? That's why I've ignored this specific checkpatch w=
arning
in all patches. Am I wrong?

> > =C2=A0 .../sophgo/sg2000-milkv-duo-module-01-evb.dts | 31 +++++++
> > =C2=A0 .../sophgo/sg2000-milkv-duo-module-01.dtsi=C2=A0=C2=A0=C2=A0 | 8=
5 +++++++++++++++++
> > =C2=A0 arch/arm64/boot/dts/sophgo/sg2000.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 75 +++++++++++++++
> > =C2=A0 arch/arm64/configs/defconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
5 +
> > =C2=A0 arch/riscv/boot/dts/sophgo/cv1800b.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 64 ++++++++++---
> > =C2=A0 arch/riscv/boot/dts/sophgo/cv1812h.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 64 ++++++++++---
> > =C2=A0 arch/riscv/boot/dts/sophgo/cv181x.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > =C2=A0 arch/riscv/boot/dts/sophgo/cv18xx-cpu.dtsi=C2=A0=C2=A0=C2=A0 | 5=
7 ++++++++++++
> > =C2=A0 arch/riscv/boot/dts/sophgo/cv18xx.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 91 +++++--------------
> > =C2=A0 arch/riscv/boot/dts/sophgo/sg2002.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 64 ++++++++++---
> > =C2=A0 14 files changed, 451 insertions(+), 103 deletions(-)
> > =C2=A0 rename Documentation/devicetree/bindings/{riscv =3D> soc/sophgo}=
/sophgo.yaml (80%)
> > =C2=A0 create mode 100644 arch/arm64/boot/dts/sophgo/Makefile
> > =C2=A0 create mode 100644 arch/arm64/boot/dts/sophgo/sg2000-milkv-duo-m=
odule-01-evb.dts
> > =C2=A0 create mode 100644 arch/arm64/boot/dts/sophgo/sg2000-milkv-duo-m=
odule-01.dtsi
> > =C2=A0 create mode 100644 arch/arm64/boot/dts/sophgo/sg2000.dtsi
> > =C2=A0 create mode 100644 arch/riscv/boot/dts/sophgo/cv18xx-cpu.dtsi

--=20
Alexander Sverdlin.


