Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6AF24789E
	for <lists+linux-pm@lfdr.de>; Mon, 17 Aug 2020 23:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgHQVQt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Aug 2020 17:16:49 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40427 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbgHQVQs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Aug 2020 17:16:48 -0400
Received: by mail-io1-f66.google.com with SMTP id b17so19078881ion.7;
        Mon, 17 Aug 2020 14:16:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IsLSq9CX8/IcF3TJcsfIQoHuBNyqx/iYeu+GElMr1HA=;
        b=UIaH7Wc8gd0Dfb4xRLljdnD8/sm/ib6uJbhtKQH6DCOjJqOH1ifOETVXHE3lRc8riq
         a72gUQHsMNqBiQ4MnIKDJtgglYcKJBimSQHekTDI/oZOS4kzJ+5s+sSvQaXJdHaVLDHx
         /ZxF4t0dg/c/k6Odb1MKUucQtO8GtMHSejUHcvrLn9EMJpL6Ht3RcPswodtEo7850iC6
         Kydf1EUPDuWfNjzSk1a9lPZEwe5y0re9trrGnlAH2nbQKWZ/CZmYw2vYjN1xnZRO9Nt7
         yiyUC1HNo3JKBh4PTdRTsmF0c5hqhGj5g8/IGdOkDOAUrIXaIxL+7SNn+MQmX7hYsSac
         50cw==
X-Gm-Message-State: AOAM530oxDxTKI8PXNsDgpCaROFZdmoGHf+rNmzTHQhhECU9qapDuoPh
        m9k8awOHvlf8B47YzRAeFQ==
X-Google-Smtp-Source: ABdhPJwtpOkoanjn6tG93giti5BHsoBTWUK3EdKLtgfghY5Ncjt7hylAWx2MJOYt1WneXEDZJEhdTg==
X-Received: by 2002:a6b:e40b:: with SMTP id u11mr14314669iog.123.1597699007578;
        Mon, 17 Aug 2020 14:16:47 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id x9sm9781291ior.12.2020.08.17.14.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 14:16:47 -0700 (PDT)
Received: (nullmailer pid 1577557 invoked by uid 1000);
        Mon, 17 Aug 2020 21:16:46 -0000
Date:   Mon, 17 Aug 2020 15:16:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, jonathan@marek.ca,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, bjorn.andersson@linaro.org,
        georgi.djakov@linaro.org, agross@kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH 4/7] dt-bindings: interconnect: Add EPSS L3 DT binding on
 SM8250
Message-ID: <20200817211646.GA1577485@bogus>
References: <20200801123049.32398-1-sibis@codeaurora.org>
 <20200801123049.32398-5-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200801123049.32398-5-sibis@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 01 Aug 2020 18:00:46 +0530, Sibi Sankar wrote:
> Add Epoch Subsystem (EPSS) L3 interconnect provider binding on SM8250
> SoCs.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  .../devicetree/bindings/interconnect/qcom,osm-l3.yaml          | 1 +
>  include/dt-bindings/interconnect/qcom,osm-l3.h                 | 3 +++
>  2 files changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
