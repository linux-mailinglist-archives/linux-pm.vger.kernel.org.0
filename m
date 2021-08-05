Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C463E1007
	for <lists+linux-pm@lfdr.de>; Thu,  5 Aug 2021 10:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239263AbhHEIO0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Aug 2021 04:14:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:39496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236074AbhHEIO0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Aug 2021 04:14:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C25FB6104F;
        Thu,  5 Aug 2021 08:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628151252;
        bh=Q0YqDGXr1jIA+Z+GfTuSZpm4xXfEgayhYHZa/aAnD9c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B9PdUaN/YTIfDqmC4DBcIzv1hltyvUyX0EYoBWeTrxgjTcRgN0kuCQnckcp9ILFav
         bv1GNoxQTpenFFXYPftVajZ4KLnY78/IDxx4D1nVReHEgr0F2+jeroXqv1y9R+BW4j
         rRH6XpOiLsu006vhPWPkzEpGKsh4Patkkm6j7nWI=
Date:   Thu, 5 Aug 2021 10:14:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?5ZCnIeeOi+Wptw==?= <zxc52fgh@gmail.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangting11 <wangting11@xiaomi.com>
Subject: Re: [PATCH v11 0/4] add some power supply properties about
 wireless/wired charging
Message-ID: <YQud0cUxbUL+8/E8@kroah.com>
References: <cover.1627992564.git.wangting11@xiaomi.com>
 <YQqCNKoLdwaCjmIl@kroah.com>
 <CAA=jPj2RVcQ3eyrcu2=2uPrZoTU0ffB9vsM-bpy8yGOu2w8odQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA=jPj2RVcQ3eyrcu2=2uPrZoTU0ffB9vsM-bpy8yGOu2w8odQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Thu, Aug 05, 2021 at 10:29:08AM +0800, 吧!王婷 wrote:
> Hi Greg,
> 
>  A demo of “The usage of quick charge type property” is uploaded in
> PATCH v11 1/4 drivers/power/supply/qcom_smbb.c.
> 
> 
> The usage of the other three properties is about wireless charging.The
> code of our driver can refer to the link below.
> 
> POWER_SUPPLY_PROP_QUICK_CHARGE_TYPE：
> https://github.com/MiCode/Xiaomi_Kernel_OpenSource/blob/umi-q-oss/drivers/power/supply/qcom/qpnp-smb5.c#L1434
> 
> POWER_SUPPLY_PROP_REVERSE_CHG_MODE：
> https://github.com/MiCode/Xiaomi_Kernel_OpenSource/blob/umi-q-oss/drivers/power/supply/qcom/qpnp-smb5.c#L2572
> 
> POWER_SUPPLY_PROP_TX_ADAPTER：
> https://github.com/MiCode/Xiaomi_Kernel_OpenSource/blob/umi-q-oss/drivers/power/supply/qcom/qpnp-smb5.c#L2633
> 
> POWER_SUPPLY_PROP_SIGNAL_STRENGTH：
> https://github.com/MiCode/Xiaomi_Kernel_OpenSource/blob/umi-q-oss/drivers/power/supply/qcom/qpnp-smb5.c#L2609

Wonderful, please submit these drivers to be merged as part of this
patch series and all should be good.

Otherwise, please realize that we can not support out-of-tree drivers at
all, that way lies madness and a kernel that we can never support well
over time.

thanks,

greg k-h
