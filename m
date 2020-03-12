Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 377B51839CA
	for <lists+linux-pm@lfdr.de>; Thu, 12 Mar 2020 20:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgCLTsX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Mar 2020 15:48:23 -0400
Received: from 7.mo2.mail-out.ovh.net ([188.165.48.182]:54747 "EHLO
        7.mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLTsX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Mar 2020 15:48:23 -0400
X-Greylist: delayed 2383 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Mar 2020 15:48:22 EDT
Received: from player773.ha.ovh.net (unknown [10.110.171.30])
        by mo2.mail-out.ovh.net (Postfix) with ESMTP id 4C7531C7FC1
        for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2020 20:08:38 +0100 (CET)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player773.ha.ovh.net (Postfix) with ESMTPSA id D68D6107269FC;
        Thu, 12 Mar 2020 19:08:31 +0000 (UTC)
Date:   Thu, 12 Mar 2020 20:08:30 +0100
From:   Stephen Kitt <steve@sk2.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: power/pm_qos_interface.rst: fix list
Message-ID: <20200312200830.355dcb7e@heffalump.sk2.org>
In-Reply-To: <20200312181925.1373195-1-steve@sk2.org>
References: <20200312181925.1373195-1-steve@sk2.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/ozT.y3x1WJF3zq_GrP9pdqU"; protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 9851061236247449005
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedruddvhedguddvfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgesghdtreerredtvdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjeefrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--Sig_/ozT.y3x1WJF3zq_GrP9pdqU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Mar 2020 19:19:25 +0100, Stephen Kitt <steve@sk2.org> wrote:
> This adds a missing separator before a numbered list, fixing
>=20
> 	Documentation/power/pm_qos_interface.rst:12: WARNING: Unexpected
> indentation.

... which is already fixed in linux-next, so please ignore this.

Regards,

Stephen

--Sig_/ozT.y3x1WJF3zq_GrP9pdqU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAl5qiK4ACgkQgNMC9Yht
g5x8+w/9HVlg8qkEE8BKdlwrD+4MGgBiAMH+MG7OtLLlFxAfz/qOvSQuml2+ax3c
K8d8ZrXgCuLWEltJRIKAhP+tBaacdlBreG0ovZMRLyejh/y9x0yJ28uf7GWcRzj0
L1jUPT8umOkaikAqorY7hN7koNgkRRsTnP0eBHxn4Vh2j/Kma9iOGU7GSYVC5tKr
BDtEgvn97H0i3bbWyr9Ve06IXVlqjca6Jl4+PxImbsCqYhlkLkBqS0jSvdVOSUVz
AfQf5nldnCHmZZ+FKQa6BFeEtYJJVorwoWHLiNlt0UeAfWultRL9zUEZokjR9iWK
ItBOoSWSEUjJB8KQMoecoZrR3i1s3HyycPKw9GjSHewFSup30aV10LeusoKpvTH7
bg0xrt/WNZWzvMyMt2pnIG2yExxh5uRvkWUKfe86w9ZNSen3YVgOq21o9S0SwB9e
Vxl6eW2VQ2eTpb8u9hXAodJPznZAI6a0S/zt4EMZRWkfQ/nCrcrz1KUIrNOjrzK6
U/qzWG0xNnMdC6JW5nPkhEXVGq9Z8ySaNbaCV+nPcy8F7SE7e06M8ZkUqeGL/hxB
jG+4KA5ltYf7DVHZJQ002I0CKCFNflHgm4CSS/7R4cZe7h3soays9aFbQuvHfeC4
umz78pxgviXAlDQR3um4zOELVhYmylgGCSJWN/ToPl0zRot/QwU=
=0+qz
-----END PGP SIGNATURE-----

--Sig_/ozT.y3x1WJF3zq_GrP9pdqU--
