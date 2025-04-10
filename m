Return-Path: <linux-pm+bounces-25169-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4D3A84C25
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 20:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E4AB4C02AF
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 18:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F07028EA78;
	Thu, 10 Apr 2025 18:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jU9cQ+gL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FCE28EA66;
	Thu, 10 Apr 2025 18:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744310046; cv=none; b=b2i7joSFSA6nYDcrgg21LSGwqv9uXAG6vwWTEOjYoEZ+ufD6irohKrHKEwOsgepAs248qXporgWJXH5Mrjnf93OAjYcnuUiJyT5W+g3YUE67gjpfSwMRJ40sRvy9/3R2grvqjlH9EWOkigl01vY0zR/NmJSNuQKEoFb2f4QscDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744310046; c=relaxed/simple;
	bh=BiYS7OJbiQUTg3Wtc7ZWyWPPeMF8qL+rJbMRI677PrI=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=kPqZgJR6Zcy3P2Okj/UuIHTmpM9Acr8fyB0nm7x/B3Cp+sjE8aIGqW393qpHqR3HogVwBTHqOjEHsaZkZwzKATqBPMYmNzRqDCQjDNNSaWspkN7XpHeA++mgMcxQk6SKwOhujCwk3D+Rf87aW7bQj7NmUnM3f1+wPRPMs46I+l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jU9cQ+gL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54389C4CEE3;
	Thu, 10 Apr 2025 18:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744310045;
	bh=BiYS7OJbiQUTg3Wtc7ZWyWPPeMF8qL+rJbMRI677PrI=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=jU9cQ+gL8iJvjU0UJbRcE6XuT/TXxXui7cod8d0LJRJXzq8rM+BgV7HF/BsDIjY/L
	 YLrjJGnETKimaJDfM9qB9ciIf2XMOU500OBNj7lycpjO0Hpy5dmcPo1JzJVMRj8/h9
	 yUxjzs1z/H0eurJaTbB0EH1xRaRMHGoWGieEYjih2+38UJMZO49xymWqer+ssC1kcX
	 oxLFcia8mOXHpkDu8KZRrnG+e7VAjAC/yMO4I5PkKuSBBX7R48V9Lb1ym6mfiMavg1
	 OY1dQ/ce8hqzqDbxBbhcXEEJrgFu83Y2X9Y8BDxeoIhXjxXyfqTpWsqbmukPL0y1uZ
	 JucIYYXJKa8Sw==
Date: Thu, 10 Apr 2025 13:34:04 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Nikunj Kela <quic_nkela@quicinc.com>, Conor Dooley <conor+dt@kernel.org>, 
 quic_mnaresh@quicinc.com, Nishanth Menon <nm@ti.com>, 
 quic_arandive@quicinc.com, linux-pm@vger.kernel.org, 
 quic_msavaliy@quicinc.com, linux-serial@vger.kernel.org, 
 Stephen Boyd <sboyd@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 psodagud@quicinc.com, Konrad Dybcio <konradybcio@kernel.org>, 
 quic_vtanuku@quicinc.com, quic_shazhuss@quicinc.com, djaggi@quicinc.com, 
 Viresh Kumar <vireshk@kernel.org>
To: Praveen Talari <quic_ptalari@quicinc.com>
In-Reply-To: <20250410174010.31588-4-quic_ptalari@quicinc.com>
References: <20250410174010.31588-1-quic_ptalari@quicinc.com>
 <20250410174010.31588-4-quic_ptalari@quicinc.com>
Message-Id: <174431004412.707497.3810714931359613741.robh@kernel.org>
Subject: Re: [PATCH v1 3/9] dt-bindings: qcom: geni-se: describe SA8255p


On Thu, 10 Apr 2025 23:10:04 +0530, Praveen Talari wrote:
> From: Nikunj Kela <quic_nkela@quicinc.com>
> 
> SA8255p platform abstracts resources such as clocks, interconnect
> configuration in Firmware.
> 
> Add DT bindings for the QUP Wrapper on sa8255p platform.
> 
> Co-developed-by: Praveen Talari <quic_ptalari@quicinc.com>
> Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>
> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
> ---
>  .../soc/qcom/qcom,sa8255p-geni-se-qup.yaml    | 100 ++++++++++++++++++
>  1 file changed, 100 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,sa8255p-geni-se-qup.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/soc/qcom/qcom,sa8255p-geni-se-qup.yaml:13:2: [warning] wrong indentation: expected 2 but found 1 (indentation)

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/soc/qcom/qcom,sa8255p-geni-se-qup.example.dts:31.13-20: Warning (ranges_format): /example-0/geniqup@9c0000:ranges: empty "ranges" property but its #address-cells (2) differs from /example-0 (1)
Documentation/devicetree/bindings/soc/qcom/qcom,sa8255p-geni-se-qup.example.dts:31.13-20: Warning (ranges_format): /example-0/geniqup@9c0000:ranges: empty "ranges" property but its #size-cells (2) differs from /example-0 (1)
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/qcom/qcom,sa8255p-geni-se-qup.example.dtb: geniqup@9c0000 (qcom,sa8255p-geni-se-qup): reg: [[0, 10223616], [0, 24576]] is too long
	from schema $id: http://devicetree.org/schemas/soc/qcom/qcom,sa8255p-geni-se-qup.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250410174010.31588-4-quic_ptalari@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


