Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A436028F43
	for <lists+linux-pm@lfdr.de>; Fri, 24 May 2019 04:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731697AbfEXCuW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 May 2019 22:50:22 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39404 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731522AbfEXCuV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 May 2019 22:50:21 -0400
Received: by mail-pf1-f194.google.com with SMTP id z26so4375309pfg.6;
        Thu, 23 May 2019 19:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5EPIY/pbD369tpqlqejU7R1YiZWbc6ywy0lqYpQEtdM=;
        b=c2DllOpso5AVzkkHXVu+qbWk5XqTYnoaosdSauvtXEM6CeATCXPU2HbEJcF7sjbW2j
         TctxTr8i0XTElyxQgQO5Cyzi10Fs0nJqM3koRiym1kOGcBD8El8jm3dTnQSkq5XDXls8
         4w/DkMIq9xau7ZdH1c8zIlFllzEjGkV5jf33ZMAoVTksfzStb3YB7mn3O3eywQNPzUIN
         nzC8V4sMyWqYAEE39MHX1uj2bTIA7DtybWVdTBbzXpQ5n4rfOx9/N2vNw3FrjOQ1Ir5q
         TLtiA9EbTD4WbfE+edftd8w3vC8Hmh0/KQ6qJeHIEm37bfihy4sH7qJi3ikT7AtF3WFD
         RXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5EPIY/pbD369tpqlqejU7R1YiZWbc6ywy0lqYpQEtdM=;
        b=cPxTpLhgbxlC1WRmcNrxqM10dVQg4yCsqbFKd5JWjw6tjz7TKEqp4+DnLrPjn5RSJM
         08cOlCX29/k0FU/UuYv6Mhm9I4mF+HMqGsjP4VhBEVyAMH9jPiqRuN2lKV67FtfejOEQ
         eQQplsmkaXmAOM4XYU2OknaSg9ZVXri4PA8/0j0brrM+jIxRK3PQ/B34SLQzEOxu2ONX
         TJkhMywDsjjCJN6eWir+kKaFA85I2EkVDrlJLabHnb+PEBUsHtk+nqp2whMqTlQdxji4
         i03QlQIr6Sl8FsGc6ll6GLl9nQLG9Np6cDMZ3KkrgA+qQQWmfYUwMvLDT1s8Wl87HqMB
         Vfbw==
X-Gm-Message-State: APjAAAVXfhm1PQ73dXYqKeI3xBP+vdAqe/ckiS0/JeRkJvSLj82VZE9J
        jN428WLduxraNiDWFjiYO0w=
X-Google-Smtp-Source: APXvYqwxVidXiS0+EqeoVmwsLOqoIKJwKRoOXpXMybgw5n+Fqj9odHC+S6EmYXD29O06mFuOfNB+0w==
X-Received: by 2002:a63:1e4d:: with SMTP id p13mr103218869pgm.125.1558666220433;
        Thu, 23 May 2019 19:50:20 -0700 (PDT)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id y16sm750850pfl.140.2019.05.23.19.50.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 19:50:19 -0700 (PDT)
Date:   Thu, 23 May 2019 19:50:18 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Yuantian Tang <andy.tang@nxp.com>
Cc:     rui.zhang@intel.com, robh+dt@kernel.org, daniel.lezcano@linaro.org,
        mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: thermal: Make cooling-maps property optional
Message-ID: <20190524025017.GA4146@localhost.localdomain>
References: <20190515093647.47656-1-andy.tang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515093647.47656-1-andy.tang@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 15, 2019 at 05:36:47PM +0800, Yuantian Tang wrote:
> There may be no cooling device on system, or there are no enough
> cooling devices for each thermal zone in multiple thermal zone
> cases since cooling devices can't be shared.
> So make this property optional to remove such limitations.

Yeah, I am  not sure that is enough reason to make this property
optional. Let me maybe ask you why do you care creating a thermal
zone if your control has no actions? Or rather, why bothering
setting up a control that has no actuators?

> 
> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
> ---
>  .../devicetree/bindings/thermal/thermal.txt        |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
> index ca14ba9..694e834 100644
> --- a/Documentation/devicetree/bindings/thermal/thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/thermal.txt
> @@ -142,11 +142,11 @@ Required properties:
>  - trips:		A sub-node which is a container of only trip point nodes
>    Type: sub-node	required to describe the thermal zone.
>  
> +
> +Optional property:
>  - cooling-maps:		A sub-node which is a container of only cooling device
>    Type: sub-node	map nodes, used to describe the relation between trips
>  			and cooling devices.
> -
> -Optional property:
>  - coefficients:		An array of integers (one signed cell) containing
>    Type: array		coefficients to compose a linear relation between
>    Elem size: one cell	the sensors listed in the thermal-sensors property.
> -- 
> 1.7.1
> 
