Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6270F8DCEC
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2019 20:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbfHNSZE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Aug 2019 14:25:04 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36856 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbfHNSZE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Aug 2019 14:25:04 -0400
Received: by mail-pf1-f196.google.com with SMTP id w2so3248459pfi.3
        for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2019 11:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=N9JGHYuENBo6LI4cBzytfOqDlISO6qEtWahhb1tznSg=;
        b=TW14/7JpTaH7Jot09F83/edfsuN7PZqPT/t2KHRSRcFmxfkGIH0Ga1ih1wOEoLZWg3
         PJ4CH5PgSyjXydAzcYMZrZ45m+W1+SbVM2N79LMRlqsGZztFdNkM0AmolymrRX8Ptt2v
         iWpRqvmjd/ogT8LaD7sfVl2xaPZVZOEioC/k4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=N9JGHYuENBo6LI4cBzytfOqDlISO6qEtWahhb1tznSg=;
        b=ubvcQ1NtxylYwjD8uMV3NSho32Xs1HbnLRKlxFU/veeMdGvqenhjlxrLC71+Dd8Ypw
         gDkL8f0hH0UPKpw/8i21Q7tkyO3JH1us0PFFkth6EV/cNRBpEiDVUMeQY0EJEKsGwwB4
         8poS7xEe3tRhEhg+ovu0qFl/+qT+rHsNBokH63GBRje7U/9H0ZoXQu4OGSVKab9dtkoa
         V9u4Su6UA1+A3+qT8/CTqTN7UjOgGr5ROt36JFkvYV12F/7vmVxcpW+vrQmiy/k0juzT
         bAHzmrpMB//ypbNBUlRXXi4+pLt0mhYktDT8iVC4WLwmy2vyfwFPDKl4A+Ka0NfYJXyj
         qTMg==
X-Gm-Message-State: APjAAAWFAMugUULIotysiI3wsHBqDEeJpl+ebijsrFE5Xqtd+PSjBuG6
        ZoT+kp9A8tsL7Fr6T8Y7R3wHpw==
X-Google-Smtp-Source: APXvYqwx1cNv7KXO8GPOLDPiAoft0yMlhl6xu12cCga8P4mioA7Rt0WlLa0RjsLJMnzJ0HD0UBmlNg==
X-Received: by 2002:a65:5348:: with SMTP id w8mr448232pgr.176.1565807103356;
        Wed, 14 Aug 2019 11:25:03 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id p90sm585636pjp.7.2019.08.14.11.25.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 11:25:02 -0700 (PDT)
Message-ID: <5d5451fe.1c69fb81.ee115.1711@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190813082442.25796-5-mkshah@codeaurora.org>
References: <20190813082442.25796-1-mkshah@codeaurora.org> <20190813082442.25796-5-mkshah@codeaurora.org>
Subject: Re: [PATCH 4/4] drivers: qcom: rpmh-rsc: Add RSC power domain support
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        dianders@chromium.org, rnayak@codeaurora.org, ilina@codeaurora.org,
        lsrao@codeaurora.org, ulf.hansson@linaro.org,
        Maulik Shah <mkshah@codeaurora.org>
To:     Maulik Shah <mkshah@codeaurora.org>, agross@kernel.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Wed, 14 Aug 2019 11:25:01 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Maulik Shah (2019-08-13 01:24:42)
> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index e278fc11fe5c..bd8e9f1a43b4 100644
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
> + *  True if controller is idle.
> + */
> +static bool rpmh_rsc_ctrlr_is_idle(struct rsc_drv *drv)
> +{
> +       int m;
> +       struct tcs_group *tcs =3D get_tcs_of_type(drv, ACTIVE_TCS);
> +       bool ret =3D true;
> +
> +       spin_lock(&drv->lock);
> +       for (m =3D tcs->offset; m < tcs->offset + tcs->num_tcs; m++) {
> +               if (!tcs_is_free(drv, m)) {

Isn't this a copy of an existing function in the rpmh driver?

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
> @@ -521,6 +547,65 @@ int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv, co=
nst struct tcs_request *msg)
>         return tcs_ctrl_write(drv, msg);
>  }
> =20
> +int rpmh_domain_power_off(struct generic_pm_domain *rsc_pd)
> +{
> +       struct rsc_drv *drv =3D container_of(rsc_pd, struct rsc_drv, rsc_=
pd);
> +       int ret =3D 0;
> +
> +       /*
> +        * RPMh domain can not be powered off when there is pending ACK f=
or
> +        * ACTIVE_TCS request. Exit when controller is busy.
> +        */
> +
> +       ret =3D rpmh_rsc_ctrlr_is_idle(drv);
> +       if (!ret)
> +               goto exit;

return 0? Shouldn't it return some negative value?

> +
> +       ret =3D rpmh_flush(&drv->client);
> +       if (ret)
> +               goto exit;

Why not just return rpmh_flush(...)?

The usage of goto in this function is entirely unnecessary.

> +
> +exit:
> +       return ret;
> +}
> +
> +static int rpmh_probe_power_domain(struct platform_device *pdev,
> +                                  struct rsc_drv *drv)
> +{
> +       int ret =3D -ENOMEM;
> +       struct generic_pm_domain *rsc_pd =3D &drv->rsc_pd;
> +       struct device_node *dn =3D pdev->dev.of_node;
> +
> +       rsc_pd->name =3D kasprintf(GFP_KERNEL, "%s", dn->name);
> +       if (!rsc_pd->name)
> +               goto exit;

return -ENOMEM;

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
> +       pr_debug("init PM domain %s\n", rsc_pd->name);
> +
> +       return ret;

	ret =3D of_genpd_add_provider_simple(...)
	if (!ret)
		return 0;

Drop the pr_debug(), it's not useful.

> +
> +remove_pd:
> +       pm_genpd_remove(rsc_pd);
> +
> +free_name:
> +       kfree(rsc_pd->name);
> +
> +exit:
> +       return ret;

Please remove newlines between labels above.

