Return-Path: <linux-pm+bounces-21733-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F54CA2FAD1
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 21:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B3193A3A3A
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 20:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E16826460C;
	Mon, 10 Feb 2025 20:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9tUmVtx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4840264603;
	Mon, 10 Feb 2025 20:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739220043; cv=none; b=RzPtXDWAQUzpfwg66MepLVPgj2KoafCpaNnZW6UH/gbyVTptdJWG+NDmxw67U/tgrSTAs94BQkLnfMrNXfCSzqKZK0r4jvIo+zrKwfUTLKpOLb1rpK+RYXO+di48mr+35rXIC4uUL60XQdTPx474lMzWZiaE6z3+Uoria0O0/R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739220043; c=relaxed/simple;
	bh=EOrJyLpi9o+aX1l7UhQTaefPqHhchUVGMwHkMkiXSo0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HBGrbgjCkavlWao13qnysPLBQ3557dw6oLlNFxUksyBBCDWSBdeAyruFYvCQlFqVE2jHWH641LPfZOM3V4p88Ii8afDMg+YseCriuTpcTV/Pre6pykffuup7WqNSxyJE+7Hnockbt483sNAEOGmjoiNgfdm9EkMoc/U4gy2BlrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9tUmVtx; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso10524685e9.1;
        Mon, 10 Feb 2025 12:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739220040; x=1739824840; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EOrJyLpi9o+aX1l7UhQTaefPqHhchUVGMwHkMkiXSo0=;
        b=e9tUmVtxwSDk3ZUC8j3JvxvRwwVv9/HlSVFRe74/Zr/HZNbP52+HHcegZNfkihyPb3
         3feTsE6BWZqRsC4cKPTqZpO597WUDPY9cYkZP4bDOGBWD82FoUnBwmxkHvYB8SL7Obh7
         iVaqELUZ2XNds7uwtGq1zQ+xUiNXOKUytOY4OTIST154Izz5+VUhmGPEnYcmHLwH9JKq
         uklRDzpYenGaGSdFpwSCc7iffDJX1qeXG9vExDZAOVc6pLgiU4EOM5qEUGIVTlirUFCe
         v3HnERWYgIV8GzPjIPvmczH0RZzgMm7YjcKcy3GqbgdV392ZobidumqHRQ36r1/wWd7E
         +qNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739220040; x=1739824840;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EOrJyLpi9o+aX1l7UhQTaefPqHhchUVGMwHkMkiXSo0=;
        b=CWjROOaPHNpJOisczIqCFnBWt1FUcMLIsb5IdbcVbLu02/MHYCoqlyL0KvrqUVgGAN
         tNvRxmW+4K76jxQzKAQmkODf/f76ptjDCA/3bpq03TvBdWW8i5sCLu/9xwXfV/9TpsD7
         9rnN7gwGYls8UGsAVGnNAm/hr6g0H8TaxN/Na7zfXkB0gZOxr/wBit+1+nk/IE3ph8lJ
         s8lwXjh3JCTB/JdqJ0deCE3TDfPyfY1m6P00ZYi+WYmNM4hMN6Ua5EDIpgRjEon9dvLs
         hyhbdL5dLLJJZEjPhdtwiSp5//MsDSuqSrD668u55h/UcWKP98mPrI+tUgx1KEFBSdg4
         FQ4w==
X-Forwarded-Encrypted: i=1; AJvYcCU3eMBHY3IZRp5iwl1beBrdfUxsSH3l8/+bLdWIcvuvkyKC2art4f/LcmK8X/Ap1Rd+SiBbulM29gY=@vger.kernel.org, AJvYcCUXanFs6vh+fsAYYnwxpifA7cwCqxHCxTdHGo8Hr2Z50GT+Qz1fUPCIlyexu2AdaFWycMtyW0R3czC+@vger.kernel.org
X-Gm-Message-State: AOJu0YzeQFKFvILzR0Pxw71Za1bgc9C0dGlYP9pB6+Nd8lGhvSFtozKB
	8JmjOrZ+k0Y0B9jThGSVboA3ifsNpnF+PvdwppiW7L0HdZEI3Xm9
X-Gm-Gg: ASbGncv+yp5DF+HPnVbsRo+hpTIf6BT+Xand3xdJqzdAtVrH+ZS9qYowpvb5+WeLaA0
	eSC3WzK4ubTi/VEGWuF4WCYd+Gt/fQgDTa5pjDvNZ7gahmoHMIRuTuNEHvotuZTu7BC/IIz+pt9
	TWZNoTpJORQ39bJ+UdQtJtvS78NFCS8vvIzg1vK/Q882wxngZII3vO14uhRDP0cHjMp4SB1qWpZ
	tWb0644JSH+cc7qQbj9krDpfadEgHF5Xg5QC1mpL2iUFO7VHuJbCAVrgQeFuyNb2HWvEEsuihxP
	rNnJypfqB8HR9VFMyXdLQm93qahbVe8O
X-Google-Smtp-Source: AGHT+IGANzhAWt5IwkQhTvn7xGsdCRHvYJ4peTBZKCls6+W0CRyuS6ldpr+5UQbejq+0t4DSbFyanQ==
X-Received: by 2002:a05:600c:b9b:b0:439:4637:9df with SMTP id 5b1f17b1804b1-43946370d05mr42704375e9.3.1739220039819;
        Mon, 10 Feb 2025 12:40:39 -0800 (PST)
Received: from giga-mm.home ([2a02:1210:861b:6f00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390daf44f3sm194823195e9.29.2025.02.10.12.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 12:40:39 -0800 (PST)
Message-ID: <b51ca7db3e2a7fab372ed950e3a18cbcd6c56ba9.camel@gmail.com>
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
Date: Mon, 10 Feb 2025 21:40:36 +0100
In-Reply-To: <e76da2aff03e9c788bc322d84d83b0e6c28f44b0.camel@gmail.com>
References: <20250209220646.1090868-1-alexander.sverdlin@gmail.com>
		 <20250209220646.1090868-7-alexander.sverdlin@gmail.com>
		 <fe1fb66d-285d-41b6-af71-89f6f93d1cf0@kernel.org>
	 <e76da2aff03e9c788bc322d84d83b0e6c28f44b0.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-02-10 at 21:30 +0100, Alexander Sverdlin wrote:
> On Mon, 2025-02-10 at 09:48 +0100, Krzysztof Kozlowski wrote:
> > On 09/02/2025 23:06, Alexander Sverdlin wrote:
> > > These syscon blocks will be used for CV18xx reset driver.
> >=20
> >=20
> > No, implement proper reset block instead of abusing syscon.
>=20
> I don't think it's an abuse... You need to look into the corresponding TR=
M [1].
>=20
> 4 bits I need to tweak (and one magic number into unlock register) are ra=
ndomly
> placed at random memory adresses and otherwise adjacent bits have random
> unrelated functions from random unrelated subsystems.
> If it's not syscon, I don't know what it is.
>=20
> It has a reset HW block, as you and Inochi have correctly pointed out, fo=
r other
> purposes, for resetting the SoC IP blocks. The overall SoC reset is compl=
ete
> mamba jamba.
>=20
> I was thinking now about a syscon driver, which will register_restart_han=
dler()...

Sorry, I meant "MFD" driver...

> Inochi, do you have more insights into it? You've mentioned RTC and 8051.=
..
> Looking into TRM I don't get it, why a thing blessed to do all the housek=
eeping
> (and called "System Controller" in imx8, for instance) happen to have RTC=
_ prefix...
> Would RTC subsystem maintainer be happy with a monster driver which has t=
ies
> to all other subsystems?
>=20
> [1] https://github.com/sophgo/sophgo-doc/releases/download/sg2000-trm-v1.=
01/sg2000_trm_en.pdf
> ("rtc_ctrl_unlockkey", "rtc_ctrl0", "RTC_EN_WARM_RST_REQ", "RTC_EN_PWR_CY=
C_REQ").

--=20
Alexander Sverdlin.


