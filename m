Return-Path: <linux-pm+bounces-37305-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B329BC2D1A4
	for <lists+linux-pm@lfdr.de>; Mon, 03 Nov 2025 17:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47BAC189562C
	for <lists+linux-pm@lfdr.de>; Mon,  3 Nov 2025 16:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6003191D3;
	Mon,  3 Nov 2025 16:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="NOI08/Hj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10A031DD99;
	Mon,  3 Nov 2025 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762186818; cv=none; b=dQYIh9UYCkMUBpmZWVOLbsRA/ffL8L/sPMCcjNrFtNuut8d2cpJeVpnyNrkBs485Mb0JPpgZgSePCvuJ6xPriFp8lhxQfFs7mpWtTlc6D19aCnAESACDd7IesNwuDkuHBSWT/yZ36EnuhEJoKT1Fz2aDfZ4vUG5Mkn307XAL87M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762186818; c=relaxed/simple;
	bh=RxnzT6MDNu6xaMxu3F1Q8cBBjNRBmAKRhhu8JsfkkHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MTIc3ZQr6JE1s5CAhwXgqhTAS/iIYoyofnU4HdC5YWaY3cQBDCNjIptuB7jKxs5IWsas9sAZSZ9Cf1/hETPvyCqVVEdlvylrt/FCyWdHMJEVrm4WNVbe0gSylishzkdjcIa8lTvbDRVVOoQ1r1hWJoxMNW9z6ODMqxCingX2wY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=NOI08/Hj; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1762186790; x=1762791590; i=wahrenst@gmx.net;
	bh=RxnzT6MDNu6xaMxu3F1Q8cBBjNRBmAKRhhu8JsfkkHI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=NOI08/HjrNKbFD39ht7utILbpPpnRKZh3cW5+XZFmQumZAKBFdTPQWULqqzC6M7d
	 FnA8DPmLVWRVGQVGaTnLTQSn8EBlIUF3Z0m6z8v/r1jXnaQAhREX6sFextOZbIrUz
	 tXQqZio3LUYJoKkwDKkngcxNdQGYMxO0hY5gtczjxHwkIifa4ONNu/qcqn1w3TgW3
	 Paql7tfzxEFeofPiofL1rub6+zkvZMMY0boXCMD/HhKYrlJbOvYwQJQkb/zKK/gxY
	 WxPOmdLzXre/Csqx1xrLRZh2KFTi3gy9iM8TQvJ035V1SeCL8Dll4N9+o9BHCyT7c
	 5VyPoffJWz5/OJsnjQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.156] ([91.41.217.223]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5fIQ-1vIh6y1z4s-001CVD; Mon, 03
 Nov 2025 17:19:50 +0100
Message-ID: <6de1bcfa-a924-4172-81ec-0384d7360014@gmx.net>
Date: Mon, 3 Nov 2025 17:19:48 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RPi 4 deferred probe timeout of V3D PM domain
To: Mark Brown <broonie@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Melissa Wen <mwen@igalia.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 kernel-dev@igalia.com, kernel-list@raspberrypi.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 "open list:GENERIC PM DOMAINS" <linux-pm@vger.kernel.org>
References: <10a4ef77-0e70-4ef2-b1df-535b476d256d@sirena.org.uk>
 <ecd75fd5-3131-4d10-ae3d-b6f608d9622a@gmx.net>
 <25e500c2-3dc1-476c-b6c1-ac4098a0501d@sirena.org.uk>
 <d6b14388-e0ab-44f0-b4d9-78adf74c2a7f@gmx.net>
 <d88f6420-5013-4856-99d6-da28f79bd7a5@sirena.org.uk>
 <CGME20251030191426eucas1p29ce063b538b60e4a998bcd32f925267c@eucas1p2.samsung.com>
 <043f1702-52fc-4a83-82f7-683a26851623@gmx.net>
 <b02c8890-4568-4afe-8628-10b77e79bf44@samsung.com>
 <3c171b6b-f8f5-4192-a3a3-da453a900316@sirena.org.uk>
 <aff4e3de-6dde-475b-9df0-3d7d6ad5d740@samsung.com>
 <77bbe008-427b-4491-a191-15be5e40e708@sirena.org.uk>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <77bbe008-427b-4491-a191-15be5e40e708@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GSZCYLeBwwQ1q4+BR102xGRkjcHoh7FKy0bdyzvFEbYzjFUI7Kc
 MZyz9fRszdnbPcWpHlfWbPmH/nGwvm7+sLrtYx/V5kRCHx+YLheulNbC6GRFuN/mqJWhfzm
 8IQMkGqXvlZ+t/3pcILTJj+kFv4keqd0XQK76cMNhy1cgeMsOai2hjeYJfNdIdVgHgJIwVB
 9BiifTnz6+xXeze33QKSw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:I6VEA0ye/s4=;aJOD8vNMqM4O8hcNv2lWtWQ0b9j
 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
 ScC2ET3HPpjUqjliYSSNyE3L20=

Am 31.10.25 um 15:37 schrieb Mark Brown:
> On Fri, Oct 31, 2025 at 02:54:15PM +0100, Marek Szyprowski wrote:
>> On 31.10.2025 13:39, Mark Brown wrote:
>>> Or the GPU driver should be moved to a module to match the clock.
>> V3D already is being built as a module in ARM64's defconfig. The proble=
m
>> is in CONFIG_BCM2835_POWER driver (defaults to 'y'), which depends on
>> resources provided by CONFIG_CLK_RASPBERRYPI (defaults to 'm'). IMHO
>> both of them should be built-in and this will solve this issue.
> Ah, yes so it is - I agree.
If no one objects, I would prepare a corresponding patch for=20
arm64/defconfig.

Best regards

