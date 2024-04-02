Return-Path: <linux-pm+bounces-5817-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DEB8959B1
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 18:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3263B2A839
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 16:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6827114AD34;
	Tue,  2 Apr 2024 16:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqv3ImhL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE9014AD1D;
	Tue,  2 Apr 2024 16:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712075010; cv=none; b=exfF58fiUPRmKOcCOPhMJCLXxO0DaRXQ8SFzWBIOWsYwnsgJBdImL0KcIFzN/7HiQE+NqmeqCMdarBopgq1PfGBGooo+aa8LbSmXp1T5xaRKHslVL4NNogpAdDSXn+LmT9i4GIYaXtUmjbqGl1tXwcnCZyti9o8cKjop5zOw47o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712075010; c=relaxed/simple;
	bh=xYB/qZ9RTNhXxTESYZVU46lsLKaPjJLvUgmdS58ycBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fB9x95IvjGoskoRTZevpSs6MolCxisYAMhsbCo7CGa1ObcSOZv7rf5iMEI2KSTFbD8gAzxmkXYfhEf6odBCLum+Su09mtpxkXcNHcUc4sqI8i6GhlxvGDdvFFJxfgdsAt7gPdxDczxzXSGpj0tOU4jOzZlSYFJWDjkw/Yciebm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqv3ImhL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A32B4C433F1;
	Tue,  2 Apr 2024 16:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712075009;
	bh=xYB/qZ9RTNhXxTESYZVU46lsLKaPjJLvUgmdS58ycBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aqv3ImhLq1PgJ337brrNrEBxR9qJmf0FXnJXgOwaUAud1wrbeWwQovWfLmtSArZ2+
	 VbM4zi4pse5vhiYygB9CjlyJJ0mHVFk+wigK7NKMAwIqWhy34Preatizf9IbJsoMuM
	 NrTu9SiLT+m+NLCX+TDYDzYVRGoscwGHlIwN/NjkJhthUtEHu7YP5s5akZtTH8DkoO
	 g/JZd0YhqkZnUdgbzcOApXE+eHPjirScuH2VQdLL6SbWCjb0qCyl1Rg0a/3O3wod3O
	 pUcayin0xsm6XXbBOtuir9EqntzT4Fe7UBt2Du9k6n/vvs5Enh70tHTxHj+5wNUwW+
	 LI52eLRN3Y+tg==
Date: Tue, 2 Apr 2024 11:23:27 -0500
From: Rob Herring <robh@kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 12/15] dt-bindings: thermal: mediatek: Add LVTS
 thermal controller definition for MT8188
Message-ID: <171207500517.249957.12484282062174711386.robh@kernel.org>
References: <20240402032729.2736685-1-nico@fluxnic.net>
 <20240402032729.2736685-13-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402032729.2736685-13-nico@fluxnic.net>


On Mon, 01 Apr 2024 23:25:46 -0400, Nicolas Pitre wrote:
> From: Nicolas Pitre <npitre@baylibre.com>
> 
> Add LVTS thermal controller definition for MT8188.
> 
> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> ---
>  .../bindings/thermal/mediatek,lvts-thermal.yaml  |  4 ++++
>  .../dt-bindings/thermal/mediatek,lvts-thermal.h  | 16 ++++++++++++++++
>  2 files changed, 20 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


