Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5BFA6ADD04
	for <lists+linux-pm@lfdr.de>; Tue,  7 Mar 2023 12:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjCGLMx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Mar 2023 06:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjCGLLp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Mar 2023 06:11:45 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DEE4EC7
        for <linux-pm@vger.kernel.org>; Tue,  7 Mar 2023 03:10:59 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id cy23so50542753edb.12
        for <linux-pm@vger.kernel.org>; Tue, 07 Mar 2023 03:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678187457;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U6fMgeLah4uWf7JxDNW3+CyJWyyIcQsO6jtmPeeVMXE=;
        b=HXC9XxzhKSMdrTPzwjf9lq2IDksgr9rg04okGQMA7Q4ukF0ZDAxBlwI6d803C1NN5S
         PkIzeN5C2u/wrZ1vsuA2LmZU+7q8Z6WZL8Jwbc++j4jwhj1BY4vYz5bT2jmxZxUVR6+c
         GmFCfUpkNPSO2Rem5YTzz7u5hmwD4EFeFtSJyITd7ej+lzx44ZA6iP73GxUF4USlm2Ox
         UEm0cbjsaFjFe5sUSH/jkSYn2oQV/YsKRUFWbOaPtqFiKe/Z9jDJN2Xb0gL75sMRpzc0
         5eYVCJOWzbg+DFkXE2eS4qDkTqCV5b78h2YO0R6ZGSd9GrhQXHnFjxlB/SftxEQZFE5S
         ZZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678187457;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U6fMgeLah4uWf7JxDNW3+CyJWyyIcQsO6jtmPeeVMXE=;
        b=X3+NohoBXIEBbCQN8reC0HuMSgfpXEX1J4ZqzOV8eKSHLuJB3aPFamHx8KOyX+Qw2H
         UZtpTvsUGvSTRZF5RGybvLQVJpW54lG4iSp546AWEh/nNEZZ2kcwHQvJpG3TIKCxRMdv
         J3IIcLPnNtnGOtDELiOQ64SHNjvzMRzTPmFTeqNdHsnLorTTEhYKAHypv8adOBqkChaP
         EqTXnDHj4pCvdPljs65bZnz/B9x96k5rbWGvDnEM4NRanzA5GnGfrAW4RRfh8RXakQSj
         L5j60ms+G4xGbv3CVukTtjKqUeeXQCR7fhgxdo5YL0ZcDwBx1Dtrnad9SIYs0dRZij4R
         fRvw==
X-Gm-Message-State: AO0yUKWUSfYt7zKuiS/ufK/xbwEtfCgyvLYOpi2lycAajGPVNRTAZVmn
        JN8JYaye373oQxweY09SkMG2F7UN1Z/fEzWADBlwcA==
X-Google-Smtp-Source: AK7set8bWIdU0Z9WjvqcfThqe44SRQhx/Kh+doUBNgk5VvVi/rKjJ6ufHAlp/UM6cMm28XzgIpWJfxz7RAbqcEenhkY=
X-Received: by 2002:a50:aa95:0:b0:4ad:7439:cecb with SMTP id
 q21-20020a50aa95000000b004ad7439cecbmr7738574edc.7.1678187457726; Tue, 07 Mar
 2023 03:10:57 -0800 (PST)
MIME-Version: 1.0
References: <20230209105628.50294-1-bchihi@baylibre.com> <20230209105628.50294-7-bchihi@baylibre.com>
 <CAGuA+oqOgprdu0dVcmB=qJd5HJjada3d8ZazMpoG-SBPizzuPQ@mail.gmail.com>
 <80c60f09-56eb-cb84-43f0-7b055ea4b32c@collabora.com> <CAGuA+oqJVTXE5YHm6rSv4pPWsGxR8nZD-T5EM7LS9gPtdcu4HA@mail.gmail.com>
In-Reply-To: <CAGuA+oqJVTXE5YHm6rSv4pPWsGxR8nZD-T5EM7LS9gPtdcu4HA@mail.gmail.com>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Tue, 7 Mar 2023 12:10:21 +0100
Message-ID: <CAGuA+oroM1XmLTDZcFx5F+tHvbOJXUGuj8SnZnUxD56+9XAb2Q@mail.gmail.com>
Subject: Re: [PATCH v14 6/6] arm64: dts: mediatek: mt8195: Add temperature
 mitigation threshold
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     daniel.lezcano@linaro.org, rafael@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com, matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
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

Hi Matthias,

Is it time to apply those last two patches of the series "Add LVTS
Thermal Architecture"?

[v14,6/6] arm64: dts: mediatek: mt8195: Add temperature mitigation threshold
https://lore.kernel.org/all/20230209105628.50294-7-bchihi@baylibre.com/
and
[v14,5/6] arm64: dts: mediatek: mt8195: Add thermal zones and thermal nodes
https://lore.kernel.org/all/20230209105628.50294-6-bchihi@baylibre.com/

Is there anything that I could do from my side, to make it possible?

Best regards,
Balsam
