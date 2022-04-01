Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2F54EF3C4
	for <lists+linux-pm@lfdr.de>; Fri,  1 Apr 2022 17:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbiDAO4K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Apr 2022 10:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352460AbiDAOuW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Apr 2022 10:50:22 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CAD2B331E;
        Fri,  1 Apr 2022 07:41:45 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:35::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 66E7236D;
        Fri,  1 Apr 2022 14:41:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 66E7236D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1648824065; bh=YOo/UPql+NDwyz2e3HSuZOsUwXhZJ0hyMP9zC0XqeJs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=jl+acHcAnWRUVHAj9Hito6b1LjAsiBL49YA0wXH8lp6o1GHuI84cSVP5cDzvJxXKV
         cqyjofllqeP0zFa5WchrYEls+oG6ytrqd2teeqWBkLutJB2lhgxU/dGJq1e9vC0Fp+
         J8Yb8L5lcWUafduIlZwGL2bd1aF9Np5fBLsQrYWKZfmJqwHxo4S3cn4t1BBEa9/Nxr
         OA2izcbIuHrcGngybhYYiInFWm4yCtEhXHEV//KAXyb4ZxGYRZvMJaxsddk3bwFNBj
         65Aok08kQH/WTHyIkJWKxJLPxu6DkjJAqWjKwdJkUT5YzDLSmamcFqUXUsR14KSwaM
         OcKQbv83/dhLw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH -pm] docs: driver-api/thermal/intel_dptf: Include
 isonum.txt
In-Reply-To: <e06542af-aa8b-0885-37a3-bb7bc5fafa1e@gmail.com>
References: <e06542af-aa8b-0885-37a3-bb7bc5fafa1e@gmail.com>
Date:   Fri, 01 Apr 2022 08:41:04 -0600
Message-ID: <87y20oyigv.fsf@meer.lwn.net>
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

> For the "|copy|" substitution to work, need to include isonum.txt.
>
> Fixes: 16c02447f3e1 ("Documentation: thermal: DPTF Documentation")
> Reported by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> ---
> Hi,
>
> This fixes a doc build warning reported by Randy at
> https://lore.kernel.org/r/73d98132-1d08-ef29-edb7-9e062b9154b8@infradead.=
org/.
>
>         Thanks, Akira
> --
>  Documentation/driver-api/thermal/intel_dptf.rst | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/driver-api/thermal/intel_dptf.rst b/Documentat=
ion/driver-api/thermal/intel_dptf.rst
> index 96668dca753a..2df82719c5be 100644
> --- a/Documentation/driver-api/thermal/intel_dptf.rst
> +++ b/Documentation/driver-api/thermal/intel_dptf.rst
> @@ -1,5 +1,7 @@
>  .. SPDX-License-Identifier: GPL-2.0
>=20=20
> +.. include:: <isonum.txt>
> +

Interesting...I don't think that was always necessary.

I have to ask, though: is this worth it?  It adds up to a fair amount of
clutter to get one symbol - =C2=A9 - that can also just be inserted directly
if we really think we need it.  I'd vote for doing a global s/|copy|/=C2=A9/
instead.

Thanks,

jon
