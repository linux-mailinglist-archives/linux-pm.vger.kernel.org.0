Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A63251A492D
	for <lists+linux-pm@lfdr.de>; Fri, 10 Apr 2020 19:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgDJRhy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Apr 2020 13:37:54 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42324 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgDJRhy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Apr 2020 13:37:54 -0400
Received: by mail-oi1-f196.google.com with SMTP id e4so1951041oig.9;
        Fri, 10 Apr 2020 10:37:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vEe+bUuvSM5gxqTCFAjWH3kYOSeAyXRq91CDiiYZ9qo=;
        b=pY2Evt1gGyDq9vfZkBvxFoYGW9xjgkQAmJq2C5P3K2bYFE/T3B2J1Dtbq27BsRQmGl
         l6CNz4f0IURCbMuLGHA18PCWZ6PodPumP2C3SLWZjlitJHc9WXN8RkeLRqNzWTJHm2Gj
         7tT3GgWjx86pcO2LiJOypQuF4mQGXENwXPkfSEzN5xalkeiaieomcv7KI9G+LxssDWm4
         sfLrSwMqn1EVQFtzW1uziXtlR5EwkQvBLehclLyu0NQ+0LWEhkzekmmhgwt4BuBpfYSK
         GGTUKH4HlFEygmxLEc91lg3UfMYPWbMzzJDao4T+fQvWUMP/VBG1kBonk95zDGg4jHO+
         /+pQ==
X-Gm-Message-State: AGi0PuZuMlInfs6MEV/NddJ/I5tG08AmO3N7JIaVzl9wO3LKXtqBVBnG
        M6ulIhzYoeQBZTwOaQMxaQ==
X-Google-Smtp-Source: APiQypKqUHndu/sKIkbRhVVGJoZLdiyzl4gTHIVGT+0qQM7jPIkI4j/9c9wXmTpb4IZFOs8t0Mjh4A==
X-Received: by 2002:aca:5210:: with SMTP id g16mr4252721oib.174.1586540273403;
        Fri, 10 Apr 2020 10:37:53 -0700 (PDT)
Received: from rob-hp-laptop (ip-99-203-29-27.pools.cgn.spcsdns.net. [99.203.29.27])
        by smtp.gmail.com with ESMTPSA id h10sm1484553otq.47.2020.04.10.10.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 10:37:52 -0700 (PDT)
Received: (nullmailer pid 5873 invoked by uid 1000);
        Fri, 10 Apr 2020 17:10:09 -0000
Date:   Fri, 10 Apr 2020 12:10:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 06/22] dt-bindings: memory: tegra20: Add memory client
 IDs
Message-ID: <20200410171009.GA5801@bogus>
References: <20200330010904.27643-1-digetx@gmail.com>
 <20200330010904.27643-7-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330010904.27643-7-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 30 Mar 2020 04:08:48 +0300, Dmitry Osipenko wrote:
> Each memory client have a unique hardware ID, this patch adds these IDs.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  include/dt-bindings/memory/tegra20-mc.h | 53 +++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
