Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D944118DB42
	for <lists+linux-pm@lfdr.de>; Fri, 20 Mar 2020 23:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgCTWiX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Mar 2020 18:38:23 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43941 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgCTWiW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Mar 2020 18:38:22 -0400
Received: by mail-io1-f66.google.com with SMTP id n21so7639493ioo.10;
        Fri, 20 Mar 2020 15:38:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qSFUyWECzAXW0HX43CgH2zDgAz8AxAWVffEW3w/kp5o=;
        b=oPRpCt+c35KS/HB2OnqzfwEBwfyAfZmsFwPRVh4v+jzWw/+7/K1VWXQdcsEcWLi0vl
         C5OEd/4f2TTyeBDGR1/iDp5p89j/7r0AiOfnJof8AzVP78fhgL2InJ765EQfwXy5BWRN
         Ny9h1mul29iNSQdzkj2/JabhHSrhCbmje46E9ON9MgWJoUTBy6zL4p8SsF4G+OwTRgWy
         h5sPp+OxE6ZeH+2T2zCpD4LkzoP5g/ALphIjgkEgzQo+ssqRLI4I1ZDjQCg7VQkVWpex
         MWjrbkyDr+aZP1ZJiOIMbfSE2ZQ04RSNcRzKvjZFMZqxcFJK2kUVUm6i6NrKN1W2a0jL
         wQAw==
X-Gm-Message-State: ANhLgQ2wWkurAKT6sayLxoxlP/7EDSktQE4jXQbhzrmomGHIGeUnp48+
        lO/2zdvNjQWxG6jK5EpD4Q==
X-Google-Smtp-Source: ADFU+vtdBLoVFwGWQgsKmCoa9A7999apEHu+ZaZVMplwZDVgvWAW6SOKN3FTPrzrV0mrY+rEp0Ct5g==
X-Received: by 2002:a6b:7504:: with SMTP id l4mr9722601ioh.184.1584743901517;
        Fri, 20 Mar 2020 15:38:21 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id n29sm2386822ila.86.2020.03.20.15.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 15:38:20 -0700 (PDT)
Received: (nullmailer pid 26889 invoked by uid 1000);
        Fri, 20 Mar 2020 22:38:18 -0000
Date:   Fri, 20 Mar 2020 16:38:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com,
        Sebastian Reichel <sre@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Laine <markus.laine@fi.rohmeurope.com>,
        Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>
Subject: Re: [PATCH v5 2/9] dt_bindings: ROHM BD99954 Charger
Message-ID: <20200320223818.GA26851@bogus>
References: <cover.1584468798.git.matti.vaittinen@fi.rohmeurope.com>
 <a697e85a2c21758e00a28ca64b6e55ff7fb2f7d0.1584468798.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a697e85a2c21758e00a28ca64b6e55ff7fb2f7d0.1584468798.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 18 Mar 2020 13:49:47 +0200, Matti Vaittinen wrote:
> The ROHM BD99954 is a Battery Management LSI for 1-4 cell Lithium-Ion
> secondary battery. Intended to be used in space-constraint equipment such
> as Low profile Notebook PC, Tablets and other applications. BD99954
> provides a Dual-source Battery Charger, two port BC1.2 detection and a
> Battery Monitor.
> 
> Document the DT bindings for BD99954
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
> 
> 
> Changes since v4:
>  - change compatible name and file name accordingly
>  - Fix the title
> 
> 
> 
>  .../bindings/power/supply/rohm,bd99954.yaml   | 155 ++++++++++++++++++
>  1 file changed, 155 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/rohm,bd99954.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
