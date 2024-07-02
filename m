Return-Path: <linux-pm+bounces-10360-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7A7924328
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 18:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 877F928C3DA
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 16:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69711BD01A;
	Tue,  2 Jul 2024 16:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jR6N/eyn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8257D14D42C
	for <linux-pm@vger.kernel.org>; Tue,  2 Jul 2024 16:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719936321; cv=none; b=mIGnPc3f3IFhI14hEjgXthZjoQ1Mq+KnOnC9AjCdADbUrLJiLyNFiV5tyshvtMx1N/HmozES6D8bJvg2AvCQMsVbcj7FaWQXfqcKKuwZANg+T6ATkmEIn/9lmiKO7TdQeIPm83w9rdhuRUuy2UsERaEcTfzMi+6DAlzk/m4U6k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719936321; c=relaxed/simple;
	bh=syIp2eAtSwSV1hJbA1lDFrbWh4wHMuVpkhgYugmdvnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MaEEPlnqnp0tazAY2eyNSWrX1a1kIQJ3+hKtrvjXOaUm6LJotHM9y4AN5MIIyCthdAPL2LewZ/8CP/oaZM1eCkZYM5IxAs9AG7svSGfkcAMn5FcEvQhgWTzrBhJ+ggJYaE/inf8UeGfYqltuyz80l5esEGIRCq8mzwE7g72tUHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jR6N/eyn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6861EC4AF18
	for <linux-pm@vger.kernel.org>; Tue,  2 Jul 2024 16:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719936321;
	bh=syIp2eAtSwSV1hJbA1lDFrbWh4wHMuVpkhgYugmdvnU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jR6N/eyng+xqAZrCwVB3AkqP86jCFo5ENmDSyMnINnqWe25QcmAL+WZOSaTgJPQTe
	 LXNmiGW4wga9uSrf16qwxrQPI6qPuzitGCXUMGOspvgPjlJMenJS9aCUnYaEC2NWnV
	 Mn6x84PO9Ew+3i3L8pdNyTzWQ9rVd9hXLjbfEt5B9b9FVlM1vd88uOiNXWZgY95QYO
	 FvqggpPLcebX+0471D0bZmkLxYTA8qK19g/7OC+dOyiFpZO+df0y+zDJi54i/WKc2L
	 XeJTvxGZxwjJSPPboNrhHSnqE0Lh7F552JG2WGPgG4BM97ACCzni4fiS1mkylmTT5v
	 DUrY/jFvcuczw==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a724958f118so536050566b.0
        for <linux-pm@vger.kernel.org>; Tue, 02 Jul 2024 09:05:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXW1cGKzhbhZ6Gl+JPawWZG9UXHJog44h270G0bh9kZ6qannfC8WAgheifbPy4cYhcPXD4gNHSmg2UJtNwAnSoTkxGkiyKweiY=
X-Gm-Message-State: AOJu0Yxz47XCT8Z3aE5YbSj/xacs+Y3xTMhcuOVxScZznOLkakTKHYQ5
	OvJ5VMClTVzVfZR6KMzHz+ZBHRL3WwS+F21hc7PLTe5zUmB0qdrH8uk5yKJdkNJZwNYTt8WLfZj
	dA4RW+9QdZ4XJ4bXcgEPuenDtYBQUROHpgBEKQw==
X-Google-Smtp-Source: AGHT+IEBp4AdEUbTVgkYnrR4l+M9u5QRL7lxuLE7wPVki6HJriUGGhJlS+z/qX598S3G9T3Nof1fz6H2Rp80Ffza6Tk=
X-Received: by 2002:a17:907:6e9f:b0:a6f:668b:3442 with SMTP id
 a640c23a62f3a-a75144de9c7mr601088966b.77.1719936319707; Tue, 02 Jul 2024
 09:05:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628-x1e80100-bindings-thermal-qcom-tsens-v2-1-4843d4c2ba24@linaro.org>
In-Reply-To: <20240628-x1e80100-bindings-thermal-qcom-tsens-v2-1-4843d4c2ba24@linaro.org>
From: Amit Kucheria <amitk@kernel.org>
Date: Tue, 2 Jul 2024 21:35:07 +0530
X-Gmail-Original-Message-ID: <CAHLCerNKcHf3e71jTSihbd+Mp1W9ndZ+ULbn-B-iJ734Cj8OEQ@mail.gmail.com>
Message-ID: <CAHLCerNKcHf3e71jTSihbd+Mp1W9ndZ+ULbn-B-iJ734Cj8OEQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: thermal: qcom-tsens: Document the
 X1E80100 Temperature Sensor
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Thara Gopinath <thara.gopinath@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 2:01=E2=80=AFPM Abel Vesa <abel.vesa@linaro.org> wr=
ote:
>
> Document the Temperature Sensor (TSENS) on the X1E80100 Platform.
>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

Reviewed-by: Amit Kucheria <amitk@kernel.org>

> ---
> Changes in v2:
> - Just picked up Krzysztof's R-b tag
> - Link to v1: https://lore.kernel.org/r/20240527-x1e80100-bindings-therma=
l-qcom-tsens-v1-1-0f50f58253e1@linaro.org
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/=
Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> index 99d9c526c0b6..ac54ed604b74 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -67,6 +67,7 @@ properties:
>                - qcom,sm8450-tsens
>                - qcom,sm8550-tsens
>                - qcom,sm8650-tsens
> +              - qcom,x1e80100-tsens
>            - const: qcom,tsens-v2
>
>        - description: v2 of TSENS with combined interrupt
>
> ---
> base-commit: 0fc4bfab2cd45f9acb86c4f04b5191e114e901ed
> change-id: 20240522-x1e80100-bindings-thermal-qcom-tsens-aa2db90c4a74
>
> Best regards,
> --
> Abel Vesa <abel.vesa@linaro.org>
>

