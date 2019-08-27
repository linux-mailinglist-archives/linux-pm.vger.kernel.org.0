Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9EDD9F03B
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2019 18:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbfH0QdS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Aug 2019 12:33:18 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46450 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730454AbfH0QdS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Aug 2019 12:33:18 -0400
Received: by mail-oi1-f195.google.com with SMTP id t24so15416982oij.13;
        Tue, 27 Aug 2019 09:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UzdCUGlHV5X682Kzeexag26wntDzMS6Jj26RZbJJmdQ=;
        b=BdBgoyaR8PAoM7ztTiOkM/BsFVE4odcwQMvkOfc2924P3OEikfN8zgjfj5lzCAV68s
         5znodeKuWxXFN1Udym0XIQiCx3wTp50/5QVJPMK0DRPrtqAQpQ8WAolRiC1Xv2NHFuY0
         R7nrzCfrputzgbhWcnAzhng2o28I+z7yLoGORKQHk6y6DJ18fsGtUBPp0CrszY0ghJ6Z
         9S42eg43eX55PcFmk4Zr/y69pWCa2KV4bz336SvkKbNjQyANfimY8t4mxHC0CoR6du3O
         KuMQPg13HfEoetjxCduEjCqGAmtj+YLUHBC0lLjXpS2MOdxNDqJS3VldbE33EZB7bNdK
         NJag==
X-Gm-Message-State: APjAAAUUqeGbsMIe084LBudW6qncJdLrlvuS5dfs4jKgeuXDCKNjAAUx
        Dw0BbV8sHgC/l9uGW+Z4ZQ==
X-Google-Smtp-Source: APXvYqyLYFFzwrl9JxWS98fBy8t+nwRyuksVVJLjy7fG7gUGnBOGgC7pm9hA0aqSzS12hgYwHLc/rQ==
X-Received: by 2002:aca:f5c1:: with SMTP id t184mr17262932oih.25.1566923597041;
        Tue, 27 Aug 2019 09:33:17 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z9sm4341038oid.39.2019.08.27.09.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 09:33:16 -0700 (PDT)
Date:   Tue, 27 Aug 2019 11:33:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     linux-mediatek@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        devicetree@vger.kernel.org,
        "linux-arm-kernel @ lists . infradead . org Alessandro Zummo" 
        <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Josef Friedl <josef.friedl@speed.at>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tianping Fang <tianping.fang@mediatek.com>
Subject: Re: [PATCH v6 01/13] dt-bindings: mfd: mediatek: mt6397: change to
 relative paths
Message-ID: <20190827163316.GA31496@bogus>
References: <20190818135611.7776-1-frank-w@public-files.de>
 <20190818135611.7776-2-frank-w@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190818135611.7776-2-frank-w@public-files.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 18 Aug 2019 15:55:59 +0200, Frank Wunderlich wrote:
> paths in dt-bindings should be relative as suggested by Lee Johnes
> 
> Suggested-By: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> changes since v5: splitted from dt-bindings: add powercontroller
> ---
>  Documentation/devicetree/bindings/mfd/mt6397.txt | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
