Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2353F192B4
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2019 21:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfEITOh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 May 2019 15:14:37 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:41000 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfEITOh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 May 2019 15:14:37 -0400
Received: by mail-io1-f47.google.com with SMTP id a17so2519797iot.8
        for <linux-pm@vger.kernel.org>; Thu, 09 May 2019 12:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YFgEka9/o2A/jgTwa7gIGZOjIMJ8eEkbnUkf/OOkIdg=;
        b=Nuh/Xvjc7dB3/VsN1vmwrrRX8qug05FOvsDEhpLcFUIZ0x+7H08g4DKa3gyROrXdXU
         pUHStnaV9+9yxF7c95yQGrcfxMLPYkvx4QaMaVdudaM7MOfyoCIvZqw+FDsy4w9pXZQp
         dk+GKY7trHouVc4I6UojsTtARsn32mDy/+e9EylGQK7/577Y2/Il+QhuQ5WWydt8IvVj
         FmtvvmCJVnP9VTGDqhi59MqOYqKPDdNhagrl8B0kalXomuk9Rjn3P6gilea/QQ9BNKpA
         IW6WIiJbz1ku/9NOyCc22/cjTEtxg2Sw85IkrfQ22eR5QhDdGV03UBjqhumH+yzmkSGW
         udHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YFgEka9/o2A/jgTwa7gIGZOjIMJ8eEkbnUkf/OOkIdg=;
        b=e9C40TKUuVHEZZKg1vMjwJf+L6WLpnlMZhAOWZ2rhllqwvew45oN4slnB+1FkPKs6v
         C/LvH5ltmvZlE7isKsHxoE8oNX8gug3LOdO/tuLMTSkRQJvhk9FAkpCLJrihFxlvetQ5
         mjPtrGM5cOIHH/0WkcA4lQp+AteyQq3tMjKnZDlTq+5ZND9N5MUvDWG+2Ted0mSfy/9h
         GbHHyZd8jsOxjy/Xz8iuaaTzcd/ygCE5Fl+oUjt4MqFmwvY3tBDZqJ3o7+SxpqSkkC9d
         8xwIbikGh0+MMYfU/ECG9GExJZJ9BUyokhW8afWL2YK7Jo11XFfygZG74AxE5weQaYxd
         WWTw==
X-Gm-Message-State: APjAAAWD/jzbmJ4GZyokaulDyAsJNXfRDVWaK9K+WtYOLtVNyaSOBpQ7
        IIXSlcY2yNFBYT9+oHddmJkOkmb3eFMf7dnJkzD+cbWk
X-Google-Smtp-Source: APXvYqz4fEYr+PxfEQ9mpnNcxllD+Vzu5x83lAEUQUwzGgLZW1cl6uG7muRICVhVBxepK0cigrSlmG+DjSPm9hBAgCw=
X-Received: by 2002:a6b:410e:: with SMTP id n14mr3456234ioa.141.1557429276375;
 Thu, 09 May 2019 12:14:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190509125614.28921-1-axel.lin@ingics.com>
In-Reply-To: <20190509125614.28921-1-axel.lin@ingics.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Thu, 9 May 2019 12:14:24 -0700
Message-ID: <CAHQ1cqH6E9zf_GuW5qx8+PAPE6LxOc4_HGXSNmLeDni4Q=pXRQ@mail.gmail.com>
Subject: Re: [PATCH] power: supply: ucs1002: Fix wrong return value checking
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Enric Balletbo Serra <enric.balletbo@collabora.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 9, 2019 at 5:56 AM Axel Lin <axel.lin@ingics.com> wrote:
>
> Fix wrong return value checking for devm_regulator_register and
> devm_regmap_init_i2c. This looks like a copy-n-paste mistake.
>
> Fixes: 9a2688e42638 ("power: supply: Add driver for Microchip UCS1002")
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Ugh, sorry about that.

Reviewed-by: Andrey Smirnov <andrew.smirnov@gmail.com>
