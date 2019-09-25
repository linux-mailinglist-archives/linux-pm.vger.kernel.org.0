Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A52F5BD7E6
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2019 07:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411772AbfIYFrr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Sep 2019 01:47:47 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57812 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411791AbfIYFrq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Sep 2019 01:47:46 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190925054745euoutp02f54675207e1644a6ad6cbdd6737b2b75~HmFBOGzF71314613146euoutp02I
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2019 05:47:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190925054745euoutp02f54675207e1644a6ad6cbdd6737b2b75~HmFBOGzF71314613146euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569390465;
        bh=Z5x2fIzH/UThhqtNBRGIRK73inw+W8sQQShb8cuq+Dw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=V5DXhR48LbO9KrkJsz3TN+ZFNKSp60UrzKMIZc7eGUIP9tfgVAZuA7SaVl/KwsABV
         Dc03JDVYzPK3PKeOyxcMtEbAly/Ou7bx11D1EWEs8LvkaxKBrHjy957okYp2wZKcjp
         DmOTAkWyOk7T+qmMfNwdJ6WK4xJA4koNlCJwxOcs=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190925054745eucas1p170eaab25d17f88843483700ee6d8e1d6~HmFA7xPP31488914889eucas1p1z;
        Wed, 25 Sep 2019 05:47:45 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 9A.01.04309.18FFA8D5; Wed, 25
        Sep 2019 06:47:45 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190925054744eucas1p28a2427e08dbdf148d67e395642a533da~HmFAN9UFj1996119961eucas1p2C;
        Wed, 25 Sep 2019 05:47:44 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190925054744eusmtrp218ada16cb20b3971cc469885b41d559c~HmFANKgFL0721607216eusmtrp2g;
        Wed, 25 Sep 2019 05:47:44 +0000 (GMT)
X-AuditID: cbfec7f4-afbff700000010d5-ea-5d8aff815330
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 8C.94.04117.08FFA8D5; Wed, 25
        Sep 2019 06:47:44 +0100 (BST)
Received: from AMDC3555 (unknown [106.120.51.67]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20190925054743eusmtip192b3d31fb4c2ff8a37f978484e114585~HmE-Zonns3141331413eusmtip1K;
        Wed, 25 Sep 2019 05:47:43 +0000 (GMT)
Message-ID: <c06ca89f2b40e0282f19727b95da5e5b0158d7e3.camel@samsung.com>
Subject: Re: [RFC PATCH v2 00/11] Simple QoS for exynos-bus driver using
 interconnect
From:   Artur =?UTF-8?Q?=C5=9Awigo=C5=84?= <a.swigon@samsung.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     myungjoo.ham@samsung.com, inki.dae@samsung.com,
        sw0312.kim@samsung.com, georgi.djakov@linaro.org,
        leonard.crestez@nxp.com, m.szyprowski@samsung.com,
        b.zolnierkie@samsung.com, krzk@kernel.org,
        "cpgs (cpgs@samsung.com)" <cpgs@samsung.com>
Date:   Wed, 25 Sep 2019 07:47:43 +0200
In-Reply-To: <d8550f93-d4cf-f215-c083-8ecad267d430@samsung.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRj229k5O1pHPqflm62kReEkNSvigyILog5Ftz8FheRqh2npjB21
        KzTLbotVGJFaOqOoZch0WugqKx0OKu9mQomGXV2uRKdEF9t2ivr3vM/7Pc/zPvCxlLKDjmEz
        DDmC0aDNVDNh8nvN31oT8ifNqQsneoFUF9lp8qlRQ16OfaCJ1dVKk27fF4ZcfuhgSGH/BTlp
        a6tSEFvfCE0cgz006XJeZcioxYVIUVuDjFS6+hTkVb6NIUUXPzErMe+oOMPwr3seMHz/WbeM
        r7lxlK/21sn4c7UViB91zN6s2B62XCdkZuQJxqQVaWHphV3n5fvyEw68NDUgE2qYa0YsC3gJ
        PHgbb0ZhrBLbEHy73iKXhjEEvZ99MmkYRXBjot+/CQ0q2u9fYqTFLQSWIRuShvcIHO0P6cAr
        DvPQZCpkAjgSb4NSz0CQZ3AKtLwaD9pGYS+Ct4++UoGBwuMIfGVVwQw5ngettlIqgEP9isHb
        HiRlL4Dhp+fkgcs5HAE/6yIDNIVj4fjdK0EfwCMKKCh+Q0ntVkOFZa0kjYQhd61CwiqYrLfK
        JCzCu/p+WtKa/A1uuihpsQya3B10wIfCGrA7kySaA1P19z8+q6DS46SlqHDoHY6QzgmHwnuX
        /1zAwemTSgmqwVkcLgkBjt3poS4gdcm/KiX/VSn5l1qOqAoULeSKWXpBXGQQ9ieK2iwx16BP
        3J2d5UD+j/bsl3usDjl/7GpEmEXqqdxK2pyqpLV54sGsRgQspY7iSlR+itNpDx4SjNk7jbmZ
        gtiIZrJydTR3OGRghxLrtTnCXkHYJxj/bmVsaIwJMb4YlTcieWTBNYe5fFr81qXNE7da5uti
        6p7r5+Bivvdd/vpNnmOzt/h2Go54H29L6izXbyLW6SHrhs42qzoGxBmrhu1WcUXphrbkghef
        Ez6SlJTUjeNxHWssRVx2X5SmzO5xzTp1Is4crkv7EZ/TvSdW83RKp+GkzlqzaHHpkzi1XEzX
        JsdTRlH7G0eFqPVkAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsVy+t/xu7oN/7tiDU7tV7PYOGM9q8XLQ5oW
        1788Z7WYf+Qcq8WVr+/ZLKbv3cRmMen+BBaL8+c3sFusuPuR1WLT42usFpd3zWGz+Nx7hNFi
        xvl9TBZrj9xlt7jduILNYsbkl2wOAh6bVnWyedy5tofN4373cSaPzUvqPTa+28Hk0bdlFaPH
        501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJ
        ehmTLvezFDTqVlxv2MfYwLhPuYuRk0NCwETiwu6pbF2MXBxCAksZJd4e2sYOkZCQ+Lj+BiuE
        LSzx51oXVNETRokHpxYzgiR4BTwkDjdMYgOxhQXCJea+fgDWwCZgL3H29jcmkAYRgfeMEh+2
        vwObyizwg1Hi8wl9EJtFQFXi3Iq5zCA2J1DD45WvGSE2/GGUaJm2nxmiQVOidftvqJN0JN6e
        6mPpYuQA2iwo8XeHMESJvETz1tnMExgFZyHpmIVQNQtJ1QJG5lWMIqmlxbnpucVGesWJucWl
        eel6yfm5mxiB8brt2M8tOxi73gUfYhTgYFTi4XVg7YoVYk0sK67MPcQowcGsJMI7SwYoxJuS
        WFmVWpQfX1Sak1p8iNEU6J+JzFKiyfnAVJJXEm9oamhuYWlobmxubGahJM7bIXAwRkggPbEk
        NTs1tSC1CKaPiYNTqoFR+oq/wLKOf/s9bIQ6dbuz2+7wHvHW45a9bLUjzmeHs1aoaGgj8yqL
        DQqr/y+uq94QauMmWyZzpnjN1wfVB9UmKvYdnO6z49CzLYv42COO9c5VeTD7Ucb8/hLnNfcW
        bwtwfqX5/ZSu3iouVX71az2B9+va5565bvhX9IHsNgH3to1bFu1il2RXYinOSDTUYi4qTgQA
        iyp1f+0CAAA=
X-CMS-MailID: 20190925054744eucas1p28a2427e08dbdf148d67e395642a533da
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-CPGSPASS: Y
X-RootMTR: 20190919142321eucas1p164c2591ad402427cb71fd00c348a29ec
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190919142321eucas1p164c2591ad402427cb71fd00c348a29ec
References: <CGME20190919142321eucas1p164c2591ad402427cb71fd00c348a29ec@eucas1p1.samsung.com>
        <20190919142236.4071-1-a.swigon@samsung.com>
        <fe6d026d-71b5-438d-6932-6a2234fc72c2@samsung.com>
        <d8550f93-d4cf-f215-c083-8ecad267d430@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Fri, 2019-09-20 at 11:14 +0900, Chanwoo Choi wrote:
> Hi Artur,
> 
> I tried to just build this patch on mainline kernel or linux-next.
> But, when I applied them, merge conflict happens. You didn't develop
> them on latest version. Please rebase them based on latest mainline kernel.

I developed on top of next-20190918 on which I applied
https://patchwork.kernel.org/cover/11149497/ as I mentioned in the cover
letter. The dev_pm_qos patches and my RFC have just cleanly rebased together on
top of next-20190920. Could you check if you have the dev_pm_qos patches (v5,
the version number is missing in this one; link above) and if so, where does the
conflict appear?

> On 19. 9. 20. 오전 10:07, Chanwoo Choi wrote:
> > Hi Artur,
> > 
> > On v1, I mentioned that we need to discuss how to change
> > the v2 for this. But, I have not received any reply from you on v1.
> > And, without your reply from v1, you just send v2.
> > 
> > I think that it is not proper development sequence.
> > I have spent many times to review your patches
> > and also I'll review your patches. You have to take care
> > the reply of reviewer and and keep the basic rule
> > of mailing contribution for discussion.
> > 
> > On 19. 9. 19. 오후 11:22, Artur Świgoń wrote:
> > > The following patchset adds interconnect[1][2] framework support to the
> > > exynos-bus devfreq driver. Extending the devfreq driver with interconnect
> > > capabilities started as a response to the issue referenced in [3]. The
> > > patches can be subdivided into four logical groups:
> > > 
> > > (a) Refactoring the existing devfreq driver in order to improve readability
> > > and accommodate for adding new code (patches 01--04/11).
> > > 
> > > (b) Tweaking the interconnect framework to support the exynos-bus use case
> > > (patches 05--07/11). Exporting of_icc_get_from_provider() allows us to
> > > avoid hardcoding every single graph edge in the DT or driver source, and
> > > relaxing the requirement contained in that function removes the need to
> > > provide dummy node IDs in the DT. Adjusting the logic in
> > > apply_constraints() (drivers/interconnect/core.c) accounts for the fact
> > > that every bus is a separate entity and therefore a separate interconnect
> > > provider, albeit constituting a part of a larger hierarchy.
> > > 
> > > (c) Implementing interconnect providers in the exynos-bus devfreq driver
> > > and adding required DT properties for one selected platform, namely
> > > Exynos4412 (patches 08--09/11). Due to the fact that this aims to be a
> > > generic driver for various Exynos SoCs, node IDs are generated dynamically
> > > rather than hardcoded. This has been determined to be a simpler approach,
> > > but depends on changes described in (b).
> > > 
> > > (d) Implementing a sample interconnect consumer for exynos-mixer targeted
> > > at the issue referenced in [3], again with DT info only for Exynos4412
> > > (patches 10--11/11).
> > > 
> > > Integration of devfreq and interconnect functionalities is achieved by
> > > using dev_pm_qos_*() API[5]. All new code works equally well when
> > > CONFIG_INTERCONNECT is 'n' (as in exynos_defconfig) in which case all
> > > interconnect API functions are no-ops.
> > > 
> > > This patchset depends on [5].
> > > 
> > > --- Changes since v1 [6]:
> > > * Rebase on [4] (coupled regulators).
> > > * Rebase on [5] (dev_pm_qos for devfreq).
> > > * Use dev_pm_qos_*() API[5] instead of overriding frequency in
> > >   exynos_bus_target().
> > > * Use IDR for node ID allocation.
> > > * Avoid goto in functions extracted in patches 01 & 02 (cf. patch 04).
> > > * Reverse order of multiplication and division in
> > >   mixer_set_memory_bandwidth() (patch 11) to avoid integer overflow.
> > > 
> > > ---
> > > Artur Świgoń
> > > Samsung R&D Institute Poland
> > > Samsung Electronics
> > > 
> > > ---
> > > References:
> > > [1] Documentation/interconnect/interconnect.rst
> > > [2] Documentation/devicetree/bindings/interconnect/interconnect.txt
> > > [3] https://patchwork.kernel.org/patch/10861757/ (original issue)
> > > [4] https://patchwork.kernel.org/cover/11083663/ (coupled regulators; merged)
> > > [5] https://patchwork.kernel.org/cover/11149497/ (dev_pm_qos for devfreq)
> > > [6] https://patchwork.kernel.org/cover/11054417/ (v1 of this RFC)
> > > 
> > > Artur Świgoń (10):
> > >   devfreq: exynos-bus: Extract exynos_bus_profile_init()
> > >   devfreq: exynos-bus: Extract exynos_bus_profile_init_passive()
> > >   devfreq: exynos-bus: Change goto-based logic to if-else logic
> > >   devfreq: exynos-bus: Clean up code
> > >   interconnect: Export of_icc_get_from_provider()
> > >   interconnect: Relax requirement in of_icc_get_from_provider()
> > >   interconnect: Relax condition in apply_constraints()
> > >   arm: dts: exynos: Add parents and #interconnect-cells to Exynos4412
> > >   devfreq: exynos-bus: Add interconnect functionality to exynos-bus
> > >   arm: dts: exynos: Add interconnects to Exynos4412 mixer
> > > 
> > > Marek Szyprowski (1):
> > >   drm: exynos: mixer: Add interconnect support
> > > 
> > >  .../boot/dts/exynos4412-odroid-common.dtsi    |   1 +
> > >  arch/arm/boot/dts/exynos4412.dtsi             |  10 +
> > >  drivers/devfreq/exynos-bus.c                  | 319 +++++++++++++-----
> > >  drivers/gpu/drm/exynos/exynos_mixer.c         |  71 +++-
> > >  drivers/interconnect/core.c                   |  12 +-
> > >  include/linux/interconnect-provider.h         |   6 +
> > >  6 files changed, 327 insertions(+), 92 deletions(-)
> > > 
> > 
> > 
> 
> 
-- 
Artur Świgoń
Samsung R&D Institute Poland
Samsung Electronics


