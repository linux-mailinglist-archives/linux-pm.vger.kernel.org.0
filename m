Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE87770485
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2019 17:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbfGVPvU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jul 2019 11:51:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54366 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfGVPvU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jul 2019 11:51:20 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E8BFA61C0D; Mon, 22 Jul 2019 15:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563810679;
        bh=rBf/mqWfKN7U2zd3m4iikSbifwekc4iKWTNDZ8h6ew0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YIEEIbEnjVapuouGfIp/VVyD3UWeXPGlmGmS7uduHj1ndwiy57aLDm33fA7+E7G2H
         /VgNuLDrHmbP0Qc7gwbqRYceNSU9WLkCYjjUYRoN+acgr2ABfp5PRy1LGPWDvPAJSm
         X0ZQ4hZV18RLKgPnHY1A5aD9GBOkEdm8dTBzmAJs=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 726F161A49;
        Mon, 22 Jul 2019 15:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563810677;
        bh=rBf/mqWfKN7U2zd3m4iikSbifwekc4iKWTNDZ8h6ew0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CX2aHSFOyGUW+vWd/GPyfFBjHoOuvFbBvyUxT4wbTKtp9VHfWQBD5h0useAo9o9xz
         ZUNntl2J84Wgkrc9WLOp9jYHAAuPQWH9dxvAZRuyChSNYqUjm57TKOmFzEznbkkItR
         MeJ/DLLLU86CkmJMxnaWOTE6/sJthp7Q0ZFTlcdY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 726F161A49
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Mon, 22 Jul 2019 09:51:16 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     andy.gross@linaro.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        mkshah@codeaurora.org
Subject: Re: [PATCH 2/2] drivers: qcom: rpmh-rsc: fix read back of trigger
 register
Message-ID: <20190722155116.GF25567@codeaurora.org>
References: <20190701152907.16407-1-ilina@codeaurora.org>
 <20190701152907.16407-2-ilina@codeaurora.org>
 <5d320a79.1c69fb81.17c57.b9ba@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5d320a79.1c69fb81.17c57.b9ba@mx.google.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 19 2019 at 12:22 -0600, Stephen Boyd wrote:
>Quoting Lina Iyer (2019-07-01 08:29:07)
>> When triggering a TCS to send its contents, reading back the trigger
>> value may return an incorrect value. That is because, writing the
>> trigger may raise an interrupt which could be handled immediately and
>> the trigger value could be reset in the interrupt handler. By doing a
>> read back we may end up spinning waiting for the value we wrote.
>
>Doesn't this need to be squashed into the patch that gets rid of the
>irqs disabled state of this code? It sounds an awful lot like this
>problem only happens now because the previous patch removed the
>irqsave/irqrestore code around this function.
>

True. Could be rolled into that fix.

--Lina
