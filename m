Return-Path: <linux-pm+bounces-644-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D3C801EB2
	for <lists+linux-pm@lfdr.de>; Sat,  2 Dec 2023 22:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1AA61C208A8
	for <lists+linux-pm@lfdr.de>; Sat,  2 Dec 2023 21:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3325A21A14;
	Sat,  2 Dec 2023 21:40:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8935FE8;
	Sat,  2 Dec 2023 13:39:57 -0800 (PST)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-58cecfb4412so2152676eaf.3;
        Sat, 02 Dec 2023 13:39:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701553197; x=1702157997;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ztgcbKHwCkK1zXqhE4JS+hbWqLKGMalxU9N925zsFjU=;
        b=YuCDM6S/Lg07+SWGkQ/3nrFhAomY1sYKU3anHaa2mecaxOpgP8iSnWbWpd6NUhaIqH
         M/jvZ9+c4gjqTY3j3lGFVp/HF3zagiVIpfEQYntTHg0GGDuFUSNla5A08FQNBlz31qNw
         4UaQwZ/YaBgW9ONCYalNEl2tXgkdgGhSSwOXEhvBz8CMsJJyBmXigl3CmOvOO25XKXdT
         jykmaiS/FEELw3MvIqF0ODLB+LoJHSPdBRgKKK5SB/A/kvhzzwQad6EUW/ImPyW+/GYW
         LOkkJZe2QsFiK4Ez/z9b1ZavQlWqczd59RlPxt0kthzu+Vel5Xe+mHiK29qy9D5E4bD7
         sOhw==
X-Gm-Message-State: AOJu0YwqXfMDup2ZFCKoTCu86Y7aH0jjoStLKB58r95yQfG0KIXkchuk
	otVSeFc9GMTbjVMSjMlbNg==
X-Google-Smtp-Source: AGHT+IFYWKztai95IBE5HnuNax1eUKxvaWbB9DWs7lAPYqpPmoenjKf8kqaazZVMEvsVxB0NfKr6JQ==
X-Received: by 2002:a4a:a74d:0:b0:58e:1c48:1edc with SMTP id h13-20020a4aa74d000000b0058e1c481edcmr1443150oom.14.1701553196705;
        Sat, 02 Dec 2023 13:39:56 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 68-20020a4a1747000000b0057b74352e3asm1093968ooe.25.2023.12.02.13.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 13:39:56 -0800 (PST)
Received: (nullmailer pid 438823 invoked by uid 1000);
	Sat, 02 Dec 2023 21:39:54 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Rob Herring <robh+dt@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-renesas-soc@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, devicetree@vger.kernel.org, Biju Das <biju.das.au@gmail.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Support Opensource <support.opensource@diasemi.com>
In-Reply-To: <20231202192536.266885-5-biju.das.jz@bp.renesas.com>
References: <20231202192536.266885-1-biju.das.jz@bp.renesas.com>
 <20231202192536.266885-5-biju.das.jz@bp.renesas.com>
Message-Id: <170155319437.438762.13341872732989255147.robh@kernel.org>
Subject: Re: [PATCH v2 04/11] dt-bindings: thermal: Convert da906{1,2}
 thermal to json-schema
Date: Sat, 02 Dec 2023 15:39:54 -0600


On Sat, 02 Dec 2023 19:25:28 +0000, Biju Das wrote:
> Convert the da906{1,2} thermal device tree binding documentation to
> json-schema.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  .../bindings/thermal/da9062-thermal.txt       | 36 ------------
>  .../bindings/thermal/dlg,da9062-thermal.yaml  | 58 +++++++++++++++++++
>  2 files changed, 58 insertions(+), 36 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/thermal/da9062-thermal.txt
>  create mode 100644 Documentation/devicetree/bindings/thermal/dlg,da9062-thermal.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/thermal/dlg,da9062-thermal.example.dtb: /example-0/i2c/pmic@58: failed to match any schema with compatible: ['dlg,da9062']

doc reference errors (make refcheckdocs):
Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/thermal/da90??-thermal.txt
MAINTAINERS: Documentation/devicetree/bindings/thermal/da90??-thermal.txt

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231202192536.266885-5-biju.das.jz@bp.renesas.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


