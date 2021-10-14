Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC13242DF38
	for <lists+linux-pm@lfdr.de>; Thu, 14 Oct 2021 18:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbhJNQfq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Oct 2021 12:35:46 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:41727 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbhJNQfq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Oct 2021 12:35:46 -0400
Received: by mail-ot1-f45.google.com with SMTP id v2-20020a05683018c200b0054e3acddd91so8985880ote.8;
        Thu, 14 Oct 2021 09:33:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wbyg5/ZHCP6iv8scvAQY2n2pP40B3OluO2DV9x0j5u4=;
        b=F/ved7XIuTJa7O23vm2LM+t+vnGnQw7Klv9ooFeTymH16wEG2Ay0LZVX6rq13Zk3I6
         sUBN8j9GNSLPUB4k3v89iC/NNgQc9eh9MX80ft+2/pvxDjYdYNWQ0G/lEfN+Ncgx2022
         pkO4dL0dGpG2t1khPa7avbW5RQvlpQpPIG95VRRxgR2XSzbRFqkgX7ESyIr/AjRG+GVe
         ZSU0drLjSVn/9XedfQpVOXOCtkxzND72UL22PK6UyrUJoNQPNkl6E/lIZRjrejueKR4n
         GgcoEVFPI+fosrFx3w1BsLFaeNOdVS/wbgoVJUC4gk0GmA8tOcrrERThtwCHC3V66cxe
         sI1g==
X-Gm-Message-State: AOAM532wY8v13p7Q3i9n97ZmtjcGy0xVOUBmI4DancsBWQ8EsQkRoonQ
        8cbRDCl4ZqOy770PJzpfyA==
X-Google-Smtp-Source: ABdhPJz377Q3GSNcm3sjaJvTeT55d12kei7sdBCTz5v8aRBkdARJ5enXHLd7xmjfqtxVxvxDgzPvdw==
X-Received: by 2002:a9d:1b41:: with SMTP id l59mr3338165otl.283.1634229221053;
        Thu, 14 Oct 2021 09:33:41 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e9sm527185oos.39.2021.10.14.09.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 09:33:40 -0700 (PDT)
Received: (nullmailer pid 3496466 invoked by uid 1000);
        Thu, 14 Oct 2021 16:33:39 -0000
Date:   Thu, 14 Oct 2021 11:33:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-pm@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chen-Yu Tsai <wens@csie.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 3/6] dt-bindings: arm: sunxi: Add H5 MBUS compatible
Message-ID: <YWhb46PfBcKDyAdP@robh.at.kernel.org>
References: <20211004012739.39053-1-samuel@sholland.org>
 <20211004012739.39053-4-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004012739.39053-4-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 03 Oct 2021 20:27:36 -0500, Samuel Holland wrote:
> The H5 SoC has a MBUS very similar to the H3 SoC, but it has a smaller
> MDFS divider range (1-4 instead of 1-16). Add a separate compatible for
> this variant.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  .../devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
