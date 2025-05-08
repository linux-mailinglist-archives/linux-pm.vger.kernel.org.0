Return-Path: <linux-pm+bounces-26873-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C420BAAF375
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 08:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A31C6465DCA
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 06:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E7D217723;
	Thu,  8 May 2025 06:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhF+i6qW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE608216399;
	Thu,  8 May 2025 06:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746684566; cv=none; b=rj/XI0kwPeLQCdtAAx9iCF5PjuccRMS5H3dpSJ42FM3hwsvpyhRmlS78SPXbcGWSc9XeRpt7uIoZGWq91cMAzSlaIZ5U5f1ZaHShyjz9IddFSctEbO/QURpnNjJ+Lg6ancnQ9EWedlMs0E31hzAdIHX5NW3ChomuS+6ke4naBfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746684566; c=relaxed/simple;
	bh=aNzIdCINKAyp+r1r0nEkypLqIzGYNhghY5XaHOpNRBo=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=qtMTe96s1MRjuwK+ND8d6fUuYrAWn/iMHwlSFenZQ9enx2Rrue3gSuC38W2P9ndHx4IbLnBs0qNN7O9/ZVCQ2Uc08ZSnG8yqqB8BrXmdX12+jJKq5bz5tj0Tcbz6a4Ulb+dqRKagIvRGHpo7pV3oJYfeorK0v+ZV0kNNPibTwHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhF+i6qW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8671DC4CEEB;
	Thu,  8 May 2025 06:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746684565;
	bh=aNzIdCINKAyp+r1r0nEkypLqIzGYNhghY5XaHOpNRBo=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=GhF+i6qW8ZUnWN8dJpgO8wPFp4CzysEiMLcaKsUSTc4bXQ3fIW/f8W7Flv7mUM5s8
	 Eq2NF19N2dGwdcnpr5ZqX4pe4buqsAH/KiRMQ9IjiXb3tMnT+LIx68xfQG5pIQXOh9
	 S4onWkn0Da13dfjAIbj77/bx6KxZAfNJBGBpisqRZz65B0GAKEsb5XVkTiuMu4rU98
	 SeZfCogDffRDlR08ZRAfQukpxQkqqscM25t3h25xczyYpUZf2iVzAeoegEz6B+uw9K
	 HSD/xPvjUvijtVuy7vtOVQEorb66kiGAoraC0nXdQNt9RSPSC9RYdqaT52wQkAXfkH
	 PMmpPvhSmTkJw==
Date: Thu, 08 May 2025 01:09:24 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: andre.draszik@linaro.org, tudor.ambarus@linaro.org, krzk+dt@kernel.org, 
 sre@kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, dima.fedrau@gmail.com, 
 alim.akhtar@samsung.com, conor+dt@kernel.org, badhri@google.com, 
 linux-kernel@vger.kernel.org, peter.griffin@linaro.org, 
 linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
To: Amit Sunil Dhamne <amitsd@google.com>
In-Reply-To: <20250508050856.674782-2-amitsd@google.com>
References: <20250508050856.674782-1-amitsd@google.com>
 <20250508050856.674782-2-amitsd@google.com>
Message-Id: <174668456195.3462769.556560233730725103.robh@kernel.org>
Subject: Re: [PATCH v1 1/2] dt-bindings: power: supply: max17201: add port
 property


On Wed, 07 May 2025 22:08:51 -0700, Amit Sunil Dhamne wrote:
> Add port binding to represent an endpoint that connects the power line
> from the battery to the Type-C port connector
> 
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> ---
>  .../devicetree/bindings/power/supply/maxim,max17201.yaml     | 5 +++++
>  1 file changed, 5 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250508050856.674782-2-amitsd@google.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


