Return-Path: <linux-pm+bounces-15339-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAC7995024
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 15:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44FC8286428
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 13:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3181DF25C;
	Tue,  8 Oct 2024 13:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3ffvz4M"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB081DF24B;
	Tue,  8 Oct 2024 13:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728394337; cv=none; b=skEAmqL0sARiXI86jTbYX6MLWQKFBgBsSCeEoh4Ix/MKkOo+tbDw3z6wVe7mmi3TaKbOitTZAvHax4pQAkXAzDe0TfMxRY6LkONZrvv69k6sQsfckC2SygGJzEy0jvYbxY2jDxxE1YhQaAcKThAv0NWFQyOHYmr2nGuYSqC+jus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728394337; c=relaxed/simple;
	bh=m3Dqaue9iMHe36I/93iGbTtg5g0XsNP1DjGguFYsNxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTXGE8l/m7z+hjo1jPHVcvcnwRZ4K89LQBSkbDKqOAPclQGen4lxYsXdE/Axzz+f2O3v2z1lZYlBW39Ggj1sb4vp88NyUBpo+FTmieVyzO6St2tn4CHEIDW94lqxlA8iJ22jOyf9EBTYlWz/w6qZmiWuBknacFRlDPXjDq/NO7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3ffvz4M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D6CC4CEC7;
	Tue,  8 Oct 2024 13:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728394337;
	bh=m3Dqaue9iMHe36I/93iGbTtg5g0XsNP1DjGguFYsNxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n3ffvz4MdASGCADyFqcOUDV3RAoKJ0UC0IMNe+xmXbpkLs55+uR3st3mH2w+0QqAC
	 hUHLQrtNj2qlRYMakBl95BmzI+lL6m2y40hXK8ucPYmaJzgyaA1Yc/mpIFWZKBjp20
	 WyqPeVRSvEDKZkyu2TskwsveLVsVNmo0VqrB0cNRngMIFX0fKMp7p0k16vCWzLNWor
	 /PuXmwHHSDUdUGzMKvUJnEfA2BGYLvCbHn9ksdJ/dWY0C/0ZQskX39pusYBGtrIXzl
	 cLegrKJm+fmX/OVgHwztKx+d7ukPh+ZLN8NomG57k10SZcEm74PevVZVu8UXc1k+eF
	 iQRzPmLKmuNsg==
Date: Tue, 8 Oct 2024 15:32:14 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
	YiFeng Zhao <zyf@rock-chips.com>, Liang Chen <cl@rock-chips.com>, linux-scsi@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 2/5] dt-bindings: ufs: Document Rockchip UFS host
 controller
Message-ID: <pthhldiu7mus3ehk2yndro5npyqaqdenru53daz34gx7vrizlp@ub7lgvoyiq6a>
References: <1728368130-37213-1-git-send-email-shawn.lin@rock-chips.com>
 <1728368130-37213-3-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1728368130-37213-3-git-send-email-shawn.lin@rock-chips.com>

On Tue, Oct 08, 2024 at 02:15:27PM +0800, Shawn Lin wrote:
> Document Rockchip UFS host controller for RK3576 SoC.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> ---
> 
> Changes in v3:
> - rename the file to rockchip,rk3576-ufshc.yaml
> - add description for reset-gpios
> - use rockchip,rk3576-ufshc as compatible

... 

> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 4
> +
> +  reset-names:
> +    items:
> +      - const: biu
> +      - const: sys
> +      - const: ufs
> +      - const: grf
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: |
> +      GPIO specifiers for host to reset the device.

Redundant description. I don't get why did you add it.... maybe we were
confused by duplicating resets and GPIO, but then say here something
useful not what the property name is already saying.

E.g. Which pin is this? Active low/high? Resets which device - phy?
memory?

With proper description:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


