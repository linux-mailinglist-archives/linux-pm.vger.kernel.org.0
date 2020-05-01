Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA231C1F63
	for <lists+linux-pm@lfdr.de>; Fri,  1 May 2020 23:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgEAVNx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 17:13:53 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37245 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgEAVNx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 May 2020 17:13:53 -0400
Received: by mail-ot1-f65.google.com with SMTP id z17so3647986oto.4;
        Fri, 01 May 2020 14:13:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Saj6I4BoNs+neao0qfUiHG20kfrjWQvvyOv909CPCK0=;
        b=pfd3VhNGTwHNWRkhlehcwurM6n51xsrvOtLb8Jbq3H0RYI8Xvc1IlwWIj0AzlhuPIZ
         dhCSb44QAQl1MCM+y+sJCTmrMVBNEH8JOSRwHGXOINY2MDarlUhs58OwV7PgG8fBkTcf
         UrrTxdT0V6un9eyj68ycA6HcpTZD0dkmoiGVtxpsNLj+OW5WgtBGwi4FglT6G0jL8XjJ
         89EBKr0cb9vrsZhYuU+6KjMK0SzGJj/leTP/KFwupMe/470P3CS24CASXEDswwu0d6w+
         78TaT6m3LE8odRTsnPKfeyhlApI+9EIXzAOVO5cEZ2WMacGHwFpRu3lHEJuE3nml+k6o
         aptQ==
X-Gm-Message-State: AGi0PuZFqBslSIJBWq9PaexjrQWMiu0BHJoSKjugw0hCI+7fMiSjcVgz
        Zh4YIujeJ+v4FniewpC8EA==
X-Google-Smtp-Source: APiQypKU8GglYSJQ5ikLjL/rCKqj6Os0VsBVrmhrxMRWf3Z8anowQqyUhYIb1pZqkiENLwXLO0FMtg==
X-Received: by 2002:a9d:6207:: with SMTP id g7mr5298118otj.195.1588367632473;
        Fri, 01 May 2020 14:13:52 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e13sm1102204otj.46.2020.05.01.14.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 14:13:52 -0700 (PDT)
Received: (nullmailer pid 5949 invoked by uid 1000);
        Fri, 01 May 2020 21:13:51 -0000
Date:   Fri, 1 May 2020 16:13:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Dan Murphy <dmurphy@ti.com>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: power: Convert power_supply text to yaml
Message-ID: <20200501211351.GA4774@bogus>
References: <20200430151841.17453-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430151841.17453-1-dmurphy@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 30 Apr 2020 10:18:41 -0500, Dan Murphy wrote:
> Convert the power_supply.txt to power-supply.yaml.
> This conversion entailed fixing up the binding to being yaml and dt
> checker compliant.
> 
> Added a note in the power_supply.txt to reference the power-supply.yaml
> 
> CC: Rob Herring <robh@kernel.org>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  .../bindings/power/supply/power-supply.yaml   | 40 +++++++++++++++++++
>  .../bindings/power/supply/power_supply.txt    | 25 +-----------
>  2 files changed, 42 insertions(+), 23 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/power-supply.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/power/supply/power-supply.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/power/supply/power-supply.yaml#

See https://patchwork.ozlabs.org/patch/1280522

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
