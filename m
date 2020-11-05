Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0F72A878B
	for <lists+linux-pm@lfdr.de>; Thu,  5 Nov 2020 20:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731994AbgKETtJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 14:49:09 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36226 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKETtI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Nov 2020 14:49:08 -0500
Received: by mail-oi1-f196.google.com with SMTP id d9so2941171oib.3;
        Thu, 05 Nov 2020 11:49:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tuYnC0Mxw2GdN/5/fc/SmXazs0VaaXHxAARa6Xjy2i4=;
        b=N1dRJ6WGhSg4r5ZssOC4wKkY67YhxCnYgIdeeXCtIAwWKh8ey/6vk7FTqPTCjVe+y7
         r1gzCj5AIVE83aZGEUxDrsVSu+nTk69fg8P5Lv4Udt0OvZDJ1tgk7WPq7GNnrBS+AnCt
         u+gtbdHb+ad0gpLXt97HVg/WhDy9QqPRbShHIOH/KLB0d2GKfXv9AK9+yBuSNgaGETcU
         y+aGAXGLAsUFivNDdFr2qg9dwxnS9bRt8xltrQ37RGWSSrmbRpaE1kRAVW8R9x3NQuwP
         2S79H/Q8F9xW5EOLxpzrfI/EnJ2AUHElSaL7oJ3egaKF11xbACdcaCiohyMkYCelMp6H
         EVcw==
X-Gm-Message-State: AOAM532xa5hO6CJT2Lg7C/9THoNWsZy9SySSI7jUv/Gxs41k2u/5sD0i
        QQ0VCu4O1CYrnjSwR3Gqo35lE2lntg==
X-Google-Smtp-Source: ABdhPJw9mjGnbmwktu6jycYe4A4nLF1h99xyWADN6/gYWECKdz4nU/5g+w8IKI9+KbNGXxZinSDljQ==
X-Received: by 2002:aca:bad4:: with SMTP id k203mr713838oif.16.1604605747683;
        Thu, 05 Nov 2020 11:49:07 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 132sm592345oid.54.2020.11.05.11.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 11:49:07 -0800 (PST)
Received: (nullmailer pid 1701587 invoked by uid 1000);
        Thu, 05 Nov 2020 19:49:05 -0000
Date:   Thu, 5 Nov 2020 13:49:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-tegra@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Nicolas Chauvet <kwizart@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        linux-pm@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>
Subject: Re: [PATCH v7 12/47] dt-bindings: memory: tegra124: mc: Document new
 interconnect property
Message-ID: <20201105194905.GA1701518@bogus>
References: <20201104164923.21238-1-digetx@gmail.com>
 <20201104164923.21238-13-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104164923.21238-13-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 04 Nov 2020 19:48:48 +0300, Dmitry Osipenko wrote:
> Memory controller is interconnected with memory clients and with the
> External Memory Controller. Document new interconnect property which
> turns memory controller into interconnect provider.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../bindings/memory-controllers/nvidia,tegra124-emc.yaml     | 1 +
>  .../bindings/memory-controllers/nvidia,tegra124-mc.yaml      | 5 +++++
>  2 files changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
