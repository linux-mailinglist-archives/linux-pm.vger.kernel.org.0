Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6D4627DC3
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2019 15:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbfEWNMb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 May 2019 09:12:31 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40108 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729430AbfEWNMb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 May 2019 09:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QvlfoLHm0G7/InzihE6PxMP0/Z/oolwPHati4bZmwQk=; b=wvGRj18ykIjgLomRO2wv+zz2c
        6FN4MniOthn8MoyoxeRJ587gb7wWgPnLnueeF74OHNrJ/hje8VjT3sxKa6EcouM0RxxZJzqEvmabM
        AchRocYS+FjBtFfeXPh/wbVWtTD85UB+eYfe1ecuWyHP9DUwL8Ogby4rV6hkzuPnj3kJs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hTnVy-0000AJ-Rd; Thu, 23 May 2019 13:12:10 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 386DD1126D24; Thu, 23 May 2019 14:12:07 +0100 (BST)
Date:   Thu, 23 May 2019 14:12:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Eduardo Valentin <edubezval@gmail.com>,
        Elaine Zhang <zhangqing@rock-chips.com>
Cc:     tomeu.vizoso@collabora.com, guillaume.tucker@collabora.com,
        mgalka@collabora.com, matthew.hart@linaro.org,
        khilman@baylibre.com, enric.balletbo@collabora.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: mainline/master boot bisection: v5.2-rc1-165-g54dee406374c on
 rk3288-veyron-jaq
Message-ID: <20190523131207.GC17245@sirena.org.uk>
References: <5ce6040d.1c69fb81.60b3b.29fb@mx.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JgQwtEuHJzHdouWu"
Content-Disposition: inline
In-Reply-To: <5ce6040d.1c69fb81.60b3b.29fb@mx.google.com>
X-Cookie: I brake for chezlogs!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--JgQwtEuHJzHdouWu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 22, 2019 at 07:23:09PM -0700, kernelci.org bot wrote:

>   Details:    https://kernelci.org/boot/id/5ce5984c59b514e6a47a364c
>   Plain log:  https://storage.kernelci.org//mainline/master/v5.2-rc1-165-g54dee406374c/arm/multi_v7_defconfig+CONFIG_EFI=y+CONFIG_ARM_LPAE=y/gcc-8/lab-collabora/boot-rk3288-veyron-jaq.txt
>   HTML log:   https://storage.kernelci.org//mainline/master/v5.2-rc1-165-g54dee406374c/arm/multi_v7_defconfig+CONFIG_EFI=y+CONFIG_ARM_LPAE=y/gcc-8/lab-collabora/boot-rk3288-veyron-jaq.html
>   Result:     28694e009e51 thermal: rockchip: fix up the tsadc pinctrl setting error

It looks like this issue has persisted for a while without any kind of
fix happening - given that the bisection has identified this commit as
causing the regression and confirmed that reverting it fixes shouldn't
we just revert?  My guess would be that there's some error with the
pinctrl settings in the DT for the board.

--JgQwtEuHJzHdouWu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzmnCYACgkQJNaLcl1U
h9DdRQf+JZtHoJEVkzFX602V6UOrnMDu66zIL9WEt8FQA28mY1VFaEe5jdz2Qhow
EoBDngfyg8tk3oipmTqKRQ6xmCwGyTzYJBJn/OXjCqJHV09ZtJFmlo70EVppBO/c
rClNwCjcwaQpC1fekhcBbZdx0AmeVNkfSD/CKtEa0ZppBeqxch+u9CEL4QzR9LPC
TSTRNXixW9s7SdI/RVs9EO0Gskr0w+M1QBPjhyegJHlny7FI9QYPU9RMUrtuIqrH
zcVRf7D/rzmnS6jHOZCvEQ49PXwcBHv/KnNp6t7ttNz5gr0EIKhaFEICSnTSjMh+
eFF4fQBLHILKCtKUTkNWZKbi4Qcl6Q==
=m0Lf
-----END PGP SIGNATURE-----

--JgQwtEuHJzHdouWu--
