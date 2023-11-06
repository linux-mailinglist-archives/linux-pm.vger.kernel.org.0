Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B8B7E1970
	for <lists+linux-pm@lfdr.de>; Mon,  6 Nov 2023 05:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjKFEvA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Nov 2023 23:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFEvA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Nov 2023 23:51:00 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDE7DB
        for <linux-pm@vger.kernel.org>; Sun,  5 Nov 2023 20:50:56 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-41ea9c5e83cso226311cf.0
        for <linux-pm@vger.kernel.org>; Sun, 05 Nov 2023 20:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699246256; x=1699851056; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PXxTC9ZsDZG2+v97NyMOilWvrDQzRLvJkG/LL1gGczI=;
        b=QBZJa4SmrI3o8Hc4kZlp+ms45EZr9MTXMKXeDxQ89XYFtlprs8mfpEZUPyoc67zeOi
         1IpFqxD2CDYhsBntsi2kfComgTWNtDVT6WARaiHVaHFmC2d+rl3iwU9Ai3aun7dsH/ap
         /HFR+22PbGAD8hlrl2M7gNP2Pp9RmvTpSZdoWljVDTYFYEpv28G+s6axBkFnZGbu+cjV
         fYu7cD9nAnjbAnNQNu+Kb7Dx7glpG9tPXbej4fZMqavMjAv3I93WBtjCmUobEAua37vc
         /pi0psiHoStP3joUrVbxa+mtUwFDZO7EYAwL7qVdfSbMoBRccoXlresNu727fVpsHbV0
         S51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699246256; x=1699851056;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PXxTC9ZsDZG2+v97NyMOilWvrDQzRLvJkG/LL1gGczI=;
        b=eduIp3znx2JgFaAZSMT5g49RQtqiMt+NwdNYJaOtynPIvcNFJ2U3xSC4suealuPvbR
         +YDzOfDzwAQMiuqzccUSK+6X2GMjR1OKALNqxzHD0yP7ZCeMQIUFjmA0b6vMrNmEaGQS
         yS/1+FAmhuuCRrct25moZFQwM6I10AsBlprTCqbL2Q8Rk3cl0ifNSYaw25mIq0MQ6kDg
         v9AcEaIvpw+Zg6DVGSOvZ1nviw7oMJYEmi1zs2E5g7W94OGuifyFgr3l5ueWVCRbqBCc
         C5GrvXgrzfJpJw8T6yV9rHCmoOBaroPEiu/NKqSDa4RBhc91hFYSuBLA4XcRFFjnY/Fk
         3Mqw==
X-Gm-Message-State: AOJu0YyjsrrmKYERYOSVFYFvUumvE73zZRzJ8v91EugasUsIMIQd77wS
        ZAsCPg0LVxcdJZ9zXXrk+a6dV58QcwlF0LaK2yr0pw==
X-Google-Smtp-Source: AGHT+IHtOYvGeyoF3LVNxd3b6K5DxRnxfvP/j5JOwXP72SaGNQMyRLXnbAugKTJua8rVYxVjtJf9nZvX9Tm3jQTft00=
X-Received: by 2002:a05:622a:649:b0:41c:e345:1da2 with SMTP id
 a9-20020a05622a064900b0041ce3451da2mr390114qtb.11.1699246255785; Sun, 05 Nov
 2023 20:50:55 -0800 (PST)
MIME-Version: 1.0
From:   Michael Shavit <mshavit@google.com>
Date:   Mon, 6 Nov 2023 12:50:19 +0800
Message-ID: <CAKHBV251ALNTBUHYG_EJzSkToj2LuR8nChTKjJvUaTNXjRYnEA@mail.gmail.com>
Subject: Using Genpd notifiers vs RPM callbacks for driver re-configuration
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        linux-pm@vger.kernel.org
Cc:     Quang Hoang <quangh@google.com>,
        Koudai Iwahori <koudai@google.com>,
        Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all

Reaching out to get some design advice on drivers that we'll
eventually be upstreaming. I'd like to get clarification on whether
using dev_pm_genpd_add_notifier is appropriate and acceptable from the
upstream community for our use-case.

Given a supplier driver (as defined by devlinks documentation) whose
hardware needs to be reconfigured when its power is flipped from off
to on, what's the best way to reconfigure it:

Option 1: In the driver's runtime_resume hook:
In this case, we reconfigure the component only when it's going to be
used. Assuming that devlinks with the DL_FLAG_PM_RUNTIME are created
between the supplier and all of its consumers, then the supplier
driver's runtime_resume hook will be called whenever at least one of
its consumers becomes active.

AFAICT this is the intended way to do such things, but there's a few
unpleasant caveats:
Cons:
1. Such devlinks can automatically be created by fw_devlinks, but
requires that the fw_devlink=rpm boot parameter is set. This can be a
 fragile due to various timeouts that can remove devlinks or downgrade the
DL_FLAG_PM_RUNTIME flag from the devlink when modules aren't all
immediately loaded during boot (depending on the Kernel's configuration).
2. If the consumer device is attached to multiple power-domains, then
it must manually create devlinks for the virtual devices created by
genpd_dev_pm_attach_by_id (which it should arguably be doing
anyways).
3. It may be reconfigured unnecessarily, if the power-domain wasn't
cycled off/on between the driver's runtime_suspend resume calls. This can
happen if a consumer depends on a supplier that lives in a different
power domain.

Option 2: By registering a dev_pm_genpd_add_notifier notifier:
Pros: It's easier to reason about. The component is always
reconfigured whenever its power-domain is flipped back on and thus
always in a functional state.
Cons: It's not clear if this is an intended use-case for the
dev_pm_genpd_add_notifier callback. It may also be reconfigured when
it's not used, if the power-domain
was powered-on for a use-case that doesn't make use of this component.
