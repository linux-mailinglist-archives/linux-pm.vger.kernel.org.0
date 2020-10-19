Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6014A292FA2
	for <lists+linux-pm@lfdr.de>; Mon, 19 Oct 2020 22:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgJSUpA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Oct 2020 16:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgJSUo7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Oct 2020 16:44:59 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4D8C0613CE;
        Mon, 19 Oct 2020 13:44:59 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id t21so709494eds.6;
        Mon, 19 Oct 2020 13:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sRKQZM/u0KyuM0HK57jZaq4ro1c5W2LrViHCVfdTkUA=;
        b=Ta1EUzyHX5+eIKSCjA1c6DssesWEAtxcwtK5/HyZ+9kxtC/Ro8Rma0Ash/CGWcmXWy
         0b0Aka3dRAyQWFkHr7523c2N7VJMVYqOmgB/6qKIoCqLBMOMxMJXbj0Qqw7FCAS5P/vA
         7sHzK2+fW4pCvfcmJwXlX+YQKRQdMpP7JRVbBgzES/MDY1aIexpTQaIzEpWDeZEPgic3
         i1FGcCsh/COQwQAhpqfAsNpEBknZsvkPlIXQcETO7sDqgDsVEWgEAre9BhZ2PYUzV970
         2jFxJMfFdNRP6VKTLIa4vqHJ85jS6VIRobVJRF3hR70deARXtODjLzN6x3MKwbdV6sBI
         DvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sRKQZM/u0KyuM0HK57jZaq4ro1c5W2LrViHCVfdTkUA=;
        b=rQhwyKRbXEGUcVvg4H8qONI4sEUNpdpavsSqk+8CmK14jMdQiEpQjhkDvcbbraIvmY
         Up+p/s8OevNjYzphvIPmWa6USXea6Nov6yp7Yukg0AuBl2xxOZIAlR5Hp06PrE9JNig2
         CyVK9W7cwngWJBsqyiJmxGfOoMIfVzV3MMzGZulapAoKe4i2TxtF0hwaBkOIhIijIjz4
         acsG+D8ktv5Rq0BZ9tOE1I9SIjB2ye6FjIYWFdm0vnWLTnSTuFxjv/DS2SjKw1/xoUcB
         w7VVMB6C0hzbjrt5aspngLkWsEfB5O+qwcU7CwU7yWsjxe6/5Wl4Sk/35kvBsPMYQCqU
         e83Q==
X-Gm-Message-State: AOAM533X+uhzS4bgKpdjIMqtv9O5ym3ifxl9bUxA+REnzeT2my0q9ivs
        jgUV7CQblXrDRUfQyEOT/dq1X10By3UCTRB83zs=
X-Google-Smtp-Source: ABdhPJyromYhLQ7NIhPxuPFo2Tfup77z4dyWm34xZ7SgFwejpZnC4Ncxq2+3wUkC11C6x8mao7s+yoCsO22AXqUZrU4=
X-Received: by 2002:a50:85c6:: with SMTP id q6mr1781028edh.126.1603140298100;
 Mon, 19 Oct 2020 13:44:58 -0700 (PDT)
MIME-Version: 1.0
References: <20201017133718.31327-1-kholk11@gmail.com> <20201017133718.31327-2-kholk11@gmail.com>
 <20201019195807.GA3508546@bogus>
In-Reply-To: <20201019195807.GA3508546@bogus>
From:   Martin Botka <martin.botka1@gmail.com>
Date:   Mon, 19 Oct 2020 22:44:46 +0200
Message-ID: <CADQ2G_HZ9nt88vW9MNiC-+Rdjzsu-hSHoqmqLC75vyiG2JKpQQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: interconnect: Add bindings for
 Qualcomm SDM660 NoC
To:     Rob Herring <robh@kernel.org>
Cc:     kholk11@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        devicetree <devicetree@vger.kernel.org>, marijns95@gmail.com,
        Konrad Dybcio <konradybcio@gmail.com>,
        phone-devel@vger.kernel.org, linux-pm@vger.kernel.org,
        georgi.djakov@linaro.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> Documentation/devicetree/bindings/interconnect/qcom,sdm660.example.dts:20:18: fatal error: dt-bindings/clock/qcom,mmcc-sdm660.h: No such file or directory
>    20 |         #include <dt-bindings/clock/qcom,mmcc-sdm660.h>
>       |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This patch depends on my MMCC patch (sent by angelo).
