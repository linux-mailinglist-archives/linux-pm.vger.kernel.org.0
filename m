Return-Path: <linux-pm+bounces-35840-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFB1BC91FA
	for <lists+linux-pm@lfdr.de>; Thu, 09 Oct 2025 14:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B4E2188E642
	for <lists+linux-pm@lfdr.de>; Thu,  9 Oct 2025 12:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6AA2E3373;
	Thu,  9 Oct 2025 12:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBbbOCLu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A5423C505;
	Thu,  9 Oct 2025 12:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760014322; cv=none; b=FewtsYwEVf+lB22kCCIPsLXgnfKwsFFvSWvbMJYV+Lmviuv/8+SRL5p9+FH7OUz+7JSQWEHm/liVhFPjAvyX+ZbuzvcX/3DmNWZeT2yAEhAP+/Nz9I28+CHcMMH6guafwORczWi8WWlUmKd1KZ55t/1xJIRKtM8h240WKiS9bis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760014322; c=relaxed/simple;
	bh=AVIp+jMYzxaeQL2X5j0m3um+EbwGIdcZQgDXBd6gbp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlBhdWgRTvHcOST7HOIo8ADiLHeUD2e5M11eDfgQ9TrITerjCfP2jCcKzKoHyA9eULXbZXMvnFKT+UqfFEFCypGOs8L/pPMUQUic7+x3VgQw7xJR/dwE5mhI7oxgyVBVyUkFAe0GJLW6zishwlpt2rijhF6SacSFaYhElWRLg5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBbbOCLu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A780BC4CEE7;
	Thu,  9 Oct 2025 12:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760014322;
	bh=AVIp+jMYzxaeQL2X5j0m3um+EbwGIdcZQgDXBd6gbp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XBbbOCLu3oW5xZbEYzEgu1/eoKRz0rV9BnC8X45E7wZOwC2bKbYf708BuxKK/CIJY
	 eHXlQ3jC+erSYmS8wIIGVnsYhcx0BoS4oc245XXU6f67/sLgDODcix1xHCZip2WMEh
	 UNsLGabGTJw9vVZEH6EojIII3RvMHBuwV4m6XTvbKOWrxMw+K43j3Jj/lrOcXg1rqH
	 BqDbuV9PhoOunbbGVHZzDIgSowJkpDvYynk7dTCG8ixK4+wkj7xjO3Gckmjv6YXjkB
	 bCZaXeFm9VRU6PPIcrhghm0z0v0jc0Vl2uigBWXQGo7oC0fO3H0c0v7sJY25me4vGr
	 aQZ4+6bolRPCA==
Date: Thu, 9 Oct 2025 13:51:55 +0100
From: Lee Jones <lee@kernel.org>
To: samuel.kayode@savoirfairelinux.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, Frank Li <Frank.li@nxp.com>,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org, Abel Vesa <abelvesa@kernel.org>,
	Abel Vesa <abelvesa@linux.com>, Robin Gong <b38343@freescale.com>,
	Robin Gong <yibin.gong@nxp.com>,
	Enric Balletbo i Serra <eballetbo@gmail.com>,
	Sean Nyekjaer <sean@geanix.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v12 0/6] add support for pf1550 PMIC MFD-based drivers
Message-ID: <20251009125155.GE2796410@google.com>
References: <20251001-pf1550-v12-0-a3302aa41687@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251001-pf1550-v12-0-a3302aa41687@savoirfairelinux.com>

On Wed, 01 Oct 2025, Samuel Kayode via B4 Relay wrote:

> This series adds support for pf1550 PMIC. It provides the core driver and
> sub-drivers for the regulator, power supply and input subsystems.

Note to self: Everything is in order.  Apply to an IB once -rc1 is out.

-- 
Lee Jones [李琼斯]

