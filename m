Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA00251010
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 05:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbgHYDsz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 23:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbgHYDsy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 23:48:54 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4405C061755
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 20:48:52 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id m8so6256146pfh.3
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 20:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=aYCn5QzgD8cBzr9wMS/HNmt2b1qxEaqPTWvWzDbRA+8=;
        b=Fn1R1h9NXvFEDBjED+T+U09XJsCGUH7Qru9WsZ+Dcjw4lo7YD8BSz5I5y42FVIxwkR
         8wvJTZuv+uphBrJhVqBLcvT4K0lUymIVcQ3ZEwHAAfjbVaN/HAH/x/QXk0GUNWs0nUr0
         8SH+lobmWvB3XaJJwxp0yYdqBRMQIL8MeCm3VHXjbpIsTVm4UVVlsxaLfZ5VstjMDg0R
         JEKDRN1E7s3GTvcAh8ANZRjbKZW2q+8ujSADRB++jPThc9wZswv0+wzXhlBVlMfrTMlH
         WZBdrcrGSVvnBD6bO710fnzKcbh3lWEFYHUp06juJUn0pmlmBAoXZ1k1AEmdlsQZ3dwO
         NJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=aYCn5QzgD8cBzr9wMS/HNmt2b1qxEaqPTWvWzDbRA+8=;
        b=Eh0HlRYgTsbljAPoYMzOVpG9QGxIarUYB0sEqJ13j5vG3ud8TNVf/ZJOEOdkLiUdFM
         5gbjXoDCDYKrskTdAfe2EzwwB0iKUUIpY8pfuT76jb0Q47chekMtgNwYBchImPlDv+QE
         f8qaFYxDJHslWXSWZtJ6YS3YFV0/SOKs2734gcp86cy+vVKPaxT7CuKBrHBVq4IXUlG1
         hB5xK/S3aHf1H3Eop9zkpyom0uSpsP4NjUn2BpQFUcWqBL9tf+iTBeoQiQyAUU/tTqKh
         SUBLEMJyb17VRM3Bk2BBO9HDZ2HHr/1fuzYvDmlkEOXdpyfkJMhroY2f02zLnCg3Qxeu
         oL2A==
X-Gm-Message-State: AOAM533GwRsLLiptP34wciTTI9X6xNFtBE+ZAwctih1U6ul8xIeVESQ2
        rDkpFNZ03fy7RFK5+jJI3Bsy
X-Google-Smtp-Source: ABdhPJxPZ3y+C1GEKw/JDVnyXmX1Cpe0y/2M+T6mT6GubLJdX6NbiXts0PgV5/WPV1WZ9E5aKMtNfA==
X-Received: by 2002:a17:902:aa89:: with SMTP id d9mr5032347plr.192.1598327331970;
        Mon, 24 Aug 2020 20:48:51 -0700 (PDT)
Received: from ?IPv6:2409:4072:514:1a63:11c2:1447:3b94:7811? ([2409:4072:514:1a63:11c2:1447:3b94:7811])
        by smtp.gmail.com with ESMTPSA id ce8sm951978pjb.24.2020.08.24.20.48.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 20:48:51 -0700 (PDT)
Date:   Tue, 25 Aug 2020 09:18:43 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <20200822232405.GA2261833@BV030612LT>
References: <cover.1598043782.git.cristian.ciocaltea@gmail.com> <20200821222653.GA2255465@BV030612LT> <20200822131343.GA5954@Mani-XPS-13-9360> <20200822232405.GA2261833@BV030612LT>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/6] Add initial support for ATC260x PMICs
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
CC:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        =?ISO-8859-1?Q?Andreas_F=E4rber?= <afaerber@suse.de>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Message-ID: <0AD08A2D-9058-4CEF-ACE0-7E8DB1015400@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 23 August 2020 4:54:05 AM IST, Cristian Ciocaltea <cristian=2Eciocaltea=
@gmail=2Ecom> wrote:
>Hi Mani,
>
>On Sat, Aug 22, 2020 at 06:43:43PM +0530, Manivannan Sadhasivam wrote:
>> Hi Cristi,
>>=20
>> Thanks for the series! I'll take a look soon but there is a quick
>comment
>> below=2E
>>=20
>> On Sat, Aug 22, 2020 at 01:26:53AM +0300, Cristian Ciocaltea wrote:
>> > I have just realized I had omitted the changelog - sorry:
>> >=20
>> > Changes in v2:
>> > - Reworked MFD core & I2C driver
>> >   * Integrated Lee's feedback
>> >   * Added support for using the regmap within atomic contexts
>> >   * Added support for ATC2603C chip variant
>> >   * Reorganized KConfig entries
>> > - Improved regulator driver
>> >   * Added support for ATC2603C variant
>> >   * Used helper macros for more compact specification of
>regulator_desc items
>> >   * Added more regulator capabilities
>> > - Added power controller driver
>> >   * Provides system poweroff/reboot functionalities
>> >   * Requires support for I2C Atomic transfers in the Owl driver
>(already submitted)
>> > - Added onkey driver: exposes the power button as an input device
>> > - Added yaml binding doc
>> > - Rebased patchset on kernel v5=2E9-rc1
>> >=20
>> > Kind regards,
>> > Cristi
>> >=20
>> > On Sat, Aug 22, 2020 at 01:19:46AM +0300, Cristian Ciocaltea wrote:
>> > > This is re-spin of the patch series submitted some time ago by
>Mani,
>> > > who added initial support (MFD core and regulators) for the
>Actions
>> > > Semi ATC260x PMICs:
>> > >
>https://lore=2Ekernel=2Eorg/lkml/20190617155011=2E15376-1-manivannan=2Esa=
dhasivam@linaro=2Eorg/
>> > >=20
>> > > The ATC260x family of PMICs integrates Audio Codec, Power
>management,
>> > > Clock generation and GPIO controller blocks=2E There are currently
>3
>> > > variants: ATC2603A, ATC2603C and ATC2609A=2E
>> > >=20
>> > > In addition to the ATC2609A regulator functionality provided that
>time,
>> > > this patchset adds support for the ATC2603C variant, together
>with some
>> > > new functionalities for both chips: power controller and onkey
>input=2E
>> > > The ATC2603A variant remains unsupported for the moment=2E
>> > >=20
>> > > This has been tested on RoseapplePi, a SBC based on the Action
>Semi S500
>> > > SoC, which integrates ATC2603C PMIC=2E An initial support for this
>board
>> > > has been already submitted:
>> > >
>https://lore=2Ekernel=2Eorg/lkml/cover=2E1592123160=2Egit=2Ecristian=2Eci=
ocaltea@gmail=2Ecom/
>> > >=20
>> > > Please note that enabling the ATC260x PMICs on the compatible
>Actions
>> > > Semi Owl SoC based boards depends on the following:
>> > >=20
>> > > * Actions Semi SIRQ driver (for PMIC DTS setup):
>> > > =20
>https://lore=2Ekernel=2Eorg/lkml/cover=2E1597852360=2Egit=2Ecristian=2Eci=
ocaltea@gmail=2Ecom/
>> > >=20
>> > > * I2C Atomic transfers in Actions Semi Owl driver (for proper
>operation
>> > >   of the power controller driver):
>> > > =20
>https://lore=2Ekernel=2Eorg/lkml/b086ef6d355d9730c839359e15eb06175283e323=
=2E1596485741=2Egit=2Ecristian=2Eciocaltea@gmail=2Ecom/
>> > >  =20
>> > > Thanks,
>> > > Cristi
>> > >=20
>> > > Cristian Ciocaltea (6):
>> > >   dt-bindings: mfd: Add Actions Semi ATC260x PMIC binding
>> > >   mfd: Add MFD driver for ATC260x PMICs
>> > >   regulator: Add regulator driver for ATC260x PMICs
>>=20
>> You need to preserve my authorship for above two patches=2E Adding the
>signed-off-by
>> is not enough=2E
>
>I'm very sorry for the mistake, I was not aware of the correct
>reposting
>procedure=2E Should I resend the series now or could we handle a first
>round
>of review before?
>

You can wait to get review comments=2E=20

Thanks,=20
Mani=20

>Thanks,
>Cristi
>
>> > >   power: reset: Add poweroff driver for ATC260x PMICs
>> > >   input: atc260x: Add onkey driver for ATC260x PMICs
>> > >   MAINTAINERS: Add entry for ATC260x PMIC
>>=20
>> I think this one too=2E
>>=20
>> Thanks,
>> Mani
>>=20
>> > >=20
>> > >  =2E=2E=2E/bindings/mfd/actions,atc260x=2Eyaml         | 221 ++++++=
++
>> > >  MAINTAINERS                                   |  12 +
>> > >  drivers/input/misc/Kconfig                    |  11 +
>> > >  drivers/input/misc/Makefile                   |   2 +-
>> > >  drivers/input/misc/atc260x-onkey=2Ec            | 304 +++++++++++
>> > >  drivers/mfd/Kconfig                           |  18 +
>> > >  drivers/mfd/Makefile                          |   3 +
>> > >  drivers/mfd/atc260x-core=2Ec                    | 290 ++++++++++
>> > >  drivers/mfd/atc260x-i2c=2Ec                     |  73 +++
>> > >  drivers/power/reset/Kconfig                   |   8 +-
>> > >  drivers/power/reset/Makefile                  |   1 +
>> > >  drivers/power/reset/atc260x-poweroff=2Ec        | 274 ++++++++++
>> > >  drivers/regulator/Kconfig                     |   8 +
>> > >  drivers/regulator/Makefile                    |   1 +
>> > >  drivers/regulator/atc260x-regulator=2Ec         | 511
>++++++++++++++++++
>> > >  include/linux/mfd/atc260x/atc2603c=2Eh          | 281 ++++++++++
>> > >  include/linux/mfd/atc260x/atc2609a=2Eh          | 308 +++++++++++
>> > >  include/linux/mfd/atc260x/core=2Eh              |  86 +++
>> > >  18 files changed, 2410 insertions(+), 2 deletions(-)
>> > >  create mode 100644
>Documentation/devicetree/bindings/mfd/actions,atc260x=2Eyaml
>> > >  create mode 100644 drivers/input/misc/atc260x-onkey=2Ec
>> > >  create mode 100644 drivers/mfd/atc260x-core=2Ec
>> > >  create mode 100644 drivers/mfd/atc260x-i2c=2Ec
>> > >  create mode 100644 drivers/power/reset/atc260x-poweroff=2Ec
>> > >  create mode 100644 drivers/regulator/atc260x-regulator=2Ec
>> > >  create mode 100644 include/linux/mfd/atc260x/atc2603c=2Eh
>> > >  create mode 100644 include/linux/mfd/atc260x/atc2609a=2Eh
>> > >  create mode 100644 include/linux/mfd/atc260x/core=2Eh
>> > >=20
>> > > --=20
>> > > 2=2E28=2E0
>> > >=20

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
