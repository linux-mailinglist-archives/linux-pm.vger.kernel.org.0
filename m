Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45D3668638
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jan 2023 22:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240396AbjALV4S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Jan 2023 16:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239924AbjALVzz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Jan 2023 16:55:55 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D38282
        for <linux-pm@vger.kernel.org>; Thu, 12 Jan 2023 13:47:39 -0800 (PST)
Received: from g550jk.localnet (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id A7B63CD0CE;
        Thu, 12 Jan 2023 21:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1673560057; bh=3GSAcgkhxyHPcJgDSr6fkcd+ojFd3CMPlK4by/i+niw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ffhWYEBcLSX4sBeR541YtTm7wVmidoCiMP4p0bWxZ+0H9YF0/al4+bmvwmsitxuw/
         eIbB4e6pLQG2ojFmr/oEdHxd2qD19OyU7zsThI1qxdHGPQQe2v3G4X5y4d1HYbJK0h
         yPcfM9wYda9Vx7tx/YoKsNLaFy7tW0EOD+EKCYjY=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Caleb Connolly <caleb.connolly@linaro.org>,
        linux-pm@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [RFC PATCH] power: supply: fix circular dependency with cooling device
Date:   Thu, 12 Jan 2023 22:47:37 +0100
Message-ID: <2266534.ElGaqSPkdT@g550jk>
In-Reply-To: <20230101174342.58351-1-caleb.connolly@linaro.org>
References: <20230101174342.58351-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FROM_SUSPICIOUS_NTLD,SPF_HELO_NONE,SPF_PASS,
        T_PDS_OTHER_BAD_TLD autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sonntag, 1. J=E4nner 2023 18:43:40 CET Caleb Connolly wrote:
> A recent change in thermal/core means it now calls the cooling device
> ->get_max_state() callback during __thermal_cooling_device_register().
> This creates a circular dependency as it attempts to fetch a power
> supply property before the psy is initialised. Move this call later to
> break the dependency.
>=20
> Fixes: c408b3d1d9bb ("thermal: Validate new state in cur_state_store()")
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

=46ixes USB on qcom-apq8026-lg-lenok (with smbb driver)

Tested-by: Luca Weiss <luca@z3ntu.xyz>

Regards
Luca

> ---
>  drivers/power/supply/power_supply_core.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/power/supply/power_supply_core.c
> b/drivers/power/supply/power_supply_core.c index 7c790c41e2fe..c921111ff2=
6a
> 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -1354,10 +1354,6 @@ __power_supply_register(struct device *parent,
>  	if (rc)
>  		goto register_thermal_failed;
>=20
> -	rc =3D psy_register_cooler(psy);
> -	if (rc)
> -		goto register_cooler_failed;
> -
>  	rc =3D power_supply_create_triggers(psy);
>  	if (rc)
>  		goto create_triggers_failed;
> @@ -1378,17 +1374,27 @@ __power_supply_register(struct device *parent,
>  	atomic_inc(&psy->use_cnt);
>  	psy->initialized =3D true;
>=20
> +	/* This has to be done after updating use_cnt and initialized
> +	 * otherwise when __thermal_cooling_device_register calls back
> +	 * to ->get_max_state() the psy core will return -EAGAIN..
> +	 */
> +	rc =3D psy_register_cooler(psy);
> +	if (rc)
> +		goto register_cooler_failed;
> +
>  	queue_delayed_work(system_power_efficient_wq,
>  			   &psy->deferred_register_work,
>  			   POWER_SUPPLY_DEFERRED_REGISTER_TIME);
>=20
>  	return psy;
>=20
> +register_cooler_failed:
> +	power_supply_remove_hwmon_sysfs(psy);
> +	psy->initialized =3D false;
> +	atomic_dec(&psy->use_cnt);
>  add_hwmon_sysfs_failed:
>  	power_supply_remove_triggers(psy);
>  create_triggers_failed:
> -	psy_unregister_cooler(psy);
> -register_cooler_failed:
>  	psy_unregister_thermal(psy);
>  register_thermal_failed:
>  wakeup_init_failed:




