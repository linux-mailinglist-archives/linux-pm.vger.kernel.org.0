Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2CAC2F242A
	for <lists+linux-pm@lfdr.de>; Tue, 12 Jan 2021 01:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391734AbhALAZl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Jan 2021 19:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404189AbhAKXnX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jan 2021 18:43:23 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B724AC061794
        for <linux-pm@vger.kernel.org>; Mon, 11 Jan 2021 15:42:42 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id f132so432355oib.12
        for <linux-pm@vger.kernel.org>; Mon, 11 Jan 2021 15:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Byv4yeeKkAWUlNgWtR9WJhmRvDT7D9MJeHLwHQJ0UdU=;
        b=Njto5ZPxhyf0Rn1c8M8Mt78kivEYcxQakmUjN8sOSvICZYE6RS4YA43/GGBN/EHIZW
         jnCUFHtqH/XR1o+CbGUqoFiHBMWvt6TRa+o8T6CgLmsLxr/cRYZPZs01IotP5Y0OZbL1
         Xn2QekLyRbAeex/t8xpxuKLvVOP1hi/LN7ko4zBC71PnmTW4IuBHyTdt7D7pfe0Ua9CI
         e78w2HY4y2DRBMrCoLlpV2BzuuuDHosNDOfGfFYnAUFIPEKyeseIWiqxORTnhYC9Wlf8
         7pi+oyM8DXBszGz083g5zXIOC/tkD8g6MqFnOxSabF/+TWFlcf3qNeBI7abnUWpF9yrI
         isJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Byv4yeeKkAWUlNgWtR9WJhmRvDT7D9MJeHLwHQJ0UdU=;
        b=pxquBpeky7/pmvv685LpbdjeW7KNMxPnWBIXWdj3GUUI6zXKYIdG7Qxnk2D5Y4aSIe
         RSn6NgRO8c/RAcH1EYFBe8FyT0zbY4qllFST+4KfvLK6ZyuZ9O1w5WhhcDTfDXHEgT3f
         +oVSq7QW3Jcc/MfhxsU5HyUcPOOHsByY5w7swXfqrqJnWTPW0pBSroDdRYHLprxcE0SH
         0GsMNAo01jatLCeQW20J1xuhmluDsib8O4kiQ26AYeytBowUnsPsTM12f6oP22GuG+kP
         u/bLkV3VztqdvgLbGv6HbDIAofoBgFQPY9RsBecVcgOuR2xeGxwj6OMfM1lntDnuSQWx
         qp3w==
X-Gm-Message-State: AOAM532uzYRxU1SQwG9M0JipddYcJRhDt5BXwGx4zRze5MQsiXrr8btb
        5D6aHXDtp/rOLVbMjJArYUGQXQ==
X-Google-Smtp-Source: ABdhPJxN0FcCUJvUqpV9ny4+A645+PuCqUPRLJFm/k7zZ382PyRzeDZcjJKgwbpYX6CKhPDTVKgqlg==
X-Received: by 2002:aca:cc01:: with SMTP id c1mr774890oig.18.1610408562014;
        Mon, 11 Jan 2021 15:42:42 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id n16sm236777oop.9.2021.01.11.15.42.40
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 11 Jan 2021 15:42:41 -0800 (PST)
Date:   Mon, 11 Jan 2021 15:42:27 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Saravana Kannan <saravanak@google.com>
cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Hugh Dickins <hughd@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vincent Huang <vincent.huang@tw.synaptics.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andrew Duggan <aduggan@synaptics.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: 5.11-rc device reordering breaks ThinkPad rmi4 suspend
In-Reply-To: <CAGETcx_odme9ufTps6tctOW+zfOox6iXgTx_9GAjoYn=+jy1BQ@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2101111539070.2728@eggly.anvils>
References: <alpine.LSU.2.11.2101102010200.25762@eggly.anvils> <X/xV7ZV5jzI7RvAe@ulmo> <CAJZ5v0iriRkEN8dVJ9gE3+Wyn_96=SNhav1QaQ59i9O0genTNQ@mail.gmail.com> <X/x49o3EtrUh6vuO@ulmo> <CAJZ5v0hyvdcKsPJ7U5WioXb1c8Pg_F1BLC_dbKesFBLTUSiVaw@mail.gmail.com>
 <CAGETcx_odme9ufTps6tctOW+zfOox6iXgTx_9GAjoYn=+jy1BQ@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 11 Jan 2021, Saravana Kannan wrote:
> 
> I happen to have an X1 Carbon (different gen though) lying around and
> I poked at its /sys folders. None of the devices in the rmi4_smbus are
> considered the grandchildren of the i2c device. I think the real
> problem is rmi_register_transport_device() [1] not setting up the
> parent for any of the new devices it's adding.
> 
> Hugh, can you try this patch?

Just tried, but no, this patch does not help; but I bet
you're along the right lines, and something as simple will do it.

> 
> diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
> index 24f31a5c0e04..50a0134b6901 100644
> --- a/drivers/input/rmi4/rmi_bus.c
> +++ b/drivers/input/rmi4/rmi_bus.c
> @@ -90,6 +90,7 @@ int rmi_register_transport_device(struct
> rmi_transport_dev *xport)
> 
>         rmi_dev->dev.bus = &rmi_bus_type;
>         rmi_dev->dev.type = &rmi_device_type;
> +       rmi_dev->dev.parent = xport->dev;
> 
>         xport->rmi_dev = rmi_dev;
> 
> -Saravana
> 
> [1] - https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/input/rmi4/rmi_bus.c#n74
