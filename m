Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5F46AA729
	for <lists+linux-pm@lfdr.de>; Sat,  4 Mar 2023 02:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjCDBLu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Mar 2023 20:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjCDBLu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Mar 2023 20:11:50 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DDF6A9FA;
        Fri,  3 Mar 2023 17:11:02 -0800 (PST)
Received: from mercury (unknown [185.254.75.29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2377E6602FA8;
        Sat,  4 Mar 2023 01:09:33 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677892173;
        bh=azvDplbHMaoh4IBoec/JRVXjJiT7wfVg7BkGadNGmdY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hs2HbpLthGtyuePn9H13JM73X+jdfzrs+djukRcdQxnlvmMTzLtW5xCqaE63EZ18d
         jx6kS6zm1ebT8jcFCD2veFYPCb25xj2FEgtp+TMBp7ynfMlj6cgTUY0R68+aUFwaG8
         GpHoKhEoFfpaXB9BR0sDoiAIIJ2B02cajE6rqB/VRkrqK61vnEmhl99VYy/ALbDd4h
         BFqvQZprERH1fRW4IW/hQVTRAyfnL1R4oP6gr2rbyrTRHea1h1Zy0OYZlBuT4StRwm
         9OnY+f1iH9w/1mz5Y2E5oEyzW2GjSZ8YgeRth6VjDcQD89loH3PRBvsEFgsGbOP/8N
         kEWN6pm34835w==
Received: by mercury (Postfix, from userid 1000)
        id DCBB910609DD; Sat,  4 Mar 2023 02:09:29 +0100 (CET)
Date:   Sat, 4 Mar 2023 02:09:29 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Jason Gerecke <killertofu@gmail.com>
Cc:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        "ping.cheng@wacom.com" <ping.cheng@wacom.com>,
        "jason.gerecke@wacom.com" <jason.gerecke@wacom.com>,
        linux-pm@vger.kernel.org
Subject: Re: "proximity" attribute for input devices
Message-ID: <c65e2dbc-c8f9-4481-85f1-4d1eb140a05f@mercury.local>
References: <MN0PR12MB6101F4408960BDB9CF63DD53E2AB9@MN0PR12MB6101.namprd12.prod.outlook.com>
 <CANRwn3Tb1JgLpCiYFZBO1+PDHWLT-yxEPQ0TQ19xGDWZR9pmoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="34dxy4kcivdpbrnl"
Content-Disposition: inline
In-Reply-To: <CANRwn3Tb1JgLpCiYFZBO1+PDHWLT-yxEPQ0TQ19xGDWZR9pmoA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--34dxy4kcivdpbrnl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 03, 2023 at 03:05:41PM -0800, Jason Gerecke wrote:
> Apologies for the delay in replying.
>=20
> First off: as an immediate action, I'm thinking of changing the Wacom
> driver to do lazy creation of the power_supply device. This would mean
> that rather than creating it at the same time as the input device, we
> would wait until we receive some kind of affirmative indication of a
> battery being present. Most Wacom peripherals report battery status in
> a "heartbeat" report that is sent every few seconds, so there wouldn't
> be much change for the typical user (just a few-second delay between
> connecting the hardware and a power_supply device being created). In
> the case of the "component" devices that are built into laptops and
> other computers, however, the battery status is only reported while
> the pen is actually in proximity. For users like you who don't own (or
> never use) a pen, this means that our driver would never create a
> power_supply device -- preventing GNOME from showing a battery that
> isn't relevant. I'm working on a patch set that does this but need a
> bit more time to finish it.
>
> That's only a partial solution, however. If a component user were to
> bring a pen into prox even just briefly, then a power_supply device
> would be created and not go away until the user reboots. The pen's
> battery status will become stale at some point in time though --
> self-discharge, use of the pen on another device, and even just simple
> irrelevance if the user hasn't used the pen in a while (do I care that
> the pen which I left at home is at 50% battery?). I agree that it
> makes sense for userspace to hide the battery after a while due to
> things like this. Are there new signals that the kernel should be
> providing to userspace (e.g. an attribute that indicates if we're in
> communication with power_supply? an attribute signaling that data
> might be stale)? Or are the signals that are already provided
> sufficient (e.g. should GNOME just hide power_supply devices that are
> in an "Unknown" state? or maybe hide power_supplies which haven't been
> updated in more than 1 hour?)

Can't you just unregister the power-supply device if there hasn't
been any heartbeat for some minutes and go back to the init state
(i.e. the one where you are waiting for a heartbeat to appear for
the first time)?

> I've added the power_supply list and maintainer for some additional
> viewpoints on the second paragraph... If there are questions about how
> the Wacom hardware and its battery reporting works, I'm happy to
> provide answers...

I think the problem you have is quite specific to the Wacom
hardware. Usually wireless devices are either connected or
disconnected and drivers unregister the battery device on
disconnect. So I think this logic belongs into Wacom specific
code and not in generic power-supply core code.

-- Sebastian

--34dxy4kcivdpbrnl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmQCmjwACgkQ2O7X88g7
+pp4hA/9HWX3RrsiIVIX00iAb9g6mQcWRNXcSKq6QN7WRA1FMd9wpTYNzaikKavd
aD7ZMOg7RU/XUgh+urTsbSoomE7gZQ1Jrt4N1isnzOM26BxaQyfAMiqo8NCo7VY6
Ldt9/YdYPqixyWoQWGkOuKx09fmgMBE1dnu0t3ShEqY60pyTt6Tk2R2wOSmWmvXs
VAe1BJ2gQxhI5yJ6VTJ2FpPL83zetTi3hT6aVpvsEbCh3RT8iG57Ubou6cZ6zNdd
d/b0BZyVJjCI0x/FfokQEQ1dqam0CjW8pQ6q8I41JWPCwSZD+ZyAmSVtY8u6CxlL
hJLQPJXOD36kksQStDN9xyuoKiMmtL6edOGukO+aWtb6toYFglDdzfjiSKZpNEzt
SVpBuq6KB/g85mzlB2glQXVsXAGbjlsMif5H7w3hKgQNCTvya1dRx9DLD9djDv0c
hTvQzt1Wn6VzZ0gfRUUf4+0Y//ss7zZqhQoIwvfsa3RARlGhNw/X/OpDqQgWy7BX
T27xsSy+P5zr28bttt4XFei6C1FiwFGPM2rl+H48yyAJXDhTXMDYntFT59m/HaSP
03aFUnVsJ2FSy6qFcV0yi9YBdTPW5gJKQgRqc4lFTOOdxV9nDqwzxAblGW40LUGU
Vh6lxyfYGhkOikZJCWpahJTuARyEVtsvj4tEzcv+bcvOgSg6ybM=
=qSbH
-----END PGP SIGNATURE-----

--34dxy4kcivdpbrnl--
