Return-Path: <linux-pm+bounces-36628-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2099ABFA3B5
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 08:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1673188DF1B
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 06:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891E4258CD7;
	Wed, 22 Oct 2025 06:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwALxt1p"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4C94D8CE;
	Wed, 22 Oct 2025 06:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761114692; cv=none; b=t1S9cT4osGl+akgttHHSwEZlb5VXDGDlSYY/XqrfFn0jMfG4mr3T56QW3JJZWAwqjpnn8plt3OiC0S2NxKfvA6RMVAfYgsKXfrViNdeNp/9mjNwHME04/AWU3MFN7AU6iXWvEwD30bKtNUt3n5/SNv3ORvKHmkb6t43r1e9W6TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761114692; c=relaxed/simple;
	bh=yn7iHw37wbzqcytch/NvZNH7Eur25QgbUSUmlbsIbMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pzw5uID9nUtuRXxySKdD2K2tGcpRDf3OGXN+r4bxIr1CbS1oEE8rtVKw2zjXE8r7T8le8EoRJrDofbOmcr5EypUXI6b9ms06YQVQhzPHV/TEfSk/YUX4fS+GkRlpK2quhE6917Ivs+YMvOgDY3Nw9j3nob6qzI20BnvoTDBH3kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwALxt1p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FCEBC4CEE7;
	Wed, 22 Oct 2025 06:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761114691;
	bh=yn7iHw37wbzqcytch/NvZNH7Eur25QgbUSUmlbsIbMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DwALxt1pgdU6zoZPDOf2lAkz/PILJ+A2gI20pNiQsuNyY5zr66DBosRt6hTwBziiE
	 crBoLGRHX7j8Mm2064nvlSFosRMxZYLqE7vqYkyg6nnE2ePBGG0tQzFb57Z6Gafqod
	 ZNNdejCZFc42MlrWfUs4Yp8kOpxfONGnma/bOIGLCqO9uIC1oxGB1ql0MxUZeoywue
	 7a8F5NGXMqWj9BOPwHg5QKQyoqDaHG8b1PhGEqYPCz9TKFJS5jpVeBHI3RRjRuo0Ck
	 6E2grmYy1Zsz3UfVZj4PfwOD3Aa9InGqb3lnsaxqhtLk1k2/9lDHLVwQChE2JSj+CD
	 RBXTnNwpL+Q1g==
Date: Wed, 22 Oct 2025 08:31:29 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 01/10] dt-bindings: power: samsung: add google,gs101-pd
Message-ID: <20251022-impartial-optimal-grasshopper-d1f392@kuoka>
References: <20251016-gs101-pd-v3-0-7b30797396e7@linaro.org>
 <20251016-gs101-pd-v3-1-7b30797396e7@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20251016-gs101-pd-v3-1-7b30797396e7@linaro.org>

On Thu, Oct 16, 2025 at 04:58:34PM +0100, Andr=C3=A9 Draszik wrote:
> Add support for the Google gs101 version of the Exynos power domains. A
> new compatible is needed because register fields have changed.
>=20
> Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---
>  Documentation/devicetree/bindings/power/pd-samsung.yaml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


