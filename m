Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 302454BFF3
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2019 19:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbfFSRlh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jun 2019 13:41:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:39238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729659AbfFSRlh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 19 Jun 2019 13:41:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4A8220645;
        Wed, 19 Jun 2019 17:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560966097;
        bh=ESmPDJyL52kdVl/UYapErd7HEurwkbOUPTEo2KJNGYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D0cuQM+VxywFQ0FkmDCdRxpNkixTWaj56EEjXp0JI4osyAE+m9SOcVRO7HRMKg24u
         ozbhJnJbEFR7sItxZPF1qVbw9L8i5f5PRXd5cjaAu1Q+odR9fxe/T3Sxh6bJX5sAoi
         klmDPwz8k8DxEAn2Btt9FmpPTS1s5hTy5PPIqUtA=
Date:   Wed, 19 Jun 2019 19:41:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ravi Chandra Sadineni <ravisadineni@chromium.org>
Cc:     len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Todd Broch <tbroch@google.com>, Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH] power: Do not clear events_check_enabled in
 pm_wakeup_pending()
Message-ID: <20190619174134.GA9441@kroah.com>
References: <20190607003735.212291-1-ravisadineni@chromium.org>
 <CAEZbON5oRSnOHQrzPcapd=XrK4_ngAY-7hTzxMOyO+=rWJB1bA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEZbON5oRSnOHQrzPcapd=XrK4_ngAY-7hTzxMOyO+=rWJB1bA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 14, 2019 at 11:23:31AM -0700, Ravi Chandra Sadineni wrote:
> Hi,
> 
> Just wanted to check if this o.k.

You seem to have forgoten to send this to the maintainer of this file :(

Please use scripts/get_maintainer.pl and resend it, remembering to send
it to Rafael next time :)

thanks,

greg k-h
