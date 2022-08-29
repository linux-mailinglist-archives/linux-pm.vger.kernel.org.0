Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683605A5273
	for <lists+linux-pm@lfdr.de>; Mon, 29 Aug 2022 19:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiH2RAX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Aug 2022 13:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiH2RAQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Aug 2022 13:00:16 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A4410D4
        for <linux-pm@vger.kernel.org>; Mon, 29 Aug 2022 10:00:11 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id v26so1770905lfd.10
        for <linux-pm@vger.kernel.org>; Mon, 29 Aug 2022 10:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=02A4WbHhB+W2fYfm07iMIj/9+1lNCqkttx9wg+WkwYM=;
        b=bXsGTsbwdgP/vC54WZaHex/xFZJpn7/Z7wIr8upxeRpyU8TcKU+wj3zySEIQ3xJ6EU
         C8LtxyUIrb68Utgo1nRaV7LVGbUn2Fi1mODUc5nOWHkV5ze41b+6lwTARX7cWSEIyjzK
         T98lsCJH9Twwnggd8q0SiexYiE+yq6Tx3Acn02yachTkkx7E5pxS344E7atvTb34TE5G
         D3WFHkacjkjn9wb+gSyAqYYkXoK7weUQjtyb59zlaGWyUf0L/wVbTl1cksx/Mn8G6q//
         1tatGff5orV3ugFh4iSaN+bP1MGeLvmrZO5ZN0SCWRv0AFb0ZweWWTtQCGnrZpeC2B+9
         HwiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=02A4WbHhB+W2fYfm07iMIj/9+1lNCqkttx9wg+WkwYM=;
        b=rKh/Pp/uEMH8/sZFQn0WoyfHep9drqbJcrQeOxgYp+zgvKCe/AxQuoq9W/HhwR5wpC
         r77kHpUzpJ9YbKAnjl/6Hc/CKR3E+GUpunDsi5qyGAzuxnvVC8UOa+KI6WXotrQ8bcO4
         vdCkCKFnwUx5gW6wdF0rBWP/X+bOfrKJufB7i/+O4g+Gfy9mlLbpKQM9+M+k/ogLylVR
         28h84eq30yJRay/T56MuKZxjYEiG978a6lFHEfmTB3uAcqn7htAjDUyqZU9pwr/O2T/k
         QpPsRPZj6IvVSwjf//EJDOIfz/K8ufwHtLqwRXSPBxz/BGdlTNf366SmIqLDEuxy92fs
         FzNA==
X-Gm-Message-State: ACgBeo0Zl+PYhvwVFVbO6nPRlbBJmzcYp/8xh3ZhgsJ7qq4qNUc+VkBB
        f3nTqyRXqVS8+5gS7OyN2eZ+KrBDcfalbkCKPP3sJA==
X-Google-Smtp-Source: AA6agR4NJYxf+fy5Mn9QZkjYnolAuc58qjTeTxjLSQKOdfiIgdgOlEupkZ0bsFUKtc3xN2lTpEZzRgMDVkdg08KFeek=
X-Received: by 2002:a05:6512:b01:b0:48b:a065:2a8b with SMTP id
 w1-20020a0565120b0100b0048ba0652a8bmr6207623lfu.401.1661792409139; Mon, 29
 Aug 2022 10:00:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220828192920.805253-3-lkml@vorpal.se> <202208290605.gE9IGbxE-lkp@intel.com>
In-Reply-To: <202208290605.gE9IGbxE-lkp@intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 29 Aug 2022 09:59:57 -0700
Message-ID: <CAKwvOdmm8c30fky5GjFbLPhrfAEsO7SgehRYip-PAKr-zonEmA@mail.gmail.com>
Subject: Re: [PATCH 2/3] platform/x86: Battery charge mode in toshiba_acpi (sysfs)
To:     kernel test robot <lkp@intel.com>
Cc:     Arvid Norlander <lkml@vorpal.se>,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Azael Avalos <coproscefalo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Aug 28, 2022 at 3:16 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Arvid,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on 1c23f9e627a7b412978b4e852793c5e3c3efc555]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Arvid-Norlander/platform-x86-Battery-charge-mode-in-toshiba_acpi/20220829-033110
> base:   1c23f9e627a7b412978b4e852793c5e3c3efc555
> config: x86_64-randconfig-a014-20220829 (https://download.01.org/0day-ci/archive/20220829/202208290605.gE9IGbxE-lkp@intel.com/config)

Note: this was from a randconfig; it's highly likely you need this
funky config to repro.  ^ should be the link to the config.

-- 
Thanks,
~Nick Desaulniers
