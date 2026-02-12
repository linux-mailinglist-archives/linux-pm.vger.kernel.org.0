Return-Path: <linux-pm+bounces-42549-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGiEAsGzjWlz6AAAu9opvQ
	(envelope-from <linux-pm+bounces-42549-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 12:04:33 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A51912CD3B
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 12:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25F9830FE217
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 11:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6AD3446DA;
	Thu, 12 Feb 2026 11:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mt56Qqri"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFFB319614;
	Thu, 12 Feb 2026 11:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770894172; cv=none; b=R015UC5v6YuLREbQDsiedA4VVg+WITh3zE12dbit9xV8wRMtmmpavGXOipvPkULxGYEU7d17XELGeNDLqia2pEaz3+kUP27ZBL8pC+i2ZXQHVq8Vet7VqRMm8aDre5y04Tdzp6Jo4quyMsVReanQuJhdrx5Uf3ELRCziWx/rYI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770894172; c=relaxed/simple;
	bh=bwh7j1H123kBt+r9j1A6KZZRHLvjkZ6ycTZTMqw9+fE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BN96rJnULnq0RXEQNx0Xb2tUD2vsxWXyPBMT1X4RuS0bFMlAY81IbD7KAje2hZGvG+kq8tRjhlj1C0yhCwmsZiRSQDw02CqHnei3Q29ZfgOUEbcARy25OTPzOyd68+8nr9MsaP/xVruUyCNX4hDArMJq2sN8yztzkOGuBPgLoSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mt56Qqri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 426FDC4CEF7;
	Thu, 12 Feb 2026 11:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770894171;
	bh=bwh7j1H123kBt+r9j1A6KZZRHLvjkZ6ycTZTMqw9+fE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mt56Qqri+0Ya/759dNZfLg4vqjGyLN8bfYQ90VuHxGA42LkC3prYtAp4vAEalHQMw
	 8mt/qt0oV3GylmFk9o6M1f2b1UVfq0024p9oFbhON0z/CIWVW50E2i3Y+aLbcVC3Q/
	 2/w+AFvfCYotjsFG9aftfmyoNJkbEdiaJkJgW19cMxM7eR8vs4KUwn9zR3VWTvqq9I
	 0IllXRD3m1Px+cpzyWCbcDH60rB9FNYURAqpCeBuHvS31+zpyfEfQ27p4Ojfhkr37B
	 lpYk4MQktkwKNneZ3Iafeli7/wcAmttX2RLl9AhXt0F40IelFNj46OqCuZo7jZergQ
	 cz5UBbUUt6eAQ==
Date: Thu, 12 Feb 2026 12:02:49 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mike Tipton <mike.tipton@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: interconnect: qcom,qcs615-rpmh: add
 clocks property to enable QoS
Message-ID: <20260212-armored-kingfisher-of-admiration-bdef7c@quoll>
References: <20260211091112.3285626-1-odelu.kukatla@oss.qualcomm.com>
 <20260211091112.3285626-2-odelu.kukatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260211091112.3285626-2-odelu.kukatla@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42549-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: 9A51912CD3B
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 02:41:10PM +0530, Odelu Kukatla wrote:
> Aggre1-noc interconnect node on QCS615 has QoS registers located
> inside a block whose interface is clock-gated. For that node,
> driver must enable the corresponding clock(s) before accessing
> the registers. Add the 'clocks' property so the driver can obtain
> and enable the required clock(s).
>=20
> Only interconnects that have clock=E2=80=91gated QoS register interface
> use this property; it is not applicable to all interconnect nodes.
>=20
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> ---
>  .../interconnect/qcom,qcs615-rpmh.yaml        | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,qcs615-r=
pmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,qcs615-rpmh.=
yaml
> index e06404828824..42679deb4607 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,qcs615-rpmh.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,qcs615-rpmh.yaml
> @@ -34,6 +34,10 @@ properties:
>    reg:
>      maxItems: 1
> =20
> +  clocks:
> +    minItems: 4
> +    maxItems: 4

Define the clocks here please.

> +
>  required:
>    - compatible
> =20
> @@ -53,6 +57,37 @@ allOf:
>        required:
>          - reg
> =20
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,qcs615-aggre1-noc
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: aggre UFS PHY AXI clock
> +            - description: aggre USB2 SEC AXI clock
> +            - description: aggre USB3 PRIM AXI clock
> +            - description: RPMH CC IPA clock

And this entire "if" goes away... unless you already plan to correct other
devices. If so, please correc them now.

Best regards,
Krzysztof


