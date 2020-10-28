Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380B229DABD
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 00:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390440AbgJ1X3E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Oct 2020 19:29:04 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38212 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390456AbgJ1X27 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2020 19:28:59 -0400
Received: by mail-oi1-f196.google.com with SMTP id 9so1386093oir.5;
        Wed, 28 Oct 2020 16:28:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=po6rWvf724844GvfQdAQJ9iq1eJb6p+ZDm6wv8whpKk=;
        b=E5xxqK6y7A79J3A2gp3w3+vTOfQiOMxi6t5bTg7TpDNMz7tnwQw9NDm5ocCy8R9Qon
         dVbxELWxqe0cs3lWe84efB6XhBt186vQeUul0ze6wwqW0AUGqprrSMJmcGIIdk3y1/R7
         hn/NdDx/dQ7c3Cx+y0ayvqK1vMqTNIVRXf0NKTNDZafSGBzFfuHO4jGv8fs6VnfV/U5U
         gC2tAzWHQpqxfp5xwGyVOHPgvXWTkkj8DuZVEDe/LrfOYsgWk+JDV4AvG+AKtYFPRmwk
         yKwMKipu3dSf8O2M5ozM+Dtapg+CJ6BtxfL9qs+z8pczZiDmOzKMo9QM/6EdTYHlFwjU
         sZOA==
X-Gm-Message-State: AOAM531sm5KZhZpkpivhBe26LFj6sI3V0Yz7yT01b9aZ6LH3kjB77wst
        J7/wTD9QFr3IdIyKApxtCO0ocRDXZQ==
X-Google-Smtp-Source: ABdhPJyEh7pfMoCDgab0DcqZOZs2B3jYAs6qTKZm/Uw5JJr14+poImxFufG/tuafS8zONyupbh4GOQ==
X-Received: by 2002:a05:6808:4d3:: with SMTP id a19mr5186027oie.10.1603896170982;
        Wed, 28 Oct 2020 07:42:50 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 61sm2196489otc.9.2020.10.28.07.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 07:42:50 -0700 (PDT)
Received: (nullmailer pid 3992502 invoked by uid 1000);
        Wed, 28 Oct 2020 14:42:49 -0000
Date:   Wed, 28 Oct 2020 09:42:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, sre@kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: power/supply: Add ltc4162-l-charger
Message-ID: <20201028144249.GA3992062@bogus>
References: <20201027070938.10157-1-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027070938.10157-1-mike.looijmans@topic.nl>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 27 Oct 2020 08:09:38 +0100, Mike Looijmans wrote:
> Add support for the LTC4162-L Li-Ion battery charger. The driver allows
> reading back telemetry and to set some charging options like the input
> current limit.
> 
> This adds the devicetree bindings.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
> v2: Use microohms, add lltc,cell-count
> 
>  .../bindings/power/supply/ltc4162-l.yaml      | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/supply/ltc4162-l.example.dt.yaml: battery-charger@68: 'lltc,rsnsb', 'lltc,rsnsi' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml


See https://patchwork.ozlabs.org/patch/1388291

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

