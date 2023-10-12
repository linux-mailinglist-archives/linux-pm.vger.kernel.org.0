Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4A67C6D78
	for <lists+linux-pm@lfdr.de>; Thu, 12 Oct 2023 13:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347343AbjJLL4w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Oct 2023 07:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379432AbjJLL4U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Oct 2023 07:56:20 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C461B468C
        for <linux-pm@vger.kernel.org>; Thu, 12 Oct 2023 04:54:05 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d9a3d737d66so883649276.2
        for <linux-pm@vger.kernel.org>; Thu, 12 Oct 2023 04:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697111645; x=1697716445; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rI9jOcZNOUVPms7Am/q9mCrEi4XfWq/IIizlQ8lLagU=;
        b=bQE7RSElMDJiXqaegyjl7VN7mCZtwourhf3XCheYa3JEZ4UBb9JJnOc5eCOxpU51QY
         zU+/VZ7iuiOekOeTtgT+I8IL5L4qNzNTI5uivSQIQkIjg1dOPEPfZyN+HV0Jidz6+CnB
         zWCiH/n4utLUv1+TSR6nE7epnJ56tQeSQ3vXKxxHuuYD6pGeCzixF4jLGagIfqCgM2UQ
         wFMbMYcjY8oiT726ZFp2du1lRM7qNuThrljXl91iH0iDD7C/ec17bNkLH35GgpVhrkWY
         Q04D2S4Cc4KnBNyJ8NKfH4rNOCVaBUKFNKRTkgt1NfHwMhsv8I65xRv21Q+W96IM4kM9
         qSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697111645; x=1697716445;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rI9jOcZNOUVPms7Am/q9mCrEi4XfWq/IIizlQ8lLagU=;
        b=reX3SVL0kj/6dYN5J8muUQOmobGXYN1r6lCpr23QQ86QmGpYv2jIzpJl1EKHIOgvQa
         RcOx9HEUEVAqscABwicyLPZQ0pPNsSJGyTcl9yQLAlpbwQ8c81up0z5NEnZCC8eeqdL0
         zjoiGK3Yt6t0j27bUyPKeuaa84YpIb2OAwpkN7QQE9uiBujTaWa1ranXBCPqThPL5SNZ
         cES1GjiXq7TN1jBmTI2a2LB8DJqDNrfz5JC/X5QAfhynuqCKCTm6nmpYZ6zS5bnhI9mZ
         7KYhY24hhtHKiVML2+QV44ZEm21rLziYaH+cRvWfkIGQxmF4zTyG2kKQUlS7neINAFNF
         it9g==
X-Gm-Message-State: AOJu0YyqqYaqYtorXOJmRxjsXEWjS4Yx5zK+Sh1wdChmixvJZKtTV5cV
        jYrr1RXTD7n9tezf86eurWii64mKVhG06OT3co/fqy09FgemvAc1
X-Google-Smtp-Source: AGHT+IGJL/KAXLKRTGm0cigdcdd4Z8397vzZIhwwaxHbHeH/oxjfGNMq7q/CyEYTLm7inmV/WYmyzg+knv9ij4NPFCg=
X-Received: by 2002:a5b:342:0:b0:d88:a049:e901 with SMTP id
 q2-20020a5b0342000000b00d88a049e901mr22110521ybp.7.1697111644872; Thu, 12 Oct
 2023 04:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <20231010105503.jwrmjahuvcjgwtk5@bogus> <CAPDyKFqEpnKeF7Yuvv_a+=Kqs=pNU_kM59EqWdpCniHrY_373A@mail.gmail.com>
 <DU0PR04MB941755466872E84217378F6388CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010130054.ieylxocuapugajif@bogus> <DU0PR04MB94177FFEAA62AC27839D826F88CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010133059.57rs52qedrc5mxfr@bogus> <DU0PR04MB9417D01218CA4803D00545A788CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010145137.fyxjlsj5qq3elq7l@bogus> <DU0PR04MB9417233F914A061FB0A23B3088CCA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <CAPDyKFo32GQdgMWJ_rkb88mcdc+0jYubWiCapf99Zg9JTnNnPw@mail.gmail.com> <20231011141551.exqxkmt3xsl5fyjh@bogus>
In-Reply-To: <20231011141551.exqxkmt3xsl5fyjh@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 12 Oct 2023 13:53:29 +0200
Message-ID: <CAPDyKFrWjAdujOr8JX5_JawaKqs0_MYUrsUN57XaB9q=darJ0w@mail.gmail.com>
Subject: Re: Question regarding scmi_perf_domain.c
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Peng Fan <peng.fan@nxp.com>,
        "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
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

On Wed, 11 Oct 2023 at 16:17, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Oct 11, 2023 at 11:26:54AM +0200, Ulf Hansson wrote:
>
> [..]
>
> > Not sure exactly what you are referring to when saying that "automatic
> > power domain on is broken". Genpd power-on the PM domain for a device
> > that gets attached to it, if the device has only a single PM domain.
> > This is the legacy behaviour.
> >
> > When we added support for multiple PM domains per device, we decided
> > to *not* power-on the PM domain, if the device that gets attached has
> > multiple PM domains. This behaviour was chosen deliberately, to allow
> > consumer drivers to decide themselves instead. Is there a problem with
> > this you think?
> >
>
> Just my understanding. Since the second PM domain added now is for perf
> and is not strictly power domain, Peng's concern is switching to this
> binding will make the platform loose this automatic genpd power-on
> feature.

Yes, correct, as they way things are today.

It all boils down to that attaching a device to multiple PM domains
can't really be done in a generic way, as it becomes device/platform
specific. Since this needs to be managed by the drivers/buses anyway,
they might as well get control of what PM domain they need to power-on
to probe their devices.

Kind regards
Uffe
