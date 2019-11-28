Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4D210CB7F
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 16:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfK1PPI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 10:15:08 -0500
Received: from onstation.org ([52.200.56.107]:60694 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbfK1PPI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 28 Nov 2019 10:15:08 -0500
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 93F4F3EE8F;
        Thu, 28 Nov 2019 15:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1574954107;
        bh=MEIhUc/F/G+cWADyn9+I6oXtDgQZMmJDG1csxAj7jAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DvSOWQGvSDikU+trIVAcdW/xNayNwwWdZHbYb1BgcwJMRP2fVk/lWE5ALyqY+8jHz
         pwZkyeqCsj9u2yCwhk9FNlle4hYfRsESSu/CJzDgrnZHgF+U8w4ZMBuCtmDsEfxG86
         vio0qzwOr6kvlEXH3fzveOTTIvyiu5Z33kJh7THU=
Date:   Thu, 28 Nov 2019 10:15:07 -0500
From:   Brian Masney <masneyb@onstation.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, evgreen@chromium.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        daidavid1@codeaurora.org, sibis@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/2] interconnect: qcom: Use the standard aggregate
 function
Message-ID: <20191128151507.GB18117@onstation.org>
References: <20191128134839.27606-1-georgi.djakov@linaro.org>
 <20191128134839.27606-2-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128134839.27606-2-georgi.djakov@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 28, 2019 at 03:48:39PM +0200, Georgi Djakov wrote:
> Now we have a common function for standard aggregation, so let's use it,
> instead of duplicating the code.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Reviewed-by: Brian Masney <masneyb@onstation.org>
