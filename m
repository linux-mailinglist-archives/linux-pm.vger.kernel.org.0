Return-Path: <linux-pm+bounces-15043-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E72E198CCD2
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 08:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24B941C2122D
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 06:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D74839E4;
	Wed,  2 Oct 2024 06:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnygEbgB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0991FA4;
	Wed,  2 Oct 2024 06:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727848806; cv=none; b=caqSdRI9w8b5oduII6C11pISDJr9O8Oa/PS+8L6Vb/rKQ4O+zOWc4vIYhTjZgzJEi178MkOZLGESvHDxbxQBo0acaXW5rke/m9z7XawPvNGT5n+8bu3cgI8zG2lFMsEDDTYSc9fB1+CW2J4lc+m3nOPXpfOtPtOPMcLEO4njT9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727848806; c=relaxed/simple;
	bh=YmyRultSw5BRCdfX+vz1b1pAJmjxiqHaXaUw3Qf4NSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCaho7zs9LMsNJxI1tpEvWl5O8kFOrNZH0eueG0N8YhmzoUqlP6QHEDIzWyVFZBMBN/QkXSZ2WvwLCMyFqAv065VGgc0tl/86MprVenEjv7jcS7Jo2fYFSrVh7nNby+3w6MnKisVQ1R8vYpyKfYiSRTnjO200GXdzX7c4wG0BGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnygEbgB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9E7C4CEC5;
	Wed,  2 Oct 2024 06:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727848805;
	bh=YmyRultSw5BRCdfX+vz1b1pAJmjxiqHaXaUw3Qf4NSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FnygEbgBOmOpwEinItg2k89GczU0li+e5cDqzUx0juIPwCOpo9zMzARiKnT0wWgrg
	 t7CrdqVnrWN8eUczeo2f9Q4bonF2DTIxJjh2pxFT5XWFf3H2pOTo5q8p6JVMIYyF+q
	 3KWl0qK7t+eBG6FQmmoKrnJdkMJlT74K94xbphT4g5BlJNo8Pzba2Iwcl3AZDjX5EQ
	 7PVUUd3IPDAq/gvLuqCgSrjVaxQtU1sc5s9aFK5tT2vGucGpaCJTmxQYbWiXjetDdD
	 FnLqKkOSI0bW9u5GJhpfgFU+RXVf5QnosvKM4paCn8LtzyEylmcUhBANelRKlT8+UL
	 ONgPRpshQ92Eg==
Date: Wed, 2 Oct 2024 08:00:01 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-sound@vger.kernel.org, 
	Alexandre Mergnat <amergnat@baylibre.com>, Bear Wang <bear.wang@mediatek.com>, 
	Pablo Sun <pablo.sun@mediatek.com>, Macpaul Lin <macpaul@gmail.com>, 
	Chris-qj chen <chris-qj.chen@mediatek.com>, 
	MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v8 3/3] dt-bindings: mfd: mediatek: mt6397: Convert to DT
 schema format
Message-ID: <5nvshurbpmjkqysphfrfxhekq3c6od6a2uqai4rfxns64mdvf7@ftjvgjnivr3k>
References: <20241001104145.24054-1-macpaul.lin@mediatek.com>
 <20241001104145.24054-3-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241001104145.24054-3-macpaul.lin@mediatek.com>

On Tue, Oct 01, 2024 at 06:41:45PM +0800, Macpaul Lin wrote:
> Convert the mfd: mediatek: mt6397 binding to DT schema format.
> 
> MT6323, MT6358, and MT6397 are PMIC devices with multiple function
> subdevices. They share a common PMIC design but have variations in
> subdevice combinations.
> 
> Key updates in this conversion:
> 
> 1. RTC:
>    - Convert rtc-mt6397.txt and merge into parent MT6397 PMIC DT schema.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


