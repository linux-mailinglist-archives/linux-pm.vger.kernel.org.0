Return-Path: <linux-pm+bounces-22517-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD742A3CCFD
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 00:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1A361898C7F
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 23:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61AE25D52A;
	Wed, 19 Feb 2025 23:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dw8pTKvu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A58B1BD9D3;
	Wed, 19 Feb 2025 23:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740006191; cv=none; b=qlf5HKbUNK7YCglOO8jXqnkG3tHPCPKM05MelTKXeREAx/8qD8YiPVpmCY15zLfbNg5HDre1MHZ9yfwRXJcCSthvDydweAfqTXo3hm/TuC4O9M2q2bbUnMN1EKxMgjHke4bsphpSfeyZdwWygHTE5zfpRO9sP3Q05MJBxk243DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740006191; c=relaxed/simple;
	bh=VUeQu1vrzQP2/7jPS3smCWyLj/rmS0K39e18uTexhz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1EjgKN+q1iVAmzRddJaJQWDMeajDb+USGCKpIM79whJEwvHGQvPQTewXy5GVfEOvaUu60idYciiMlLpxGMOo7KVyQkbTeegWqCNNfEe9FYJxlOr7hW4V5pJkn3eTjgbr/9Yi1psCMS3t5cPx83VqeHr3DDlAkXPsQqRnvF9h1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dw8pTKvu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26CAC4CED1;
	Wed, 19 Feb 2025 23:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740006191;
	bh=VUeQu1vrzQP2/7jPS3smCWyLj/rmS0K39e18uTexhz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dw8pTKvugW7ZaQzOiw3C0XKopY6Hf/aEGHoQAngd8UnAXxaEgWjpQDjUeGYfV6MvR
	 fdO1y+W4JYAkQwCIDAuTKxCiXqy+XJ+BBiMlzqk0pXqzQ2xhAE3cHcqlzQ62oYbd0T
	 cuQqDJRtFEt9dYl+9b7lT6ihRefYWnf4+1EqUN3FtTVKLFsRTTcx0/+hXqTJjUZ98w
	 HnfOEHTrbhwKbBdxNM1ZdtZ+kfYqYkjQCZoTFi4jrrQUKczyROSHTo6MMxg+V3MbyN
	 0Mk6Z2I/wY0IwiybtQbOsj3L08ZaOWBynwxpX4zCe5MGEKYETlTGzCXQwwWib+T7YQ
	 x3ncvP79QgYEA==
Date: Wed, 19 Feb 2025 17:03:09 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
	Zhang Rui <rui.zhang@intel.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, kernel@collabora.com,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org,
	"Rafael J. Wysocki" <rafael@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: rockchip-thermal: Add RK3576 compatible
Message-ID: <174000618924.3136841.3347238546392310162.robh@kernel.org>
References: <20250216-rk3576-tsadc-upstream-v1-0-6ec969322a14@collabora.com>
 <20250216-rk3576-tsadc-upstream-v1-1-6ec969322a14@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250216-rk3576-tsadc-upstream-v1-1-6ec969322a14@collabora.com>


On Sun, 16 Feb 2025 00:34:50 +0100, Nicolas Frattaroli wrote:
> Add a new compatible for the thermal sensor device on the RK3576 SoC.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


