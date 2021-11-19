Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7112B45679C
	for <lists+linux-pm@lfdr.de>; Fri, 19 Nov 2021 02:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbhKSBw3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Nov 2021 20:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbhKSBw2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Nov 2021 20:52:28 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDA7C061574
        for <linux-pm@vger.kernel.org>; Thu, 18 Nov 2021 17:49:27 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id x19-20020a9d7053000000b0055c8b39420bso14341781otj.1
        for <linux-pm@vger.kernel.org>; Thu, 18 Nov 2021 17:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p/yB12Lwz7EzvGfdERVvlnwuUIvVBmwlt8u3SLltb74=;
        b=LBGGkZ/6Lag+yjHnf6Xyt1g2QfNYRv0mCun5+qxjty42nWhtn2KKlXp0zXt2kpDgdd
         +W6wzpPPwVy7vpASA/IWmbQpjOuuzyI4fodo0rLkf06tY5eeFeoYk91mX6PeJQHHO1Nq
         gJUQ9qtyXWdg1vTiRAuUbfhiyV1RdJ7tJ6eWjWeAjhi1651n5709+dEVe1ASPsbk4n8K
         b9AGCS92Y80nCmONEfnIl0VbMMtBHux5oOdtxZ249EVCJ5YZ5H72nJqWZLAQGiAy+8Ug
         VThMbutyzfyJ0oKIfP+k18Ha6QPRSdjrEVBz123C9mO1S62raSYPHzvUkb1qLSRhYasO
         4vIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p/yB12Lwz7EzvGfdERVvlnwuUIvVBmwlt8u3SLltb74=;
        b=os3Kl4MPudOrhQcfjpWBLQou/LZOsuq7dsH8WP/Wk16q5a81QRaEZx2CsvrGAMrpCN
         olHAUzJa1iHlz1rZIJ0NqQNw26uY/WOQNAOGAep7Xp286JDJUkZnnzAxOuURGHJvzwdC
         b+C5O/CX2/i7vPLKfeWz287J/WW4L5fh0krHpeJtWUElHwiX8sjTqfTMM+ENiNr940gv
         Wma3VJ/rHsiGDKu2OKisidIMmNtpD+hYAbefBO94DXR/7h/I/IoNaPJBmaB+a8NA5ia5
         qTe6VMCGHaTSen/SQ+VM8XVVmciN1COwyW16ZG2yl43wYQbUQDn4WO/oGb3LuaU5JdMI
         iQNw==
X-Gm-Message-State: AOAM533bxmULhWk/iU5sUy92v9tLSmoGX7nzWHrGk5lEidIWBSrhdXLD
        Z98bftiD2Lw77FgQ+D3BGGJt6PWODkydT4SkJRXRBg==
X-Google-Smtp-Source: ABdhPJw6Jo5EKLi4h1LH7kdp+MaUuceje5OBNlQRaAoBgEVhDH/nsZroQkkQPqsdlu6RHeJkx54/yTg/O7KbnMDbuwI=
X-Received: by 2002:a9d:ed6:: with SMTP id 80mr1487939otj.35.1637286567370;
 Thu, 18 Nov 2021 17:49:27 -0800 (PST)
MIME-Version: 1.0
References: <cover.1637061794.git.matti.vaittinen@fi.rohmeurope.com> <392c7aa891d466bc4df06a076090150319e0e7dc.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
In-Reply-To: <392c7aa891d466bc4df06a076090150319e0e7dc.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 19 Nov 2021 02:49:15 +0100
Message-ID: <CACRpkdZ4HvgYyssNw_bfWR-7YQXEe_nPOtZChY_ZPUpz_Ga7jA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 6/9] power: supply: Add batinfo functions for OCV
 to SOC with 0.1% accuracy
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, rostokus@gmail.com,
        fan.chen@mediatek.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-power@fi.rohmeurope.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 16, 2021 at 1:27 PM Matti Vaittinen
<matti.vaittinen@fi.rohmeurope.com> wrote:

> The battery info functions computing the state-of-charge (SOC) based
> on open-circuit-voltage (OCV) are returning SOC using units of 1%.
>
> Some capacity estimation computations require higher accuracy. Add
> functions that return SOC using units of 0.1% to reduce rounding error.
>
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

That sounds useful.

> +int power_supply_ocv2dcap_simple(struct power_supply_battery_ocv_table *table,
> +                               int table_len, int ocv)
> +{
> +       int i, cap, tmp;

Why a whole new function? Just rename the original power_supply_ocv2cap_simple()
to power_supply_ocv2dcap_simple and patch it to return the finegrained value,
then add a wrapper that use that function but drops it down by one order
of magnitude.

> +int power_supply_batinfo_ocv2dcap(struct power_supply_battery_info *info,
> +                                 int ocv, int temp)

Same with this, saves a lot of code!

(Also will use my new interpolation routines since you refactor
on top of that.)

Yours,
Linus Walleij
