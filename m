Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9317D861D6
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2019 14:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403884AbfHHMby (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 08:31:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:45704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403878AbfHHMbx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Aug 2019 08:31:53 -0400
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3667F218A4;
        Thu,  8 Aug 2019 12:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565267512;
        bh=bdQZvsSQ32pIcK00dvHnvYCuayYBNzzTq0JqfKXAAnA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=opj1qQf9iEv45GohNPIZzhCfVIZu1ZKpRtt66TnyPL0lOzTJk5eitdVMhBoy+g0Hf
         UVInrjj0SFWueYHRvOSGyc2Fpz0WX4Dk4DE0AzIZES1sOm0BnypToJNP5f4pPpc22P
         wQUfdU1+dQ5DAUF2r3Ky0lG/+/V7pVl8LsPRJRnY=
Received: by mail-lj1-f181.google.com with SMTP id p17so88755682ljg.1;
        Thu, 08 Aug 2019 05:31:52 -0700 (PDT)
X-Gm-Message-State: APjAAAUT5PPbj95rvcI9AaKvULcLH5UuERGUxkAPpnVMe3cRJG1kPyFF
        WmS/pyH828ZjbTD7Dn0OwwGFNTNcj/dhTaIaMmA=
X-Google-Smtp-Source: APXvYqzE6I+ay+3PmHe0pYVJmR3CgZhxE3A6RP3FlUDg7MjWb3h3zbv3W0JwnvdTTIFomcUI0MjdcuE87ZGWhiIDMH0=
X-Received: by 2002:a2e:3008:: with SMTP id w8mr8290719ljw.13.1565267510378;
 Thu, 08 Aug 2019 05:31:50 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190718143130eucas1p26f2058f47eb2f4020e1ddbf1619d1ac8@eucas1p2.samsung.com>
 <20190718143044.25066-1-s.nawrocki@samsung.com> <20190718143044.25066-4-s.nawrocki@samsung.com>
 <CAJKOXPeOfDHjqSotxVwVuy+6r9X3Q8ZXLit1_=gGd7bOwkHupA@mail.gmail.com> <a56fe2d8-1f26-b462-1564-f23902f7dbb5@samsung.com>
In-Reply-To: <a56fe2d8-1f26-b462-1564-f23902f7dbb5@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 8 Aug 2019 14:31:39 +0200
X-Gmail-Original-Message-ID: <CAJKOXPc8iFo=2JAGEZSC46N3sZae4+JcZYBCjpKysb6PFPzyaQ@mail.gmail.com>
Message-ID: <CAJKOXPc8iFo=2JAGEZSC46N3sZae4+JcZYBCjpKysb6PFPzyaQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] soc: samsung: Add Exynos Adaptive Supply Voltage driver
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     robh+dt@kernel.org, vireshk@kernel.org, devicetree@vger.kernel.org,
        kgene@kernel.org, pankaj.dubey@samsung.com,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 8 Aug 2019 at 14:07, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
> >> +static unsigned int exynos5422_asv_parse_table(struct exynos_asv *asv,
> >> +                                     unsigned int pkg_id)
> >> +{
> >> +       return (pkg_id >> EXYNOS5422_TABLE_OFFSET) & EXYNOS5422_TABLE_MASK;
> >> +}
> >> +
> >> +static bool exynos5422_asv_parse_bin2(struct exynos_asv *asv,
> >> +                                    unsigned int pkg_id)
> >> +{
> >> +       return (pkg_id >> EXYNOS5422_BIN2_OFFSET) & EXYNOS5422_BIN2_MASK;
> >
> > return !!() for converting to boolean.
>
> I'm not convinced it is needed, the return type of the function is bool
> and value of the expression will be implicitly converted to that type.
> Is there any compiler warning related to that?

Yeah, but bool is int so there will be no implicit conversion... I
guess it is a convention. In theory !! is the proper conversion to
bool but if bool==int then it's essentially conversion to 1. I am not
sure what's the benefit, maybe for some wrong code which would do
comparisons on result like if (exynos5422_asv_parse_bin2() == TRUE)...

Best regards,
Krzysztof
