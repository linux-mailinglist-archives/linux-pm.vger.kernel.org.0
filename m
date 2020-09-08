Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1FD026212B
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 22:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgIHUci (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 16:32:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbgIHUci (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Sep 2020 16:32:38 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AA592080A;
        Tue,  8 Sep 2020 20:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599597157;
        bh=ae6AMbW5Zbt4RvWuZiatLoN8hwJFRLDqXNWITg74j8A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a/drOXrPUFcSOe5T7Wu/Brg0cAwHxDPwLy6+IbSTLvBWnzxRifbReAuKkjG8atNCX
         DA6OTYolrj8KEkjEbdriEltxGOX7eWXwQhPtxcuak2nfY/PcZyFt975+sRtJbkrTC1
         RQu6KElntPRstPYuVXNyaFQOq4Rm7Mc1AYYvdAV4=
Received: by mail-ed1-f54.google.com with SMTP id l63so395293edl.9;
        Tue, 08 Sep 2020 13:32:37 -0700 (PDT)
X-Gm-Message-State: AOAM531TdnlK3rpoV06hbOj+gyZHH6eSItz9tS8+M8w/P9B8HITric/h
        xVCzhM3fxMd6BUUHjtN/TgeCYq7AlJag5RPk198=
X-Google-Smtp-Source: ABdhPJwMA0H8NIde0m0lJZ/ingPzRtfE0khao8PRkl6XIflfEfvU5DX+zreF3O7C3tOpXiUr8SA55OXc2jr2Fth2PLo=
X-Received: by 2002:a50:ab1d:: with SMTP id s29mr887456edc.246.1599597156268;
 Tue, 08 Sep 2020 13:32:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200730143122.28519-1-dmurphy@ti.com> <20200730143122.28519-2-dmurphy@ti.com>
In-Reply-To: <20200730143122.28519-2-dmurphy@ti.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 8 Sep 2020 22:32:24 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeTWko5zD-AJiAud+QvXgSj9_jjvEx3aBCNqRSYL0iJmQ@mail.gmail.com>
Message-ID: <CAJKOXPeTWko5zD-AJiAud+QvXgSj9_jjvEx3aBCNqRSYL0iJmQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] power: bq27xxx: Fix spacing style and white space issues
To:     Dan Murphy <dmurphy@ti.com>
Cc:     sre@kernel.org, afd@ti.com, pali@kernel.org,
        linux-pm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 30 Jul 2020 at 16:32, Dan Murphy <dmurphy@ti.com> wrote:
>
> Fix spacing style issues with the chip data array.  As well as fix
> missing new line after variable declaration.
>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  drivers/power/supply/bq27xxx_battery.c | 63 ++++++++++++++------------
>  1 file changed, 33 insertions(+), 30 deletions(-)

Hi all,

Different topic. Do you know what is happening with Andrew's email? I
receive bounces with 550, so permanent error (no recipient under this
address).

Best regards,
Krzysztof
