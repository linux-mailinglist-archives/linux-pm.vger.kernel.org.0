Return-Path: <linux-pm+bounces-18597-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2FF9E4D91
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 07:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C6B1168F64
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 06:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C65196D9D;
	Thu,  5 Dec 2024 06:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F0Lxr09E"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5411922D8
	for <linux-pm@vger.kernel.org>; Thu,  5 Dec 2024 06:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733379743; cv=none; b=keS+BZ5LsChSc8Kp/p/FjVQIcOSDJ6gcw8MMWEFH/yuLbfl2fU4//B1VSYC99iuB3m7NYDX3HnV49VO/TouUU37o65JRoThagmNNYkiIF236rKUwhP2iB6l6+gDMlla2daiqQ1W/HNHsoiNAk+ggcFFdYSwUxCFbzaBtQCv104Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733379743; c=relaxed/simple;
	bh=635HXEH9z9+euuYtdUWAXhck3oezPbylgKy1CXvtRrE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h9qpxtijBw/HKXymGZLld3dNMSeS7e+1v08e/BEeSt4RjIH/ruyMSWRCqJ0YOaC4l+1TRZoHQ5QqvgbV93fSYA4GLtxDlro3VyrosDxkXAF/yW1ZoWCjYmASIpEcxPC8vTrTQ6cWZGzllBA0CrKoeW5dtcPLN4pKpnydC7YkMqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F0Lxr09E; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385d7b4da2bso451455f8f.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Dec 2024 22:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733379740; x=1733984540; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=635HXEH9z9+euuYtdUWAXhck3oezPbylgKy1CXvtRrE=;
        b=F0Lxr09Eak/GQOOtKyld0TH0mqp9lKCKMeFYoQy5C38t/jyhTIfeqOqlCPDyxW2idp
         cV5prbbduYU9eMw5+en+nvAC384BJX83WxO5uM+ycbQc7HOs1bthBHKKFiBzN54Ym+9a
         stqvPQ/mP+M4Aa1FDarvd9cOuLF8ncFDRcqi4nWcou9o3JYITTVRy4eQiV9pZcHl23dg
         hsaOBu01gHSTJ1fhokbY8n7WUcMnsQRMrO8+MUgL3szPivTnn0IbbwAxrG5h/u7hIn6j
         ZiRiEsKg74IfhxnJ1B0MBeK5HmvC/J3zOOKyITXdJaaDgrKYRRqN8NInvIkDqTJ8b3O0
         r+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733379740; x=1733984540;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=635HXEH9z9+euuYtdUWAXhck3oezPbylgKy1CXvtRrE=;
        b=fOKmRcLUW6O/5+no9nU7+RornWNtbR9MGXfe5aeJlT+oaIzD0ibiPRDfv5939juWO6
         4wfGdbsR1VJiTdN65T3UDi5A8wTgNATSnm1FD1K2wnKca0VEN/WvooMYqFJVRH6iq1aw
         Z97y7LLlNBriQmnFVwB6P/6qs0jfaOAkZNV+zb+h2v3cicPg8ohdJxjOfV1/MvQa4iL3
         J1iyC3K4DX3+kiVT7MW0dDqG8KsTCmDoDAAyciSVKc4FA1M2I1zO5mG/T6WdtDOfVzTi
         qVOnd8gDomME5UGGN4Hi/Jq19voNv5TqG3CAOJt7UdceL8WkTgqFBJcRN1LOwA+ztcML
         Xk8g==
X-Gm-Message-State: AOJu0Yw3drqZCDID7Fe0Wf+P8ZGxabNzUAn7G/der2amED4kn42WkH/t
	9MBeRMjDnXwF+F+7mihCMoVZz6nprM1zHqL1Lzh/yxh+ErX5b13lLZk9DJ3AISg=
X-Gm-Gg: ASbGnctFRIR+E3er7hj+x9p/JhRZjEqSygJrWWsREmiy2p67LhUuTEaNaVfU4FBiwSh
	YOE2aLvTFOALoW44hJCJdczUQubz1OC7+370G5APmTskSF0I7xeJyly91JUWATCLixKdDEzKK6U
	YKYiOTaWJcUsbic6Ngc3GJRznUPEEfINhGP8vihWjeBcX37P/8OGuWgqserwe04KFA2z291oaPa
	p6lrz1Yvx7gNr7Cv4w5HiBD1WGvx81J9qID51gC/LDeuM8nit5r1g==
X-Google-Smtp-Source: AGHT+IGp/jNJTmdaFQ6E6rKRxd5mOl5DWkdNmDAnwmLFHgFS6wCHCx0RvANhN0Zro7KAfaQqmMGFCA==
X-Received: by 2002:a05:6000:1a86:b0:385:ef8e:a652 with SMTP id ffacd0b85a97d-385fd43c331mr9424928f8f.56.1733379739965;
        Wed, 04 Dec 2024 22:22:19 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52732casm49399175e9.13.2024.12.04.22.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 22:22:19 -0800 (PST)
Message-ID: <2a20b243ade39fa240f75baf22a13f02239e3411.camel@linaro.org>
Subject: Re: [PATCH 2/4] dt-bindings: power: supply: add max77759-fg flavor
 and don't require nvme address
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Thomas Antoine <t.antoine@uclouvain.be>, Sebastian Reichel
 <sre@kernel.org>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,  Dimitri Fedrau
 <dima.fedrau@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>,  Peter Griffin <peter.griffin@linaro.org>, Alim
 Akhtar <alim.akhtar@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Date: Thu, 05 Dec 2024 06:22:18 +0000
In-Reply-To: <5281f86d-6917-4f4e-b85d-70502a24c5bd@uclouvain.be>
References: <20241202-b4-gs101_max77759_fg-v1-0-98d2fa7bfe30@uclouvain.be>
	 <20241202-b4-gs101_max77759_fg-v1-2-98d2fa7bfe30@uclouvain.be>
	 <e23721ebd766f410103ddfb8705f3d7d6e5ae3e9.camel@linaro.org>
	 <575b3275-b2fa-4e5c-bb6b-759394b02e18@uclouvain.be>
	 <30b0995903fb7db3f866d1304783d878f563fe2f.camel@linaro.org>
	 <5281f86d-6917-4f4e-b85d-70502a24c5bd@uclouvain.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1-4 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-12-04 at 14:13 +0100, Thomas Antoine wrote:
> On 12/3/24 11:40, Andr=C3=A9 Draszik wrote:
> > On Tue, 2024-12-03 at 11:23 +0100, Thomas Antoine wrote:
> > > On 12/3/24 08:12, Andr=C3=A9 Draszik wrote:
> > > > On Mon, 2024-12-02 at 14:07 +0100, Thomas Antoine via B4 Relay wrot=
e:
> > > > > From: Thomas Antoine <t.antoine@uclouvain.be>
> > > > >=20
> > > > > As the Maxim max77759 fuel gauge has no non-volatile memory slave=
 address,
> > > > > make it non-obligatory. Except for this, the max77759 seems to be=
have the
> > > > > same as the max1720x.
> > > >=20
> > > > What about the battery characterization tables? Aren't they needed =
for
> > > > correct reporting?

[...]

> >=20
> I looked into it. The probe function launches a delay work
> max1720x_model_work which will try multiple times to run
> max1720x_model_load which leads to
> max_m5_load_gauge_model -> max_m5_update_custom_model
>=20
> This last function writes 0x0059 to 0x62 and 0x00c4 to 0x63 which unlocks
> the addresses from 0x80 to 0xaf.

OK. The regmap I had proposed was excluding those based on the
datasheet I have, but you probably noticed.

[...]

> If it is indeed the case and that all of those are equivalent to their
> max1720x counterpart, I think the management of those values should be
> added in another patch which implements it for both the max1720x (and pos=
sibly the
> max77759) as the mainline driver does not do anything with those values
> currently.

Thanks for the analysis! And yes, I agree.

Adding new required properties to a DT binding is an ABI break,
therefore I was trying to ensure the binding is complete from
the start.

Cheers,
Andre'


