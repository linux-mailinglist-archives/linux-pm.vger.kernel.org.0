Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9842E79FC49
	for <lists+linux-pm@lfdr.de>; Thu, 14 Sep 2023 08:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbjINGrV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Sep 2023 02:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjINGrU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Sep 2023 02:47:20 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220AACCD
        for <linux-pm@vger.kernel.org>; Wed, 13 Sep 2023 23:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694674036; x=1726210036;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MiNTIYzOJN1wrtxFN5lQC/gqZO2j2q+e6nLCMiBsuN0=;
  b=LXGy6+9arqaDbWxWSLePJ4PzgJIwKo2NmTPLm3jGZr7YxzZs68CsuKEW
   AeTKeA36ZyGvw5h6wMcT1UCsusq2Dxx2Ga+6tkU+b1UYn7cjyld+qs7OU
   NXyoAW+NWJo5QJUWBavCYWPwlLwo0I/Z4dosWIBI17aMEQTFmBOFnnnxn
   43380Nzs31oi25T8N+5Xxz9wCxQW3OCV79Ehg3Ku0iDj5Jx2AKiD9cwJE
   zwIRnPs5wJtSuttrzdidR8FDyw0EPyND2YKir2lOv5GXYDEzNyptgHacC
   aJJAj0ZcBIMJgrCPZfBiL0MUm5tYLvG8FLIVs0jyvHl86vzLbnRjGwyW4
   w==;
X-CSE-ConnectionGUID: vfMOlH7yTwexRPP1GuH5GQ==
X-CSE-MsgGUID: xoTsubcES+2nTFm4PMX80A==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="asc'?scan'208";a="4463721"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Sep 2023 23:47:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 13 Sep 2023 23:46:45 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 13 Sep 2023 23:46:43 -0700
Date:   Thu, 14 Sep 2023 07:46:27 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Conor Dooley <conor@kernel.org>, <arnd@arndb.de>,
        <changhuang.liang@starfivetech.com>, <jiajie.ho@starfivetech.com>,
        <linux-pm@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <robh@kernel.org>, <walker.chen@starfivetech.com>
Subject: Re: [GIT PULL 0/5] Missed starfive pmdomain changes for v6.6, now
 for v6.7
Message-ID: <20230914-appliance-vastness-989ded32323a@wendy>
References: <20230913-bloomers-scorebook-fb45e0a2aa19@spud>
 <CAPDyKFoENVp7+VjKkPpJWDecowxYD=QM6TSa6HjyzOZ=z7r81w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JiM0GHmFjKEmdcha"
Content-Disposition: inline
In-Reply-To: <CAPDyKFoENVp7+VjKkPpJWDecowxYD=QM6TSa6HjyzOZ=z7r81w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--JiM0GHmFjKEmdcha
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yo,

I tried to reply a few hours ago from k9, but it appears to not have
landed on lore, so here goes attempt #2. Apologies if you got a mail
twice.

On Thu, Sep 14, 2023 at 12:30:20AM +0200, Ulf Hansson wrote:
> On Wed, 13 Sept 2023 at 15:56, Conor Dooley <conor@kernel.org> wrote:
> >
> > From: Conor Dooley <conor.dooley@microchip.com>
> >
> > Hey Uffe,
> >
> > Here's those missed changes in patch form. I figured it might be a bit
> > easier this way given the name of the subsystem is in flux, doubly so if
> > you'd like to put the header change of Rob's on fixes.
>=20
> Not sure we really need to queue up patch 1 for fixes - or is it
> fixing a real problem for us?

It was just in case you felt that taking that header cleanup as a fix
was worthwhile. I think I saw some people doing that last cycle & I
think Rob was trying to clean that up for v6.6 which I obviously haven't
helped him with.

> The series applied for next, thanks!

Great, thanks.

--JiM0GHmFjKEmdcha
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQKsQwAKCRB4tDGHoIJi
0r7TAQD81jDl7jfypoYEMa4xfg+xgWZ18aAlvf6l47iUh9yGkwD+IhMwZjeNG32K
QFrjpiM4Bsm9g1HAcfAtmsBVqtwaXwQ=
=YHCd
-----END PGP SIGNATURE-----

--JiM0GHmFjKEmdcha--
