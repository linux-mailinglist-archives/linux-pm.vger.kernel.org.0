Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E526E65DC
	for <lists+linux-pm@lfdr.de>; Tue, 18 Apr 2023 15:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjDRN2R convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 18 Apr 2023 09:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbjDRN2K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Apr 2023 09:28:10 -0400
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B15146E3
        for <linux-pm@vger.kernel.org>; Tue, 18 Apr 2023 06:28:08 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-94a34c299d8so124655066b.1
        for <linux-pm@vger.kernel.org>; Tue, 18 Apr 2023 06:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681824487; x=1684416487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2gXhqtgQDBSs5ML4Wysn8c6dM/l6h54+I5KeJwOo9Yw=;
        b=IvwGaSXJ1LSft5YGrtQwQaC/hMLzItcOLfbWdlj1rQylsmGPLPzAMdzAcF+5FXtYG7
         yaBQNV1sHAF1yMDsN7JJ/ovuJHxT0vRgMdIyIo6drV7sil8736w5OM9KNO1p0ep+afeG
         lkqu5yZjiXdapeVuT7LHiyiPv/vK2jr2HGhMpZKK7HWX1vVq16sUocQB0yZ2hL1Ogk5e
         hssULPhL7ytxVKsghLnkShJ3V/u4H5TgDI8Bqi5ymZS0g1JAIRPdiuR9aq1a+p1+rryS
         pdtfRPJDNUmDYaxuBiJkhLnXPxsbnfEHWAXO5SR9uXKtbtxLzMTAWX7Sw/mlVAwF3Mb+
         FoiA==
X-Gm-Message-State: AAQBX9fwoIiIpaoS2xVPbrsqOCneZeyya+vzgUQcP5RRsT3w4oOQpkYl
        MmadWr+wBWFqY8clxmPx5td9jYV0xtdOQStW5UI=
X-Google-Smtp-Source: AKy350bfzMJcjGZZbvdEGngJmkl9MMUCf6JYq+jSDjtq0fK1Uzhbl37BM2NjqcfeqcSuCHVgAhv+Rj87JTgKvIIDfZo=
X-Received: by 2002:a17:906:86:b0:94f:4ec3:f0e7 with SMTP id
 6-20020a170906008600b0094f4ec3f0e7mr7844744ejc.2.1681824486716; Tue, 18 Apr
 2023 06:28:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230418091957.5e7sopmiaoa4fw2r@vireshk-i7>
In-Reply-To: <20230418091957.5e7sopmiaoa4fw2r@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 18 Apr 2023 15:27:55 +0200
Message-ID: <CAJZ5v0jSf56NLE6xTzTQ=UQouo0vUGQ-UuSreDWPUEOwWNh8DQ@mail.gmail.com>
Subject: Re: [GIT PULL] OPP updates for 6.4
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 18, 2023 at 11:20 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:
>
>   Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-updates-6.4
>
> for you to fetch changes up to 528f2d8d540a3c374d6b765c769620d91536b176:
>
>   OPP: Move required opps configuration to specialized callback (2023-04-03 09:45:09 +0530)
>
> ----------------------------------------------------------------
> OPP updates for 6.4
>
> - Use of_property_present() for testing DT property presence (Rob
>   Herring).
>
> - Add set_required_opps() callback to the 'struct opp_table', to make
>   the code paths cleaner (Viresh Kumar).
>
> ----------------------------------------------------------------
> Rob Herring (1):
>       opp: Use of_property_present() for testing DT property presence
>
> Viresh Kumar (2):
>       OPP: Handle all genpd cases together in _set_required_opps()
>       OPP: Move required opps configuration to specialized callback
>
>  drivers/opp/core.c | 78 ++++++++++++++++++++++++++++++++++++++++++++----------------------------------
>  drivers/opp/of.c   |  7 +++++--
>  drivers/opp/opp.h  |  4 ++++
>  3 files changed, 53 insertions(+), 36 deletions(-)
>
> --

Pulled, thanks!
