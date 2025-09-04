Return-Path: <linux-pm+bounces-33808-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F14DB434F1
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 10:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F19495836B6
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 08:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9492BE64F;
	Thu,  4 Sep 2025 08:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAnEGlM1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485B02356B9;
	Thu,  4 Sep 2025 08:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756973310; cv=none; b=b0a7JF4zH2kt2fkmAwikr1gj1+a2NGgghZsVvd3G3t2UviXf7vvZ42d2Hs/gN6Pen25Szdq+bq7V1LJryzRs2rVqrNqTAfZURN0SjcJgRDvDwkA3mAxwaOvXN3tlvdmlJANXSxnJ8I3CXkdecDKcPeHv7ACTaZCz1mt4Jqr3+NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756973310; c=relaxed/simple;
	bh=vc79dnGwg3J7C0Q9Oj/eJb7nhDLpp8vlxfgCHGF0/t4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xmu+lF+ZsFFVn0/yt/4jsOc6kmxUE5N8gQO6PqlOrcLrEcBd94LzZkt3zbywtBW9EHqRtOEfiS7EWJIi06mUjp7Dyztv0f+oP3plmmzp6mYJdo9xgnalaWEcDBTh3a6QVt+BjJQKKBMnhbGHUxq+LMHD3fMZ516z1YHNGdtUTsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAnEGlM1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7371C4CEF0;
	Thu,  4 Sep 2025 08:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756973310;
	bh=vc79dnGwg3J7C0Q9Oj/eJb7nhDLpp8vlxfgCHGF0/t4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GAnEGlM1dEMuuHpPNbdD+D5OVPkg2YfKT7CN1jEsLlMzCvYjE5VaxkTlW7hQ0YfUF
	 8Tbqi5+c6AqEX4h8TsjRPI5cuJM5RvH6Ifv4qo+8YDPsR2i7ap8Sk2nxX5jpcrlAuf
	 V0X7w1FsrsGaThZgdT1B+eWvcFMEidnsyTnIvqvbFDdmZ6aHp95LfHtt0pGbGOm1Rh
	 uFR4DZI0kt1dfVeQQl/Ko/vuKNO2hCsvo6kYZWTFPI2HHrqEUNFnIHK2uwB/GVVfLe
	 s+gA++NHw7/NnEcH0eW0akcuigQM6KWhOcQWaFrixYQNNTu7ow0IuuPeesbQ6IQxDE
	 oSs+WjNcD2nzQ==
Date: Thu, 4 Sep 2025 10:08:27 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Dmitry Osipenko <digetx@gmail.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 0/8] Support Tegra210 actmon for dynamic EMC scaling
Message-ID: <20250904-inquisitive-gazelle-from-atlantis-0bdccb@kuoka>
References: <20250903-t210-actmon-v2-0-e0d534d4f8ea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250903-t210-actmon-v2-0-e0d534d4f8ea@gmail.com>

On Wed, Sep 03, 2025 at 02:50:06PM -0500, Aaron Kling wrote:
> This series adds interconnect support to tegra210 MC and EMC, then
> enables actmon. This enables dynamic emc scaling.
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>

I asked for explaining the dependencies and merging. I don't see
improvements here.

Best regards,
Krzysztof


