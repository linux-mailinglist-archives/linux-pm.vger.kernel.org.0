Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429154B7F70
	for <lists+linux-pm@lfdr.de>; Wed, 16 Feb 2022 05:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243735AbiBPEV2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Feb 2022 23:21:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbiBPEV1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Feb 2022 23:21:27 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAAD99EE7
        for <linux-pm@vger.kernel.org>; Tue, 15 Feb 2022 20:21:16 -0800 (PST)
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B8D9D3F1E3
        for <linux-pm@vger.kernel.org>; Wed, 16 Feb 2022 04:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644985274;
        bh=HsXK+os0Bu/iWLA0AHHw/feI5UAiYSJ6PqC8mSn7924=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=eXFDmBwprg5T7C0bA5bpvqRee9gHfyNdKh5K9TwrDfDoTNq5g943eeNvHsLhRSQn+
         +v5kPOWtpuvJDFd1z2JXnafsc+HB7LvfoWS4dRX4975oOba2JaGylep+cy7SecZROt
         MEq9RwTMvLVoZO5h2twSzkZrTgumVGStWdxw77xGPdTNZhijErn5w/TNzd/GwpdwDY
         NnBbXU3ChFNZtFJAPeqGHRISG7q3zDn0nOKlkEwsIEWZQyLIjyFoPd+UsycLMcDDz0
         5h1Xt0EvXOGpQSo7SYsg81lyFC2TghEEBv4xWZoFyFWEy9MyPDomEdSjZ3gQzrHWbo
         +uYUpSGSuU01w==
Received: by mail-oo1-f71.google.com with SMTP id l10-20020a4ac60a000000b002de84253574so646898ooq.19
        for <linux-pm@vger.kernel.org>; Tue, 15 Feb 2022 20:21:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HsXK+os0Bu/iWLA0AHHw/feI5UAiYSJ6PqC8mSn7924=;
        b=x6h1W/dTqqHC6F3cLbgfbClXwDVVBunNpeZX5wbZlXA27Zbao3l92lHWVFnL74Kt/V
         ynLG+JIIMHU2eWvPSiJS0NNJNAgH/I77yJ67h+3NFBCpR/uMl9NWH9ve2HVry4/mj2jW
         kzMNYvPZAmuqngyB0tJNvRvaiyGc2k6navZNcDVgLjwHLakVbqnQO4Ya+Vh41QnQtlcQ
         hdP6AA15N+gkNS8/QYCl30T8GsIHYIoE+qbxftWcaFpGOLJMlKa7TWrX80CqxDhwDpiG
         yF1mTnlndRmbznxJf8z643jd3SrhoEciI80tnqthtmgbomsLGDFHns9J+aaA7ipvvGqk
         MVow==
X-Gm-Message-State: AOAM533mDCUWooYlKPMcrGztcgVdj31SGqG1i3wJ/Vfn34qFzoMvfDxh
        zKHaDCwPeD+JWqC4CCDsydfcIaPj1Plzfv5pigFIBim27huBii0UQgBoAwHCmpewSbKwk9KVq/+
        TgyzMhL0IHzuHcAGIIPTyeJoftXjSIy3VqFZ9jbrrg0fuYpeqTpWM
X-Received: by 2002:a05:6870:134e:b0:d3:7659:e8b5 with SMTP id 14-20020a056870134e00b000d37659e8b5mr1240419oac.131.1644985273570;
        Tue, 15 Feb 2022 20:21:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxqQr9WioccQW2rNW50BJPxIWDXzh/BNZrc3rusV/8zTVsrc7M7FzsEBHFXcP6ido7ZdOtWXBCXsG/e+zdx8wc=
X-Received: by 2002:a05:6870:134e:b0:d3:7659:e8b5 with SMTP id
 14-20020a056870134e00b000d37659e8b5mr1240404oac.131.1644985273323; Tue, 15
 Feb 2022 20:21:13 -0800 (PST)
MIME-Version: 1.0
References: <20220121014039.1693208-1-kai.heng.feng@canonical.com>
 <20220125055010.1866563-1-kai.heng.feng@canonical.com> <CAPDyKFrtD28NKTyUAR-6Rt4PwYvkOuWcRhxZZWVAq4KcTNG7QQ@mail.gmail.com>
In-Reply-To: <CAPDyKFrtD28NKTyUAR-6Rt4PwYvkOuWcRhxZZWVAq4KcTNG7QQ@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 16 Feb 2022 12:21:02 +0800
Message-ID: <CAAd53p5LxZh6-jZj274g6+PeDpAPWSiwRWXL93dgOg3xpqvu8g@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] mmc: rtsx: Use pm_runtime_{get,put}() to handle
 runtime PM
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-pm@vger.kernel.org, Ricky WU <ricky_wu@realtek.com>,
        Thomas Hebb <tommyhebb@gmail.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Feb 4, 2022 at 8:28 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 25 Jan 2022 at 06:50, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> >
> > Commit 5b4258f6721f ("misc: rtsx: rts5249 support runtime PM") doesn't
> > use pm_runtime_{get,put}() helpers when it should, so the RPM refcount
> > keeps at zero, hence its parent driver, rtsx_pci, has to do lots of
> > weird tricks to keep it from runtime suspending.
> >
> > So use those helpers at right places to properly manage runtime PM.
> >
> > Fixes: 5b4258f6721f ("misc: rtsx: rts5249 support runtime PM")
> > Cc: Ricky WU <ricky_wu@realtek.com>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>
> The runtime PM reference counting for the mmc host device is managed
> by the mmc core. Have a look at __mmc_claim_host() and
> mmc_release_host().
>
> In other words, the runtime PM reference counting should not be needed
> in the mmc host driver, unless there are some specific cases, like for
> example during ->probe|remove().
>
> So perhaps it's only the changes in the ->probe|remove() functions
> that you need to fix the problems? No?

Yes you are right. Let me send a patch to remove redundant PM helpers
from this patch.

Kai-Heng

>
> [...]
>
> Kind regards
> Uffe
