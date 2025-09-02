Return-Path: <linux-pm+bounces-33616-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB538B3F83F
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 10:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E14437A5576
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 08:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA992E7160;
	Tue,  2 Sep 2025 08:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="quANh/F8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E4B2E612D;
	Tue,  2 Sep 2025 08:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756801439; cv=none; b=jj44UrVS8QJeFs1LrWpsO0T6GhwO6JEhORoFYHU9x7dmmvRwqpiCp98o80mJnptlkp3/mtItIbgIjs/Yrd9f/ZbPnqUdbdC1H1qENIaGS7o61CwyYfhYOvjBxUjTOZ5lJULCxB5NJ9m2tzoO+gMdkVkX+9etq8pfRpPC3P9/Y4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756801439; c=relaxed/simple;
	bh=1ATwK9QeTQPiTLRp7e1b8aQrtqeEFUfLhDTxDp84PSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BEf0teLpfjEerTW+BzantJPIZh8N2dHsu5Ud82FHedJ3IsaIjTuoWBrOgcaWVhg5Q2OkthvaBSN/hdsqfKIx1TpjqBElQoKrbL2oYq7XUwdn5DfOxRvRysubmlcUi/BSIhKg2eVvdofcDG2ujoi3hZ2/+/6DRdabQ5YfJrPTYUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=quANh/F8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D06C4CEED;
	Tue,  2 Sep 2025 08:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756801438;
	bh=1ATwK9QeTQPiTLRp7e1b8aQrtqeEFUfLhDTxDp84PSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=quANh/F8Q8ySKbjfQo9wpn+67nUYriaEUG9upUzUsFxoPSaI8gHBbtavupzn7TaTG
	 YjGCsrm1yPeRAC9kERMQLFeY0OrCtCumwf+nHwcOT+yejC7zNJoR28fgn+kfMinRe7
	 xF8pdUfgpKrM+avje5qS68of1z2MiTfQQlOGqRcEyrU7r/LTyrgPl8kPcH6MEQWKDr
	 ROUxTqpGSu6kL2wKwdJnyI7IWERufXJ45R1t1Yv4cRKepliy5ptM2TAJ/NC9HuDD4G
	 fKb33mlqJyhB2lQVkVI8191p1BFI7na5ibMYr79NeXBAaYG+G2IKU7UHU3Syhz2ZGp
	 YzPZWSBmob8cg==
Date: Tue, 2 Sep 2025 10:23:56 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/8] Support dynamic EMC frequency scaling on
 Tegra186/Tegra194
Message-ID: <20250902-glittering-toucan-of-feminism-95fd9f@kuoka>
References: <20250831-tegra186-icc-v1-0-607ddc53b507@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250831-tegra186-icc-v1-0-607ddc53b507@gmail.com>

On Sun, Aug 31, 2025 at 10:33:48PM -0500, Aaron Kling wrote:
> This series borrows the concept used on Tegra234 to scale EMC based on
> CPU frequency and applies it to Tegra186 and Tegra194. Except that the
> bpmp on those archs does not support bandwidth manager, so the scaling
> iteself is handled similar to how Tegra124 currently works.
> 

Three different subsystems and no single explanation of dependencies and
how this can be merged.


Best regards,
Krzysztof


