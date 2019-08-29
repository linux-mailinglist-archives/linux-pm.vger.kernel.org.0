Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87F9CA1CB2
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2019 16:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfH2O25 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Aug 2019 10:28:57 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:41730 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfH2O25 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Aug 2019 10:28:57 -0400
Received: by mail-vs1-f67.google.com with SMTP id m62so2531575vsc.8
        for <linux-pm@vger.kernel.org>; Thu, 29 Aug 2019 07:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mIpyQ3wOb9bWqvkX0Kpr4MtQFBTIPyZmoRnHAHX/iC4=;
        b=lHE8RghiwfW1Za7MXZfEj+tcRA5+wrEWmVF5Keow8qTDcQOlGf4062XfDSUn6uEXDh
         lZNKY9YudWj2VwmIGrrk0z96f7MCwqTmToJ0qUx7s9qo5fMEKYT63v3iilBq/ykKVI0k
         4uQGf2L0Qu4GxqfenZnbk3+E1Hyft/0qcstmSQbMSOP0hSUEeCdV4ho5986Zq2vC8vFd
         /3xTmD1TXSCXRTRhGGM9PJzXP4mIJTDL8Uz9uL0aFnR4Pv2X7S+q6R+YjGzN16IA04xd
         G/zNaTE1nZDJiQiJwhAZUOdxXwX36xfy+KGbSTMV406iQO+PaEU3HTP2Bd2sUPzNjmH9
         9DGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mIpyQ3wOb9bWqvkX0Kpr4MtQFBTIPyZmoRnHAHX/iC4=;
        b=ENLizzogJWsAI/X2SeY1Da0Ttwy7cgprNaEgubfDumlonVEuESl3w1Rq8Q8RZ3Pa/8
         jcVRHqEmWkrE7jOG7+er33y6Z6uGSww74RXG/z7IiReo/eeB4fjwIi+XGJwTrK2ar34g
         SZniJ1BYIWEfetnIEyKGPU5kX9elpIFy6HNko4frEOBXS/doedvbuKazAaIHwl3hGRDu
         dRSGrX8mJogb5kuwqbpnNCVPFP2d1QwTRCJFiFSeybaVjg+MJQlisbIdGPNvUeiCFjB/
         +AVFmAUk9OL+5ofrt++26kDl/bJTV8JSGfaBCFmOmYYgBdcoEJzvPGEUif9Asw/NX1Xc
         zKMQ==
X-Gm-Message-State: APjAAAUVlPuOQOkgH7n65/ZDhz24aQmjlLAWFajANgRZRdSFIe/cYOSR
        Lz1GGM16z6r9mSmZoIRKh2kYMl5cxnPpnFrym4Dsng==
X-Google-Smtp-Source: APXvYqzYJ6oqRwamIEDLJ3VtjU+XaOg77kkXW1O2XB+w4FxGCSBbCRCZltm1LjnvJjPK+WsK0l7De0RJSAqYnMnKyvI=
X-Received: by 2002:a67:b009:: with SMTP id z9mr5725405vse.27.1567088936391;
 Thu, 29 Aug 2019 07:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1566907161.git.amit.kucheria@linaro.org>
 <93fa782bde9c66845993ff883532b3f1f02d99e4.1566907161.git.amit.kucheria@linaro.org>
 <20190829140459.szauzhennltrwvg4@holly.lan>
In-Reply-To: <20190829140459.szauzhennltrwvg4@holly.lan>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 29 Aug 2019 19:58:45 +0530
Message-ID: <CAHLCerNuycWTLmCvdffM0=GdG7UZ7zNoj0Jb0CeLTULzVmfSJw@mail.gmail.com>
Subject: Re: [PATCH v2 03/15] drivers: thermal: tsens: Add __func__ identifier
 to debug statements
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <masneyb@onstation.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 29, 2019 at 7:35 PM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Tue, Aug 27, 2019 at 05:43:59PM +0530, Amit Kucheria wrote:
> > Printing the function name when enabling debugging makes logs easier to
> > read.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> > Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>
> This should need to be manually added at each call site; it is already
> built into the logging system (the f flag for dynamic debug)?

I assume you meant "shouldn't".

I haven't yet integrated dynamic debug into my daily workflow.

Last time I looked at it, it was a bit bothersome to use because I
needed to lookup exact line numbers to trigger useful information. And
those line numbers constantly keep changing as I work on the driver,
so it was a bit painful to script. Not to mention the syntax to frob
the correct files in debugfs to enable this functionality.

As opposed to this, adding the following to the makefile is so easy. :-)

CFLAGS_tsens-common.o          := -DDEBUG

Perhaps I am using it all wrong? How would I go about using dynamic
debug instead of this patch?

Regards,
Amit
