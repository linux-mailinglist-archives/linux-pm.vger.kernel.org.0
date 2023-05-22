Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF6E70C410
	for <lists+linux-pm@lfdr.de>; Mon, 22 May 2023 19:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjEVRMx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 May 2023 13:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjEVRMw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 May 2023 13:12:52 -0400
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E301B3
        for <linux-pm@vger.kernel.org>; Mon, 22 May 2023 10:12:52 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-504d149839bso675638a12.1
        for <linux-pm@vger.kernel.org>; Mon, 22 May 2023 10:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684775570; x=1687367570;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iJ8shFRLQxgVxyay7H7lw+jqurdFnL+yY/g0KRPDCv4=;
        b=bSd9T2fbXfQrRYJ28ZMkQotWCYOa4cI+4/uC/oF9JdbDFkrzfRU/MD9wyQqK19nULj
         49T4JWlQhPUqThtPXITQvOoYrjJTrIGSVx11BuwVGGFKJmglIupwwiggB4NkXGAN+xxe
         UO5u087sDlCnILapln+8zA06xhAWwYUi4EExyIwRP/ngujPga4CJKrxxdsfWrI13CaY8
         9DpmcShRvG1Zx245rtF32RY9uI1MbvP0PZYLgKTV+mQlw/h5u6KTkRxGudADLNoyEQ79
         iXxlVwFkEuzyLcj06B2SrST3+QeMEoOdE4/M2gPnda7Ziw+qDrH+NneG9neKHC3KBCdc
         z9uA==
X-Gm-Message-State: AC+VfDxzykMPceVHmyYdU+c/maWOhiTzJTvT2AIVvfupESSPEVCDo0c8
        +foEOjHqtH9qqnXmrsj/GA77yB+vfv/gBtETjfwZh1nNCQo=
X-Google-Smtp-Source: ACHHUZ6MxBD1JqlZ/NtcbJrPcqgLwsxkiWP9jWTzVy+Un1lkPsQWB2iQPaCGtHx7hPliidA/U4ucgCHM1olf0vWASf4=
X-Received: by 2002:a17:906:74dd:b0:929:b101:937d with SMTP id
 z29-20020a17090674dd00b00929b101937dmr10359168ejl.1.1684775570321; Mon, 22
 May 2023 10:12:50 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 22 May 2023 19:12:39 +0200
Message-ID: <CAJZ5v0juUuy2xKZHMXAKSRtfQxMyL6z12AFdU8_ZbdFRKKrR=Q@mail.gmail.com>
Subject: [CfP] Power Management and Thermal Control MC (LPC2023)
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Folks,

I'm going to submit a Power Management and Thermal Control
micro-conference proposal for LPC2023 along the lines of what happened
in the previous iterations of it.

If you have topics that you'd like to be discussed there, please let
me know by Friday, May 26.

Please note that LPC MC topics are expected to cover work in progress
or at the concept stage.  They are not supposed to be about work that
has been done already.

Kind regards,
Rafael
