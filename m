Return-Path: <linux-pm+bounces-873-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AEB80BC0A
	for <lists+linux-pm@lfdr.de>; Sun, 10 Dec 2023 16:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B4CE1F20FEB
	for <lists+linux-pm@lfdr.de>; Sun, 10 Dec 2023 15:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9095516423;
	Sun, 10 Dec 2023 15:37:54 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015FAC3;
	Sun, 10 Dec 2023 07:37:51 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3b8958b32a2so2882770b6e.2;
        Sun, 10 Dec 2023 07:37:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702222671; x=1702827471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Ji5mkz2w1i3rJ7T9MkphHkjSl4MgnGzYXtKBOP0fIA=;
        b=VSuTeNvOdpD1lo4dEl6XXydC6h+2EtqojOPeyNGOstjICoqS/L9GYA6nf0CvEYbhps
         kVnQ+AXhstdcs4TFbmTSyIgH0z/y2P9Ql9e/0rcktOYZxFjiOR+CXwMNJ1doOtDRRibn
         GCXEXS0v/SKIVJkxxtLd/az3vbIULOegt+x5k3El875tZmHET+1tkLdGtSf7NKaTXWVE
         cwI9HyegBsTgEXaw2rN5y2dsFI7u2DuiZEM9yAa+Yc1/J7m8OwSsAFH+iajcK7fhjr8B
         p3bnqk8TvXysFGqWhx6c72QutjDYpoZ0oImy8b/xMInIG1oHDpexQXEcLG6UtTYRozUo
         OYUg==
X-Gm-Message-State: AOJu0Yxd3xyxiCsdPXOI1lBK65uwfrOGUqS+pNpGoYviXhDVHj3pXeKp
	yacvVllzbUbULCYAIYjlvRP6hRbpqQ==
X-Google-Smtp-Source: AGHT+IHrobPKFO9W9UfjW0q5XGkO+ESeVvPaamhI/77np1Di3BZ79ZUxiOzxHkMRl60bFPYEg9/IbA==
X-Received: by 2002:a05:6808:16a6:b0:3b8:b063:505a with SMTP id bb38-20020a05680816a600b003b8b063505amr3482938oib.91.1702222671207;
        Sun, 10 Dec 2023 07:37:51 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bi15-20020a056808188f00b003b895806194sm1378654oib.40.2023.12.10.07.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 07:37:50 -0800 (PST)
Received: (nullmailer pid 4148470 invoked by uid 1000);
	Sun, 10 Dec 2023 15:37:49 -0000
Date: Sun, 10 Dec 2023 09:37:49 -0600
From: Rob Herring <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Fabio Estevam <festevam@denx.de>, Fabio Estevam <festevam@gmail.com>, daniel.lezcano@linaro.org, rafael@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: thermal: qoriq-thermal: Adjust
 fsl,tmu-range min/maxItems
Message-ID: <20231210153749.GA4141628-robh@kernel.org>
References: <20230928222130.580487-1-festevam@gmail.com>
 <20231002-unheard-copy-f9dceb6498a9@spud>
 <CAOMZO5Di6Saq_r2k8AkGeANRvXwwx26U=Vf5-Eu-_2Qhu5sDCw@mail.gmail.com>
 <20231209-singular-tighten-eef5f7909dcd@spud>
 <a591318fbba10b764075e9395ddd9f7f@denx.de>
 <20231210-stimulant-halogen-e3aaca2279c5@spud>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231210-stimulant-halogen-e3aaca2279c5@spud>

On Sun, Dec 10, 2023 at 02:52:45PM +0000, Conor Dooley wrote:
> On Sat, Dec 09, 2023 at 05:59:17PM -0300, Fabio Estevam wrote:
> > Hi Conor,
> > 
> > On 09/12/2023 17:23, Conor Dooley wrote:
> > 
> > > You're adding the constraints and items at the wrong level AFAICT.
> > > I think something like the below better matches your constraints?
> > 
> > Thanks for your example.
> > 
> > With your change the fsl,imx93-tmu case works correctly:
> > if I pass the number of fsl,tmu-range entries different than 7,
> > dt_binding_check correctly complains.
> > 
> > However, if I pass 7 entries to fsl,qoriq-tmu it should complain as it
> > expects 4, but it
> 
> btw, unrelated - minItems seems (from a grep) like it needs to be 2 not
> 4.
> 
> > does not.
> > 
> > On top of your patch:
> > 
> > --- a/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
> > +++ b/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
> > @@ -104,7 +104,7 @@ additionalProperties: false
> >  examples:
> >    - |
> >      tmu@f0000 {
> > -        compatible = "fsl,imx93-tmu";
> > +        compatible = "fsl,qoriq-tmu";
> >          reg = <0xf0000 0x1000>;
> >          interrupts = <18 2 0 0>;
> >          fsl,tmu-range = <0x000a0000 0x00090026 0x0008004a 0x0001006a 0 0
> > 0>;
> > 
> > make dt_binding_check DT_SCHEMA_FILES=qoriq-thermal.yaml
> >   LINT    Documentation/devicetree/bindings
> >   DTEX
> > Documentation/devicetree/bindings/thermal/qoriq-thermal.example.dts
> >   CHKDT   Documentation/devicetree/bindings/processed-schema.json
> >   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> >   DTC_CHK
> > Documentation/devicetree/bindings/thermal/qoriq-thermal.example.dtb
> > 
> > Any suggestions?
> 
> I dunno. I spent far far longer than I would like to admit trying to fix
> this. Firstly my suggestion here is crap I think and only applies to
> ___matrices___. I think it needs to be the way you had it in your diff,
> but I cannot figure out why it doesn't apply the maxItems constraint.
> 
> Perhaps Rob or Krzysztof can figure out what we were overlooking.
> The diff in question was something like:

I suspect something is going afoul in the fixups. Will look at it 
tomorrow.

Rob

