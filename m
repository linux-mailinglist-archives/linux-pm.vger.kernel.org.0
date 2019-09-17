Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E775FB56C9
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2019 22:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbfIQUT7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Sep 2019 16:19:59 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42804 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfIQUT7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Sep 2019 16:19:59 -0400
Received: by mail-ot1-f68.google.com with SMTP id c10so4249465otd.9;
        Tue, 17 Sep 2019 13:19:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lTap6f5G5pylKGfzicQFeJjtWLtSRnIsWooZSm3rQcI=;
        b=Eu1kMr8YgyMY5mGrVU8qokWP3eV6gGnmkufQ+xGFfmNvabgxrx5nCp7+Z6m6VbVa/O
         J0dGi/aZzlhr5BN+0ELOz71pKyGEqR6zLF63SmymgfPrI01W0J3SaIAIMEwCAo15G04I
         //BrskukBHA/qP72+lhBmt66F6WQD335FnX3emx/Kqdj13MAzfb3HOOYCRqsqfHFZblf
         sJ6dushsXV9uY65dBisrODu3AJMZ7dlJxg78L2CUdAdRGtLDJbjp5oxtnhj7MCN/fsG6
         J3KBxFcolw4XLj3gyOkU9ZIdFamSeRicZg1L3cpuu9E6OHkodSY+sEVNJx4ue9BuWro5
         oyHg==
X-Gm-Message-State: APjAAAV1a04gUdC1BNkD9YbwdXLNmzXBOR4bmTsWdROefjSoRpzjevCN
        W7vW6pAJ9lDwYuIvsONVXBixiYp1BQ==
X-Google-Smtp-Source: APXvYqwWMcToGiqtK7DQ5rkMwWll7z3LWyTHg8U7Vn12++SkQnLN7MxzLClVS2wx0nFJZ0SVJAbvEA==
X-Received: by 2002:a9d:2043:: with SMTP id n61mr598826ota.17.1568751598063;
        Tue, 17 Sep 2019 13:19:58 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z10sm1355232ote.54.2019.09.17.13.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 13:19:57 -0700 (PDT)
Date:   Tue, 17 Sep 2019 15:19:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        kernel@pengutronix.de, linux-imx@nxp.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFCv4 3/7] dt-bindings: devfreq: imx: Describe interconnect
 properties
Message-ID: <20190917201956.GA10780@bogus>
References: <cover.1566570260.git.leonard.crestez@nxp.com>
 <3f27038292c09c8bf07a086eac759132c100aedb.1566570260.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f27038292c09c8bf07a086eac759132c100aedb.1566570260.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Aug 23, 2019 at 05:36:56PM +0300, Leonard Crestez wrote:
> The interconnect-node-id property is parsed by the imx interconnect
> driver to find nodes on which frequencies can be adjusted.
> 
> Add #interconnect-cells so that device drivers can request paths from
> bus nodes instead of requiring a separate "virtual" node to represent
> the interconnect itself.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  Documentation/devicetree/bindings/devfreq/imx-ddrc.yaml | 5 +++++
>  Documentation/devicetree/bindings/devfreq/imx.yaml      | 5 +++++
>  2 files changed, 10 insertions(+)

Please combine this with the other series for devfreq support.

Rob
