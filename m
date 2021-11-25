Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD6645DF40
	for <lists+linux-pm@lfdr.de>; Thu, 25 Nov 2021 17:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348451AbhKYRBP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Nov 2021 12:01:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:44602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356653AbhKYQ7N (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 25 Nov 2021 11:59:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE0C76109D;
        Thu, 25 Nov 2021 16:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637859362;
        bh=O9v3Njtq80tAl0M9abbGC4xtAJmpzOAZo/aqUsyRDeA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pUZCyHZn2w3bK4Ur11Mhh33VFig+RQIpj9x4WG+CvQa68Nbj3hT3cjrhtrHgpE4qh
         EEG7lugfiJWW/2jVtTct+8Y8rlQ5UzUVPEnPgLLjxJcH3AvZVa46aexaUkxzgT6Uke
         rJQzID+gzC/TlsKYIrkssrS1pWGt8KjBughVDrXg=
Date:   Thu, 25 Nov 2021 17:55:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Subject: Re: [PATCH 2/2] powercap/drivers/dtpm: Reduce trace verbosity
Message-ID: <YZ/AG5N9AGksA3Ev@kroah.com>
References: <20211123101601.2433340-1-daniel.lezcano@linaro.org>
 <20211123101601.2433340-2-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123101601.2433340-2-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 23, 2021 at 11:16:01AM +0100, Daniel Lezcano wrote:
> The traces when registering a powerzone is at the pr_info level and
> should be changed to pr_debug as requested by Greg-KH.
> 
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Link: https://lkml.kernel.org/r/YGAnRx8SiZHFPpY6@kroah.com
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/powercap/dtpm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
