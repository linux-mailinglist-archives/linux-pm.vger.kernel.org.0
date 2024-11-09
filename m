Return-Path: <linux-pm+bounces-17273-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C38229C2DD2
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2024 15:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3A521C20D46
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2024 14:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB77E19753F;
	Sat,  9 Nov 2024 14:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uz9uWSgB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD895155322;
	Sat,  9 Nov 2024 14:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731163351; cv=none; b=Rw0AfsTm8sWaxyUE0p3MjfIixOVwVEaY0Xu/mRmawRqMacHtSSUZ3/2a6Bv4ZzDqBiEFQi6B/+GdxPOnaDt7jNkK7rHl3Iu9NV6COUuJNlpSzkBVS/l1KNK0dMY2C+zJ3vwNEqG3mc1UnL/GX96cl+6NDTaGfSVMpaVx0H+BUe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731163351; c=relaxed/simple;
	bh=T4NsAzzbrxsGN654m3HITV9plHMlIDtNUng5/+1hPwk=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=Is/1sAKjLoYVNpKpmCfjjzxxuIXYkRBLeXUUmc9gpuOpj14/nkkCe7dWq9P70ViECWWFBZA4/XQ3W7ayynve7TH/rBiUpKuoFnij6zz6OOEpcM4mVXaeXmgWv8hPiCBfXgWzpYde4pJ5eXJcRuf99fitQcfA9wMWJ7RVWQrCnU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uz9uWSgB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E261C4CECE;
	Sat,  9 Nov 2024 14:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731163351;
	bh=T4NsAzzbrxsGN654m3HITV9plHMlIDtNUng5/+1hPwk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=uz9uWSgBfXnx0ngUIW6rGUhDMz6o4EtZKpNd9RDvNDRoCEaMuotCAkm2d4Chy5Zy1
	 a7pdXeazJuzvDabfD8GLXkXQcQ4Eq4Mzi0VsItmyCiZwdYddAWNNZFt7gYe8W/u8Gx
	 PJ1dENMsxPXCtFXUt6K11XSgsji2lV3Ju840+tPSR5tHexV8bdkxdDUcx9k4qSsQqD
	 ntBdtIQAIW030BQRqrOymC7GLrzp+SNpO4VbuXnqwZjqHm96m+M7JVcqiog6yfzEdw
	 0dzP3DtDV56huciH2OoHZT+KSmsnwsEOCuS400TsQHwYAzLGM+qD7qWaJgrY+K7dd9
	 DV49c3RRSJOig==
Date: Sat, 09 Nov 2024 08:42:29 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Purism Kernel Team <kernel@puri.sm>, Sebastian Reichel <sre@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, linux-pm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Bjorn Andersson <andersson@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 imx@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>
In-Reply-To: <20241109-b4-max17042-v1-1-9e2b07e54e76@gmail.com>
References: <20241109-b4-max17042-v1-0-9e2b07e54e76@gmail.com>
 <20241109-b4-max17042-v1-1-9e2b07e54e76@gmail.com>
Message-Id: <173116334945.561244.8973169174943598746.robh@kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: power: supply: max17042: add
 share-irq node


On Sat, 09 Nov 2024 15:44:33 +0300, Dzmitry Sankouski wrote:
> If specified, driver should request irq as shared.
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---
>  Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml: shared-irq: missing type definition

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241109-b4-max17042-v1-1-9e2b07e54e76@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


