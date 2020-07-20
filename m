Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8802259E3
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jul 2020 10:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgGTIUv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jul 2020 04:20:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:45676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbgGTIUt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 20 Jul 2020 04:20:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C315C20709;
        Mon, 20 Jul 2020 08:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595233249;
        bh=WQScxDVLUlB94XEZg3B0RJYm62O72Z0/Q5oNhbdJcEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F7IsKAmwCM1kfdjIhZRdJopD9z0T5M0Gb3v9LZAkIzyEbVyXnYY08MfLMUJXY3Xt6
         GkPoKQmpCuICywWlNGoR/xE3j31lizH7iTWGx4C0hk12Ag/9ZgxDsN5Z/B7P3h95tO
         NhOiDNa+0h3Tdb+q7pLnG2JQpBZYtsLsR4EOa0jA=
Date:   Mon, 20 Jul 2020 10:21:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qiwu Huang <yanziily@gmail.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: Re: [PATCH v4 0/4] add some power supply properties about
 wireless/wired charging
Message-ID: <20200720082100.GA720171@kroah.com>
References: <cover.1595214246.git.huangqiwu@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1595214246.git.huangqiwu@xiaomi.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 20, 2020 at 01:47:13PM +0800, Qiwu Huang wrote:
> From: Qiwu Huang <huangqiwu@xiaomi.com>
> 
> quick_charge_type reports quick charge type based on charging power.
> tx_adapter shows wireless charging adapter type.
> signal_strength shows degree of coupling between tx and rx when wireless charging.
> reverse_chg_mode supply interface to enable/disable wireless reverse charging.
> 
> Qiwu Huang (4):
>   power: supply: core: add quick charge type property
>   power: supply: core: add wireless charger adapter type property
>   power: supply: core: add wireless signal strength property
>   power: supply: core: property to control reverse charge

What changed from the previous versions of this series?  Normally you
either include that in the 0/X email, or in the individual patches.  I
don't see that in either place in this series :(

See the many examples of how this is done by looking at other patches on
the mailing lists and in the submitting patches documentation.

thanks,

greg k-h
