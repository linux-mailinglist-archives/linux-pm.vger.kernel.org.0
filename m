Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83B6B9EC8E
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2019 17:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbfH0P1J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Aug 2019 11:27:09 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44969 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfH0P1J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Aug 2019 11:27:09 -0400
Received: by mail-ot1-f67.google.com with SMTP id w4so19011266ote.11;
        Tue, 27 Aug 2019 08:27:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4hpxnmJP4KU/1OJr6+4sa9RXeNI65BLZtzZhrkj77uw=;
        b=nQgJacm2lGWk0IDYn/sacM7egbudQbz3nTQ2PkSbFroSN9artqINDXTN0mnCQNrnG0
         buTUsz89gXM1HC7Z61VyjDJLnPto4ZGsXv+RyMxi6XeIL14Ldw2vXfJ3XVj0/vGjSqou
         4Q8NlWGViY7mKBEhTgUShmMUNMU4vwx4nK0wZICte27Ws0413yiQvputjUBS/9Wf82vF
         d48sRwX+Z8W6GYxDaJP57fxW0ZS1LXVnpXPIHwVib9dJYvZ1encXqMElYWjhIl5Qd2zj
         dFDtg0mJx3yzR5YnUEJRmw/Co3Cdp5whGhgbktV3EMgL7q3oq1lqKdk/aBsyMWTBShp1
         53qg==
X-Gm-Message-State: APjAAAXiW4mQCEvzGLHx/FcXb5hn/SaJxB2wzsYY9/PyPWktKsoWx4tA
        G1woD1qjh8PamxiSq3+z1A==
X-Google-Smtp-Source: APXvYqxI2BinRquZkReZpU2cEZFE0qzvFjr5Z2aOCCb2TjpCYpGkqqM5FGsP6qGUbIaXsvZ9RoHwJg==
X-Received: by 2002:a9d:6a8d:: with SMTP id l13mr14602804otq.239.1566919628515;
        Tue, 27 Aug 2019 08:27:08 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v1sm5268079ota.60.2019.08.27.08.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 08:27:08 -0700 (PDT)
Date:   Tue, 27 Aug 2019 10:27:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        nicolas.ferre@microchip.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: Re: [PATCH v5 14/18] dt-bindings: thermal: add binding document for
 h5 thermal controller
Message-ID: <20190827152707.GA26554@bogus>
References: <20190810052829.6032-1-tiny.windzz@gmail.com>
 <20190810052829.6032-15-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190810052829.6032-15-tiny.windzz@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 10 Aug 2019 05:28:25 +0000, Yangtao Li wrote:
> This patch adds binding document for allwinner h5 thermal controller.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
