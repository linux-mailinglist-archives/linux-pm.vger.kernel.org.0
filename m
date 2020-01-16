Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF9C13F5BA
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2020 19:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389001AbgAPS62 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 13:58:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:38264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389538AbgAPS62 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Jan 2020 13:58:28 -0500
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83AE121D56;
        Thu, 16 Jan 2020 18:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579201107;
        bh=xQHaMmW5+OUanOpzT3F10iGg7VHntvomNgGXkgpU0/4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pW1ad/mr9lv4mjG0KEHhw15B0zLcU7PWxrVIHtozNIlIefsGUj+3aY68lA0al2hhz
         oWtE//Q1g1pAS6w0SBmCk64FIpGJjxgsQAswNY8yo9mAkJeDp4c/olz+VXoP3Kme05
         TC1GjKQjhsUfwbm5bhgzsLb7A7y6H9uLiQgNebmM=
Received: by mail-qk1-f174.google.com with SMTP id a203so20225382qkc.3;
        Thu, 16 Jan 2020 10:58:27 -0800 (PST)
X-Gm-Message-State: APjAAAX7EBSkaL+2UN0vHHUSOPaWAykL58uzba7Sdl55VtITmLMHVai7
        7nddZv4d5aJCXwXX1c7AtfQlKWE22hP4xROPJw==
X-Google-Smtp-Source: APXvYqz7Jds+/Z0T2jKmrW9vc4gPA0ja7tR3DL5ZNZX7bEiGSGPBQq4mA+KAyBwwQDFM1HxCAgDqUAjb3yEtcnqqaag=
X-Received: by 2002:a05:620a:1eb:: with SMTP id x11mr35416430qkn.254.1579201106608;
 Thu, 16 Jan 2020 10:58:26 -0800 (PST)
MIME-Version: 1.0
References: <1579200077-17496-1-git-send-email-stefan.wahren@i2se.com>
In-Reply-To: <1579200077-17496-1-git-send-email-stefan.wahren@i2se.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 16 Jan 2020 12:58:15 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+51A_wKBzxwihkQd=eo_AEQ-wo4pK_GthO5b8WT=6oKw@mail.gmail.com>
Message-ID: <CAL_Jsq+51A_wKBzxwihkQd=eo_AEQ-wo4pK_GthO5b8WT=6oKw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: brcm,avs-ro-thermal: Fix binding check issues
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 16, 2020 at 12:42 PM Stefan Wahren <stefan.wahren@i2se.com> wrote:
>
> Drop the reg property since this only necessary for the parent and
> add the missing thermal-sensor-cells property description.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Fixes: 3d4849897691 ("dt-bindings: Add Broadcom AVS RO thermal")
> ---
>  .../devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml         | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Thanks for the quick fix.

Reviewed-by: Rob Herring <robh@kernel.org>
