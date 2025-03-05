Return-Path: <linux-pm+bounces-23467-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F58A4F7C2
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 08:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6370E16F544
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 07:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F97A1E7C24;
	Wed,  5 Mar 2025 07:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUiAhT7q"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9691DB34C;
	Wed,  5 Mar 2025 07:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741159048; cv=none; b=ASBiZgp6fNxLNwvV1Lcdcao6c8JxSEjgg6IS38YXXNX9E4bUEY3ZRtedgOITpfnVc0Da8p5dK1Q+EnVvY9pqNRVysxFh4K83WGeux96EuqMqcTLvMIFJhdivJBvR81E8cgffrZO4g2jJLhEZCoSYe1TKJkcqRx8Ip9YzWxpsoxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741159048; c=relaxed/simple;
	bh=Yy85xq8NIgFIUxeo+qTOi/d7W9oIiEseG9gB1XAQxeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYGShBgRQ6R2wTvzWZILGWUWmWMTqD9QxnCCfH94HPPkd3r6whHQdu3LS8/ZQ97nwwIy0ZgcoIwK5VksFJI/LoBjuqbgD+xRBYZcrb5hOLVcO5SzmxQ3jLcoWxsioCt/d8LRqo2X14RpnMA15PMp40Af5x57HZFL70j46t3S3A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUiAhT7q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A394DC4CEE8;
	Wed,  5 Mar 2025 07:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741159047;
	bh=Yy85xq8NIgFIUxeo+qTOi/d7W9oIiEseG9gB1XAQxeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kUiAhT7qJHIBOlUA9LQIqE7zQPWhNsl3vdLD8qp/zR2d+AQgbUNdX/HpsePBWObEK
	 1UhdBPAet5nW/Xquhte+SwXcZjcRMIN2S9EgmhpMGFrjFgjY3eLhqTSk07idrXo3aW
	 l7BoyPnkrf5wIYCPl/fh/JrW/XG3ruf+IOKj0ziBI7mwH2BumfjIZwE5kUCBL4NqeG
	 JX2BDaMIyXwSwPTDm+q70J3eF1TRgxw7soxYxgU3d767Bu5sN/nWO03p79pPVgEYzF
	 dRCNceR2+imFbmYxQfVluGzhcJpD9hIK3FC+qcCAwuYN255LVSet1Ir4VFs6XA3kPu
	 f9i9If8u8VUvg==
Date: Wed, 5 Mar 2025 08:17:23 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux@ew.tq-group.com, 
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 3/6] pmdomain: imx93-blk-ctrl: Scan subnodes and bind
 drivers to them
Message-ID: <20250305-keen-shaggy-bullfinch-fc77fd@krzk-bin>
References: <20250304154929.1785200-1-alexander.stein@ew.tq-group.com>
 <20250304154929.1785200-4-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250304154929.1785200-4-alexander.stein@ew.tq-group.com>

On Tue, Mar 04, 2025 at 04:49:22PM +0100, Alexander Stein wrote:
> +#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
> @@ -297,8 +298,14 @@ static int imx93_blk_ctrl_probe(struct platform_device *pdev)
>  
>  	dev_set_drvdata(dev, bc);
>  
> +	ret = devm_of_platform_populate(dev);

This means in remove() you will depopulate in different order than error
path (e.g. after genpd removal). This is rather unexpected - remove()
should be cleaning up in exactly reversed order of probe. Not sure if it
can lead to any issues, but usual recommendation is that you either use
devm() or not.

Best regards,
Krzysztof


