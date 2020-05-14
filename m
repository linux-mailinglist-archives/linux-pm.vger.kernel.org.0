Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB691D3489
	for <lists+linux-pm@lfdr.de>; Thu, 14 May 2020 17:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgENPJH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 May 2020 11:09:07 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44337 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgENPJG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 May 2020 11:09:06 -0400
Received: by mail-oi1-f194.google.com with SMTP id a2so24613398oia.11;
        Thu, 14 May 2020 08:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pEb8Z2pMkkbfNV7pCxLtoRmGyd419uEf0xyvpMZy978=;
        b=W7stWmPAgpc4oQ1dJvRCckEPqKVXjFF9my7CGSL+VcBRZgEQzp5nDZfI6QEamd9LKw
         CdIHvkFcdF4NAklzfcYHGSETc3XOCiwkPMYzu5rKweM6+/L4UanPfcCsRqGMtorgEfNO
         L6N8atZsMn7S+aG7w2PL94BmKafh1yZfrZnHpjvplCxxJOnh2Bz6gdL1jSJZkRaUAUGo
         lwLYspP9d5VzD3ACBfJVw700x76PSU7VPo9hRRaGzCGZiLDC/Q1hdWEbX3Gfb3dTtyJ/
         8I3ZReu7InNAgshfpbtmpa8HWOImP+/sL56PVwkpRclmKmZzDYuHpleXYAUItFealmw/
         bLIw==
X-Gm-Message-State: AGi0PuYp8D52C84tZuk+kwQ56tOqJCNsCVqM/GEZz+HNaVNDctswR338
        rEqMG0DuoLj8trFzbgnj1g==
X-Google-Smtp-Source: APiQypLVRNwGWhiz/pLryvwHAj1Sc7jqWQATwc7y3kNeYCvEkOxVAGZwsNHFpv/Mc94Bdfgu+ChEGg==
X-Received: by 2002:a05:6808:7dc:: with SMTP id f28mr31904197oij.88.1589468945619;
        Thu, 14 May 2020 08:09:05 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l192sm857550ooc.3.2020.05.14.08.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 08:09:04 -0700 (PDT)
Received: (nullmailer pid 28879 invoked by uid 1000);
        Thu, 14 May 2020 15:09:03 -0000
Date:   Thu, 14 May 2020 10:09:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sergey.Semin@baikalelectronics.ru
Cc:     devicetree@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, Paul Burton <paulburton@kernel.org>,
        linux-mips@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v2 01/20] dt-bindings: power: Convert mti,mips-cpc to DT
 schema
Message-ID: <20200514150903.GA28744@bogus>
References: <20200306124807.3596F80307C2@mail.baikalelectronics.ru>
 <20200506174238.15385-1-Sergey.Semin@baikalelectronics.ru>
 <20200506174238.15385-2-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506174238.15385-2-Sergey.Semin@baikalelectronics.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 6 May 2020 20:42:19 +0300,  wrote:
> From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> It's a Cluster Power Controller embedded into the MIPS IP cores.
> Currently the corresponding dts node is supposed to have compatible
> and reg properties.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-pm@vger.kernel.org
> 
> ---
> 
> Changelog v2:
> - Reword the changelog summary - use shorter version.
> - Lowercase the example hex'es.
> ---
>  .../bindings/power/mti,mips-cpc.txt           |  8 -----
>  .../bindings/power/mti,mips-cpc.yaml          | 35 +++++++++++++++++++
>  2 files changed, 35 insertions(+), 8 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/mti,mips-cpc.txt
>  create mode 100644 Documentation/devicetree/bindings/power/mti,mips-cpc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
