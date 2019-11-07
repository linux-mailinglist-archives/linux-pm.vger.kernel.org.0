Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAA8F313E
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2019 15:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389314AbfKGOVP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Nov 2019 09:21:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:37024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726924AbfKGOVO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 7 Nov 2019 09:21:14 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7C65207FA;
        Thu,  7 Nov 2019 14:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573136474;
        bh=zrIHF7T3paXEpcMq7MV6AOWqqxFyxj9f/j+Oa24JGp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c4HeHac8PTx6WMnMwd4fYMcUhf0YK8e2NA/osYMyZyT5GirPSPLMf4wqToyntz14B
         1tnzc4TOoCO0XFtpTbbP1v5pvS3uaA5NfJq8p3Et7QytccOqsVO1upZbHVw7nR9nBd
         gNgy/hYr3h71tN6nqmf1Ptiopzilxl7IQkIeehAY=
Date:   Thu, 7 Nov 2019 15:21:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] interconnect changes for 5.5
Message-ID: <20191107142111.GB109902@kroah.com>
References: <5123bf54-5d62-fc5c-8838-17bc34487d83@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5123bf54-5d62-fc5c-8838-17bc34487d83@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 07, 2019 at 02:46:53PM +0200, Georgi Djakov wrote:
> Hi Greg,
> 
> This is a pull request with interconnect patches for the 5.5 merge window.
> All patches have been for a while in linux-next without reported issues. The
> details are in the signed tag. Please consider pulling into char-misc-next.

I don't know about
0003-interconnect-Disallow-interconnect-core-to-be-built-.patch here.
Shouldn't you just fix up the dependancies of subsystems that rely on
this?  We are moving more and more to kernels that "just work" with
everything as modules, even on arm64 systems.  So forbiding the
interconnect code from being able to be built as a module does not feel
good to me at all.

Same for
0007-interconnect-Remove-unused-module-exit-code-from-cor.patch, we are
adding module_init/exit() calls to modules, do not remove them!


Can you drop those two patches and resend?  Or I can just take these out
of the pull request and apply the rest as patches for now, if that's
easier for you to handle.

thanks,

greg k-h
