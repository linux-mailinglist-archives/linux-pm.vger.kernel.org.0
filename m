Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDF3263DAB
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2019 23:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfGIV6O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jul 2019 17:58:14 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44702 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfGIV6N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jul 2019 17:58:13 -0400
Received: by mail-io1-f66.google.com with SMTP id s7so234894iob.11;
        Tue, 09 Jul 2019 14:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Ey61egmeTzlJzdnS3KXDPWo7KaDWydr+b+uOUD/PhiM=;
        b=dGy6QPfFr0GGfn2v93VPxlUrS+5pK+zHvIe+iSUVvUgt53VxHWunGpJC6N9Hd/IfUi
         BFLVQaRYukKyDoaVIct6TNZgZsgl+P5RNNhkx/Ie2hA6+smDyI7ilD6ewgU22LQEHXhI
         CUZCfiuLVyhq5FWbOYGJK26I/rGEBsVIZPhuXHR1DNvfXsQiEPT9BVroU+LRtp+cJvVr
         7jEm70/kZuFRkFDVQe/lsoqJrqYmOIrP5V7gRrm9LChqJqEBrMNKUaVvAPrNbCuJg/79
         GmPinNXqX3r9KjlOSuvcorEOuKlEc7VDd6Jnd7zI5Z28a9vaSoZIw8asjct/jxIp5WMH
         8xCQ==
X-Gm-Message-State: APjAAAXoVtJz01e6xru2Ch7rPzOywAnCaLMqjX7f6+XtYiHHi6K0rV04
        u8J6OeLcfLvItgOsiM5/9A==
X-Google-Smtp-Source: APXvYqw5juZHQchjp5SSeEn+D8SjtVO4k6VtZq4TP772vPqxBVFTwIGj7pgz0nnUSAKu0HaFyjkq1Q==
X-Received: by 2002:a5d:87d6:: with SMTP id q22mr7694894ios.2.1562709492517;
        Tue, 09 Jul 2019 14:58:12 -0700 (PDT)
Received: from localhost ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id p3sm58971iom.7.2019.07.09.14.58.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 14:58:11 -0700 (PDT)
Date:   Tue, 9 Jul 2019 15:58:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     sre@kernel.org, lee.jones@linaro.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings: mfd: max8998: Add charger subnode
 binding
Message-ID: <20190709215810.GB26049@bogus>
References: <20190621115602.17559-1-pawel.mikolaj.chmiel@gmail.com>
 <20190621115602.17559-3-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190621115602.17559-3-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 21, 2019 at 01:56:02PM +0200, Paweł Chmiel wrote:
> This patch adds devicetree bindings documentation for
> battery charging controller as the subnode of MAX8998 PMIC.
> 
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
> Changes from v3:
>   - Property prefix should be maxim, not max8998
>   - Describe what End of Charge in percent means
> 
> Changes from v2:
>   - Make charge-restart-level-microvolt optional.
>   - Make charge-timeout-hours optional.
> 
> Changes from v1:
>   - Removed unneeded Fixes tag
>   - Correct description of all charger values
>   - Added missing property unit
> ---
>  .../devicetree/bindings/mfd/max8998.txt       | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/max8998.txt b/Documentation/devicetree/bindings/mfd/max8998.txt
> index 5f2f07c09c90..368f787d6079 100644
> --- a/Documentation/devicetree/bindings/mfd/max8998.txt
> +++ b/Documentation/devicetree/bindings/mfd/max8998.txt
> @@ -48,6 +48,25 @@ Additional properties required if max8998,pmic-buck2-dvs-gpio is defined:
>  - max8998,pmic-buck2-dvs-voltage: An array of 2 voltage values in microvolts
>    for buck2 regulator that can be selected using dvs gpio.
>  
> +Charger: Configuration for battery charging controller should be added
> +inside a child node named 'charger'.
> +  Required properties:
> +  - maxim,end-of-charge-percentage: End of Charge in percent.
> +    When the charge current in constant-voltage phase drops below
> +    end-of-charge-percentage of it's start value, charging is terminated.
> +    If value equals 0, leave it unchanged. Otherwise it should be value
> +    from 10 to 45 by 5 step.
> +
> +  Optional properties:
> +  - maxim,charge-restart-threshold: Charge restart threshold in millivolts.
> +    If property is not present, this will be disabled.
> +    Valid values are: 0, 100, 150, 200. If the value equals 0, leave it
> +    unchanged.

Needs a unit suffix as defined in property-units.txt.

> +
> +  - maxim,charge-timeout: Charge timeout in hours. If property is not
> +    present, this will be disabled. Valid values are: 0, 5, 6, 7.
> +    If the value equals 0, leave it unchanged.

Needs a unit suffix as defined in property-units.txt.

> +
>  Regulators: All the regulators of MAX8998 to be instantiated shall be
>  listed in a child node named 'regulators'. Each regulator is represented
>  by a child node of the 'regulators' node.
> @@ -97,6 +116,13 @@ Example:
>  		max8998,pmic-buck2-dvs-gpio = <&gpx0 0 3 0 0>; /* SET3 */
>  		max8998,pmic-buck2-dvs-voltage = <1350000>, <1300000>;
>  
> +		/* Charger configuration */
> +		charger {
> +			maxim,end-of-charge-percentage = <20>;
> +			maxim,charge-restart-threshold = <100>;
> +			maxim,charge-timeout = <7>;
> +		};
> +
>  		/* Regulators to instantiate */
>  		regulators {
>  			ldo2_reg: LDO2 {
> -- 
> 2.17.1
> 
