Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABBB4279DC
	for <lists+linux-pm@lfdr.de>; Sat,  9 Oct 2021 13:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244815AbhJIL7M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 Oct 2021 07:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbhJIL7M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 9 Oct 2021 07:59:12 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F030C061570;
        Sat,  9 Oct 2021 04:57:15 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id r134so2632008iod.11;
        Sat, 09 Oct 2021 04:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b6PCq4Gkwis4c8eZUmnooNUV0Fha5o7at5yue5VuXyw=;
        b=fLkwbZhg2oiOnoYuSZpq0qa6f2oN3xEGRYGP/buE8l3dxeDp5hb0njNy/tVjxxjmGT
         YsNvvbJ1IGgcPu4Hf1y9HdoZPPdL5ZNH1R3PlBJFKLyt466rdfI29qWDGnX3S0NU0djw
         pH4Ilnj1alWs635XglmbROXVGIqJiAnI+Uh+vCiMF4fR8rjPUbCiobCSe6+BNL500rzW
         c4q3PI5UTaAPeAOKJp+szft9o0j0ZI2gW1bK+Uaw3UbmP9V9N4scUWKUIDbMFjzhH3iH
         x+nGNas4MP33mCbUwVvrJIdaHpm5JFnLOJsLC7SUpUWeTuZasp6+ZiBXWIF+Gep3PW4c
         RL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b6PCq4Gkwis4c8eZUmnooNUV0Fha5o7at5yue5VuXyw=;
        b=XsznwLk/PU96CfK3t96LY6SKgeMg0XDPChAlouR6+uJVSKmaOk9MMvMPraG4PpONXQ
         /1C/xMXQK0hw59eXdc8OHjAK54gOcV1rhwNHMuJVj4CVP0SuonbkpY13rniMV3SWlSYQ
         aOPnDLspR6E/RuHzjVw1mHsDf4FBdneK3935JkTdSS4TQlxDgNTdofsK60QGFRmRml5v
         WXzSULw2wnrDk9SKlyh+FRxx8Z2SIt7M+hx3TyeJ/MRFPet1mgDGW1iKCShURaQjYCgU
         X/DUzllfpfCkdrBWnQhFEgywfjZnbznLWVkC5ZtWUl6Y0GH94PEjQF5GPiE6D9CYa3kQ
         yDVA==
X-Gm-Message-State: AOAM530grnI0GFYjF30uvHcMF3iIsASewtM7sKbLvYCb5h3RGtb1rcG+
        0aRI0eHrXpPaURnEYjXQd7iRR8xoAgFr2sc1kVA=
X-Google-Smtp-Source: ABdhPJzmSyqKU/YcdHWZExJXMvHzqYHsLnCWw9ApzCbbCsVUgoCpXARsNWldWo7W1pCgwU9mHWKjai5fbpyX2fBmXxk=
X-Received: by 2002:a05:6602:2e88:: with SMTP id m8mr5018798iow.91.1633780634902;
 Sat, 09 Oct 2021 04:57:14 -0700 (PDT)
MIME-Version: 1.0
References: <20211009115031.18392-1-alistair@alistair23.me> <20211009115031.18392-8-alistair@alistair23.me>
In-Reply-To: <20211009115031.18392-8-alistair@alistair23.me>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Sat, 9 Oct 2021 21:56:49 +1000
Message-ID: <CAKmqyKOQ32zMucsEexgfJcs9Tks4JB_ra6nhjVf=36aiwkvYHg@mail.gmail.com>
Subject: Re: [PATCH 5/7] capsules: hmac: Continue reducing code size
To:     Alistair Francis <alistair@alistair23.me>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        lgirdwood@gmail.com, Mark Brown <broonie@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, amitk@kernel.org,
        rui.zhang@intel.com, devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-pm@vger.kernel.org,
        Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Oct 9, 2021 at 9:51 PM Alistair Francis <alistair@alistair23.me> wrote:
>
> From: Alistair Francis <alistair.francis@wdc.com>
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Sorry, I wrongly copied this patch. Just ignore this patch

Alistair
