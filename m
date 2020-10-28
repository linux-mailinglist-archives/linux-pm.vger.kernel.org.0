Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C0729D98F
	for <lists+linux-pm@lfdr.de>; Wed, 28 Oct 2020 23:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389844AbgJ1Wz7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Oct 2020 18:55:59 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:35095 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389664AbgJ1Wx3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2020 18:53:29 -0400
Received: by mail-oo1-f66.google.com with SMTP id n16so284666ooj.2;
        Wed, 28 Oct 2020 15:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z8qRO5fdt5NREdYFOvySAdOEhiWbrwmj4h+0kAQzcnw=;
        b=jr7aYC4G57UCx1wz5KzVb62CyX+HTf9ssaVUqQNR9goooEQas0KlupcDB1NjtjoX3y
         cZwA5swuYm7fC4ViEXbITJkdW2wRjfnvJPul1oAHGjrm//EEbIenMzRw1ZFeUpDyjx93
         uP63t5uBfNknYx3ahBf5h0dxyf47O8iR6xrBz+8fuN++ui9azMWVR9kbrYIbvMKDknpV
         8LJM5QSRr55LD53dMzLXda/lXqODG2y0OC0eMXnJGj0Hi5qCEOVvE0gsSWZ/GimQG3E4
         P0tPBaXuOL98ueFG1NUZOScmQgOmkrvHW6nVP72DAeAOWMN9I9pDAl3ioj481qfj//kf
         GsmQ==
X-Gm-Message-State: AOAM532F3BonZpO5NHt+QDJC8A6oVkKpN3AOPU/JjDeBEEtgt8CJwxtK
        DB1woXCt2+PWQ9TwRbdnchq5GQ4SQw==
X-Google-Smtp-Source: ABdhPJz4rAItM9Tjr+B041aWkQLcJ4P9I8LjHRMJj9yAlwEt4a/QxGWhvpDv4Tv7mKuo7b3lREU2dg==
X-Received: by 2002:a05:6830:144b:: with SMTP id w11mr5358743otp.82.1603899076759;
        Wed, 28 Oct 2020 08:31:16 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 105sm2094205otf.52.2020.10.28.08.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 08:31:15 -0700 (PDT)
Received: (nullmailer pid 4061457 invoked by uid 1000);
        Wed, 28 Oct 2020 15:31:14 -0000
Date:   Wed, 28 Oct 2020 10:31:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Mikko Perttunen <cyndis@kapsi.fi>,
        Peter Geis <pgwipeout@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-tegra@vger.kernel.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 19/52] dt-bindings: memory: tegra124: Add memory
 client IDs
Message-ID: <20201028153114.GA4061412@bogus>
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-20-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201025221735.3062-20-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 26 Oct 2020 01:17:02 +0300, Dmitry Osipenko wrote:
> Each memory client have a unique hardware ID, this patch adds these IDs.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  include/dt-bindings/memory/tegra124-mc.h | 68 ++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
