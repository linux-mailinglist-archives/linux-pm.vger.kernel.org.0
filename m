Return-Path: <linux-pm+bounces-33617-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 675BAB3F841
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 10:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF25318980B9
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 08:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7152E762E;
	Tue,  2 Sep 2025 08:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYCxO9xh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EBD2E613A;
	Tue,  2 Sep 2025 08:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756801526; cv=none; b=H8xL6bsmcuKTO4PkyrXjvdPFE4YGq81RItN1EZrLZeSTt4lTHwWanOaa5FR/EQiYLpE+3tog9XNy+o4K27D/Cc6xv76VKXyApd1RvfURQlfwCXYvQRR3vobzzImZohK4o1BQlSwLLorCfIbAocccJOi+ptS1gXfUAyEsKI81fOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756801526; c=relaxed/simple;
	bh=m8v8Z7SngkH8vSoJlDA+lnDIPikSc2blJeJCqYOjf+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1yzPrdoYrM1LTkFI05fS5/VYNwCiaU/AI0EEPGI96XwqUTK/pjPk75zya1cytpmJcoEbuXvbtOiwmc8X6INiU+/Cz3R8j5INJHFFakgR8YyikS9I+w+We/T8OT/2lZMPZqpKCo/xVd7E4IkiWH/xdxzb8I8H0Dd4SPLSHT/XRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYCxO9xh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673B0C4CEED;
	Tue,  2 Sep 2025 08:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756801526;
	bh=m8v8Z7SngkH8vSoJlDA+lnDIPikSc2blJeJCqYOjf+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bYCxO9xhKI+J4Z0cCZGTWK2Cd8xdhI2mwnHNJeUJFMlZqHqEK7daaq5H3KwNzXHHr
	 FL8QqfQ74EzpjgA6NAOJPADBi+pxpfU87Cj/iU8cQt9GYdx/xIMJ8S04s+MhWaU6Cg
	 n7MJS0Q9r8LStepZu7D/plyXTd8nJB9JExDahBRUJlCCNGTZd0lkZBBGvDdsDlLvYL
	 Rr7E+E1jj9O+irwBVgK1tXesEjrwDOAvbumukYoZYYwgPvyhoHgAMJrEJgFycPZDFX
	 GXVu5a11FzlOJRqucKl5loe/cSkRiStX6kANkPiygeG+9cXgEBu18IGxXa08JxHOCn
	 zExKh0ylyzvFQ==
Date: Tue, 2 Sep 2025 10:25:23 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/8] dt-bindings: tegra: Add ICC IDs for dummy memory
 clients for Tegra194
Message-ID: <20250902-curious-cooperative-agouti-1efdcd@kuoka>
References: <20250831-tegra186-icc-v1-0-607ddc53b507@gmail.com>
 <20250831-tegra186-icc-v1-2-607ddc53b507@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250831-tegra186-icc-v1-2-607ddc53b507@gmail.com>

On Sun, Aug 31, 2025 at 10:33:50PM -0500, Aaron Kling wrote:
> Add ICC IDs for dummy software clients representing CCPLEX clusters.
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  include/dt-bindings/memory/tegra194-mc.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>

Please use subject prefixes matching the subsystem. You can get them for
example with 'git log --oneline -- DIRECTORY_OR_FILE' on the directory
your patch is touching. For bindings, the preferred subjects are
explained here:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters

dt-bindings: memory: tegra194-mc: (or nvidia,tegra194-mc)

Best regards,
Krzysztof


