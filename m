Return-Path: <linux-pm+bounces-35919-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D503BCD710
	for <lists+linux-pm@lfdr.de>; Fri, 10 Oct 2025 16:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EAC7B4FC666
	for <lists+linux-pm@lfdr.de>; Fri, 10 Oct 2025 14:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72232F3C3B;
	Fri, 10 Oct 2025 14:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYD5jrSU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B432F3600;
	Fri, 10 Oct 2025 14:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760105639; cv=none; b=p4Xh5Q+Akdiqc6P5A1dWMIecuHhD4Zw8Z7ESEa4bPxlGxaTRhgkLWgrgH31r7Lrgc0gJB2PpDWn5B+M/cTqQzGMNH3pdXsvMatq5VlUqNPPqOrE4LaVgK7ZqBeS1gsH+OYgrYmd70fRU4eJ0wnKfFgjuJ3gh/DietT2fqctkN2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760105639; c=relaxed/simple;
	bh=A/9vTnU0ngIvMSKiBV7pVXM9Nx6z4gz//N6Gk+nd5r8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EaxfK0NI50R4+/Q0xGG0Ujdbu8ULVylVdr9j/LMWuZQxvsPSKyAtk8NoO3GzS4OMLhOR3rOp3Dw871sgPsWFxyKP48fJXZ2vBJsBBUsQyQtQwkf2cBJrMGrAu+ODuvg39jErhejvCfGH8jky4sQSCQRZwdvhs4zCVCaExCX5zGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYD5jrSU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8969C4CEF1;
	Fri, 10 Oct 2025 14:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760105639;
	bh=A/9vTnU0ngIvMSKiBV7pVXM9Nx6z4gz//N6Gk+nd5r8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GYD5jrSUgbAZexvCkuk9uiJYWiz0fDuY7Oh8X+fFOlFcjEfHPQ73ELn0MZEBOGWTG
	 6Kzade07nj7deIgGH3OF2zZYVxBVjbXt2ldD7mRubGg5Uc/s+PJQe9lq7fVViTnogp
	 xVffTZPZNyyEKI+ZK+YoT7eZQsskunkq1Ui5u2qEejXsNFZqSTHEC3V1n2pXV7FjUg
	 OUJT7/JP9kNsHc8FxzRiwR+GI9fFkqXOu8EHMMAnTcjqrduDgNF65AmcF+5LKSSW97
	 NmvBzPiZ4i8JNE1im3zel/3oe09HI5KzEjgrmTrCdLIgd8tWL2uMppcuJ7GlsYBUNa
	 QPgV6/wdIOhTA==
Date: Fri, 10 Oct 2025 09:13:57 -0500
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 03/10] dt-bindings: soc: samsung: gs101-pmu: allow
 power domains as children
Message-ID: <20251010141357.GA219719-robh@kernel.org>
References: <20251009-gs101-pd-v2-0-3f4a6db2af39@linaro.org>
 <20251009-gs101-pd-v2-3-3f4a6db2af39@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251009-gs101-pd-v2-3-3f4a6db2af39@linaro.org>

On Thu, Oct 09, 2025 at 04:25:05PM +0100, André Draszik wrote:
> The power domains are a property of / implemented in the PMU. As such,
> they should be modelled as child nodes of the PMU.
> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> 
> ---
> Note: Ideally, the newly added properties (ranges, etc.) should only be
> 'required' if "^power-domain@[0-9a-f]+$" exists as a patternProperty,
> as they're needed only in that case. As-is, this patch now causes
> warnings for existing DTs as they don't specify the new properties (and
> they shouldn't need to). Only if DTs are updated to include
> power-domains, such an update should also add the new properties.
> 
> I've not been able to come up with the correct schema syntax to achieve
> that. dependencies, dependentRequired, and dependentSchemas don't seem
> to support patterns. Similarly,
>   - if:
>       required:
>         - ...
>     then:
>       required:
>         - ...
> 
> doesn't allow patterns in the 'if' block (or I didn't get the syntax
> right).

This is a known limitation in json-schema. Not sure if they've come up 
with a solution yet.

Rob

