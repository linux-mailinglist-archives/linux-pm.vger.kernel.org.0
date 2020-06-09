Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17ED81F47B0
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 22:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732500AbgFIUCa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 16:02:30 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45692 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgFIUC2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 16:02:28 -0400
Received: by mail-io1-f68.google.com with SMTP id y5so24174642iob.12;
        Tue, 09 Jun 2020 13:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k8Vtkuk+eVaXGU/8rfVJdWcttoiSK9i9poLLXc4pfnw=;
        b=uUvqEBhR3EXCW+mC25JRkSeAgKuETy/N8Sae6xZgNXUOrjyI0FECNYsbroCECbajXq
         dCHsQN+UiqSB2fbcx3A787iYg8yTfT7mWo8da9GBGETkj4YQJm65JGV9oAoxyQ5Oxgtq
         bQcWDmPV3kupCm8l9dCikZ5who4CvhImNKn/oDmgopVnIm2/JKY6eZL6BNwuHsTMi1vo
         pjdpJZ0uF9myXpxZfS3oTZmZnTsHgwaCYzr/cFcZ5LMuLTWOt509+dnRU+FMjmTcLlY7
         GgB0RVqNav5c1Lzgt+r7nZCLxrXymqpid/+XI0rbx1iQWjQ+AEkft6zHrEx6v7vMOLQq
         zOIg==
X-Gm-Message-State: AOAM531oX/4IWQc2zMqx67sPN7oilvsD7g4J7eGMnmQ016ZbMiXdRqrZ
        P0ilHD7QC6YZ1Kjx6OS7ZQ==
X-Google-Smtp-Source: ABdhPJwwjhFBa9o+ou5vR9zbKMqsajdWUO/uk2RF8iJ7Mxb3+utXKh5+R6GmAI2gbaTUyNT6I1quhg==
X-Received: by 2002:a05:6602:2e96:: with SMTP id m22mr28955927iow.165.1591732947458;
        Tue, 09 Jun 2020 13:02:27 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id e184sm7664983iof.44.2020.06.09.13.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 13:02:27 -0700 (PDT)
Received: (nullmailer pid 1359505 invoked by uid 1000);
        Tue, 09 Jun 2020 20:02:25 -0000
Date:   Tue, 9 Jun 2020 14:02:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        linux-pm@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <cyndis@kapsi.fi>, devicetree@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Subject: Re: [PATCH v3 24/39] dt-bindings: memory: tegra30: Add memory client
 IDs
Message-ID: <20200609200225.GA1359394@bogus>
References: <20200607185530.18113-1-digetx@gmail.com>
 <20200607185530.18113-25-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200607185530.18113-25-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 07 Jun 2020 21:55:15 +0300, Dmitry Osipenko wrote:
> Each memory client have a unique hardware ID, this patch adds these IDs.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  include/dt-bindings/memory/tegra30-mc.h | 67 +++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

