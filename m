Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9711C2A0553
	for <lists+linux-pm@lfdr.de>; Fri, 30 Oct 2020 13:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgJ3M1Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Oct 2020 08:27:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:50268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbgJ3M1A (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 30 Oct 2020 08:27:00 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9B8F20728;
        Fri, 30 Oct 2020 12:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604060778;
        bh=BdHjvJbrsdz6JTaL52s8Ddha3XR9mxfPJxJWvqQgQVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oRBRqnhNPZ++VanpBAwLCxAFqSknHsJoL/oEEvjhXLG2OqKUa/wlWBXx0eG5JZPLn
         OQZH1WjX/amNRM0cIjEsI6QAuwA65XlCFY4R1JPo89Y8NvX3vDQHWaMV8Ci9+Gdc1l
         r3SUAW5vqjdWqO9bhtl66NuVeg/0fpLZahv3YbA4=
Date:   Fri, 30 Oct 2020 13:26:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect fixes for 5.10
Message-ID: <20201030122650.GA2545459@kroah.com>
References: <20201030112110.2362-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030112110.2362-1-georgi.djakov@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 30, 2020 at 01:21:10PM +0200, Georgi Djakov wrote:
> Hello Greg,
> 
> Here is a pull request with interconnect fixes for 5.10-rc. Please
> take them into char-misc-linus when possible. All patches have been
> in linux-next with no reported issues.
> 
> Thanks,
> Georgi
> 
> The following changes since commit 86d6e5793e0fa3a510cff466894d0d3051fd716e:
> 
>   interconnect: imx: simplify the return expression of imx_icc_unregister (2020-09-21 11:15:02 +0300)

Pulled and pushed out, thanks.

greg k-h
