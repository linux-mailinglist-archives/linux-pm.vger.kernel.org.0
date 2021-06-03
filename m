Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2827399F9C
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jun 2021 13:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhFCLRZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Jun 2021 07:17:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229665AbhFCLRZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 3 Jun 2021 07:17:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A5AE5613E6;
        Thu,  3 Jun 2021 11:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622718941;
        bh=RwbkK9oF6LST8g6LQt2OeAbkTHnZ2UJmsx7Gny6sH+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nRxQVPB8aRCGlO1BPnW4n8qX3/w7qxVvCdgDcUx4KdmevFX9NiOKOi16VS7PvHmsQ
         KT31a3l/uLZ3u+vSNjaxCvOgM3pf4LC1vrnTQJzk2vhkLZif8RD5QskjYa0umBFin/
         1p7b2QE061b2wNMDQ2zmMa6wv2vsKqJdGyblKtr39ILemR9DqVm/YcT05CtfHMiuF/
         MOfjKvXJdO9I6Lw26YPE3EuM2nClZUiG2ljH3bNCD4phNccq9jhiw4yx4cnEPU7WkF
         hVpj6iFbguNaPZbHH/UFansBAoEP6vjPu4U5747NrPFPMHbalxaEkGmb7GFhkP0x1y
         DRgTRRFiEsVQA==
Date:   Thu, 3 Jun 2021 12:15:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH v2 4/4] PM: domains: Drop/restore performance state votes
 for devices at system PM
Message-ID: <20210603111529.GB4257@sirena.org.uk>
References: <20210603093438.138705-1-ulf.hansson@linaro.org>
 <20210603093438.138705-5-ulf.hansson@linaro.org>
 <CAPDyKFp2dKFQpLMgazXumCxf=FHQ9bdadXUkGsjiAwniF8p2dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Content-Disposition: inline
In-Reply-To: <CAPDyKFp2dKFQpLMgazXumCxf=FHQ9bdadXUkGsjiAwniF8p2dw@mail.gmail.com>
X-Cookie: Where am I?  Who am I?  Am I?  I
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 03, 2021 at 12:20:57PM +0200, Ulf Hansson wrote:
> On Thu, 3 Jun 2021 at 11:34, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> > Recent changes in genpd drops and restore performance state votes for
> > devices during runtime PM.

> After a second thought, it looks like we maybe should defer to apply
> this final patch of the series. At least until we figured out how to
> address the below issue:

> So, I noticed that we have things like "regulator-fixed-domain", that
> uses "required-opps" to enable/disable a regulator through the
> dev_pm_set_performance_state() interface. We likely don't want to drop
> the performance state internally in genpd when genpd_suspend_noirq()
> gets called, for the corresponding struct device for the regulator.

> I guess if genpd should drop performance states like $subject patch
> suggest, we need some kind of additional coordination, that allows a
> subsystem/driver to inform genpd when it should avoid it. Or something
> along those lines.

I'm not sure what you're looking for from me here - was there a concrete
question or somehing?

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmC4udAACgkQJNaLcl1U
h9D8kgf/dBC8AxOjnHauevy6x2baUEtxIkdLpGc2VA+tTItoQOpKj5VjLNVN4jR9
WSxXFtxgOKiJxnMPauE92BJzPN4zsYN/9++bb5Z7f6qnTDCkudumz17ofsYX6kNR
94SE6H8EQhtZvvYqeRt60EdcMRKvFpvI4DLd5Nt6FB+PaBhhQkMy0yQL9adke/ha
VzkHdTtfMxyqw7iHgq/hfagCg/zYH1Ie+p61Iax8tavibpOHU6hkDUgSjKQQxLPO
31kwox5f/q+BhE5+Ruf+VBqSbAp84UDO3eNelr8yjgPZi5AuOca6Jt3E/tcXPfF/
UOmOkD544VJFywxF2282v8In8pGzCw==
=/jXo
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--
