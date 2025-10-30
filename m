Return-Path: <linux-pm+bounces-37139-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 209D5C21FCF
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 20:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 040B03A4776
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 19:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0812F999A;
	Thu, 30 Oct 2025 19:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQeGbKb1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C082F4A06;
	Thu, 30 Oct 2025 19:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761853019; cv=none; b=I2VmFu6bY+b5aSZZUoBmHbKlGP2wTTd6i1ee2610yUGodvmzA6g3II5PLvu9YZEhyfWz5mnnff2ZfT6qJujdglYd5yCYynLConHxAfeaduNq5tK2b3WKU+Rwe7qJwoSvFeQR7/y4RCuci6zbK20r4dNx2eYios6a7IbqYRmFW1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761853019; c=relaxed/simple;
	bh=hU8kIQqXqh2RC+ap5a3ScOWDHPyItHVVbCRN+iRanSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r8EhCTgYPfD0EKBb2sfxREqwnd4ygGnyY8dw/wR2KIquaxKE8Xw8vyS4w6q5mLaJzqpjRxUi6cpHNhuMHdg6jcgWI0SdvAHsRURHEnBvHLW2rQqUD1Xk1wl8Qh9Lll8IB02HvOy/ckPOCdww3Wq/g5EUKzlxSfPyK53s4j2/5aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQeGbKb1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E85CC4CEF1;
	Thu, 30 Oct 2025 19:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761853018;
	bh=hU8kIQqXqh2RC+ap5a3ScOWDHPyItHVVbCRN+iRanSI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eQeGbKb15jG1AFdHRLlPy2zrAD0mCVbucZ1NArmVWPhcdslIRNb5ijKQSCJnSpPDP
	 TLuHezc+uDkx5FDyzFHq813fZZxW2wXZQ3/ySBol7KnbgYGZuJA13sJNic6EZHXQ1t
	 vlxsry3ug9k9vkzYvGCVoHnYNQOfbOUDP8gpp32JytTQTxjQlviu/PvorkruKIatEm
	 2PaHBSe4uf6n0dsDSSJrn4YZFqFa9I4L1fxCH7+JgFlE0KsLFLLjpw0izMhNJtFNsb
	 +oq5GkTY0SLZ8R3dqrqQp8XKoB6udYrmXLaiG61I1F2gcrZkkKoI2GC1ensKDHr1Y0
	 zAN4EMtviV8SQ==
Message-ID: <d7f57521-22d1-465e-a918-2a5c1ce5dc64@kernel.org>
Date: Thu, 30 Oct 2025 20:36:52 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RPi 4 deferred probe timeout of V3D PM domain
To: Stefan Wahren <wahrenst@gmx.net>, Mark Brown <broonie@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Melissa Wen <mwen@igalia.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Maxime Ripard <mripard@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Stephen Boyd
 <sboyd@kernel.org>, kernel-dev@igalia.com, kernel-list@raspberrypi.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 "open list:GENERIC PM DOMAINS" <linux-pm@vger.kernel.org>
References: <20251005113816.6721-1-wahrenst@gmx.net>
 <9ebda74e-e700-4fbe-bca5-382f92417a9c@sirena.org.uk>
 <a5e1e279-7e20-458d-a75f-787e0adbc9fe@gmx.net>
 <ad07546f-0c2d-4bc2-b794-755b892c7328@sirena.org.uk>
 <a016e7e1-09f7-4056-a855-6cfaa8d51962@gmx.net>
 <10a4ef77-0e70-4ef2-b1df-535b476d256d@sirena.org.uk>
 <ecd75fd5-3131-4d10-ae3d-b6f608d9622a@gmx.net>
 <25e500c2-3dc1-476c-b6c1-ac4098a0501d@sirena.org.uk>
 <d6b14388-e0ab-44f0-b4d9-78adf74c2a7f@gmx.net>
 <d88f6420-5013-4856-99d6-da28f79bd7a5@sirena.org.uk>
 <043f1702-52fc-4a83-82f7-683a26851623@gmx.net>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <043f1702-52fc-4a83-82f7-683a26851623@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 30/10/2025 20:13, Stefan Wahren wrote:
> Hi Ulf,
> 
> Am 30.10.25 um 13:59 schrieb Mark Brown:
>> On Wed, Oct 29, 2025 at 08:51:38PM +0100, Stefan Wahren wrote:
>>> Am 28.10.25 um 19:47 schrieb Mark Brown:
>>> Okay, here is my theory. The difference is about (boot) time. In my setup
>>> the whole device boot from SD card and in your case the kernel modules are
>>> stored via NFS.
>>> V3D requires two resources, a clock and a PM domain. Additionally the PM
>>> domain itself depends on the very same clock. In arm64/defconfig the
>>> relevant clock driver is build as module, but the PM domain driver is
>>> builtin.
>>> During boot "driver_deferred_probe_timeout" (10 s) expires before the clock
>>> driver could be loaded via NFS. So the PM domain core gave up:
>>> [   16.936547] v3d fec00000.gpu: deferred probe timeout, ignoring dependency
>>> So this breaks probing of V3D driver in this case.
>> That seems buggy on the part of the core, particularly since userspace
>> isn't there yet so we might be missing some filesystems - I would have
>> expected the device to probe once the supply becomes available.  But I
>> do agree with your analysis, it doesn't look like an issue with this
>> driver.
> recent changes to the Raspberry Pi 4 device tree revealed the issue for 
> the following corner case:
> V3D requires two resources, a clock and a PM domain. Additionally the PM 
> domain itself depends on the very same clock. In arm64/defconfig the 
> relevant clock driver clk-raspberrypi is build as module, but the PM 
> domain driver bcm2835-pmdomain is builtin.
> 
> During boot "driver_deferred_probe_timeout" (10 s) expires before the 
> clock driver could be loaded via NFS. So the PM domain core gave up:
> [   16.936547] v3d fec00000.gpu: deferred probe timeout, ignoring dependency

Core clock modules you should have as part of your initramfs, not rely
on rootfs to load. You can also move the domain to module, but it still
won't solve the problem of lack of initramfs population.

Best regards,
Krzysztof

