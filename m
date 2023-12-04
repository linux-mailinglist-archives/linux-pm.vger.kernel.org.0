Return-Path: <linux-pm+bounces-680-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD057803850
	for <lists+linux-pm@lfdr.de>; Mon,  4 Dec 2023 16:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E5E4B20B63
	for <lists+linux-pm@lfdr.de>; Mon,  4 Dec 2023 15:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AF02C185;
	Mon,  4 Dec 2023 15:09:22 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C4DC1;
	Mon,  4 Dec 2023 07:09:19 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6d875809921so1647838a34.3;
        Mon, 04 Dec 2023 07:09:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701702559; x=1702307359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9l8EahoQw2Wnje//cO/DhKYNYDo8SBi80v9eiboOfA=;
        b=KdmwE5+233L+Kw22lz0mhrjsJTjpdC7IrFO5rp723EvzGrRcfCNf8Rk9vREs/Gv4bu
         Ww74krhbhXZUmoXqOAJEkH8pWD5wHxqsJ9rzVuIiQKZoDRwWCfAN1B/6kRvbH+L9Ohgm
         GOjqdvh1ksMXvtP0lwoLBIL92XNurI1OAmTff3cyRO9FytWyE8jRCuIUEd0zg4zvsRat
         qAxptzTL1r5kcBtsOt/kCEtOJ66mxS0Qk9UchINeSBenIA4ZO971U5Xt0T/Gq3hizwct
         oweyHr3+uZQhCKuyvLVfUdK74YWrQGo9BzrSoOW/NqRlfMy97AkrU/ZxLtnjZpQYsqtt
         n5Sg==
X-Gm-Message-State: AOJu0YxFanihAzDmCSU5fHZZ8Ee3tcg+bMQTbp4spiuJixsDVci2iyy3
	cW2ndXkcGDvOImVS9kiAqg==
X-Google-Smtp-Source: AGHT+IEcB/7Ra9YBZTzGma3hu/xNlaFP3XiJI8kV4x2Omfb3V3TYhmEfP1Jimo9QrmygGYa3UrhJ1g==
X-Received: by 2002:a05:6830:150b:b0:6d8:7835:a9d3 with SMTP id k11-20020a056830150b00b006d87835a9d3mr3944450otp.50.1701702558858;
        Mon, 04 Dec 2023 07:09:18 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id el23-20020a056830719700b006d99cb99f25sm716110otb.81.2023.12.04.07.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 07:09:18 -0800 (PST)
Received: (nullmailer pid 1322960 invoked by uid 1000);
	Mon, 04 Dec 2023 15:09:17 -0000
Date: Mon, 4 Dec 2023 09:09:17 -0600
From: Rob Herring <robh@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "biju.das.au" <biju.das.au@gmail.com>, Lukasz Luba <lukasz.luba@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Support Opensource <support.opensource@diasemi.com>
Subject: Re: [PATCH v2 04/11] dt-bindings: thermal: Convert da906{1,2}
 thermal to json-schema
Message-ID: <20231204150917.GA1260709-robh@kernel.org>
References: <20231202192536.266885-1-biju.das.jz@bp.renesas.com>
 <20231202192536.266885-5-biju.das.jz@bp.renesas.com>
 <170155319437.438762.13341872732989255147.robh@kernel.org>
 <TYCPR01MB112694B04B266A50E3AE3291B8687A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCPR01MB112694B04B266A50E3AE3291B8687A@TYCPR01MB11269.jpnprd01.prod.outlook.com>

On Sun, Dec 03, 2023 at 10:07:19AM +0000, Biju Das wrote:
> Hi Rob Herring,
> 
> Thanks for the feedback,
> 
> > Subject: Re: [PATCH v2 04/11] dt-bindings: thermal: Convert da906{1,2}
> > thermal to json-schema
> > 
> > 
> > On Sat, 02 Dec 2023 19:25:28 +0000, Biju Das wrote:
> > > Convert the da906{1,2} thermal device tree binding documentation to
> > > json-schema.
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > ---
> > >  .../bindings/thermal/da9062-thermal.txt       | 36 ------------
> > >  .../bindings/thermal/dlg,da9062-thermal.yaml  | 58
> > > +++++++++++++++++++
> > >  2 files changed, 58 insertions(+), 36 deletions(-)  delete mode
> > > 100644 Documentation/devicetree/bindings/thermal/da9062-thermal.txt
> > >  create mode 100644
> > > Documentation/devicetree/bindings/thermal/dlg,da9062-thermal.yaml
> > >
> > 
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > Documentation/devicetree/bindings/thermal/dlg,da9062-thermal.example.dtb:
> > /example-0/i2c/pmic@58: failed to match any schema with compatible:
> > ['dlg,da9062']
> 
> Looks validation is not checking compatible defines in the mfd/da9062.txt file. 
> So will merge this patch with patch #11 to fix this error.

No need to merge it. Just note below the '---' the warning is expected.

Rob

