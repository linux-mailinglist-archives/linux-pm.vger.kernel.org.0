Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0130A349E65
	for <lists+linux-pm@lfdr.de>; Fri, 26 Mar 2021 02:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhCZBGD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Mar 2021 21:06:03 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:39444 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhCZBF4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Mar 2021 21:05:56 -0400
Received: by mail-io1-f44.google.com with SMTP id k25so3810196iob.6;
        Thu, 25 Mar 2021 18:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zH0f9upICvGtfhc9K2ovrNfwKuCEFP7sQ4T0LgE5oCE=;
        b=nKknosDrYdmX5yhOoa0fBriXSl+D7GxHvB2foDZYris6il8m3Ou+3XQMB1SmqXLCN9
         7grqWEXWaJYBTuBqLMiox6mnxU9gn1g9NpbziK3579i9u3IkTiu7ZUAW+dPpBx+nevJ4
         abY9QpD/V0hhvtLkDY1WpIYiKTcwAQ8eDY8iaPAi0+QR9hQUsblVWtfr91lknM3BA4b2
         xDhWNQs6yz0xUZcApyHKi5ObcvUf9hFZ+GnD2AY0LV6DFwUiR97gLcueggJpSriC7E0d
         SCfJjte3VKvAw4Lgokv119Dp2XY8dEzC4tpgbqNJXQEL3zZdFrFt/PO9aAEX+oAXtiKO
         CLiQ==
X-Gm-Message-State: AOAM533XDt37t5K4Ukkqx9mPNjgy44J+y1fkLbwFRRVRTcGdgYUl005G
        uTARph4nLO4ZSeZh7sNYbQ==
X-Google-Smtp-Source: ABdhPJyICXxa42GrQ71eu8ff2Oat1nHtX15PHNXQVMG+4zeSDlcWjZ+exqiFjJzCzVrlg2z0Ae6ilw==
X-Received: by 2002:a5e:d908:: with SMTP id n8mr8544541iop.121.1616720756093;
        Thu, 25 Mar 2021 18:05:56 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id p3sm3464481iln.48.2021.03.25.18.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 18:05:55 -0700 (PDT)
Received: (nullmailer pid 2090699 invoked by uid 1000);
        Fri, 26 Mar 2021 01:05:52 -0000
Date:   Thu, 25 Mar 2021 19:05:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <anup@brainfault.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        linux-kernel@vger.kernel.org, Liush <liush@allwinnertech.com>,
        Sandeep Tripathy <milun.tripathy@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>
Subject: Re: [RFC PATCH v3 7/8] dt-bindings: Add common bindings for ARM and
 RISC-V idle states
Message-ID: <20210326010552.GA2090598@robh.at.kernel.org>
References: <20210318130512.1025416-1-anup.patel@wdc.com>
 <20210318130512.1025416-8-anup.patel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318130512.1025416-8-anup.patel@wdc.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 18 Mar 2021 18:35:11 +0530, Anup Patel wrote:
> The RISC-V CPU idle states will be described in under the
> /cpus/idle-states DT node in the same way as ARM CPU idle
> states.
> 
> This patch adds common bindings documentation for both ARM
> and RISC-V idle states.
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  .../bindings/{arm => cpu}/idle-states.yaml    | 228 ++++++++++++++++--
>  .../devicetree/bindings/riscv/cpus.yaml       |   6 +
>  2 files changed, 217 insertions(+), 17 deletions(-)
>  rename Documentation/devicetree/bindings/{arm => cpu}/idle-states.yaml (74%)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
