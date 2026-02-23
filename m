Return-Path: <linux-pm+bounces-43037-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cO5bGB5ZnGkAEQQAu9opvQ
	(envelope-from <linux-pm+bounces-43037-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 14:41:50 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF51177209
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 14:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FD00308E87F
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 13:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6F123C51D;
	Mon, 23 Feb 2026 13:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+ypo24l"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4443923B61B;
	Mon, 23 Feb 2026 13:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771854009; cv=none; b=mfzcka5/0fQ9pIImDDOQpgu8abvjnL2OgxZI9Lzeg5V3b1e7JeB82y8pXcZQvmRdFG41kU3Jbwq94jQk4xJO9ifGWfMZUMkfFeA68Dwc+yYZ0YPoFPrq3/YFU26HeUDBjM0P6KqFn4gMyoBeHdGy66In3oU0sy+F6dWvvc4JEto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771854009; c=relaxed/simple;
	bh=9PNEevegNtvsO0WR6AZ0/wSOXs5/9ARoQnV0wddpNrc=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=FpLnqDtFkz7mfSt3rOyjM8MPmiLVXxo6EWZkYPKPP8dCv2A5k/o8dXBlS2GW5o0fUxUjvyNCtHdy+PV+pYNB7GVtpRCY4TloUHCO9ofpd8Sp7DcpuhE9kTAm8Nn3kYKEMp5IyLQgMGD1MFSmc8bNZLMwwLwLwL3zAWSLw9X9MdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+ypo24l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2ABC2BCAF;
	Mon, 23 Feb 2026 13:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771854008;
	bh=9PNEevegNtvsO0WR6AZ0/wSOXs5/9ARoQnV0wddpNrc=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=V+ypo24lNTZj1iKq74gORkQfLafw8amuYQTkds0dxuFs5u4qejITu8wq/+emi04hs
	 yKS+l3fFnMHyNXulRAcr+wdM4c5TNHkYg8Dm2U/LESRyGRK1+L3bTRoq4Xt4UIdWaa
	 SwgwDU8jrq+k9mfDF/zY83c2VwEt+7R0nAmx0mNe6GstMZrzsJdQp4MSxWsPA8wzp1
	 oMtOvcNAn02pI30OechUuXuHoSj1CLtD+vRIXuNaxRFm2nN0VZ+52xvSM9mkstKjx8
	 3zadHnbIyYwo0bxBxrt2c4V0dzGMOGk3usjqRcwh0XXM+70vdVmCVsMhbcXXpk2SIz
	 ufucvUkLCjTvQ==
Date: Mon, 23 Feb 2026 07:40:07 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Georgi Djakov <djakov@kernel.org>, linux-pm@vger.kernel.org, 
 Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-arm-msm@vger.kernel.org
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
In-Reply-To: <20260223-eliza-interconnect-v3-1-f4508b8335c5@oss.qualcomm.com>
References: <20260223-eliza-interconnect-v3-0-f4508b8335c5@oss.qualcomm.com>
 <20260223-eliza-interconnect-v3-1-f4508b8335c5@oss.qualcomm.com>
Message-Id: <177185400776.3536428.4819077425980688263.robh@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: interconnect: document the RPMh
 Network-On-Chip interconnect in Eliza SoC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43037-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,devicetree.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BFF51177209
X-Rspamd-Action: no action


On Mon, 23 Feb 2026 14:16:42 +0200, Abel Vesa wrote:
> From: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> 
> Document the RPMh Network-On-Chip Interconnect of the Eliza platform.
> 
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> ---
>  .../bindings/interconnect/qcom,eliza-rpmh.yaml     | 142 +++++++++++++++++++++
>  include/dt-bindings/interconnect/qcom,eliza-rpmh.h | 136 ++++++++++++++++++++
>  2 files changed, 278 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/qcom,eliza-rpmh.example.dtb: interconnect@16e0000 (qcom,eliza-aggre1-noc): clocks: [[4294967295]] is too short
	from schema $id: http://devicetree.org/schemas/interconnect/qcom,eliza-rpmh.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260223-eliza-interconnect-v3-1-f4508b8335c5@oss.qualcomm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


