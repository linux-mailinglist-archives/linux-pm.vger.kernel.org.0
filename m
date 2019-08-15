Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D57F68EFD9
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2019 17:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbfHOP5v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Aug 2019 11:57:51 -0400
Received: from mail-40132.protonmail.ch ([185.70.40.132]:44964 "EHLO
        mail-40132.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729251AbfHOP5v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Aug 2019 11:57:51 -0400
Date:   Thu, 15 Aug 2019 15:57:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=philipmolloy.com;
        s=protonmail; t=1565884669;
        bh=T/m0RXoCDnU9xnxRYtBEztvyTWOYL55kInYHUXle+6Y=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=N6mEzlYBPGrj81Z1Df+2nUVFRzcVF7PKNGuJyXdrezIWCOK5GaHWJp+LycMr/wAVQ
         HIeFCpdALaOL0769UeBjs/+rx1a4l71Mrfd1SCGcEvyUXm/SAqpSHRFg7c9/6vKd4p
         lkKk7aYsiT7NOz+h+/zmAyb1RWkTYFKIqR3kD7MY=
To:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
From:   Philip Molloy <philip@philipmolloy.com>
Cc:     Kevin Hilman <khilman@baylibre.com>
Reply-To: Philip Molloy <philip@philipmolloy.com>
Subject: Power domain configuration for a i2c module
Message-ID: <IhUuEbYWNmzYrxy4xrqraNXsMwsBC-QMPC9NIy4JyxfW2J8ViOwTNj4zy9K_pNbZdhJixkAFJSPOc9oJ9IleeYBsEIkPGK_cU11OhzDfJ3M=@philipmolloy.com>
In-Reply-To: <LBvyayNVX8_SOsSXpNSqiBACOGjM2Bu-Fz-D_gW850M9ZJQVEk6WVxzipUn9O4n15435v4yHSIVYp0HgKUcSkTt_hTIEA3XZ0FZLSyEKipY=@philipmolloy.com>
References: <LBvyayNVX8_SOsSXpNSqiBACOGjM2Bu-Fz-D_gW850M9ZJQVEk6WVxzipUn9O4n15435v4yHSIVYp0HgKUcSkTt_hTIEA3XZ0FZLSyEKipY=@philipmolloy.com>
Feedback-ID: GJt-tMfvxqs0QQBY3TE43pQhGJvmgUyYcaVNLwpOk7zQA3Z8eEn7lfwmGEZNv6-1MJvpWrQYi2j-a_XpfopQjA==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.protonmail.ch
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

I've setup a power domain, but I'm having trouble understanding how the dom=
ain's power management callbacks are called when a i2c driver is probed.

The domain is intended to cover two external modules. The power to both mod=
ules is controlled by a single GPIO. I intend to add several drivers to the=
 domain including drivers for several i2c devices and a MMIO driver to acce=
ss data streamed from the modules. I've started with one provider and two c=
onsumers.

The provider calls pm_genpd_init() and of_genpd_add_provider_simple(). It a=
lso implements power_on() and power_of().

provider@0 {
    ...
    power-gpio =3D <&gpio XX GPIO_ACTIVE_HIGH>;
    ready-gpio =3D <&gpio XX GPIO_ACTIVE_HIGH>;
    #power-domain-cells =3D <0>;
};

The consumers are two physical I2C switches:

i2c-mux-gpio {
    compatible =3D "i2c-mux-gpio";
    ...

    module@1 {
        ...

        tca9543@70 {
            compatible =3D "nxp,pca943";
            ...
            power-domains =3D <&provider 0>;
            power-domain-names =3D "provider";
        };
    };

    module@2 {
        // Same as above
    };
};

When I modprobe i2c-mux-mpca954x it is successfully added to the domain, bu=
t probe fails when calling i2c_smbus_write_byte() to verify the mux is pres=
ent. That is because the modules are not powered on, because the power doma=
in callbacks were not called.

I feel like there are a number of ways this could work. My assumption would=
 be that the i2c driver subsystem would make sure the device is powered on =
before probe is called. i2c_device_probe() does call dev_pm_domain_attach()=
 before calling driver->probe(), but I don't see where it would power on th=
e device. i2c-mux-pca954x implements a resume callback so I assume it doesn=
't require any changes.

Any clarity would be greatly appreciated.

Best,
Philip
