Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66F8371F41
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 20:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391458AbfGWSYw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 14:24:52 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37123 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391473AbfGWSYw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jul 2019 14:24:52 -0400
Received: by mail-pg1-f195.google.com with SMTP id i70so9084630pgd.4
        for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2019 11:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:cc:from:user-agent:date;
        bh=b41n3LREvvCVOT99upf2mTScwjCvonjOKLeOr7b3C5o=;
        b=FV39AKdMDQeD6YqtoKQSMhCbjgrTyHJN60X0SWmNCD+O9p2bX6C8qYJz0eINu0Vkyf
         LAbFt2BoaV/5c012dA0FE9DnPmAfbtAoMuMuWTdOwtIgpVHXOPYq/wXTmyg0mmReH1eo
         bP8CKJ5kluT1kIqJojulM3Lhe452qac63uGtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:cc:from
         :user-agent:date;
        bh=b41n3LREvvCVOT99upf2mTScwjCvonjOKLeOr7b3C5o=;
        b=ffScPjyw+FGVtTFtF5Hn16JLlZVr3WV2s8sbH9QA3tGYZXEQnq7tcKGytx4EFSnXCN
         TVcfg4Nl4mgBpZFDMc468mIsWxWiLAqML6KeVtADTgaIsIackcnOncRI1QlfKex+Fr1f
         z30seviJlDoeoC4ni4J0CZOTVh8pvuXyy7DqaegxkJ2CshGLvmyldzrD/grPRvn3jfoa
         JPOHlaPdO+LQDgObxLqkzNRkm7Aa6yi7UGs3oUF51o4vbXv0eDCuMa9N5WrsnyY9P/7C
         JPwy1nBMxI0moi2WxQSyEM4tXbH3COEFZleXAQEvfUD5tI0qLXpAHEeX6toFwA2r7Iwr
         HgeQ==
X-Gm-Message-State: APjAAAVCTPsUF2rZBRVhV6DZPXQVZ0vkBuCK0x4uISTdDxQ02noXRgYE
        ZCL2fQJMAvAUlePG6E+fKxLYuQ==
X-Google-Smtp-Source: APXvYqx0i7nBRik0fKx4AbxAnDtKCTytjeuS/7WcJwq1Evpncx6GnzRR1koiuEsmKqC3CiPSEsktfA==
X-Received: by 2002:a17:90a:4f0e:: with SMTP id p14mr80829741pjh.40.1563906291568;
        Tue, 23 Jul 2019 11:24:51 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id t29sm53263348pfq.156.2019.07.23.11.24.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 11:24:51 -0700 (PDT)
Message-ID: <5d3750f3.1c69fb81.923dc.874d@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190722215340.3071-3-ilina@codeaurora.org>
References: <20190722215340.3071-1-ilina@codeaurora.org> <20190722215340.3071-3-ilina@codeaurora.org>
Subject: Re: [PATCH V2 3/4] drivers: qcom: rpmh: switch over from spinlock irq variants
To:     Lina Iyer <ilina@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        mkshah@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Tue, 23 Jul 2019 11:24:50 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Lina Iyer (2019-07-22 14:53:39)
> From: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
>=20
> Switch over from using _irqsave/_irqrestore variants since we no longer
> race with a lock from the interrupt handler. While we are at it, rename
> the cache_lock to just lock to allow use of the lock to synchronize
> controller access.

Is there a reason why it can't be a mutex now?

>=20
> Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
