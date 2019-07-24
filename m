Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCFB77369D
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2019 20:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbfGXScS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jul 2019 14:32:18 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38035 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbfGXScS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jul 2019 14:32:18 -0400
Received: by mail-pf1-f193.google.com with SMTP id y15so21367056pfn.5
        for <linux-pm@vger.kernel.org>; Wed, 24 Jul 2019 11:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:cc:from:user-agent:date;
        bh=GTi6Bq8qv1MIsEGO5GGNfuTeyzBZrOU9NQN3sCHpWpU=;
        b=dlPXGjbxzXqoe4vdb5l7jyFruLZ+nHHe9/9E9yscqhiwlwhyBSaN4dPhkYwpa84mi7
         0MpmchCjBhRFmXYVUpsYI4pzbe313pQchqM0KZxaVyFPO73RtmJq2s7g6HoZn9QWbbvl
         CvrnuhN6bNDpDnb0nbyMulDWbfPHmNlRrG3x4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:cc:from
         :user-agent:date;
        bh=GTi6Bq8qv1MIsEGO5GGNfuTeyzBZrOU9NQN3sCHpWpU=;
        b=BxzGWX9NSeR6YDWczG9Rdp4Sz639WI+ZNG4JxduHe4TfAReMKuDM/ODkxlpXe1sHAa
         4rulLj998ihcCV6Vw99UcoMX20Gm1snNtBu+fPUfqfDpKZJuCCVSm4fnrjvS8qiCBda5
         nmCe2hoW7URs2j3pDCNRoo5nUPZLeF7CEq2LpI0CLi6cOvop/JJOqbKEZAUDX2ruCnsZ
         fp9muW8vCuNXI+f2flwU98PyHjEcEEwqOWY0NwI2UC9+xiyc3InAiuTGLUEcFBoKtPZs
         i7TXHuJr+mq+OyNLLF5oVnZUiNQ9Y/eIPn0iwcaU9ihPOy2WxMmqhgqB9vwLl0ILV57f
         xJ6Q==
X-Gm-Message-State: APjAAAVvydT4grjjC4wyNOrMISIo4+eUvKfmX0sU307iYvcWwvb8OK4O
        yujqTrViApyVseTC1s0QHrllNg==
X-Google-Smtp-Source: APXvYqwlbxuM9oEkV60kqlua8NagirbM9q2MPlMTaGMBsIzc4Q8rsHoHFsJa6K4sRG5TpRVZbXGDRQ==
X-Received: by 2002:a62:2a4d:: with SMTP id q74mr12678551pfq.86.1563993137491;
        Wed, 24 Jul 2019 11:32:17 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id k8sm45880018pgm.14.2019.07.24.11.32.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 11:32:16 -0700 (PDT)
Message-ID: <5d38a430.1c69fb81.6e696.9e6f@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190724145452.GC18620@codeaurora.org>
References: <20190722215340.3071-1-ilina@codeaurora.org> <5d375054.1c69fb81.7ce3f.3591@mx.google.com> <20190723192159.GA18620@codeaurora.org> <5d376bb3.1c69fb81.2bb4e.7771@mx.google.com> <20190724145452.GC18620@codeaurora.org>
Subject: Re: [PATCH V2 1/4] drivers: qcom: rpmh-rsc: simplify TCS locking
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        mkshah@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Wed, 24 Jul 2019 11:32:15 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Lina Iyer (2019-07-24 07:54:52)
> On Tue, Jul 23 2019 at 14:19 -0600, Stephen Boyd wrote:
> >Quoting Lina Iyer (2019-07-23 12:21:59)
> >> On Tue, Jul 23 2019 at 12:22 -0600, Stephen Boyd wrote:
> >> >Can you keep irq saving and restoring in this patch and then remove t=
hat
> >> >in the next patch with reasoning? It probably isn't safe if the lock =
is
> >> >taken in interrupt context anyway.
> >> >
> >> Yes, the drv->lock should have been irqsave/irqrestore, but it hasn't
> >> been changed by this patch.
> >
> >It needs to be changed to maintain the irqsaving/restoring of the code.
> >
> May be I should club this with the following patch. Instead of adding
> irqsave and restore to drv->lock and then remvoing them again in the
> following patch.
>=20

I suspect that gets us back to v1 of this patch series? I'd prefer you
just keep the save/restore of irqs in this patch and then remove them
later. Or if the order can be the other way, where we remove grabbing
the lock in irq context comes first and then consolidate the locks into
one it might work.

