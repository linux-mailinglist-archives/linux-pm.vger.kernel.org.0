Return-Path: <linux-pm+bounces-19412-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B31589F601F
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 09:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6F9616D783
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 08:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD803176228;
	Wed, 18 Dec 2024 08:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kj83UXCR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A288F4317E;
	Wed, 18 Dec 2024 08:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734510496; cv=none; b=R3YEq8lA4Ci1lWdZYyag3hSr4AYwC7Pp6xbq44my6vUggLGBV5Tp/AUxt3qUXSNdDHOkIZ+S30YpL2YbCCyEtXmZ3b1kF+n15F7MMqFhJNkn0PjVLYUyMsY8/vtMXetJTxji+mTVB8ecQAF0GmWIxZeN61MAKaAvbV28+yP2Hj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734510496; c=relaxed/simple;
	bh=CsY+ALDMecc5Y7Al1rY01JAbl+nL6+nkWBZjGrMZ8iQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6EFRusHbw0yxZmuDdvXaYJ/9/Ull5RFqTAlN0M0sST8cWNPu7YXD/PM+U5A4n02cy3cJtO/E20lp6WuAMGzVmNNZrxrNb+YUNtNHFh5kr6xD76RmKlk1mFCYGnoZBiQfsKG3OOXI/0PjfVjKmz76Fo9bIRvLrt3IGPNEoU8N/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kj83UXCR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B41C4CECE;
	Wed, 18 Dec 2024 08:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734510496;
	bh=CsY+ALDMecc5Y7Al1rY01JAbl+nL6+nkWBZjGrMZ8iQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kj83UXCRuAYrcShm4ohxzm86FHdKSZSWAqJWrO7kE2oARUaySr9ZvZJi2xNHkAo98
	 JygsO3OJIewM84I+jyY12JTs27Ukh5OKP+ufEnmo/28TgNS1x2Cm5GR5FZF6fHX07A
	 qt/Htfa5x2At5zevaeVVWGpZWo5VaPgNFlJR8qgOSATLDVmUBpV8cqu0T7aRHQXX6n
	 ViGqznR+F7l3vuvqIiuBRAxWlxYv2FA0j7cr1TH40JvFScQ1ZEIR6kn40jJsvOrE+5
	 kmQyLJ+Ifnnuw8SsOvmhBKGYeYG1FKkeJuSOHCGaxiZdZyFjvS+RCSKuJo1LR7R0ER
	 SbaF4VMWVbw/Q==
Date: Wed, 18 Dec 2024 09:28:12 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Pavel Machek <pavel@ucw.cz>, Hans de Goede <hdegoede@redhat.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
	Purism Kernel Team <kernel@puri.sm>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v12 02/11] dt-bindings: power: supply: max17042: split on
 2 files
Message-ID: <vunx3s4wqw5fqtwuuuuofjtja7buh5zpxi3iznzgfl4iz7fm4d@wlxbzrnlu7fr>
References: <20241217-starqltechn_integration_upstream-v12-0-ed840944f948@gmail.com>
 <20241217-starqltechn_integration_upstream-v12-2-ed840944f948@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241217-starqltechn_integration_upstream-v12-2-ed840944f948@gmail.com>

On Tue, Dec 17, 2024 at 08:30:00PM +0300, Dzmitry Sankouski wrote:
> Move max17042 common binding part to separate file, to
> reuse it for MFDs with platform driver version.
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> 
> Changes on v12:

Malformed patch.

> - add addtionalProperties: true on common file
> - rename *-base file to *-common
> - remove compatibles from shared shema
> - move required properties to final schema
> - remove max77705 compatible from binding - it will be used in
>   mfd77705 binding

Sorry, all this is somehow complicated effort of not calling the fuel
gauge what it really is: separate device with its own I2C address, just
like all previous designs in that family from Maxim.

I keep repeating this and you keep going that way, maybe because it fits
your drivers, but that's not the way.

Best regards,
Krzysztof


