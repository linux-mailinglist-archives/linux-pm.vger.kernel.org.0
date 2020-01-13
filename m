Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDC0138A27
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2020 05:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387474AbgAMEJH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Jan 2020 23:09:07 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46637 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387460AbgAMEJH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Jan 2020 23:09:07 -0500
Received: by mail-ed1-f66.google.com with SMTP id m8so7231776edi.13;
        Sun, 12 Jan 2020 20:09:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VRG/asPsXrvPYXyKX7n6EnWclC+DWZV9ykIQcZ3tJv4=;
        b=VhUwBl1qnUjF1F1gbW0UVlJYWJSPyIjfWGV3wss5dciLYCid7AwMe0lsV0drxzKEbm
         82fJaRsY1WXo7ngzevxrSeT6Cbce4kKRnlyaUjGOD+lK4B9odwBZaQ0E5DGWWRbsXo2A
         5twNEOFRDnx5IHGLPxbTrbcQtkqkWRjWWf7wwb8Ktosi0esees0S+uAjwfuTzagsiaru
         98Apwa0CoJqYbjkXNZHfV5uy0UnbwA/CzLTfC2HrPCwOWS0km7+hUzCdh0DGf+gyu+Fh
         CvkFvTqwAZS5xO6NrwiRmWsm9nLjaOhP9rd6Kn9R4pJHu+s1BMbRNZtYUoNKjkGPTvDg
         Mkzg==
X-Gm-Message-State: APjAAAVbO20jjBSur9c7UQ1uDO5Ur6F8pkjNTOTQlZOfkhPLnEI3QmGS
        6xPY/E3MbJB8mKDmUQP6dKeDobJtOOk=
X-Google-Smtp-Source: APXvYqyUQTRpFfPw5Is4YosB12w+ZFPt6H8v/vbdeXiOFPH03T1/LJ1n7fmS39fyRxchvleBh/+rrw==
X-Received: by 2002:a17:906:3591:: with SMTP id o17mr14882175ejb.209.1578888544938;
        Sun, 12 Jan 2020 20:09:04 -0800 (PST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id w10sm424722eds.69.2020.01.12.20.09.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jan 2020 20:09:04 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id w5so8837613wmi.1;
        Sun, 12 Jan 2020 20:09:04 -0800 (PST)
X-Received: by 2002:a7b:cf12:: with SMTP id l18mr18568407wmg.66.1578888544372;
 Sun, 12 Jan 2020 20:09:04 -0800 (PST)
MIME-Version: 1.0
References: <20200113035310.18950-1-samuel@sholland.org> <20200113035310.18950-6-samuel@sholland.org>
In-Reply-To: <20200113035310.18950-6-samuel@sholland.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 13 Jan 2020 12:08:55 +0800
X-Gmail-Original-Message-ID: <CAGb2v66FsV9Gdm0Osgg5=Ebeh8-q4dVcWo1QoB8J9Ehag4XjkQ@mail.gmail.com>
Message-ID: <CAGb2v66FsV9Gdm0Osgg5=Ebeh8-q4dVcWo1QoB8J9Ehag4XjkQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] power: supply: axp20x_usb_power: Use a match structure
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
> Instead of ad-hoc variant ID checks throughout the code, let's start
> moving the variant-specific details to a match structure. This allows
> for future flexibility, and it better matches the other axp20x power
> supply drivers.
>
> This commit removes most variant checks from axp20x_usb_power_probe().
> Other parts of the driver still do ID matching; they are left unchanged
> for now.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
