Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C137719A196
	for <lists+linux-pm@lfdr.de>; Wed,  1 Apr 2020 00:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730014AbgCaWF2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Mar 2020 18:05:28 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41632 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728493AbgCaWF2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Mar 2020 18:05:28 -0400
Received: by mail-io1-f66.google.com with SMTP id b12so7267239ion.8;
        Tue, 31 Mar 2020 15:05:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7gyHDuCCObLbwOhDgDLIB3IBv9q5ANpOPQTizzDSzp0=;
        b=OnpU/umN6BEcbm9jH8esKZmgTWL206z6AOmN45u6yUpn5M4wvqeI6iPZ+j1Zeeux8w
         VBMSzR1CnE3FayWwqgl7wv/vIYe6/ZGG5+qgNPafEl4k9D/Ilsq+9lQKc908v+p18Dvt
         Hy0wy1U6yxTGRvUp/m7gVPkQUdpFuDS5jwm3KEAHd5YVuLP/hSXe5hG3MRlhPD5MCDYp
         RjUoFG4z5nRSpDx8JxaiJTXs3ZNArW6R+250wwe6s6kAA1LiOUTLXy2y1LlX/qqG0QZY
         Q3DIqlknQ84yLMKV5/ga5/z/+X/1Js6dYxsi0mA0uaq7zHBUFh5TmDgs13LJrY4ZMBTh
         rAbw==
X-Gm-Message-State: ANhLgQ20fm3vTV8AM+l/Gq5TtgitIyho/LT4ZHcmyAvJgIxc7A0knCVo
        bx3qgptNlLsLXCXxQLK04g==
X-Google-Smtp-Source: ADFU+vsSpOsZ8Wc5swgJ7BDjH/PlcggrqpxIHsrUj7g2brTbnTX5zZ608Wo6F6HlLOic/Op0/GNsQQ==
X-Received: by 2002:a02:dc6:: with SMTP id 189mr17932359jax.100.1585692325439;
        Tue, 31 Mar 2020 15:05:25 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id r5sm48089ioc.6.2020.03.31.15.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 15:05:24 -0700 (PDT)
Received: (nullmailer pid 28953 invoked by uid 1000);
        Tue, 31 Mar 2020 22:05:23 -0000
Date:   Tue, 31 Mar 2020 16:05:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     devicetree@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: Add some constraints for PSCI nodes
Message-ID: <20200331220523.GA28810@bogus>
References: <20200326105626.6369-1-ulf.hansson@linaro.org>
 <20200326105626.6369-2-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326105626.6369-2-ulf.hansson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 26 Mar 2020 11:56:25 +0100, Ulf Hansson wrote:
> There's no point allowing anything else but "psci" for the corresponding
> nodename of the PSCI node, so let's make this an explicit requirement.
> 
> Moreover, let's also prevent additional properties, which also allows a
> better verification of the "patternProperties" bindings for subnodes.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/psci.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Applied, thanks.

Rob
