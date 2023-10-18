Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0795A7CD8B1
	for <lists+linux-pm@lfdr.de>; Wed, 18 Oct 2023 11:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjJRJ52 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Oct 2023 05:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjJRJ51 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Oct 2023 05:57:27 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88185BA
        for <linux-pm@vger.kernel.org>; Wed, 18 Oct 2023 02:57:24 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1e9fbb7d88eso3253219fac.3
        for <linux-pm@vger.kernel.org>; Wed, 18 Oct 2023 02:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1697623044; x=1698227844; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7BiiFcmmCiNj3LecX6OCrxhnQVAh1Ic9WQCeBx3SSIM=;
        b=MgI4PatRPBKA+BV6TtjvlZW95jOzTD0xTPpweUnYhlxK9oRpUWqFfk+vWrPF0gt7h0
         Thz3p9t2MpbddeXjttVi70daxziWR3pUV4Wem5A8d/xX/xOptgY0tkjceuCpdjI0bbV2
         cR3gYMgS6EMxeKQaqvLZUzk6sDkomz6bKn3QQykZuBm31GfqgLppXfgiaL/AeJp8wxCm
         HsshWKwcqsS5oP88aiAxOkWAlNaXRc72W9sMGW9NVL2AT1J1Ctr0HdmNuJo0veK6sIuo
         BDFUS4Ynzd2PBBagzZmc18/hbIlxyH3iA22rDReJHW/7D+l6sV1jstEu+SMPjJlWfr2B
         HcHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697623044; x=1698227844;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7BiiFcmmCiNj3LecX6OCrxhnQVAh1Ic9WQCeBx3SSIM=;
        b=O29C6OODuBYGKsNysLZpy0NoQjTKXAA32g+h9vX75BXicdXTpBg0OvgJk5B/KVjMFk
         8FFdQWKndPZ/Vg5m8zUyUTl4NuwFQgIWzidjZm5pvByQG1SL3SHQ2wU6A5kIt91hRXPN
         6AgjRXyIyYb8Ip7IQf7gC1Yzndi5iKh9G8wHzOlB9Bex0a9OlqSgGwlJcCR+WxKS/c0R
         ayjL3VkZXplQoQgH4/XB6jwQP+ThNjncJ7wp7bxyTHCyIkadNxzkiYuRBJ4FzDKbaUba
         g1mHlqrPnFm39jNQWGfrShp71IEC22D6BeqVhkdK6OWQyJPxI0qf/DnDXKNwIIC1PU8Q
         7y+A==
X-Gm-Message-State: AOJu0YxBjRjV0O6wvp+hF3SwaZuSPDd5XMzi77k/kKc1lJ3EgIhXLCiY
        bCYqwDaLlbJ25t/mmZpOfqieK8NI9HI6S7Oa0bwY3vTG2Gx+5OwA
X-Google-Smtp-Source: AGHT+IGgvTbYU5kAQ82x1eFJVsu/1pPvWmCD2rUCbOzwMrNjpSgu4ojXK1qUS7A/ozCqhTWYWn/CkMe98pIFz+h8TFQ=
X-Received: by 2002:a05:6870:179a:b0:1d5:8d8b:dcc with SMTP id
 r26-20020a056870179a00b001d58d8b0dccmr4682983oae.18.1697623043809; Wed, 18
 Oct 2023 02:57:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231017190545.157282-1-bero@baylibre.com> <CAGXv+5FwkBU3wfyZWWaiOgzLACfMVs4Bnu2KM4oSCUa28SzXVw@mail.gmail.com>
In-Reply-To: <CAGXv+5FwkBU3wfyZWWaiOgzLACfMVs4Bnu2KM4oSCUa28SzXVw@mail.gmail.com>
From:   =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>
Date:   Wed, 18 Oct 2023 11:57:12 +0200
Message-ID: <CAP2ifjN-z9R=HS06RYPnTrMYondrtobkoPOJDR6js=r8astKJQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] Add LVTS support for mt8192
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dunlap@infradead.org,
        e.xingchen@zte.com.cn, p.zabel@pengutronix.de,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        ames.lo@mediatek.com, rex-bc.chen@mediatek.com,
        nfraprado@collabora.com, abailon@baylibre.com,
        amergnat@baylibre.com, khilman@baylibre.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Wed, 18 Oct 2023 at 02:07, Chen-Yu Tsai <wenst@chromium.org> wrote:
>
> I see two series in my inbox and on the mailing list. Which one is the
> correct one?

They're identical except I accidentally sent them out using my private
email (that happens to be on a mail server hosted on my DSL line, so a
number of MLs drop it because of dialup blacklists) first. I resent it
using my work email when the error messages about that started
flooding my inbox. Sorry about the confusion - but code wise it
doesn't matter, v5 is v5.

ttyl
bero
