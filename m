Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F96D1E0956
	for <lists+linux-pm@lfdr.de>; Mon, 25 May 2020 10:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389319AbgEYItX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 May 2020 04:49:23 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:42965 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388182AbgEYItW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 May 2020 04:49:22 -0400
Received: by mail-oi1-f171.google.com with SMTP id l6so15447015oic.9;
        Mon, 25 May 2020 01:49:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5qd4JhElAe3z091uS7e1GwYMBB8ObuPCQBDSxEgdKVQ=;
        b=LXU9Fo5RGtzNk+9BrnDFd0pmWSXZRiUn6QQGQ8TVkWqbuUp5n57jdOdnG8776h3vRk
         QXeQrPWY3Q6B293ScWXnaAvWxh/nfgQ80BqOVeq2V3TuwAl0GNEahTQd7HfkTQ47JDwX
         H96xeA7BO3nj8v0j4D7YXK+5I0YC0N6mkFxlOeMrJrkTKtlzVabkwbyfhKO7ULA2evj2
         ZVp8D/M1SDXCJvFXrWnCn8pA8Lq1jtRyAs4h430hgjs74szsjLG5FyIvuhfOmJiVOtRr
         m1X9PbuCPuXMgbEOVNuUrWrDbQ0Sn8fJ7J8Rq6JyGoItG4XuI9nsxNVEvAtPk1bFg2aQ
         6mBw==
X-Gm-Message-State: AOAM5314O82UfF4Ck1ocrsGqu1CtXS93t8O1c0dHLB8LrhqM+w3j0DL1
        UfLc2asjKmxlqKS8gprQAH9kkLJFYiCbaIJ+NHESJw==
X-Google-Smtp-Source: ABdhPJw6Spt4qqKfu2lRfdhTsKwOc4XO0GKpo/Kd1MOA5Wn8wzEu38xyveRCXSUkPYZZWyOce0+T4n6Uo42MYkhp4I0=
X-Received: by 2002:aca:4254:: with SMTP id p81mr10082895oia.68.1590396561724;
 Mon, 25 May 2020 01:49:21 -0700 (PDT)
MIME-Version: 1.0
References: <7bf4d518-5772-9615-f925-8f9af4751d10@linuxfoundation.org>
In-Reply-To: <7bf4d518-5772-9615-f925-8f9af4751d10@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 25 May 2020 10:49:05 +0200
Message-ID: <CAJZ5v0jDUvLuq8Zhj+Dx_=rd75Y9mg28yDyX76=mrQoC5bqAhw@mail.gmail.com>
Subject: Re: [GIT PULL] cpupower update for Linux 5.8-rc1
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, May 23, 2020 at 1:15 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> Hi Rafael,
>
> Please pull the following cpupower update for Linux 5.8-rc1.
>
> This cpupower update for Linux 5.8-rc1 consists of a single
> patch to fix coccicheck unneeded semicolon warning.
>
> diff is attached.

Pulled, thanks!
