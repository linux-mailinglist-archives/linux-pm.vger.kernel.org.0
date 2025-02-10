Return-Path: <linux-pm+bounces-21732-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 888D6A2FAB6
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 21:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C27716928E
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 20:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490641BC099;
	Mon, 10 Feb 2025 20:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F17Xuh8p"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0E918DF93;
	Mon, 10 Feb 2025 20:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739219459; cv=none; b=D2tNTgId7TVy0V6wi4giLpHBATWeAWK/Wn1MMp37OTU2BbLmiQour9fzEDKy1mTFTm9r80aXJd1geb9e3NfRfWpYGMZFUy+ZFma4prhCkKwBI4QrmY+0N+Jp4r6x1Cgo50EX1yO2EJalGjzGjylFkTbwg85PVOGlr1ch1TjJBZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739219459; c=relaxed/simple;
	bh=m557/Jpvp5pp4+T1xIHiZmJOAkIv767CgIPPPqCBZEw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kCghfoo2CMOMnL95m2Puvvz68FTRtC+kUG3Z+lRNdQWzPLeataYHoE8aSdgak7gontKpd9aci15m2IxFIgzjFqSDpwInnun9vyIQkFlc0GYkkVt8RgztvhtXfI7AhtmUZf8/R8t+JhfW7aWfzqWQtw0nBrpurE2n6hep0v98EFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F17Xuh8p; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38dcb7122c1so2926441f8f.2;
        Mon, 10 Feb 2025 12:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739219456; x=1739824256; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m557/Jpvp5pp4+T1xIHiZmJOAkIv767CgIPPPqCBZEw=;
        b=F17Xuh8prPlCOiybTWlgiIAPJOjL14evZIr/nwc1hXk9eh9BBjWJhTIJb0wBx0yOrr
         IvfYmtDA5/tI8sekpJkIG38Gh861RHBS1kXkCVcfRIpNBZyOlCDKVxPLRmDgm4R4Y5Jx
         MXmjFibbro63SNAiAD+epjQZxtM52eDuBrn+4NHwey6yNJT4Wpr+BbQm+qDtv4jpRt91
         xq+WAyLyQCy6tUb7ALD8/UFFavqsgM4M4yfekieB28kprglhg2GwsrKXJJqWVGg9Pq4J
         YVhGnSpcXwegxYhHkKFi5gkTQvMF6XFloEsAhvemczTwebgd3OhG16MBwFNLsuRx2z76
         cd5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739219456; x=1739824256;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m557/Jpvp5pp4+T1xIHiZmJOAkIv767CgIPPPqCBZEw=;
        b=Sk5pSf9nyPSDtwWIvXcOpkZXhvp7VS4+X/ebtAeTmZXPSZ1RPw25k1tiGLkxIwei1J
         NKFGMWyR6oxV5m3JfEePuhLYM4gnDDDNVtPThffVMhOwO3JJ7WKypL8feKRqDXoyIic9
         nB9GVNZWCNtR9XE9/vXEx51WgXeTKmiV/X/9lSsMG5R9UE0CjZr1OY2jee/oBoo7bFxy
         vSYQ/omgZyAOgg8lHvyvCnEpaCpDQuBVi443UOv5ioAKF/PxeSb19Ttl9EN1M/wYLQEs
         sfwHn6AfA3orG6PsKv+JOpyg5aCA646W4Oc5LiYZ/isG2d9KChTSz3+mNDFyYuhZyyfe
         O/ug==
X-Forwarded-Encrypted: i=1; AJvYcCWGIeQLh0TsXFgX16z33txl1wzA1p43X3We8O7wEt7rCeBIU4awR4DNZE5qtY6T+yinsFkj29YJ57s=@vger.kernel.org, AJvYcCX13847unZXTAWZ/kDUx+C4DwE7gJBEF6wZ+q+++KPx/b0g6d+XUkZoUHvbMXiRcCLgw8sIH7dXDzeE@vger.kernel.org
X-Gm-Message-State: AOJu0YxfI6TJrQDBgWjxF/Ms/ns2esd/DDo2wggKzbu5CYmj3ChvM/E/
	ggzamW3XDemYkLo2XvoKco1By9U2UwIev5phNaKQo4ODfsbs7n7Dl3CekTAU
X-Gm-Gg: ASbGncu1jM2Mo2fSDl6uqyp7GAn4WwQYxF3W0RmwVJiml87KlHDtJgzZtW6r6Csr2q3
	e3E9F0aa7JQvmZBtfKHVaZ7ZdFf0/verMVAv9gMYVlHMCm/5Lc1x9m8Gzwn5RPCgGbSM+JZhJxs
	EcJ5GVGqGwUrL9lVqdr2bQAnKQsZl1Sdw/oNFjvx03MSleZQT3RWpmgJoDSJ85bl4P3dcOrx6vJ
	tM8WNUlk0PSUoj43xPkZaaDlznIIiDVZD9W5iYPsYGpxix2RaUZ3HPNZ1GdlqSve4RGhQZxZqEj
	3nSec8YIDDeW3nt1vqEvQ6qseqJc2Lfi
X-Google-Smtp-Source: AGHT+IFvurPoS9MTaLS3PpCWAsYOJF7NzTYw7+2Z56lUplq4lRolzdbvYN3eBpQHiYgZPARX6B6e0g==
X-Received: by 2002:a5d:64eb:0:b0:386:32ca:aa12 with SMTP id ffacd0b85a97d-38dc93745famr11388110f8f.49.1739219455327;
        Mon, 10 Feb 2025 12:30:55 -0800 (PST)
Received: from giga-mm.home ([2a02:1210:861b:6f00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dd9c48173sm5389541f8f.37.2025.02.10.12.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 12:30:54 -0800 (PST)
Message-ID: <e76da2aff03e9c788bc322d84d83b0e6c28f44b0.camel@gmail.com>
Subject: Re: [PATCH 06/10] dt-bindings: mfd: syscon: Add Cvitek CV18xx
 rtcsys core and ctrl compatible
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, soc@lists.linux.dev
Cc: Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto
 <inochiama@outlook.com>, 	linux-pm@vger.kernel.org,
 linux-riscv@lists.infradead.org, 	devicetree@vger.kernel.org, Haylen Chu
 <heylenay@outlook.com>, 	linux-arm-kernel@lists.infradead.org, Sebastian
 Reichel <sre@kernel.org>,  Arnd Bergmann	 <arnd@arndb.de>, Philipp Zabel
 <p.zabel@pengutronix.de>, Rob Herring	 <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley	 <conor+dt@kernel.org>, Lee
 Jones <lee@kernel.org>
Date: Mon, 10 Feb 2025 21:30:51 +0100
In-Reply-To: <fe1fb66d-285d-41b6-af71-89f6f93d1cf0@kernel.org>
References: <20250209220646.1090868-1-alexander.sverdlin@gmail.com>
	 <20250209220646.1090868-7-alexander.sverdlin@gmail.com>
	 <fe1fb66d-285d-41b6-af71-89f6f93d1cf0@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Krzysztof!

On Mon, 2025-02-10 at 09:48 +0100, Krzysztof Kozlowski wrote:
> On 09/02/2025 23:06, Alexander Sverdlin wrote:
> > These syscon blocks will be used for CV18xx reset driver.
>=20
>=20
> No, implement proper reset block instead of abusing syscon.

I don't think it's an abuse... You need to look into the corresponding TRM =
[1].

4 bits I need to tweak (and one magic number into unlock register) are rand=
omly
placed at random memory adresses and otherwise adjacent bits have random
unrelated functions from random unrelated subsystems.
If it's not syscon, I don't know what it is.

It has a reset HW block, as you and Inochi have correctly pointed out, for =
other
purposes, for resetting the SoC IP blocks. The overall SoC reset is complet=
e
mamba jamba.

I was thinking now about a syscon driver, which will register_restart_handl=
er()...

Inochi, do you have more insights into it? You've mentioned RTC and 8051...
Looking into TRM I don't get it, why a thing blessed to do all the housekee=
ping
(and called "System Controller" in imx8, for instance) happen to have RTC_ =
prefix...
Would RTC subsystem maintainer be happy with a monster driver which has tie=
s
to all other subsystems?

[1] https://github.com/sophgo/sophgo-doc/releases/download/sg2000-trm-v1.01=
/sg2000_trm_en.pdf
("rtc_ctrl_unlockkey", "rtc_ctrl0", "RTC_EN_WARM_RST_REQ", "RTC_EN_PWR_CYC_=
REQ").

--=20
Alexander Sverdlin.


