Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 059DDB5615
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2019 21:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730091AbfIQTWt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Sep 2019 15:22:49 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:32898 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfIQTWt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Sep 2019 15:22:49 -0400
Received: by mail-ot1-f68.google.com with SMTP id g25so4165466otl.0;
        Tue, 17 Sep 2019 12:22:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ueOlxJgXhHGR0t/S2l0g404wxAKQDmbp//P/jfatHng=;
        b=pZmmy0zSU/Ji0t3xZsx309XC0RP+9Hg3EfaND5oz2dyV5fEzn+oxMYErE1Ef7DKGi8
         QVtC3AQnfmdc0qK51Zrvv1N0v28Y3gdZOumspFUAkhYwmDJd00DBq3gjP4D7aD/uzX6z
         pZT+TjDFVkG5NNLLsm6AgFfWMtEJh01sCQNzVgkef870kwDEAwz/IihnRqMlmC/ITZHR
         BYk/6ocnDXC5EpwPiKjnd3Vx27KEVrf2G42Fu/Me1b0vD6wKQ5tig3GyWt2kLhdwK40t
         fcGPXOF74M24Nolst2Qzl0AEViXKNnSGvrMH4PvsVT95PuLjR0vWQGu5UEK8oVpw161y
         Z6Zw==
X-Gm-Message-State: APjAAAUaWLWgGTgqKPNaaNQxC4H9gJBsec3/QWRN830kpskB9IWCSAIe
        7SolRm0V3fyeulzLmpwGvA==
X-Google-Smtp-Source: APXvYqyeJCbqzZZ3GBSOlmWeWQLiFwUCCb1lRRjCc1FSgIfpRPjy68M3i6sEvrofJCoe+vdjL4x/fw==
X-Received: by 2002:a9d:714e:: with SMTP id y14mr356697otj.109.1568748168469;
        Tue, 17 Sep 2019 12:22:48 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t12sm930174otl.35.2019.09.17.12.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 12:22:47 -0700 (PDT)
Date:   Tue, 17 Sep 2019 14:22:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Adam Ford <aford173@gmail.com>,
        =?iso-8859-1?Q?Andr=E9?= Roth <neolynx@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Roger Quadros <rogerq@ti.com>,
        Teresa Remmet <t.remmet@phytec.de>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 5/8] cpufreq: ti-cpufreq: omap36xx use "cpu0","vbb" if
 run in multi_regulator mode
Message-ID: <20190917192247.GA7233@bogus>
References: <cover.1568224032.git.hns@goldelico.com>
 <1c803be8060fb99b7d92e2f5cde3c0e1962fbe2b.1568224033.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c803be8060fb99b7d92e2f5cde3c0e1962fbe2b.1568224033.git.hns@goldelico.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 11 Sep 2019 19:47:11 +0200, "H. Nikolaus Schaller" wrote:
> In preparation for using the multi_regulator capability of
> this driver for handling the ABB LDO for OPP1G of the omap36xx
> we have to take care that the (legacy) vdd-supply name is
> cpu0-supply = <&vcc>;
> 
> To do this we add another field to the SoC description table which
> optionally can specify a list of regulator names.
> 
> For omap36xx we define "cpu0-supply" and "vbb-supply".
> 
> The default remains "vdd-supply" and "vbb-supply".
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  .../devicetree/bindings/cpufreq/ti-cpufreq.txt       |  6 +++++-
>  drivers/cpufreq/ti-cpufreq.c                         | 12 ++++++++++--
>  2 files changed, 15 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
