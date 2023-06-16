Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98637331AE
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jun 2023 14:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344555AbjFPM4K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Jun 2023 08:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjFPM4J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Jun 2023 08:56:09 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC38B30F7;
        Fri, 16 Jun 2023 05:56:06 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686920165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3ebk/q/MCadxjGPV72mBiKGQBmlcWEDONAz8ZGZsXKg=;
        b=PjJXNPeNZjNWUK6U9a3y8FEn1YJwMeE6t4vTJNnS7lM9gemfJfBZGEm/T96U5Kl9qw6mCZ
        X92mMHf+wuqzMKK1pO++DLdp9O4+9pVT5EwoDZqSdAsrE04TjK8NBTDueqb6t/Tww2csTF
        QjBhxcY+u4yv98X8gKPbyQDXrqgRSALcghS9eYOzh7G+JmXdl69K3cD4VV9BCboVOVD7Nf
        q46xOgn5Gs66h3NVPHgx44H8+AAlw7EN/uvTn1y/CToRNKUB6ZpHlhOJkHwUVmEDdLzw2M
        47QgzWfrh88eKRkO1G0KC8C44dY673JNg0Ykn854JQWHWGr95aglVn9Rkl2FWg==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1AC8DE0010;
        Fri, 16 Jun 2023 12:56:01 +0000 (UTC)
Date:   Fri, 16 Jun 2023 14:56:00 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     Amit Kucheria <amitk@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Josua Mayer <josua@solid-run.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/3] thermal: armada: add support for AP807 thermal data
Message-ID: <20230616145600.78c30f91@xps-13>
In-Reply-To: <E1qA7yU-00Ea4u-Je@rmk-PC.armlinux.org.uk>
References: <ZIxMYXDCTB7IvsDk@shell.armlinux.org.uk>
        <E1qA7yU-00Ea4u-Je@rmk-PC.armlinux.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Russell,

rmk+kernel@armlinux.org.uk wrote on Fri, 16 Jun 2023 12:50:42 +0100:

> From: Alex Leibovich <alexl@marvell.com>
>=20
> Add support for the AP807 die thermal data. This is the same as AP806,
> except for the coefficients.
>=20
> ap807 values taken from TSENSE_ADC_16FFC spec, which says:
> 	T(in Celsius) =3D T(code)*TSENE_GAIN+TSENE_OFFSET
> where in default:
> 	TSENE_OFFSET =3D 128.9
> 	TSENE_GAIN =3D 0.394
>=20
> Signed-off-by: Alex Leibovich <alexl@marvell.com>
> Tested-by: sa_ip-sw-jenkins <sa_ip-sw-jenkins@marvell.com>
> Reviewed-by: Stefan Chulski <stefanc@marvell.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

> ---
>  drivers/thermal/armada_thermal.c | 32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
>=20


Thanks,
Miqu=C3=A8l
