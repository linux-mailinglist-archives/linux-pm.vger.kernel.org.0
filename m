Return-Path: <linux-pm+bounces-43846-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIqQNULwqmncYwEAu9opvQ
	(envelope-from <linux-pm+bounces-43846-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 16:18:26 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2887B223A57
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 16:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FAB731835CB
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 15:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A643B895D;
	Fri,  6 Mar 2026 15:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QuYQw/Gy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71E93B8920
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 15:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772809954; cv=pass; b=OBpbIXQI2dQchWGlyvuL9eJFYAvCKv72HMtAXRUi10QwfkPHtThPc9ejD5tj48EWhskoeQ7/SAFwyFVUIwnpe3FcIe0EYBl3WSu2mxR1TPIf51shqaHHyXkUOJ4i/PiY2q3FarqADg9TWdGMBt/ynBQd6fneBurURgIgasCHx+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772809954; c=relaxed/simple;
	bh=DJIrAPOjzVYlNzQFRb+nPE0bDvEsm0g1GvK4jt7OniE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VBYs34odpQd6QCJdUH1aEsAUtm5j3C7+pNTR1vBGQlJnmzIIEoR36Lu9mdMjCtsvE0gAWMo5MnWj1CXkjZZZkqsHLS7TnYficOeBTFd4HvBFC17Ov1ro/DekBFmyX9Ed3UkdacU99JQ/b5BlNUb6AdPxwoj7c0FES6voAftyGDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QuYQw/Gy; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-660a58841d4so5072049a12.0
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 07:12:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772809950; cv=none;
        d=google.com; s=arc-20240605;
        b=W/cwp+/M4DnhfcdN8yvvdIw+P0vhnAFol2KEWLS6dO1QVELDvnW//vPsJefPd2oxWw
         gxMqaA2UE7aRg8kEje154KIOMgSXY7Xslvh5T8OH037WrvOF7Dqq2eFFBj0zo5u+XdnO
         2V5hBh6GjTj+ElZ5PJxNFsrDTZJl/OIs8WBcA/00caXGpsWZgqMSM9xrqD142+z4hXP0
         S78h+QeZ8rb9TN8wFQSoeCB+iFX/KKt9eTwWr1dyOyncsdE1DQBwUaqG5Iz+qQOCtNU9
         NMyYQ/4Lq7cDmluowhwBcR3KkB53xYd2WPghxb6PdOluspklTsThJgWdTA7GTF3AQQwQ
         ir+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HVem0P0AdsDnzJHzIyaxJZEVpAJaMe9yOv2rf1iAdzg=;
        fh=MLvSi2HlJ/xwlwzOYHXsZSCEPSwBkyqDSHs3b9k8xEk=;
        b=dR5qVLFRLb/FM/S1vZgoBTNz6grQW9Ao4x9G9jJlRZjSPl0Hk/dzD79vWzVP79ltU9
         8qqlAcdDJRFJ53dijguiqsInoI4Lj+wKX4PaEsrj1qwtRfnH/FpzlWKlm1re6COmBa1F
         8mxg/ybOqxEd5f6dTyhk7g4U0jCRoSQxcJmve3GD+GpF2H+5kaCa773fT1wlJAjQbWKT
         Z7HavrhdN0wrjI+TlNUwkK0Oqr/NJPoMLzATrBF5zrge+0X12/fcANn/w9YnOkyxd2uZ
         lnfgnJz6Gzg0zV7WIyu9TEwgsaO0R631crylHpfvH6KGGMHVplaSXSej/NX15Hsp4Jor
         zSQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772809950; x=1773414750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVem0P0AdsDnzJHzIyaxJZEVpAJaMe9yOv2rf1iAdzg=;
        b=QuYQw/Gyu/EpV7JIEcs3fH2Hrw9+w5z4nmZLEg0ZhNPjfI3rj02G13db+pu9ZB1Ni2
         RltXTC7qQM2cCgWjXNnjQnAUvgmWy8xjANpGJ19KusWek72cgD7+1A5m9J83K6POGXNY
         eAQMNjoYoHL0gjxU/E+cJ5wUs0R05blqVTlOs8bdIAe4Zh83LpZyUMlwWRtF7EfUXslf
         4qbdAm4+evuJB/cQgSvImPwLTVNYy1LO8jAIZHby/6x/jEehd3inUkmT865S2twyybb4
         Q1yils7YNUbBF233LoVDtq+0Fx/syiJJgla+/6LgjZuZUyorsHR60oqDCTfbvurSexQL
         HDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772809950; x=1773414750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HVem0P0AdsDnzJHzIyaxJZEVpAJaMe9yOv2rf1iAdzg=;
        b=Ld4NZb61VzgTBtQ2sMzHWXudb5XDn6qzwxM0uOrZEQkAaAgd8CBnUhIN9fLtUIdxEs
         sQXYOfcHNXKAGduw6+G83fyqROQROj5tD6+ioT5Y0ngve4G8Nq40VaAbtmrO++VB6px/
         BXNIFCucwjKObA2NerL7egLFxfYmQkrKEed9epfcFX7+4cfspJgdodgDwg/zSDZfWywV
         i+XbRN5C68ZlBYNKhtZDPIuH+1x6osUWUJui+bEAUxli1qNAENkQ8bIJfquVb+ndqAex
         njoOyvxKjOsIBri5GIJ1dr+ZqoWP3lx4U7jqsndvkpN30yp9YW95ZEjcszQKmwx96Duc
         gfEw==
X-Forwarded-Encrypted: i=1; AJvYcCXT51eCoMi9SHEV5pEujJJ4j0qZl504jGVJ9ivLUrO6z60W/8/tEgZyr5m3uPcV01Nu33z+XU69gQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5dpR3q4quLWbT2V2ZIh4ey8QbM3mtYSqXUfe7CpyDE4aAhFfd
	2fGO419i09s7K+xsYPe4IDWYfF15eJDSRZYdpV/EHR0xTDCKb84JtGCRwcvTqL4JtP1Qbit2KH5
	1rAC3P5vwmkTln3S1maatC2zmVmeIi+GIcSPByapDrQ==
X-Gm-Gg: ATEYQzySQ0bCLmplSXoRQH7eADmkJgHTehpT9Nfapb7X1V/36t0JTsctM5b20Wby8XE
	2EetxD3X6zTzIi+uHrm6xu1hJj3rUib1fJRxsGCsArEG92W3JfDDn7IsE1sTNMagmbcBBqWVJ6l
	zENll3Sxo70HzjhmtKIzqVeecVmGq46gVegIJmSDenFsq+0ExKfImLTV4Wy7e6+1rgAsVt/KYrN
	sj3gjhWgs1XDJYRdAI3m6BOq8+gqNBWnoZEh9sCJt5ZmaAx5hFekOJda96Nwh2m9v5lbKRjwpQN
	SaGGS3F8NHT84bM8rXEGQ1qkihnullFUjHR+fI19nw==
X-Received: by 2002:a05:6402:3487:b0:660:b913:faa with SMTP id
 4fb4d7f45d1cf-6619d464e36mr1481328a12.7.1772809948849; Fri, 06 Mar 2026
 07:12:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306-gs101-pd-v7-0-03f7c7965ba5@linaro.org> <20260306-gs101-pd-v7-4-03f7c7965ba5@linaro.org>
In-Reply-To: <20260306-gs101-pd-v7-4-03f7c7965ba5@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 6 Mar 2026 15:12:17 +0000
X-Gm-Features: AaiRm50bC_Zr0ksut70Q7jUwSUCXTU_SK0a7CwA46Jn7HCchhyT2HfXFov7-djc
Message-ID: <CADrjBPpiFR-T5SgnOAgt9U279esUYkdVn21Yy2TQnMvrd3VNUA@mail.gmail.com>
Subject: Re: [PATCH v7 04/10] dt-bindings: soc: google: gs101-pmu: allow power
 domains as children
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
X-Rspamd-Queue-Id: 2887B223A57
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43846-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,samsung.com,linaro.org,gmail.com,google.com,android.com,lists.infradead.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.7.208:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peter.griffin@linaro.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-0.991];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linaro.org:dkim,linaro.org:email,1.10.107.32:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Fri, 6 Mar 2026 at 10:29, Andr=C3=A9 Draszik <andre.draszik@linaro.org> =
wrote:
>
> The power domains are a property of / implemented in the PMU. As such,
> they should be modelled as child nodes of the PMU.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

> v7:
> - really be consistent with quoting (Krzysztof)
> - drop invalid tested-by tag (Krzysztof)
>
> v4:
> - consistent quoting using " (Krzysztof)
> - add samsung,dtzpc to example
>
> Note:
> Because the properties added are 'required', this commit breaks DT
> validation of the existing DT for Pixel 6, but a) that's simply because
> the DT is incomplete and b) a DT update will be posted once the binding
> is accepted.
> It is not possible to write the binding such that it supports old
> (incomplete) DTs in addition to the full version, but as per above
> it's not required to keep supporting old DTs.
> ---
>  .../bindings/soc/google/google,gs101-pmu.yaml      | 41 ++++++++++++++++=
++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/soc/google/google,gs101-pm=
u.yaml b/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
> index a06bd8ec3c20..dfe6f87e5949 100644
> --- a/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
> +++ b/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
> @@ -16,6 +16,14 @@ properties:
>    reg:
>      maxItems: 1
>
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +  ranges: true
> +
>    reboot-mode:
>      $ref: /schemas/power/reset/syscon-reboot-mode.yaml
>      type: object
> @@ -39,9 +47,23 @@ properties:
>      description:
>        Phandle to PMU interrupt generation interface.
>
> +patternProperties:
> +  "^power-domain@[0-9a-f]+$":
> +    type: object
> +    description: Child node describing one power domain within the PMU
> +
> +    additionalProperties: true
> +
> +    properties:
> +      compatible:
> +        const: google,gs101-pd
> +
>  required:
>    - compatible
>    - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +  - ranges
>    - google,pmu-intr-gen-syscon
>
>  additionalProperties: false
> @@ -51,6 +73,25 @@ examples:
>      system-controller@17460000 {
>          compatible =3D "google,gs101-pmu";
>          reg =3D <0x17460000 0x10000>;
> +        #address-cells =3D <1>;
> +        #size-cells =3D <1>;
> +        ranges;
>
>          google,pmu-intr-gen-syscon =3D <&pmu_intr_gen>;
> +
> +        pd_g3d: power-domain@1e00 {
> +            compatible =3D "google,gs101-pd";
> +            reg =3D <0x1e00 0x80>;
> +            #power-domain-cells =3D <0>;
> +            label =3D "g3d";
> +            samsung,dtzpc =3D <&pd_g3d>;
> +        };
> +
> +        power-domain@2000 {
> +            compatible =3D "google,gs101-pd";
> +            reg =3D <0x2000 0x80>;
> +            #power-domain-cells =3D <0>;
> +            power-domains =3D <&pd_g3d>;
> +            label =3D "embedded_g3d";
> +        };
>      };
>
> --
> 2.53.0.473.g4a7958ca14-goog
>

