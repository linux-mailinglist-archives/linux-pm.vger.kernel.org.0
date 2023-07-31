Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9775B76964D
	for <lists+linux-pm@lfdr.de>; Mon, 31 Jul 2023 14:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjGaM2r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Jul 2023 08:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjGaM2q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Jul 2023 08:28:46 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD871702
        for <linux-pm@vger.kernel.org>; Mon, 31 Jul 2023 05:28:25 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-4036bd4fff1so512401cf.0
        for <linux-pm@vger.kernel.org>; Mon, 31 Jul 2023 05:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690806504; x=1691411304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9a83S9oH1wWkZWlJljW3yz8wgS9T0t+wUYJiP5RdQk=;
        b=a7M3gasbhuWnQTXbzIaxlEqYJuQpn3r0R7kER1uUS1A6Z7x7eylNWlFLCIGTqetw4c
         z6NWWOnS/3ecbIthBTsXqCa4mvkWdI9HiTBfuf2ccTgvQw2biVcXteOFr/9pMa2nDCKM
         nP9JWXOmDp5gIbpfM/s+uj1X+dro7eGVLlDulch4ejG3OjWUzqtT3ZdsX6lUqpkYOLTV
         HqBhCT3I+IcPDzMGA/P0GSyEqv63rxu6N71/ag7aL4kJsTZdpxVdmSjyQ6VAhOQdHM9N
         pytpIfbSrO0Xcty0bElVipiCCoXFz26tR0Wfl+enYUmPzSv0bIRaHQRYHTJH1udJP143
         aKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690806504; x=1691411304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9a83S9oH1wWkZWlJljW3yz8wgS9T0t+wUYJiP5RdQk=;
        b=Buz803YosiZ3lbvw6rtF1LGdZdU8ElrFGkTeQll4HJvGFWBDwMUHjK4lla+E4uf0+o
         ioL2Frl7hOh50UTt6n3tg4qx5roVtsmGthFPeIvsDAeWdIRlh3qAZzffeBoLV/ZYwwrF
         W/O7OtKET6aYRpQVSLUuwrtALq381MoQGwJZWbsEqhrNjyJEtak9/5++aXgChR9izLI0
         Eh5EeOo+3FNl3GnbxdKMEnpMbxDczOB01GsXg19H5aG006w5Mwr8DNUGfkT5Lgjcxlqq
         YczGGdS+9tVD5ccQ1/dkXb8nP12ase34hdYFRtJ7nsEW2FGO63OX7YMRWuiF98N8cTQN
         BovQ==
X-Gm-Message-State: ABy/qLYIwKLcmEx7FJ8zntZ9fLIHI4T2kYL9t33ZvMm0anKwEjykGzOg
        bZpRh+SJydvS7+u/iLpdKh2eCdxP8rUpMNqRyHJgrw==
X-Google-Smtp-Source: APBJJlF6O13cnUgrS/MfMzP3wGnw90WTHWu3I3rN8grauxbF6V5Mjn+3mDGh1ukWK0amQn6ULRXQWCxUhDjyGEegAiM=
X-Received: by 2002:a05:622a:58f:b0:403:ff6b:69b9 with SMTP id
 c15-20020a05622a058f00b00403ff6b69b9mr274351qtb.13.1690806504019; Mon, 31 Jul
 2023 05:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <ZKYvpgs6p3S7nglh@google.com> <CAPDyKFpWybtCWt9pVcFMKcV0zBrjCzhhmAzYN-JPw2ZS6mUpwQ@mail.gmail.com>
 <20230707164149.GP6001@thinkpad> <ZKxHHvBKvJeWiioc@google.com> <CAPDyKFq6R8ar9nj+3OUX4HDNs0q+a+XcLdvNCX5GG_n0pW7cng@mail.gmail.com>
In-Reply-To: <CAPDyKFq6R8ar9nj+3OUX4HDNs0q+a+XcLdvNCX5GG_n0pW7cng@mail.gmail.com>
From:   Michael Shavit <mshavit@google.com>
Date:   Mon, 31 Jul 2023 20:27:48 +0800
Message-ID: <CAKHBV254i3fdQ7UX0Pc+CDaKO_OROA276vmgDPx4aPtZTiS2Bw@mail.gmail.com>
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
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 6, 2023 at 11:06=E2=80=AFAM Ajay Agarwal <ajayagarwal@google.co=
m> wrote:
>
> Hello Linux PM experts
> I have a question on PM domain. As per the current PM domain driver desig=
n, the genpd_finish_suspend turns OFF a power domain if it is not already t=
urned OFF by runtime suspend.

I don't really understand why genPD does this in the first place. Not
only does it power off domains that might have RPM_ACTIVE devices
during suspend, it also powers on domains that might not have any
active devices in them during resume (except for wakeup devices,
similar to power-off. See genpd_finish_resume).

Why isn't genPD powering-off/on domains based on device's RPM status
sufficient? Assuming those are correctly set by device drivers during
system suspend/resume.

Such that this:
> But this flag is really intended to be used for devices which are capable=
 of waking up the system from PM suspend. But my usecase does not involve a=
 scenario of the device potentially waking up the system, it just needs to =
stay powered for the co-processor to be able to use it.

becomes just a matter of the device keeping its RPM status as active
during system suspend.
