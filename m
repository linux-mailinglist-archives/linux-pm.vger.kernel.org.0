Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4F2F133EC1
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2020 10:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgAHJ6c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jan 2020 04:58:32 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:42377 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbgAHJ6c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jan 2020 04:58:32 -0500
Received: by mail-io1-f66.google.com with SMTP id n11so2510813iom.9
        for <linux-pm@vger.kernel.org>; Wed, 08 Jan 2020 01:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QAtR7WNLGbja1kZFYbC1LM6r/2gOOz73oNIxwZf1sK8=;
        b=LGhwTuIZMsvckUaUhJ+tDGp6Y0jn0LYn/xbxleZUSDMkTwotTTy+1Fg5ZHuiCgbnuW
         ABixaa78LQAMQqSXxlOdTlfDx+n2+WrJQM9cCO+dERP4pTnItxTE5IlWAuVhshqD5D0f
         0ZiCF95TJ+fR3w2e37nT74ePbWYE2y6TFcorU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QAtR7WNLGbja1kZFYbC1LM6r/2gOOz73oNIxwZf1sK8=;
        b=g3Yu7oId0UAtOdjp+cRFdxQOrjDZUBiOxNWuTmme1Sq1NtujXhWzxtZuUdNHq2On25
         o6mgUH7JL5RWyc/fB+aApMiDn9Mj1ymAHIFwlLPsPSGaiFXrw7BEx1o+Q78h50ZhiaWk
         uzTKkwxhG/yajHh2NImsZccSUaq7mW3cqawQA2KADwrhl5aYV/KU/cUvXM+u8C5yaQ8e
         x4qylnxdCydkAuCbaAyBuJKVtC0HzOle6LX8z6ny31rJip+XxnuO8y9EplV3AwqXeGl7
         r17z/OU1OqETGmFmejUu7JbxmxeeUHkYxg44oWKsnolh91RlMaNYYBVWHkkvzO1cfcbM
         E1jQ==
X-Gm-Message-State: APjAAAU06crMeUWgZW8uDdEMy8UJQFOznkewWpXziZim+C93133vCz5I
        rO/oNJxWl+Pe/sidrYklTVk97Hb4Kmn4UE2IwAmDcg==
X-Google-Smtp-Source: APXvYqwH5rufYzM9JfRPQjj7bRhJ6sm9RgJQyx7qvhgpJjalHtt1/UbVPcBLfTvCu23laYbDf4TKavfcetdwMpGEoRY=
X-Received: by 2002:a6b:3845:: with SMTP id f66mr2819729ioa.102.1578477511547;
 Wed, 08 Jan 2020 01:58:31 -0800 (PST)
MIME-Version: 1.0
References: <20200103064407.19861-1-michael.kao@mediatek.com> <20200103064407.19861-7-michael.kao@mediatek.com>
In-Reply-To: <20200103064407.19861-7-michael.kao@mediatek.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Wed, 8 Jan 2020 17:58:05 +0800
Message-ID: <CAJMQK-hQ5BWp7isGDTz_Y4ttxfoM0guqfcAEFrh3Eq7SMcNM5w@mail.gmail.com>
Subject: Re: [PATCH v3,6/8] thermal: mediatek: mt8183: fix bank number settings
To:     Michael Kao <michael.kao@mediatek.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, srv_heupstream@mediatek.com,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jan 3, 2020 at 2:44 PM Michael Kao <michael.kao@mediatek.com> wrote:
>
> MT8183_NUM_ZONES should be set to 1
> because MT8183 doesn't have multiple banks.
>
> Fixes: a4ffe6b52d27 ("thermal: mediatek: add support for MT8183")
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> ---
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
