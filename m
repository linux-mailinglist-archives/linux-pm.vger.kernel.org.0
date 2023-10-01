Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA8E7B488E
	for <lists+linux-pm@lfdr.de>; Sun,  1 Oct 2023 18:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbjJAQKF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Oct 2023 12:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235155AbjJAQKE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Oct 2023 12:10:04 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1FAD3
        for <linux-pm@vger.kernel.org>; Sun,  1 Oct 2023 09:10:00 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2DF00FF803;
        Sun,  1 Oct 2023 16:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696176599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nTM/Nsc3zOjLn8S1kvg5RlsrwD8UzfKMMLDfqdH1DLc=;
        b=bmEc0aylr3Q5KbUQMbb58tQbRE5W+fITmbO8xvRMEKzNmDwJDjjP9Z09PIIC+KgoKU1aNa
        phKICrL+YGkAkCe4r4HgrDWNsR9mgo2QlEwDqNZkhBLNe8xKEp00Ifh1M0pFfwmySF0daZ
        6eLZv75A34GOsBznfCrpeDzfPn6+NWwK4ZUCsKuVaBQzdIR6SR84yRWiFGMVsInS5yfXae
        hNGx1zzO2JHtNomVxaJyMZj2JIWjh2AOqzQTA2xDx1fOaYJqewrIVHeIJG7ELOKPBDB4Uj
        gwY3VfBSOR53t2N40psoX5fW9QH8EVbJWtwW9vkPAyz5lSSyeNmiRYS/f/5TsA==
Date:   Sun, 1 Oct 2023 18:09:56 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 02/31] thermal: armada: Convert to platform remove
 callback returning void
Message-ID: <20231001180956.76c12807@xps-13>
In-Reply-To: <20230927193736.2236447-3-u.kleine-koenig@pengutronix.de>
References: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
        <20230927193736.2236447-3-u.kleine-koenig@pengutronix.de>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Uwe,

u.kleine-koenig@pengutronix.de wrote on Wed, 27 Sep 2023 21:37:07 +0200:

> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
>=20
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>=20
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
