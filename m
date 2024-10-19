Return-Path: <linux-pm+bounces-16025-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 872F19A4E29
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 15:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 323B8286B05
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 13:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F332AD14;
	Sat, 19 Oct 2024 13:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPGlFyKr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9597179BC;
	Sat, 19 Oct 2024 13:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729344072; cv=none; b=fY4ZUkwxyGFiuFG/oYhq43PTYJlFTYItlKV0mqk190CFByp0/S3h0Gd0eJK4FL61JX+9+v95TjNg6NF7cEavR86+ZZjlWHK7WAAF5dxUE8KHzXgfvR6wllabE3R+4TXoVS7ySk3E2lCF+MdlO26yMwHu10FtEILroiEwQKydYjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729344072; c=relaxed/simple;
	bh=z2ujj7CqOUPXYkC5rnIpzmXHcFrq6tat7NLdngayWTY=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=g+Bz5OeZdbg8Nl4HW1WnVRrFwQtl9EzFkij/XIvkBcTQrNuGbAgKg5KzrWsRBwb+Ie1Na9oQmFeSAhjtfs4brpMHGoIeX9y7Xq9wQHObMEwYDjoBgpRWkOTumu2afBR0PxXBRHM3vXHwKiH1yVVJs0OlD83Qx2kntQAdw+iLzMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPGlFyKr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D041C4CEC5;
	Sat, 19 Oct 2024 13:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729344071;
	bh=z2ujj7CqOUPXYkC5rnIpzmXHcFrq6tat7NLdngayWTY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=kPGlFyKrmktffw53xmClKa6zbv8UfqJjFbmkhR/AaLhg5Nah/EahKixgKN3r325iX
	 FaAloBzq/PSU6uPKnyZMu5P5z47h2rXQ27JCm2Cittk0C6AoC9HPudJn+8IeiSKLw1
	 lwItxGogPGCBiQk5Bgt2sXKVQCmv/fAQzFn6CaqT5BwzXkHhsONIu3eFsxelIV8PsY
	 L5d7+hewqtHh3DGhngY7DuEJbV1+rEyOS2x5NwrSoSrI2Z0kuRbMRCblu9GYJL1B7a
	 p2ugcpxBusHZr1g4lI8UnWkTjPOgR2MOqgbXfGfe6Sulwb7fNIUNe7X090H3zluySV
	 usXT/TQT5rNGA==
Date: Sat, 19 Oct 2024 08:21:10 -0500
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
Cc: Bjorn Andersson <andersson@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
 iommu@lists.linux.dev, linux-gpio@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>, 
 Will Deacon <will@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
 devicetree@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, linux-pm@vger.kernel.org, 
 Robin Murphy <robin.murphy@arm.com>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-arm-msm@vger.kernel.org, 
 Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20241019-msm8917-v1-1-f1f3ca1d88e5@mainlining.org>
References: <20241019-msm8917-v1-0-f1f3ca1d88e5@mainlining.org>
 <20241019-msm8917-v1-1-f1f3ca1d88e5@mainlining.org>
Message-Id: <172934406053.3231562.13300763002607513598.robh@kernel.org>
Subject: Re: [PATCH RFC 01/14] dt-bindings: pinctrl: qcom,pmic-gpio: add
 PM8937


On Sat, 19 Oct 2024 13:50:38 +0200, Barnabás Czémán wrote:
> Document the 8 GPIOs found on PM8937. It has holes on
> 3,4 and 6 pins.
> 
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
>  Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241019-msm8917-v1-1-f1f3ca1d88e5@mainlining.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


