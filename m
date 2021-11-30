Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41E1462A28
	for <lists+linux-pm@lfdr.de>; Tue, 30 Nov 2021 03:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237279AbhK3CIH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Nov 2021 21:08:07 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:34326 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbhK3CIG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Nov 2021 21:08:06 -0500
Received: by mail-ot1-f52.google.com with SMTP id x19-20020a9d7053000000b0055c8b39420bso28174822otj.1;
        Mon, 29 Nov 2021 18:04:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wbQymcP+21yk6oynLQVFlXzpHpqZPTkxpaAmnOmiAFM=;
        b=Rbft+u1rKEMXkuI5ANkmSTHn4FhtiLYwl7D4Uq1Sk3JQ0m6ONKhb6NmsQM2wgzGVjV
         vsA0QexDVb6W8Y+RSpOz8wyffd6nZ0FS4YxMkt+ZCDNamwpMDlvF9rutGUq0VVwaecGR
         859vh+gvHsfhrIFlbKWfhAjnsmKEtYsYxskkt+mcaBJnsoh0mk25xeCTlGigJmSs41gZ
         tkfaw7GElzenQl+pIyU/8HQMvK9YC/GxqSr/g2W+/iX+3Z+c+H0rUzY4kYXEj02UnUS6
         MRbm6hhANTdNdf2zBbusV/gOBLr7bO6gxKRR8FZ1Oo7YrVsS9Athiehq91B56YZYTBSV
         tCFg==
X-Gm-Message-State: AOAM530AzJ9j+vPjJaxgi0ym4daqlmasQDAQDHLXn6DxcB25rnN0+W3r
        /4I5BcM5iqXmA+Neu5cXSg==
X-Google-Smtp-Source: ABdhPJwmzEi4PMk2SlLn/PHaE2RR7lx9hJxlOFilZE2im0L+wCpcji+Wt2GwlyM7yGa4BLqn/kdOhw==
X-Received: by 2002:a05:6830:4119:: with SMTP id w25mr47075376ott.256.1638237887848;
        Mon, 29 Nov 2021 18:04:47 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c9sm2644025oog.43.2021.11.29.18.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 18:04:47 -0800 (PST)
Received: (nullmailer pid 1026610 invoked by uid 1000);
        Tue, 30 Nov 2021 02:04:46 -0000
Date:   Mon, 29 Nov 2021 20:04:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-pm@vger.kernel.org, Biju Das <biju.das@bp.renesas.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: thermal: Document Renesas RZ/G2L TSU
Message-ID: <YaWGvmJZrfP/Ujyj@robh.at.kernel.org>
References: <20211120194711.9073-1-biju.das.jz@bp.renesas.com>
 <20211120194711.9073-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211120194711.9073-2-biju.das.jz@bp.renesas.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 20 Nov 2021 19:47:10 +0000, Biju Das wrote:
> Document the Thermal Sensor Unit(TSU) in the RZ/G2L SoC.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2:
>  * No change
> ---
>  .../bindings/thermal/rzg2l-thermal.yaml       | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
