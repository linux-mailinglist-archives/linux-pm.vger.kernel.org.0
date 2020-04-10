Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0DB51A496F
	for <lists+linux-pm@lfdr.de>; Fri, 10 Apr 2020 19:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgDJRl6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Apr 2020 13:41:58 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39968 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgDJRl6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Apr 2020 13:41:58 -0400
Received: by mail-oi1-f193.google.com with SMTP id a7so1968215oid.7;
        Fri, 10 Apr 2020 10:41:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0iuTTuHAKQBLl6wYTyl9B3rSSI6V9IdcCwjtYPwLnRg=;
        b=gGO/6Xop18l/5MqHN4rGO6fFxI1foVkHiGQoCukidIfXPqbTCsKjkst6pRzbZ4Fpmh
         ue3EGld4ESrbxFBE0pJPLb8A0URnDOmEa0PjbyzB6K3qEd8/ffotgCQ9VmxJj+DcxTws
         e8Cpc7bPs+hIt1A+Fgjl7oGERwNw5fYB0KWtBACgbEgAAvUED8IgQRHhBV8yHy05H2eg
         2ppZWth5fZMLT1kST9hN6FeqUJZ2vNC/iIb7uaDVPMoh2ey7/VOZalnyqX4SAGov1Xn1
         ba0yRsG3LgBGMz1AmUxPv1L8Kyi3yMe/IxUiX/cJkA95gmQK0XyRv6Xr4WuA2RZGlWdi
         iYnw==
X-Gm-Message-State: AGi0PubaH8IxxRq933bmTyUcU97giax+ReXJebeUV18v8nQjnIQPPazL
        ldWmua58MlBYps2M6lxagWhFEeI=
X-Google-Smtp-Source: APiQypJG6wzg7b39i/tEaYyjfDn8nBkJ24exIHhxeEzgkKcAtLcxB+Cs60pyg4ubvZSd15mI/BYhPw==
X-Received: by 2002:aca:7251:: with SMTP id p78mr4240717oic.32.1586540516474;
        Fri, 10 Apr 2020 10:41:56 -0700 (PDT)
Received: from rob-hp-laptop (ip-99-203-29-27.pools.cgn.spcsdns.net. [99.203.29.27])
        by smtp.gmail.com with ESMTPSA id h10sm1489399otq.47.2020.04.10.10.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 10:41:55 -0700 (PDT)
Received: (nullmailer pid 6756 invoked by uid 1000);
        Fri, 10 Apr 2020 17:10:44 -0000
Date:   Fri, 10 Apr 2020 12:10:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 07/22] dt-bindings: memory: tegra30: Add memory client
 IDs
Message-ID: <20200410171044.GA6675@bogus>
References: <20200330010904.27643-1-digetx@gmail.com>
 <20200330010904.27643-8-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330010904.27643-8-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 30 Mar 2020 04:08:49 +0300, Dmitry Osipenko wrote:
> Each memory client have a unique hardware ID, this patch adds these IDs.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  include/dt-bindings/memory/tegra30-mc.h | 67 +++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
