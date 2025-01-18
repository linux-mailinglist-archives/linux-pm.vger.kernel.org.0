Return-Path: <linux-pm+bounces-20648-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCBDA15DF3
	for <lists+linux-pm@lfdr.de>; Sat, 18 Jan 2025 17:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9496E7A3990
	for <lists+linux-pm@lfdr.de>; Sat, 18 Jan 2025 16:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BFD19D88B;
	Sat, 18 Jan 2025 16:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cywys806"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F9E199E9A;
	Sat, 18 Jan 2025 16:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737216737; cv=none; b=e1KlbBS03E1RC6YXMe7tKRJGfVIueUfiAwuwTLhfW4JF1RTxNUfs0K0TICQ46xprrwbYoh5z1humtMFnarr1H4LKtCjtXj61nLtaSx0wLB2nBCjnVqZls/9gbmXO/IYguJvN9kgGjQe9gWiO9HJjt4bFUxE7epBu3NvCF+1rZlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737216737; c=relaxed/simple;
	bh=wz6R80GCtHE8Pub+JlZqdRoqRWL7RgSMjrqENer31tI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+KGGRC7cLYHWZLTbOSC7JvBiD8MPfb6TJ38sJfA5HcXyyuHPtpSLg4BKhpd4MaYZOuPEHKLa4ufGq51Wxb31rx54fj8ND8BHgZkK1Td+wjTZJk2cweqYenv6jMpavkp0I986pvMVMGdNs5aXt4843o0dRFn+U/wFQQWaB17Bw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cywys806; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F195C4CED1;
	Sat, 18 Jan 2025 16:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737216737;
	bh=wz6R80GCtHE8Pub+JlZqdRoqRWL7RgSMjrqENer31tI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cywys806iFznKs1sz/lxDrbd2Vh8/1EkGHH9NWDEC4vVJv2QxztmgBwrSX14wB4+L
	 HzmiX0+pTh2OteReMNdIhfMx5lkoBxxzPhtqDHRd9VtSm3ZDvOjkQbaG4WfaigBd/T
	 TUqhXbHH2s3wIoorT4NsyW7dtjtJTiDvSdYZEj8/hCqIOw/yfROcmBdZXi3PDTg1Sp
	 OcQcQiMgL6yPXY98a7FNm9RCEQaznSoL3l/imyef4vGggy6SL5FcAx6iyTr91ud2iN
	 5to1fwqAVCZSiOHK7WrGjcXHUayGMWZKEK7M7GTyB9csuWeNZtiYRzZJ7vMCZOJ4cM
	 FL1j8mIbugZag==
Date: Sat, 18 Jan 2025 17:12:13 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-kernel@vger.kernel.org, Markus Mayer <mmayer@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:BROADCOM STB AVS TMON DRIVER" <linux-pm@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/2] dt-bindings: thermal: Update for BCM74110
Message-ID: <20250118-mauve-panther-of-upgrade-1ee500@krzk-bin>
References: <20250116193842.758788-1-florian.fainelli@broadcom.com>
 <20250116193842.758788-2-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250116193842.758788-2-florian.fainelli@broadcom.com>

On Thu, Jan 16, 2025 at 11:38:41AM -0800, Florian Fainelli wrote:
> Update the binding with the BCM74110 compatible string which denotes the
> first device we need to support in a different process node requiring an
> updated thermal equation.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  Documentation/devicetree/bindings/thermal/brcm,avs-tmon.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


