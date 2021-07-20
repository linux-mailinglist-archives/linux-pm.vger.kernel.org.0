Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0FB23CF533
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jul 2021 09:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhGTGit (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Jul 2021 02:38:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:35368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229588AbhGTGh7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Jul 2021 02:37:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 354D961164;
        Tue, 20 Jul 2021 07:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626765515;
        bh=yTva8fpd7rAmHf9rcie+nXbZnL+Lm0tokbn/ORpXNZM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=OG2W8xzKkYVH6IlTNVty7c8Hlnh8gVCx1RvYZJcYBYmI4ThJBTgLcbYdNvLQJOFL+
         ilRhUJrvvuHZr1LTdJ55n8XU/m5jw0nw1qMHPCgIJhf85yMGy2g9sBQ+MRyT4DDlFH
         QkzmCN7crVn1EVh1n2SCu8BSBKTVBMAPo0ZjW88FuZ/8Se/nGc20muGk4aNwYur8uD
         7+XILJElOSrIc89D/JBBSunCFi75yqycHwQnFVJb36664DxCbERLT2Lwh1emnEZDLl
         7n0g2wJhp4/xl+XRoQiwECVT6m1ADmhx0YnQjPdLwQaLo6ViGr7UOsuw1iCf0yLeRh
         pnSLongroKgWg==
From:   Felipe Balbi <balbi@kernel.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>, ulf.hansson@linaro.org,
        bjorn.andersson@linaro.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, rojay@codeaurora.org, stephan@gerhold.net,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH v5 1/2] PM / Domains: Add support for 'required-opps' to
 set default perf state
In-Reply-To: <1626764876-10229-2-git-send-email-rnayak@codeaurora.org>
References: <1626764876-10229-1-git-send-email-rnayak@codeaurora.org>
 <1626764876-10229-2-git-send-email-rnayak@codeaurora.org>
Date:   Tue, 20 Jul 2021 10:18:24 +0300
Message-ID: <871r7tzc5b.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Rajendra Nayak <rnayak@codeaurora.org> writes:
> @@ -2635,9 +2641,10 @@ static void genpd_dev_pm_sync(struct device *dev)
>  static int __genpd_dev_pm_attach(struct device *dev, struct device *base=
_dev,
>  				 unsigned int index, bool power_on)
>  {
> +	struct device_node *np;
>  	struct of_phandle_args pd_args;
>  	struct generic_pm_domain *pd;
> -	int ret;
> +	int ret, pstate;

nit: might want to keep one variable declaration per line here.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCAAvFiEE9DumQ60WEZ09LIErzlfNM9wDzUgFAmD2eMARHGJhbGJpQGtl
cm5lbC5vcmcACgkQzlfNM9wDzUhYAggAqmGtV8s1jMt1CfWKeCnD+OEjfKviaLc+
5KkpCz/6/TshWjSYR3dBa1qaPX8VGUHl66p3oiGhY1vV73XmqTbLfqeG10jz2Wrx
kjqGUoWeG2xXg/S3yefDljL3mR5sxJA/SdxAKr1Fv6hza55D1huvakPuridjq//Y
atulXP6MDgwdSc71bwDVjN1Dk7IA9qMx6ZvqkcJEL+AOIO++1yMbLk6YA2yaDrhO
SGEJ2NP73ytOv8d1AJrRDvurJdeNRhdM4gibSlDQx0nrspucdv74kUBwCqhMQdl6
C8MzGEL/w7rogRqCoXh0d1ER2yt20yjga2qBq+D6BnEdBd+XJDXwyg==
=r4IL
-----END PGP SIGNATURE-----
--=-=-=--
