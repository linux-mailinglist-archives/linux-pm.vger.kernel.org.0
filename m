Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C231434F015
	for <lists+linux-pm@lfdr.de>; Tue, 30 Mar 2021 19:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbhC3Rt0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Mar 2021 13:49:26 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:30041 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232463AbhC3RtP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Mar 2021 13:49:15 -0400
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 30 Mar 2021 10:49:15 -0700
X-QCInternal: smtphost
Received: from gurus-linux.qualcomm.com (HELO gurus-linux.localdomain) ([10.46.162.81])
  by ironmsg01-sd.qualcomm.com with ESMTP; 30 Mar 2021 10:49:14 -0700
Received: by gurus-linux.localdomain (Postfix, from userid 383780)
        id 79326192B; Tue, 30 Mar 2021 10:49:14 -0700 (PDT)
Date:   Tue, 30 Mar 2021 10:49:14 -0700
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] thermal: qcom-spmi-temp-alarm: add support for
 GEN2 rev 1 PMIC peripherals
Message-ID: <20210330174914.GA28865@codeaurora.org>
References: <944856eb819081268fab783236a916257de120e4.1596040416.git.gurus@codeaurora.org>
 <69c90a004b3f5b7ae282f5ec5ca2920a48f23e02.1596040416.git.gurus@codeaurora.org>
 <159661011044.1360974.2399567989389491381@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159661011044.1360974.2399567989389491381@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 04, 2020 at 11:48:30PM -0700, Stephen Boyd wrote:
> Quoting Guru Das Srinagesh (2020-07-29 09:52:52)
> > From: David Collins <collinsd@codeaurora.org>
> > 
> > Add support for TEMP_ALARM GEN2 PMIC peripherals with digital
> > major revision 1.  This revision utilizes a different temperature
> > threshold mapping than earlier revisions.
> > 
> > Signed-off-by: David Collins <collinsd@codeaurora.org>
> > Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> > ---
> 
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>

+ Daniel Lezcano

Hi Daniel,

I just checked Linus' tree and discovered that this patch has not been
applied - only the other patch in this series. Since this patch has been
reviewed already, could you please check if it's good to be applied as
well?

Thank you.

Guru Das.
