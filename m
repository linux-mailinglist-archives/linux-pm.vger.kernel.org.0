Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9203978BF
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jun 2021 19:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbhFARKU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Jun 2021 13:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234581AbhFARKR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Jun 2021 13:10:17 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B91EC061760;
        Tue,  1 Jun 2021 10:08:35 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id dg27so8547198edb.12;
        Tue, 01 Jun 2021 10:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b14f7x0G6qwhXKyhv/ZWNE4Va6SHm9Fj/WA+S8U4gkk=;
        b=VI37py+0idQkQMtyA2diYaP9Qs+Q0PI7DAaQNzlIIRdS5jdFlTxxq6fNexYlkF/b7t
         2ZTUG38T0QH88npVF6+6aTmibfeCiSVnzTFKIrNQpYdpgS3PcBRSrQXRrmY+704bo+i/
         pKajwjIOWL93YGz4q7HbDrwYOF9iEOVCGjHCycUDbsHfuTox+VhdGxbZWMspRjSbmYZ4
         c0S1LkyyLr8Tz+tzsMfJP/UvseqCzZSGwNVdnsIGRHmopN1YBsE4z2CctEo8KJe6gWUd
         h2mzqgq3/icbtbuA/7KhhKwloI+BfTkqJyy94ZD3ra2YO7iDf0g7jY2SXXsdG1m0ajPk
         eAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b14f7x0G6qwhXKyhv/ZWNE4Va6SHm9Fj/WA+S8U4gkk=;
        b=mWQPl+DIcvsssHsqHzZ3elYIaSs2QpSppbxCqpaVHR09mSxlCzXZCBtXxxauToaHvy
         SKEVfIHKRLkrtrb76VjzO50FtHxsR2Yrd1n3PmtnJZ9lUbVMZIKcZmaPYZKKXWijMFuZ
         G9yW0xH9CM0Drv2WrMJWAhINcB6thDhHru14jbCz/UepTqRmoXRJ9c7kK9GMCgMGra0J
         be9MuXirl+WcQFWFNzRxz79pH4XYijRkGcpzjHQsFdOvykHizKEmfDh4tdInttAmesZE
         m2m0zDYbbSk2dqQp2hRfJWivQUWyHgihAPaGgs1TniqhV8HaXlSCHWrHxpKbvGcng4A9
         /dKg==
X-Gm-Message-State: AOAM531bywibznydGMXJkzL621lrO6CkJi/y4zhJ/sOpfJnEJzjqB0at
        wO18huV65FeQUdYXS2QuZnA=
X-Google-Smtp-Source: ABdhPJwaNZhg0igVAbJpgo4E4GFx+2pDpOX8Zrxo64OaAWULhK5yea/2YAcxTgnMuDGgV4a5ieTPkg==
X-Received: by 2002:aa7:d8d8:: with SMTP id k24mr18079147eds.253.1622567313625;
        Tue, 01 Jun 2021 10:08:33 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id r21sm5292674edy.78.2021.06.01.10.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 10:08:32 -0700 (PDT)
Date:   Tue, 1 Jun 2021 19:10:08 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Nikola =?utf-8?Q?Milosavljevi=C4=87?= <mnidza@outlook.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Paul Fertser <fercerpav@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v6 00/14] NVIDIA Tegra memory and power management
 changes for 5.14
Message-ID: <YLZp8FlV4lcDnL23@orome.fritz.box>
References: <20210601023119.22044-1-digetx@gmail.com>
 <YLYZvFPyJFJgxI56@orome.fritz.box>
 <11206c96-9f56-ca6f-e5e3-658534356666@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UGsCKX3hLwTPT7Tr"
Content-Disposition: inline
In-Reply-To: <11206c96-9f56-ca6f-e5e3-658534356666@gmail.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--UGsCKX3hLwTPT7Tr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 01, 2021 at 06:51:33PM +0300, Dmitry Osipenko wrote:
> 01.06.2021 14:27, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Tue, Jun 01, 2021 at 05:31:05AM +0300, Dmitry Osipenko wrote:
> >> This series:
> >>
> >>   1. Adds CPU/core voltage bump before system is rebooted.
> >>   2. Adds new devm_tegra_core_dev_init_opp_table() helper and switches
> >>      Tegra memory drivers to use it.
> >>   3. Adds compile-testing support to the Tegra memory drivers.
> >>   4. Adds Tegra SoC core power domain support.
> >>
> >> Changelog:
> >>
> >> v6: - Fixed another compile-test trouble reported for v5. I double che=
cked
> >>       the clk stubs this time and compiled them locally.
> >=20
> > Heh... I just fixed those locally on top of your v5. Let me see if I can
> > roll back the changes and apply this new set instead.
>=20
> Thank you! You probably saw already that Ulf Hansson suggested to remove
> the lockdep annotation for now from the core PD, I'll make a v7 with
> this small change.

Can you perhaps post this change as a follow-up? That way I can just
merge it into the corresponding branch, which may be easier than backing
out all the changes spread over four branches and applying basically the
same thing again.

Thierry

--UGsCKX3hLwTPT7Tr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmC2afAACgkQ3SOs138+
s6G/ew//SSAN5RwYaYKKZhq2h3fzHhv65ckrGL74avoGHdwES0XJzLEsMSULZggA
w3NKHFtmqyDnaCTL2M9QSOnBPGohXwutZtX8GWifTATMzg+JaRNH1Hsm48lbuovi
Aab4sL6NzAdX1j/MxI3PZgviVmDKz5R0uzAN3xa7CWjGs64a7nhvhf8ONRdJanEB
7NiFjiR5HpcldgfR9hv6DwID5GxeAaQ6HcOngERDGTkC7dPPWfd7LrqJkOJ77iLG
I0CFmXe4nu+lNI9zztqyuD3Z/b64otAmtwhVa30plsnysl40EaJJWI+nFrPMBrGj
hh+5ZoFzPz+D5p6yZ0qjLCUZ8rL9JiRSdOEDl/mYVT3/pgO/zG8NpuuzEtYvQije
62Tn7L4T5cpdRfkgTnmWWOE4fh6iWbRBHvp8RDJ/eaUjGaHC4E1yvw84YSOxkMgr
dk0P9R1amzVgI8TFiPn2HQ9X/rbLSqlhjN7iKBffpKmrkaq+7QixSaHw/wbh8CqX
msfyAyuGQC65JiyMtOQcZuARntKJtgZuYy9gwb+w6VyD8ttWFu3P0FpHvkSmFFz8
DeGQ2aAaB/R8SpbIsasRxNGsFKEq3En7dfFLuM5TyAF+N///UuTpJVanB3967N3o
DyuvDflL/6a7PTGJp2M4ZOBg9LKpQYMteNf9e8m9okhrtsKd/yQ=
=Cbap
-----END PGP SIGNATURE-----

--UGsCKX3hLwTPT7Tr--
