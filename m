Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39CFD151FA9
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2020 18:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbgBDRmB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Feb 2020 12:42:01 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:46111 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbgBDRmB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Feb 2020 12:42:01 -0500
Received: by mail-vs1-f65.google.com with SMTP id t12so11890171vso.13
        for <linux-pm@vger.kernel.org>; Tue, 04 Feb 2020 09:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fjuC2Q+emYlj3liTOkhD1vT9STVKFzAaIxRG9/y4iLc=;
        b=ZuVKoRBbN2IxVALm7ARFmbp19wHiGrM2qMixN5b4MYb4oB/R0B4QxZnKEsVDmmofqR
         k6mxVSRfB+v3QsTaNfp4d6f2d3SZKhLpXl6Hm+50L7unNYEavzkC7D1Vb+hxcJnl1XjB
         QTb9FHxN3Z5Ir9DhS+5rxFnyeR7o736FgGuvc0YfEMjG29aUhUBV+k2y0wujIwgSne3f
         uK8i6oC22/ss2UONJtnI1p28HhBfD511L4euVCxYWTq8RzETezIQ1LsGHo/qNrTPoRWQ
         vMx4uVGYS8OZd11dPpszNxE+L9thfWUIopzVtFD7rkWgvJHuiRaLDzl04JIisQeay7/p
         yL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fjuC2Q+emYlj3liTOkhD1vT9STVKFzAaIxRG9/y4iLc=;
        b=UrVCiZnHXaxekkCK7o2V8y6tx9Mb6c4SAvjSBdpPhTvnqHOxL7wNR3oPaSu8Yv2gzE
         7gnGJl3Ko2+s5EIM1e8tzvPP4iWdfGtCeXhbFt5aLdAa8v2XvPzrehB3lSMx6qybrSMg
         Ny4zCqKl5OHyYRgElEkZ4PipO2VJJ0AiBLMkQAUPL7HVA+5Gnzjt+TYKyWVXc5wqZgaa
         O827ZmnKd6Vh8goNKApcZp1ZEPuHzAucgeXVE8qumoojElPkR8wWykmEGVvSe9CZqs1U
         OA84U8aO9wH1NrO8eN9ou/qNpd3pB42xNR7bBs//LOluzPDgE4XUvWhPffar/OyHYrSN
         buOQ==
X-Gm-Message-State: APjAAAXdl4Dy2ceEd9y56xor++LKYl/qEBwhSdS07DofyPkrjVL/mew9
        czubDa3O/6eWPHTeq+QjJAs8TkDM4efM+ZtBLX+lKA==
X-Google-Smtp-Source: APXvYqyjrOIcbN1CA5AmmX2fCOqRAU7O978JET53Jj4/L8pqQCnTpNTrAge1isc2vOAXGGZ0K3lgeSxX/nKsE/f0Vpk=
X-Received: by 2002:a67:ee02:: with SMTP id f2mr18787393vsp.165.1580838120569;
 Tue, 04 Feb 2020 09:42:00 -0800 (PST)
MIME-Version: 1.0
References: <1574254593-16078-1-git-send-email-thara.gopinath@linaro.org> <1574254593-16078-7-git-send-email-thara.gopinath@linaro.org>
In-Reply-To: <1574254593-16078-7-git-send-email-thara.gopinath@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 4 Feb 2020 18:41:24 +0100
Message-ID: <CAPDyKFrZ9QM9L4OEFuseRTC+mBqourv11Rcu3Ua95ZPKoNFgng@mail.gmail.com>
Subject: Re: [Patch v4 6/7] dt-bindings: soc: qcom: Extend RPMh power
 controller binding to describe thermal warming device
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
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

On Wed, 20 Nov 2019 at 13:57, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>
> RPMh power controller hosts mx domain that can be used as thermal warming
> device. Add #cooling-cells property to the power domain provider node to
> indicate this.
>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
> v3->v4:
>         - Removed subnode to indicate that mx power domain is a warming
>           device. Instead #cooling-cells is used as a power domain
>           provider property to indicate if the provider hosts a power
>           domain that can be used as a warming device.
>
>  Documentation/devicetree/bindings/power/qcom,rpmpd.txt | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
> index bc75bf4..a193d33 100644
> --- a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
> +++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
> @@ -19,6 +19,11 @@ Required Properties:
>  Refer to <dt-bindings/power/qcom-rpmpd.h> for the level values for
>  various OPPs for different platforms as well as Power domain indexes
>
> +Optional Properties
> + - #cooling-cells: must be 2
> +       RPMh also hosts power domains that can behave as thermal warming
> +       device. If so, indicate this by specifying #cooling-cells.
> +
>  Example: rpmh power domain controller and OPP table
>
>  #include <dt-bindings/power/qcom-rpmhpd.h>
> --
> 2.1.4
>
