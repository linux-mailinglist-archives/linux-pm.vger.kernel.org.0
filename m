Return-Path: <linux-pm+bounces-16026-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB5C9A4E2D
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 15:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B83E31F257B1
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 13:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FD338FAD;
	Sat, 19 Oct 2024 13:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uj3yPaep"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59ED93307B;
	Sat, 19 Oct 2024 13:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729344073; cv=none; b=AXZT8eFXwxpkUylMbPt1X8g8217fv75Yb8XRN9VuaoQkhnXFtrbr25qCDey3s4l242rSC7djlXPOwTycJBWcrZs7HzlfMA6XLllkWYHPPo1WdSzJX7+6LKBP7Z4m2BJE98AfIDbvs9wWuX23z3qpOKpOLn1fQboU1/XxFpTBjdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729344073; c=relaxed/simple;
	bh=viuTmcbCblXw8rPN5stleAfhO8dzDYFzTsz+0HcbEm4=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=tesE2gijFS5fsWlOvfHLZoFN9myTcBl7NXc9sJqM2nu5HSknfUDBf7PjBpSQhVRiEv7gH8eBsh+noBe1QCEnK9p8k8ItngqF1qLKqejN6sWH3rrwo46iZnLFcF1fK3DubQ760xlQe+52olxyQijZQN17Ox9ItYzRjhugB9rLZnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uj3yPaep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB15C4CEDB;
	Sat, 19 Oct 2024 13:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729344073;
	bh=viuTmcbCblXw8rPN5stleAfhO8dzDYFzTsz+0HcbEm4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Uj3yPaepkLEzW6/48Cjl1VIE37rP0q+xMTManMLFpdh3apvzEciGyjqJaoktE3pQc
	 H9iGyhgSClZWoLoINMD+bi7K/rDt53qx59ilhQaIop8PZUf2V6d/rqwaJf/9wtyIkA
	 zJEcnOqSBL0oCdZ5W9v0bcFu5ZIuRtuL2yfB8g1VHzf6QidLgP5s9IAZGoEN88IEFM
	 c9Iz7mtQq+Hkd2Qx3a7E9urM4PjF2g+/zDBFWUOMj3VMI/XEpSfUsndDO4rmEGoi8T
	 kXWJOFHRkiTwecGuP/MlfQScwOwVT6Irg1QBVpEIBQ6HKCFbX8U+1VdwNc6qjkMBbd
	 rSCnVf/OgdVoA==
Date: Sat, 19 Oct 2024 08:21:11 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, 
 Will Deacon <will@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, linux-arm-msm@vger.kernel.org, 
 Amit Kucheria <amitk@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Lee Jones <lee@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 linux-gpio@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>, 
 Conor Dooley <conor+dt@kernel.org>, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>
In-Reply-To: <20241019-msm8917-v1-3-f1f3ca1d88e5@mainlining.org>
References: <20241019-msm8917-v1-0-f1f3ca1d88e5@mainlining.org>
 <20241019-msm8917-v1-3-f1f3ca1d88e5@mainlining.org>
Message-Id: <172934406194.3231604.1407605892101052446.robh@kernel.org>
Subject: Re: [PATCH RFC 03/14] dt-bindings: pinctrl: qcom,pmic-mpp:
 Document PM8937 compatible


On Sat, 19 Oct 2024 13:50:40 +0200, Barnabás Czémán wrote:
> Document the Device Tree binding for PM8937 MPPs.
> 
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
>  Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241019-msm8917-v1-3-f1f3ca1d88e5@mainlining.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


