Return-Path: <linux-pm+bounces-41610-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aN9pOgPzeWnT1AEAu9opvQ
	(envelope-from <linux-pm+bounces-41610-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 12:29:07 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0AEA068A
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 12:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32061305A3B2
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 11:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1AD34DCD9;
	Wed, 28 Jan 2026 11:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFRSWxHX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9805D34D4EE;
	Wed, 28 Jan 2026 11:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599666; cv=none; b=cQ4WkARnrRBYDhXcsb3j+igeKHDue996onHOKUv68SANl1NUtaT6XBQ7maZ8LQtj+s2vCgYwNn1a45WDVA9IdegJNM4a35q78BvO0AxgxsE2I86Mucfe4LBfAr8qlGuAc2m7S4YBQSFdo3DNEUPW64E2qZLS3dVY/c+V+4Iip/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599666; c=relaxed/simple;
	bh=sL/hnpDbsYGw2TI07D8a1UN5mq9+miWEwEGOG03CMFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/5zhRTXgqPg20jKNzW67TDsjqMouAkGfZunij1vaEpdVFgZGSbQKuTowaWBt4MSAVMK1lSAvZqIGGDpjB/54mtJoy4BxezTPyiDeix5QsvDOypfNL1pFHlX/vpVnyweZZOf01Zx3lQ/0ehxcYDUbp/ru7Xm/7sGbBnGE2cV+NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFRSWxHX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03FEC19421;
	Wed, 28 Jan 2026 11:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769599666;
	bh=sL/hnpDbsYGw2TI07D8a1UN5mq9+miWEwEGOG03CMFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IFRSWxHXepN1DOcXJxPqMzLn3mSW0RKAEG52uKvA8qVQfH7KjhVp3yXIDK9uCvH3Z
	 NZtu5LeftSNeWdCg99Dl6BMQpfgXxVqiSrLmVIu1d0QKqLqCy1TCtjv6z2QI1kx9oU
	 Zk6ffWzFNha8j2nRP0+QJSjdVHSYaCYfscoRJG8nqkowaE+95rrG6xze7EHKWinIGY
	 nA/SU8yHODAW7SjC6vDBZXhqj1b4PRILvRkgX/qQuZh2EnAomlKXIntPo3gADj4oc5
	 c+fz20oDQnyvyAU9xdg7vlq2syYuh1LJqala8kXojscrVfQ71ivVQ++zEXs5xYD9UN
	 GgGDvEMVA9X1g==
Date: Wed, 28 Jan 2026 12:27:43 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: andersson@kernel.org, mathieu.poirier@linaro.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com, 
	konradybcio@kernel.org, mani@kernel.org, casey.connolly@linaro.org, 
	amit.kucheria@oss.qualcomm.com, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com
Subject: Re: [PATCH v2 2/8] dt-bindings: thermal: Add qcom,qmi-cooling yaml
 bindings
Message-ID: <20260128-whispering-caracal-of-respect-a26638@quoll>
References: <20260127155722.2797783-1-gaurav.kohli@oss.qualcomm.com>
 <20260127155722.2797783-3-gaurav.kohli@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260127155722.2797783-3-gaurav.kohli@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41610-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,devicetree.org:url]
X-Rspamd-Queue-Id: AD0AEA068A
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 09:27:16PM +0530, Gaurav Kohli wrote:
> The cooling subnode of a remoteproc represents a client of the Thermal
> Mitigation Device QMI service running on it. Each subnode of the cooling
> node represents a single control exposed by the service.
> 
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> ---
>  .../bindings/remoteproc/qcom,pas-common.yaml  |  6 ++
>  .../bindings/thermal/qcom,qmi-cooling.yaml    | 72 +++++++++++++++++++
>  2 files changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
> index 68c17bf18987..6a736161d5ae 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
> @@ -80,6 +80,12 @@ properties:
>        and devices related to the ADSP.
>      unevaluatedProperties: false
>  
> +  cooling:
> +    $ref: /schemas/thermal/qcom,qmi-cooling.yaml#
> +    description:
> +      Cooling subnode which represents the cooling devices exposed by the Modem.

I do not see the reason why you need 3 (!!!) children here. Everything
should be folded here.

> +    unevaluatedProperties: false
> +
>  required:
>    - clocks
>    - clock-names
> diff --git a/Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml b/Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml
> new file mode 100644
> index 000000000000..0dd3bd84c176
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/qcom,qmi-cooling.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm QMI based thermal mitigation (TMD) cooling devices
> +
> +maintainers:
> +  - Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> +
> +description:
> +  Qualcomm QMI-based TMD cooling devices are used to mitigate thermal conditions
> +  across multiple remote subsystems. These devices operate based on junction
> +  temperature sensors (TSENS) associated with thermal zones for each subsystem.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,qmi-cooling-cdsp
> +      - qcom,qmi-cooling-cdsp1

What are the differences between them?

Why these are not SoC specific?

> +
> +patternProperties:
> +  "cdsp-tmd[0-9]*$":
> +    type: object

No, you do not need childnode. See writing bindings (covers exactly this
case).

> +
> +    description:
> +      Each subnode which represents qmi communication to CDSP.
> +
> +    properties:
> +      label:
> +        maxItems: 1
> +
> +      "#cooling-cells":
> +        $ref: /schemas/thermal/thermal-cooling-devices.yaml#/properties/#cooling-cells
> +
> +    required:
> +      - label
> +      - "#cooling-cells"
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    remoteproc-cdsp {
> +        cooling {
> +            compatible = "qcom,qmi-cooling-cdsp";
> +
> +            cdsp_tmd0: cdsp-tmd0 {
> +              label = "cdsp_sw";
> +              #cooling-cells = <2>;
> +            };
> +        };
> +    };
> +
> +  - |
> +    remoteproc-cdsp1 {

No, don't create unnecessary examples. Please read some slides from
earlier talks so you won't need 10 iterations.

Best regards,
Krzysztof


