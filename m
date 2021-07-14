Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9F23C9428
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jul 2021 01:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237313AbhGNXEh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Jul 2021 19:04:37 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:34506 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbhGNXEg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Jul 2021 19:04:36 -0400
Received: by mail-io1-f44.google.com with SMTP id g22so4202866iom.1;
        Wed, 14 Jul 2021 16:01:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iWYj7BYmLf4sE9pZYmPOjA7KWU/Cdxu9ZYSyNE9Xa2o=;
        b=CQX9I86nolMTA+nUCqykOHWs1MpTYKS1kP4Xoh+GVhuif5TTLZ+rBapSAP5afKv9ga
         yiO8k80LBmwnd+2t62Sgk8UjPfWkW5J7EmzfybmH2zaNoW0t2U9T81/BdrKwqzYFvn7h
         SZzihneyU/I67HaOL1n5mql4FS2AVJByG9ixER06ynfQ6K66Ff2KKm+zP5dTcl67fnz1
         MckFkKlFK6wxo58/k+WKGwNL9HRdjeJgfl4eOaZoqfNnLqHZ0C0DPLiaS6v/F9TrajgL
         /WXVT6UDUqwQWdxh03CM5GLkK7gND5rC/Om+EjNjdlZxt6TPwnq4RpN5SqS7VYh7GDlu
         RmIg==
X-Gm-Message-State: AOAM5324E19B95MeIlgVa0Fc9b+dkLKKeQW5t5nZ9G0ZhLLl6hQdICEp
        dafCAAIgjqrQCuxa2akB8g==
X-Google-Smtp-Source: ABdhPJxRnII1A4P7617nk+P/dL3rkhW199nEWSWXEjBvCWsHF3w+QlDdvckSGvOuEEncV11dSrn9uQ==
X-Received: by 2002:a6b:6016:: with SMTP id r22mr407400iog.12.1626303703032;
        Wed, 14 Jul 2021 16:01:43 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id l8sm2217302iok.26.2021.07.14.16.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 16:01:42 -0700 (PDT)
Received: (nullmailer pid 3701173 invoked by uid 1000);
        Wed, 14 Jul 2021 23:01:40 -0000
Date:   Wed, 14 Jul 2021 17:01:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Heidelberg <david@ixit.cz>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 06/12] dt-bindings: power: supply: smb347-charger:
 Document USB VBUS regulator
Message-ID: <20210714230140.GA3697673@robh.at.kernel.org>
References: <20210704225433.32029-1-digetx@gmail.com>
 <20210704225433.32029-7-digetx@gmail.com>
 <20210712153905.GA1980362@robh.at.kernel.org>
 <9032e807-b4d3-bacf-6c39-d3a2c7c57f3e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9032e807-b4d3-bacf-6c39-d3a2c7c57f3e@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 13, 2021 at 03:22:40AM +0300, Dmitry Osipenko wrote:
> 12.07.2021 18:39, Rob Herring пишет:
> >> +  summit,inok-polarity:
> >> +    description: |
> >> +      Polarity of INOK signal indicating presence of external power supply.
> >> +    $ref: /schemas/types.yaml#/definitions/uint32
> >> +    enum:
> >> +      - 0 # SMB3XX_SYSOK_INOK_ACTIVE_LOW
> >> +      - 1 # SMB3XX_SYSOK_INOK_ACTIVE_HIGH
> >> +
> >> +  usb-vbus:
> >> +    $ref: "../../regulator/regulator.yaml#"
> >> +    type: object
> >        unevaluatedProperties: false
> > 
> > With that,
> > 
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > 
> 
> I tried to add the unevaluatedProperties + a random unrelated property
> to the example usb-vbus node and dt_binding_check is happy with that. So
> the unevaluatedProperties has no effect, is it supposed to be so?

Yes, until support lands upstream[1].

Rob

[1] https://github.com/Julian/jsonschema/pull/817
