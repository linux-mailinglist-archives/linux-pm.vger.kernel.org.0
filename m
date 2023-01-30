Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B44680B48
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jan 2023 11:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236088AbjA3KuG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Jan 2023 05:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236566AbjA3Kt6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Jan 2023 05:49:58 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A3D31E0B
        for <linux-pm@vger.kernel.org>; Mon, 30 Jan 2023 02:49:48 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id gr7so5866370ejb.5
        for <linux-pm@vger.kernel.org>; Mon, 30 Jan 2023 02:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WbYOQUl8YkiJPsrRGZ6+9JqhC6vIn/U8fqF7NQ0FW/8=;
        b=ViX+vlUGX5BaP57CJJRM376Pvt1EL0A1wuWaXke5DxqeOY5dT3bVE3rJ3XRafd6XBG
         dbvdEqnA8aId1gPMR7LYH3a5ghGC6ptgK3A1k2wZUUq5utbQlMGSSbKG+rK28UVkmzRs
         +RSMjFrFJ1uE7tsd+ZdNNuCeVOwNIVbhA8q41vulASQromkI8HCGNOkj1+jXLCfhEiKc
         5vlPnRkHj21aJwuRRWcKoHO+J/vhxcY/lDd57zjgLTzshME0qgL76XikV0t9qNA6l750
         v1AKurPoH4qEAkHWr7v/PcFyFfCtGUhXl1JmRWskH7hSgLP1gnvD1bfU9eurASGMasPc
         ZXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WbYOQUl8YkiJPsrRGZ6+9JqhC6vIn/U8fqF7NQ0FW/8=;
        b=6xWEmpcIoqDPti/Y2SYJJdEgzaLM4dHPzJz1qpzCfkJpMl2lOASvXSp3EReWsUBgHp
         NWjGY1nm4nKeQ+8UWe3+kmEj13uAl+jmOCR5k2CuGyxbMPRdqxE10yHBryd6HndAcdaP
         4fWk93TOfjByqct7n00qN2yLfjgMuk/9XnRDLo7Edu1Ynha/GsneD+a1dlmGU9MNWz2v
         Hn0i6nJJMkQHLYTJHEVG67HicAwHVNt/QlmVva4CB+qzcfTTK1FokULnRHDByuSvk979
         xazzDesp/cw0P17WkoPcgFJ0XcKNSSv7FG98a+9Dc0dVItECpOiDUlM9A24AC1EykZxb
         C7eg==
X-Gm-Message-State: AO0yUKVpgAqowbXcANqnzb2j4iRdtrVcucyvsCg1RFWPq9NzV1PGzqSf
        JssMXS29eeFzVezO69Y6l1z3hZ1kQMXMTh/LeIkOwA==
X-Google-Smtp-Source: AK7set/J7PES+ljqawMieJJRd/cu/yzPZarw9tMyMY5Jntle7Jn7XPBW+FIYQs1uClIQZVIgTGBgF92r5iwxtvN2CD8=
X-Received: by 2002:a17:906:eced:b0:878:4ea8:6c2f with SMTP id
 qt13-20020a170906eced00b008784ea86c2fmr4129189ejb.115.1675075787022; Mon, 30
 Jan 2023 02:49:47 -0800 (PST)
MIME-Version: 1.0
References: <20230124131717.128660-3-bchihi@baylibre.com> <20230126161048.94089-1-bchihi@baylibre.com>
 <2ce57abd-203f-04b9-f0de-8e524d6afaae@linaro.org> <b0b49007-7882-bb44-df26-8d2132b34bc0@linaro.org>
In-Reply-To: <b0b49007-7882-bb44-df26-8d2132b34bc0@linaro.org>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Mon, 30 Jan 2023 11:49:11 +0100
Message-ID: <CAGuA+oqL41XZ0bUDTY1xfZrhWXjFrT9aoX+nqMmXDdY7QDJ5Ow@mail.gmail.com>
Subject: Re: [PATCH v12 2/6] dt-bindings: thermal: mediatek: Add LVTS thermal
 controllers dt-binding definition
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        angelogioacchino.delregno@collabora.com, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rdunlap@infradead.org, ye.xingchen@zte.com.cn,
        p.zabel@pengutronix.de, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,

On Sat, Jan 28, 2023 at 11:50 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 27/01/2023 23:10, Daniel Lezcano wrote:
> >
> > Hi Rob,
> >
> > I think Balsam took into account your comments. Is it fine for you ?
> >
>
> The patchset was not sent to us at all, so it is the second version we
> see. Therefore it's not v12 for us. It's v2 and it still needs fixes.
>
> I replied with minor comments (which could be fixed during applying) and
> the license concern (which you rather cannot change while applying).

I apologize for forgetting to add some email addresses while sending
previous versions.
The changes you asked in your preview comment are taken in account and
ready to be sent.
Please let me know what version number should the patch have.

>
> Best regards,
> Krzysztof
>

Best regards,
Balsam
