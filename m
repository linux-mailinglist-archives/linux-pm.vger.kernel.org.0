Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2B5D125942
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 02:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfLSBeU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 20:34:20 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41444 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfLSBeU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 20:34:20 -0500
Received: by mail-qk1-f193.google.com with SMTP id x129so3304039qke.8;
        Wed, 18 Dec 2019 17:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BCSxFafqPE5ERz3UrkP5uxFwiwYg6nGJeQKlM4gvCAU=;
        b=AoTnognSO/nELYlSs55Y0LZS7ZwnLR5p+y/QO74XN/A8K+7vHMvE/jiJ+Jq/Ul+2PG
         5lVjCcDYkgFxpv5+gGYSmHBhcLXB/DndFqGxcOG/DzvMHX+eugQO7oKigvLAr1b2i2/H
         GyYgJbImMczndYXzKJFqkkhF+a6/XZoXyH3T2ZCXFQrs5wg9uh+guHpnfIPQ+xHsUmpz
         0uCXqlYH5+TfkA1fIxeJ31XpiNlGyjW9y5Vg+wAH4OGeedzEcgW/RYM5m2D2KfPDNYx0
         r9YaHHczYY/cfgwyNEN2HSGZSynOtTFNrFiGqEzSYKqnvA15hd2wlery0iVYpYzO+eGL
         R8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BCSxFafqPE5ERz3UrkP5uxFwiwYg6nGJeQKlM4gvCAU=;
        b=VKBx77XWRqOl+EkGxo8G5/rggbWC9jOfWT4UpgCviUxaGDgc+nnZacW4o9yPS8q2UN
         AI+yYdSl9VYdRHF+ebWfMqWoARN2t+jYjxuWY4tk6WoQwQNBdIaVpnu3OBB4KA00FoA2
         MzrJpqKLqhEXogrmhj56E8g9pLWlCtM3tDWrbvKO5jkblp6eWEQtHSzggeQcX380anrt
         euIg/phGVaXkjbJAT6Pcm6u7KaOQTMhAm7kk5iMkkBZF4JJjuqtkgBX/c3yqRwufS16y
         tYKPpha1+ThJ2nvUH725l37GZsRNwmpUVyanVf3LCKk/89iep4MXfWEFmcmJgXqtCSln
         Ad8A==
X-Gm-Message-State: APjAAAXVfGpBAAyAM9dVTSg2KunOCbAwW0u4K8G1x92eqnx+4X3AtWeQ
        FyoF2naJnNO7pcQOwFJXrb9uOQbQLc6dftN6hbsq+tDg
X-Google-Smtp-Source: APXvYqxaN0OeO3c7GsQVcs5292WIZw+d+djvRDMX1ntmlnFQbkJKQmSjBMrY06hv/6U6pVL+GUm82/OqYtsDB6kdL24=
X-Received: by 2002:a37:8e03:: with SMTP id q3mr5803812qkd.395.1576719259097;
 Wed, 18 Dec 2019 17:34:19 -0800 (PST)
MIME-Version: 1.0
References: <cover.1575863274.git.baolin.wang7@gmail.com> <20191219005439.63nk4fpraveoeqyv@earth.universe>
In-Reply-To: <20191219005439.63nk4fpraveoeqyv@earth.universe>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Thu, 19 Dec 2019 09:34:07 +0800
Message-ID: <CADBw62oQ8FaoVXCe7w9rAYy7mR6j8vOAUoeM_K3u4XC0JwTe3g@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Improve the SC27XX fuel gauge controller
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        yuanjiang.yu@unisoc.com, Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian,

On Thu, Dec 19, 2019 at 8:54 AM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hi,
>
> On Mon, Dec 09, 2019 at 11:56:20AM +0800, Baolin Wang wrote:
> > This patch set adds one battery resistance-temperature table to optimize
> > the real battery internal resistance in different tempertures, and
> > calibrates the resistance of coulomb counter to improve the accuracy
> > of the coulomb counter.
> >
> > Any comments are welcome. Thanks.
>
> Thanks, queued to power-supply's for-next branch. I changed the
> comment for struct sc27xx_fgu_data, so that it states calib_resist
> being in uOhm instead of mOhm.

OK. Thanks.
