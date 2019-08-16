Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 839D8907AA
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2019 20:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfHPSXA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Aug 2019 14:23:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:46108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727500AbfHPSXA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 16 Aug 2019 14:23:00 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 538532077C;
        Fri, 16 Aug 2019 18:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565979779;
        bh=Os7RmwFmk/bvYTsc+erxUvNygEZaIVYpIKLZnm5tJQ8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Adjba4SejZEIRO+Ov9Lzdodd3sqIArS0Iry4f3BQyWM2DQroF9Z+U11Pbs1d/Aru1
         qPxAzwjzPc5OUdkL2N6Mn5Fz4HTfMF0fh0d/R0QFfLjrWELMYOfgbsCcOieyJkPtIs
         IaRzYp/utbr1y9t+DUUcp8A1vEpDgVyuhnbdWEg0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190807223111.230846-4-saravanak@google.com>
References: <20190807223111.230846-1-saravanak@google.com> <20190807223111.230846-4-saravanak@google.com>
Subject: Re: [PATCH v5 3/3] OPP: Add helper function for bandwidth OPP tables
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        vincent.guittot@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, adharmap@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>, sibis@codeaurora.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        kernel-team@android.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Viresh Kumar <vireshk@kernel.org>
User-Agent: alot/0.8.1
Date:   Fri, 16 Aug 2019 11:22:58 -0700
Message-Id: <20190816182259.538532077C@mail.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Saravana Kannan (2019-08-07 15:31:11)
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 3b7ffd0234e9..22dcf22f908f 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -127,6 +127,29 @@ unsigned long dev_pm_opp_get_freq(struct dev_pm_opp =
*opp)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq);
> =20
> +/**
> + * dev_pm_opp_get_bw() - Gets the bandwidth corresponding to an availabl=
e opp
> + * @opp:       opp for which frequency has to be returned for

s/frequency/bandwidth/ ?

> + * @avg_bw:    Pointer where the corresponding average bandwidth is stor=
ed.
> + *             Can be NULL.
> + *
> + * Return: Peak bandwidth in kBps corresponding to the opp, else
> + * return 0
> + */
> +unsigned long dev_pm_opp_get_bw(struct dev_pm_opp *opp, unsigned long *a=
vg_bw)
> +{
> +       if (IS_ERR_OR_NULL(opp) || !opp->available) {
> +               pr_err("%s: Invalid parameters\n", __func__);
> +               return 0;
> +       }
> +
> +       if (avg_bw)
> +               *avg_bw =3D opp->avg_bw;
> +
> +       return opp->rate;

It deserves a comment if it stays named 'rate'. At a glance it looks
like a bug.

> +}
> +EXPORT_SYMBOL_GPL(dev_pm_opp_get_bw);
> +
>  /**
>   * dev_pm_opp_get_level() - Gets the level corresponding to an available=
 opp
>   * @opp:       opp for which level value has to be returned for
> @@ -299,6 +322,34 @@ unsigned long dev_pm_opp_get_suspend_opp_freq(struct=
 device *dev)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_get_suspend_opp_freq);
> =20
> +/**
> + * dev_pm_opp_get_suspend_opp_bw() - Get peak bandwidth of suspend opp i=
n kBps
> + * @dev:       device for which we do this operation
> + * @avg_bw:    Pointer where the corresponding average bandwidth is stor=
ed.
> + *             Can be NULL.
> + *
> + * Return: This function returns the peak bandwidth of the OPP marked as
> + * suspend_opp if one is available, else returns 0;

Why a semicolon instead a full stop?

