Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF412519DF
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 15:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgHYNgQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 09:36:16 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:52193 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725998AbgHYNgH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2020 09:36:07 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 430D8CB7;
        Tue, 25 Aug 2020 09:36:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 25 Aug 2020 09:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=7A7IyNQAX4KGw2bi0hCwk/gNt7/
        v19Lp9o3x4DENAWI=; b=XFK78CQlOrY04Z0f4pm6PsGxK52trgYd4RzZAi7cc4x
        ZuD/l9TkbBAwWP33ZgkIyr6uPNAjmvtEUW3HwC+E+90KIFNUiL4WYB3M7UAcAKF0
        xlPT7O0ddPJrwtxbFviVBMbgl7dW9ifKII41zXLoAVWg3XZJhS/MCtMVzdGmTkTX
        y+jsQT5cETKWRWBGuQEBWVDGHrsg8VWobYmXUzi7O00hKzJk//7E0h9+i9GSzOAM
        2HjHLro5ekq3plgB1/+V+85hiitsEhSDUibKQxWRP/LHJv47RAW1u80qCdt+L+6W
        zLAEuLcIQlL5XLS+n71gKwvPXLlqb0sUtBjFd6Dz52A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=7A7IyN
        QAX4KGw2bi0hCwk/gNt7/v19Lp9o3x4DENAWI=; b=K5CKLmlHcw71nJDgSpEpt9
        TxGws8VwIjUuXZPHQBZPx4mZ1aK2iePGVrx4MweA5sGaCKn6l5zaxpMmUn/jdh1L
        MT0ZIGKiwbeugKQ2LH+iZ5T7O+qJDilCC5pGZ3/3+DtZATdXHkWLOI/dh3H5D1dw
        0WvYLIpE3pALi7SOipu9ZfW+axc5DL9BDJiR4bn9AUWcGBxuHZ7dagtH07H1QHBf
        VgAPWUqtTAERLFwq//BuGGutk49rl7qKHk/9pUVRX1gQVEoxmyTLfGXTcHaz2Cr+
        xPr9YAqzQa7Z2UqBsaKliv8QAW7HCaleK9VbcpXDA9oxfBVoUnMIc6ILKcTR70UA
        ==
X-ME-Sender: <xms:xRNFXwRDLUTPQe1yntKB0lzccEDs3t6Fewy_jHeErf4oi8XhYKMJIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddvtddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudegne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:xRNFX9w8ITlfwAeNHwfowmVw101nfaknpJcwaXcPjHKNfEgsHTxWBQ>
    <xmx:xRNFX93pBAqQJpVcrkfN2NE72QaKP7d_6WO-MjAysKsSzjxEbwsIdw>
    <xmx:xRNFX0CN0zAkfS4ytkZDicgncFSDB2vm78Zm0fzN9MfxzvrtXls2zw>
    <xmx:xRNFX-ZQ8M9Xa8WWzjpZ182TYRGqyXWBBrLzAAOEXmEKudq9Z4PiK_7V3E0>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7B7A43280059;
        Tue, 25 Aug 2020 09:36:05 -0400 (EDT)
Date:   Tue, 25 Aug 2020 10:46:10 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Frank Lee <frank@allwinnertech.com>
Cc:     anarsoul@gmail.com, tiny.windzz@gmail.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        robh+dt@kernel.org, wens@csie.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, huangshuosheng@allwinnertech.com,
        liyong@allwinnertech.com
Subject: Re: [PATCH v5 08/16] thermal: sun8i: add TEMP_CALIB_MASK for
 calibration data in sun50i_h6_ths_calibrate
Message-ID: <20200825084610.s4wfrdcix46ngztc@gilmour.lan>
References: <cover.1595572867.git.frank@allwinnertech.com>
 <dcf98648c16aff7649ff82438bfce6caae3e176f.1595572867.git.frank@allwinnertech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="amb66d7k4sp7gd6t"
Content-Disposition: inline
In-Reply-To: <dcf98648c16aff7649ff82438bfce6caae3e176f.1595572867.git.frank@allwinnertech.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--amb66d7k4sp7gd6t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2020 at 03:11:42PM +0800, Frank Lee wrote:
> From: Yangtao Li <frank@allwinnertech.com>
>=20
> For sun50i_h6_ths_calibrate(), the data read from nvmem needs a round of
> calculation. On the other hand, the newer SOC may store other data in
> the space other than 12bit sensor data. Add mask operation to read data
> to avoid conversion error.
>=20
> Signed-off-by: Yangtao Li <frank@allwinnertech.com>

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--amb66d7k4sp7gd6t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX0TP0gAKCRDj7w1vZxhR
xccQAP9CCPtCw7TtG7p625fxJ0FYNYrLiEl6trsuXgmQC1WKygD/baMZswGDFigJ
KpxCgoleFdIJu2WpLSR+zOzbvULctAw=
=p4tr
-----END PGP SIGNATURE-----

--amb66d7k4sp7gd6t--
