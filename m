Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16AE0453823
	for <lists+linux-pm@lfdr.de>; Tue, 16 Nov 2021 17:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbhKPRAN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Nov 2021 12:00:13 -0500
Received: from mout.gmx.net ([212.227.15.19]:37155 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230103AbhKPRAN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 16 Nov 2021 12:00:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637081805;
        bh=M+95GG9pOYr+sggZ23h8a1YVbdAtpertOAKkIz3RoPU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=BPK1gM/+x29dXwIb4VTJ0wuqARu0SlJvHSd1htQ9OyB8V2hvsp+3LnI8zIebc6DWZ
         Q59+RrPKfrKrCK4ajxRyWN1ZTdeW1hRHOQLUZeXMbEmvBgLlyEEhH+XRXoq8Ct9S+J
         1+yscgOvUiZtkCkWgsDHgXNetdwEzqYU46+pF/Qg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.135.7.100] ([87.123.191.145]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N95iH-1mZslu1CeV-0163ef; Tue, 16
 Nov 2021 17:56:45 +0100
Subject: Re: [PATCH 0/4] power: supply: add charge_behaviour property
 (force-discharge, inhibit-charge)
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        Mark Gross <markgross@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc:     linux-kernel@vger.kernel.org, bberg@redhat.com, hadess@hadess.net,
        markpearson@lenovo.com, nicolopiazzalunga@gmail.com,
        njoshi1@lenovo.com, smclt30p@gmail.com
References: <20211113104225.141333-1-linux@weissschuh.net>
From:   Thomas Koch <linrunner@gmx.net>
Message-ID: <9cebba85-f399-a7aa-91f7-237852338dc5@gmx.net>
Date:   Tue, 16 Nov 2021 17:56:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211113104225.141333-1-linux@weissschuh.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:x0ju+oRwoPkuyA8uflSr94bEewFh4Xtgfzb+77evOag2GA29Kam
 kQYZF+ptmlGuEkmDsU5plA8urpKQH+2YvpfkSQaaCfNCJ0+lfwzJ1slypCodsFEbwtORK2v
 EUFBmsq6OfNVpRp0YudFpTMdE7Rt1/1jUqEzouFZrokKFr2UPDWN6AzTLVVTdICVcIcZRme
 ts3BcJnQiauwNaXlmROsw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:btgV3Qyhq+4=:5T9pn9zDZK6OHVY98O34Xi
 c5VEwyrxQvqhdymO51ZIqR9XwTjWBS09/8q35zoQQY/sYPiFRYXM8DHHocsoiGOGyQU+y2Wqj
 2k6mygFxFydYyJOK2GbNg3uL1CqW06FrurmISMcM2is+Qbyes4cMcPgXVoIidZ2ktf+LKlOm2
 sqd722LcJFOAxueHVtsBzKqggbEYg6bVKdn79Jh0rx01qAi8v01aQ+Ln1+D4JQacyUEcb3gaM
 ax50mwB7AkuITzhi4kso0ywthcpsFNvbZCTq1FOelGqV4KikNYRMfRws5r0nJsFj5fhuqamo3
 LdfnhnzK9IJEgdcDtApzT+JDHB5n3VO0W0qqYNRf8Ym6KsdqEBNF7fJEPpFbJTo2dIV9DwCyc
 dts/BXzWyKspbN6v6vuPYOkdi69LVwVfvrlZqj2ZMZ9vQmn8qdP7HEPFItwEut9pZ6C/f90rm
 gDu6xOyBuAyYmibZ6f5qz+0LqU0LsA1yRRdZ8E0TiGP8CUBNQZECwViC5uUGE5Q09wx9WRJse
 m9mqeobCW8rVuW9IH34zlJN9vkLd9DcWEks2QSGAwrjABhBiS3TMUmtCjf6rHhJ6hzjGJZU+a
 V0pAULg6/UvBSQRaD0SQXUQiJ7oI0wRdD/WdrOrEE6OnmQuxBip0Zxpb3bOC3ibdmETJueInS
 Di50UmFXDbR/mzTiufH9wt+a4DYFBLTuJnMbpRgCabAR1E+6FcycmtzSUZGl688obbiLShzGk
 Iy8R93Y519AQBU4L1AQHVFPCjz8yq1Agb84IhYzmjKljXCqIAjXIMXIhj6/+zay7ug6Fe8BzW
 nHBOSotN4UNj/HvLwMHoPBQEysIVZgKb/MF5mnaIB+Ui1WImbgiFj/FMQO2QFJNRQRkAhauk9
 xHWwvAV9LDnOXWZKa6R+0TqrOaoNI7kOF9kU+mQjwt6JiiONADi/UninmskYlIMm6b3eyOD5/
 4LlJemCvu3USdi7HffKiqe1o5QHwqlNpf3MSLoFPd5zqnPH7OIdWnRWlFqMb0/FJ4IISIWfnY
 rrP1URkUBe+Ty+kcw6jJeq0ZiXh3SMppDQzf8hBdSkJaHM/POjKOBlsKZEGvrJ4cNziqXTa2e
 wVKlmYh112NEz4=
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Thomas,

thank you very much for working on this. It is high time that we leave
external kernel modules for ThinkPads behind us.

On 13.11.21 11:42, Thomas Wei=C3=9Fschuh wrote:
> Hi,
>
> this series adds support for the charge_behaviour property to the power
> subsystem and thinkpad_acpi driver.
>
> As thinkpad_acpi has to use the 'struct power_supply' created by the gen=
eric
> ACPI driver it has to rely on custom sysfs attributes instead of proper
> power_supply properties to implement this property.
>
> Patch 1: Adds the power_supply documentation and basic public API
> Patch 2: Adds helpers to power_supply core to help drivers implement the
>    charge_behaviour attribute
> Patch 3: Adds support for force-discharge to thinkpad_acpi.
> Patch 4: Adds support for inhibit-discharge to thinkpad_acpi.
>
> Patch 3 and 4 are largely taken from other patches and adapted to the ne=
w API.
> (Links are in the patch trailer)
>
> Ognjen Galic, Nicolo' Piazzalunga, Thomas Koch:
>
> Your S-o-b is on the original inhibit_charge and force_discharge patches=
.
> I would like to add you as Co-developed-by but to do that it will also r=
equire
> your S-o-b. Could you give your sign-offs for the new patches, so you ca=
n be
> properly attributed?
S-o-b/Co-developed-by/Tested-by is fine with me.

I tested your patches.

Hardware:

- ThinkPad X220, BAT0
- ThinkPad T450s, BAT0+BAT1
- ThinkPad X1C6, BAT0

Test Results:

1. force-discharge

Everythings works as expected
- Writing including disengaging w/ "auto" : OK
- Reading: OK

- Battery discharging: OK
- Disengaging with "auto": OK

2. inhibit-charge

Works as expected:
- Writing: OK

- Disengaging with "auto": OK


Discrepancies:
- Battery charge inhibited: BAT0 OK, BAT1 no effect e.g. continues chargin=
g
- Reading: always returns "auto"

Note: the reading discrepancy may be related to Hans' remarks [1].

[1]
https://lore.kernel.org/all/09a66da1-1a8b-a668-3179-81670303ea37@redhat.co=
m/

>
> Sebastian Reichel:
>
> Currently the series does not actually support the property as a proper
> powersupply property handled fully by power_supply_sysfs.c because there=
 would
> be no user for this property.
>
> Previous discussions about the API:
>
> https://lore.kernel.org/platform-driver-x86/20211108192852.357473-1-linu=
x@weissschuh.net/
> https://lore.kernel.org/platform-driver-x86/21569a89-8303-8573-05fb-c2fe=
c29983d1@gmail.com/
>
> Thomas Wei=C3=9Fschuh (4):
>    power: supply: add charge_behaviour attributes
>    power: supply: add helpers for charge_behaviour sysfs
>    platform/x86: thinkpad_acpi: support force-discharge
>    platform/x86: thinkpad_acpi: support inhibit-charge
>
>   Documentation/ABI/testing/sysfs-class-power |  14 ++
>   drivers/platform/x86/thinkpad_acpi.c        | 154 +++++++++++++++++++-
>   drivers/power/supply/power_supply_sysfs.c   |  51 +++++++
>   include/linux/power_supply.h                |  16 ++
>   4 files changed, 231 insertions(+), 4 deletions(-)
>
>
> base-commit: 66f4beaa6c1d28161f534471484b2daa2de1dce0
>
=2D-
Freundliche Gr=C3=BC=C3=9Fe / Kind regards,
Thomas Koch

Mail : linrunner@gmx.net
Web  : https://linrunner.de/tlp
