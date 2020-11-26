Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94EA92C5B3F
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 19:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404137AbgKZR7s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Nov 2020 12:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404024AbgKZR7r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Nov 2020 12:59:47 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AF7C0613D4;
        Thu, 26 Nov 2020 09:59:47 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id p8so3044062wrx.5;
        Thu, 26 Nov 2020 09:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B0eWenI3s7t4CQn2VVdRPyGmdCAqsYIZHY7BlXQhkLg=;
        b=lSd8O7Glixuod1Q43d9R0+tI131xfCWMKE7KZli2KGBQaaF+34/t9VfJa20X7oluCk
         +AyTgUc2NY8Yg3I5gUB2u68LbYogA3+LY5JEIs/3k+XuJ31efkfUtgstYW+rCTshJwCy
         +lXoSiPtK7/207ylXNAq/3IT9SfC3i8Za4PtWLuJ3S6sWJtLAFqkyAyEAfHdseEgjGxr
         ITwuxEWjZx4Mijwrlitt/ciwuQAGL+mMPkzdGMBKEY5zLMCTBJJY9/A9shmhVRXILuVI
         ZnVfp3xFPEP8FXVDJl4rvhVE/7GHww6pTtULmSNrgeX/RZu25V47tBWNym9pBGM42/u2
         cotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B0eWenI3s7t4CQn2VVdRPyGmdCAqsYIZHY7BlXQhkLg=;
        b=bUUU5jerZ9EaJo+iLQV8L+oxxjW8xuFeGWZEhOgBEb2QYXRTW+Xd0WyYcO+d7vWS1Z
         MgLSSD1GGxgqkSnqLbSLxkUyoxxDq05U/QOicdBkbt4vsGRKxHlrIkZ5Z1W69+MbKRmI
         WSRcyvczV6vYpx3iBDoOuT9NmakD0RP2DAp2ZaZSvhH6gRIuRJZTW12RNYcaWh0SesoD
         AyxrmS4i4G8NIQzgthWlrISE3iUhPOCxtSovTIAfIGO6EnkB7D7pmE6DrJ5fi1idMMSZ
         ojywqomwYsL6Sz8Q19YqRrIeo3YstbzHmqiwhkRC9uC66slupqWYjfh7hjguoWaRqpXZ
         KD9w==
X-Gm-Message-State: AOAM531CI5xV3S0a1WH0GCROt35VoLYKhrVe5GEwc2X7Wk2wLbceT/gT
        ckX5aUSa7gX2zGq+/AbNfb0=
X-Google-Smtp-Source: ABdhPJxxJVsHHrrk+eWmYQV3GlRCJJq3A28lXJ1xFeTsbZPyIjn5EFocWUgFkb0/KGIq1GPnktC2uw==
X-Received: by 2002:a5d:67c5:: with SMTP id n5mr5358207wrw.179.1606413586194;
        Thu, 26 Nov 2020 09:59:46 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id 8sm9041288wmg.28.2020.11.26.09.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 09:59:44 -0800 (PST)
Date:   Thu, 26 Nov 2020 18:59:43 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 17/47] dt-bindings: memory: tegra20: Add memory client
 IDs
Message-ID: <X7/tDybgSg6qlYc2@ulmo>
References: <20201104164923.21238-1-digetx@gmail.com>
 <20201104164923.21238-18-digetx@gmail.com>
 <X7/lLaZJNp+Vfczk@ulmo>
 <20201126173922.GA7048@kozik-lap>
 <CAJKOXPfbmvUi3uWmX=qiiBxpCK_2oTWPY1JVxiVMuiv=RtwdKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QUBNmSd1dzfaeSLX"
Content-Disposition: inline
In-Reply-To: <CAJKOXPfbmvUi3uWmX=qiiBxpCK_2oTWPY1JVxiVMuiv=RtwdKw@mail.gmail.com>
User-Agent: Mutt/2.0.2 (d9268908) (2020-11-20)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--QUBNmSd1dzfaeSLX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2020 at 06:45:51PM +0100, Krzysztof Kozlowski wrote:
> On Thu, 26 Nov 2020 at 18:39, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > On Thu, Nov 26, 2020 at 06:26:05PM +0100, Thierry Reding wrote:
> > > On Wed, Nov 04, 2020 at 07:48:53PM +0300, Dmitry Osipenko wrote:
> > > > Each memory client has unique hardware ID, add these IDs.
> > > >
> > > > Acked-by: Rob Herring <robh@kernel.org>
> > > > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > > > ---
> > > >  include/dt-bindings/memory/tegra20-mc.h | 53 +++++++++++++++++++++=
++++
> > > >  1 file changed, 53 insertions(+)
> > >
> > > Is there any chance you could drop these dt-bindings include patches
> > > (17, 18 and 19) so that I can pick them up into the Tegra tree? The
> > > device tree changes that I was going to pick up depend on this and
> > > fail to build if applied as-is.
> > >
> > > I was looking at your linux-mem-ctrl tree and had initially thought I
> > > could just pull in one of the branches to get these dependencies, but=
 it
> > > looks like the dt-bindings patches are on the for-v5.11/tegra-mc bran=
ch,
> > > which the ARM SoC maintainers wouldn't like to see me pull in for a
> > > dependency on device tree changes.
> >
> > Partially you answered here. :) Since you should not pull my branch into
> > a DT branch, you also should not put these include/dt-bindings patches
> > there.  SoC guys will complain about this as well.
> >
> > These patches are also needed for the driver, so if you take them, I
> > would need them back in a pull request. SoC folks could spot it as well
> > and point that such merge should not happen.
>=20
> It seems I was wrong - these patches are not needed for the driver
> code. Neither in applied parts nor in upcoming Dmitry's work. In such
> case I could rework my branches and send a new pull request. The
> patches would stay only in your tree.

Oh yeah, I forgot to mention that the driver doesn't actually need
these. I'll take your Acked-bys and put these three patches into the
Tegra tree, then.

Thanks,
Thierry

--QUBNmSd1dzfaeSLX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+/7QwACgkQ3SOs138+
s6HuRA/+Kp2c3GAsSyiRtTQk3qufpZ6bUlHdTsyyNxM7KEG7Ge7TFU/H6JNnUCBN
b1irx/2pmUZ9AvIlPanpffcUrCIG7OKian2XtuBlonnftQwIibcP/XKOkZ5C28jd
eTEjUHvXuTnQ2P4ZWtuuLXfpy5Ft6VFYikf8fd505YE8TbGB4NgIV8sNCUwaY9Iv
pjC/PWNY3uHGSB7ELO7j/mZYidGFtEQ7AxSZ8RCmEOP2N0cLo2d+7EMyc31fkWnk
M7i97UMxlTvzRdvKIVD2rakTGIm/+jche6zl3kL3+TqFpDWccmKvtOAtPADhpuFc
NZckjAN08u284MFzjTOlR8tGtT9Kc0Q7LHxDajm9/rF8HSiMuJGjDBYaeCmbQ+IR
48Le6IL+/aYU9OtFXmVQQjzf/gZ3GKmWeO4xcs6TejPXOAPgNj7yO0jQ2reKdZPi
KmgPqKB98ZnoYhn/FQugKcKn/7ic2WNyDGMTfFlQew4UU/ps0nXPksTVtp1ueZJg
ynXCdALnGzKDbMPiD0VnLJtToKGIkOD2iZxg4bBKpJw+Z9w2G6ZZdzkb/A9XqOt5
RjX4jeRhftN9CxnZ5f8IbbRsj4McDmM5Sj22DPSUqqDsQE3JX4HrNOR28u6UPZkB
7IFq+WjRqhE7TEPV8j1p1vwChrfjmnNgh5p55EWow2H5Jn9jBxc=
=F+up
-----END PGP SIGNATURE-----

--QUBNmSd1dzfaeSLX--
