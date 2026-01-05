Return-Path: <linux-pm+bounces-40232-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 537B0CF5B9D
	for <lists+linux-pm@lfdr.de>; Mon, 05 Jan 2026 22:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00C533041A72
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 21:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D160311971;
	Mon,  5 Jan 2026 21:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrRcKAei"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEA92D7DF2;
	Mon,  5 Jan 2026 21:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767650062; cv=none; b=pCcxov4l95cryFGn4H4MFk0c0+PCl/tKfLHAKWtSeJosHbqJ1i+0tZT2Bml5A7wnoJ/plyu93j9sQa3J0QOSY+usWCg9O37hdUMGH4fXWXwU4elQcMivodfUFlKFk9iNhLh8hROyKn7dZ0nJdQniLQtA0DI+Pls2hUJdjKnJOsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767650062; c=relaxed/simple;
	bh=zFtE7UMZGmtWbkHt+Bv1qSGyUbvFtGWp1kub6ZgHCPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kA/NsWhOq0XlnlzfOI0gAhuJ2gkTpsBDTdTZdDdRdGccFR4kZVqHUo848rEtLeXupS0RugEsxwan+sCRCrzEsGR9EqEPRHqjgpmrBDWsBvLGZZmR7hAngIiFFxRc/FcMpcIbRTiJU9pCUZprdANF6Ax5NYnLuFqjAk1sQyzm5KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrRcKAei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 703B1C116D0;
	Mon,  5 Jan 2026 21:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767650061;
	bh=zFtE7UMZGmtWbkHt+Bv1qSGyUbvFtGWp1kub6ZgHCPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WrRcKAei56cjRisCJHaUNR570PqIitI7pT09taRLoTkIRc1uV3hDZOqCG/bwGQGAo
	 99vXlLSuDYDIGRqJB0FU6Dv6TViQcQiEnUrIlOrLvjnn2J0Qta0hZ0a9GHdiixJ24z
	 vExzH/LZKYv6957aUzGspW3eKyIT3QecHQuvfIreuhSEX1Ot2MmtSF4YtbQ9ZRxIrg
	 1iCVbPFRS+mjt6UMxV8LGWpJledya+Qloj99ptmKv0zMCjRgVzgJUH3xLDx4gJiEcH
	 80dcQ/SBDM+Jk7zOCd/mk6rsAf2FsYLjCQScgMJ7TWJkM3HclAaS+aQDEXZmyyzuzF
	 uW2UU7X8oyuVQ==
Date: Mon, 5 Jan 2026 15:54:20 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: power: syscon-poweroff: Allow "reg" property
Message-ID: <176765005966.3490694.12039569602021862852.robh@kernel.org>
References: <20251216211556.3047726-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216211556.3047726-1-robh@kernel.org>


On Tue, 16 Dec 2025 15:15:55 -0600, Rob Herring (Arm) wrote:
> Similar to "syscon-reset", allow using the standard "reg" property
> rather than "offset".
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../devicetree/bindings/power/reset/syscon-poweroff.yaml  | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 

Applied, thanks!


