Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4FE264C28
	for <lists+linux-pm@lfdr.de>; Thu, 10 Sep 2020 20:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgIJSC5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Sep 2020 14:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgIJSCX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Sep 2020 14:02:23 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C3DC061573;
        Thu, 10 Sep 2020 11:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bRi4N5vLxoScsFjTWSVX3rfTP6F8SdP0zUyXpfsqsa4=; b=nOiMmiMrtN83A2i9SuwjSG1xUA
        X8hMVPZQ4xzv5VoomT9q25ADTLfgin9O8HmN8WR/S+aUD3FsTPzFlX7VmRi7MDXrsIovqurVvyrsR
        Bg4Fq/SwBlGFByssTJ90CZAs0yqm352bw47JNEd5/hQZ9P9oKiDIOulsVYpOk1KH/OZ8=;
Received: from p200300ccff0e43001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0e:4300:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1kGQtN-0006Gq-DC; Thu, 10 Sep 2020 20:01:53 +0200
Date:   Thu, 10 Sep 2020 20:01:52 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-pm@vger.kernel.org, aford@beaconembedded.com,
        hns@goldelico.com, kernel test robot <lkp@intel.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/2] thermal: ti-soc-thermal: Enable addition power
 management
Message-ID: <20200910200152.72cc5d9f@aktux>
In-Reply-To: <20200819125925.2119434-1-aford173@gmail.com>
References: <20200819125925.2119434-1-aford173@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 19 Aug 2020 07:59:23 -0500
Adam Ford <aford173@gmail.com> wrote:

> The bandgap sensor can be idled when the processor is too, but it
> isn't currently being done, so the power consumption of OMAP3
> boards can elevated if the bangap sensor is enabled.
> 
> This patch attempts to use some additional power management
> to idle the clock to the bandgap when not needed.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
> V2: Fix issue where variable stating the suspend mode isn't being
>     properly set and cleared.
> 
hmm, it is not in linux-next. Can we expect that for v5.10?

Regards,
Andreas
