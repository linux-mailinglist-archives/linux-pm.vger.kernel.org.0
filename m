Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88ECF752524
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jul 2023 16:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjGMObM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Jul 2023 10:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjGMObL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jul 2023 10:31:11 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20901734
        for <linux-pm@vger.kernel.org>; Thu, 13 Jul 2023 07:31:06 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-bd0a359ca35so699416276.3
        for <linux-pm@vger.kernel.org>; Thu, 13 Jul 2023 07:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689258666; x=1691850666;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IqT7j+KylEfniBAFnK0k7TjREUIr3lCs3f+6vbJeVWI=;
        b=xqF2IBGYpKcrwAL+JlN4YC6UPfJ3FPQxwjo5NmcBnQm8ssc/NrT8Owuiu9C6YuLvL1
         ZY9r8qa/V29MsQ+sY5nVUGYeqS+VuaVTaykLmRH9KShjNQ8BlUYIL2XivDqHOGh3jgfj
         qs1Zvi44vtPtaipfjnm2zs7W4OglrokXVk7RCV0zPwVYTGnOSUCMo/CEI8UaB9rSwnz3
         2xpP+59oDhiILqoEDd/K73Bp/JQIMm/Nt2VJ6chbDyP+FFYWln/tBkSxl2YePWpBu1i/
         9tUekg0/RPg3ZipcwMiDqfSifgVxPEKpy9EkQKWuP7P5DyMNckB0lqwHMXUYvjpGyorj
         zRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689258666; x=1691850666;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IqT7j+KylEfniBAFnK0k7TjREUIr3lCs3f+6vbJeVWI=;
        b=Un3PUyadPYCZck1Vyl8UCm8tkhB0lWC7KG0RazNcTJJ9GLHFC6NfQBTqpTdGf8wMaA
         RiiUcdjsuYlmw+E2I/SRSmJbALeLjsxVITxzF/v9xMg3VuHZFRhgOaLpjK0OAdDlJzD+
         YRQ3zTF8qREGK1Vj+I4rNSzGSwMuKOc0jEI12WCC+Ydb7pXTWJX97XiuEY52TLpKMPBS
         06WlsG50p701C2cNGl4jXsbQ/pF653lRl/EmQD1rsNhYXoa3xyjfMc/7PCnuMq74lYPh
         oAB0Z3oN7W51SnR88f9KtjypYKSTwTaMfkJTPhPcULcgUE561Yw1CcqPAnvQVJ5tS/3u
         7AWw==
X-Gm-Message-State: ABy/qLY+2Dn3pLAngG8HbcHWmdYzriHC1QtqLQguy3qLSFxX8Yc8Zl7E
        6jmXc2kXXlJgLTCK9iaBr+I1WNdW4srFsVEeJCbM2w==
X-Google-Smtp-Source: APBJJlEgreHf+ypPT93RVs5v/8Yq/Qt/i/Z+isLoK8CQnGNsuBlgYd2TRxWwdOpZw9dOG1FMBFKI2AKL2+beg0MK2wU=
X-Received: by 2002:a25:8c8b:0:b0:c75:41f3:1d23 with SMTP id
 m11-20020a258c8b000000b00c7541f31d23mr1211618ybl.10.1689258665873; Thu, 13
 Jul 2023 07:31:05 -0700 (PDT)
MIME-Version: 1.0
References: <ZKYvpgs6p3S7nglh@google.com> <CAPDyKFpWybtCWt9pVcFMKcV0zBrjCzhhmAzYN-JPw2ZS6mUpwQ@mail.gmail.com>
 <20230707164149.GP6001@thinkpad> <ZKxHHvBKvJeWiioc@google.com>
In-Reply-To: <ZKxHHvBKvJeWiioc@google.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 13 Jul 2023 16:30:29 +0200
Message-ID: <CAPDyKFq6R8ar9nj+3OUX4HDNs0q+a+XcLdvNCX5GG_n0pW7cng@mail.gmail.com>
Subject: Re: Prevent PM suspend from powering off the domain for non-wakeup
 in-use devices
To:     Ajay Agarwal <ajayagarwal@google.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
        manugautam@google.com, mshavit@google.com, quangh@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 10 Jul 2023 at 20:00, Ajay Agarwal <ajayagarwal@google.com> wrote:
>
> Thanks Ulf and Mani for looking into this. I could not quite understand
> your suggestions here. I believe you are talking about adding a new
> helper API. What flag will this API update? Will it be
> `dev->power.wakeup_path` itself? Or do we introduce a new boolean flag
> in dev_pm_info structure for this?

Honestly I am not exactly sure on what I think. Someone (possibly
myself) needs to draft a patch to see what it looks like. Although,
adding a new flag that would behave exactly like
'dev->power.wakeup_path' seems a bit silly to me.

>
> Also, how about the genpd flag? Shall we re-use the
> GENPD_FLAG_ACTIVE_WAKEUP flag? Or create a new one?
>
> I feel that we should come up with a generic name for both the genpd
> flag and the power flag to satisfy both the wakeup usecase and the
> stay-on usecase. Let me know what you think.

I agree that the naming isn't particularly good for this use case. I
don't have a good suggestion for how to deal with it. If these things
aren't being used too much out in the kernel, maybe a tree wide commit
(at some good point) to rename things could work?

>
> Rafael, can you chime in as well?

Kind regards
Uffe
