Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A877B3104
	for <lists+linux-pm@lfdr.de>; Fri, 29 Sep 2023 13:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjI2LGR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 29 Sep 2023 07:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2LGQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Sep 2023 07:06:16 -0400
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F438199
        for <linux-pm@vger.kernel.org>; Fri, 29 Sep 2023 04:06:14 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-57ddba5ba84so501297eaf.0
        for <linux-pm@vger.kernel.org>; Fri, 29 Sep 2023 04:06:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695985574; x=1696590374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eXfAf5K3soRpBRm4siYV07qIpnEuTmFZ/fmri8xNbS0=;
        b=eE6l7spgxrtHS9hm/I33rmmfSa6f1jNh0ZhIuXSWbqdIwJ2pIEPBOBtxLsCjIvzHSw
         VjoCeVvjorQIaJAk7CulCN+a89EcEQREZfZuPOsh+0UGyARxhO4SBmtdMg+ZwHVETskS
         AwQp8vxY2LW8nsqkLV9wFYKwvnaW0/jAictyxnR7Ra1QzOR6sGF6mTOim+cWtftxEo1Q
         1OL3gNUIIMwsCw+Ct71OAbG0+REb3D1HH5mR3yGJUiQs2eftFz0+AbvDhoEOiPHN2lQn
         FZuiRRJuDxmO3xK+nNfOgdaKP5BtM0x4J7bAHGO5Rje0N9UuXhrGO8WoSSSvYXAZczSV
         9VKA==
X-Gm-Message-State: AOJu0YyF8GWQIzOQ+lCgCv705whe44zK6ZxVkoAj0aM9ry3KB872tjRh
        V2R9iMIoGOyvOx4V5L7mo42LlTEA/zju0H5tvtoRAsjEqR4=
X-Google-Smtp-Source: AGHT+IHnjMQf4TcIXqCYxJb3MiiDMpkfJS1bbFz8BdVVdymPezpCAoDu2EEE46tvAJIh66O1sFSg8v/jwiHNHZ+/gT0=
X-Received: by 2002:a05:6820:3c1:b0:57c:6e35:251e with SMTP id
 s1-20020a05682003c100b0057c6e35251emr3709817ooj.1.1695985573695; Fri, 29 Sep
 2023 04:06:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230929061305.2351953-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230929061305.2351953-1-u.kleine-koenig@pengutronix.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 29 Sep 2023 13:06:02 +0200
Message-ID: <CAJZ5v0gZa24GuaqxH2M7Br9jWzivqVdxDurZv3F0K1xRVj8e4A@mail.gmail.com>
Subject: Re: [PATCH] thermal: amlogic: Fix build failure after conversion to .remove_new()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        kernel@pengutronix.de, Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guillaume La Roque <glaroque@baylibre.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Sep 29, 2023 at 8:13 AM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
>
> Commit 88af8b66ffed ("thermal: amlogic: Convert to platform remove
> callback returning void") converted amlogic_thermal_disable() to return
> no value but missed that amlogic_thermal_suspend() makes use of the int
> returned by this function. As amlogic_thermal_disable() returned zero
> unconditionally before, add a return 0 to get the same behaviour as
> before the offending commit.
>
> Fixes: 88af8b66ffed ("thermal: amlogic: Convert to platform remove callback returning void")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202309291214.Hjn3gJ94-lkp@intel.com/
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>
> sorry for not catching that before sending. I don't understand yet what
> was wrong with my testing; I would have bet the series was tested with
> an ARCH=arm64 allmodconfig build. :-\
>
> If you prefer it, feel free to squash this patch into the offending
> commit.

Instead, I've dropped the changes in amlogic_thermal_disable() from that commit.

IMO they are not really related to it, because "remove" is not the
only caller of the above.

Thanks!
