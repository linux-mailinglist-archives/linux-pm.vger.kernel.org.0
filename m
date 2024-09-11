Return-Path: <linux-pm+bounces-14039-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E59B197599B
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 19:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 912871F27DB1
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 17:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4263F1B5836;
	Wed, 11 Sep 2024 17:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSAsUVEB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1A81B5823;
	Wed, 11 Sep 2024 17:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726076329; cv=none; b=O733pjBRJSM9OsbbFB/wj15MUbpbRASfIkeD0nwGiQlYvvsQdqjuyiCTMhWXnWQcubcdq180U0WvTdIowWtYHmGYVVdg1Q295fXZE7su0MhguIXOaZm6ABfu/YygRr/KKJga50XWbGDs3Tl7ayXLbey7mjFgOcQmPEx4OHzHBQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726076329; c=relaxed/simple;
	bh=bOVwNWUV6Ukmuh2XCEvIpMUl1EkoGDu5P5d6lc+GSi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1hCi0jm/xyAwvSdj0e1qskyrihhoC9xfIpiGU419fOcTTlV/UH/EKXN6+c8UAUhfPJs6w5rT0BQMFtLBxQHfNaxcd+R+3TvXqN3rc8qGcpaFfn8xMJ2bfgTwWDhYNqC3BtMd6+DP/Ly5i85se6VaRM3oXd3tbcBHOzkXbMcXIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSAsUVEB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B99C4CECC;
	Wed, 11 Sep 2024 17:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726076328;
	bh=bOVwNWUV6Ukmuh2XCEvIpMUl1EkoGDu5P5d6lc+GSi4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iSAsUVEB/FtCTvh8oZWwuq9IHYV+v8w9YXmHFL7+Z1yj/38tAemh5FxZ3zVH1JC1z
	 NOsFbLt4gKxNy9JCjlzD6RPm5h+BCYlLySxQnEjp3a9qTNpq6snM4nDlHPpIRvG01f
	 31f9vQcoW4JNH5EAENDqrxkKEiZI3JqJO/KQE3eheZbu/F7fTopvVTpdgplahbOeq0
	 pm04IG23jmLmOiJIxIWl3VFppsyXQGRiio3wTOXsYKQaDGYggLF6SiGk1jlhO2crlU
	 nPl0Oqkp4b2Wzh0C6AWf9m476amsnhd1FPJnzWyr8Broyo6dmUq0Wq/vRx/OPckkIK
	 vnohLuSoUk5/g==
Date: Wed, 11 Sep 2024 12:38:47 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org,
	Heiko Stuebner <heiko@sntech.de>,
	=?iso-8859-1?Q?Adri=E1n_Mart=EDnez?= Larumbe <adrian.larumbe@collabora.com>,
	kernel@collabora.com, Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org,
	Elaine Zhang <zhangqing@rock-chips.com>
Subject: Re: [PATCH v1 4/6] dt-bindings: power: rockchip: add regulator
 support
Message-ID: <172607632666.1014488.15274638720541628232.robh@kernel.org>
References: <20240910180530.47194-1-sebastian.reichel@collabora.com>
 <20240910180530.47194-5-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910180530.47194-5-sebastian.reichel@collabora.com>


On Tue, 10 Sep 2024 19:57:13 +0200, Sebastian Reichel wrote:
> Add optional support for a voltage supply required to enable a
> power domain. The binding follows the way it is handled by the
> Mediatek binding to keep things consistent.
> 
> This will initially be used by the RK3588 GPU power domain, which
> fails to be enabled when the GPU regulator is not enabled.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../devicetree/bindings/power/rockchip,power-controller.yaml   | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


