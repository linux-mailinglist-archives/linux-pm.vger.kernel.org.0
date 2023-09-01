Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E47878F89C
	for <lists+linux-pm@lfdr.de>; Fri,  1 Sep 2023 08:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344694AbjIAGdY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Sep 2023 02:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjIAGdY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Sep 2023 02:33:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A05F10CE;
        Thu, 31 Aug 2023 23:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1693550001; x=1725086001;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m64vTGuTn+LyymqjWnqc46/AIGoEDr1fAhPkx94h6g8=;
  b=vwpNvkD2s5+clXUIuQdppmiVruLu/Pe0E5xNvESYjSo9YZarpPS1DtJp
   o9W1AthztG3FvK5+hdAX5czVpHNTdjD73xsWD1XuUDK8l9AWHHdj9msDM
   HztEh8Bk9TEw/gc1NpJTQOI+VN+rYMneIOxFgsZdhca3+HGv9EiTDIew5
   PX+NH9aPfCMBvNYJtTwXgXw0yFbCS7elJk6CdGaSKklI+ndH/USyXlL52
   byHTP+gJ4OrwM7OgGWcK3T0vvp54rJAPnKO+IIogeOXDYurGY6BhYNqu8
   68eDfc66Fy8zVNpXIHHULx6MnmP1KBu64ZYlPDJE58FJvpps2axfCyiXL
   g==;
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="asc'?scan'208";a="232862143"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Aug 2023 23:33:21 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 31 Aug 2023 23:32:47 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 31 Aug 2023 23:32:44 -0700
Date:   Fri, 1 Sep 2023 07:32:02 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Binbin Zhou <zhoubb.aaron@gmail.com>
CC:     Conor Dooley <conor@kernel.org>,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        <loongson-kernel@lists.loongnix.cn>, <soc@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Xuerui Wang <kernel@xen0n.name>, <loongarch@lists.linux.dev>
Subject: Re: [PATCH v2 3/5] soc: loongson: loongson_pm2: Drop useless
 of_device_id compatible
Message-ID: <20230901-doubling-multiple-8b72b062e622@wendy>
References: <cover.1693474728.git.zhoubinbin@loongson.cn>
 <bf09b11ec6a0102f85dc2b3289d003271304e24d.1693474728.git.zhoubinbin@loongson.cn>
 <20230831-ambition-refusing-08e63b345573@spud>
 <CAMpQs4JbUx9N4MmfM6vRsdQBHyUcU9UHGX23UewL5Matt6iXnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HoQ3/6k+9svD/8I7"
Content-Disposition: inline
In-Reply-To: <CAMpQs4JbUx9N4MmfM6vRsdQBHyUcU9UHGX23UewL5Matt6iXnQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--HoQ3/6k+9svD/8I7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 01, 2023 at 11:05:12AM +0800, Binbin Zhou wrote:
> Hi Conor:
>=20
> Thanks for your reply.
>=20
> On Thu, Aug 31, 2023 at 11:15=E2=80=AFPM Conor Dooley <conor@kernel.org> =
wrote:
> >
> > On Thu, Aug 31, 2023 at 07:43:13PM +0800, Binbin Zhou wrote:
> > > Now, "loongson,ls2k0500-pmc" is used as fallback compatible, so the
> > > ls2k1000 compatible in the driver can be dropped directly.
> > >
> > > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > > ---
> > >  drivers/soc/loongson/loongson2_pm.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > > diff --git a/drivers/soc/loongson/loongson2_pm.c b/drivers/soc/loongs=
on/loongson2_pm.c
> > > index 796add6e8b63..5ffb77afd9eb 100644
> > > --- a/drivers/soc/loongson/loongson2_pm.c
> > > +++ b/drivers/soc/loongson/loongson2_pm.c
> > > @@ -197,7 +197,6 @@ static int loongson2_pm_probe(struct platform_dev=
ice *pdev)
> > >
> > >  static const struct of_device_id loongson2_pm_match[] =3D {
> > >       { .compatible =3D "loongson,ls2k0500-pmc", },
> > > -     { .compatible =3D "loongson,ls2k1000-pmc", },
> >
> > What about older devicetrees that do not have the fallback? Aren't you
> > going to remove support for those?
>=20
> This driver was just merged in during the v6.6 window, and no release
> will use it until now.

Ahh, thanks for the info. Your commits 1-3 should then all have Fixes:
tags pointing to the commits tat introduced the problems, if you intend
getting these applied as fixes before v6.6 gets released.

Thanks,
Conor.

> commit 67694c076bd7 soc: loongson2_pm: add power management support
> commit 6054a676e969 soc: dt-bindings: add loongson-2 pm
>=20
> Of course, it was our mistake not to make better use of fallback
> compatible when submitting the driver, and we hope to fix this mistake
> soon.
> Also, this driver will only be used by the LoongArch architecture, no
> need to worry about other architectures.
>=20
> Thanks.
> Binbin
> >
> > >       {},
> > >  };
> > >
> > > --
> > > 2.39.3
> > >

--HoQ3/6k+9svD/8I7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZPGFYgAKCRB4tDGHoIJi
0vSUAQDcrB5/73rfmCNAiT2jQA1ruGVppzf3RjC+q0NLyXn7+AD9FlXDDVIXG0U4
83Jc8qNKJVsTNg62hZ8YWLQVEyARvA8=
=1aNe
-----END PGP SIGNATURE-----

--HoQ3/6k+9svD/8I7--
