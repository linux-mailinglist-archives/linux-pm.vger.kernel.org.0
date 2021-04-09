Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372663597D6
	for <lists+linux-pm@lfdr.de>; Fri,  9 Apr 2021 10:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbhDIIaB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Apr 2021 04:30:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:54460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229696AbhDIIaA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 9 Apr 2021 04:30:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 31EA861105;
        Fri,  9 Apr 2021 08:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617956988;
        bh=Sdny1LZSGXQ2GdZwEshNQkM1dXaHUGh70H8n+JDMBCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HaUFUPYEJ7M3W/RLs++Sa+BiX5LnBmNfXxZfJdJipYinu74LbMuRgaXaixbkBTZpR
         aRw9kEb0AVLWwbcBf9uYQByTGa00RsXWtnmDE5O11gIVRzbJJRKks+u0gxH1RJYlIS
         AA/M/DV8spjeuCxCrPYWSDwCsQz+BYBRBeDL8mWXIrTxdohXs4HyNbARr337iOvsZK
         dIytfkMerEMhDLfIFw4DbuLbaSsXLLnzvgCyjs+njctHjYms5Fu2STqAjyfeCJtzVC
         QkSDMEH6W2Yv74eHOG59nvdxzo8RtnTDGFBBGuet6Jl1g1d9FWHJMNZ/fTFVWPnPJQ
         BavOIQFkpg9Bw==
Received: by pali.im (Postfix)
        id C975282E; Fri,  9 Apr 2021 10:29:45 +0200 (CEST)
Date:   Fri, 9 Apr 2021 10:29:45 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [RESEND PATCH mvebu v3 00/10] Armada 37xx: Fix cpufreq changing
 base CPU speed to 800 MHz from 1000 MHz
Message-ID: <20210409082945.aa5yp5kiqg4gf6jt@pali>
References: <20210408114223.8471-1-pali@kernel.org>
 <CAKohpomAv8GbEz88HVf8iftWyLC_wNLYgTJMq72MHXO_E1FgRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKohpomAv8GbEz88HVf8iftWyLC_wNLYgTJMq72MHXO_E1FgRA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Friday 09 April 2021 13:19:11 Viresh Kumar wrote:
> On Thu, 8 Apr 2021 at 17:12, Pali Rohár <pali@kernel.org> wrote:
> 
> You haven't sent patch 1/10 or something went wrong somewhere.
> Please send it in reply to the cover letter, so everything appears connected.

Hello Viresh! I have written in cover letter that I have not resent
patch 01/10 because it is DTS patch and was already applied into Gregory
mvebu/dt64 tree.
