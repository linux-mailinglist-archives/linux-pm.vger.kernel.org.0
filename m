Return-Path: <linux-pm+bounces-37165-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB36EC23CA0
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 09:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAA131A22ABE
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 08:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BB430CD81;
	Fri, 31 Oct 2025 08:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ea7EP1eQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2151F2E2661;
	Fri, 31 Oct 2025 08:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761899225; cv=none; b=GV0OQjS8FeGaowhga/kqKVrifV734+SyiidsMIrYgnrS6uk/8i9/fEXSzoMmiZ4hit5LCMqbngnHrtGV4M34O0gK2Z+wfu1d+IWfmRvffTZHjS0DsdJg7ob/DiU1P9wWXiDPkZbZmAH1jtN0UBzJ20Rq0jTstoVoTdXB4PWfi6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761899225; c=relaxed/simple;
	bh=T7J9+XFKVg8HuPmkvReyqzEKUvKCj6+pGkV3l2AMnJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSBjIvQXwkBNHlCFxrb2Y3w/tG0vbOHhCPUuU12G59s4gvZtoQ06wvBU0/T7UfnI2QFJve9Ty3Z2mlYJ847Sxc9f44fsNsOsX5mQ/Jk9oiIMyjKZiQgmYryTQmxQ7g0L7bXH2HdRKTegT2BqVoFYDMfmj9j+eY7hnrd7iVjbiKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ea7EP1eQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C282C4CEF1;
	Fri, 31 Oct 2025 08:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761899224;
	bh=T7J9+XFKVg8HuPmkvReyqzEKUvKCj6+pGkV3l2AMnJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ea7EP1eQuY3M6A+U7svOwmqMrp7L9PJ8wkKsD1BhIrL8E/LIjlsJBDVK+Be6gsz6r
	 3+dEnu9lsLh0YCW3ZOcHQbBe2r9aaudaUWDP5J5Qg8m3HFwinTIAuqMNzgIVBjz/OY
	 gVWSQ3/MbeqxmClFCkw+UqCikQmInzSNkLs9v/atcC4MUjSu3nsHEW4TFTN7DAb8e+
	 A5S0v4i654H/yjLFX7IKk/8ArQPxLxDLIdZqXOpgIKNWoSIep61iYm6LnZ8AFvbfPo
	 QGra4+tQPCBWgZ064IEcy+/zWDCaOK7HoUglMA27Y4FdIgwF4o6oG5P1efPRojWGbW
	 +wX5upBYMa8xw==
Date: Fri, 31 Oct 2025 09:27:02 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: interconnect: document the RPMh
 Network-On-Chip interconnect in Kaanapali SoC
Message-ID: <20251031-careful-fast-tapir-6ccece@kuoka>
References: <20251031-knp-interconnect-v4-0-568bba2cb3e5@oss.qualcomm.com>
 <20251031-knp-interconnect-v4-1-568bba2cb3e5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251031-knp-interconnect-v4-1-568bba2cb3e5@oss.qualcomm.com>

On Fri, Oct 31, 2025 at 03:38:47AM +0000, Raviteja Laggyshetty wrote:
> Document the RPMh Network-On-Chip Interconnect of the Kaanapali platform.
> 
> Co-developed-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> ---
>  .../bindings/interconnect/qcom,kaanapali-rpmh.yaml | 124 +++++++++++++++++
>  .../dt-bindings/interconnect/qcom,kaanapali-rpmh.h | 149 +++++++++++++++++++++
>  2 files changed, 273 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,kaanapali-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,kaanapali-rpmh.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..9731e7df7eb3d8e1e291a57cbc5941bb8dce1fac
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,kaanapali-rpmh.yaml
> @@ -0,0 +1,124 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interconnect/qcom,kaanapali-rpmh.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm RPMh Network-On-Chip Interconnect on KAANAPALI

Kaanapali

Nowwhere in other patchsets this name is considered an acronym.

With above fixed:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


