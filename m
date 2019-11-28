Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A487C10CB7B
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 16:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfK1PPC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 10:15:02 -0500
Received: from onstation.org ([52.200.56.107]:60678 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbfK1PPB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 28 Nov 2019 10:15:01 -0500
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id E78CA3E99D;
        Thu, 28 Nov 2019 15:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1574954101;
        bh=/c81pNolHCMZve856QRR3BeJWpuzT+iELri5cZmkeQ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LW3xHrVNbPyIGqHhS9MB8Juft0qu5DZiP+y5AR0h0Ft0BG16eB55hbyzYpU9Uiqnj
         xVa88jGwxER+3Iy/ASU1vNEbt64gPwTwOn4Bm+i6BnYW9pSeUuzaFpcLrmN1W4q4QU
         ZWQB9Yh2VIvjCfAnUG+/NHkFnbp/AICCweG3EYDg=
Date:   Thu, 28 Nov 2019 10:15:00 -0500
From:   Brian Masney <masneyb@onstation.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, evgreen@chromium.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        daidavid1@codeaurora.org, sibis@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/2] interconnect: Add a common standard aggregate
 function
Message-ID: <20191128151500.GA18117@onstation.org>
References: <20191128134839.27606-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128134839.27606-1-georgi.djakov@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 28, 2019 at 03:48:38PM +0200, Georgi Djakov wrote:
> Currently there is one very standard aggregation method that is used by
> several drivers. Let's add this as a common function, so that drivers
> could just point to it, instead of copy/pasting code.
> 
> Suggested-by: Evan Green <evgreen@chromium.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Reviewed-by: Brian Masney <masneyb@onstation.org>

