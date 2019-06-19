Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D86194BCAE
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2019 17:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbfFSPWY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jun 2019 11:22:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:48308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbfFSPWX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 19 Jun 2019 11:22:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6288A2187F;
        Wed, 19 Jun 2019 15:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560957302;
        bh=KFT8Ipc2epwdydYPZBWt89RoYQ7frl6WZ/aK6S4sRms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A+akaE4DZWdYKhy+6u07liCyIyHerHONzLAQjA2Jl8ZQ3lcd7ipFWl0raEiZI3CGE
         x2PuTe3fo0x2+EFBQD4DavMpsAGQJBan+rkoxVH2rypdoUdMYDlgtFmN0X2BG+Wfto
         +LIaxz+5FFvZ81Ty7QGuC9K4g+Ix/TGGx/xYDstc=
Date:   Wed, 19 Jun 2019 17:15:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PM: sleep: Update struct wakeup_source documentation
Message-ID: <20190619151500.GA29425@kroah.com>
References: <9413171.SRfamDnp5r@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9413171.SRfamDnp5r@kreacher>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 19, 2019 at 12:48:15AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The kerneldoc comment for struct wakeup_source has become outdated,
> so fix that.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
