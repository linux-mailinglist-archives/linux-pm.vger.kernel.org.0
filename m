Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E04313488D
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2020 17:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbgAHQxZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jan 2020 11:53:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:52668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729507AbgAHQxZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Jan 2020 11:53:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC5DC20678;
        Wed,  8 Jan 2020 16:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578502405;
        bh=H1p2fX0nJsbb077d4AW19/aUlVCtej1nlRBJlhvXO6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kGvq+LCWZ5RGwV4CLf34HMsMWWhbQSQghxfjXbSvb32sMeWAl7NRpLjFR/N+QuM1x
         j4em6ezD2Yuu4Wvh5C6pF/AIxCmoWg0Xsw2Owm6NSZyM4Fkyy78uXMuRQtVA2VCuQP
         8nWIBtD0vLTlStF1Z2EqxtObEgS24JK/MHunBSmM=
Date:   Wed, 8 Jan 2020 17:53:23 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>, od@zcrc.me,
        linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: common: usb-conn-gpio: Register charger
Message-ID: <20200108165323.GA2506374@kroah.com>
References: <20200107002901.940297-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107002901.940297-1-paul@crapouillou.net>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jan 07, 2020 at 01:29:01AM +0100, Paul Cercueil wrote:
> Register a power supply charger, whose online state depends on whether
> the USB role is set to device or not.

That says _what_ you are doing, but I have no idea _why_ you want to do
this.

What is this going to cause to have happen?  What new userspace api is
going to result?  What will a user do with this?

Is this going to always show up, no matter if the role is not even
relevant for a power supply?

You need a lot more text here to make this mergable.

thanks,

greg k-h
