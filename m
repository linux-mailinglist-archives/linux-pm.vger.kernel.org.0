Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFAF7409B19
	for <lists+linux-pm@lfdr.de>; Mon, 13 Sep 2021 19:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244730AbhIMRmb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Sep 2021 13:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245147AbhIMRmV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Sep 2021 13:42:21 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A9CC061788
        for <linux-pm@vger.kernel.org>; Mon, 13 Sep 2021 10:40:16 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id j16so9563836pfc.2
        for <linux-pm@vger.kernel.org>; Mon, 13 Sep 2021 10:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3HEy5QOgGPe7wcN+0QN1kQCAYQBdydFgWiZKsBhUq28=;
        b=CGOa3+4GGEptXc5PuDypeXAJI1wCrXyFgv1bZ7SzsR2e0wRoJ+lRY43NE5RFGIONdU
         P2uH+Aoqmj5+JsSEcVIHiFpbMrN8dKJI9TwDjXsP8avbRxg0Lte9Yh3JzGGqZpWh/Vo5
         SiZyjWUC4YUkKqDwN6hcH+axujIJpevQ0800RHChLornVsanxXmQYz2qiyOEFxwp20Ip
         dqkfgcitS22ja77/SLdJRimQnrQBAhNYTqALRVgxqQA6CWVd8NDt69OYMjDXc8xWdNZI
         ScyKGl06XeZHUDAErsIDgN/8hYTejuzv9Dv6kTMwfFvQgM5Pi1mXIhbjRN5/5Z2euwJE
         Sq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3HEy5QOgGPe7wcN+0QN1kQCAYQBdydFgWiZKsBhUq28=;
        b=3cOcyJPMQ/eHgtWIJxpk8eCV+ooYAbX/r3Gne5HyiaeJEEYv3aTOSRB5aDMx/GbhH2
         Lz/6CuazKT3EPQgLrksaVBASL4feF5JyC978CSfqx5nepk7V2D6d4c490sw6SEUNJ45U
         hQSZRaWRXL9KKYYgOsHpR1LVmx6RJ7/rQcm4aVQijB2K+7chDvUN3ebQjPS7Zs7R7aBn
         HGcvtB0+qxQ6lVGkwTNypCFkcZYBFVBdDqrzl+Q24jtE6ejAUR/eK1M+kukWNJkwMmQY
         ABLMv1SPKV+lJHH/ndEHu8EmGl7eVeEI90UPRW83F43ruM6pAXcpyVAhfMy5RCp6DBgR
         CQqg==
X-Gm-Message-State: AOAM531vkavWOc+A18vmNwWudMsWhUeqLJXbMHnS8nuLU7GFVGiKPD8S
        hHQx5a57cxYH6rK8FXc1sJvSCQ==
X-Google-Smtp-Source: ABdhPJzplap2wM1xXtls7hv4RBUuLjRyQPqQmr853ZxQxFS6tGGDbMoM6OqA0Ris0HKrE58H5OdfRw==
X-Received: by 2002:a62:16c8:0:b0:43d:d6b8:f38 with SMTP id 191-20020a6216c8000000b0043dd6b80f38mr643872pfw.9.1631554815226;
        Mon, 13 Sep 2021 10:40:15 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:7b92:14a1:4f7c:6560])
        by smtp.gmail.com with ESMTPSA id z131sm7936638pfc.159.2021.09.13.10.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 10:40:14 -0700 (PDT)
Date:   Mon, 13 Sep 2021 10:40:08 -0700
From:   Benson Leung <bleung@google.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-pm@vger.kernel.org, bleung@chromium.org, badhri@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC PATCH 2/3] power: supply: Add support for PDOs props
Message-ID: <YT+M+CSyWYj1eqNZ@google.com>
References: <20210902213500.3795948-1-pmalani@chromium.org>
 <20210902213500.3795948-3-pmalani@chromium.org>
 <YT9SYMAnOCTWGi5P@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SbCgKMEoeM84Kils"
Content-Disposition: inline
In-Reply-To: <YT9SYMAnOCTWGi5P@kuha.fi.intel.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--SbCgKMEoeM84Kils
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Heikki,

On Mon, Sep 13, 2021 at 04:30:08PM +0300, Heikki Krogerus wrote:
> My plan is to register a separate power supply for each PDO. So for
> every source PDO and every sink PDO a port has in its capabilities,
> you'll have a separate power supply registered, and the same for the
> partner when it's connected. With every connection there should always
> be one active (online) source psy and active sink psy (if the port is
> source, one of the port's source psys will be active and the partner
> will have the active sink psy, or vise versa - depending on the role).
>=20
> Each PDO represents a "Power Supply" so to me that approach just
> makes the most sense. It will require a bit of work in kernel, however
> in user space it should mean that we only have a single new attribute
> file for the power supplies named "pdo" that returns a single PDO.

There's a few downsides to this approach (one psy for each pdo).

The PDOs returned by Source Capabilities and Sink Capabilities do not just
contain possible Voltage, Current, and Power combinations, but they also co=
ntain
additional information in the form of properties.

In the Fixed Supply PDO, the following bits convey information about the su=
pply
or sink (See USB PD Spec R3.1 V1.0 Table 6-9):

* B29 - Dual-Role Power
* B28 - USB Suspend Supported
* B27 - Unconstrained Power
* B26 - USB Communications Capable
* B25 - Dual-Role Data
* B24 - Unchunked Extended Messages Supported
* B23 - EPR Mode Capable

These bits exist in every single 32-bit Fixed Supply PDO, however,=20
Section 6.4.1.2.2 requires that they be appropriately set in the vSafe5V Fi=
xed
PDO (which is required for all sources and sinks), and set to 0 in all other
PDOs in the caps.

> Since all USB Providers support vSafe5V, the required vSafe5V Fixed Supply
> Power Data Object is also used to convey additional information that is
> returned in bits 29 through 25. All other Fixed Supply Power Data Objects
> Shall set bits 29=E2=80=A622 to zero.

So, splitting out a particular port partner or port's PDOs into individual
power supplies runs the risk of the information above not properly being
attributed to the actual power supply.

For example, if you're connected to a 18W power supply that has a vSafe5V P=
DO,
and a 9V Fixed PDO, and you're operating at 18W, the 9V Fixed PDO will be A=
ctive
but the inactive vSafe5V PDO has information in those higher order bits that
remain relevant.

Just something to keep in mind.
>=20
> Let me know if you guys see any obvious problems with the idea.
> Otherwise, that is how we really need to do this. That will make
> things much more clear in user space. I have a feeling it will make
> things easier in kernel as well in the long run.
>=20
> Adding Adam and Guenter. It would be good if you guys could comment
> the idea as well.

I'm supportive of using a separate PSY to represent the different power rol=
es
of a particular port and port-partner, however. If you're connected to a US=
B-C
power bank, you should see two objects for that partner, one for when the
power bank is in source role, and one when the power bank is in sink role.

Even when you're in one role or the other, you should still be able to read
information from the other role in order to make an informed decision wheth=
er
you want to power role swap.

Thanks so much!
Benson

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--SbCgKMEoeM84Kils
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCYT+M+AAKCRBzbaomhzOw
woiuAP98EOxvnyM8s0sjMr4L7+xT/HIE8zBgWBc1Hc9K19iKDQD+KguqhT0F6CQW
m/3+6GMzrNmx9TGeLNsp/9IcjhOZGw0=
=sfGH
-----END PGP SIGNATURE-----

--SbCgKMEoeM84Kils--
