Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C16D528B19
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2019 21:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387599AbfEWTyr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 May 2019 15:54:47 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34607 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387546AbfEWTyr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 May 2019 15:54:47 -0400
Received: by mail-pl1-f193.google.com with SMTP id w7so3167702plz.1
        for <linux-pm@vger.kernel.org>; Thu, 23 May 2019 12:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U3LLk369lx0l/Cax30ZKFIWopXk4cwhU19zVTBRdyDg=;
        b=OLTWrxv9KFJRtLRvrA9iUwbxM3MnJ4We26ubghbbb7/DT61JHNFhpo+x+taiQkkHt3
         r/VxXdmi7n8S4NX8La2p0v7lijEBYWBI+doPOfIBDZSx+/XGRSaXHENBlfcUmq2o+jgZ
         RDzlec51PgRhBXrzNQbZUEbyI42vchEtJo4dqUzVms+sGCcoZ4gNgkW8fPYO9wdL4AnS
         8b6OImpZAUeTBqm4cp4COeRgvY4x0Q1AGguiT+q/Abv0cUFWY7gxEPacHz97RaGNFDf2
         s4dLzoanFzg144hLIhWtb/hmNoaIqInf5nr+Uxw+Rndhtm2nV+8Vhwy4H3gRAAgt9vc4
         2ilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U3LLk369lx0l/Cax30ZKFIWopXk4cwhU19zVTBRdyDg=;
        b=P+KJ8aCEZUln23KZj9CTASDwCk4lAW1BK6zQYXrbNPFjSNP+T3yXJQjLnUi07gjo2i
         LcdRcsBPQpsr8suxAKZP7C6mAD8BqYAm/7gS6JHIgxIYmZy0nqJgOrX0vTR6T+Eas2gv
         OTjWyqMC7vD1KGCX8P+5++sFztPIZUizddT9LVApMDH6TrCCawRSkmzhFBe91WsVBd5e
         IWY6nk/4KGswccHiOs71oXmPy+Vflc1dtNcJUlKQan338cCVM6BpFo2KF+YWxfb3a6Fw
         bJFF05OifA3/9YCxscCelYDT2OJKeQv7ai7n0M5CYV/iQIBNFLzw7eUsz/qpFcXREbHL
         B9dg==
X-Gm-Message-State: APjAAAWV8BKlTldI2z9GelKQnxO8KlvWoGscxhjr0SyzdSncUfgP1G55
        yYLEBz4W4ZvthdfUNaIBlZnDBg==
X-Google-Smtp-Source: APXvYqzEzxMwTyuepztbi3qnj0NnQB4vzeT8DtYtsUPRejRPP7KXhwsUDoF51TbaFdkdCSvBeqW3aQ==
X-Received: by 2002:a17:902:bd91:: with SMTP id q17mr99231198pls.13.1558641285152;
        Thu, 23 May 2019 12:54:45 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id y16sm256381pfo.133.2019.05.23.12.54.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 23 May 2019 12:54:43 -0700 (PDT)
Date:   Thu, 23 May 2019 12:54:38 -0700
From:   Benson Leung <bleung@google.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-pm@vger.kernel.org, sre@kernel.org,
        Sameer Nanda <snanda@chromium.org>, bleung@chromium.org,
        rjw@rjwysocki.net, gwendal@chromium.org,
        linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        groeck@chromium.org, Adam.Thomson.Opensource@diasemi.com,
        kernel@collabora.com, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v4 1/2] power: supply: add input power and voltage limit
 properties
Message-ID: <20190523195438.GA110498@google.com>
References: <20190507095248.17915-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <20190507095248.17915-1-enric.balletbo@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Enric,

On Tue, May 07, 2019 at 11:52:47AM +0200, Enric Balletbo i Serra wrote:
> For thermal management strategy you might be interested on limit the
> input power for a power supply. We already have current limit but
> basically what we probably want is to limit power. So, introduce the
> input_power_limit property.
>=20
> Although the common use case is limit the input power, in some
> specific cases it is the voltage that is problematic (i.e some regulators
> have different efficiencies at higher voltage resulting in more heat).
> So introduce also the input_voltage_limit property.
>=20
> This happens in one Chromebook and is used on the Pixel C's thermal
> management strategy to effectively limit the input power to 5V 3A when
> the screen is on. When the screen is on, the display, the CPU, and the GPU
> all contribute more heat to the system than while the screen is off, and
> we made a tradeoff to throttle the charger in order to give more of the
> thermal budget to those other components.
>=20
> So there's nothing fundamentally broken about the hardware that would
> cause the Pixel C to malfunction if we were charging at 9V or 12V instead
> of 5V when the screen is on, i.e. if userspace doesn't change this.
>=20
> What would happen is that you wouldn't meet Google's skin temperature
> targets on the system if the charger was allowed to run at 9V or 12V with
> the screen on.
>=20
> For folks hacking on Pixel Cs (which is now outside of Google's official
> support window for Android) and customizing their own kernel and userspace
> this would be acceptable, but we wanted to expose this feature in the
> power supply properties because the feature does exist in the Emedded
> Controller firmware of the Pixel C and all of Google's Chromebooks with
> USB-C made since 2015 in case someone running an up to date kernel wanted
> to limit the charging power for thermal or other reasons.
>=20
> This patch exposes a new property, similar to input current limit, to
> re-configure the maximum voltage from the external supply at runtime
> based on system-level knowledge or user input.
>=20
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Reviewed-by: Guenter Roeck <groeck@chromium.org>
> Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

Reviewed-by: Benson Leung <bleung@chromium.org>

> ---
>=20
> Changes in v4:
> - Add also input_power_limit.
>=20
> Changes in v3:
> - Improve commit log and documentation with Benson comments.
>=20
> Changes in v2:
> - Document the new property in ABI/testing/sysfs-class-power.
> - Add the Reviewed-by Guenter Roeck tag.
>=20
>  Documentation/ABI/testing/sysfs-class-power | 32 +++++++++++++++++++++
>  Documentation/power/power_supply_class.txt  |  4 +++
>  drivers/power/supply/power_supply_sysfs.c   |  2 ++
>  include/linux/power_supply.h                |  2 ++
>  4 files changed, 40 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/=
ABI/testing/sysfs-class-power
> index 5e23e22dce1b..962a27a1daf8 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -331,10 +331,42 @@ Description:
>  		supply. Normally this is configured based on the type of
>  		connection made (e.g. A configured SDP should output a maximum
>  		of 500mA so the input current limit is set to the same value).
> +		Use preferably input_power_limit, and for problems that can be
> +		solved using power limit use input_current_limit.
> =20
>  		Access: Read, Write
>  		Valid values: Represented in microamps
> =20
> +What:		/sys/class/power_supply/<supply_name>/input_voltage_limit
> +Date:		May 2019
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		This entry configures the incoming VBUS voltage limit currently
> +		set in the supply. Normally this is configured based on
> +		system-level knowledge or user input (e.g. This is part of the
> +		Pixel C's thermal management strategy to effectively limit the
> +		input power to 5V when the screen is on to meet Google's skin
> +		temperature targets). Note that this feature should not be
> +		used for safety critical things.
> +		Use preferably input_power_limit, and for problems that can be
> +		solved using power limit use input_voltage_limit.
> +
> +		Access: Read, Write
> +		Valid values: Represented in microvolts
> +
> +What:		/sys/class/power_supply/<supply_name>/input_power_limit
> +Date:		May 2019
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		This entry configures the incoming power limit currently set
> +		in the supply. Normally this is configured based on
> +		system-level knowledge or user input. Use preferably this
> +		feature to limit the incoming power and use current/voltage
> +		limit only for problems that can be solved using power limit.
> +
> +		Access: Read, Write
> +		Valid values: Represented in microwatts
> +
>  What:		/sys/class/power_supply/<supply_name>/online,
>  Date:		May 2007
>  Contact:	linux-pm@vger.kernel.org
> diff --git a/Documentation/power/power_supply_class.txt b/Documentation/p=
ower/power_supply_class.txt
> index 300d37896e51..1e3c705111db 100644
> --- a/Documentation/power/power_supply_class.txt
> +++ b/Documentation/power/power_supply_class.txt
> @@ -137,6 +137,10 @@ power supply object.
> =20
>  INPUT_CURRENT_LIMIT - input current limit programmed by charger. Indicat=
es
>  the current drawn from a charging source.
> +INPUT_VOLTAGE_LIMIT - input voltage limit programmed by charger. Indicat=
es
> +the voltage limit from a charging source.
> +INPUT_POWER_LIMIT - input power limit programmed by charger. Indicates
> +the power limit from a charging source.
> =20
>  CHARGE_CONTROL_LIMIT - current charge control limit setting
>  CHARGE_CONTROL_LIMIT_MAX - maximum charge control limit setting
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index 5358a80d854f..860db617d241 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -275,6 +275,8 @@ static struct device_attribute power_supply_attrs[] =
=3D {
>  	POWER_SUPPLY_ATTR(charge_control_limit),
>  	POWER_SUPPLY_ATTR(charge_control_limit_max),
>  	POWER_SUPPLY_ATTR(input_current_limit),
> +	POWER_SUPPLY_ATTR(input_voltage_limit),
> +	POWER_SUPPLY_ATTR(input_power_limit),
>  	POWER_SUPPLY_ATTR(energy_full_design),
>  	POWER_SUPPLY_ATTR(energy_empty_design),
>  	POWER_SUPPLY_ATTR(energy_full),
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 2f9c201a54d1..ba135a5d8996 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -122,6 +122,8 @@ enum power_supply_property {
>  	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT,
>  	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX,
>  	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> +	POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT,
> +	POWER_SUPPLY_PROP_INPUT_POWER_LIMIT,
>  	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
>  	POWER_SUPPLY_PROP_ENERGY_EMPTY_DESIGN,
>  	POWER_SUPPLY_PROP_ENERGY_FULL,
> --=20
> 2.20.1
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXOb6fgAKCRBzbaomhzOw
wruNAP4zRqtnStUyRbBYdBhaBh/GyqZhsVOldLx65aej/QKwlgD/c1Jt+QIZMNyj
e5t4yql/iUJbui2eMgpTtAy0FERpEgE=
=37gh
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
