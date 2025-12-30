Return-Path: <linux-pm+bounces-40042-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DB2CE989E
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 12:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D71E3019B7F
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 11:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229961EBFE0;
	Tue, 30 Dec 2025 11:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJoVs731"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4790322A;
	Tue, 30 Dec 2025 11:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767094352; cv=none; b=G8L3IgXAE1Bzzrxl2omKbdmlDOS/lJ3Ymc5GDq8oHVQ1dGVlHtOTbxsUoxuK5d9ZjM3yVixK/K++jTrfKMBDQtg6EGe6jkbWn5gErKH4QGJA3KbhoArqAUeGkCBUvMMb7ytOOmhbIjK8zolYj2+NUaaQlgcNc52hTqfwKa+Nz4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767094352; c=relaxed/simple;
	bh=1wH3ZPxPRehzt76eXsHKSmF14QWef8nqajbMpVN7FTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzhlwhjgvutdFbkc6u2crA/YWfXMyLjIdHLcyWPgy24hmPCWlSwcZyP2RwQzP2uC8kn7dP4jjXnJtBitIZfDb3mOQcdkP2u0blWnbSme3HXNiwk8t1XUqwSYmBGILFBExW9RjOp273kMkciTN5mhtZp6+eXrL2URTEQXwoWVUO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJoVs731; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40BCCC4CEFB;
	Tue, 30 Dec 2025 11:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767094351;
	bh=1wH3ZPxPRehzt76eXsHKSmF14QWef8nqajbMpVN7FTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fJoVs731GixdCVTUbjmkQfw5Lom+AtRheYjXhRYYzis8E8Xo/4Ko8stdzG/yjG4ez
	 XMpXvpsvlrka/pjpmYNysfd5B6InMlFl9AKY4NUdeBXFKdN9zHlJ0yfwmu564u7VCA
	 J1dvjoUgfoSMVXQ2zsV61b/gOtz4SolDmpKEnC+RwEHtSlT0fF4kDDoU/pt+W+O45y
	 snXYpfz0Km3MUVLamraTR2M50QiOIoRvJCzyJ3/ufBkTkc4JaKS+WWSccKYp5uHEzS
	 bvfzFI+gOemVmxo9Y0XNxOmCjV4v6yMQHzpNdGeruNZOoiwVQBgTnuD9+LaPcLG0vH
	 GlamK/hBL75Xw==
Date: Tue, 30 Dec 2025 12:32:29 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Josua Mayer <josua.mayer@jm0.eu>
Cc: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Andreas Kemnade <andreas@kemnade.info>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	Josua Mayer <josua@solid-run.com>
Subject: Re: [PATCH 2/3] dt-bindings: mfd: netronix,ntxec: add reference to
 power-supply
Message-ID: <20251230-defiant-frisky-bull-95ecd0@quoll>
References: <20251227-kobo-aura-battery-v1-0-328a90ef5122@jm0.eu>
 <20251227-kobo-aura-battery-v1-2-328a90ef5122@jm0.eu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251227-kobo-aura-battery-v1-2-328a90ef5122@jm0.eu>

On Sat, Dec 27, 2025 at 05:28:14PM +0100, Josua Mayer wrote:
> The Netronix Embedded Controller supports monitoring of battery voltage.
> 
> Voltage monitoring functionality is self-contained and requires no
> supply- or battery-specific runtime configuration.
> 
> Battery design characteristics (e.g. voltage-min-design-microvolt) are
> useful for users to understand the charge level and are commonly
> provided by a separate battery node linked with monitored-battery
> property.
> 
> Add reference to power-supply.yaml so that power-supplies and
> monitored-battery properties become available.
> 
> Further drop reg property description and replace it with maxItems 1 as
> is common for i2c devices with single bus address.
> 
> Finally replace additionalProperties with unevaluatedProperties to
> allow properties from referenced schemas.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>

This does not match From address. Please use consistent identities for
both.

Best regards,
Krzysztof


