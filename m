Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20EBEDE588
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2019 09:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfJUHw0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Oct 2019 03:52:26 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40277 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfJUHw0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Oct 2019 03:52:26 -0400
Received: by mail-ed1-f65.google.com with SMTP id p59so860302edp.7
        for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2019 00:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lshseq5695iLMWS2/yTnU4q4phMFdnGbVyLcqMyDgNw=;
        b=f4plsD5OF7QI01+J/daaDJeoz3LkteQ6BQB7+jftsCG7vHACEuYAS0/ifg1VOZ+2bv
         DVnIY34EwF6RV/LyAIkxxcICf5gDAB5lJnzvHZwPiIbqUNd0/Lda6KhsIL7Vv666qS53
         0dm2LtJmUWVBz3Z6INSe5m7WXyh7OwRPV6IN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lshseq5695iLMWS2/yTnU4q4phMFdnGbVyLcqMyDgNw=;
        b=bs8cg6EUgeR4xW2fXVDeZB5uMGNfur1ySPIvR4ACxMy8Wtf8yL7K9HKQSQgjEBKWhX
         0SkCE5jH1T4hDsGnyYDrfvrWRI8hZg+mWrQs0ITOLPzq8LjEfN89F4A/NWCVM3OGVMR3
         22E/QeUN//bbmUnA0jZBcKObvW3bA0W74uojjirpTz4CDTmWlsZ67kLICrorZQbf8CZr
         o5A1vJbFYzshAbIZr4BZ9wu/uAKdHx2DHg3HUtzlUEcyCjdfyzuIrZhFUKpzg4Y60Ok1
         PIPtjMz1TKbJQwnwO+CvkM6bmgKr2AdTEhr2fjkGvlhLpy2eWHyJiRp96sYtBPqsHODN
         D4/Q==
X-Gm-Message-State: APjAAAUiw/pk7XtN5PJ1br/Sj0TEp8d7hDrZL/BK9DhNYIi4jCkGp/P1
        p8nUP+CgPA2lh8gh1WpsYKHLANeqhd/23LXwOmM+9A==
X-Google-Smtp-Source: APXvYqzlkUpYGQn2syS3ZLVsVWF/tTk0yVfY4fQyTuFCwfaWNooQm7u2tuJVHYSsQtBTu3rWlHNporZiD288c1BLvm4=
X-Received: by 2002:aa7:d8c6:: with SMTP id k6mr23548337eds.87.1571644344157;
 Mon, 21 Oct 2019 00:52:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190906100514.30803-1-roger.lu@mediatek.com> <20190906100514.30803-4-roger.lu@mediatek.com>
In-Reply-To: <20190906100514.30803-4-roger.lu@mediatek.com>
From:   Pi-Hsun Shih <pihsun@chromium.org>
Date:   Mon, 21 Oct 2019 15:51:48 +0800
Message-ID: <CANdKZ0dAWWy7QMMZhNHAha5ZpcBo1GHebPc5_FRu5gvBc569QA@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] PM / AVS: SVS: Introduce SVS engine
To:     Roger Lu <roger.lu@mediatek.com>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>, yt.lee@mediatek.com,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nishanth Menon <nm@ti.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Roger,

On Fri, Sep 6, 2019 at 6:06 PM Roger Lu <roger.lu@mediatek.com> wrote:
> ...
> +static int svs_resource_setup(struct mtk_svs *svs)
> ...
> +               for (i = 0, freq = (u32)-1; i < svsb->opp_count; i++, freq--) {
> +                       opp = dev_pm_opp_find_freq_floor(svsb->dev, &freq);
> +                       if (IS_ERR(opp)) {
> +                               pr_err("%s: error opp entry!!, err = %ld\n",
> +                                      svsb->name, PTR_ERR(opp));
> +                               return PTR_ERR(opp);
> +                       }
> +
> +                       svsb->opp_freqs[i] = freq;
> +                       svsb->opp_volts[i] = dev_pm_opp_get_voltage(opp);
> +                       svsb->freqs_pct[i] = percent(svsb->opp_freqs[i],
> +                                                    svsb->freq_base) & 0xff;

Should have dev_pm_opp_put(opp); here.

> +               }
> +       }
> +
> +       return 0;
> +}
> ...
> +static int svs_status_proc_show(struct seq_file *m, void *v)
> ...
> +       for (i = 0, freq = (u32)-1; i < svsb->opp_count; i++, freq--) {
> +               opp = dev_pm_opp_find_freq_floor(svsb->dev, &freq);
> +               if (IS_ERR(opp)) {
> +                       seq_printf(m, "%s: error opp entry!!, err = %ld\n",
> +                                  svsb->name, PTR_ERR(opp));
> +                       return PTR_ERR(opp);
> +               }
> +
> +               seq_printf(m, "opp_freqs[%02u]: %lu, volts[%02u]: %lu, ",
> +                          i, freq, i, dev_pm_opp_get_voltage(opp));
> +               seq_printf(m, "svsb_volts[%02u]: 0x%x, freqs_pct[%02u]: %u\n",
> +                          i, svsb->volts[i], i, svsb->freqs_pct[i]);

Same here.

> +       }
> +
> +       return 0;
> +}
> ...
