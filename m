Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 753A7F097D
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2019 23:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbfKEW3V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Nov 2019 17:29:21 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35672 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729895AbfKEW3V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Nov 2019 17:29:21 -0500
Received: by mail-oi1-f195.google.com with SMTP id n16so19139703oig.2;
        Tue, 05 Nov 2019 14:29:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UoYy8XsKNEQ2TnQ0Osc5PBrfES+IwUY4yKiGP1bttyo=;
        b=QxekdWHLgQjVR9NUE5XMO0oGDeKarUrC7aoe+kvMy95Ghba7wnLUa/x0dWkT6Zpuhg
         K0tbX2g47kLQ/fWK94zAX9WS+v+QTPPOoOgQSC1dfzhO12H9GktIlUrC6SIoXTVNXS8q
         KYLbg3JGNRnAmpfbsaVhy8ihCwMdTo+o43xl5/bvN2lSs+Yn2Z9T477q1j3SsKE6tcj7
         VR/XWsYW3c8pvC9FFvewRFVojTVMDz7U8KG7Ro1t/324KEUW98cP3WW0Wn7s+Hjr6xY1
         QS2WF4/Fkul1KNPBT0ZdDwF+UTsBlQAgRzh3t0Q/9yzt0i//5atkRH2RSBImdNaMr0fg
         dfSA==
X-Gm-Message-State: APjAAAX+9+XHOk1DtBNQ6jz6NV74lxjeYSNK1jm+edl73qWYttJTTEgF
        RDagtrTC+3guMBxc4ZmP41TfZM4=
X-Google-Smtp-Source: APXvYqzPbkmZfrb12TZaDeT5FPREatvauqbAOXEHm6Yy22++J2iCDBKOKxPsVvP3BzIZejRzVmi09w==
X-Received: by 2002:aca:f1c5:: with SMTP id p188mr1095047oih.125.1572992960591;
        Tue, 05 Nov 2019 14:29:20 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y1sm6740096ota.72.2019.11.05.14.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 14:29:20 -0800 (PST)
Date:   Tue, 5 Nov 2019 16:29:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, baolin.wang7@gmail.com,
        zhang.lyra@gmail.com, orsonzhai@gmail.com
Subject: Re: [PATCH v2 1/5] dt-bindings: power: Introduce one property to
 describe the battery resistance with temperature changes
Message-ID: <20191105222919.GA13611@bogus>
References: <cover.1572523415.git.baolin.wang@linaro.org>
 <c9a1357628bb091aff5e54f60a2600b129388f19.1572523415.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9a1357628bb091aff5e54f60a2600b129388f19.1572523415.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 31 Oct 2019 20:22:40 +0800, Baolin Wang wrote:
> Since the battery internal resistance can be changed as the temperature
> changes, thus add one table to describe the battery resistance percent
> in different temperatures to get a accurate battery internal resistance.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  .../devicetree/bindings/power/supply/battery.txt   |    5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
