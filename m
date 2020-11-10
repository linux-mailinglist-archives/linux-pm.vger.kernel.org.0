Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C342AD8B9
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 15:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbgKJO0P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 09:26:15 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34943 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730059AbgKJO0P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 09:26:15 -0500
Received: by mail-oi1-f196.google.com with SMTP id c80so14507637oib.2;
        Tue, 10 Nov 2020 06:26:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=I6eINwgPGvryXHeca8G+4NRiZwWs6cwo0lxUCGUsnnM=;
        b=PDirRAStIMa4VK87ur1eXW+HxdYLTp3veN5PPtGWpTaeFKqJ8DSCP9RlrmN427wTmL
         i+xNUO0vZNro8rE8nB4LUSrSzNL8oJ7kEnjFtMSzxxIlTdcYAZlrEdZbMIbaiBF+Nvji
         N+aisTLlQ0RuwkcV5Vqd4sdKIj3Dp8DShbXie+uH+UF2LTGMVCtsPyWARwOIxaadAFRn
         4GGvMOK1y6B385Jmf5HQWhEb8ld8EJ6skFLbP48yjRnCplWXIqfyStweXvx3wvekcczT
         I9kIJjks60qp3QUgvJW9iQZ4Gm9t9k7B/JUXddIIiMfMHwPZ0zwhmth1OIMMjS/Wa/S8
         9UWQ==
X-Gm-Message-State: AOAM533T0gnDGq7UbhcrQZDzJg2bSuDaJry2Tsp0jIltZcIkRBl81oON
        wv1z3o4qXGJ+Q3ZisO/DMw==
X-Google-Smtp-Source: ABdhPJxmEBz2DgpgaTJfUBpq6k0kGF8zZgE3ZaEHQ0GkfG/X/Rq/tzCx9MOVxL5mhsN1tNj0erLv8A==
X-Received: by 2002:aca:ea54:: with SMTP id i81mr2775381oih.48.1605018374555;
        Tue, 10 Nov 2020 06:26:14 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 33sm3265678otr.25.2020.11.10.06.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 06:26:13 -0800 (PST)
Received: (nullmailer pid 3120474 invoked by uid 1000);
        Tue, 10 Nov 2020 14:26:12 -0000
Date:   Tue, 10 Nov 2020 08:26:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     krzk@kernel.org, sw0312.kim@samsung.com, myungjoo.ham@samsung.com,
        devicetree@vger.kernel.org, georgi.djakov@linaro.org,
        dri-devel@lists.freedesktop.org, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com,
        a.swigon@samsung.com
Subject: Re: [PATCH v8 1/7] dt-bindings: devfreq: Add documentation for the
 interconnect properties
Message-ID: <20201110142612.GA3120426@bogus>
References: <20201104103657.18007-1-s.nawrocki@samsung.com>
 <CGME20201104103718eucas1p1c103f1a96499b03c72e5457ac2542c3d@eucas1p1.samsung.com>
 <20201104103657.18007-2-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201104103657.18007-2-s.nawrocki@samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 04 Nov 2020 11:36:51 +0100, Sylwester Nawrocki wrote:
> Add documentation for new optional properties in the exynos bus nodes:
> interconnects, #interconnect-cells, samsung,data-clock-ratio.
> These properties allow to specify the SoC interconnect structure which
> then allows the interconnect consumer devices to request specific
> bandwidth requirements.
> 
> Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes for v8:
>  - updated description of the interconnects property,
>  - fixed typo in samsung,data-clk-ratio property description.
> 
> Changes for v7:
>  - bus-width property replaced with samsung,data-clock-ratio,
>  - the interconnect consumer bindings used instead of vendor specific
>    properties
> 
> Changes for v6:
>  - added dts example of bus hierarchy definition and the interconnect
>    consumer,
>  - added new bus-width property.
> 
> Changes for v5:
>  - exynos,interconnect-parent-node renamed to samsung,interconnect-parent
> ---
>  .../devicetree/bindings/devfreq/exynos-bus.txt     | 71 +++++++++++++++++++++-
>  1 file changed, 69 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
