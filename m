Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D50139724C
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jun 2021 13:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbhFAL2I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Jun 2021 07:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbhFAL2H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Jun 2021 07:28:07 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE1AC061574;
        Tue,  1 Jun 2021 04:26:25 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id c3so13875981wrp.8;
        Tue, 01 Jun 2021 04:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Bbmxczt86n0ZwIeh1oB7JRebdsVVoIdB9E1KItxrw4s=;
        b=DPfEsUAHlnHg4WJ7JnUtE9C6esdr8UrSGmf8qN4BP4UyRAs/p8/i/8xs1oQ3j+0J94
         n1O/kn+/Is2Fvt52OLksJif9sCL898o1rmIDnhwuxT2zX0CdtCezKHiBLFRxAoK+r2JV
         ToEaU8ES+sjkZPbts5aLWPL0jN6EaiaddCQN0xMrVeM0wA15Osran1Sw6NpIyyxbr757
         Gr6MGZN4jo9IsDMLbqz2grbZi0UjqSyCnHm5ubO8+a5mO4yJO9DBlKf7zZ9tEL3bA2Ny
         9y3o314HD/iNZeSe9CVJNZC8l60jNZoaCBSnLrNAZ9wAZV5MwK3Jmpg+KsZyOfh/Hpyw
         +khw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Bbmxczt86n0ZwIeh1oB7JRebdsVVoIdB9E1KItxrw4s=;
        b=mPOytGcAnjc9dSZd2+8CPwmMDqsf1vPIMLGpkl1FhOjnhViczsdrWCClUHhJZelOOU
         IEy/GL1mnE3EX6iFi5oLi/Rg8DcGQwaGdJb9JYEERt6CgX3SpKPj60mcqq8fj7rJtYTX
         934Vfz85X8wSieZEwT3nAIqQgX4PIVx2RJV6zJka193IwZg0mQfEnmRoYh8gBIOJ7xgH
         efiPP/47nkKRqyW4A36ZTm56jJ0qCfSahQXf340Jx0smM0IoBGviEZZXTaBde4eXJmST
         K10Ki+oy69M5CM6sj8gOWPWRKgtO9BVJNOwhEXNl48zqxTcnf+beZl2x3elsmoJRGMWL
         3n8A==
X-Gm-Message-State: AOAM531H4kd9rKNpT6PVmaX0b7jrjC1PPWw/j6IkBWk0Zek/6NMN0mzl
        Gh5LLqTjle1mdtnRCM4jPIo=
X-Google-Smtp-Source: ABdhPJzhKoFglUVq4+ZSesu4iSZ4DfjnhebLMTYDt/o3mF+bM+jx9ZpiAcxZ8VziMIAyv3M2ey4F1A==
X-Received: by 2002:a5d:538c:: with SMTP id d12mr849200wrv.116.1622546783198;
        Tue, 01 Jun 2021 04:26:23 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id 6sm9208524wmg.17.2021.06.01.04.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 04:26:20 -0700 (PDT)
Date:   Tue, 1 Jun 2021 13:27:56 +0200
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
Message-ID: <YLYZvFPyJFJgxI56@orome.fritz.box>
References: <20210601023119.22044-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jQ9XooBwh3CMbl+E"
Content-Disposition: inline
In-Reply-To: <20210601023119.22044-1-digetx@gmail.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--jQ9XooBwh3CMbl+E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 01, 2021 at 05:31:05AM +0300, Dmitry Osipenko wrote:
> This series:
>=20
>   1. Adds CPU/core voltage bump before system is rebooted.
>   2. Adds new devm_tegra_core_dev_init_opp_table() helper and switches
>      Tegra memory drivers to use it.
>   3. Adds compile-testing support to the Tegra memory drivers.
>   4. Adds Tegra SoC core power domain support.
>=20
> Changelog:
>=20
> v6: - Fixed another compile-test trouble reported for v5. I double checked
>       the clk stubs this time and compiled them locally.

Heh... I just fixed those locally on top of your v5. Let me see if I can
roll back the changes and apply this new set instead.

Thierry

--jQ9XooBwh3CMbl+E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmC2GbwACgkQ3SOs138+
s6GZcxAAwAW383JhE5y+j756zxk2eJtP2L4sR43pP2ukgez2S3EWAgQJTCKqLxtM
5WyvDsokxqCwFPxruVTCvVS71wM8m0elkiAcXmchDtCjUinqg9SinaExAewJYekB
5nTnylFaw5jnjTX8xkSndSfnfoyChNHIvg+xewCdQY72XMHEgc/jpCZ9xBU5vB0t
24FZvU95JzNFkhFbVvBiTbCfYhH26aZpnH0WO2ZqfCwKpkf9EPiB9icriPt6Lz9u
jUdbydwS2kHNndXpGk7MJVjm6BxIo2gdLmYHOg4S59ijjHqaho39Zd+yl6z/yD+W
5MrRluQCTD4yJZKj3JspXJiOhRRowXLKcGpdh3ZpTghmfgx7+Z5IjClPHgrOrt7I
ZhEf7OqIPvrh6jEj8RYRfBWjFr3w5bvUTYAKJ7Hpu6bvL0YnRZB0jiTWSsFbqomQ
5bLre67BJSYS9kpACvl6D/CD1B1+oMqgHaMQF13IjNzWWPYyakakkQNx3uNdeY0Q
V3Hnu8axNrp3J8c/xNv5VN5PxFyQA7ESO2mQMWs5YBCP2mqbLljn7KPVp283BiVe
r/GiUxBNrJCnK3zH5kmWKRPJZ+9YtN7cJCmD1d9w/E88EjyZm3zoxmt1cMEx5DXC
uvkKktKhav1ObzX2MUC/mTr2NWaDKh/+kgi2HkJ6PKhUHrnQLj0=
=D53B
-----END PGP SIGNATURE-----

--jQ9XooBwh3CMbl+E--
