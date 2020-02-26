Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7DB11702E2
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2020 16:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbgBZPma (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Feb 2020 10:42:30 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35629 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgBZPma (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Feb 2020 10:42:30 -0500
Received: by mail-ot1-f67.google.com with SMTP id r16so3375877otd.2;
        Wed, 26 Feb 2020 07:42:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oALkAv67EVsYWYHdpUzQk0H8ppF1xN73RMetofcDpiA=;
        b=MomOWL05UeFBWTj3So9JNuhq102eawyuiGRWBLfnZZr9v0GlR3/qcJdPnHH5oqNF+e
         drBM5Gc0ZqxF3U4zzCbgvTDgz3eNr+uMgSyvTeIr+gOwKvA4oeNGev6mynjbKeOVATqq
         TZuiFo2djOQw+pF+U7mCpI7RiN+ePa54YfeYn24uhRVsdTUsUA/lcsXJc89Ea//pQC+F
         3npgepbSoimgCN2b8fjqhrA5BNSGL/gWUomkXaC6UbVVgwNJddq8kOeUaqv5TSyTHwl5
         6s1yfb2yWnARtBwWT3xbrlOl3rOaAxPTjEYjXSEOfPrQucaHXy0uLeRkQL+H0y06SUFx
         +uWw==
X-Gm-Message-State: APjAAAVWNOY3jYSX01IYt5OVy6AbsM7Fir9HFyPxgybVqZ+i1Apb9UTQ
        LdG7wsev2/RoGAwvaNjT04KXYUv4UQ==
X-Google-Smtp-Source: APXvYqydqZ6UJB5h2BMo//IMEZdjers3OTc7g4pogmYI9e5t7XqZpBlJBXDQT5Pgj8r+gCgYGwebzg==
X-Received: by 2002:a9d:7c9a:: with SMTP id q26mr1908862otn.206.1582731749194;
        Wed, 26 Feb 2020 07:42:29 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w202sm931951oiw.0.2020.02.26.07.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 07:42:28 -0800 (PST)
Received: (nullmailer pid 23994 invoked by uid 1000);
        Wed, 26 Feb 2020 15:42:27 -0000
Date:   Wed, 26 Feb 2020 09:42:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Sricharan R <sricharan@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: qcom: Add support for krait based socs
Message-ID: <20200226154227.GA22249@bogus>
References: <20200219205546.6800-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219205546.6800-1-ansuelsmth@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Feb 19, 2020 at 09:55:45PM +0100, Ansuel Smith wrote:
> In Certain QCOM SoCs like ipq8064, apq8064, msm8960, msm8974
> that has KRAIT processors the voltage/current value of each OPP
> varies based on the silicon variant in use.
> 
> The required OPP related data is determined based on
> the efuse value. This is similar to the existing code for
> kryo cores. So adding support for krait cores here.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/opp/qcom-nvmem-cpufreq.txt       |   3 +-

If you respin, please split bindings to a separate patch.

>  drivers/cpufreq/Kconfig.arm                   |   2 +-
>  drivers/cpufreq/cpufreq-dt-platdev.c          |   5 +
>  drivers/cpufreq/qcom-cpufreq-nvmem.c          | 181 ++++++++++++++++--
>  4 files changed, 173 insertions(+), 18 deletions(-)
> 
