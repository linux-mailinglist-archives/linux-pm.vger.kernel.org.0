Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B103D87D1
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jul 2021 08:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbhG1GX3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Jul 2021 02:23:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:58976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231199AbhG1GX3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 28 Jul 2021 02:23:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28D0760F58;
        Wed, 28 Jul 2021 06:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627453407;
        bh=cTCAGOAsBM2oppNycnqCbmguMrkUmbR1fWFIwmzyIGQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pwz2U7A1Xk7KnM9ZD6ft+yKfDWN6/0O7eBT+0Jw6vmli6jO7Kkxf68F6HHOAyhAOD
         tcagIFxRuKqF5GFtM152hT8CLhtpAp+mJEY9oqCBbnF59L3GkKfVsA18k6rambr98+
         ks429uE1djsXvWh0MNzbKhQi4gCD57HUuBRe+ff4=
Date:   Wed, 28 Jul 2021 08:23:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: PM: add two device managed helpers
Message-ID: <YQD33b6kjSk3AIAa@kroah.com>
References: <20210727210202.717181-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727210202.717181-1-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 28, 2021 at 12:02:00AM +0300, Dmitry Baryshkov wrote:
> Qualcomm clock controller code (and most probably other drivers) would
> benefit from having devres helpers for pm_runtime_enable() and
> pm_clk_create(). Add those two helpers.
> 

I do not want to add new "helpers" without seeing them actually used in
the kernel at the same time, so that we can verify they work and make
code easier to understand.

So please feel free to resubmit this as a patch series that uses them,
adding apis that no one uses is not a good idea.

thanks,

greg k-h
