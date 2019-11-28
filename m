Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2A1210CB84
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 16:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfK1PPg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 10:15:36 -0500
Received: from onstation.org ([52.200.56.107]:60716 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbfK1PPg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 28 Nov 2019 10:15:36 -0500
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id DA3D23EE8C;
        Thu, 28 Nov 2019 15:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1574954135;
        bh=CpuXn/1YuVR1thvz9vWG1G71nhfeLIpEDAFoJfvL0rY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Drs4fjWxdOVDm3ua1lPGFAi0pCzKM9XKe9royO0rhFS/hgGadjFOJftXIHIGjhQRA
         lsQGPPTwGOAv2tHNdwOgJoqFmzrMWD7e8o96Xh8A/BSMCpBiFwzRP7HgziKlo4SaR4
         P6fY/3UrWidq+vXoy25fh7AxbBBAjSseJFp+f/ms=
Date:   Thu, 28 Nov 2019 10:15:35 -0500
From:   Brian Masney <masneyb@onstation.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, bjorn.andersson@linaro.org,
        agross@kernel.org, digetx@gmail.com, evgreen@chromium.org,
        daidavid1@codeaurora.org, sibis@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/5] interconnect: qcom: msm8974: Walk the list safely on
 node removal
Message-ID: <20191128151535.GC18117@onstation.org>
References: <20191128133435.25667-1-georgi.djakov@linaro.org>
 <20191128133435.25667-3-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128133435.25667-3-georgi.djakov@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 28, 2019 at 03:34:33PM +0200, Georgi Djakov wrote:
> As we will remove items off the list using list_del(), we need to use the
> safe version of list_for_each_entry().
> 
> Fixes: 4e60a9568dc6 ("interconnect: qcom: add msm8974 driver")
> Reported-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Reviewed-by: Brian Masney <masneyb@onstation.org>
