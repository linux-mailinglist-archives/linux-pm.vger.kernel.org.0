Return-Path: <linux-pm+bounces-8269-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 268338D22A8
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 19:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94AA51F244CE
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 17:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4E3481DD;
	Tue, 28 May 2024 17:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/Xp5bRw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA32A47F60;
	Tue, 28 May 2024 17:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716918106; cv=none; b=DfPtZk7f2FpMs2XZFAHU1CZsaHn5PKXjaY+sSOVA0JVN2nlGTwxye7XDxDMv3aDkfHOJpqwWbesN1098YJ1k+darZvk6H79S7Y5QWOWp6pdepg/+TiY56/p8El8rSc4PXlsqlRKWwKJYPpjHQTFRM3b3gBrwJ4w5CfsZp+tEF6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716918106; c=relaxed/simple;
	bh=RLYbWmtB1JSsSqTY7dPzl/obl0aq3fUopxD+P3sLiE8=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=I01LRYJOUO4uqDTLrGj9TbFBsc8BSL3M4J7QaQuTDzOvW/NRX499p6PrUMgNsGJ1w5ACLwNeReNmBEaSbmKDJTdnAoi4hft2yIAtF7gHy1plaekBeUzZNZhfao0r/hy/fbhv590ZHcwxi2o25ddxglF/VYkJi26tkCBvz3tU8cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/Xp5bRw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F78EC32782;
	Tue, 28 May 2024 17:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716918105;
	bh=RLYbWmtB1JSsSqTY7dPzl/obl0aq3fUopxD+P3sLiE8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=I/Xp5bRwm2CmB1DjEPopS7cv+o9A3G5woq4FBaf3o60k1PKxJ9QSoeWj3e9TfOpxC
	 vwNP6Ne0lfNrOp1cetrrdIDRMIvHzK9GfEJurIMsSsqZEZkEq274cNH6vLRfsQs82B
	 2QnrAO5gtjo+YZoG+W91mS1EdgX2f6Pnmwai/k28Rnof9n/GAdHnVen9Vq3WRCDaex
	 rXB77GDTMq8CIRDIsPzkbzVDxaLdrwAWbCXH9OPXWLVX7Qh22I2tMRePCP6PmHRQ6L
	 Wb1dKsMEDxQ2vrPyGNaWyn47q0MCzC1h8vXIOj2E8w50nFiy7ECKKr83zgXJaPhf5G
	 Abxys47sO/qRw==
Date: Tue, 28 May 2024 12:41:44 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sre@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Hans de Goede <hdegoede@redhat.com>, devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 linux-usb@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org
In-Reply-To: <20240527-yoga-ec-driver-v3-0-327a9851dad5@linaro.org>
References: <20240527-yoga-ec-driver-v3-0-327a9851dad5@linaro.org>
Message-Id: <171691793418.1180687.12564348124831502092.robh@kernel.org>
Subject: Re: [PATCH v3 0/6] power: supply: Lenovo Yoga C630 EC


On Mon, 27 May 2024 13:03:45 +0300, Dmitry Baryshkov wrote:
> This adds binding, driver and the DT support for the Lenovo Yoga C630
> Embedded Controller, to provide battery information.
> 
> Support for this EC was implemented by Bjorn, who later could not work
> on this driver. I've picked this patchset up and updated it following
> the pending review comments.
> 
> DisplayPort support is still not a part of this patchset. It uses EC
> messages to provide AltMode information rather than implementing
> corresponding UCSI commands. However to have a cleaner uAPI story, the
> AltMode should be handled via the same Type-C port.
> 
> Merge strategy: the driver bits depend on the platform/arm64 patch,
> which adds interface for the subdrivers. I'd either ask to get that
> patch merged to the immutable branch, which then can be picked up by
> power/supply and USB trees or, to make life simpler, ack merging all
> driver bits e.g. through USB subsystem (I'm biased here since I plan to
> send more cleanups for the UCSI subsystem, which would otherwise result
> in cross-subsystem conflicts).
> 
> ---
> Changes in v3:
> - Split the driver into core and power supply drivers,
> - Added UCSI driver part, handling USB connections,
> - Fixed Bjorn's address in DT bindings (Brian Masney)
> - Changed power-role for both ports to be "dual" per UCSI
> - Link to v2: https://lore.kernel.org/linux-arm-msm/20230205152809.2233436-1-dmitry.baryshkov@linaro.org/
> 
> Changes in v2:
> - Dropped DP support for now, as the bindings are in process of being
>   discussed separately,
> - Merged dt patch into the same patchseries,
> - Removed the fixed serial number battery property,
> - Fixed indentation of dt bindings example,
> - Added property: reg and unevaluatedProperties to the connector
>   bindings.
> - Link to v1: https://lore.kernel.org/linux-arm-msm/20220810035424.2796777-1-bjorn.andersson@linaro.org/
> 
> ---
> Bjorn Andersson (2):
>       dt-bindings: power: supply: Add Lenovo Yoga C630 EC
>       arm64: dts: qcom: c630: Add Embedded Controller node
> 
> Dmitry Baryshkov (4):
>       platform: arm64: add Lenovo Yoga C630 WOS EC driver
>       usb: typec: ucsi: add Lenovo Yoga C630 glue driver
>       power: supply: lenovo_yoga_c630_battery: add Lenovo C630 driver
>       arm64: dts: qcom: sdm845: describe connections of USB/DP port
> 
>  .../bindings/power/supply/lenovo,yoga-c630-ec.yaml |  83 ++++
>  arch/arm64/boot/dts/qcom/sdm845.dtsi               |  53 ++-
>  .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts      |  76 ++++
>  drivers/platform/arm64/Kconfig                     |  14 +
>  drivers/platform/arm64/Makefile                    |   1 +
>  drivers/platform/arm64/lenovo-yoga-c630.c          | 279 ++++++++++++
>  drivers/power/supply/Kconfig                       |   9 +
>  drivers/power/supply/Makefile                      |   1 +
>  drivers/power/supply/lenovo_yoga_c630_battery.c    | 476 +++++++++++++++++++++
>  drivers/usb/typec/ucsi/Kconfig                     |   9 +
>  drivers/usb/typec/ucsi/Makefile                    |   1 +
>  drivers/usb/typec/ucsi/ucsi_yoga_c630.c            | 189 ++++++++
>  include/linux/platform_data/lenovo-yoga-c630.h     |  42 ++
>  13 files changed, 1232 insertions(+), 1 deletion(-)
> ---
> base-commit: 8314289a8d50a4e05d8ece1ae0445a3b57bb4d3b
> change-id: 20240527-yoga-ec-driver-76fd7f5ddae8
> 
> Best regards,
> --
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y qcom/sdm850-lenovo-yoga-c630.dtb' for 20240527-yoga-ec-driver-v3-0-327a9851dad5@linaro.org:

arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dtb: pinctrl@3400000: ec-int-state: 'oneOf' conditional failed, one must be fixed:
	'bias-disable', 'function', 'input-enable', 'pins' do not match any of the regexes: '-pins$', 'pinctrl-[0-9]+'
	False schema does not allow True
	from schema $id: http://devicetree.org/schemas/pinctrl/qcom,sdm845-pinctrl.yaml#






