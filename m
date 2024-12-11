Return-Path: <linux-pm+bounces-18994-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D23C39EC939
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 10:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CD34282F15
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 09:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B6F1C1AB1;
	Wed, 11 Dec 2024 09:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MiExNU8d"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D4D1A841C;
	Wed, 11 Dec 2024 09:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733909751; cv=none; b=hYFdhxMffK64bkb6RdPjt0uzQ4jP95dPV+jfuPSpVUm8ZgtFSi/nO2doCEwS3xNao/eN7Hk+neNhVRdGTXtpHGz1hxoV/zWc/BN1c0LJU0ylwMxu3SL+NmmqEsYMtbpmvGG40y2LQhjZuY6Ta6kgpnREhChS1L/NExhzJg1fMIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733909751; c=relaxed/simple;
	bh=iLFw43OnoXzWnqMuVnmSTPFH2Xr7CNIIsPaMJUmIUvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBkA8ujWQjj8yLyciaRw8R7jidzAuDo1rUKY24VQzVfrqfI2zbOvuQBm+nls/ViWzyZ8T3sT0Zs0MYzE5mMQQYYOg979leOUvnAoub5CZK0pzDjYgHFYpyveRiGjW92+DaTDTP2mlHG9L8l/VZGsW2SGTrwCmIXhWBdacjmS954=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MiExNU8d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF4F2C4CED2;
	Wed, 11 Dec 2024 09:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733909750;
	bh=iLFw43OnoXzWnqMuVnmSTPFH2Xr7CNIIsPaMJUmIUvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MiExNU8dJp4RuFxEc6MEegk5hw5t8sC9v94SeKS6W+/wpBfA9L2Aly+iaIPeqxFau
	 RXvplC/NV4cZiaziOrSA3lnbM7NPL9J4E2p/ze9McR1CTnYrnUcAQjlYWv/WygOdbS
	 ULZupA2+6BZbQJHsXjZdPaJ7onl+0T+HHT8xvx5S/aVMpUALQTZFO65BlTCGhRAwpl
	 M+27eShzZhiz0fXXksV11LS+GbKSZA1pAqtUW8p4LBL53YpCIEIA+pXLsXwA24Z4vo
	 rZn8PLGuHWXPcaA7Hk2yXjEmHhXEtvJyP8Dj32CpFPVwcxTCP+ALV2/fp/mpEfjadi
	 xQVcJdYH+1w5w==
Date: Wed, 11 Dec 2024 10:35:47 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Pengfei Li <pengfei.li_1@nxp.com>, Marco Felsch <m.felsch@pengutronix.de>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: thermal: fsl,imx91-tmu: add bindings
 for NXP i.MX91 thermal module
Message-ID: <u2y3owsp442geue2knfhnx4zhrzefmky6bl47nxaaqhw7dhpb3@vkc6z7c5hwv2>
References: <20241210-imx91tmu-v2-0-5032aad4d88e@nxp.com>
 <20241210-imx91tmu-v2-1-5032aad4d88e@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241210-imx91tmu-v2-1-5032aad4d88e@nxp.com>

On Tue, Dec 10, 2024 at 04:27:02PM -0500, Frank Li wrote:
> +description:
> +  i.MX91 features a new temperature sensor. It includes programmable
> +  temperature threshold comparators for both normal and privileged
> +  accesses and allows a programmable measurement frequency for the
> +  Periodic One-Shot Measurement mode. Additionally, it provides
> +  status registers for indicating the end of measurement and threshold
> +  violation events.
> +

Missing ref to thermal-sensor.yaml

> +properties:
> +  compatible:
> +    items:
> +      - const: fsl,imx91-tmu
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  nvmem-cells:
> +    items:
> +      - description: Phandle to the trim control 1 provided by ocotp
> +      - description: Phandle to the trim control 2 provided by ocotp
> +
> +  nvmem-cell-names:
> +    items:
> +      - const: trim1
> +      - const: trim2
> +
> +  "#thermal-sensor-cells":
> +    enum: [0, 1]

Why this is flexible? How many sensors do you have there?

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - '#thermal-sensor-cells'

Use consistent quotes, either ' or "

> +
> +additionalProperties: false

This should be unevaluatedProperties: false after referencing mentioned
earlier thermal-sensor yaml

Best regards,
Krzysztof


