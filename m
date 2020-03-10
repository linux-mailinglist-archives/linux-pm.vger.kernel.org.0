Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1B4117F20F
	for <lists+linux-pm@lfdr.de>; Tue, 10 Mar 2020 09:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgCJIiC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Mar 2020 04:38:02 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39505 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgCJIiB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Mar 2020 04:38:01 -0400
Received: by mail-oi1-f194.google.com with SMTP id d63so6225742oig.6
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2020 01:38:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Edv5FGx6HfQViwOHvX4++3OuZDAlkVwMs+TRV+ocKyE=;
        b=LdjXPR3h1avbAjfSYuMxidr8Bd3RZqLjaeuc4XiOwq1dFWZdYePkpOt+nAXPJdciAr
         rE/RAxK78G/2Iocx0hjQJ8e7MOH7aE09FnvDS1u74JqfkLnze85miv5UEckXZ5z10Mhy
         mzvTRzoAR9BCfH32kn5eypkEHsTrVZerjS4wiDoJtzj+iqnMd93cKMnGn9ij3nFN/OLi
         o3my0FkZJkrBqlUSH8soJnZHJphkTpi6UbPFx1S+h+lSJPAdluirIxz4lemzbTx7A9Wm
         f+RvW+oZDCYOd3daEHszElQhnfBwzrUqbQK8b1ooz22vLJ7a2vw0jFmFp7K3TwviA0i6
         womQ==
X-Gm-Message-State: ANhLgQ2IDbsQruOEDVVK8nhE5JwteqqwOXbZ5EnZxf8gEn6YxFnpPrb7
        OJiPhZCclOu82oAcU/ntVE90YaOpHb165KsyieU=
X-Google-Smtp-Source: ADFU+vtxKj1FXGdXpMM5q7fMJsZPCOH9fUrMlzex1LWI8M8+68iu8RsU/KevMNJjhu1oBsetZIr4gh2j9nSlvsgxdZY=
X-Received: by 2002:aca:5155:: with SMTP id f82mr350047oib.103.1583829480926;
 Tue, 10 Mar 2020 01:38:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200303203559.23995-1-ulf.hansson@linaro.org>
 <CAJZ5v0j86N5WgEJhCD6a7K2NG7NoK-wqG5h-vbc-Z7qH4fkySQ@mail.gmail.com> <CAPDyKFo3o6k8kiXTG337_4OkcunQn9T1FgPM-PngO3t9Sg9eBw@mail.gmail.com>
In-Reply-To: <CAPDyKFo3o6k8kiXTG337_4OkcunQn9T1FgPM-PngO3t9Sg9eBw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 10 Mar 2020 09:37:50 +0100
Message-ID: <CAJZ5v0gjhTCA=puG515Bf-it9xt-zgTNyJUmiDK+Oip_ucMThQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] cpuidle: psci: Some fixes when using the
 hierarchical layout
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 9, 2020 at 8:21 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 3 Mar 2020 at 23:28, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Tue, Mar 3, 2020 at 9:36 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > Changes in v2:
> > >         - Small changes to patch 3 and 4, see their changelogs.
> > >
> > > While collaborating with Benjamin Gaignard to deploy the hierarchical layout
> > > for an ST SoC, it has turned that I have clearly missed to test a couple of
> > > corner cases in recently added support to the cpuidle-psci driver.
> > >
> > > This series are fixing the issues we have found.
> >
> > I can apply the whole series, but I'd need an ACK from the PSCI driver
> > maintainers for that.
>
> Patch 1 and patch 3 is ready to go. Although, patch 3 don't need the
> fixes tag and can be queued for v5.17 instead.
>
> Do you want me to resend or can you pick them from the series?

Yes, please!
