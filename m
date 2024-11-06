Return-Path: <linux-pm+bounces-17055-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C6B9BE028
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 09:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D944928537C
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 08:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6D51D3566;
	Wed,  6 Nov 2024 08:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUPReqe9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6A918FDCE;
	Wed,  6 Nov 2024 08:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730881042; cv=none; b=a2oHbvb6t7uPNNbXqBfYRktffDagdGQ44BhHxYlMDmMvKa2DNYKaxMegJQBO6QV2zqtCl49WPCR9aZIDDlb9GGxX+sOaTR3LaBwB9zf0VZwzXl/I9hijrCYwRu0uJl5ryUpWTk+jo/9KdwmQtdXqfqIIlhl0J9+xmwJfbMpOxdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730881042; c=relaxed/simple;
	bh=BU/8HXrCA+97b1VY2hBlr7bf8upxGunWXFaXlB7m5+M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jX5/k4qWpHe0I9BOUQVI+ZJOX9o4lIw9a97akcBjr21YzZSiu6vMAPZjo6gKUBVeL86I9QCRTZSYRPW/uVkRGf4DXPhatQLllJClLJA3QPDDr/8do6H9mWOhtivVNfvKaSvOwKAqKedoNc0P7jseftTsXGdL6rBRuWWmDprUY6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUPReqe9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DBCC4CED0;
	Wed,  6 Nov 2024 08:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730881041;
	bh=BU/8HXrCA+97b1VY2hBlr7bf8upxGunWXFaXlB7m5+M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=QUPReqe9pJVXrM7BpaB7S0Mf7mQhKlPjAedmAY2RtA8rztlXnvWBNbPknP1wyUi4e
	 oVJCZD9DpJJSRhobww6gxC3FzqTQqSIgFA2dxzQXN+63BBziGEWxR+ycBpqEH+r6DM
	 /GiypEEYIelSvtvxaRLTXl8K1FLcdD7d2h3KnOKTPsEjVPpHZ9RgrJRb1Qq5X/Ye46
	 U8EVBEimIn2SRjtdbYYyn01tIwUQRUTnZ/yxlTtH421sISfu6Ieh18HoMVndJaIlmn
	 sWPSJAsNqdlTAdIUQzeanJwum6eDZ/8ECBEkTbKtsLVXtx/NnHQ/sZ7jv7henReyBH
	 UDfTMry4JtZ4Q==
From: Lee Jones <lee@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Lee Jones <lee@kernel.org>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, iommu@lists.linux.dev
In-Reply-To: <20241031-msm8917-v2-8-8a075faa89b1@mainlining.org>
References: <20241031-msm8917-v2-0-8a075faa89b1@mainlining.org>
 <20241031-msm8917-v2-8-8a075faa89b1@mainlining.org>
Subject: Re: (subset) [PATCH v2 08/15] dt-bindings: mfd: qcom,tcsr: Add
 compatible for MSM8917
Message-Id: <173088103734.3238073.14614502914792299953.b4-ty@kernel.org>
Date: Wed, 06 Nov 2024 08:17:17 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Thu, 31 Oct 2024 02:19:49 +0100, Barnabás Czémán wrote:
> Document the qcom,msm8917-tcsr compatible.
> 
> 

Applied, thanks!

[08/15] dt-bindings: mfd: qcom,tcsr: Add compatible for MSM8917
        commit: 1b630208d797bd43645cbd0cdc3da424d1581919

--
Lee Jones [李琼斯]


