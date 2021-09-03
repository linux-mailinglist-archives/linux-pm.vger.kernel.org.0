Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C447E40036B
	for <lists+linux-pm@lfdr.de>; Fri,  3 Sep 2021 18:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350051AbhICQgL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Sep 2021 12:36:11 -0400
Received: from mail-oo1-f43.google.com ([209.85.161.43]:41513 "EHLO
        mail-oo1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349998AbhICQgJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Sep 2021 12:36:09 -0400
Received: by mail-oo1-f43.google.com with SMTP id b5-20020a4ac285000000b0029038344c3dso1669862ooq.8;
        Fri, 03 Sep 2021 09:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cBS95estuzxVp3cHtxmKL4O9j2jB1kuG56GjGOq66Kk=;
        b=EvEOhR5W5n8YoNrmvdo2U+s5T4RyBmqgbYU+LZOhVdoU1dLuKG3Fh1D7FEmjNPHJ7P
         cK8QUV+d4QqXezIR8xDlXLc7ina1CoYlawwQhDogpuD4b5Ri60FQoPMK1zJuveGt5ZIb
         oCLnO8Hks6RC7NZnYK6istEEagv/zHmM9EUU0gkAA1+Ilpo4IiP6zU8ywBt3xnzq/XR9
         /fwLOkE1f543TsHdTViFm/ngnbBmDu1xrl0lZ9WYONz7NxSjr7t0o3iEHZ+GKIhPfDGf
         gQE935uaf+AEycU6tJCb2kGgHA0213DYS0i23BvqgfS6FiSzNKBdzMpQSuQ70arqHncT
         ilSg==
X-Gm-Message-State: AOAM531HCD5aW9MaJAKb2J+FPS/vbJ+8L+kANB0QzJDAHNZf3Vl4SF/l
        mu7CM35d/3tW2SlC6cJ0+g==
X-Google-Smtp-Source: ABdhPJwI1jhvQ61a8n7xvPWLvaY2h+cxGEEbZ1SfD8vUTYtw4ZvN3JSQhqmUmb6Zwdf1b+L03ugECg==
X-Received: by 2002:a05:6820:121:: with SMTP id i1mr3713699ood.57.1630686907756;
        Fri, 03 Sep 2021 09:35:07 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k23sm1133582ood.12.2021.09.03.09.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 09:35:06 -0700 (PDT)
Received: (nullmailer pid 3061917 invoked by uid 1000);
        Fri, 03 Sep 2021 16:35:05 -0000
Date:   Fri, 3 Sep 2021 11:35:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hector Yuan <hector.yuan@mediatek.com>
Cc:     wsd_upstream@mediatek.com, Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 1/3] dt-bindings: cpufreq: add bindings for MediaTek
 cpufreq HW
Message-ID: <YTJOuVr0SkwClJbw@robh.at.kernel.org>
References: <1630658364-6192-1-git-send-email-hector.yuan@mediatek.com>
 <1630658364-6192-2-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1630658364-6192-2-git-send-email-hector.yuan@mediatek.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 03 Sep 2021 16:39:22 +0800, Hector Yuan wrote:
> From: "Hector.Yuan" <hector.yuan@mediatek.com>
> 
> Add devicetree bindings for MediaTek HW driver.
> 
> Signed-off-by: Hector.Yuan <hector.yuan@mediatek.com>
> ---
>  .../bindings/cpufreq/cpufreq-mediatek-hw.yaml      |   70 ++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
