Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C61A783EB2
	for <lists+linux-pm@lfdr.de>; Tue, 22 Aug 2023 13:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbjHVL2P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Aug 2023 07:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234178AbjHVL2P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Aug 2023 07:28:15 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA198CD1;
        Tue, 22 Aug 2023 04:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1692703693; x=1724239693;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zy+oNUnTax/2/pEu8NMMXhkiT6EE1L1FvMZzPOAdESU=;
  b=BSlOARM642jhazFoceCL9TjAzy6VAmYpTvDYumrJ2Q4yYvIi4yVoA9vH
   70OYgMuKaXEzJsSxoZ+Gnm79S9XT5yfG1oi8hUyb/PSuEErPJSy0Bx0xs
   JYTJ8vYsA3B6FOfRQUFnq7hfsLm6xVnxix7yp6ztZPlcy5PlklhYbSxue
   2K9yvuSTDtA1MGJEc2oHn492LnCHukCsRuEd1iLfwrYCRLJi5FxnOClTF
   x2v5jKOzbhF6/hRm2k45wpuopm63vodR8pmVUSE4NPzvB7fOcCrxvQHxS
   Y9ErmVV7j/0gShupMIYNiL7i9w2j0S4zsQI0ZMKnR37bQoH/PdasdocHD
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,192,1684792800"; 
   d="scan'208";a="32561792"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 22 Aug 2023 13:28:10 +0200
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 6D857280075;
        Tue, 22 Aug 2023 13:28:10 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>, linux-pm@vger.kernel.org,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        dri-devel@lists.freedesktop.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 4/6] dt-bindings: net: microchip: Allow nvmem-cell usage
Date:   Tue, 22 Aug 2023 13:28:10 +0200
Message-ID: <4855037.31r3eYUQgx@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <169263807888.1978386.16316859459152478945.robh@kernel.org>
References: <20230810144451.1459985-1-alexander.stein@ew.tq-group.com> <20230810144451.1459985-5-alexander.stein@ew.tq-group.com> <169263807888.1978386.16316859459152478945.robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Am Montag, 21. August 2023, 19:14:39 CEST schrieb Rob Herring:
> On Thu, 10 Aug 2023 16:44:49 +0200, Alexander Stein wrote:
> > MAC address can be provided by a nvmem-cell, thus allow referencing a
> > source for the address. Fixes the warning:
> > arch/arm/boot/dts/nxp/imx/imx6q-mba6a.dtb: ethernet@1: 'nvmem-cell-name=
s',
> >=20
> >  'nvmem-cells' do not match any of the regexes: 'pinctrl-[0-9]+'
> >  From schema: Documentation/devicetree/bindings/net/microchip,lan95xx.y=
aml
> >=20
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > ---
> >=20
> >  Documentation/devicetree/bindings/net/microchip,lan95xx.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks. But while reading your comment on patch 3, I'm wondering if=20
additionalProperties should be changed to unevaluatedProperties here as wel=
l.
This way local-mac-address and mac-address canbe removed as well, they are=
=20
defined in ethernet-controller.yaml already.

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


