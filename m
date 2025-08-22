Return-Path: <linux-pm+bounces-32919-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEF8B322EE
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 21:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17D54B06B34
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 19:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148362D1F7C;
	Fri, 22 Aug 2025 19:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfLNl9Px"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D5B4A1A;
	Fri, 22 Aug 2025 19:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755891335; cv=none; b=MkL73cJggSkkuOi9LziHibW061CJ2yuwIqOFFiRbV9hisrVIZz4/GFX920ylsc775kepA9LoJeZwHzI4D+QoAKy98ftFldzxgQyzImlH+IiO4auCbpolj8aJkSWOfGiQlXnGTc59OMcJiOYxuqSDHjnMFFLj6ylCJ1EhroZ42K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755891335; c=relaxed/simple;
	bh=xgU7037EpdyDMRnXjTxTDjKwrS8kwbSM8eeBoserZHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmNjieY/sHCqGtjxpktSBllD+LbS6VJJpVS8ntG4VUYcfhEe5HQpQm9BXNw3SH4gPPeq1Ucgm4BhN5AGEZRHek8nVgdV6dxeZCaYmMJoLcIYD4wJfesCe6pkq+Lg1iAmS3j7YG4K9XDOSJgPt08aPChaeyNcjZ8xYvxJHQRaZdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfLNl9Px; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85280C4CEED;
	Fri, 22 Aug 2025 19:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755891335;
	bh=xgU7037EpdyDMRnXjTxTDjKwrS8kwbSM8eeBoserZHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QfLNl9PxlXpIZKzVjyxkyQ6HZXNSJGnrEG4zrh9mbX6tbS81oJOoGBdOh7CoHdJ8p
	 HccHwUyCh8ud7F9XtoYmfIgtYPjx/1o2RFLWdJJDAQGZptq8FhRRtNiJtFtTBzvu9Q
	 IX+0ldBlpbiCclPz1GyfphvtvEG7hv/PwVGQpES9UWE64L9l6A46Kzl5FTgSx8jz9b
	 4wBBXI37n04qLS9ZUX+hUdUdOy7sB3rMJa2/V9UFkuc00a1BJ1OMVlwAGd9ZT4j38h
	 /yjjVM3hoPALD1oFxzFoefkUBclP6G8sZMdO4g14uv6eTBLQykLTCiPXSbGrrTvrRP
	 Sp+GWW9abJZWg==
Date: Fri, 22 Aug 2025 14:35:34 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Cc: Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
	~postmarketos/upstreaming@lists.sr.ht, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	David Wronek <david@mainlining.org>, phone-devel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
	Karel Balej <balejk@matfyz.cz>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: clock: marvell,pxa1908: Add syscon
 compatible to apmu
Message-ID: <175589133410.186782.9795752378497482017.robh@kernel.org>
References: <20250821-pxa1908-genpd-v2-0-eba413edd526@dujemihanovic.xyz>
 <20250821-pxa1908-genpd-v2-1-eba413edd526@dujemihanovic.xyz>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250821-pxa1908-genpd-v2-1-eba413edd526@dujemihanovic.xyz>


On Thu, 21 Aug 2025 13:17:43 +0200, Duje Mihanović wrote:
> Add required syscon compatible to the APMU controller. This is required
> for the SoC's power domain controller as the registers are shared.
> 
> Also add a #power-domain-cells property as the node will serve as the
> power domain phandle.
> 
> Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
> ---
> v2:
> - Drop simple-mfd
> - Add #power-domain-cells
> ---
>  .../devicetree/bindings/clock/marvell,pxa1908.yaml | 30 +++++++++++++++++-----
>  1 file changed, 24 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


