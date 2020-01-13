Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CED85138A24
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2020 05:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387480AbgAMEGB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Jan 2020 23:06:01 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35471 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387415AbgAMEGB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Jan 2020 23:06:01 -0500
Received: by mail-ed1-f66.google.com with SMTP id f8so7259706edv.2;
        Sun, 12 Jan 2020 20:06:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2XoQxnxnbf89i87hmMyaS+hS25moXF0WF8eizgFC4Nw=;
        b=Vw3abKezw0SGONxn7qnSSx+GxsNKaFXprbwllqpPSaA7fnS6QAYeCyDG+9yT/BwaVw
         EAs87soF1wv8TaPdLHRwp3qq3p+SrS/7drrVTnom2+j0OYD0yixycrOwFXntiBwltkix
         Vy2LOem4E+al6sKfk7gObC7Yv84bVStISVXqyekSJwvvq3WNWnjHYpS1p9tIjoAPKln1
         pIDKYnpl/d2yBGpRA2TlaNxBxjmCeJlQwi69buz6uZh+EvVrcgfHNSHS6Fd8JOaEMunV
         mut4YwmxgrzwBjPUUZJrkcLV6gBvkGz4uWRtnAoF1E0gz/7SR3M1p2I9+Bzj5jJTcf6R
         IObA==
X-Gm-Message-State: APjAAAVnJOZ23m4BKE/LtwotKg7GjGcop/j+O++tCV2hTYghgMzbTHOg
        MZVMzewhEPtXhKNUW1wEzNNvDqwyebw=
X-Google-Smtp-Source: APXvYqw0G/JED1DUbNrhmqls8VbqlRD8Bl8VhXxbWlNWrsyNoQCaZXJtWRIpdIuSCBgXuHSiMbnvCg==
X-Received: by 2002:a17:907:43c1:: with SMTP id i1mr14475961ejs.138.1578888359060;
        Sun, 12 Jan 2020 20:05:59 -0800 (PST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id j21sm415191eds.8.2020.01.12.20.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jan 2020 20:05:58 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id u2so8047020wmc.3;
        Sun, 12 Jan 2020 20:05:58 -0800 (PST)
X-Received: by 2002:a05:600c:2409:: with SMTP id 9mr16419248wmp.109.1578888358440;
 Sun, 12 Jan 2020 20:05:58 -0800 (PST)
MIME-Version: 1.0
References: <20200113035310.18950-1-samuel@sholland.org> <20200113035310.18950-7-samuel@sholland.org>
In-Reply-To: <20200113035310.18950-7-samuel@sholland.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 13 Jan 2020 12:05:49 +0800
X-Gmail-Original-Message-ID: <CAGb2v65v40RDWz3V4Fu=MfU4K+MUXxmj5_LB7wFt2Qtxw9RMzQ@mail.gmail.com>
Message-ID: <CAGb2v65v40RDWz3V4Fu=MfU4K+MUXxmj5_LB7wFt2Qtxw9RMzQ@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v3 6/8] power: supply: axp20x_usb_power:
 Allow offlining
To:     Samuel Holland <samuel@sholland.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Oskari Lemmela <oskari@lemmela.net>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 13, 2020 at 11:53 AM Samuel Holland <samuel@sholland.org> wrote:
>
> AXP803/AXP813 have a flag that enables/disables the USB power supply
> input. Allow control of this flag via the ONLINE property on those
> variants.
>
> It may be necessary to offline the USB power supply input when using
> the USB port in OTG mode, or to allow userspace to disable charging.
>
> When the USB VBUS input is disabled via the PATH_SEL bit, the VBUS_USED
> bit in PWR_INPUT_STATUS is cleared, so there is no change needed when
> getting the property.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
