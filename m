Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B6F777FD3
	for <lists+linux-pm@lfdr.de>; Thu, 10 Aug 2023 20:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235695AbjHJSBU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Aug 2023 14:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbjHJSBP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Aug 2023 14:01:15 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FBB2D63
        for <linux-pm@vger.kernel.org>; Thu, 10 Aug 2023 11:00:57 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-4036bd4fff1so44031cf.0
        for <linux-pm@vger.kernel.org>; Thu, 10 Aug 2023 11:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691690456; x=1692295256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+XQb0ok4JfbeFoXtLOamlNV1oWwR+eOvtUWHulJjBU=;
        b=xSBVP+LflA+s1JQlxgRH+fXY/1OKhHfF1l9ZxeHNOdal9xIRA3Pcfa4b4TaiMvhZht
         bqlDVFMsOYhKgzuLIGRoh7OUR440wdBr9nGJkNEo+sF4NtqqcXPgXHPOYSNdRfLBp8HX
         H9Yl3Wa9rPvuaYHBkhBA/RDG+335HyTZOdwHNcSLdujXNixtVDe3dwrvcwDE/cQ7Qzr9
         3MR6HlhIvkluYObHnE7GBdjqNGAg9VrRbx/CNBNrzC/jCR0w/z9Zimce6kvfXh976Xjv
         YnpfF3rNfzLd7roaArWu1Jw4+GYz+0rMsC34xKzx7QkuJJOJuoMXt0MPQ98hgrKS7+BL
         zDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691690456; x=1692295256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r+XQb0ok4JfbeFoXtLOamlNV1oWwR+eOvtUWHulJjBU=;
        b=ly70FML7qgLDL/5CCPJeGouHyHV0vDbCt5pZA1bPSU7aKhH0qslHNfgd29pLHE4Chq
         1phK513YC+A2XfmF0HOqgS+gJBw7G/xWOh0DZNls8m1ucYNL70bqOB8qEnRTFP8cbIDp
         6txDNO0EUwtJAM++F+34FyGDjfvHkxC/pV5+RMcFcIIQuXg/LMjXxc8l9VG63bIUw5vO
         5RdHRzRrzMxBtXL1jAtiwz13ogMBGysq0b6rwWpG1SUDJZbcXIt5XVHtFLwEQPbnmRnM
         5tpuSEsM3fhydTRoVS6WCxxKyuTkZ++toCB3UlVCJHmQG0FCclO56l4Z2Bjxq4c23xns
         NH7A==
X-Gm-Message-State: AOJu0YwGc1HrkjOl/K8roZ/SMT48Eemts3BIhgJ/ukutglDqhGdcGlqe
        41oELA7CuOcWbJuZAW9yCVlxoX3Xb0d3qGZ3iQtuXQ==
X-Google-Smtp-Source: AGHT+IEMSpRNIrpW6m93Airbi3mNdWQVlDZtzRC47gplAPeYjm4Ll636x/jqdNjho4jQnAcKGmV470/ijKpQA+AB7II=
X-Received: by 2002:a05:622a:14c9:b0:3de:1aaa:42f5 with SMTP id
 u9-20020a05622a14c900b003de1aaa42f5mr22411qtx.15.1691690455981; Thu, 10 Aug
 2023 11:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <ZKYvpgs6p3S7nglh@google.com> <CAPDyKFpWybtCWt9pVcFMKcV0zBrjCzhhmAzYN-JPw2ZS6mUpwQ@mail.gmail.com>
 <20230707164149.GP6001@thinkpad> <ZKxHHvBKvJeWiioc@google.com>
 <CAPDyKFq6R8ar9nj+3OUX4HDNs0q+a+XcLdvNCX5GG_n0pW7cng@mail.gmail.com>
 <CAKHBV254i3fdQ7UX0Pc+CDaKO_OROA276vmgDPx4aPtZTiS2Bw@mail.gmail.com> <CAPDyKFq6gVbQ7cGggmqgPGwNd9=5jdm=zN6zfT5VPeSrqkYR4w@mail.gmail.com>
In-Reply-To: <CAPDyKFq6gVbQ7cGggmqgPGwNd9=5jdm=zN6zfT5VPeSrqkYR4w@mail.gmail.com>
From:   Michael Shavit <mshavit@google.com>
Date:   Fri, 11 Aug 2023 02:00:19 +0800
Message-ID: <CAKHBV24Exdi38rLH3_LQcFOV1kR39gw3X7DwKOC3tdtp2EzXtA@mail.gmail.com>
Subject: Re: Prevent PM suspend from powering off the domain for non-wakeup
 in-use devices
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Ajay Agarwal <ajayagarwal@google.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
        manugautam@google.com, quangh@google.com,
        Koudai Iwahori <koudai@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 10, 2023 at 11:57=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
> I think you kind of already answered this by yourself. We can't rely
> on all drivers to update the runtime PM status of their devices during
> system wide suspend - simply because there are no requirements (legacy
> wise) that they need to.
[...]
> Moreover, as runtime PM gets disabled/enabled for all devices by the
> PM core in the suspend_late/resume_early phase (for good reasons) - we
> have a window when runtime PM can't be used to power-on/off devices.
> In other words, if a driver needs to power on its device (and the
> corresponding PM domain) during this window, how will that be done?

Ok makes sense. If we're to rename dev->power.wakeup_path, could we
then think of it as a way for device drivers to declare that their RPM
state is in fact managed during system suspend/resume?

Another question that I haven't been able to figure out by tracing
through the code history, is why the genpd domain *also* needs to
declare the GENPD_FLAG_ACTIVE_WAKEUP flag. Shouldn't device drivers
setting device_set_wakeup_path() be sufficient for the core to decide
not to force power it off during suspend? In what scenarios would a
genpd provider want to leave that flag unset?
