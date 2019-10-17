Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36862DA7FF
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 11:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439364AbfJQJEq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 05:04:46 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:33394 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439363AbfJQJEq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Oct 2019 05:04:46 -0400
Received: by mail-vk1-f194.google.com with SMTP id s21so348032vkm.0
        for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2019 02:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3YEZ6kmrwj0jmNEINZ5DrxfXAkCY+f5snursTVbXw/Q=;
        b=W2e51Z687HKzqeEUxw8//AMcHGkkuFOP8XPRGjOfymWxiy5Zp1IsFw7JpdMcbsWu2b
         3XRp9hda4U35V3m4NBdsGLbwORsP7M6z6hcLgkBMeNdc6Kv9H54zl1XG8UyqG3oVaiRA
         uYXbj1yTpmGTc5+j3xXkUibu704TmnkPoO2sjQNeCRQIL58QuDsOIAezBG7b14OxBFv6
         5FbrylzIeAFhCyolzRmA8yt6ll3bpHI/fYR97EcEQ3jn9UGLTrm83xRCCHz8AS86pmze
         m1mdnFdbPnS0BElbdxvOVcKomZv+rfTKsUOZ1i3MKBNxnh2hdw7vJ49G7aVlAm37710n
         WkLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3YEZ6kmrwj0jmNEINZ5DrxfXAkCY+f5snursTVbXw/Q=;
        b=dRJ5NTSwkIFRJUwLTgs5mw2SEEjOyWOxjCyVkZyHQS+OG2SDisNqQQxs1BKJN2+D7n
         UpUNKKXHqLczrGOP8bZiWggWZUIiO1HHr3QkLekomPAi+K3gR+PnnaYiPLfGubFzMsAa
         aF5Jrb7v8TB9IUFqk/IdFxtslqDmQJ9ihm0BXK+e+e0tT7r0UqaQZ4IHrh1u30Z1S+53
         z0FEFisOaQBVncz/a58tDuzldVcGfzq/4bFZcjRhl/DPKZW+V6Dt5ERA/Q8BfyilKFc7
         /kNS8+QBsSqnF7uRnsfHzyyGoMx8O00WzYM3CAki27zEttOGdjDHav96MFHJGOhQABrO
         4K8w==
X-Gm-Message-State: APjAAAX1wQCKQFC+XH64Lm0KbrnPC7GoQIZjsIFc2JicZl5BsyDfUCAH
        NpLKVNGYJXSCqJxj7gaweAte0G76zKt5MBjXTgphvQ==
X-Google-Smtp-Source: APXvYqyt8CM8fHUNAOrVRVddOgQGQx8mRNb41o6lI3llgLFlyRzgA5YeS309L///NMZr8TxyMVq1MEKf6S7M8tbxb2E=
X-Received: by 2002:a1f:b202:: with SMTP id b2mr1313280vkf.59.1571303083600;
 Thu, 17 Oct 2019 02:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <1571254641-13626-1-git-send-email-thara.gopinath@linaro.org> <1571254641-13626-7-git-send-email-thara.gopinath@linaro.org>
In-Reply-To: <1571254641-13626-7-git-send-email-thara.gopinath@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 17 Oct 2019 11:04:07 +0200
Message-ID: <CAPDyKFqcKfmnNJ7j4Jb+JH739FBcHg5NBD6aR4H_N=zWGwm1ww@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] dt-bindings: soc: qcom: Extend RPMh power
 controller binding to describe thermal warming device
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, amit.kucheria@verdurent.com,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 16 Oct 2019 at 21:37, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>
> RPMh power controller hosts mx domain that can be used as thermal
> warming device. Add a sub-node to specify this.
>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  Documentation/devicetree/bindings/power/qcom,rpmpd.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
> index eb35b22..fff695d 100644
> --- a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
> +++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
> @@ -18,6 +18,16 @@ Required Properties:
>  Refer to <dt-bindings/power/qcom-rpmpd.h> for the level values for
>  various OPPs for different platforms as well as Power domain indexes
>
> += SUBNODES
> +RPMh alsp hosts power domains that can behave as thermal warming device.
> +These are expressed as subnodes of the RPMh. The name of the node is used
> +to identify the power domain and must therefor be "mx".
> +
> +- #cooling-cells:
> +       Usage: optional
> +       Value type: <u32>
> +       Definition: must be 2
> +

Just wanted to express a minor thought about this. In general we use
subnodes of PM domain providers to represent the topology of PM
domains (subdomains), this is something different, which I guess is
fine.

I assume the #cooling-cells is here tells us this is not a PM domain
provider, but a "cooling device provider"?

Also, I wonder if it would be fine to specify "power-domains" here,
rather than using "name" as I think that is kind of awkward!?

>  Example: rpmh power domain controller and OPP table
>
>  #include <dt-bindings/power/qcom-rpmhpd.h>
> --
> 2.1.4
>

Kind regards
Uffe
