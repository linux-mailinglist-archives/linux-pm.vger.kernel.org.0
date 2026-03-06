Return-Path: <linux-pm+bounces-43841-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPIjITvrqmmOYAEAu9opvQ
	(envelope-from <linux-pm+bounces-43841-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 15:56:59 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D802232C9
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 15:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9BF80300AB37
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 14:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2739B3ACA4B;
	Fri,  6 Mar 2026 14:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OMOPNNur"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46F83A9DAD
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 14:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772809015; cv=pass; b=Wywj8Aan8MlQhV2mUujPGyCb5qmucwynhfwHnbiIZs9adrVqSLfOksu85ZAFkHGoiaU6DS3DQBsxUyt9HQZsmJWgJ2yRD8yuSTeJ881jSL9j9RrjjxQaH9Joul+QD85PQPeJ8FAELgOx2OkIWwLcLod71LajQ0Rpu8dygqFnGlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772809015; c=relaxed/simple;
	bh=goBpoJ28faoQ8XYgq6WhtkSGFlcd+YD90udJy5DZgkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CTKVaOW+kCiim7W9mYKh+tbMUY5Ea3qmeA+obeFJpEGSxcBATpaNz6MpXYP4HzvJLyssc9f75IZgmOF/W9dZZZ62dwVbeo/H506z7RASNFGLjIe/sMl9M9h2vdpv0dsAngUhatMrB56dOZ+fe5u4Ytf6ME+6STYyFvb4v54dCcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OMOPNNur; arc=pass smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-56af73db66bso713298e0c.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 06:56:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772809013; cv=none;
        d=google.com; s=arc-20240605;
        b=GinUQT240QrSKlegaswXKqgY/NwkacehQgzicqDgqQ85OMILvsHYIdcYoH5wPYs1YB
         ksIM8Gbd6tJ4qOz3qF2sNRILSwEE2OxIqAOR8wWhvpsKt0EizrL3PXV1+Uf5buM9Oz1I
         PfPnKjkcRWoer/etu3IkPRvSM1B6yIsoFlSE7OgEyueI5ZcvtSB7KnXWah4SMMt8OqlX
         HQgq0Ierk2g/p9uLB20V/HeiK3CxHrxrvjF2SluHzaA6Pxu/OlXDqMduhA+ekQ0VXZrv
         Gug4FIaJS/9wxxyKk0C4KxIk++wuuHtyDqhwP3GIGQcu4skNlDDvSLgkcYzDDvLU9Ofl
         qW/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZeEoT4aQ4mi2vgbSEY9kBw8Y3Q/OpPZnH0cNhdXpb+E=;
        fh=1pfL/ejYz9ulBlXhO7YVKHnDiSO9TH6SU0Nu61vgMdM=;
        b=fR648cmF9Z0exIkLwF5dFYMcsh0+tgQgRH6esZZYdqlv3K/ITsUxCWTYsDZYmE8RRR
         YYSSMOqK/TH5VPCXxDAq4Mamix3/USOf/TgwDjzG6OHa/zml8vMFebdD2RkxWuzMRtvZ
         DjPsM7inYr7sFi0vVQJSiFXi3/1eNXiBh0thIMJ4ub4HTVidVgMl/0JGz4VtAYgd8XNR
         5qyaFSfY67ro3efy5nLCaescOHX4i5+/di2kCnpCtkIHXO9iYQTGGozngkYzbB6cXIl6
         yBkTika4kFu/tJg7uhagEFFatu202EZumOUNpKRbcEDEUmGFFQL8ag25OY6EEajhwpEh
         9QTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772809013; x=1773413813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZeEoT4aQ4mi2vgbSEY9kBw8Y3Q/OpPZnH0cNhdXpb+E=;
        b=OMOPNNurmksofM6hthi26u33qkRP1VGQTiSNwb+x4OiJzXiPfZQB3Spv62Oo/6yEjm
         lMaibKVzkClOHXR4GED0quj9b4ipSiowfl9/TDAiDmWqm+qfzd5YdCAQpdApfMThn7Sa
         gxUAV1ttvtBcW34SyuS05nn8ktuTplgWJ3ydNw795GZoAvubaopYQi7zMoC8yfo/LkzP
         8Q6N1I+ZVEtgRm6Gu8aFfrjwypa+IOH9ZAKPym/Jn/SfoMbFZre8sb8MPpd5QNQ6LoDU
         H5EucT6+OWNJKTZaWa2ahOJIui8dHDBySrKGg+SdqECsBmoIVJ2UmbkHY5FtfONLXSEP
         r5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772809013; x=1773413813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZeEoT4aQ4mi2vgbSEY9kBw8Y3Q/OpPZnH0cNhdXpb+E=;
        b=Gf2o2ZplvxlrLIrr44hDwj+iItTlg1bVges2veqG5vu96iX3diG1DODtZbo72ONOYe
         fJS80HZ5MscskBUQDwC0NvilNLRQqsH2Ac5x4qoEZMCsoZxE0zX8fjWm6/oJWt9wy6vC
         AbKkXlZFjug//GuEPeox+LZmDf8c1eKdTcZpcVVGrEP2+Rl/z90rq6/bSOexbXd7cJAm
         mtb06l3s6B2B7EVFjzStVHRAHi6Qe9Nd9WwX9bmYxAgbU1OkYyD/n3b6WgGErnV2PjwW
         eX8bovyrrEiLxWrgSg10ZitfekgunwPQP1N+N9DLpbIBaHxUvs6+eDuQChBt5+1dWGw0
         p6Fw==
X-Forwarded-Encrypted: i=1; AJvYcCVhCZA2HuNwWoy/7BwoIy+posY7s72zyckrJC8kiBQtocoegSbKBLLsaUcUSSSfXJIogNtG4ziktQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+hXLvCU8WQ2epOpJIxwaJB+mewRk41ESetn1TmwKWnMGRU5CB
	aaA0mbCB9j690LsShxC46ML2kk2qUyF1TOQF0nBpsnpG8qS2znTfEX6EKfZs5MLkquGpBnaEu5B
	IjOQaGEaywUfMFhyGQvbnZ5Wo9fAPoOsoV+gEEmbXIg==
X-Gm-Gg: ATEYQzzFLWQWJmmjUw0HhwTZxQvg5S95Bp37ViHxlVzvDBES2NlKaiKb7bGUA4bzn7l
	CBhJ48SBi5gwQv+pDjGTRG0z7Awnp0gRvzLlhVwXcMJKqeBw5Y2top1dDArjl/b+A66e6A4Rkdx
	cr0VWZA90wkFvETyYQUrv1qSex6eV3gFpnz4jyr+0B8X7JhFCXEyrHGyyLKKFHvYFBm1C1z3So9
	qKSzxmgbopI7WwV5lu7nuGqEGWjgkgDkxMQRgT9RbMGbJR5wFsAcCk1jUa1PMH8D37Ka7ZW1pQj
	S9RAbSsiqwcbHNDZAxV/WL80vO7OOFJnhH8LoKWtrQ==
X-Received: by 2002:a05:6102:2908:b0:5f5:459f:9860 with SMTP id
 ada2fe7eead31-5ffe61b0681mr982266137.28.1772809012534; Fri, 06 Mar 2026
 06:56:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306-gs101-pd-v7-0-03f7c7965ba5@linaro.org> <20260306-gs101-pd-v7-2-03f7c7965ba5@linaro.org>
In-Reply-To: <20260306-gs101-pd-v7-2-03f7c7965ba5@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 6 Mar 2026 14:56:38 +0000
X-Gm-Features: AaiRm53uvHQccafGc4pUCi7QdXkQtBc4s9nxRYsP2kqD6MjlxpYsHiREsE46KEE
Message-ID: <CADrjBPqsQhmL+7tFQQdFDq=xbWKMUcADXiGoWehKXgWe1FVhnQ@mail.gmail.com>
Subject: Re: [PATCH v7 02/10] dt-bindings: power: samsung: add google,gs101-pd
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 28D802232C9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43841-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[kernel.org,samsung.com,linaro.org,gmail.com,google.com,android.com,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peter.griffin@linaro.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linaro.org:dkim,linaro.org:email,mail.gmail.com:mid,0.0.8.32:email]
X-Rspamd-Action: no action

On Fri, 6 Mar 2026 at 10:29, Andr=C3=A9 Draszik <andre.draszik@linaro.org> =
wrote:
>
> Add support for the Google gs101 version of the Exynos power domains. A
> new compatible is needed because register fields have changed and
> because power domain operations involve interfacing with the TrustZone
> protection control on newer Exynos SoCs.
>
> Power domains can also have a power supply linked to them, so add
> optional support for that, too. It is believed that all (existing)
> platforms could benefit from this, hence it's not being limited to
> gs101-pd.
>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

> v5:
> - add domain-supply and update commit message
>
> v4:
> - add new vendor property samsung,dtzpc
> - drop previous tags due to that
> ---
>  .../devicetree/bindings/power/pd-samsung.yaml      | 33 ++++++++++++++++=
++++--
>  1 file changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/power/pd-samsung.yaml b/Do=
cumentation/devicetree/bindings/power/pd-samsung.yaml
> index 9c2c51133457..3f1a2dc17862 100644
> --- a/Documentation/devicetree/bindings/power/pd-samsung.yaml
> +++ b/Documentation/devicetree/bindings/power/pd-samsung.yaml
> @@ -13,12 +13,10 @@ description: |+
>    Exynos processors include support for multiple power domains which are=
 used
>    to gate power to one or more peripherals on the processor.
>
> -allOf:
> -  - $ref: power-domain.yaml#
> -
>  properties:
>    compatible:
>      enum:
> +      - google,gs101-pd
>        - samsung,exynos4210-pd
>        - samsung,exynos5433-pd
>
> @@ -33,6 +31,9 @@ properties:
>      deprecated: true
>      maxItems: 1
>
> +  domain-supply:
> +    description: domain regulator supply.
> +
>    label:
>      description:
>        Human readable string with domain name. Will be visible in userspa=
ce
> @@ -44,11 +45,28 @@ properties:
>    power-domains:
>      maxItems: 1
>
> +  samsung,dtzpc:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Distributed TrustZone Protection Control (DTZPC) node.
> +
>  required:
>    - compatible
>    - "#power-domain-cells"
>    - reg
>
> +allOf:
> +  - $ref: power-domain.yaml#
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            contains:
> +              const: google,gs101-pd
> +    then:
> +      properties:
> +        samsung,dtzpc: false
> +
>  unevaluatedProperties: false
>
>  examples:
> @@ -66,3 +84,12 @@ examples:
>          #power-domain-cells =3D <0>;
>          label =3D "MFC";
>      };
> +
> +    power-domain@2080 {
> +        compatible =3D "google,gs101-pd";
> +        reg =3D <0x2080 0x80>;
> +        #power-domain-cells =3D <0>;
> +        label =3D "hsi0";
> +        domain-supply =3D <&ldo7m>;
> +        samsung,dtzpc =3D <&dtzpc_hsi0>;
> +    };
>
> --
> 2.53.0.473.g4a7958ca14-goog
>

