Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C31B79B03
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2019 23:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbfG2VZI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 17:25:08 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34722 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfG2VZI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jul 2019 17:25:08 -0400
Received: by mail-ot1-f65.google.com with SMTP id n5so64145254otk.1;
        Mon, 29 Jul 2019 14:25:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KJFm+29xdmh4eMN4D0nGSnJhY+tLmcYbySYne7TR5rk=;
        b=e46aDFveK7zG4xYYs0IECKEtaCORx0QzVb1zgQIKbIyChyNJX+s1ihxDVtTARc9SeO
         n74BbPaT4n/xjKFS4TTfpCVnP4ZnqfPCbSlnqR5/V5DTn1z1bwLk/VegxEcOwAeBYPn4
         R0NiP2wC85C8jlWXlBb4P1Tx4AKyMiHc0Lyp8qpiqmNSR2Er5C9eGGnwSGdfxhpZo80d
         x+pKrkQ79wjKEHyAfju28iN1RWNQXomxtOfHljtf9ocr0azLpgzlEQndDS8rQBoBaAC+
         rClZFLIrPnsmea6N6To34jU3HCEruDXWf5MmuTRlO6BLRBvmman4WblxmSmI8GXPZRxs
         0fyw==
X-Gm-Message-State: APjAAAWw6wE4eXS+Y3bx5EIOKOlycTONZVHUw0N2GbNaemjy0Amwuzi4
        ulDegCjaNYTyNAzkYQ3Gf3JKYfg3HwX2qjYktos=
X-Google-Smtp-Source: APXvYqwZKJSEHahFNopVUM0XNCLRgSdZ263ULw6EoirQNLdhBkJnGI89d2oNHu1aN8Et/1+cJZJbadg/yjCLAQjxwxI=
X-Received: by 2002:a05:6830:1516:: with SMTP id k22mr77695493otp.189.1564435507068;
 Mon, 29 Jul 2019 14:25:07 -0700 (PDT)
MIME-Version: 1.0
References: <2305283.AStDPdUUnE@kreacher> <c8960d91-4446-9acf-5575-e442a652bd05@gmail.com>
 <CAGETcx_+i6_0Q2rf-UdzZ3bCPUos9Tu4JmvvO0zUoy5gB8_ESQ@mail.gmail.com>
In-Reply-To: <CAGETcx_+i6_0Q2rf-UdzZ3bCPUos9Tu4JmvvO0zUoy5gB8_ESQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 29 Jul 2019 23:24:56 +0200
Message-ID: <CAJZ5v0h5U60yCyaHeHVbWmwWDa4NBnuhgsV022nZm5HuGgV7ow@mail.gmail.com>
Subject: Re: [PATCH v2] driver core: Remove device link creation limitation
To:     Saravana Kannan <saravanak@google.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Jon Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 29, 2019 at 10:47 PM Saravana Kannan <saravanak@google.com> wrote:
>
> Rafael,
>
> This is the fix you need. Or something link this.
>
> I had asked you to reject DL_FLAG_MANAGED as an input flag if you are
> marking it as internal (in the comments). But looks like you were also
> trying to check for "undefined" bit positions. However, the check
> isn't correct because DL_MANAGED_FLAGS doesn't include (rightfully so)
> DL_FLAG_PM_RUNTIME and DL_FLAG_RPM_ACTIVE .
>
> I tried to write a DL_FLAG_EXTERNAL to include all the external flags,
> but that felt like a maintenance headache that's not worth carrying. I
> think it's simpler to just error out when internal flags being passed
> in and ignore any undefined bit positions.

Well, IMO it is better to prevent people from passing unrecognized
flags to device_link_add() at all, even if that means some extra
effort when adding new flags.

I'll post an alternative fix shortly.
