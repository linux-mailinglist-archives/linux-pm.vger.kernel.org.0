Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 304FA907A6
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2019 20:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfHPSVc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Aug 2019 14:21:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:45602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727568AbfHPSVc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 16 Aug 2019 14:21:32 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A692E206C1;
        Fri, 16 Aug 2019 18:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565979691;
        bh=SdLfbqllEBIl5x50TrX3UxG8XOSW2YtXDHKp5IStfXM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=e53ZOCk/X9G2cDNOl0Z73k7huakI07VBl7FdYFhOLpShZfOzZ+5coj70+uwihDuvk
         z9s6x8bIEepalcIsgxfqA417KLs5rwMzixF/i/iCjCs5hEETPYowz8ThkXLhea1b2B
         9fE9gRvCpr7m3PE9EV05zdCL1YPGNixTRhMdfNS4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190807223111.230846-3-saravanak@google.com>
References: <20190807223111.230846-1-saravanak@google.com> <20190807223111.230846-3-saravanak@google.com>
Subject: Re: [PATCH v5 2/3] OPP: Add support for bandwidth OPP tables
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
Date:   Fri, 16 Aug 2019 11:21:30 -0700
Message-Id: <20190816182131.A692E206C1@mail.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Saravana Kannan (2019-08-07 15:31:10)
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 1813f5ad5fa2..e1750033fef9 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -523,6 +523,35 @@ void dev_pm_opp_of_remove_table(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
> =20
> +static int _read_opp_key(struct dev_pm_opp *new_opp, struct device_node =
*np)
> +{
> +       int ret;
> +       u64 rate;
> +       u32 bw;
> +
> +       ret =3D of_property_read_u64(np, "opp-hz", &rate);
> +       if (!ret) {
> +               /*
> +                * Rate is defined as an unsigned long in clk API, and so
> +                * casting explicitly to its type. Must be fixed once rat=
e is 64
> +                * bit guaranteed in clk API.
> +                */
> +               new_opp->rate =3D (unsigned long)rate;
> +               return 0;
> +       }
> +
> +       ret =3D of_property_read_u32(np, "opp-peak-kBps", &bw);
> +       if (ret)
> +               return ret;
> +       new_opp->rate =3D (unsigned long) bw;
> +
> +       ret =3D of_property_read_u32(np, "opp-avg-kBps", &bw);
> +       if (!ret)

I would write this as=20

	if (!of_property_read_u32(np, "opp-avg-kBps", &bw))
		new_opp->avg_bw =3D (unsigned long) bw;

because you don't care about the return value.

> +               new_opp->avg_bw =3D (unsigned long) bw;
> +
> +       return 0;
> +}
> +
>  /**
>   * _opp_add_static_v2() - Allocate static OPPs (As per 'v2' DT bindings)
>   * @opp_table: OPP table
> diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
> index 01a500e2c40a..6bb238af9cac 100644
> --- a/drivers/opp/opp.h
> +++ b/drivers/opp/opp.h
> @@ -56,7 +56,8 @@ extern struct list_head opp_tables;
>   * @turbo:     true if turbo (boost) OPP
>   * @suspend:   true if suspend OPP
>   * @pstate: Device's power domain's performance state.
> - * @rate:      Frequency in hertz
> + * @rate:      Frequency in hertz OR Peak bandwidth in kilobytes per sec=
ond

Why is Peak capitalized?

> + * @avg_bw:    Average bandwidth in kilobytes per second
>   * @level:     Performance level
>   * @supplies:  Power supplies voltage/current values
>   * @clock_latency_ns: Latency (in nanoseconds) of switching to this OPP's
> @@ -78,6 +79,7 @@ struct dev_pm_opp {
>         bool suspend;
>         unsigned int pstate;
>         unsigned long rate;

If you're trying to save space why not make an anonymous union here of
'rate' and 'bandwidth'? Then the code doesn't read all weird.

> +       unsigned long avg_bw;
>         unsigned int level;
> =20
>         struct dev_pm_opp_supply *supplies;
