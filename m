Return-Path: <linux-pm+bounces-43843-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJmjAgrtqmmOYAEAu9opvQ
	(envelope-from <linux-pm+bounces-43843-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 16:04:42 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DE122364A
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 16:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C6523054B89
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 15:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84AF2D131A;
	Fri,  6 Mar 2026 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E06WX1nX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528F33AEF54
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772809217; cv=pass; b=Tj6hFDanodVimGpDxVwZXB821aqzET2qIteNwPOWILvSgFBRZhAFpR/iGprymkSxmv88L2/P+IugCjVkTvEsQtk9n0CrcEKkLJ5Scc+3YjD5Iv6IABQ5iG9F/+tmDShVY/gLeUIfgBycYsbEXKzFMIP/NbjajQBTYW3gZJo4I08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772809217; c=relaxed/simple;
	bh=uura52BWg09fTSKw/snQHdZ0LDso4ffMBuCWX5PPr7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LfkGr3RzwIUCp/2Mf3tDii6lXfk2ed6+Yc/jlU/NdD/VURnxoUr6nwYrQtqF9apMVw5LiWCRlKUjwwLnlB3iRsKImMAEeBTg5jPpZR2OB+enTuD/4tS/1d+yYcb7VSUuT5GNnLetT+XN249GQY836De3dTqS1INwlQ1qmAtncBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E06WX1nX; arc=pass smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5ffc879bc24so1444273137.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 07:00:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772809213; cv=none;
        d=google.com; s=arc-20240605;
        b=YtpVR40reTP7jrL2DfiTK2O1QTxsy24qnFKpTaZAWBDmkgRFGom+mi3+xA35kf96qO
         0VaDmJPCVCW00A2it9Ck8OXrN7bKrr/TVe+XLCQOs13Sg4YSLs8SrnD0WyM6eAOxkWBQ
         MHMQKOetaeVE0HIcy8SRDTXXABmoc/EYmLtX2UVcl+k/4gIw+qr6rp60+DXTtaBmNTZ7
         urIIr/3wuYq55q0knO72BBA93zkpxTUJY+nofW+GX4IW4FC/6wCZ0XTDtK+r0vX39jsg
         2puOWFfdBCoCrGkbxos/0McvHx1fCQ6bHLFkVFJdiXC5gOnYJORRjGpzgFHUrnGKxque
         5Htg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J/Bpufq2xekGRgCcsd2+UGC/FPMgrs977MI+bXws1l0=;
        fh=igo03Rt+CFhP7rcgU1wU9LxuLvW72pXcOq2EWoAYmp4=;
        b=kWWdWFATRr5jE48jTWydro0LC7WngS1XEJN0SihJOzaxOFGF4sskzRz7VBCZBCOExh
         r17BCbIFOUBbAintsJO5WwPcMWL0xW4hq7g1cZc5zwzFL9iP4+PVVDc+bVGT1XGFn3M+
         V4PWRBR+bsiUTImylEVNXHhdzrKXY4TqRvKExxhMMRInPl7P6qFP6UCknbTjGwbxHcL2
         I/wJMyGy1O00GhxiiPQo+EQ1DNgbgJAK61UxJDLhx9o9kEiPkYgZqwwosRFzmo6M+49a
         b6COyFaro0c6raJ3an26P3c8pPA6lOthYTp/wHz/TEPpSfZG1gcXrcOWJuCSRXuhdhRH
         e9Vg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772809213; x=1773414013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/Bpufq2xekGRgCcsd2+UGC/FPMgrs977MI+bXws1l0=;
        b=E06WX1nXcE4hSb9+D0BmRGd/uAqyLIZgN6gvpJqj5a/f+JLIIW2kWq3H2y12V2b4hE
         r4g5KVl1nfm6MNV5KxhXldbLodtTKzM811zXErjwFZRVkgZwBvBo73/w2YEJes3lPvIB
         fFzUyDuAgyEaxi1cv2LYIOcwLFEfZ6RoPOlh1S4CxZ3bPzZvhlWpBJd+BQJkVzTqSrEs
         GxhGjK/sIJtI92LPhKc8EpenM3WAUaoLRgMqph6LrryY8VEOeHe7eiK8+i3R3VIFcKY5
         FVVTcy19mM/6CRSLHgeAVJ2D0ayvP8Tsd72X4yg5WI05f2MwLwmnrvcnNJnGus3/Fiq5
         HZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772809213; x=1773414013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J/Bpufq2xekGRgCcsd2+UGC/FPMgrs977MI+bXws1l0=;
        b=rmWdBdfO0y3i97HnA73L9s8WSgK0wipG8jbIh2CJSPuoZiuIM/z6chK/61scuso0OJ
         4IwCwv0djaNFxJsI4SaCrGUN7m5h/uClMwLqJ0vjUgvNmkTYYp/HDLvTfp6MfyelZz1g
         4SU4aceNvSJCPeIZQ8nKNIkeA2Bfl5Mt45iBn2Nq+rAnGrMwwnjadKWr7MIfVfRr8OX0
         eJU/qoasTIMl9QGLWUuEGKx1CkdxJinlL3QxE7j3eze8YqSR9gC1rXApfvfjYCP4PeIB
         lTUiTRX338CubKAFFES289xbBoet2TREQT2xZtKk0oUhjD+RrDyADiB6l3yMBuFBPZu4
         moIw==
X-Forwarded-Encrypted: i=1; AJvYcCWoOej7sBx/+WzEBSbdrfrN+ZkiQPlfYG4IaQZnsLFxht3w4IFUOnK9L6JtOr5z9OR8UVZhocXaDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yww5pMSR/JOh746ABJ8CxM7q38N/iLu5GG9Uaz3vcwGPEfvoSrB
	AQjdb5gG71QH78rVYXHYW+qQAvscglaXkqy2s5KOYHZ5wQooubAUcvwGeBjTi25Fn5G3XIxt6e2
	AX8ZWcXaqmwt86SZaAxVTwsAuudoVTb8fkwq4/c6Cpg==
X-Gm-Gg: ATEYQzzH0B/10Uc/rBOwMoCIgesLVJXx8dJpJQXwmMfOblIz+ixhe4zEcx4TD9CQOHg
	GEbWXCgRM9IIVUqs9B86IugGbMW4+yj9G8aL+Va0amrHJc/VkLfUjQbsKSgpCtrvixxiPhvIddJ
	oNrJfh64AooAMvxCSAAEAXjd17gvD2w+unJssCeKrtZe+HJB+D72buV3j8bpUtC+GxiSn1FuCC6
	YVqKEd2ILzLuJL/4mV0xO31rOwzzknNn41A3rT3BSJ+8x3qMrW9guAKYkguyyCdl8lp8MT63/pN
	3Msj+Nv6F+1bVU9EyLv8aXsZVGZVVm4NdFLZ6znOSQ==
X-Received: by 2002:a05:6102:4194:b0:5ff:b8d8:b40b with SMTP id
 ada2fe7eead31-5ffe5f5af96mr976076137.11.1772809211966; Fri, 06 Mar 2026
 07:00:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306-gs101-pd-v7-0-03f7c7965ba5@linaro.org> <20260306-gs101-pd-v7-3-03f7c7965ba5@linaro.org>
In-Reply-To: <20260306-gs101-pd-v7-3-03f7c7965ba5@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 6 Mar 2026 14:59:55 +0000
X-Gm-Features: AaiRm52iLKW20Iji1D2QiNvWLmb7shRdq2i6p-ERiHTNgGNSGFd7-_UUwIqk2YY
Message-ID: <CADrjBPoN65zKrgZ-Hm7exbPK6-7DMSwUKjZ-zvkg_GG3fhn-jQ@mail.gmail.com>
Subject: Re: [PATCH v7 03/10] dt-bindings: soc: samsung: exynos-pmu: move
 gs101-pmu into separate binding
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
X-Rspamd-Queue-Id: 75DE122364A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43843-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,linaro.org:email,devicetree.org:url,mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,1.10.107.32:email]
X-Rspamd-Action: no action

On Fri, 6 Mar 2026 at 10:29, Andr=C3=A9 Draszik <andre.draszik@linaro.org> =
wrote:
>
> The gs101-pmu binding is going to acquire various additional (pattern)
> properties that don't apply to other PMUs supported by this binding.
>
> To enable this, move google,gs101-pmu into a separate binding.
>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

> v7:
> - drop invalid tested-by tag (Krzysztof)
>
> v4:
> - update since 'syscon' was removed from gs101-pmu compatibles
> - update since 'select:' was removed from google,gs101-pmu.yaml
>
> v3:
> - use additionalProperties, not unevaluatedProperties
> - fix path in $id (Rob)
> - drop comment around 'select' (Rob)
> ---
>  .../bindings/soc/google/google,gs101-pmu.yaml      | 56 ++++++++++++++++=
++++++
>  .../bindings/soc/samsung/exynos-pmu.yaml           | 20 --------
>  MAINTAINERS                                        |  1 +
>  3 files changed, 57 insertions(+), 20 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/soc/google/google,gs101-pm=
u.yaml b/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
> new file mode 100644
> index 000000000000..a06bd8ec3c20
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/google/google,gs101-pmu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Google GS101 Power Management Unit (PMU)
> +
> +maintainers:
> +  - Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> +
> +properties:
> +  compatible:
> +    const: google,gs101-pmu
> +
> +  reg:
> +    maxItems: 1
> +
> +  reboot-mode:
> +    $ref: /schemas/power/reset/syscon-reboot-mode.yaml
> +    type: object
> +    description:
> +      Reboot mode to alter bootloader behavior for the next boot
> +
> +  syscon-poweroff:
> +    $ref: /schemas/power/reset/syscon-poweroff.yaml#
> +    type: object
> +    description:
> +      Node for power off method
> +
> +  syscon-reboot:
> +    $ref: /schemas/power/reset/syscon-reboot.yaml#
> +    type: object
> +    description:
> +      Node for reboot method
> +
> +  google,pmu-intr-gen-syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to PMU interrupt generation interface.
> +
> +required:
> +  - compatible
> +  - reg
> +  - google,pmu-intr-gen-syscon
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    system-controller@17460000 {
> +        compatible =3D "google,gs101-pmu";
> +        reg =3D <0x17460000 0x10000>;
> +
> +        google,pmu-intr-gen-syscon =3D <&pmu_intr_gen>;
> +    };
> diff --git a/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yam=
l b/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
> index 76ce7e98c10f..09368dbb6de6 100644
> --- a/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
> +++ b/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
> @@ -12,8 +12,6 @@ maintainers:
>  properties:
>    compatible:
>      oneOf:
> -      - enum:
> -          - google,gs101-pmu
>        - items:
>            - enum:
>                - samsung,exynos3250-pmu
> @@ -110,11 +108,6 @@ properties:
>      description:
>        Node for reboot method
>
> -  google,pmu-intr-gen-syscon:
> -    $ref: /schemas/types.yaml#/definitions/phandle
> -    description:
> -      Phandle to PMU interrupt generation interface.
> -
>  required:
>    - compatible
>    - reg
> @@ -176,19 +169,6 @@ allOf:
>        properties:
>          dp-phy: false
>
> -  - if:
> -      properties:
> -        compatible:
> -          contains:
> -            enum:
> -              - google,gs101-pmu
> -    then:
> -      required:
> -        - google,pmu-intr-gen-syscon
> -    else:
> -      properties:
> -        google,pmu-intr-gen-syscon: false
> -
>  examples:
>    - |
>      #include <dt-bindings/clock/exynos5250.h>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 611fa8fb9f8f..6a00d97ccd09 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10884,6 +10884,7 @@ C:      irc://irc.oftc.net/pixel6-kernel-dev
>  F:     Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
>  F:     Documentation/devicetree/bindings/phy/google,lga-usb-phy.yaml
>  F:     Documentation/devicetree/bindings/soc/google/google,gs101-dtzpc.y=
aml
> +F:     Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yam=
l
>  F:     Documentation/devicetree/bindings/soc/google/google,gs101-pmu-int=
r-gen.yaml
>  F:     Documentation/devicetree/bindings/usb/google,lga-dwc3.yaml
>  F:     arch/arm64/boot/dts/exynos/google/
>
> --
> 2.53.0.473.g4a7958ca14-goog
>

