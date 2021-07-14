Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB1F3C9438
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jul 2021 01:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237403AbhGNXM4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Jul 2021 19:12:56 -0400
Received: from mail-io1-f43.google.com ([209.85.166.43]:41771 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbhGNXM4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Jul 2021 19:12:56 -0400
Received: by mail-io1-f43.google.com with SMTP id z9so4145489iob.8;
        Wed, 14 Jul 2021 16:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YLUvGWBUmjKSetxSon9JscWVz0P9qvwgt8I5+BcK8F0=;
        b=sUYyjKG7LNGsMOJri5o1pFOak7pByiK8+rEKFE46hVgTu5MPLkL72pzdyaF6zbWlfC
         A2bQsq6CnscZV1GL94Qc71dkv8Y9cZFM8RbhrATmaEP9ex88n71wwBrV17KsjtmxS7xt
         R6MxwTjbm/IdCpuj/ipo2ohE12BuprdBLMr6BhzHoUa9CTLcKsIMSNf5xoN/0U4vE5SF
         YYjZHZMJU8qS+Od81VboGd9HFANUIQ9BQ0zi6Ow/ZWl5l/M4DPs9NdlH1F0uOHCTHMW9
         WYSvx1FQojOAtFPNdFuoc7h5cK28FqfTzpFsrraH4mdslu0G8PW+V17x2G6YZzOH93XK
         +fXg==
X-Gm-Message-State: AOAM530OhwWiVtn0IIzvZXLfqVqZIuzWz1aw5dVnvjPbo6c7ICdgVUEW
        738H961slHD+RQC6MABsGg==
X-Google-Smtp-Source: ABdhPJwItOx56dX2xisR7HWLFDXoKMNwFdNj1TdV7Khq8AMg+ss+hULiWEara0juvrGDf56/iWljWA==
X-Received: by 2002:a05:6638:289:: with SMTP id c9mr571973jaq.14.1626304202707;
        Wed, 14 Jul 2021 16:10:02 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id u13sm1964286iot.29.2021.07.14.16.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 16:10:02 -0700 (PDT)
Received: (nullmailer pid 3713794 invoked by uid 1000);
        Wed, 14 Jul 2021 23:10:00 -0000
Date:   Wed, 14 Jul 2021 17:10:00 -0600
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
Subject: Re: [PATCH v3 02/12] dt-bindings: phy: tegra20-usb-phy: Document
 properties needed for OTG mode
Message-ID: <20210714231000.GB3697673@robh.at.kernel.org>
References: <20210704225433.32029-1-digetx@gmail.com>
 <20210704225433.32029-3-digetx@gmail.com>
 <20210712154139.GB1980362@robh.at.kernel.org>
 <8fe56e89-9e1e-f5e2-5a47-242b5b3d085a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8fe56e89-9e1e-f5e2-5a47-242b5b3d085a@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 13, 2021 at 02:33:11AM +0300, Dmitry Osipenko wrote:
> 12.07.2021 18:41, Rob Herring пишет:
> >> +  nvidia,pmc:
> >> +    $ref: /schemas/types.yaml#/definitions/phandle
> >> +    description:
> >> +      Phandle to Power Management controller.
> >> +
> > Add a cell to this for the PHY reg offset and then get rid of the index:
> > 
> >> +  nvidia,phy-instance:
> >> +    $ref: /schemas/types.yaml#/definitions/uint32
> >> +    minimum: 0
> >> +    maximum: 2
> >> +    description: Unique hardware ID.
> 
> The instance ID belongs to the USB h/w and not to PMC. It may look like
> I added the ID just to get offsets within PMC, but it's not like that.
> The Tegra documentation explicitly assigns unique IDs to the USB
> controllers and PHYs. Hence this ID should be the property of the PHY
> hardware, IMO.

It looks like the use is calculating register offsets in a PMC register. 
That's quite common and including that with the phandle is the preferred 
way to describe it.

Lots of docs have UART1, UART2, UART3, etc. module numbering. We don't 
copy that into DT.

Rob

