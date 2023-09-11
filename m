Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F1C79C351
	for <lists+linux-pm@lfdr.de>; Tue, 12 Sep 2023 04:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239188AbjILCw3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Sep 2023 22:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239961AbjILCwT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Sep 2023 22:52:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC05247BF7
        for <linux-pm@vger.kernel.org>; Mon, 11 Sep 2023 19:22:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80FA2C116AC;
        Mon, 11 Sep 2023 22:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694470291;
        bh=9xgcfoLXpsarcdZ6MsksuhWsqxyGuMU2EIpeJoma7qs=;
        h=Date:From:To:Cc:Subject:From;
        b=D3eAlDlsRFAHgs4mtSQu2piofthwM4zq3cFD5K+W8eB5ShdiLrXeea+gayFRGJjVz
         yCs7YtnjKb7vndqhvAj6JZisyEkmVVuFR/DKz6p5881r7mH8Z6AWb1O0AwWmd4qs6V
         /VdI4IzsSGQBL96q230GKQhGvgSK55oUjh/nucIcOIfC5N1l3LJdwANtC/SbJOD9/U
         czHrEZGHIT0B6VwhD3aQPazKB5GG7q/UODvFjWOf+MH9idy+c/labr7D+PWTkGgP61
         4/9lb+Tk0jCkm3hp3XUUrqatwHXaEN0WVzNPf5H680rP2+bEv2UNuUxFuU5iBuRkM3
         1vTauKJjQagYQ==
Date:   Mon, 11 Sep 2023 23:11:27 +0100
From:   Conor Dooley <conor@kernel.org>
To:     arnd@arndb.de, ulf.hansson@linaro.org
Cc:     Changhuang Liang <changhuang.liang@starfivetech.com>,
        Walker Chen <walker.chen@starfivetech.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh@kernel.org>,
        Jia Jie Ho <jiajie.ho@starfivetech.com>, conor@kernel.org,
        linux-pm@vger.kernel.org
Subject: Missed soc/genpd PR for 6.6 mw
Message-ID: <20230911-scouring-squash-3ef2cc8b1ee2@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LnID/Z83AY46bbrF"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--LnID/Z83AY46bbrF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey all,

So I've been informed that I made a hames of things and forgot to send
my soc driver PR for the 6.6 merge window. There's not too much in my
branch
https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/log/?h=riscv-soc-for-next
so I would've kicked the can to 6.7, but the majority of changes there were
made to the starfive pmu driver that has since moved to the new genpd
subsystem.

Sending a PR to Arnd for 6.7 with the pmu bits & based on v6.5-rc1 doesn't
seem to make all that much sense to me, since that stuff is no longer in
drivers/soc, but rebasing on top of v6.6-rc1 would make these genpd changes,
with a different path to Linus.

What's the best way to rectify me screwing this up? Should I split out
the non genpd patch and send a PR for that for the genpd tree for 6.7?

Thanks,
Conor.

--LnID/Z83AY46bbrF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZP+QjwAKCRB4tDGHoIJi
0i6DAQCjnuw+oBFXw1zVZ5b8WdW2dD3CGQ2g/4PC180nUzfLRQEAx43AhfrVwniN
23fOLn51eWMkM8KAMRCDmDdnhgUBWwE=
=pTt1
-----END PGP SIGNATURE-----

--LnID/Z83AY46bbrF--
