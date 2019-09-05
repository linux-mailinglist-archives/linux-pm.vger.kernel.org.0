Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB99AAA10
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2019 19:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389737AbfIERdr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Sep 2019 13:33:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35530 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbfIERdr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Sep 2019 13:33:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id n4so1797883pgv.2
        for <linux-pm@vger.kernel.org>; Thu, 05 Sep 2019 10:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:subject:to:from:user-agent:date;
        bh=QOU2fQSnEMLrYzBWOEmTCGpu7kl2KoRGYPyXWekRxFo=;
        b=nLPdLSeZYkCdXYg47Zk8yaMIeE+E7vOm69Gu3zUn2kx8md33AAfro52hxkxX2stB/o
         WZbR4YaWa7z0PLGI5OkJUNCAeYHYn43jqA19pbqd19b6rvoRCdz1i3mI68/sl7CH/tiG
         /UCTKOdiJmyzTZoREfUPUxqxDdxgyXQC9hYtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:subject:to:from
         :user-agent:date;
        bh=QOU2fQSnEMLrYzBWOEmTCGpu7kl2KoRGYPyXWekRxFo=;
        b=DwpqQsWBJ00IPk3KLjIblXLUAwhM5gpMGzO679KsP62+ZvPT6PbbOeTlZRopMxR/XG
         8prK1CB7hEAaFfVKo5HSChad9IdhJPAOpiGhYj6IwZ4BAxIJqvCHRjyICUtVIxC0AC/L
         dIyWT4Aj6axMSPMKH9wFxbCFYi2UVkIM4Kz6AhDduKhDKw6iN+O4i86yk1uLzAodn6ho
         Nu3O8XhP3T9EqUK2esGoBw7NKnKd/pbLe5F2L/U+oBfhvEj6KLotnKuuRRqcQIvbyBk2
         NzNYyEF8oPm10A9P4hj4U+EhiAQLtNVT4a7H+vH9r7fq/NtBgz/K/otccz56un8vcW9E
         M6RQ==
X-Gm-Message-State: APjAAAVOxOjDE4FTUoAJKhTjyY5DTcB5lSGucGwjIPlR2/7Z6g40A4gw
        M34G11SJgsd91eztYUdP8V6JaA==
X-Google-Smtp-Source: APXvYqz+0+yaaxJQM5pVlU26kNn+3QA/1QGN/LfY5TdaWbV7kBX334BYFDDtUf5aA8ZfofZhnEcc4w==
X-Received: by 2002:a17:90a:356d:: with SMTP id q100mr5201262pjb.53.1567704826899;
        Thu, 05 Sep 2019 10:33:46 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g2sm3739214pfm.32.2019.09.05.10.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 10:33:46 -0700 (PDT)
Message-ID: <5d7146fa.1c69fb81.8444a.8f49@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190823081703.17325-7-mkshah@codeaurora.org>
References: <20190823081703.17325-1-mkshah@codeaurora.org> <20190823081703.17325-7-mkshah@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        dianders@chromium.org, rnayak@codeaurora.org, ilina@codeaurora.org,
        lsrao@codeaurora.org, ulf.hansson@linaro.org,
        Maulik Shah <mkshah@codeaurora.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 6/6] arm64: dts: Add rsc power domain for sdm845
To:     Maulik Shah <mkshah@codeaurora.org>, agross@kernel.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Thu, 05 Sep 2019 10:33:45 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Maulik Shah (2019-08-23 01:17:03)
> Add rsc power domain to enable sending sleep and wake votes
> using generic power domain infrastructure.
>=20
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> ---

Can this be combined with the previous patch?

