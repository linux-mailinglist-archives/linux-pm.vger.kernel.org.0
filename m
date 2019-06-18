Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1CED4ADE4
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2019 00:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbfFRWgZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Jun 2019 18:36:25 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41092 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729982AbfFRWgY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jun 2019 18:36:24 -0400
Received: by mail-lf1-f68.google.com with SMTP id 136so10490041lfa.8;
        Tue, 18 Jun 2019 15:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OmWI+jPSOU4GzXhhmiJ7IENEOWtdm0c+3gyyHlOWvqc=;
        b=TJJzmgJQH+0YaqHqaI05h6/a2QNcYpFEiPf6fCr5DHyjHjD87HNUx0mM6HRZvRQ6Ep
         2KByAdsdHykeh/tziTXUTYbDmQMl1FetXi26liIbFSIxyvTaQbIth6VBGO6xOFpOkD4w
         VlVZJ05a44+437c0F54r+p41O3ZbN+nAwtscWZmoiB0mLLYxZ3kbOYHaxZBX8MG5T9A1
         zxji+DAiD6z8Sc4VIrIBPARiMX57KVZhkaNsTqoVnIh2tagwf3F0jZvBuo5pa09zhKoC
         S4l0xSRwVpiFy0Wmkktg2hlmM7CS4xwDZ3QHszcbrYbgjOds1LH/waP2nNAwq5LvnoXt
         wLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OmWI+jPSOU4GzXhhmiJ7IENEOWtdm0c+3gyyHlOWvqc=;
        b=b5/3gGj+2QYgoOpAg/Lm3w3Tv8wdqDMYgYZRcFqA69wAK4wCGxrb79w2WOvRIm0oL9
         O/OQvWs53GslrnL5AJlDqxlvlgSy+e4Lhm+S8LrvBBHLmenHwP/hoc28ODsmst96B8CV
         8h/SScA2gKdQRBRNUKg+MVMl7rHtjRXvaUvm53kPLTltPtvJone8toVuTYqsdyw0Bn/D
         Dgs5y96zhdf3Rg1t38evursek7qRl4MyP0hnWs2pMnFsIpBL979NO01MM9usWdHCp3S7
         GrphJXaSs9Wrg3WHUZUUwE+R8gOlxN2kvsLeDmOm9cRI8gIxKWrZTVOmTwpdkgeRR+4z
         voTQ==
X-Gm-Message-State: APjAAAX+LEwhYgv9qUUOTpJcfrZPC6l/dAP/sQvZ8PLQ+fBptmnygV/k
        eHRcCC6qzWemXjtv3R744Ng9PkPyWeZKcit1e6Y=
X-Google-Smtp-Source: APXvYqxVxnco4ZxfcINkyM3EPMHdvT8k36eLksXyP8cjLk9NtCWF+uLO5jPWzi8akJxZwabtOTCJPRUNMtGyyO+qJQU=
X-Received: by 2002:a19:5044:: with SMTP id z4mr57625740lfj.80.1560897382598;
 Tue, 18 Jun 2019 15:36:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190614074140.15276-1-andrew.smirnov@gmail.com>
In-Reply-To: <20190614074140.15276-1-andrew.smirnov@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 18 Jun 2019 19:36:34 -0300
Message-ID: <CAOMZO5ALbjLu8+QBL2Z3dEg7Qkb6jcfHLW_CPzVyyifhDasFLQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: imx: skip registering legacy cooling on i.MX7
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Andrey,

On Fri, Jun 14, 2019 at 4:41 AM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> i.MX7 doesn't have a mainline cpufreq driver, so

i.MX7 uses the generic cpufreq-dt driver since commit:

commit e3526f004a35e5f324b1c835bca056f4df05bff0
Author: Bai Ping <b51503@freescale.com>
Date:   Tue Nov 24 18:25:16 2015 +0800

    ARM: imx: enable cpufreq device on i.mx7d

    Add a cpufreq-dt device on i.MX7D, using the
    generic cpufreq-dt for CPU frequency scaling.

    Signed-off-by: Bai Ping <b51503@freescale.com>
    Acked-by: Lucas Stach <l.stach@pengutronix.de>
    Signed-off-by: Shawn Guo <shawnguo@kernel.org>
