Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143E745DA0A
	for <lists+linux-pm@lfdr.de>; Thu, 25 Nov 2021 13:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350482AbhKYMbm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Nov 2021 07:31:42 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:43749 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348941AbhKYMa1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Nov 2021 07:30:27 -0500
Received: by mail-ot1-f41.google.com with SMTP id h16-20020a9d7990000000b0055c7ae44dd2so9159078otm.10;
        Thu, 25 Nov 2021 04:27:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9HbXFpIh/y4w8a8eT1ZfLzvqZSm5LG22VgGOZnieP9k=;
        b=Uf+/MSZdr/WSNXA+QxmwOK6dV/cI28ZbUxOPtkSs2Z0TJ1l6tMHB6+zMsqra9c+QQJ
         GMLm2mnRfvBfCNIpVAMsKW9DRGFEI2pjPKAT3tbGO++rz5Rystrhqo4ITZFu+VkSQNsN
         d4y7yorzBail3tgfz6ixXO3JlcFyDduzQdZLtE6fIV4ekKiA/mtbd+KZ0hqW74ii9112
         zahNjSjO+2PwBRVRCcBUJNmng9O2TWu4y5BLnccI3jDRf94lDPS834M8khYq/PvVCqrJ
         Qg9EZwFsDshaXRLqHCKxpzAKbUd2EXL0VwkKuvo3rM4R8dxI7tYbCCtsHJcXPxpBIUq1
         7RJg==
X-Gm-Message-State: AOAM532wYQ81iSSsVIHhJiLtR9N+8wjyx9CcUiKFfLNHGmzNRpgxIqHN
        dpgp45MhRdB4n835Lx6/EwrD6r5v/XjrItbCcaU=
X-Google-Smtp-Source: ABdhPJzXTx2FQb+cCeHwjuDPFTvFkWd0PGZt5EoZW9Ob4rnnSPE2b84X4PkMW0KHIr039bqkSQkbJaOpoWqM9dRX+aA=
X-Received: by 2002:a9d:4c10:: with SMTP id l16mr10811837otf.198.1637843235097;
 Thu, 25 Nov 2021 04:27:15 -0800 (PST)
MIME-Version: 1.0
References: <1637830481-21709-1-git-send-email-quic_mkshah@quicinc.com>
In-Reply-To: <1637830481-21709-1-git-send-email-quic_mkshah@quicinc.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 Nov 2021 13:27:03 +0100
Message-ID: <CAJZ5v0hhUSjNdHwF4dRUQ1Fgos-jqg1agHBShhhwFUGK6wiedQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Allow cpuidle governors to be compiled as modules
To:     Maulik Shah <quic_mkshah@quicinc.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, quic_lsrao@quicinc.com,
        "Nayak, Rajendra" <rnayak@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 25, 2021 at 9:55 AM Maulik Shah <quic_mkshah@quicinc.com> wrote:
>
> This series makes changes to allow cpuidle governors menu, ladder and teo
> to compiled as modules when building with allmodconfig.

What's the purpose of this?
