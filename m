Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 453F9ADE90
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2019 20:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405668AbfIISNd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Sep 2019 14:13:33 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.81]:32946 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405643AbfIISNc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Sep 2019 14:13:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1568052807;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=tV029y11XWsg52niiYVuB13LG4WzStnlH9YsdMIy1yQ=;
        b=X3lqSL2rJsYo520/1Y/VUa5nIZVZcMIz2hS/jP62Bvc+gOk366S6tyg6ngIUOuUh/B
        fr3XVHXW0AlJTEVGwMpwsDm4V+2V9nbLJbhCL0QWXAy6F0V7N6pF7aWNolqHHv7QtEVT
        nZpW0iA2xavwMBoijqXlFAQHPUonMC/fsYgvFS9O5YwdjlzxkgVeFGTEH2b2P8CLUYsj
        Q8Rw7lT/scuy/9OU1UrfO25QRgexfQaoUxx/aWjpL6mCmJ0hx8y2fJtRhNx8wZspXhpF
        0Div8RsZMMiJzWsm1FbxCmOe7zk9n3ZN9z3VaHo+Y3l/K6Umzc0Xgh6+ZpAM1tsL50QB
        Js0A==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw9iZeHmMnw4vkig=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 44.27.0 DYNA|AUTH)
        with ESMTPSA id u036f9v89ID3y5R
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 9 Sep 2019 20:13:03 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 1/2] cpufreq: ti-cpufreq: Add support for AM3517
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20190909154502.19804-1-aford173@gmail.com>
Date:   Mon, 9 Sep 2019 20:13:03 +0200
Cc:     linux-omap@vger.kernel.org, neolynx@gmail.com,
        letux-kernel@openphoenux.org, andreas@kemnade.info,
        tony@atomide.com, adam.ford@logicpd.com,
        =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6081134F-AACD-412C-B36A-BF9463C9712B@goldelico.com>
References: <20190909154502.19804-1-aford173@gmail.com>
To:     Adam Ford <aford173@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Adam,

> Am 09.09.2019 um 17:45 schrieb Adam Ford <aford173@gmail.com>:
>=20
> The AM3517 only lists 600MHz @ 1.2V, but the revister values for

a small typo...

s/revister/register/

> 0x4830A204 =3D 1b86 802f, it seems like am3517 might be a derivative
> of the omap36 which has OPPs would be OPP50 (300 MHz) and OPP100
> (600 MHz).
>=20
> This patch simply enable adds the am3517 to the compatible table
> using the omap3630 structure instead of the 3430.
>=20
> Signed-off-by: Adam Ford <aford173@gmail.com>
>=20
> diff --git a/drivers/cpufreq/ti-cpufreq.c =
b/drivers/cpufreq/ti-cpufreq.c
> index f2f58d689320..6b69fb1d6bdf 100644
> --- a/drivers/cpufreq/ti-cpufreq.c
> +++ b/drivers/cpufreq/ti-cpufreq.c
> @@ -270,6 +270,7 @@ static int ti_cpufreq_setup_syscon_register(struct =
ti_cpufreq_data *opp_data)
>=20
> static const struct of_device_id ti_cpufreq_of_match[] =3D {
> 	{ .compatible =3D "ti,am33xx", .data =3D &am3x_soc_data, },
> +	{ .compatible =3D "ti,am3517", .data =3D &omap36xx_soc_data, },
> 	{ .compatible =3D "ti,am43", .data =3D &am4x_soc_data, },
> 	{ .compatible =3D "ti,dra7", .data =3D &dra7_soc_data },
> 	{ .compatible =3D "ti,omap34xx", .data =3D &omap34xx_soc_data, =
},
> --=20
> 2.17.1
>=20

Looks good to me.

Should I include your two patches to my patch set (and resend)?
Or should we keep them separated?

BR and thanks,
Nikolaus

