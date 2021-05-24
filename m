Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5366638E5C0
	for <lists+linux-pm@lfdr.de>; Mon, 24 May 2021 13:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbhEXLr1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 May 2021 07:47:27 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:51094 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbhEXLr0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 May 2021 07:47:26 -0400
X-Greylist: delayed 397 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 May 2021 07:47:25 EDT
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id AA9DF3F5C5;
        Mon, 24 May 2021 13:39:18 +0200 (CEST)
Authentication-Results: pio-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=flawful.org header.i=@flawful.org header.b="WoCK2IgX";
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NO_RELAYS=-0.001,
        URIBL_BLOCKED=0.001] autolearn=ham autolearn_force=no
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fJFEFzrhEmgJ; Mon, 24 May 2021 13:39:17 +0200 (CEST)
Received: by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 79B0B3F52E;
        Mon, 24 May 2021 13:39:15 +0200 (CEST)
Received: by flawful.org (Postfix, from userid 1001)
        id 5BA316B7; Mon, 24 May 2021 13:39:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flawful.org; s=mail;
        t=1621856355; bh=rAafNi0SZ2NEjOf8TkXLBcHHsXGUwxyvQxpUbPEPfi4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WoCK2IgXRO/aRLqBX5GWYKVXfgHMnSApkw5u7YyC76cgLZiV/6/j9DYiQWtK7hCqA
         J8f37bCC7+N9Y/Py4fm2u9GoSGBxNzc2M2CojL0gsfJAJ3Ggq08vhAurq1BUKpfFdX
         rybaOWCYWJwNl6FD53xcS81mnKETfT8ygSLt7inA=
Date:   Mon, 24 May 2021 13:39:15 +0200
From:   Niklas Cassel <nks@flawful.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] PM: AVS: qcom-cpr: Use
 nvmem_cell_read_variable_le_u32()
Message-ID: <20210524113914.GA5000@flawful.org>
References: <20210521134437.v2.1.Id1c70158722750aec0673d60c12e46a9c66bbfed@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521134437.v2.1.Id1c70158722750aec0673d60c12e46a9c66bbfed@changeid>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 21, 2021 at 01:44:53PM -0700, Douglas Anderson wrote:
> Let's delete the private function cpr_read_efuse() since it does the
> basically the same thing as the new API call
> nvmem_cell_read_variable_le_u32().
> 
> Differences between the new API call and the old private function:
> * less error printing (I assume this is OK).
> * will give an error if the value doesn't fit in 32-bits (the old code
>   would have truncated silently).
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> I haven't done any more than compile-test this. Mostly I'm just
> writing this patch because it helped provide inspiration for the
> general API function.
> 
> Changes in v2:
> - Resending v1 as a singleton patch; dependency is merged in mainline.
> 
>  drivers/soc/qcom/cpr.c | 43 +++++-------------------------------------
>  1 file changed, 5 insertions(+), 38 deletions(-)

Acked-by: Niklas Cassel <nks@flawful.org>
