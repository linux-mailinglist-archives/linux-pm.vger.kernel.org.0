Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C563227F9C
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jul 2020 14:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbgGUMH6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jul 2020 08:07:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:36942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbgGUMH6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 21 Jul 2020 08:07:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E0F82080D;
        Tue, 21 Jul 2020 12:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595333277;
        bh=ZUjG13bq3yCzY2xs0gEEy4+MA9Axdzej9I8ZGgYBsJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nox/1oML+ERt68D4V4Xzqbz1esrKwwCJ0vpIacz/wyZnZKOdso42fO1u1xZQOPawz
         0TGT8xvFD9FyFg79kKg9RoEuJa3nUbiOJ9DWrp5PHrF2vMZG0BZ8jWh0o66WDoiDdy
         4t1znDong8UX6TgTmtw9f5ebq74qlm3NyGwtcPUQ=
Date:   Tue, 21 Jul 2020 14:08:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qiwu Huang <yanziily@gmail.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: Re: [PATCH v6 0/4] add some power supply properties about
 wireless/wired charging
Message-ID: <20200721120805.GA1819755@kroah.com>
References: <cover.1595329640.git.huangqiwu@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1595329640.git.huangqiwu@xiaomi.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 21, 2020 at 07:43:49PM +0800, Qiwu Huang wrote:
> From: Qiwu Huang <huangqiwu@xiaomi.com>
> 
> This patchset aims to provide power supply properties about wireless/wired charging.
> "quick_charge_type" reports different types of quick charge based on the charging power;
> "tx_adapter" shows" the type of wireless charging adapter;
> "signal_strength" shows the coupling level between TX and RX;
> "reverse_chg_mode" provides the interface of enabling/disabling wireless reverse charging.
> 
> Changes in v6
>  - Replace "phones" with "devices" suggested by GregKH
>  - Add permission statement for "reverse_chg_mode"
>  - Update description for "reverse_chg_mode" in ABI suggested by GregKH
>  - Update description for "PING phase" in ABI suggested by GregKH

Looks good, full series is:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
