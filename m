Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7D31A4919
	for <lists+linux-pm@lfdr.de>; Fri, 10 Apr 2020 19:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgDJRhL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Apr 2020 13:37:11 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42313 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgDJRhK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Apr 2020 13:37:10 -0400
Received: by mail-ot1-f68.google.com with SMTP id j20so1783985otl.9;
        Fri, 10 Apr 2020 10:37:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OvsHNilOxSyiwGW3V/imzWzd5sgcwB1R86uU7/0uLTg=;
        b=kigp8dttzmLP+Qsad67IeMe62x4ooQks84vN4tj5l3ca55HbNzWVpIAXuB0MA0YdQZ
         UOeVvtMT3Dm4cXed5fr6RgNxE/L6n9IH86LHlpFmg4wdP36DpCsQW/sDELZjqjGsHDuW
         axX8cJ0eaYzZucghVbrYxgTezp4hkPnAYx5DbxfLTGQ5V6rgwHUoyKGUjTcOAzOn710Z
         3SczSPgrBWHOSHvBqIEUfaGtmae2Q+5V52WRCHg37KE/fvg5PdUmpVy8huO1NJOXqL9g
         cN7ztYF5mQcYyx3Rs8nleJc5afOIr0bZ6Hin6nBkBY8zc4nM2t+NHIO+1dW5Q0iTNqpf
         nP8w==
X-Gm-Message-State: AGi0PubHbGu6y0d2WiXy5P3ProwKM+fpbvWN/GmkyuQn0DgOO3aaqxJS
        I/qIWw/5WfiOKRhRvOPtXw==
X-Google-Smtp-Source: APiQypL0WB5tGIuunT3qritEJX9PvG/EVqigMCAxoki77FmP/HPVGri3fzYS6+Bezx2cJ8PtdYYb+Q==
X-Received: by 2002:a4a:9cd8:: with SMTP id d24mr4988155ook.84.1586540230111;
        Fri, 10 Apr 2020 10:37:10 -0700 (PDT)
Received: from rob-hp-laptop (ip-99-203-29-27.pools.cgn.spcsdns.net. [99.203.29.27])
        by smtp.gmail.com with ESMTPSA id d3sm1480526oth.81.2020.04.10.10.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 10:37:08 -0700 (PDT)
Received: (nullmailer pid 30639 invoked by uid 1000);
        Fri, 10 Apr 2020 17:05:13 -0000
Date:   Fri, 10 Apr 2020 12:05:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 01/22] dt-bindings: memory: tegra20: mc: Document new
 interconnect property
Message-ID: <20200410170513.GA30556@bogus>
References: <20200330010904.27643-1-digetx@gmail.com>
 <20200330010904.27643-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330010904.27643-2-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 30 Mar 2020 04:08:43 +0300, Dmitry Osipenko wrote:
> Memory controller is interconnected with memory clients and with the
> external memory controller. Document new interconnect property which
> turns memory controller into interconnect provider.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../bindings/memory-controllers/nvidia,tegra20-mc.txt          | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
