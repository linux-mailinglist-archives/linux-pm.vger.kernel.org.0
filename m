Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0AFBDABF
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2019 11:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfIYJPl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Sep 2019 05:15:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:52126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbfIYJPb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 25 Sep 2019 05:15:31 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C17A020673;
        Wed, 25 Sep 2019 09:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569402925;
        bh=Z2Uag+DwW909ph/1HOySpUCCmNKluWCbwO7QFKK6F8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LUAdHLEB0Njr3vPkEeYEnn9UJ65aNeraXjCw8vvFf6X7fzKvIP2kobELTTOGaz+Ai
         F/6Pk5OGh6G++u9o8W46kH+kpymk6XLNk9oIVvO3P5dgTlNDCS89SC0ZdQYzlIooNS
         HHynK47zEbah8oMWrSK4ChXXBYoripfPPxhyqVt0=
Date:   Wed, 25 Sep 2019 11:15:22 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        David Dai <daidavid1@codeaurora.org>
Subject: Re: [RFC PATCH] interconnect: Replace of_icc_get() with icc_get()
 and reduce DT binding
Message-ID: <20190925091522.jf5q2jdo6njfkxto@gilmour>
References: <20190925054133.206992-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aomtcuidegtr2wsv"
Content-Disposition: inline
In-Reply-To: <20190925054133.206992-1-swboyd@chromium.org>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--aomtcuidegtr2wsv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Stephen,

On Tue, Sep 24, 2019 at 10:41:33PM -0700, Stephen Boyd wrote:
> The DT binding could also be simplified somewhat. Currently a path needs
> to be specified in DT for each and every use case that is possible for a
> device to want. Typically the path is to memory, which looks to be
> reserved for in the binding with the "dma-mem" named path, but sometimes
> the path is from a device to the CPU or more generically from a device
> to another device which could be a CPU, cache, DMA master, or another
> device if some sort of DMA to DMA scenario is happening. Let's remove
> the pair part of the binding so that we just list out a device's
> possible endpoints on the bus or busses that it's connected to.
>
> If the kernel wants to figure out what the path is to memory or the CPU
> or a cache or something else it should be able to do that by finding the
> node for the "destination" endpoint, extracting that node's
> "interconnects" property, and deriving the path in software. For
> example, we shouldn't need to write out each use case path by path in DT
> for each endpoint node that wants to set a bandwidth to memory. We
> should just be able to indicate what endpoint(s) a device sits on based
> on the interconnect provider in the system and then walk the various
> interconnects to find the path from that source endpoint to the
> destination endpoint.

The dma-mem name is used by the OF core to adjust the mapping of the
devices as well. So, any solution needs to be generic (or provide a
generic helper).

Maxime

--aomtcuidegtr2wsv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXYswKgAKCRDj7w1vZxhR
xe8UAQC3EqIcKg882wsQj/TdlIO/sf9HoBIDnQnVNJ2t2kaPsAD/Qsa+D9ZQUlKc
qhYx4agifh1/WXVN4H+Wb39VO4vx5wk=
=Z0s1
-----END PGP SIGNATURE-----

--aomtcuidegtr2wsv--
