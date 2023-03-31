Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52A96D1ECA
	for <lists+linux-pm@lfdr.de>; Fri, 31 Mar 2023 13:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjCaLMJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Mar 2023 07:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjCaLMI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 Mar 2023 07:12:08 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993F32704
        for <linux-pm@vger.kernel.org>; Fri, 31 Mar 2023 04:12:06 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id cn12so88166854edb.4
        for <linux-pm@vger.kernel.org>; Fri, 31 Mar 2023 04:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680261125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnhVEWPY3LI3WG9Svxz8cvgWKx4Gl9EpZwq0srqQMr8=;
        b=xq4n2KuvPi65onmp9ypTuv04b5ojmuuFLk/ZRJzgD/BrlBvW4YGewuAtP6VC5kbTSK
         ey80Wblfa744lKvJkqHXJZUCOjYBuBevkWPvH427nbSt1RIMmrX6zvSrtrHivxOS+PK+
         DSFbRCzORTCoUBAnZklX3646x/DVoZVTJTmH533ybteQVVjrjLzHaLxvp/ZKhNZh4eW+
         npPQxmLKAF+kM3nsEDNLzUSXafiSa0jEJ8YQXlQkIhtc1YEgc5tPC74TbBki/yS0l9w/
         jlERXEv38wD5KLwCZgIQ/mIrslbONLdwZmR56vcWt4l6mBE6umNJ4USyv5vn0BYpPGdU
         rpww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680261125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RnhVEWPY3LI3WG9Svxz8cvgWKx4Gl9EpZwq0srqQMr8=;
        b=ldpCByo1C3uANXZjExrzVa82exr7yxYTWE490Od7y2KVfH6izCfp3Sjp4YiY5uPgZg
         M8WMrNVdVSzyFBTpQzcJCBiObCXMfwDKstrLsh/JLYQOx0Jsk3eZgkqoPJ7yAIavEoM7
         St4VUySaTBXrkA31ptHhhiMyltc8KfbxPzZxg4TPhFzZBQ2MFgt5F440NArsHzTOL9p0
         oATeW6mvKapPPMQ/Tn/zDICW8ARIoAD02wqSrmylUTnXg8R3Jsz/4DA6tA7pestVG9v0
         I6CA9JeygrDuuDvuri8y7v8IUJc+9NfS+fIU9fpde2KVSqNoz11N7r4OV2OZZHs8c7wz
         g/eg==
X-Gm-Message-State: AAQBX9cLr4tWX+rdoQ0oAzF7UuF+CZQTArSy1MAxX1f+0W/dORgP43BW
        vFQtrRlxxtE2pQsSX2lZR3v3bd8VsQ/GtGxCDybOFg==
X-Google-Smtp-Source: AKy350azlQfzBnLoPq7rtYMIv00ABiMzIBIBlYFONAJZctR5m3rtXPk16+owY2z1t0tNFwozIYO4yrgn1BJTKVFHSXA=
X-Received: by 2002:a17:906:4a94:b0:947:c623:2c84 with SMTP id
 x20-20020a1709064a9400b00947c6232c84mr418421eju.2.1680261124928; Fri, 31 Mar
 2023 04:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230209105628.50294-1-bchihi@baylibre.com> <20230209105628.50294-7-bchihi@baylibre.com>
 <CAGuA+oqOgprdu0dVcmB=qJd5HJjada3d8ZazMpoG-SBPizzuPQ@mail.gmail.com>
 <80c60f09-56eb-cb84-43f0-7b055ea4b32c@collabora.com> <CAGuA+oqJVTXE5YHm6rSv4pPWsGxR8nZD-T5EM7LS9gPtdcu4HA@mail.gmail.com>
 <CAGuA+oroM1XmLTDZcFx5F+tHvbOJXUGuj8SnZnUxD56+9XAb2Q@mail.gmail.com> <a1fde974-f392-1493-b48a-b4cce05f3ea3@gmail.com>
In-Reply-To: <a1fde974-f392-1493-b48a-b4cce05f3ea3@gmail.com>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Fri, 31 Mar 2023 13:11:28 +0200
Message-ID: <CAGuA+opkB0KHm8ngf6+U_o8B91Qv4Keo2XJb4UXfJe-DainRDQ@mail.gmail.com>
Subject: Re: [PATCH v14 6/6] arm64: dts: mediatek: mt8195: Add temperature
 mitigation threshold
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        daniel.lezcano@linaro.org, rafael@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Matthias,

On Fri, Mar 31, 2023 at 12:36=E2=80=AFPM Matthias Brugger
<matthias.bgg@gmail.com> wrote:
>
>
>
> On 07/03/2023 12:10, Balsam CHIHI wrote:
> > Hi Matthias,
> >
> > Is it time to apply those last two patches of the series "Add LVTS
> > Thermal Architecture"?
> >
> > [v14,6/6] arm64: dts: mediatek: mt8195: Add temperature mitigation thre=
shold
> > https://lore.kernel.org/all/20230209105628.50294-7-bchihi@baylibre.com/
> > and
> > [v14,5/6] arm64: dts: mediatek: mt8195: Add thermal zones and thermal n=
odes
> > https://lore.kernel.org/all/20230209105628.50294-6-bchihi@baylibre.com/
> >
> > Is there anything that I could do from my side, to make it possible?
> >
>
> Both applied now. Thanks!

Great, Thank you!

Best Regards,
Balsam
