Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98FD4F489F
	for <lists+linux-pm@lfdr.de>; Wed,  6 Apr 2022 02:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbiDEVnk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Apr 2022 17:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457459AbiDEQDP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Apr 2022 12:03:15 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D455D1A0;
        Tue,  5 Apr 2022 08:46:55 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:35:2589:2a93:190d:b787])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 20691608;
        Tue,  5 Apr 2022 15:46:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 20691608
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1649173615; bh=kHfYrSzZyDs+Fu27L1LKoiRzei4/RCGk3O/QVQBW1rk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Ym15LNvNX+5bNBTOTEfnrPAQERPQL+4Q3JLRjO3chKJgurqlYd90WxSYSbab+74hK
         r5fkWh/kQQqTfh96JTYHX9Jm4ZvoIDKhcBSNcPIQgF+XHN3iXU4rz9WPOBoOUYAksU
         ++4u3F3nNERfFWdutVRxQI27DWewR1g5jk7AC/3c/Lkazl4f47H5hZqBjfkzZpegHi
         jXwVMJ8BqvwpUGapCdr50+Dg8Gke5bX+PaFEffzqGVJdXy7WKib0ztNhbRQGiedDNz
         p4MsveBUV35qF82ZxnpB1UtqerBoYaqlvgmdeKqBsHQnBhrvx+jlOoKXA5NmKDhCz2
         dt7e1tX0WOWoQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH -pm v2] docs: driver-api/thermal/intel_dptf: Use
 copyright symbol
In-Reply-To: <fffa1d50-f155-b6a4-bf58-22e395d7401c@gmail.com>
References: <fffa1d50-f155-b6a4-bf58-22e395d7401c@gmail.com>
Date:   Tue, 05 Apr 2022 09:46:54 -0600
Message-ID: <871qybfs7l.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Akira Yokosawa <akiyks@gmail.com> writes:

> Using a substitution pattern of "|copy|" without including
> isonum.txt causes a doc build warning.
>
> Using the symbol "=C2=A9" itself is a better choice for those
> who read .rst sources.
>
> Fixes: 16c02447f3e1 ("Documentation: thermal: DPTF Documentation")
> Reported by: Randy Dunlap <rdunlap@infradead.org>
> Suggested-by: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> ---
> Changes since v1 [1]:
>
>   - Use =C2=A9 instead of including isonum.txt (Jon).
>   - Amend title and changelog.
>
> v1 [1]: https://lore.kernel.org/r/e06542af-aa8b-0885-37a3-bb7bc5fafa1e@gm=
ail.com/
> ---
>  Documentation/driver-api/thermal/intel_dptf.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/driver-api/thermal/intel_dptf.rst b/Documentat=
ion/driver-api/thermal/intel_dptf.rst
> index 96668dca753a..372bdb4d04c6 100644
> --- a/Documentation/driver-api/thermal/intel_dptf.rst
> +++ b/Documentation/driver-api/thermal/intel_dptf.rst
> @@ -4,7 +4,7 @@
>  Intel(R) Dynamic Platform and Thermal Framework Sysfs Interface
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20=20
> -:Copyright: |copy| 2022 Intel Corporation
> +:Copyright: =C2=A9 2022 Intel Corporation

Applied, thanks.

jon
