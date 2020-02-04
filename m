Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB5B15205E
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2020 19:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbgBDSWK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Feb 2020 13:22:10 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38786 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727355AbgBDSWK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Feb 2020 13:22:10 -0500
Received: by mail-lj1-f193.google.com with SMTP id w1so19681878ljh.5
        for <linux-pm@vger.kernel.org>; Tue, 04 Feb 2020 10:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QDmc7rJKH3PB8BRLa4LSMdik+WscauM3bJQAO66d9eA=;
        b=WeRebeBVSEUt28wl435zQEX1/6tiqV9monpU/7Ej5fqLhT4R41NF8WtVIPn3kCpd2W
         wbcN2Sjxu4ENSsuskkDYKK9U80zRpDL4LUYH/tlUOhVyLqB1KATrcbuAqPq0Al5qoWvp
         rMHMlBCss0WzMtE8Lymhfpn15/d3thD2oJEIZmNP8MDzdV8YSMDGPweIJImQWGcV8Ga/
         j/IbkkAP1Fj9pbuFBAyq/t9v6EySeBAPmFRUvTPRYghB8ovJFADomNk5+wvaaAHEWM0S
         hpqdASOKeTOzzB6JZ+53/Eq07SOogb68gbxVJW6udAD0KmS978l/cAwWllNpHbBrJLcc
         ldEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QDmc7rJKH3PB8BRLa4LSMdik+WscauM3bJQAO66d9eA=;
        b=DhCtKZLORxpcjDnXuiDZD6O3ubWx4iQ8IFypi1D6kG1bIKbyc7bsJbWlZf8USWv3Lg
         pv7Rloc8R0A5CYkONQG4S9HePBha82CcKtKIpiM6J31wSMAJOrXjio2CRhLmKWMWsKD7
         C5kGZSY1cpAPFGC+QGrQcYUCBr56cobUzmC7TrQOvQHAaPqX9dETa0DvKmuMlq43Q8gD
         qQYRu15ZtmK5SBQCxS1hvV0loN+6+TSxCBUjo7f3SqknYL5rI4ohQN54hnKJ3vmWPAIc
         wU5SIxNK17LFp6BsSQo9Nnd37Fjrp9WVPMpqOf43WPvDmAOje34v4z0LQn8gNhS7nGhC
         CVCw==
X-Gm-Message-State: APjAAAVIhnlLUUrt+TmrRqwSTZAfNi7FTzfaakcaSBJIDY3Xdzcvm7PE
        IL5ZXyHhvtc/8/M0vQnkKY+7euzl91tR5djYbtdItA==
X-Google-Smtp-Source: APXvYqxET1q8n/qQ6aY0jYO8nGz1OvZdbUcpn8bnrFqAZJyuuJYIXotPvLB+pBHSS5AiqYMW6+TjrlGJYozegKXPWGc=
X-Received: by 2002:a2e:81c7:: with SMTP id s7mr18353599ljg.3.1580840527698;
 Tue, 04 Feb 2020 10:22:07 -0800 (PST)
MIME-Version: 1.0
References: <1578630784-962-1-git-send-email-daidavid1@codeaurora.org> <1578630784-962-6-git-send-email-daidavid1@codeaurora.org>
In-Reply-To: <1578630784-962-6-git-send-email-daidavid1@codeaurora.org>
From:   Evan Green <evgreen@google.com>
Date:   Tue, 4 Feb 2020 10:21:31 -0800
Message-ID: <CAE=gft6--=zhxfR9G=S0g-5c9YdpvaFWz9dcgV7zJQAzcreZjg@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] interconnect: qcom: sdm845: Split qnodes into
 their respective NoCs
To:     David Dai <daidavid1@codeaurora.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, sboyd@kernel.org,
        Lina Iyer <ilina@codeaurora.org>,
        Sean Sweeney <seansw@qti.qualcomm.com>,
        Alex Elder <elder@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 9, 2020 at 8:33 PM David Dai <daidavid1@codeaurora.org> wrote:
>
> In order to better represent the hardware and its different Network-On-Chip
> devices, split the sdm845 provider driver into NoC specific providers.
> Remove duplicate functionality already provided by the icc rpmh and
> bcm voter drivers to calculate and commit bandwidth requests to hardware.
>
> Signed-off-by: David Dai <daidavid1@codeaurora.org>
> ---
>  drivers/interconnect/qcom/sdm845.c             | 1132 ++++++++++--------------
>  include/dt-bindings/interconnect/qcom,sdm845.h |  263 +++---
>  2 files changed, 609 insertions(+), 786 deletions(-)
>
> diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
> index f078cf0..8145612 100644
> --- a/drivers/interconnect/qcom/sdm845.c
> +++ b/drivers/interconnect/qcom/sdm845.c
> @@ -5,283 +5,285 @@
>   */
>
>  #include <asm/div64.h>

You don't need this header anymore, right?

> -#include <dt-bindings/interconnect/qcom,sdm845.h>
>  #include <linux/device.h>
>  #include <linux/interconnect.h>
>  #include <linux/interconnect-provider.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
> -#include <linux/of_platform.h>
> -#include <linux/platform_device.h>
>  #include <linux/sort.h>

..or this one.
