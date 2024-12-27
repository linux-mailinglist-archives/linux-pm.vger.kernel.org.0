Return-Path: <linux-pm+bounces-19783-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D309FD6DB
	for <lists+linux-pm@lfdr.de>; Fri, 27 Dec 2024 19:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F0393A24DF
	for <lists+linux-pm@lfdr.de>; Fri, 27 Dec 2024 18:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FED1F890D;
	Fri, 27 Dec 2024 18:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rbfi2/Zp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C6F57C93;
	Fri, 27 Dec 2024 18:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735323504; cv=none; b=Ncgo3zPSG+MQ6t8BcFzAgm5bP9wdpOjGmltZ4kW6m2BTAYGsbMBPR97tZNxfyTQn65V36Lax85eKgptrnM51uSPd925t0SdZPCvyy8Qos7rNhxsI/DPcBr69NHewtq1EgmMVw//qkaa5CVQAJnBdh72OJJFlbIrUy5Mh4OhLd3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735323504; c=relaxed/simple;
	bh=24BUqcfdsdxMuG27h4cuGyjiUcqul2XhSU011v32JC0=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=nsJnmlDknlURoB4cTIRx3j/eUXXwFQkwGjcJhzK5F9yEv4uC8jmUcLboC0pSNZj7DuunvNM4giU/voz8z4xHSnRvYSnhla4oCltIv8TUJyCn+hSuNCJaPcfaK5ACFlcZCzVZwVLZMihzN5RDLdQxd431u6SGkVEihkUgeta/1YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rbfi2/Zp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E562C4CED0;
	Fri, 27 Dec 2024 18:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735323503;
	bh=24BUqcfdsdxMuG27h4cuGyjiUcqul2XhSU011v32JC0=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Rbfi2/ZpdRa1qBu/fCPIrNaq+P+hBWeYws1C8JmcADtnW0aA4ybo7jlqSP5Fz12kf
	 J/2PKE/8Jzwo3yAPh4qnqW5LeiOPEod0J/TmjdT7acBos2ivuo/jLTaGUOjQ9wPgmw
	 VRC3MDnLteIj0lpMMuuRAaOh3jyvTc7qEzTTjUNa0YQSTAN7wO40OrCmbvDsk1dG5w
	 gDKuospvCL0jugEM0FU8SVSqlDEdywtcltd/n4pfBJH2Aqd9qklPZacjE/lR24gHbn
	 QclssAIge/h62j8LSlKZ9Dh68//sSIlPVEU+oZ2/2b6AouCDF6yVP76g0k2wr7qFm3
	 BP/DfwA5QTztQ==
Date: Fri, 27 Dec 2024 12:18:21 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Sebastian Reichel <sre@kernel.org>, linux-usb@vger.kernel.org, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 linux-arm-msm@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Nikita Travkin <nikita@trvn.ru>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
To: Pengyu Luo <mitltlatltl@gmail.com>
In-Reply-To: <20241227171353.404432-2-mitltlatltl@gmail.com>
References: <20241227171353.404432-1-mitltlatltl@gmail.com>
 <20241227171353.404432-2-mitltlatltl@gmail.com>
Message-Id: <173532350175.52721.17324669998498629489.robh@kernel.org>
Subject: Re: [PATCH 1/5] dt-bindings: platform: Add Huawei Matebook E Go EC


On Sat, 28 Dec 2024 01:13:49 +0800, Pengyu Luo wrote:
> Add binding for the EC found in the Huawei Matebook E Go (sc8280xp) and
> Huawei Matebook E Go LTE (sc8180x) 2in1 tablet.
> 
> Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> ---
>  .../bindings/platform/huawei,gaokun-ec.yaml   | 116 ++++++++++++++++++
>  1 file changed, 116 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/platform/huawei,gaokun-ec.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/platform/huawei,gaokun-ec.example.dts:26.61-62 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.dtbs:131: Documentation/devicetree/bindings/platform/huawei,gaokun-ec.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1506: dt_binding_check] Error 2
make: *** [Makefile:251: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241227171353.404432-2-mitltlatltl@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


