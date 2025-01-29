Return-Path: <linux-pm+bounces-21070-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A93A21636
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2025 02:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF668166F7D
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2025 01:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0ECC187858;
	Wed, 29 Jan 2025 01:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ww5gOyeX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B054114A60A;
	Wed, 29 Jan 2025 01:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738114940; cv=none; b=Ji/7TO03r61ApxK2BYzad17QDvzdMRNZKoAx9zS7fYOgVQZKrPGpJqkJEEQGcC47m4rzY9kka3NSUF68HPDq8LSkficAEmzbgWrzhj0eWyQejAnB+YwPy3D3Qp2+hbINqsfq23pWYNvhFRmUDjwqS+nbv8DfDyUYNQkV/tQ+mpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738114940; c=relaxed/simple;
	bh=XsBY+N8Xy+Xq/wB4sa5tol2/3SUkstHmrkcWo6Zmqwo=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=kc7yEPmtSz7a6UGMHqps4sUoSX5jrzoTCKPSZx93j5+gGDE6rfTT5DIPfNVfKaubJSCxRwd8168CfZi8nY00ueSXiwGV1iBg2uRrdHI7rK1hmFaCWxC642A3vmWPkKgEeCcdLolb1uM2zG+bV/zSW3Q7P0R5OZAj3hEQjb94mJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ww5gOyeX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C8CC4CED3;
	Wed, 29 Jan 2025 01:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738114938;
	bh=XsBY+N8Xy+Xq/wB4sa5tol2/3SUkstHmrkcWo6Zmqwo=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Ww5gOyeXthUxw1WP6Z+SUn2RxAFSBx01TRULJHQT6xdG6EEEdVrN2bjEKFDQGZd6L
	 riF1Mc3K4WWIw1KS8xctGA1uFXYcd1rcA1WQQS60O+g97Spg3fxW+Y0PZ9XK9hwaQk
	 9GkmQs8SMQUR6SMwMLqJF82u2hiVChnX9p37Wl+K+x+Ce0i/qI1MSN+FNBdSNajLMn
	 uj5jOh4R0aCBdpn1RFo1shsl7Zr33hH5291xELxoVry9lPpjZ9pUgutq90RGaevLDC
	 8crQXJw7hC3lahBd5Js/8woZOz4Ca9DoKDpRa3GH1XsyRvk3JlEz9uQJDzLba0oRs8
	 KRaFQL65b6PHw==
Date: Tue, 28 Jan 2025 19:42:17 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: guoren@kernel.org, krzk+dt@kernel.org, aou@eecs.berkeley.edu, 
 airlied@gmail.com, wefu@redhat.com, ulf.hansson@linaro.org, 
 jszhang@kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, jassisinghbrar@gmail.com, 
 linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-clk@vger.kernel.org, palmer@dabbelt.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 mturquette@baylibre.com, p.zabel@pengutronix.de, m.szyprowski@samsung.com, 
 linux-riscv@lists.infradead.org, simona@ffwll.ch, drew@pdp7.com, 
 frank.binns@imgtec.com, conor+dt@kernel.org, tzimmermann@suse.de, 
 sboyd@kernel.org, paul.walmsley@sifive.com, matt.coster@imgtec.com
To: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <20250128194816.2185326-13-m.wilczynski@samsung.com>
References: <20250128194816.2185326-1-m.wilczynski@samsung.com>
 <CGME20250128194841eucas1p29048dc05a26475d8323a7a318a8c7a25@eucas1p2.samsung.com>
 <20250128194816.2185326-13-m.wilczynski@samsung.com>
Message-Id: <173811493702.543459.14627465568650161345.robh@kernel.org>
Subject: Re: [PATCH v4 12/18] dt-bindings: gpu: Add support for T-HEAD
 TH1520 GPU


On Tue, 28 Jan 2025 20:48:10 +0100, Michal Wilczynski wrote:
> Add bindings for the PowerVR BXM-4-64 GPU integrated in the T-HEAD
> TH1520 SoC.  This GPU requires two clocks.
> 
> Document the integration details including clock, reset, power domain
> and interrupt assignments. Add a dt-bindings example showing the proper
> usage of the compatible string "thead,th1520-gpu" along with
> "img,img-bxm".
> 
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  .../bindings/gpu/img,powervr-rogue.yaml       | 39 +++++++++++++++++--
>  1 file changed, 35 insertions(+), 4 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/gpu/img,powervr-rogue.example.dts:46.28-29 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.dtbs:131: Documentation/devicetree/bindings/gpu/img,powervr-rogue.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1506: dt_binding_check] Error 2
make: *** [Makefile:251: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250128194816.2185326-13-m.wilczynski@samsung.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


