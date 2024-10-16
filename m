Return-Path: <linux-pm+bounces-15790-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7699A10C1
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 19:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6082E1C21F0F
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 17:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11842101B7;
	Wed, 16 Oct 2024 17:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifQW81H1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B0618660A;
	Wed, 16 Oct 2024 17:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729100188; cv=none; b=m8T8EMrsbVsWraA4TKcQGGusVzxhP8tI3xzgBg0kjs+ktCvlLbCQ91cZACC1+7t2ebmTDMh2DrVLLfLyKe8h41mR6mtUxw/ujtKmd/R4GXTMjdmOgFPh7C+nndn0Fr/jAysn7R20ZglBZ59F/cGbuBHio39p3OEqqa78KU8S6GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729100188; c=relaxed/simple;
	bh=TmZJhCmtgNQ+uSiCm3N2f3DBsrSeO/fYVybPVkWjOEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sto+3YApkQp9yiawm6OKaKP9Cop8Jq5+6PmamWgti6ph5EOAL8H3926ZESabrFJ6wkWZnqqjORQ8Q4/iqhpd4a+APrgK9r97eXvo6glM+tQJhzsyPgd4vp8On4E8DM/3VkXkXrfa8ZiGn/BDeo6Yi+j44LXEZLBztP3O29i/HKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifQW81H1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D87C4CEC5;
	Wed, 16 Oct 2024 17:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729100188;
	bh=TmZJhCmtgNQ+uSiCm3N2f3DBsrSeO/fYVybPVkWjOEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ifQW81H1EDbOT9aP1RMxDoUm/+Kek9KD9sZz17eKEzmpj2/Q7q7UhlWFT2s9yJNnC
	 KbJn0VorpIAbJdgnAK3yD+tUT8g0ShVGMOwftfw+uZ8dtL/F5SoO05+tDFIQU/mmba
	 aGKxTSZ73rDERcLN+WP3tJzK4TE5SbUJI3+NxftAusMYDPSbo3tnNvkHeIENcECAP8
	 5+dLifNhE5D80K6DAEYluIarhLEswwZr2ks3A3OCcs/CpQjxJN7sxEqz4+q7mieG0T
	 lqe5Y0bFG0I6DJ36grOpcjUoLvzypr7fB1RqyB0ZvmVlrmv/9LoD5x3UXjtKu0z+Q7
	 XNTw47yBYhmHw==
Date: Wed, 16 Oct 2024 12:36:27 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	devicetree@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>, upstream@airoha.com,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: thermal: Add support for Airoha EN7581
 thermal sensor
Message-ID: <172910018648.2080954.3683531984930036070.robh@kernel.org>
References: <20241016153613.25501-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016153613.25501-1-ansuelsmth@gmail.com>


On Wed, 16 Oct 2024 17:35:48 +0200, Christian Marangi wrote:
> Add support for Airoha EN7581 thermal sensor and monitor. This is a
> simple sensor for the CPU or SoC Package that provide thermal sensor and
> trip point for hot low and critical condition to fire interrupt and
> react on the abnormal state.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../thermal/airoha,en7581-thermal.yaml        | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/airoha,en7581-thermal.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


