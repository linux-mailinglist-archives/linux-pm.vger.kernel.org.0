Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F3F7CACFA
	for <lists+linux-pm@lfdr.de>; Mon, 16 Oct 2023 17:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbjJPPJN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Oct 2023 11:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbjJPPI6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Oct 2023 11:08:58 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDADDD9
        for <linux-pm@vger.kernel.org>; Mon, 16 Oct 2023 08:08:54 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d9a518d66a1so5466014276.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Oct 2023 08:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697468934; x=1698073734; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AfMzmSAMB17a2NwH2HpOiWWpuFzMguqaGLUDXQnZZEg=;
        b=BtHTb/Q5HVldX9NirWPq5/7fLVtGPJpxMn8wecF7UXGY7+WTmeE+tVZ2GliI991lV8
         pFXaTJZKcOGA53M022UmWRjXORbWJBpK33rPDmjJ5QEwSr7U5EZ9wqGDnWTJm1liroxg
         sFj3KN1WyJVQdViNXW7boTxr/aVqG22b78BG9drp+st7AsQ8x2eyL95pNrglPykG1A7P
         MOXoLhpRmv2VclVgOGWTz4a7bh5aMBQttNI7tglAB8y52fnQsZp6m+lgO1rwlG0a9Mdr
         AmOvqHiYls0vd1YQHzGEjMqMR0lT4u3rJ9Er9yPHwCRfslGppW0pmL6hnbCLplsces9t
         CT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697468934; x=1698073734;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AfMzmSAMB17a2NwH2HpOiWWpuFzMguqaGLUDXQnZZEg=;
        b=Dy4qLzCwc1U9SocKnJwXPeI8Znojz5t/257aKzVTsiSl8IaZFrZGysAF6HjOD67fYu
         g0ahx+8+4IymPar9uTfY06DeXHTW0OaDL0Ae881/CjkYPht+abIT+6QweLnbPR4zSMk2
         4YFiIrKVgu7sOuk6s48OAebfJ7kAgQjiT5xMZv+fbd6+O3f1xBxGl+VZy2bgQgD1RlbC
         vtw9qoOtwiCLnTF+69uRLkKSYAY2tmGK3ceWc0rHnuLX0j3fDBF0HHI/emHg/ZUFigRS
         JvTNO+UdRshHgB4b1CQzTwQomB1I8sWHIsySmHivaVFoZ/+iycEzGMIBj4/AOr9X8dVB
         2QZQ==
X-Gm-Message-State: AOJu0YztIXNd/pZVQ8nmSbpRjvq4rl+CPqJVs8okCwo85HJB2BthQiZe
        +USI/O7jkyzHO+5mF49siwyoVWolhZvQ0DiJCNlsHw==
X-Google-Smtp-Source: AGHT+IHECKOX8CIKoErpJcR94iahfflcdhD1LxOqcN9jzWh9ZPzHv7UmbSxzk1sdKp55GX0wmwzbvsF3/X+qgKcjXMg=
X-Received: by 2002:a25:ae85:0:b0:d9a:4362:67ac with SMTP id
 b5-20020a25ae85000000b00d9a436267acmr17826010ybj.15.1697468933976; Mon, 16
 Oct 2023 08:08:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231010105503.jwrmjahuvcjgwtk5@bogus> <CAPDyKFqEpnKeF7Yuvv_a+=Kqs=pNU_kM59EqWdpCniHrY_373A@mail.gmail.com>
 <DU0PR04MB941755466872E84217378F6388CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010130054.ieylxocuapugajif@bogus> <DU0PR04MB94177FFEAA62AC27839D826F88CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010133059.57rs52qedrc5mxfr@bogus> <DU0PR04MB9417D01218CA4803D00545A788CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010145137.fyxjlsj5qq3elq7l@bogus> <DU0PR04MB9417233F914A061FB0A23B3088CCA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <CAPDyKFo32GQdgMWJ_rkb88mcdc+0jYubWiCapf99Zg9JTnNnPw@mail.gmail.com>
 <20231011141551.exqxkmt3xsl5fyjh@bogus> <CAPDyKFrWjAdujOr8JX5_JawaKqs0_MYUrsUN57XaB9q=darJ0w@mail.gmail.com>
In-Reply-To: <CAPDyKFrWjAdujOr8JX5_JawaKqs0_MYUrsUN57XaB9q=darJ0w@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Oct 2023 17:08:18 +0200
Message-ID: <CAPDyKFoJpnF_CezT6RySPpAwJY0+LO+RiSqqM=byTaRibKQPyg@mail.gmail.com>
Subject: Re: Question regarding scmi_perf_domain.c
To:     Peng Fan <peng.fan@nxp.com>, Sudeep Holla <sudeep.holla@arm.com>
Cc:     "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Glen G Wienecke <glen.wienecke@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 12 Oct 2023 at 13:53, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 11 Oct 2023 at 16:17, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Wed, Oct 11, 2023 at 11:26:54AM +0200, Ulf Hansson wrote:
> >
> > [..]
> >
> > > Not sure exactly what you are referring to when saying that "automatic
> > > power domain on is broken". Genpd power-on the PM domain for a device
> > > that gets attached to it, if the device has only a single PM domain.
> > > This is the legacy behaviour.
> > >
> > > When we added support for multiple PM domains per device, we decided
> > > to *not* power-on the PM domain, if the device that gets attached has
> > > multiple PM domains. This behaviour was chosen deliberately, to allow
> > > consumer drivers to decide themselves instead. Is there a problem with
> > > this you think?
> > >
> >
> > Just my understanding. Since the second PM domain added now is for perf
> > and is not strictly power domain, Peng's concern is switching to this
> > binding will make the platform loose this automatic genpd power-on
> > feature.
>
> Yes, correct, as they way things are today.
>
> It all boils down to that attaching a device to multiple PM domains
> can't really be done in a generic way, as it becomes device/platform
> specific. Since this needs to be managed by the drivers/buses anyway,
> they might as well get control of what PM domain they need to power-on
> to probe their devices.

Due to the above, it might be a good idea to power-on the SCMI
*power-domains* during boot and leave them on to allow drivers to
continue to probe their devices?

Maybe a module parameter or Kconfig debug option could be used to control this?

In this way an updated DTS with that adds a performance domain to a
consumer device node (which already has a power-domain), should allow
the consumer driver to continue to probe successfully.

Peng, would this resolve your concern?

Kind regards
Uffe
