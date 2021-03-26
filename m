Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A46F34AA6A
	for <lists+linux-pm@lfdr.de>; Fri, 26 Mar 2021 15:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhCZOtO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Mar 2021 10:49:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:53434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229839AbhCZOso (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 26 Mar 2021 10:48:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFF2561A05;
        Fri, 26 Mar 2021 14:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616770124;
        bh=Sn21efNseA5j0bpRvtff1pm/MoN2WZ/SnjDGYElzwFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sSzA6sLwrXyYAqyOAE42+KoRWgWZNletaWCW0M2nAfyD1YQwB7KUTJM12pdwEElxN
         MUNF6hvY8QY2sydd3OEhHGQ8qM21rAIPm1EryDEkUXT1nN1cNxOmNJPGJuQKicefts
         HX9fw5m0E7tb2If9u+T9CAtkBDQ+nqk8b4BXlXxg=
Date:   Fri, 26 Mar 2021 15:48:41 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] power: supply: axp20x_usb_power: fix work-queue init
Message-ID: <YF30Sf0Z8mSjA0s+@kroah.com>
References: <cover.1616574973.git.matti.vaittinen@fi.rohmeurope.com>
 <a774ca25010b7c932c07f22ce8a548466705c023.1616574973.git.matti.vaittinen@fi.rohmeurope.com>
 <20210324102506.3ta2zstmrwq4wswb@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324102506.3ta2zstmrwq4wswb@earth.universe>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 24, 2021 at 11:25:06AM +0100, Sebastian Reichel wrote:
> Hi,
> 
> On Wed, Mar 24, 2021 at 11:21:34AM +0200, Matti Vaittinen wrote:
> > The commit 6d0c5de2fd84
> > ("power: supply: Clean-up few drivers by using managed work init")
> > Re-introduced wrong order of initializing work-queue and requesting
> > the IRQs which was originally fixed by the commit b5e8642ed95f
> > ("power: supply: axp20x_usb_power: Init work before enabling IRQs")
> > 
> > In addition this caused the work queue to be initialized twice.
> > 
> > Fix it again.
> > 
> > Fixes: 6d0c5de2fd84 ("power: supply: Clean-up few drivers by using managed work init")
> > 
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > Reported-by: Chen-Yu Tsai <wens@csie.org>
> > ---
> 
> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> 
> Needs to be merged by Greg, since I do not have 6d0c5de2fd84 in
> my tree.

Now merged, thanks.

greg k-h
