Return-Path: <linux-pm+bounces-30445-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4164AAFE5DA
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 12:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF33E7B3F40
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 10:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD1F28D83A;
	Wed,  9 Jul 2025 10:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GK4ZwQ8Q"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4D328CF4C;
	Wed,  9 Jul 2025 10:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057291; cv=none; b=Y66ioj24MlbyRm+Ob2hzUu9M/y3uaqf7G3zlEEJkb0ogAS5fljTcKvpWljY3tcIDX9wnvAL0xaiJOSzAvRO4LLFAfVP1XaFri0HWXZrwIPxELkRKP7eGAmewff6MB+WE0o9rjJabC6963IIPCtXasXAWN/88Ea2UcIkzHoMdUhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057291; c=relaxed/simple;
	bh=ye/kS3zQScJ7fXiXA7wmDs0gglazPSqwJCewE/16L18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pweaAai0VM3FTCuc1zMF9fxWf9ftweLXRAnu7ahRcHRRkYHFPFq2PkV5pKo/s9IkRlDCbJbg9e3OVAZQu4C1eImTmQDum/js8I0uH/v/C13pl3W1pNffNn1D2wfhpNvxZoq6vf8DaBAzcLVELaKh6jKGTHCGaPqxQsD4MaqzmmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GK4ZwQ8Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E928FC4CEEF;
	Wed,  9 Jul 2025 10:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057291;
	bh=ye/kS3zQScJ7fXiXA7wmDs0gglazPSqwJCewE/16L18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GK4ZwQ8Q4yWpjjc/vZucPsCBat/t9+qnkE9Kfj4E8qQNtfBXiezLAyni4Da8WJ6Cz
	 rLEZIm6LBmI16z5J1RYjRwk0Xsewusm+Grj1g3RjVvXrPwfEMZWy4ZSF30ju9yLNas
	 JwQOrC5Xgijxf5YkOCTTuIAqE/2xtlB6hOnUHEV87SIigmuyX8hX3d7KGybcH/moA8
	 d23U7VIRNcr0xw6pHYt5rIcmePhR1BrX2yzXXis6bTN/bXMXnz3z2Z/1yT3jJoKmOv
	 YxWmeuGdIJateh7Hr1py+UAxFB82QcXL41Tr66TIfR8M6kzDzitev3IywQmz+2UQ7x
	 u2XGZ+bJ0jrjQ==
Date: Wed, 9 Jul 2025 12:34:48 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: interconnect: document the RPMh
 Network-On-Chip Interconnect in Qualcomm Milos SoC
Message-ID: <20250709-chestnut-beagle-of-painting-035a49@krzk-bin>
References: <20250708-sm7635-icc-v2-0-e158dbadb29c@fairphone.com>
 <20250708-sm7635-icc-v2-1-e158dbadb29c@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250708-sm7635-icc-v2-1-e158dbadb29c@fairphone.com>

On Tue, Jul 08, 2025 at 12:20:37PM +0200, Luca Weiss wrote:
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,milos-rpmh.yaml
> @@ -0,0 +1,136 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interconnect/qcom,milos-rpmh.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm RPMh Network-On-Chip Interconnect on Milos

on Milos SoC

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


