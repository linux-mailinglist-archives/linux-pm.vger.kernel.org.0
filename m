Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2120A1ADFEE
	for <lists+linux-pm@lfdr.de>; Fri, 17 Apr 2020 16:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgDQOaS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Apr 2020 10:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgDQOaQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Apr 2020 10:30:16 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76572C061A10
        for <linux-pm@vger.kernel.org>; Fri, 17 Apr 2020 07:30:14 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id q8so1718687eja.2
        for <linux-pm@vger.kernel.org>; Fri, 17 Apr 2020 07:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t4kmCow4WbTQt7XbF+AHk2oxINCbHnDLYHrlyOhKeBk=;
        b=O655oVXD26/Duqzplq5CoYORER7kylQOADLYA8rTjyrsRtR+cZoU1U4nPoMhz2fkz8
         hapAuxqoExCMkSrWtwrMaz1fh4B5HjHb6jhmbHULPqqw+j6tfZjmofNvMNaDq/pdhDdf
         jQbdidXViJE77LOAHkJ6/vpAL2zd7EOztZHXN4ZS1D3gfE7tNnUtkMK4IFtHz2tQNL9H
         9YJcx+coYjh+IcshnyOrzzCjR23xQUP76YvhuMi8qg81ltnrMvYhhWBemdUw1mkr/JMd
         x9WcSSshr6riUwK78zVOB0ReS93JWQIfKnx4W90kVjq5grkY1sAVC6hFgbMwY6FePuIM
         t+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t4kmCow4WbTQt7XbF+AHk2oxINCbHnDLYHrlyOhKeBk=;
        b=djPKWMunhPfClMrM/pDoY8m2hCylZ3jwxo11gA9W9hmJL7NqoI/23A+E8JpPZ88PPe
         gu5autSV43UvINge8wT6MncR/kGWPVEaSI2K7uczlgTGMmw9/R4ywqLRZ/+G06WBviAi
         D38vyzWzr1F+6eiRAO9gQZh/8bwNtsXdryEnrof9OXXtvvE7wmkcNjlABau2K6OZqbc0
         ds7F63gFVpEWGDlDUlen/h101LKxDNTBR1XlDZhC0Z23rPC0uiCLp1qcEOLaB4XMn7bR
         Jn9C3dKm/u8sG3rhZ1kEVlxP/NJtUNsRVVtOuIJXBu5NvtYRbZAdNkNg/5mu9/w1WvUm
         pX7g==
X-Gm-Message-State: AGi0PuZpKM3DjcSM7Z6NfLNTczbwPH0Dh/J9g2mna/ts0/XH23A1J7km
        tdcmgkZBuhVU9Mkw/zAO9mt/AsRMGubjIBU+ThodVg==
X-Google-Smtp-Source: APiQypKPdKUYjS3rat3E9WJ8o9VJMKiO8ypcMyMQxjiSuPo/IX7IsxV3bqp0yPJ5iuSP5EY8uP4deMWceCiTHe4iuBY=
X-Received: by 2002:a17:906:11c9:: with SMTP id o9mr3448550eja.64.1587133812954;
 Fri, 17 Apr 2020 07:30:12 -0700 (PDT)
MIME-Version: 1.0
References: <ilia.lin@kernel.org> <20200313175213.8654-1-ansuelsmth@gmail.com>
In-Reply-To: <20200313175213.8654-1-ansuelsmth@gmail.com>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Fri, 17 Apr 2020 16:34:03 +0200
Message-ID: <CAMZdPi8XnoCiD2OL8dEEG6qtcicz9BM5CrziX4p9_s-UNKk9HQ@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: qcom: Add support for krait based socs
To:     Ansuel Smith <ansuelsmth@gmail.com>, viresh.kumar@linaro.org
Cc:     ilia.lin@kernel.org, Sricharan R <sricharan@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:QUALCOMM CPUFREQ DRIVER MSM8996/APQ8096" 
        <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh, Ansuel,



On Fri, 13 Mar 2020 at 18:52, Ansuel Smith <ansuelsmth@gmail.com> wrote:
>
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

> --- a/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
> +++ b/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
> @@ -19,7 +19,8 @@ In 'cpu' nodes:
>  In 'operating-points-v2' table:
>  - compatible: Should be
> -       - 'operating-points-v2-kryo-cpu' for apq8096 and msm8996.
> +       - 'operating-points-v2-kryo-cpu' for apq8096, msm8996, msm8974,
> +                                            apq8064, ipq8064, msm8960 and ipq8074.

> @@ -153,7 +277,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
>         if (!np)
>                 return -ENOENT;
>
> -       ret = of_device_is_compatible(np, "operating-points-v2-kryo-cpu");
> +       ret = of_device_is_compatible(np, "operating-points-v2-qcom-cpu");

This breaks backward compatibility and is not aligned with the
qcom-nvmem-cpufreq compatible binding.

Regards,
Loic
