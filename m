Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B61672007
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jan 2023 15:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjAROqg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Jan 2023 09:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbjAROqP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Jan 2023 09:46:15 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC5C5DC0D
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 06:38:31 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id s21so5674322edi.12
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 06:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bNS6eiGHbygAPEjwKzCdhJHEUCYd2KE+a83PDdTHehk=;
        b=XQz8nBzO6ssc0BhM0mHTU4Ee9cGY/nEF9rDFzsVgIw1SJeNYIigeUYr5c/RHFjCQh3
         mO6Yh0EoHw5NR/lWgI3NGtZbHwUvAg5KiyAOOv00OT0yLA/ajYqJ++jHEkg/pc+zO81S
         cf9EBiXWpLP2i2JYAg4pjh8Lca2+9gxAvzIu2TgJg0f/k6F8n6IIAmoyHqKygdtUmjza
         C1tqTtmh7MfSy86n8BMT1bXOt2Yl3cfkCDwdbe4AJifEZMfhC3bnpwXSeWfgnozVGO6g
         3AlrVRnuntM6C8rMVDq51hACHSIot1L4aOPESjBWD/tRxsawdKZtBQx5p4ubeqyyQ3oE
         ek6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bNS6eiGHbygAPEjwKzCdhJHEUCYd2KE+a83PDdTHehk=;
        b=kGMOF77Njexz0Bm8oJVOIgn8G6AhbO7zLrC/m3i5eqGRNKzv9f8oynzlkKsrx5QKRu
         FIUVCtzFKbSMJ+PKXjo36ktVjyse4UW/zcSENVmkoekjvpa8GyR0DfXcK8SkS1sU39Of
         TRVx/eXTTOY+6ySNvW/HQDJq1DxaaudpPNL83YQmjqmaKlqOh2RBg2CgLwr5tCNsjjwC
         1rRZv6ghtv5Kg1T+4tJYkp5Q5FvsqNQ7dD3zoaiUcNr4xIPqD8DESlY4WflLv0E6hDUT
         cU3/u7oPmYIUI3CbmTPa8JDf1LtOxru+LeJw+9I1LrQCaOlSsjaNqKntaZxopvHaTzda
         WnMQ==
X-Gm-Message-State: AFqh2kqu3l22BkcjOm7l4ETb8lqp7WvGAFeoOIaTtzRxH/BkaaiRpTz5
        Er7uAjRUITSMulQGZaj9MBwwvV+vEmTA9cZlsScJSw==
X-Google-Smtp-Source: AMrXdXvD7QlyuufONbPUVTnt/WaVr7FKTorLy3QtyD7HO+AvLys9OISk72Se8sYBY5zkCe52Ol3FTyondDwwMfQ4Gj8=
X-Received: by 2002:a05:6402:1:b0:498:dfe5:49aa with SMTP id
 d1-20020a056402000100b00498dfe549aamr561038edu.398.1674052710126; Wed, 18 Jan
 2023 06:38:30 -0800 (PST)
MIME-Version: 1.0
References: <20230112152855.216072-1-bchihi@baylibre.com> <20230112152855.216072-5-bchihi@baylibre.com>
 <feab4ff4-b874-aa10-2031-ad6b84cbc004@collabora.com>
In-Reply-To: <feab4ff4-b874-aa10-2031-ad6b84cbc004@collabora.com>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Wed, 18 Jan 2023 15:37:54 +0100
Message-ID: <CAGuA+oo5HcVNoCvDxjHhxZnRc5o19V6iXPe4kBPiA8rTHBoAAA@mail.gmail.com>
Subject: Re: [PATCH v10 4/6] thermal/drivers/mediatek: Add the Low Voltage
 Thermal Sensor driver
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     daniel.lezcano@linaro.org, rafael@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sorry for forgetting this comment.

> > +static int lvts_ctrl_initialize(struct device *dev, struct lvts_ctrl *lvts_ctrl)
> > +{
> > +     /*
> > +      * Write device mask: 0xC1030000
> > +      */
> > +     u32 cmds[] = {
> > +             0xC1030E01, 0xC1030CFC, 0xC1030A8C, 0xC103098D, 0xC10308F1,
> > +             0xC10307A6, 0xC10306B8, 0xC1030500, 0xC1030420, 0xC1030300,
> > +             0xC1030030, 0xC10300F6, 0xC1030050, 0xC1030060, 0xC10300AC,
> > +             0xC10300FC, 0xC103009D, 0xC10300F1, 0xC10300E1
> > +     };
> ...what is this long list of commands?
>

I can not give an answer for that.
The LVTS programming guide is short in explanation.
It just gives this code sequence to configure it without any explanation.
