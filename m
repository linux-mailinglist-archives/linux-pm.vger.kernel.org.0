Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E25DD2F72D1
	for <lists+linux-pm@lfdr.de>; Fri, 15 Jan 2021 07:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbhAOGUP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Jan 2021 01:20:15 -0500
Received: from mail2.protonmail.ch ([185.70.40.22]:60060 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbhAOGUP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jan 2021 01:20:15 -0500
Date:   Fri, 15 Jan 2021 06:19:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1610691573;
        bh=MMAL5Kui+vVOjSc+zW3syAP1NEdjBqjVan7pfvyQkw4=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=PioXalzsNQh9fZk+GHvLgr527n281L2QYgFXV7MI95OYX2HB0ONxk1fAb5dq4r9WA
         BrXiKejeXBoX2tlA78NXM+SVkadjyGJLLmw8oOyfa42O/T+ahM+bzCTb0ew4Vyzd/t
         zt8m9dHUBEd2iu1EZHRhwHW3JZXHKcBfhGGngAV8=
To:     Mark Brown <broonie@kernel.org>
From:   Timon Baetz <timon.baetz@protonmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Reply-To: Timon Baetz <timon.baetz@protonmail.com>
Subject: Re: [PATCH v6 2/8] regulator: dt-bindings: Document max8997-pmic nodes
Message-ID: <20210115071914.0407a928.timon.baetz@protonmail.com>
In-Reply-To: <20210108161653.GA4554@sirena.org.uk>
References: <20201230205139.1812366-1-timon.baetz@protonmail.com> <20210104181825.GB27043@kozik-lap> <20210104182734.GH5645@sirena.org.uk> <20210104183821.GA29033@kozik-lap> <20210104212449.GJ5645@sirena.org.uk> <20210105165529.GB20401@kozik-lap> <20210106145931.GE4752@sirena.org.uk> <20210108161635.1b9303c8.timon.baetz@protonmail.com> <20210108161653.GA4554@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 8 Jan 2021 16:16:53 +0000, Mark Brown wrote:
> On Fri, Jan 08, 2021 at 03:16:48PM +0000, Timon Baetz wrote:
>=20
> > Muic needs a node to be used with extcon_get_edev_by_phandle().
> > Charger needs a node to reference a regulator. =20
>=20
> The pattern is to use the parent device's node.

So is extcon going to be a self-reference then?

Just for my understanding: I can see sub-nodes for MFD all over the
place. It is still not clear to me why sub-nodes aren't the right
choice in this specific case?

Thanks for the feedback,
Timon

