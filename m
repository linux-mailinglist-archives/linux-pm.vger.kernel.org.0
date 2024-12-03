Return-Path: <linux-pm+bounces-18473-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE8E9E1F0F
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 15:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3030B1643D8
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 14:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7BE1F7062;
	Tue,  3 Dec 2024 14:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ViPykzP+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE461F6696;
	Tue,  3 Dec 2024 14:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733235903; cv=none; b=HFgpiU7BWXUuP+T5mJUTgArc4gyYCAnXevyEFyqOx1VJiHYpG35xR8Xv70MR896luDMGsA0LaNB2TBNLuDFIjKnddgmGAXnG8/Q42ODwDSrmjJibTZw7h8Pd+LAJ4Xtd2Jtyu2cGMGcpsKO9AyX0HAeN91RFxAXCmP0oW7wnkQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733235903; c=relaxed/simple;
	bh=3TKmXmpGABry9oSTFFXvSq6pX10XyahRQRIHFkooJ9U=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=JCZFdekgyyWaTGgHBbMVRP4b9ttrvxwuEAbKTmRgzzMU3wdmLlGRRSLkBdhILZ0X8V/6+RCiadylftYiMPvYvQ2eqbDQW666TJNV4GSe0c6dafWxmqXnSDBq9nIrG3hWmo2L+VzxY3ydASF68+rpZtDMKz//8JY8ZRfcJNjZCEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ViPykzP+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C3FC4CED8;
	Tue,  3 Dec 2024 14:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733235902;
	bh=3TKmXmpGABry9oSTFFXvSq6pX10XyahRQRIHFkooJ9U=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=ViPykzP+sBvHyHt7Xd0oRVDSF+xonpAPnOrijJ+0Pbp26DGv0Cdvrht8+TIpc2sWE
	 kJPD2rafQfO3kcF4UuE4GtuYKOBXphzyGjrTTwcTXAmzC3ez56j+n4MDHUjiRbWSTf
	 96usMdwPzLVCKTZq9txbogysHjFofNHPuVnJ2Sknt4qwn1kbHYr5WqRPrDI6Pdqqap
	 yRkFb5eMkdEvzsZMUdKUxD7ExbAkQ5KaFqhtfpAyH2PjJjxPeldOyIfhRbJEkI0ms0
	 b/FWkBWN6+yyPWtmW3TD2UAYGwaHNxr8r8j/dGsRMFF1dS/O3IbqfkMSn0Md3+C9WO
	 PHgCOkz0SFcsQ==
Date: Tue, 03 Dec 2024 08:25:00 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: mripard@kernel.org, frank.binns@imgtec.com, aou@eecs.berkeley.edu, 
 jszhang@kernel.org, sboyd@kernel.org, guoren@kernel.org, 
 m.szyprowski@samsung.com, dri-devel@lists.freedesktop.org, 
 maarten.lankhorst@linux.intel.com, wefu@redhat.com, 
 jassisinghbrar@gmail.com, simona@ffwll.ch, conor+dt@kernel.org, 
 devicetree@vger.kernel.org, mturquette@baylibre.com, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, krzk+dt@kernel.org, 
 ulf.hansson@linaro.org, palmer@dabbelt.com, paul.walmsley@sifive.com, 
 linux-riscv@lists.infradead.org, tzimmermann@suse.de, drew@pdp7.com, 
 airlied@gmail.com, matt.coster@imgtec.com, linux-pm@vger.kernel.org
To: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <20241203134137.2114847-7-m.wilczynski@samsung.com>
References: <20241203134137.2114847-1-m.wilczynski@samsung.com>
 <CGME20241203134156eucas1p2326d84fcef2ee0914586122520b18dcc@eucas1p2.samsung.com>
 <20241203134137.2114847-7-m.wilczynski@samsung.com>
Message-Id: <173323589751.1743555.13494050245769190862.robh@kernel.org>
Subject: Re: [RFC PATCH v1 06/14] dt-bindings: clock: thead,th1520: Rename
 YAML schema file


On Tue, 03 Dec 2024 14:41:29 +0100, Michal Wilczynski wrote:
> As support for clocks from new subsystems is being added to the T-Head
> TH1520 SoC, the Device Tree binding YAML schema file name should reflect
> this broader scope.  The existing schema file 'thead,th1520-clk-ap.yaml'
> includes the '-ap' suffix, indicating it's specific to the Application
> Processor (AP) subsystem.
> 
> Rename the YAML schema file to 'thead,th1520-clk.yaml' to generalize it
> for all subsystems. Update all references to this schema file
> accordingly.
> 
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  .../clock/{thead,th1520-clk-ap.yaml => thead,th1520-clk.yaml}   | 2 +-
>  MAINTAINERS                                                     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>  rename Documentation/devicetree/bindings/clock/{thead,th1520-clk-ap.yaml => thead,th1520-clk.yaml} (96%)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241203134137.2114847-7-m.wilczynski@samsung.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


