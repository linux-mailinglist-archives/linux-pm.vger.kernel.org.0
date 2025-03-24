Return-Path: <linux-pm+bounces-24469-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED958A6E03F
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 17:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27765166317
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 16:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1000263F20;
	Mon, 24 Mar 2025 16:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qlhld6OZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E8933C5;
	Mon, 24 Mar 2025 16:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742835221; cv=none; b=tqKSwMNGsf4MvSrgmrWSanB8E/bEn7SDIy3tFEqOBzxjZXwqUIJeWiBS8B0v2at/JN3AVeDP1z4sS8kLeJMalKo4TLKem68jFLw+HZCB95YszvhhN0TXqpI27eNGOCf8G0xAVY9RcWUaMHj+Tc72BJ0BLBVy4nRvC5A5j4jAfOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742835221; c=relaxed/simple;
	bh=uHrtjAXUnbb9Jj/BliPkXF8dRHiqvxl6NrcWJMlvzo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rd61Gx6bvKAI06C8cg5xov72LG5+PsRyimt3h3lv6Jk6nGaHTIe+UnUAChnuJPfmrAo8se5uODlzGzIiRzla/KRJf7XmmE+KqjNuXfR3Og7hrYMhTBiu8pnoGh0pj9wXHUqQz2Wa59eLwvjzhNKwex1ywEaXx1j52oa2WZUT7AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qlhld6OZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 175F7C4CEDD;
	Mon, 24 Mar 2025 16:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742835221;
	bh=uHrtjAXUnbb9Jj/BliPkXF8dRHiqvxl6NrcWJMlvzo8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qlhld6OZQ074/6jzX+If9Ysjy8jF7+WAVvtx6lDduECvJdjskIYnOiSCbiv9PiRKc
	 rJZSICrjNimod/vcCYmAKgfxiq9GxCSFe7NtyJZ9Gz1ygs/Jvw3HpWZ+T/Yy89MaeR
	 3do5AWmusr0rrGKxp8N/nqzVuLdgz3zs7i6+hUlLDpaIyc/wBY4AsA0CpQAJgC7qoC
	 YbiXCfhvIdOYZrGfxc7ktfCKREa5b83p5JkK9e4GlGsvYHztWwAdbR7DozvuTu+QgS
	 vKBtT2hhKnPdCcy+EIENLPqTQiLfk6aqx+G9ew1tp3cdEXThrnoJII/p48bM6TZAOJ
	 Miz/F59KJZdNQ==
Date: Mon, 24 Mar 2025 11:53:40 -0500
From: Rob Herring <robh@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 1/4] dt-bindings: vendor-prefixes: add prefix for
 Pegatron Corporation
Message-ID: <20250324165340.GA508658-robh@kernel.org>
References: <20250323071424.48779-1-clamor95@gmail.com>
 <20250323071424.48779-2-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250323071424.48779-2-clamor95@gmail.com>

On Sun, Mar 23, 2025 at 09:14:21AM +0200, Svyatoslav Ryhel wrote:
> PEGATRON Corporation is a Taiwanese electronics manufacturing company that
> mainly develops computing, communications and consumer electronics for
> branded vendors. Link https://www.pegatroncorp.com/
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Rob Herring (Arm) <robh@kernel.org>

