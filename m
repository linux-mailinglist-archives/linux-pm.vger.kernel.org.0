Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B1C1C7059
	for <lists+linux-pm@lfdr.de>; Wed,  6 May 2020 14:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgEFMdc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 May 2020 08:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727971AbgEFMdb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 May 2020 08:33:31 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0F3C0610D5
        for <linux-pm@vger.kernel.org>; Wed,  6 May 2020 05:33:31 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id u12so988321vsq.0
        for <linux-pm@vger.kernel.org>; Wed, 06 May 2020 05:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r/H9a8fdUQMIeGLl1QzKMQEwsBfgzt/5wa51opjojDM=;
        b=Al2hllyDJrpnAAgUMK4kmI3Q4IvOqQLe0OVjzxqXCK2z1jqaLkiyJi5DX4ENlFPf0W
         zq3dCkbZ6StGLbPMWGN+pIeDc6ihuyLGPfl6IoTQYnyEGgNWapWnCjcQFlopRjCwChlR
         IFqp5yy9xOiagdbFvp0nSlhH/Co0b5MutNTiMGGL3JrtpH8deu748hBqo6sjdzUYTw1/
         JfRCay5/xUnGMlLQjoCnvI9Tlst1bNTeXqQ2GvhmCUOtz9WH1W3ZnCe6G9wZNli7v6JL
         wn4mGFaQ2HLDiTV9IzsjMxEJPc13Bhm292vOZNkhKSUkyMP/Xx+1eZ5TKD+A7C4oYoKd
         3CFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r/H9a8fdUQMIeGLl1QzKMQEwsBfgzt/5wa51opjojDM=;
        b=IdZ33SNqaaUF6DUoP9dLb/j7hQ476sDP+y0bvoEDs5NbcfCu2QVOr7L0cFEOBZe6fe
         w3lNNqZNRKDK14ESQCeVg9+1kcFR+DdtuEau2WiP2A8YPrLDwnCjxKcv2ABFvIfiKPSr
         hIKasByXbJCUSCndruADeTksZI5FEg5rfH9b6QHLG6pg5QO08DC3QCSwpz6szRzOzv+O
         CbMyZaC2qTk57GCGFhmoWYRKM4MJ+cILd7OLj3ZiIgXUFYJYaIDKUboXfy1WYJ856KPk
         zo2Vg0ufyeRKfZklROisFHdp5LsYyH13bn2LXiA/FwyQdyRsH4j5Ct790TklRVSHYMhT
         aMow==
X-Gm-Message-State: AGi0Puaf+lFCZfIgbrT6eHQVacW+2OD659ZxfQiv1Z20SHlF0mRRp3wE
        U0OyM3r9mmp7kpZ4c+Xvnir6ijhpisWWuiQ/BKGvXg==
X-Google-Smtp-Source: APiQypIveNOAp+c/Cus1Zn/SarzWZcN4REWKyhbpRPZVcAdvDS7J0T6Lh9t3nKf/aERxl5/aNTXybAaSlEHODK+/ECQ=
X-Received: by 2002:a05:6102:2e4:: with SMTP id j4mr7021578vsj.182.1588768410246;
 Wed, 06 May 2020 05:33:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200504202243.5476-1-sibis@codeaurora.org> <20200504202243.5476-2-sibis@codeaurora.org>
In-Reply-To: <20200504202243.5476-2-sibis@codeaurora.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 6 May 2020 18:02:54 +0530
Message-ID: <CAHLCerMMxQHK2FbtfyLAzU5Vi0HTM6sR5vdb1G_2bDo4m1KbCw@mail.gmail.com>
Subject: Re: [PATCH v4 01/12] arm64: dts: qcom: sdm845: Add SoC compatible to MTP
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Nishanth Menon <nm@ti.com>, Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, May 5, 2020 at 1:54 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> Add missing SoC compatible to SDM845 MTP board file.
>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>


> ---
>
> v4:
>  * Picked up R-b from Matthias
>
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> index 023e8b04c7f65..1372fe8601f50 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> @@ -13,7 +13,7 @@
>
>  / {
>         model = "Qualcomm Technologies, Inc. SDM845 MTP";
> -       compatible = "qcom,sdm845-mtp";
> +       compatible = "qcom,sdm845-mtp", "qcom,sdm845";
>
>         aliases {
>                 serial0 = &uart9;
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
