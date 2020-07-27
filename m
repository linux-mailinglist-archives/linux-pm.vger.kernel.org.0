Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE32422E852
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 11:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgG0JBi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 05:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgG0JBh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2020 05:01:37 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71594C061794;
        Mon, 27 Jul 2020 02:01:36 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id by13so11516610edb.11;
        Mon, 27 Jul 2020 02:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JzEEhJ/gSEqeIPhKBNFMdZtgXlIDSYR3vaBxjVSErS4=;
        b=ge2yrJpObzku3hqYB6XPsmzD6RqnM7NAA7SK3vvZYKMnJyN2FvALS22PctbgXQ4rW4
         Fhd6dXSA7M/DqEOdNlj/YCoU39e71s6hf5nkY1vV6amNwVXagV6r6PTawElhR88tu/go
         UVBJlRhzC2avJBCOgAHCbYA2bJi/zUlDeT2UR6hqJGwC3e4tg+FKkwsn8IPQ6iK4UYDB
         xlJPOL2XE/x99z+Tw9IFi27yjV5exR3hh5FD41SiVCMtfTfsS0wgBh+obceJ44mLHm9P
         n0fJTrymcfAtv7sJMgDdugRocPjRs+zbhIl2/B0C7ZAXklNcMCDGCN0fi0ENBTJCpOVE
         WAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JzEEhJ/gSEqeIPhKBNFMdZtgXlIDSYR3vaBxjVSErS4=;
        b=XOwde3SYPZcbS5sB7v2Lcpq2z0vbVOO4LvyoI72CCXcuWN7ljO9pJFcS6+yhEcnkuH
         bOAMJTCFW0HROvQ8LO98d3MUkbqVLDt1JZ2XREOBG8LOp2sYT5w6BKljQghx/ri1GK29
         ZINKUleAlRbiL9/XvmZryzVinQTigeX1TeBzMhhfu1sVa5+ui+pn+u8I6Wc92tlPSUHz
         oWrVMQrCEKGZ4+KmFCIwVWd/FL1x2r8C5KbA2FUqHuZqn92h4sMQ61SgRWVXcYqh8HmX
         oTK1JDBt1p4LEVG2C4akDIfz5jmoRy3lwTDWJFHTAHREVUQuCoysGi3Do4ZPD5NlKldr
         cQkg==
X-Gm-Message-State: AOAM531KOVNFBtCEt4PtV5eUg5nBeipSP9P1QAwDYht8AsIbv/YyB0tc
        MY31M2peXp6ZUVXqiRYl4nM=
X-Google-Smtp-Source: ABdhPJy+W16tLSRAorS/TKv73RktJTDc+mCgc9hEqjcQbSBZKRilv/hpRbTfXvsFNEy7zkfLJzyScg==
X-Received: by 2002:a05:6402:d0d:: with SMTP id eb13mr19567554edb.307.1595840495212;
        Mon, 27 Jul 2020 02:01:35 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id gh24sm2545269ejb.45.2020.07.27.02.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 02:01:34 -0700 (PDT)
Date:   Mon, 27 Jul 2020 11:01:33 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>, Amit Kucheria <amitk@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: Fix zone lookup by ID
Message-ID: <20200727090133.GG2781612@ulmo>
References: <20200724170105.2705467-1-thierry.reding@gmail.com>
 <db6efeab-b2bc-bad5-9c75-89e3e306256c@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="w/VI3ydZO+RcZ3Ux"
Content-Disposition: inline
In-Reply-To: <db6efeab-b2bc-bad5-9c75-89e3e306256c@linaro.org>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--w/VI3ydZO+RcZ3Ux
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2020 at 07:12:49PM +0200, Daniel Lezcano wrote:
> Hi Thierry,
>=20
> Applied, thanks for the fix!

I ran into this as I was experimenting with the new netlink interface
and got things wrong. Do you have any userspace that you use for testing
this that I can use as a reference?

I have managed to get it to work now, but I'm still interested in any
userspace that you might have for this.

Thierry

--w/VI3ydZO+RcZ3Ux
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl8el+oACgkQ3SOs138+
s6HOMg//f9Vxawx1IBVtdLfYPjp7vY5FLMOUjpu3SUKiyzjqyToDpWAsGPmBLTUJ
+uZmRHPp/tzkHG2yh9S/4EJV6dTDGi3QfxuvMM0PuYQpoPz8/20+LbNcvObHMrzi
YMYWVhWWv65KTloweACuJzok32GAITuozNi0YLZaBqnFcGm36aNHdEU9XrTRDWuH
NFnRfjwOheu83Rb3I3+maje9EpbalqW64VeRJkTU1oN2LgsrbzXxCV6bVDxOhX9i
mwPnwedDz/IqW2AO9hKsfnnjRSbLreRKv/HdVjl3IY8R49Q9uJyiNK+OgBbSo966
+IK1Idl/HXLFuGCELMgle4ggq9dEnot45+iwwp9UnoNLETP96Tdc9OQFqEBDFx5r
pHmruHxK/TNWQtca3MOKx0oIrURCiidkZR4g6wqlbmSufgNJ1lDsSO3z3Ki73Ixj
bfRNqkwma7T1Rysh+8SrmNKTuJGyUfT+6dTkqwz3+nG0xNbl1RHi1OkuZWtuJhXY
fHntFcU7tJkQMW0rN9PvIMU1Wnz0ihxTKNR911kI/dYjYIAzL7hiKI5BEdwWfIvG
3pMG2kleSq7xPqVtJzri3jUht9qdqeuSTGPzq7cb08QMKjU6MW90ASoscLZWrIR7
SCgDHqyEYPjV7SBF8+/QhSR6NkyrwuM4gEr2cm4x9DHxpeDyA7g=
=1SZ3
-----END PGP SIGNATURE-----

--w/VI3ydZO+RcZ3Ux--
