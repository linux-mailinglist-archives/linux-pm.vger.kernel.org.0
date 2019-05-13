Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F10C01BB9D
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 19:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbfEMRQK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 13:16:10 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34302 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbfEMRQK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 May 2019 13:16:10 -0400
Received: by mail-ot1-f67.google.com with SMTP id l17so12526582otq.1;
        Mon, 13 May 2019 10:16:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hi/B3pDLCTv/0zQybMoo8PsgjNBI5kvnYnP5VMF7qhI=;
        b=R0RSGjATJAY5XZ/PG/xCsgxupGbA1ERZ1FdVcP3rwQA6CUodT3m+jcCKrwMcKIxg0g
         Ad4chM+8ZufeO6lPBgBm68fLavfXcaWfFiqAFxoPxfyPAjLmERAgac4y+dUcWEnQ53gp
         ip2TNJJPQRF1qnRJhrqIKzV33r3IHtjVk6RhGPzFA0tlp92NPLMmLWHHuPbDnjzqi3Wb
         OKE9VF9xgdymHWb0lq/zEsRix3aNW6lPBrTcm+ZtTMk/Sg1ncvqeeZ56aiKrge9FB3sG
         2+BpmxeBfg5vUFngMTzr139A4oRHdUeDv5/bdf0pSQ/kmkPaW0wy2Xm4K44SOsCuEd9B
         BJkw==
X-Gm-Message-State: APjAAAVEYzQ4kudywSIltTLEtEelJlOGVGKB6OQ5LZd04aC+/HFQcgJh
        VrbJNiRK8mNRqALArTxGlQ==
X-Google-Smtp-Source: APXvYqz/YR2P1ehCNc15CXc2iDimOfGfWV1/7llqz6w550adaNWtvx+q+Jy3/kM9N6Z+rfW8gqy7Hw==
X-Received: by 2002:a9d:60b:: with SMTP id 11mr2484447otn.9.1557767769212;
        Mon, 13 May 2019 10:16:09 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c3sm5319743otb.13.2019.05.13.10.16.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 10:16:08 -0700 (PDT)
Date:   Mon, 13 May 2019 12:16:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 2/5] dt-bindings: imx-cpufreq-dt: Document
 opp-supported-hw  usage
Message-ID: <20190513171607.GA24874@bogus>
References: <cover.1557742902.git.leonard.crestez@nxp.com>
 <7948ab63fe5c92da280542a9a372349486d40c65.1557742902.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7948ab63fe5c92da280542a9a372349486d40c65.1557742902.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 13 May 2019 11:01:39 +0000, Leonard Crestez wrote:
> The interpretation of opp-supported-hw bits for imx-cpufreq-dt driver is
> not very obvious so attempt to explain it.
> 
> There is no OF compat string associated.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  .../bindings/cpufreq/imx-cpufreq-dt.txt       | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/imx-cpufreq-dt.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
