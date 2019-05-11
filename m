Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8D781A920
	for <lists+linux-pm@lfdr.de>; Sat, 11 May 2019 20:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbfEKS4r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 11 May 2019 14:56:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43186 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfEKS4r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 11 May 2019 14:56:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id t22so4624218pgi.10
        for <linux-pm@vger.kernel.org>; Sat, 11 May 2019 11:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TkwclHielykQHxqIzEB9Vnj5wJnsSfp+0mnn7BghUuQ=;
        b=GvTDvgtvnl40okW788gaw0ZN8pTAdDZ797fDIrYjGjkpC7XZ8us0qLxuuJAm2SzrXn
         DqIaiNvGdIzLf+kPvbCdYaA6mxSLRvDA+c+b6+1OXYVHWKhort5bpWjoN6a+1vZZrBnu
         tJF+JDIE4ytoWDtoH/En517GXrNfpGsVtk2s7iXWf00tJiebr/0ARB8V8qhSsLFGwCyO
         zteeUoN9rLhPBRQUhEr2UGzEWED0Y0EssCDjV2/buFFXGsvr46xNze/wnHItN/Iim4UZ
         72Gvl878aiwrkzQmF/TMmu4HGRbiDAtR0HzCab1IZwOWaJGlaHkaQpq0ggRU+zUgcjUk
         2Bng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TkwclHielykQHxqIzEB9Vnj5wJnsSfp+0mnn7BghUuQ=;
        b=BG6/dQodxAta1ZZXozN+0mk5+KyPyzhMFKmWiS5TFUnz/pHxouoT1vDSMEZY/Vyo4P
         /nvaExqIBQ1RNuOX5zaBTQILzezVgFc6azBdB2ympw6sV8QcFFsu7y5REMscdgQCQeW5
         +dL65lzSTV/JZUNXZde1cjBKy3EFC5jdovgGhxdW0sr2cGe1WATUW6FvHgp1Y5DT3vkx
         w9iB8U0+XbAI7ZoZXlFe3T7v6sv2wE8Ddu1QIhjaT/sAJlAa02styH/LF4b4hPMc74xT
         ckqnNa8C5w8NfDdEvQvEoUk5o7jU3EIU6MARTOGr7Nk/6++FKdOjefxG8YurO4lQiiUz
         DPow==
X-Gm-Message-State: APjAAAUKOFrKyAgrOKTUBJNeGJBTQfLU7xV2JA+i5yweN7bfCyq8UQGA
        XsAVRUNEHn6i+mRvqGwMbrs=
X-Google-Smtp-Source: APXvYqyGFSoMahfbPU/eZZFbAkWkBAHSd9W2co0SHCnlgWZlcXdL6bN3e5CRklts/DHnMWwwAURlSw==
X-Received: by 2002:a63:c94a:: with SMTP id y10mr22111982pgg.168.1557601006654;
        Sat, 11 May 2019 11:56:46 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:4a55:a659:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id n188sm11753880pfn.64.2019.05.11.11.56.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 11:56:46 -0700 (PDT)
Date:   Sat, 11 May 2019 11:56:43 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Cc:     linux-pm@vger.kernel.org, daniel.lezcano@linaro.org,
        rui.zhang@intel.com
Subject: Re: [PATCH 2/2] dt-bindings: thermal: generic-adc: make lookup-table
 optional
Message-ID: <20190511185639.GA15204@localhost.localdomain>
References: <20190418163733.17414-1-jeff.dagenais@gmail.com>
 <20190418163733.17414-2-jeff.dagenais@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190418163733.17414-2-jeff.dagenais@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

On Thu, Apr 18, 2019 at 12:37:33PM -0400, Jean-Francois Dagenais wrote:

I added a description to this patch, but next time, on your next
patches, describe your change. Description is not an optional field
of a commit, it is very mandatory!


BR,

> Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
> ---
>  .../devicetree/bindings/thermal/thermal-generic-adc.txt        | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/thermal-generic-adc.txt b/Documentation/devicetree/bindings/thermal/thermal-generic-adc.txt
> index d72355502b78..691a09db2fef 100644
> --- a/Documentation/devicetree/bindings/thermal/thermal-generic-adc.txt
> +++ b/Documentation/devicetree/bindings/thermal/thermal-generic-adc.txt
> @@ -8,16 +8,22 @@ temperature using voltage-temperature lookup table.
>  Required properties:
>  ===================
>  - compatible:		     Must be "generic-adc-thermal".
> +- #thermal-sensor-cells:     Should be 1. See ./thermal.txt for a description
> +		             of this property.
> +Optional properties:
> +===================
>  - temperature-lookup-table:  Two dimensional array of Integer; lookup table
>  			     to map the relation between ADC value and
>  			     temperature. When ADC is read, the value is
>  			     looked up on the table to get the equivalent
>  			     temperature.
> +
>  			     The first value of the each row of array is the
>  			     temperature in milliCelsius and second value of
>  			     the each row of array is the ADC read value.
> -- #thermal-sensor-cells:     Should be 1. See ./thermal.txt for a description
> -			     of this property.
> +
> +			     If not specified, driver assumes the ADC channel
> +			     gives milliCelsius directly.
>  
>  Example :
>  #include <dt-bindings/thermal/thermal.h>
