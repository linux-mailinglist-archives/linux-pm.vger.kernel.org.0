Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20409DF3C4
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2019 19:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfJUREV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Oct 2019 13:04:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfJUREV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 21 Oct 2019 13:04:21 -0400
Received: from earth.universe (cust-west-pareq2-46-193-15-226.wb.wifirst.net [46.193.15.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05B552086D;
        Mon, 21 Oct 2019 17:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571677460;
        bh=hnMFoVLDueryhj//1FWCAlGZBq3X8HrGcADBOK6nEmw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zmZo2ukhBPXROHUEjWugx1CunYxMORuICc8s8lBWc0tzyhx/jm/lyUgaPXB0591ta
         lOnqU63FoDfrRArNfYF/Z4OmSHoA/tQwGyhq5q9LPrJSb/LSL1MbFUpiZza4907O1/
         ti5iIUq3zlKb5De7+hDkpMmiQ2RV9qNOVJwoVyG8=
Received: by earth.universe (Postfix, from userid 1000)
        id 005A93C0CA0; Mon, 21 Oct 2019 19:04:17 +0200 (CEST)
Date:   Mon, 21 Oct 2019 19:04:17 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: cpcap-charger: Make
 cpcap_charger_voltage_to_regval static
Message-ID: <20191021170417.ycoavur3bdje67ya@earth.universe>
References: <1571672407-58950-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ec4ro7gh4ewxksot"
Content-Disposition: inline
In-Reply-To: <1571672407-58950-1-git-send-email-zhongjiang@huawei.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ec4ro7gh4ewxksot
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 21, 2019 at 11:40:07PM +0800, zhong jiang wrote:
> The GCC complains the following case when compiling kernel.
>=20
> drivers/power/supply/cpcap-charger.c:563:5: warning: symbol 'cpcap_charge=
r_voltage_to_regval' was not declared. Should it be static?
>=20
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---

Thanks, but Intel's kbuild test robot was faster than you:

https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/=
commit/?h=3Dfor-next

-- Sebastian

--ec4ro7gh4ewxksot
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl2t5Q4ACgkQ2O7X88g7
+prVVg/+NBqfVKL1EG1o+wY4BZzlq8xUKpHg2TV3jb9rbk3sZjKWm/Rqmu45CrCE
/m0LPaOxIGp0vZcZcmTxEshpSOFRsd46jTT4+K/9ZKuKufz5tBqhFhm5O2VgBiB7
o8+bYkP0aB7ElieikSNCSUMApUU2b10B6Xa0sEHvOofuDs4QtucVNUh3BN0urMNM
z4IqPpOAGLXZxTUJxf7ghoKFm+AH0CI5g5tMNlp/aZhdqM/1dfQJQzfLn6W/H239
gFG+qbOTrUDMBFN7SQTR2v1B7qXJRgpEcqf795TI8EACZOeA3mM/HOC9MOj4m5sx
l4vm28UNKnrYZ84bTGI06iUecilCCX46KZEQCpRzIlpDrVK9QABQEPWV/FMyhBal
LjmK009WaNq0mAeAL+kHRWUEuf6bxI79T++r8CHDkPYLPlDK9UQhI2KAGhzzO8LP
ZtwPiIe5oSrFdlOWZIy4pgyPfhB9mic6b0FN4D7kAYy2xFO8PRSh6kkFLqt5XnML
XpBWejsFDUTs2wGTVPSo1XD9LNqoTBnOX28kZC+VoDN1SFulNCG8sejp3jltqdu7
BWR94Fmcckw6aFVj7P+VWRat0ArbrI1n1eZS0wdiukcNwgBn0AmyJRDP1ZyY5cvL
VwClqz3mxgy4Db6LC6BJEIRRHc+TsmiClhQY/V0/8vS4pIQ+YBQ=
=Yr1v
-----END PGP SIGNATURE-----

--ec4ro7gh4ewxksot--
