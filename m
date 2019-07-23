Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0517124D
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 09:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732688AbfGWHHt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 03:07:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:46008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731529AbfGWHHt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Jul 2019 03:07:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B39842238C;
        Tue, 23 Jul 2019 07:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563865668;
        bh=R51oED/kbi1NG+A/4qG7UsyTgwSIDi4AsjmGHkykhS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L0ZakudK7REOGlFNg1bv0568qou4UshQp5gA8ZtO0osiaH5ecS0uzDYy0SD7r5tTI
         Qa3BRl2ORreXdWp3en2PVcmxIRgP/V4i+GmY1EGJYBTvkYJcGkO3z/kP5PGZTjMaR6
         A6HgrrzFCuIJlkRjCGDzSXTw7WjwMGnQBuGoS7zI=
Date:   Tue, 23 Jul 2019 09:07:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ravi Chandra Sadineni <ravisadineni@chromium.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, rjw@rjwysocki.net, pavel@ucw.cz,
        len.brown@intel.com, bhe@redhat.com, dyoung@redhat.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        tbroch@chromium.org
Subject: Re: [PATCH 2/2 V2] power:sysfs: Expose device wakeup_event_count.
Message-ID: <20190723070745.GF27629@kroah.com>
References: <20190722182451.GB24412@kroah.com>
 <20190722223337.36199-1-ravisadineni@chromium.org>
 <20190722223337.36199-3-ravisadineni@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722223337.36199-3-ravisadineni@chromium.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 22, 2019 at 03:33:37PM -0700, Ravi Chandra Sadineni wrote:
> Device level event_count can help user level daemon to track if a
> praticular device has seen an wake interrupt during a suspend resume
> cycle. Thus expose it via sysfs.
> 
> Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
> ---
> V2: Address comments from patchset 1.

You didn't address my comment about locks :(
