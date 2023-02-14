Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C19696736
	for <lists+linux-pm@lfdr.de>; Tue, 14 Feb 2023 15:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbjBNOoQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Feb 2023 09:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbjBNOoQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Feb 2023 09:44:16 -0500
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4532D2119
        for <linux-pm@vger.kernel.org>; Tue, 14 Feb 2023 06:44:15 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id fi26so17701562edb.7
        for <linux-pm@vger.kernel.org>; Tue, 14 Feb 2023 06:44:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r8DlOof1qKZcOLUpVo4Fr+SwDlEqIiPfD5b+11BU5tE=;
        b=IBwHh78vuII4d0wn1bcc10x+2YgFGy9SUf0yX0TfyI9++eEmRkZYKsVJgXkR+oseS6
         IaALWN6PXs2t6SLOwiIhg8ipuqSyQeZymDl4Nmk+k5aqYaDi1BqnIGjajnXZjxIBSkN5
         ItPwhGNQBVnUqOeiFKaCn7T8d4+GuEsUvFktvdgD5QJ2lbKu20jKmY2kOE0KintklEGV
         MAhCES3GzGMDCHBJ6Llz9BdLiSvVvTuATaMIaLrVRMyEqOmSnzMzZ/tVT7aeTy8NIXhT
         ty8szAbCOzQSGNIzGI6hsSfBHoknS2B4NUx+9A1BGRBELuT8fnhqI6xUt/72w3ODAdbO
         QuAw==
X-Gm-Message-State: AO0yUKVlgXmWevFJraM0nMBW24zc4JNyku4iRcyTKSjG8LU7U3Y3/Jax
        dAADJ57E5YiQMO99NTsZPJyUPET0Dx7gZWszyLI=
X-Google-Smtp-Source: AK7set8iQhw78Gwz4w+L5hxXH9e/6QCPhu67ioGspnWYvg5+OnEhddiUb8SXK74VQUKRLEPiztoRvUD4zA2VvdXSPIs=
X-Received: by 2002:a50:9f07:0:b0:4ac:20b:96b0 with SMTP id
 b7-20020a509f07000000b004ac020b96b0mr1307755edf.3.1676385853665; Tue, 14 Feb
 2023 06:44:13 -0800 (PST)
MIME-Version: 1.0
References: <20230214053838.5tyq375sxbrprque@vireshk-i7>
In-Reply-To: <20230214053838.5tyq375sxbrprque@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 14 Feb 2023 15:44:02 +0100
Message-ID: <CAJZ5v0iEPY1RJiWJg_eTdrcmJsObTkafs92Bo0ZwwJA+bM9+gA@mail.gmail.com>
Subject: Re: [GIT PULL] OPP updates for 6.3
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Feb 14, 2023 at 6:38 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:
>
>   Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-updates-6.3
>
> for you to fetch changes up to eca4c0eea53432ec4b711b2a8ad282cbad231b4f:
>
>   OPP: fix error checking in opp_migrate_dentry() (2023-02-08 10:40:59 +0530)
>
> ----------------------------------------------------------------
> OPP updates for 6.3
>
> - Add missing 'cache-unified' property in example for kryo OPP bindings
>   (Rob Herring).
>
> - Fix error checking in opp_migrate_dentry() (Qi Zheng).
>
> - Remove "select SRCU" (Paul E. McKenney).
>
> - Let qcom,opp-fuse-level be a 2-long array for qcom SoCs (Konrad
>   Dybcio).
>
> ----------------------------------------------------------------
> Konrad Dybcio (1):
>       dt-bindings: opp: v2-qcom-level: Let qcom,opp-fuse-level be a 2-long array
>
> Paul E. McKenney (1):
>       drivers/opp: Remove "select SRCU"
>
> Qi Zheng (1):
>       OPP: fix error checking in opp_migrate_dentry()
>
> Rob Herring (1):
>       dt-bindings: opp: opp-v2-kryo-cpu: Add missing 'cache-unified' property in example
>
>  Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml   | 2 ++
>  Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml | 4 +++-
>  drivers/opp/Kconfig                                          | 1 -
>  drivers/opp/debugfs.c                                        | 2 +-
>  4 files changed, 6 insertions(+), 3 deletions(-)
>
> --

Pulled and pushed into the linux-next branch in linux-pm.git.

Thanks!
