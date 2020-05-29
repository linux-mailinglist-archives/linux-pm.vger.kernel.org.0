Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56AE51E87B5
	for <lists+linux-pm@lfdr.de>; Fri, 29 May 2020 21:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgE2TZT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 May 2020 15:25:19 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:46874 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgE2TZS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 May 2020 15:25:18 -0400
Received: by mail-il1-f193.google.com with SMTP id h3so3567322ilh.13;
        Fri, 29 May 2020 12:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+jsSD39hHvQLjp8xO9x55ruARe4jwgzpVQAoeALrzvY=;
        b=J4UWS1kPgEHqUo5RpbupsnJMCrd+/ZQ9cwvQS7R/lxeCEHs5SetTOEow8kollJoy5f
         fhbJuxZrysU8Xbm90hNz8siOe9zXAUCcmzdBd5ACWHe5vQWWCK8F4lZKpxtjBdBc3vbm
         ZCb5jCROtqjkC9qlrSe7TXQnOs24SH6TNZ7UI07VM6TfE3bsX4Uvg9XHEwtyE5MnBfLL
         cr7KEKe86/APlJ42RFdq6gjIY0EmgDqbymtFKiVANrzeMMI/QAyB2Mg/Tcze6LcMTzQg
         FHOeMPWyZmKVYmx8oKzfZuVWJlGpZ/CHrrJ2/fTvVOXDIR7k2Mg8w5Y02eVlUVtWzKPG
         tmbg==
X-Gm-Message-State: AOAM530gmaBg+RV3xLu1nzDMy1fG5Npaw2qLoVm1OJFAu3CBSRjgc+yc
        ERmY1p+PZezGjvWMM8qZqw==
X-Google-Smtp-Source: ABdhPJy2GDRwX3hp0pcVeHeUGDjVSeXbX7VRrqLtjS92UWLZVzEIgHXCzs8i72mp5vc9GsbHJd+wRw==
X-Received: by 2002:a92:6411:: with SMTP id y17mr9126428ilb.161.1590780317943;
        Fri, 29 May 2020 12:25:17 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id e184sm3443315iof.44.2020.05.29.12.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 12:25:17 -0700 (PDT)
Received: (nullmailer pid 2796388 invoked by uid 1000);
        Fri, 29 May 2020 19:25:16 -0000
Date:   Fri, 29 May 2020 13:25:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     afd@ti.com, linux-pm@vger.kernel.org, sre@kernel.org,
        linux-kernel@vger.kernel.org, pali@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: power: Add BQ27561 compatible
Message-ID: <20200529192516.GA2796309@bogus>
References: <20200528122147.6171-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528122147.6171-1-dmurphy@ti.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 28 May 2020 07:21:44 -0500, Dan Murphy wrote:
> Add the Texas Instruments bq27561 battery monitor to the bq27xxx
> binding.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  Documentation/devicetree/bindings/power/supply/bq27xxx.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
