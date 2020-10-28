Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B67E129D3FB
	for <lists+linux-pm@lfdr.de>; Wed, 28 Oct 2020 22:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725898AbgJ1VdT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Oct 2020 17:33:19 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:43971 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgJ1VdP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2020 17:33:15 -0400
Received: by mail-yb1-f194.google.com with SMTP id d15so392233ybl.10;
        Wed, 28 Oct 2020 14:33:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nlJqqXXAH1t+pt7s0ccAWf7pcAID62bNuJtmD6PRncE=;
        b=A7uIJO5L/ESrMYJbIAs9pb4sjGPenFSovbWB7VHfAvMfAIYeBaTKmHhpoxBwVkao6G
         7ikFU4GeOWYFdRLu5QJgJ7j5BnuDaEhn2wF6/Umk+TzrMgr3iRFVAj5yVAK3bJF/OPyd
         nx7VU9oVCTpBuZ6zkZkhdWSW8VxCCWdcUz/4SGJnW7qJkK268XjNZI11MTCeoF63nXhu
         nFVn9sw8ju458ocL62tqP7W8oIs0EGCdj0G5FZm24I59fXqLwFlO6JN4ij6UucI9rc7D
         /hYQ1LhMH+JAbs4rwLJ1a++kNa79XtCykIfGsF2o8Z2Fmf8glqWZGvTzrQZJlqPC6uaO
         uY0g==
X-Gm-Message-State: AOAM53215hzBxxfAMkozQo7OEYPqC9IiNvHTu7m2z9JVxiNCcOpkCNLP
        tHFgvk8YAbZ3ugJMx/13Hl75J6ALjg==
X-Google-Smtp-Source: ABdhPJy5UQJsgQmDLtE/+RjvN2Lhxh8sG17+hq4U7TOgu5yrnYqg9JmwYnTRx0VJDOZqz6UR5e+hJA==
X-Received: by 2002:a9d:172f:: with SMTP id i47mr5804523ota.74.1603898986343;
        Wed, 28 Oct 2020 08:29:46 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h6sm2714750oia.51.2020.10.28.08.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 08:29:45 -0700 (PDT)
Received: (nullmailer pid 4059166 invoked by uid 1000);
        Wed, 28 Oct 2020 15:29:44 -0000
Date:   Wed, 28 Oct 2020 10:29:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Viresh Kumar <vireshk@kernel.org>, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v6 11/52] dt-bindings: memory: tegra30: emc: Document OPP
 table and voltage regulator
Message-ID: <20201028152944.GA4059076@bogus>
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-12-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201025221735.3062-12-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 26 Oct 2020 01:16:54 +0300, Dmitry Osipenko wrote:
> Document new OPP table and voltage regulator properties which are needed
> for supporting dynamic voltage-frequency scaling of the memory controller.
> Some boards may have a fixed core voltage regulator, hence it's optional
> because frequency scaling still may be desired.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../memory-controllers/nvidia,tegra30-emc.yaml       | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
