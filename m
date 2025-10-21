Return-Path: <linux-pm+bounces-36567-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C8DBF6A7B
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 15:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7C35422FE4
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 13:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB5E33C50B;
	Tue, 21 Oct 2025 13:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c2NdSUn0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810DB33C504
	for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 13:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051618; cv=none; b=V6jmd2iSxg6XT43Ei68Nsl9vBgf42L0bv7wwMZw+9vienVdIF8OHi+xDMCHI8jz7Yb8IUuLbFDopsHnhmGZZj//sNrSS2/18SvnAPpOAUzoInqtITWzhXYQjhjNa/qIIzzKukTuJiUOU0ssd8ycozjFJ9IhrmI5uYGdyBZx72sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051618; c=relaxed/simple;
	bh=5CwFdvA3X29Kv1mhM21fPBuZSIHfzjJ7q9hLb6A09cA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ceEKQgQiYKcTPXj4qov5xbApuvqchTS44MnFcCSitiw3be3fBehkcPN9OEE2l2lXjqWezp/A+lBsVDOpI/PYgWrHc5O1+0o6Feb+EQkNRbSAzltZnEhRqhHlG9OthcqCMkJOUmqUAWJBMgIcA/rAtO8X7w1cDMduft49sRAyKRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c2NdSUn0; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-63d0692136bso5736673d50.1
        for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 06:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761051615; x=1761656415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlEJkGo4jbFcLLHgPauAsvkvtRdewAA4g7rPzfOb2+8=;
        b=c2NdSUn0yplebnJZ75R6Fkskgf29aH6hwjhW3+d4F2fJQdm/ZCzrJKO8fnhpqjZLLF
         OGHQ7naJyKgqlfdPS7UOG0qdaX+Ud+iFqlLqFjncvPgt21vAOw9NZCJmwVcu7tfkD1DM
         Gn4ShpqDV/dDRYX+tM1hZSnwdqI6N3H/9VT2y/ZW1RMFlWODymVfpVvtngQ/v7jvwLJi
         5sbU1Ywmkah9oxwMu50UuDWgfxe5JZ9l9YULd43ScHOtynICOWaB1JB3DpvzEAe9FfI+
         0wkb3MI1QslQ+puDVgcvoXJS4o0HFkgaZ0yy7luqDTuEPN/1LUDKaldntaD8n/GR+8ck
         32xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761051615; x=1761656415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vlEJkGo4jbFcLLHgPauAsvkvtRdewAA4g7rPzfOb2+8=;
        b=awnknsdIzuVRspnZvPD/O4s7mw9MvZZ5Dre9eZUuwMPbekC9hllcrZsBsGkIx9liZS
         ZbensCn34ZHH6mdv0E49IqdGJgEfk3xaZ9i+ov1ZjhQvmiiRxkftpKAG7o0BJNvppzWf
         DdKYqLQy2clqRrluuVkN9F+Y2GJa82vBa6nln4T3AzhsiVEjDsu6OSNcYwb6OFk8HflB
         9D09LSkF45nS6TEtw6M1wIEktJ4vcpIoRDNO2Pw+c9nKoyJ3sJcR89l+fW4kXhKrILWk
         PvO6EN5KXoBFWgzpXfuryyzaUasV14dxoKgKSfacM51S3ru1lnw6nY7D1m7txIg5cPHz
         Up4g==
X-Forwarded-Encrypted: i=1; AJvYcCVU/rZQDvpTxyYWupMJTjv7pd8HQNPZNimpKT94L2eGbF0QoSkm6eFOH5T0JsBjdLwc1m1cM6xyaA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyeQvyMtzKMefN2t3V5nJuAX3s2Mns0AKF20woLlefRMK/zvVv
	teqSdeRaAXRQrHaRFWy+cgzUfR3gHvCsm0myj57c7Rl64nSSel8DBmM6lT5B7d1JQCQ9QyU41om
	S28k5Hf3LPWSG4jXhvXRPqPmIrzIdGIreUAl8L1ZYPA==
X-Gm-Gg: ASbGncuSCZEzm6oqg15H6VwJ4tSenpaGtzrISVdVzlSQlF3Ww2EuF3chI/VPnLY7l+u
	0IAwyp9PYSTRkwDk8gT/0zLm5ix19QVBERHg9s8Z6oqsdYshj6mTM8Q5Z31Bn1wizHBX2BZsS/Q
	WFJmK5fhUcLqKtB0FznOm8TGxObCSwdQiEQgDt4eOzyzi3eR9RHHArCBWE0XHkZUFAWIWrxIVE4
	WjzG0NlU2buQGAMYLLNUnWDbHAZyOmacJb9o7e+qTCNB6RyExG7xTy3sVUl3LY48F4b/kKm
X-Google-Smtp-Source: AGHT+IH3Bsal993llg86W2aSSM1eiZS3yAmHYuPkrL2KcynJ1XAI6y+Y0IumRaTcK/qZuaGYZjT8+fHPq/Xs9WCQQDY=
X-Received: by 2002:a05:690e:2049:b0:63c:f5a7:406 with SMTP id
 956f58d0204a3-63e161f865emr9077055d50.58.1761051614403; Tue, 21 Oct 2025
 06:00:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016-gs101-pd-v3-0-7b30797396e7@linaro.org> <20251016-gs101-pd-v3-3-7b30797396e7@linaro.org>
In-Reply-To: <20251016-gs101-pd-v3-3-7b30797396e7@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 21 Oct 2025 14:59:37 +0200
X-Gm-Features: AS18NWAWrX3EdOi49ik_edQ7hyw6I5dlqupwh8B2wvDucY-SMETDIx3Qc3I521g
Message-ID: <CAPDyKFqNEN_yfmGWZr=sC-W8-Drv7zn82WYa-y=v+Suk-JHvtQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] dt-bindings: soc: samsung: gs101-pmu: allow
 power domains as children
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 16 Oct 2025 at 17:58, Andr=C3=A9 Draszik <andre.draszik@linaro.org>=
 wrote:
>
> The power domains are a property of / implemented in the PMU. As such,
> they should be modelled as child nodes of the PMU.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
>
> ---
> Note: Ideally, the newly added properties (ranges, etc.) should only be
> 'required' if "^power-domain@[0-9a-f]+$" exists as a patternProperty,
> as they're needed only in that case. As-is, this patch now causes
> warnings for existing DTs as they don't specify the new properties (and
> they shouldn't need to). Only if DTs are updated to include
> power-domains, such an update should also add the new properties.
>
> I've not been able to come up with the correct schema syntax to achieve
> that. dependencies, dependentRequired, and dependentSchemas don't seem
> to support patterns. Similarly,
>   - if:
>       required:
>         - ...
>     then:
>       required:
>         - ...
>
> doesn't allow patterns in the 'if' block (or I didn't get the syntax
> right).
>
> Rob said in
> https://lore.kernel.org/all/20251010141357.GA219719-robh@kernel.org/
> that this is a known limitation in json-schema.
> ---
>  .../bindings/soc/google/google,gs101-pmu.yaml      | 40 ++++++++++++++++=
++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/soc/google/google,gs101-pm=
u.yaml b/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
> index f7119e7a39a3fe0a0a23d1faa251d356f83ba501..a24390f6d2a54afe1aa84935e=
03f719a62f4fc8e 100644
> --- a/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
> +++ b/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
> @@ -26,6 +26,14 @@ properties:
>    reg:
>      maxItems: 1
>
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 1
> +
> +  ranges: true
> +
>    reboot-mode:
>      $ref: /schemas/power/reset/syscon-reboot-mode.yaml
>      type: object
> @@ -49,9 +57,23 @@ properties:
>      description:
>        Phandle to PMU interrupt generation interface.
>
> +patternProperties:
> +  "^power-domain@[0-9a-f]+$":
> +    type: object
> +    description: Child node describing one power domain within the PMU
> +

I think we should specify the power-domain-cells too, along the lines
of the below.

'#power-domain-cells'
 const: 0


> +    additionalProperties: true
> +
> +    properties:
> +      compatible:
> +        const: google,gs101-pd
> +
>  required:
>    - compatible
>    - reg
> +  - '#address-cells'
> +  - '#size-cells'
> +  - ranges
>    - google,pmu-intr-gen-syscon
>
>  additionalProperties: false
> @@ -61,6 +83,24 @@ examples:
>      system-controller@17460000 {
>          compatible =3D "google,gs101-pmu", "syscon";
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
> 2.51.0.788.g6d19910ace-goog
>

Kind regards
Uffe

