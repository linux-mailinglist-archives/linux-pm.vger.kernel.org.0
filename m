Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43D4DAAA0B
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2019 19:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387663AbfIERct (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Sep 2019 13:32:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46711 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732358AbfIERct (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Sep 2019 13:32:49 -0400
Received: by mail-pg1-f196.google.com with SMTP id m3so1765369pgv.13
        for <linux-pm@vger.kernel.org>; Thu, 05 Sep 2019 10:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:subject:to:from:user-agent:date;
        bh=f/cxCSlkOSNQOctAxBzsNj20vu+MPJAWjCVom+scLtM=;
        b=Ot/TAFXRnL1ZmSBNpKSGC1FPbPlYowycfY1zQqvDsox9CXGblA/G235sihbwPp3yP0
         DOGup6hSau72ryFdD5B9O9BJQZ57Ae4n0g3KsbdMbfVG0PnALc8w3wdy9CMGNDtNwZzz
         styv+zEQihKg+ge9nAwpeKgbUUgiR/ortszcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:subject:to:from
         :user-agent:date;
        bh=f/cxCSlkOSNQOctAxBzsNj20vu+MPJAWjCVom+scLtM=;
        b=TxIuougAsPRXYIoG3deZ2g96LZwInjFF1E9VsL/UW/MD/JkblQRitfAg9U2C8bpFIA
         5CvMQtGlB9BvVW/AVMmW1rrMcsXw2+Cg7kUyveCQhr0CwruW4xKZXahmF3ewsOGjPYHx
         G08rGf+/psxV+XL8lRMQpKGdGksbAKaxGTO4493wUNgRdNzTHqpDUJQWmb1DWdJFuhzN
         aH9m0bn57TgBMtBJTcg3jl32g46tR5WQ+nBgT6MHnEHJ4pLRFH+/253XEg5trcNyxi5G
         qykVxGz6Ajgli7QJDbO4IVuYFyyV9ed/Wzn1PSmHXl5CUiJi/k3whIkK7AUOYwaXy17e
         CBHA==
X-Gm-Message-State: APjAAAVFT8muGZEctQk0ZNrvWF9ViQzIds4bdZtgmw+kfvmfWlHXF+gI
        XUZvj3d/BJR+CKWk+KQW+E3drg==
X-Google-Smtp-Source: APXvYqyDLEfQ9vrdfMKaCyaiKklkMkJv0KNpIFxh/WZng5+5VJVzUfSu2SI+sg3aGMVA/s+iuERd+A==
X-Received: by 2002:a63:b904:: with SMTP id z4mr4150651pge.388.1567704767527;
        Thu, 05 Sep 2019 10:32:47 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id d11sm3266103pfn.151.2019.09.05.10.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 10:32:46 -0700 (PDT)
Message-ID: <5d7146be.1c69fb81.38760.7fb8@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190823081703.17325-5-mkshah@codeaurora.org>
References: <20190823081703.17325-1-mkshah@codeaurora.org> <20190823081703.17325-5-mkshah@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        dianders@chromium.org, rnayak@codeaurora.org, ilina@codeaurora.org,
        lsrao@codeaurora.org, ulf.hansson@linaro.org,
        Maulik Shah <mkshah@codeaurora.org>
Subject: Re: [PATCH v2 4/6] drivers: qcom: rpmh-rsc: Add RSC power domain support
To:     Maulik Shah <mkshah@codeaurora.org>, agross@kernel.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Thu, 05 Sep 2019 10:32:45 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Maulik Shah (2019-08-23 01:17:01)
> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index e278fc11fe5c..884b39599e8f 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -498,6 +498,32 @@ static int tcs_ctrl_write(struct rsc_drv *drv, const=
 struct tcs_request *msg)
>         return ret;
>  }
> =20
> +/**
> + *  rpmh_rsc_ctrlr_is_idle: Check if any of the AMCs are busy.
> + *
> + *  @drv: The controller
> + *
> + *  Returns false if the TCSes are engaged in handling requests,

Please use kernel-doc style for returns here.

> + *  True if controller is idle.
> + */
> +static bool rpmh_rsc_ctrlr_is_idle(struct rsc_drv *drv)
> +{
> +       int m;
> +       struct tcs_group *tcs =3D get_tcs_of_type(drv, ACTIVE_TCS);
> +       bool ret =3D true;
> +
> +       spin_lock(&drv->lock);

I think these need to be irqsave/restore still.

> +       for (m =3D tcs->offset; m < tcs->offset + tcs->num_tcs; m++) {
> +               if (!tcs_is_free(drv, m)) {

This snippet is from tcs_invalidate(). Please collapse it into some sort
of function or macro like for_each_tcs().

> +                       ret =3D false;
> +                       break;
> +               }
> +       }
> +       spin_unlock(&drv->lock);
> +
> +       return ret;
> +}
> +
>  /**
>   * rpmh_rsc_write_ctrl_data: Write request to the controller
>   *
> @@ -521,6 +547,53 @@ int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv, co=
nst struct tcs_request *msg)
>         return tcs_ctrl_write(drv, msg);
>  }
> =20
> +static int rpmh_domain_power_off(struct generic_pm_domain *rsc_pd)
> +{
> +       struct rsc_drv *drv =3D container_of(rsc_pd, struct rsc_drv, rsc_=
pd);
> +
> +       /*
> +        * RPMh domain can not be powered off when there is pending ACK f=
or
> +        * ACTIVE_TCS request. Exit when controller is busy.
> +        */
> +

Nitpick: Remove this extra newline.

> +       if (!rpmh_rsc_ctrlr_is_idle(drv))
> +               return -EBUSY;
> +
> +       return rpmh_flush(&drv->client);
> +}
> +
> +static int rpmh_probe_power_domain(struct platform_device *pdev,
> +                                  struct rsc_drv *drv)
> +{
> +       int ret;
> +       struct generic_pm_domain *rsc_pd =3D &drv->rsc_pd;
> +       struct device_node *dn =3D pdev->dev.of_node;
> +
> +       rsc_pd->name =3D kasprintf(GFP_KERNEL, "%s", dn->name);

Maybe use devm_kasprintf?

> +       if (!rsc_pd->name)
> +               return -ENOMEM;
> +
> +       rsc_pd->name =3D kbasename(rsc_pd->name);
> +       rsc_pd->power_off =3D rpmh_domain_power_off;
> +       rsc_pd->flags |=3D GENPD_FLAG_IRQ_SAFE;
> +
> +       ret =3D pm_genpd_init(rsc_pd, NULL, false);
> +       if (ret)
> +               goto free_name;
> +
> +       ret =3D of_genpd_add_provider_simple(dn, rsc_pd);
> +       if (ret)
> +               goto remove_pd;
> +
> +       return ret;
> +
> +remove_pd:
> +       pm_genpd_remove(rsc_pd);
> +free_name:
> +       kfree(rsc_pd->name);

And then drop this one?

> +       return ret;
> +}
> +
>  static int rpmh_probe_tcs_config(struct platform_device *pdev,
>                                  struct rsc_drv *drv)
>  {
> @@ -650,6 +723,17 @@ static int rpmh_rsc_probe(struct platform_device *pd=
ev)
>         if (ret)
>                 return ret;
> =20
> +       /*
> +        * Power domain is not required for controllers that support 'sol=
ver'
> +        * mode where they can be in autonomous mode executing low power =
mode
> +        * to power down.
> +        */
> +       if (of_property_read_bool(dn, "#power-domain-cells")) {
> +               ret =3D rpmh_probe_power_domain(pdev, drv);
> +               if (ret)
> +                       return ret;
> +       }
> +
>         spin_lock_init(&drv->lock);
>         bitmap_zero(drv->tcs_in_use, MAX_TCS_NR);

What happens if it fails later on? The genpd provider is still sitting
around and needs to be removed on probe failure later on in this
function. It would be nicer if there wasn't another function to probe
the power domain and it was just inlined here actually. That way we
don't have to wonder about what's going on across two blocks of code.

