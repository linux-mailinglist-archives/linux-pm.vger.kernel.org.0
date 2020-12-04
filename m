Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A282CEC72
	for <lists+linux-pm@lfdr.de>; Fri,  4 Dec 2020 11:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387776AbgLDKrA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Dec 2020 05:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgLDKrA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Dec 2020 05:47:00 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD919C0613D1;
        Fri,  4 Dec 2020 02:46:13 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id 7so8056181ejm.0;
        Fri, 04 Dec 2020 02:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TZyqh6ptYlihraD2b1FndRpYclk9mikTkr3/jwSxY8I=;
        b=J+QfY0fDBqvQwH8IMbTR9NFnix3NYx2WQfu39bKEQ6EQcreYVG9DF5Pgvt8S+IiGwt
         YhD6106K+McI96ZwqH+9qQ1ZVvY7nWqYPLcUsaMAU0PqvXuw6DabzalMiwcz/ll0WyTh
         d0pMp8+oNzsOxDluo5+0GY2lxYACxgZbbPmpx+fGKjdEFQV0IVLjBRTIYewJoNHjy++8
         mXGZEIR8tMlCMFKcdxb1w4kGAbZalg+rnQjagHnn/aMNcGOVNdKHm16WoPrdoB9orG+n
         nm6CO7LF2ZyMt+4NNXWKJxj8dslE43cGZyOZuHl05dMesNnJQs5VceofnGxiomKn2NQ8
         fSag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TZyqh6ptYlihraD2b1FndRpYclk9mikTkr3/jwSxY8I=;
        b=sA7TgxvfG7TedlPQ1KFfKWf6rjCRMZKK3BPtaHShwTHf8Eqy/gF5HAf/Pon8Ge1P8z
         8XqVhm4ze4HJteopDr9fWl0JqV4MpqTnZ090XCpdkyrSgeuJUUPQzV0Jggk0RGoOxWuc
         x4L11T7byEKrdbprFPBkMomVzbtkq03xAKsKP8tBUr7gWO1dWtXJJFLTF3kVGmo2ZOxb
         cQzu13OY0wR2WaohxKfMcjluH1sbsOscJPYmT+YanfJPCJgvfrJ4+LpIxPSP4joBbIAt
         O9NysHjgUyoBQE/KeLfblj0BVIi6S/NvaGPzMTo5E3+IbgF/orAEO87GldWG+MOsTQLn
         vlWw==
X-Gm-Message-State: AOAM531TGjqdvK7ZkALdI1S68LYAMQm2UL3UYzciVLCSSBdCK4aW9rjO
        SL/GiFUuPZ8o6+YVYnbCUjY=
X-Google-Smtp-Source: ABdhPJzgG4ZQ33plbJ6DmN3bKD2NZhx4EP0JVX5IICKTKOosmqc9iUbg7S5aC5sJa3sMJopaEfIXIg==
X-Received: by 2002:a17:906:74c1:: with SMTP id z1mr6692642ejl.182.1607078772351;
        Fri, 04 Dec 2020 02:46:12 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id lc18sm2826034ejb.77.2020.12.04.02.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 02:46:10 -0800 (PST)
Date:   Fri, 4 Dec 2020 11:46:09 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] driver core: Reorder devices on successful probe
Message-ID: <X8oTcS9vManhNH1n@ulmo>
References: <20201203175756.1405564-1-thierry.reding@gmail.com>
 <CAJZ5v0g_FC6Pikrvk2PK=XMvAwqjaNOcYXHYS6eqv6Zc0JgqNQ@mail.gmail.com>
 <CAGETcx9wrKNfvV36v1YJLa_A8jtb6OvZRMjsNG9AYxLPDvdpgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IWeSzFgMjGsB0/Jx"
Content-Disposition: inline
In-Reply-To: <CAGETcx9wrKNfvV36v1YJLa_A8jtb6OvZRMjsNG9AYxLPDvdpgQ@mail.gmail.com>
User-Agent: Mutt/2.0.2 (d9268908) (2020-11-20)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--IWeSzFgMjGsB0/Jx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 03, 2020 at 11:19:11AM -0800, Saravana Kannan wrote:
> On Thu, Dec 3, 2020 at 10:17 AM Rafael J. Wysocki <rafael@kernel.org> wro=
te:
> >
> > On Thu, Dec 3, 2020 at 6:58 PM Thierry Reding <thierry.reding@gmail.com=
> wrote:
> > >
> > > From: Thierry Reding <treding@nvidia.com>
> > >
> > > Device drivers usually depend on the fact that the devices that they
> > > control are suspended in the same order that they were probed in. In
> > > most cases this is already guaranteed via deferred probe.
> > >
> > > However, there's one case where this can still break: if a device is
> > > instantiated before a dependency (for example if it appears before the
> > > dependency in device tree) but gets probed only after the dependency =
is
> > > probed. Instantiation order would cause the dependency to get probed
> > > later, in which case probe of the original device would be deferred a=
nd
> > > the suspend/resume queue would get reordered properly. However, if the
> > > dependency is provided by a built-in driver and the device depending =
on
> > > that driver is controlled by a loadable module, which may only get
> > > loaded after the root filesystem has become available, we can be faced
> > > with a situation where the probe order ends up being different from t=
he
> > > suspend/resume order.
> > >
> > > One example where this happens is on Tegra186, where the ACONNECT is
> > > listed very early in device tree (sorted by unit-address) and depends=
 on
> > > BPMP (listed very late because it has no unit-address) for power doma=
ins
> > > and clocks/resets. If the ACONNECT driver is built-in, there is no
> > > problem because it will be probed before BPMP, causing a probe deferr=
al
> > > and that in turn reorders the suspend/resume queue. However, if built=
 as
> > > a module, it will end up being probed after BPMP, and therefore not
> > > result in a probe deferral, and therefore the suspend/resume queue wi=
ll
> > > stay in the instantiation order. This in turn causes problems because
> > > ACONNECT will be resumed before BPMP, which will result in a hang
> > > because the ACONNECT's power domain cannot be powered on as long as t=
he
> > > BPMP is still suspended.
> > >
> > > Fix this by always reordering devices on successful probe. This ensur=
es
> > > that the suspend/resume queue is always in probe order and hence meets
> > > the natural expectations of drivers vs. their dependencies.
> > >
> > > Reported-by: Jonathan Hunter <jonathanh@nvidia.com>
> > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> >
> > Saravana had submitted a very similar patch (I don't have a pointer to
> > that one though) and I was against it at that time due to
> > overhead-related concerns.  There still are some, but maybe that
> > doesn't matter in practice.
>=20
> Yeah, it's a very similar patch but I also suggested deleting the
> reorder done in the deferred probe code (I'm pretty sure we can drop
> it). Here's the thread:
> https://lore.kernel.org/lkml/20200625032430.152447-1-saravanak@google.com/

Yeah, I was thinking about that as well and I agree with your assessment
that this should no longer be necessary after this patch. Any device
that would've gotten reordered by a deferred probe should now get
reordered after successful probe as well. The ordering of the DPM list
may not end up being exactly the same, but at least it should be from a
functional point of view.

I didn't want to roll these changes all into one so that we could first
make sure that this change itself works and then at a later time we
could remove the deferred probe reordering incrementally to validate
that we really no longer need it.

But thinking about it, it might be worth making these changes all at
once, so that when we break things we break them once instead of
potentially twice.

> Btw, I've been wondering about this recently. Do we even need
> device_pm_move_to_tail() to do the recursive thing once we do "add
> device to end of list when added" + "move probed devices to the end
> after probe" thing here? Doesn't this guarantee that none of the
> consumers can come before the supplier in the dpm list?

I think we still at least need to reorder the children recursively, but
I'm pretty sure we could also drop the reordering of consumer device
links because, yes, every consumer should defer probe if the provider
hasn't been probed yet, which in turn would cause the consumer to get
sorted into the right position in the DPM queue after its successful
probe.

Thierry

--IWeSzFgMjGsB0/Jx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl/KE20ACgkQ3SOs138+
s6FY2w/+KfnnfH/20hfPqZ8Bh6SpeXb+3eoc9ah5S+EOwVGa4hqpp1EeIEk2ZES9
6U5z/IDKgpX0qK3mwuRhneWP4Lz7R/dHjuRlH828/zJ8ucEOCyTk2zcRsVGDJi1Z
b7ICRZaDc0+Ym2tCBl+1fwWXXfmMruKXKP/JnH3PNUroc4pFzcp4kiekVLCUtAa0
ABpeJ0B6iIy6oqNaRAfFM7Dd4ZfYWjBRbiLt/xTqxJhYxoC+brodetlrL4oLQtU9
B4xxl0ECZlnFP94n07fRDD138x3edtCpZmReVoFf9fc1pUsH+NbDQOG0/+dscdo8
4aOfNi8VrMzEsJca4vZqbCiAJ/avx4N5pgaJjWmlrxFZChi38LUaE9FuZwxrb8sI
lfbN4+hvPaIvBjmLT9GI7EopDg8CqjVGQRUWHeIVUjNbonPVIzdp4qVWUtZwMkGs
QJ4l9OUN/bnRguK5V5ET19GOy8XBXrQZoUcOJVmHV0r0K+lnwklwjnTwUAUAxzLx
iGoQDzAp+LSECkac1dc9MyOV0prz8OYNtJ2Jg9Cf/bDyQceerzL+e9FFba+rGSEa
/rKgeAVJAduYVioKPnBAuq/ipXrPCvQzGbk6FJ/wz+Oq/CAsrGOkGuzGjr1MqvXg
XY4GVzno5mNGkWZQ3Fr3PKH2s/6Wu98pR+f8GuXsk9p1fypQHD0=
=HyxY
-----END PGP SIGNATURE-----

--IWeSzFgMjGsB0/Jx--
