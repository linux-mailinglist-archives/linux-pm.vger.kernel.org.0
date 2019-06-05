Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 225FD3549B
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 02:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfFEADT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jun 2019 20:03:19 -0400
Received: from anholt.net ([50.246.234.109]:50614 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbfFEADT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 4 Jun 2019 20:03:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 34DD110A288F;
        Tue,  4 Jun 2019 17:03:18 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id olrx2v55qpgq; Tue,  4 Jun 2019 17:03:17 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id ED6F010A1128;
        Tue,  4 Jun 2019 17:03:16 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 7398A2FE3AAE; Tue,  4 Jun 2019 17:03:16 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        stefan.wahren@i2se.com, Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     mbrugger@suse.de, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        sboyd@kernel.org, ptesarik@suse.com,
        linux-rpi-kernel@lists.infradead.org, ssuloev@orpaltech.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, linux-pm@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] clk: bcm2835: remove pllb
In-Reply-To: <20190604173223.4229-2-nsaenzjulienne@suse.de>
References: <20190604173223.4229-1-nsaenzjulienne@suse.de> <20190604173223.4229-2-nsaenzjulienne@suse.de>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/26.1 (x86_64-pc-linux-gnu)
Date:   Tue, 04 Jun 2019 17:03:16 -0700
Message-ID: <87k1e0zynv.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain

Nicolas Saenz Julienne <nsaenzjulienne@suse.de> writes:

> Raspberry Pi's firmware controls this pll, we should use the firmware
> interface to access it.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Acked-by: Eric Anholt <eric@anholt.net>

If someone ever has a non-rpi 2835 to support, they can resurrect this.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlz3BsQACgkQtdYpNtH8
nuiUNhAAuusJeKijdAnVBRXypIxS17ZxosYDMGrz1+WmREQHh631IDfVAqcMvVQt
OiXSpnJRSxZlqQt0ADMIu9khMLDekk+2k8BO5T84+86H4Hb0WIAswxV44lOeo5UR
vNqVi/tuVVudMhAunv3i8xdK+2S+jx7yQ+1mv9APcBFJ45jQfKqlIirPsJ7Eo0Sj
6yT2hutyzuhtepG1u6L8HvDYYbOoeuuNP4xh2u2z2pW1ZM4bjS89zDBsiRHOIW9l
dJhN1zTObyO1S4QbiMNobNyE+vsjBf/X5jH/wOvxioswgVmlCUSbgUtUtw8Fj4I8
wWmpprgXDWtOk8AsXE6t6IDHPv+4xZEOxR6e+ViQqfex26qq6Van0LXTO6TfC3H1
A1F+SOG0e0HgyX2Y302k06gWAIvl9b03lZ5ixZFj4mLDJxXDXaLLTezYmNj24O76
p6iAB1npEZnT0Olqw3K5Bexpj6XDdZImX0maFd+nA3Zg0W7xNqaqDialuhBmuatK
lYyER2Fr23h0LOTSMfR9tCYzZo+jFrG4/0nNGN3vCRA84XaAtQXDrNfbFR94MuHr
5MSv0HfzYrziJVjZJOaMKtbwjnNKU2RnnDuX6ZklP4ANCl70+/fvT8dgabEMFCA4
d2pwStTbLeYA6b9MkZfyX6e5cO9b4VWvnhShEotiecpMfU0LC9o=
=UhPx
-----END PGP SIGNATURE-----
--=-=-=--
