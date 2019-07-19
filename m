Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72FEE6EA95
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2019 20:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731330AbfGSSUZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Jul 2019 14:20:25 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40612 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbfGSSUZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jul 2019 14:20:25 -0400
Received: by mail-pl1-f193.google.com with SMTP id a93so15966216pla.7
        for <linux-pm@vger.kernel.org>; Fri, 19 Jul 2019 11:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:cc:from:user-agent:date;
        bh=M26syJ4cW7NPI3SuosUdPQTeP9LfAyv4R4zcZOR5omc=;
        b=StxKZQU6THFXUJQCrcXp31nW4A0j02kuJ4ttDn46X3RRw7GUDQXFmw1gncEUDBBZo5
         yeTqHL3JVWT8kOb8uEgDgx2CTMTPqvUWLnqK/U43jqsgPKdrViYR8hS00FSaxSwadwT8
         Oz1dYGLf4pS5wt2SCQDkhAP1iycL+/pj3pvjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:cc:from
         :user-agent:date;
        bh=M26syJ4cW7NPI3SuosUdPQTeP9LfAyv4R4zcZOR5omc=;
        b=DTGX+6be/de7JHrSTJsUujr4Magonz5XOoZwVK/43ZLHAFC/XHx/GMw+izGpB2oWxN
         dqb566ybKOnPEnlP4MUjcNwxrsMjuctat9ijKP/hV18NVc6abw7vElWFpzpyouy8szH5
         bZmqGCdfhMM6HNwnjPxMvMeUHIAI0YWxPp+m0+1uei3nEXwA1Hqn4LmExB6PUAQP0DqY
         nuyu4Pv+iFa7XQ5B1GJ5dmjzuwnbEc/9bCnqzz4TD6FXLNVmDggXuegqL59oZfjK83K0
         05vZmfIb63r24ekE75bBJluARbiwkKdHxrVxi/D6BXpinOKVGyJ3fVBWNVEWUkmfkTk6
         PvhQ==
X-Gm-Message-State: APjAAAVp1u+9pDagcdC22oRGUoQTZoBid0lPDfSThMZilZZvzyl9U03L
        PZJr+HzxUm67tyF66cYPSsCGLg==
X-Google-Smtp-Source: APXvYqz/RpGKnJ45DZoI1c21p88BvZhB2sSsak8OqJzITQuJMJLtGysFhCcD7usnFqeySO8wrV6gJg==
X-Received: by 2002:a17:902:be15:: with SMTP id r21mr57134298pls.293.1563560424619;
        Fri, 19 Jul 2019 11:20:24 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id s15sm31288067pfd.183.2019.07.19.11.20.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 19 Jul 2019 11:20:23 -0700 (PDT)
Message-ID: <5d3209e7.1c69fb81.5ef1.5195@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190701152907.16407-1-ilina@codeaurora.org>
References: <20190701152907.16407-1-ilina@codeaurora.org>
Subject: Re: [PATCH 1/2] drivers: qcom: rpmh-rsc: simplify TCS locking
To:     Lina Iyer <ilina@codeaurora.org>, andy.gross@linaro.org,
        bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        mkshah@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Fri, 19 Jul 2019 11:20:22 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Lina Iyer (2019-07-01 08:29:06)
> From: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
>=20
> tcs->lock was introduced to serialize access with in TCS group. But
> even without tcs->lock, drv->lock is serving the same purpose. So
> use a single drv->lock.

Isn't the downside now that we're going to be serializing access to the
different TCSes when two are being written in parallel or waited on? I
thought that was the whole point of splitting the lock into a TCS lock
and a general "driver" lock that protects the global driver state vs.
the specific TCS state.

>=20
> Other optimizations include -
>  - Remove locking around clear_bit() in IRQ handler. clear_bit() is
>    atomic.
>  - Remove redundant read of TCS registers.
>  - Use spin_lock instead of _irq variants as the locks are not held
>    in interrupt context.

Can you please split this patch up into 3 or 4 different patches? I'm
not sure why any of these patches are marked with Fixes either. It's an
optimization patch, not a fix patch, unless the optimization is really
large somehow?

>=20
> Fixes: 658628 ("drivers: qcom: rpmh-rsc: add RPMH controller for QCOM
> SoCs")
> Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
>  drivers/soc/qcom/rpmh-internal.h |  2 --
>  drivers/soc/qcom/rpmh-rsc.c      | 37 +++++++++++---------------------
>  drivers/soc/qcom/rpmh.c          | 20 +++++++----------
>  3 files changed, 21 insertions(+), 38 deletions(-)
>=20
> diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-int=
ernal.h
> index a7bbbb67991c..969d5030860e 100644
> --- a/drivers/soc/qcom/rpmh-internal.h
> +++ b/drivers/soc/qcom/rpmh-internal.h
> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index e278fc11fe5c..92461311aef3 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -93,8 +93,7 @@ static void write_tcs_reg_sync(struct rsc_drv *drv, int=
 reg, int tcs_id,
> =20
>  static bool tcs_is_free(struct rsc_drv *drv, int tcs_id)
>  {
> -       return !test_bit(tcs_id, drv->tcs_in_use) &&
> -              read_tcs_reg(drv, RSC_DRV_STATUS, tcs_id, 0);
> +       return !test_bit(tcs_id, drv->tcs_in_use);

This can be a different patch. Why is reading the tcs register
redundant? Please put that information in the commit text.

