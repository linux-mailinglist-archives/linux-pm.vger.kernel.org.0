Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C1C2D6E42
	for <lists+linux-pm@lfdr.de>; Fri, 11 Dec 2020 03:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391168AbgLKCx0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Dec 2020 21:53:26 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38236 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390721AbgLKCxZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Dec 2020 21:53:25 -0500
Received: by mail-ot1-f66.google.com with SMTP id j20so2517707otq.5;
        Thu, 10 Dec 2020 18:53:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u730lB6v0y2irZRjPgn18dAMkQ87hO91KDEoZMKd5FM=;
        b=KzvBG2QNrwLXVueZ/2MyvoC4b6XnKBEvN57MZtzR9PRxew+0ZfTWPW+ERlqIZ8VAUO
         dx9sqnwTJ5patWmW85xduMXHCstTuA4HoTz6R/M6EZLkyBDJ91L5PIRKmZnbsGvIa/dA
         NrMWAO3f6sL0viGP4I/ZtqMJlL37jw2EjSm+gV6+enwQtZnaNTyx90/AvKp2o+dOHXnn
         i7XxNsWIiwR5iezmhrsVPW3L7QSaR6qNKceYxV/ud5Wk6988ksIK3SXF2jz4ZW681eEZ
         tXu8Z1OF8rcyESWlv9L2TbW7UvRro5HYLwQI52XdwB0hzcWvAj5spijTmPHHs4iEks6E
         JwRA==
X-Gm-Message-State: AOAM533z+RWfoe6tqMKNAvs6qVp60F/L6+eoqFnmidsoea+QMun2WBvU
        kQHQAfFYq1Nas9u16yVt5Q==
X-Google-Smtp-Source: ABdhPJyQrHbhg+o5ePEtwFe/gxJay541KZcQ7oM/4+PltW0Q7qTn20f08qBYHe84hCLamudqakGgCg==
X-Received: by 2002:a05:6830:240d:: with SMTP id j13mr8344090ots.319.1607655164861;
        Thu, 10 Dec 2020 18:52:44 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y84sm1570664oig.36.2020.12.10.18.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 18:52:43 -0800 (PST)
Received: (nullmailer pid 3524654 invoked by uid 1000);
        Fri, 11 Dec 2020 02:52:42 -0000
Date:   Thu, 10 Dec 2020 20:52:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hector Yuan <hector.yuan@mediatek.com>
Cc:     wsd_upstream@mediatek.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v9 2/2] dt-bindings: cpufreq: add bindings for MediaTek
 cpufreq HW
Message-ID: <20201211025242.GA3523811@robh.at.kernel.org>
References: <1607586516-6547-1-git-send-email-hector.yuan@mediatek.com>
 <1607586516-6547-3-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607586516-6547-3-git-send-email-hector.yuan@mediatek.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 10 Dec 2020 15:48:36 +0800, Hector Yuan wrote:
> From: "Hector.Yuan" <hector.yuan@mediatek.com>
> 
> Add devicetree bindings for MediaTek HW driver.
> 
> Signed-off-by: Hector.Yuan <hector.yuan@mediatek.com>
> ---
>  .../bindings/cpufreq/cpufreq-mediatek-hw.yaml      |  112 ++++++++++++++++++++
>  1 file changed, 112 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml: 'additionalProperties' is a required property
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml: ignoring, error in schema: 
warning: no schema found in file: ./Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml


See https://patchwork.ozlabs.org/patch/1413865

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

