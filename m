Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09ABF23C626
	for <lists+linux-pm@lfdr.de>; Wed,  5 Aug 2020 08:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgHEGl5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Aug 2020 02:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbgHEGly (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Aug 2020 02:41:54 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBC0C06179E
        for <linux-pm@vger.kernel.org>; Tue,  4 Aug 2020 23:41:54 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id r11so14211817pfl.11
        for <linux-pm@vger.kernel.org>; Tue, 04 Aug 2020 23:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=ltqLz+bl5cJfWC7EYmNLCWQiWVWxzgHI/BH5Y9oslyQ=;
        b=aO0Z1jPDvV8s5byVMzx/gWoab/lBG5ayZTHBB6BRUjMsp1YxPj1Be33sYB91VB5n02
         RnDyHR15B0m1x3IeZVwte/0U1gzjj/FIdFfDnm+Xd+8JQjg1YdoWfUnyGfJK3DadI6+o
         LxpKhy0Lud50qAF0DIQ5sRpkYaa4Xz8TyQN3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=ltqLz+bl5cJfWC7EYmNLCWQiWVWxzgHI/BH5Y9oslyQ=;
        b=O0Uu6w9srpffdktPMR2BV5Yka2e8vhIWQUntXXTkYiXDVCr56GYwPNZ2rTRIEhoa+c
         DF9oY0Ep46n9q+HknS5nY5zPyArAAKD5IXMPeoa2rUF1/5CkilDYY36PZ9yG6rXmSfFa
         GqwBs/iAywz85Y+sTy6dR7YlRPB1ogDTAwXJ7yO9RTO51ed/XFrlhLs2LgZSaOQa38Z+
         rL85wLulVXrVdK7Bfso3UH4zUl1G+7hrPZfcn/ioR6Ls+exV7L3MfGkF7+zPloxU19oQ
         fXtNrmJfBmzghtzNHAGoASK7mnW/9sgOCdZLUawLzwFUhlbyIXwHmiTudPyuo00+FpgC
         XnpA==
X-Gm-Message-State: AOAM530MzpJBmUQSNbIy02uVww5WF+pnCVfolkP0/uj0oJOTRArCwSAd
        FM68hzhTZRTHce2oO6rTiYOr1b1KRFw=
X-Google-Smtp-Source: ABdhPJzTj31DnR6UDAJ7nYUuV1oFzS4F7uSIHrrjTsdOzmxqP6lzTTtoxG7G22mn7a8de9Y3wO7mYw==
X-Received: by 2002:a63:df01:: with SMTP id u1mr1574233pgg.401.1596609713589;
        Tue, 04 Aug 2020 23:41:53 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id g23sm1659455pfo.95.2020.08.04.23.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 23:41:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1596541616-27688-4-git-send-email-rnayak@codeaurora.org>
References: <1596541616-27688-1-git-send-email-rnayak@codeaurora.org> <1596541616-27688-4-git-send-email-rnayak@codeaurora.org>
Subject: Re: [PATCH 3/3] arm64: dts: sc7180: Add assigned-performance-states for i2c
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, ulf.hansson@linaro.org
Date:   Tue, 04 Aug 2020 23:41:51 -0700
Message-ID: <159660971183.1360974.3826701315718625693@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Rajendra Nayak (2020-08-04 04:46:56)
> qup-i2c devices on sc7180 are clocked with a fixed clock (19.2 Mhz)

s/Mhz/MHz/

> Though qup-i2c does not support DVFS, it still needs to vote for a
> performance state on 'cx' to satisfy the 19.2 Mhz clock frequency

Capitalize CX?

> requirement.
>=20
> Use 'assigned-performance-states' to pass this information from
> device tree, and also add the power-domains property to specify
> the cx power-domain.
>=20
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

Can you generate this patch with more context? The hunks all look the
same so it's really hard to see where they apply.
