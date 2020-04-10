Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A35671A4931
	for <lists+linux-pm@lfdr.de>; Fri, 10 Apr 2020 19:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgDJRiA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Apr 2020 13:38:00 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36676 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgDJRiA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Apr 2020 13:38:00 -0400
Received: by mail-ot1-f68.google.com with SMTP id l23so2526174otf.3;
        Fri, 10 Apr 2020 10:38:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z+n7hy7rFWHZOTxNMWQy7RW9UsHyHmHBslRaPOEtLgo=;
        b=uMgCOdfcRxOXT4IkPKBjClPSQTzDSJ1BoombcQa/XsBYfDVx+hf7l89LaZVMAplyqE
         967BUe7Y2XRjEyUn5z1+sB/VrzPF4J++v0CE+sgx3usXcS6GScSGgrK6ASPfAT0Ih+bS
         5OrOr3WKuxs5YHTs/J0Ipsy//h6DwioppMV9PXxL7N3KvYQw0z5nIKX42pdQx2AeuITs
         CQeoUU0yd68PqleIbbnxqqOAKAuYtyURrbYPW7klUUcat4Gb/SqyM7nkLq2geuMurc7s
         Dfjs/jyORBZVLKrW0Oqp0aO6J7sVU7YkYuneMMvL7Ll/yVdl+Nkfx0vWT/OKecFPS0/8
         qD3g==
X-Gm-Message-State: AGi0Pua3h3M/XhPGP17L/K+dRBdR4hFtVV6p++QX7nIMdplys+RZW7O9
        51kMmDIImyBzkZeePn/jFiR4uRc=
X-Google-Smtp-Source: APiQypIg6cdHup3w/mI8veji6zYX9S6G3uLYfY5aoWKwXOo49lGA8L/dhRUfTwcjpE+a5YwlYCuBSA==
X-Received: by 2002:a9d:364b:: with SMTP id w69mr4950447otb.289.1586540280239;
        Fri, 10 Apr 2020 10:38:00 -0700 (PDT)
Received: from rob-hp-laptop (ip-99-203-29-27.pools.spcsdns.net. [99.203.29.27])
        by smtp.gmail.com with ESMTPSA id c7sm1617939ooi.41.2020.04.10.10.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 10:37:59 -0700 (PDT)
Received: (nullmailer pid 829 invoked by uid 1000);
        Fri, 10 Apr 2020 17:06:57 -0000
Date:   Fri, 10 Apr 2020 12:06:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 03/22] dt-bindings: memory: tegra30: mc: Document new
 interconnect property
Message-ID: <20200410170657.GA769@bogus>
References: <20200330010904.27643-1-digetx@gmail.com>
 <20200330010904.27643-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330010904.27643-4-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 30 Mar 2020 04:08:45 +0300, Dmitry Osipenko wrote:
> Memory controller is interconnected with memory clients and with the
> external memory controller. Document new interconnect property which
> turns memory controller into interconnect provider.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../bindings/memory-controllers/nvidia,tegra30-mc.yaml       | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
