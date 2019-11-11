Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02B12F6E0A
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 06:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfKKF0I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 00:26:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:38552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbfKKF0H (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 11 Nov 2019 00:26:07 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C77D820856;
        Mon, 11 Nov 2019 05:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573449967;
        bh=H+9NY5NoBtSDcrU2DUVT7MbY08MFMHKqvmh7Or5JfDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I2z9H+P9QHWnDiLHkQ602ePx3T2AzdbGBjrjITJc+ua1aGvNv0XWhJeYVeA5W0Zs1
         cLxaLezk+WtYVQdE7I4AuwWRqeKHu/DVmcSNNBSJlR4/xTPakxwyfClrxPXJxfVdvo
         mJxd8AL37rzHnGIkFSlZxM1VGU5C5tTw4ooQ8xvo=
Date:   Mon, 11 Nov 2019 06:26:01 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] interconnect changes for 5.5
Message-ID: <20191111052601.GA3176397@kroah.com>
References: <5123bf54-5d62-fc5c-8838-17bc34487d83@linaro.org>
 <20191107142111.GB109902@kroah.com>
 <0cb5a6a6-399f-99e3-dc41-50114eea4025@linaro.org>
 <20191108103917.GB683302@kroah.com>
 <CAOCOHw4d0q3uGTAh_UrNWr+Wi6ObDKUFn7M_zkD8cFTkNFEUDA@mail.gmail.com>
 <20191109084820.GC1289838@kroah.com>
 <CAOCOHw4AFz2Rj3sLTrboA0pBOkL_5MbitJnFHgBYaVBbWyYATw@mail.gmail.com>
 <20191110101647.GA1441986@kroah.com>
 <20191111045423.rnhmv7uzhabgtebq@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111045423.rnhmv7uzhabgtebq@vireshk-i7>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 11, 2019 at 10:24:23AM +0530, Viresh Kumar wrote:
> On 10-11-19, 11:16, Greg Kroah-Hartman wrote:
> > Ah, now I get it.  Yeah, that sucks.  We need a "shortcut" in Kconfig to
> > express that type of dependancy.
> 
> So we are going to merge this patch for now ?

I did not, sorry.

greg k-h
